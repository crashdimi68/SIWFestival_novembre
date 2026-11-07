package it.uniroma3.siw.SiwFestival.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.function.Supplier;

import org.hibernate.SessionFactory;
import org.hibernate.stat.Statistics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StopWatch;

import it.uniroma3.siw.SiwFestival.dto.FetchScenarioRisultato;
import it.uniroma3.siw.SiwFestival.model.Film;
import it.uniroma3.siw.SiwFestival.model.Interpretazione;
import it.uniroma3.siw.SiwFestival.repository.FilmRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

/**
 * Analisi sperimentale dell'accesso ai dati (Sezione 8.2 della specifica).
 *
 * Lo stesso caso d'uso — "carica tutti i film con il loro cast (attori e personaggi)" — viene
 * eseguito con tre strategie diverse sullo stesso insieme di dati, misurando per
 * ciascuna il numero di query SQL effettivamente eseguite (statistiche di Hibernate),
 * il tempo totale e il numero di oggetti caricati.
 */
@Service
public class FetchBenchmarkService {

    @Autowired
    private FilmRepository filmRepository;

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional(readOnly = true)
    public List<FetchScenarioRisultato> eseguiConfronto() {
        Statistics statistics = entityManager.getEntityManagerFactory()
                .unwrap(SessionFactory.class)
                .getStatistics();

        List<FetchScenarioRisultato> risultati = new ArrayList<>();

        risultati.add(eseguiScenario(statistics,
                "Default (LAZY)",
                "findAll() e poi, per ogni film, getInterpretazioni() e getAttore().getCognome(): "
                        + "Film.interpretazioni e Interpretazione.attore sono LAZY, quindi ogni accesso "
                        + "scatena una SELECT separata (1 query per l'elenco + 1 per il cast di ogni film "
                        + "+ 1 per ogni attore, il problema N+1).",
                () -> {
                    List<Film> film = filmRepository.findAll();
                    return conta(film);
                }));

        risultati.add(eseguiScenario(statistics,
                "JOIN FETCH esplicito",
                "findAllWithAttori(): JPQL scritta a mano 'SELECT DISTINCT f FROM Film f "
                        + "LEFT JOIN FETCH f.interpretazioni i LEFT JOIN FETCH i.attore', un'unica query. "
                        + "Interpretazioni e attori arrivano insieme al film, gia' inizializzati.",
                () -> {
                    List<Film> film = filmRepository.findAllWithAttori();
                    return conta(film);
                }));

        risultati.add(eseguiScenario(statistics,
                "@EntityGraph",
                "findAllBy() con @EntityGraph(attributePaths = {\"interpretazioni\", \"interpretazioni.attore\"}): "
                        + "stesso risultato del "
                        + "JOIN FETCH, ma dichiarativo, senza scrivere JPQL a mano.",
                () -> {
                    List<Film> film = filmRepository.findAllBy();
                    return conta(film);
                }));

        return risultati;
    }

    /**
     * Tocca il cast di ogni film e l'attore di ogni interpretazione: e' questo accesso
     * che, con le associazioni LAZY non inizializzate, provoca le query aggiuntive.
     */
    private int[] conta(List<Film> film) {
        Set<Long> attori = new HashSet<>();
        for (Film f : film) {
            for (Interpretazione i : f.getInterpretazioni()) {
                i.getAttore().getCognome();
                attori.add(i.getAttore().getId());
            }
        }
        return new int[] { film.size(), attori.size() };
    }

    private FetchScenarioRisultato eseguiScenario(Statistics statistics, String titolo, String descrizione,
            Supplier<int[]> scenario) {
        entityManager.clear();
        statistics.clear();
        StopWatch stopWatch = new StopWatch();
        stopWatch.start();
        int[] conteggi = scenario.get();
        stopWatch.stop();

        long numeroQuery = statistics.getPrepareStatementCount();
        return new FetchScenarioRisultato(titolo, descrizione, numeroQuery, stopWatch.getTotalTimeMillis(),
                conteggi[0], conteggi[1]);
    }
}

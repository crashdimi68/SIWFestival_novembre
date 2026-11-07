package it.uniroma3.siw.SiwFestival.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.SiwFestival.model.Attore;
import it.uniroma3.siw.SiwFestival.model.Film;
import it.uniroma3.siw.SiwFestival.model.Interpretazione;
import it.uniroma3.siw.SiwFestival.repository.AttoreRepository;
import it.uniroma3.siw.SiwFestival.repository.FilmRepository;
import it.uniroma3.siw.SiwFestival.repository.InterpretazioneRepository;

@Service
public class InterpretazioneService {

    @Autowired
    private InterpretazioneRepository interpretazioneRepository;
    @Autowired
    private FilmRepository filmRepository;
    @Autowired
    private AttoreRepository attoreRepository;

    /** Cast di un film, con l'attore di ogni interpretazione gia' caricato. */
    @Transactional(readOnly = true)
    public List<Interpretazione> findByFilmId(Long filmId) {
        return interpretazioneRepository.findByFilmIdOrderByPersonaggioAsc(filmId);
    }

    /**
     * Aggiunge un attore al cast di un film, con il personaggio che interpreta.
     * Coinvolge tre entita' (film, attore, interpretazione) in un'unica transazione.
     * Regola: lo stesso attore compare al massimo una volta nel cast di un film.
     * Il controllo e' qui, nel Service Layer, ed e' rinforzato dal vincolo di
     * unicita' (film_id, attore_id) sulla tabella.
     */
    @Transactional
    public Interpretazione aggiungi(Long filmId, Long attoreId, String personaggio) {
        Film film = filmRepository.findById(filmId)
                .orElseThrow(() -> new RisorsaNonTrovataException("il film", filmId));
        Attore attore = attoreRepository.findById(attoreId)
                .orElseThrow(() -> new RisorsaNonTrovataException("l'attore", attoreId));

        if (interpretazioneRepository.existsByFilmIdAndAttoreId(filmId, attoreId)) {
            throw new InterpretazioneDuplicataException(
                    attore.getNomeCompleto() + " fa gia' parte del cast di \"" + film.getTitolo() + "\".");
        }

        Interpretazione interpretazione = new Interpretazione();
        interpretazione.setFilm(film);
        interpretazione.setAttore(attore);
        interpretazione.setPersonaggio(personaggio);
        return interpretazioneRepository.save(interpretazione);
    }

    @Transactional
    public void elimina(Long interpretazioneId) {
        interpretazioneRepository.deleteById(interpretazioneId);
    }
}

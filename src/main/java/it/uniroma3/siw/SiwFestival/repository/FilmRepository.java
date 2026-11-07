package it.uniroma3.siw.SiwFestival.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import it.uniroma3.siw.SiwFestival.model.Attore;
import it.uniroma3.siw.SiwFestival.model.Film;
import it.uniroma3.siw.SiwFestival.model.GenereFilm;

public interface FilmRepository extends JpaRepository<Film, Long> {

    List<Film> findByTitoloContainingIgnoreCase(String titolo);

    /** Ricerca per titolo con il cast gia' caricato: evita una query per ogni film trovato. */
    @Query("SELECT DISTINCT f FROM Film f LEFT JOIN FETCH f.interpretazioni i LEFT JOIN FETCH i.attore "
            + "WHERE LOWER(f.titolo) LIKE LOWER(CONCAT('%', :titolo, '%'))")
    List<Film> cercaPerTitoloConAttori(@Param("titolo") String titolo);

    List<Film> findByGenere(GenereFilm genere);

    /** Dettaglio film: recensioni caricate insieme al film. */
    @EntityGraph(attributePaths = { "recensioni" })
    Optional<Film> findWithRecensioniById(Long id);

    /**
     * Scenario 2 del confronto sulle strategie di fetch:
     * una sola query, JPQL scritta a mano con JOIN FETCH.
     */
    @Query("SELECT DISTINCT f FROM Film f LEFT JOIN FETCH f.interpretazioni i LEFT JOIN FETCH i.attore")
    List<Film> findAllWithAttori();

    /**
     * Scenario 3 del confronto: stesso effetto del JOIN FETCH ma dichiarativo.
     */
    @EntityGraph(attributePaths = { "interpretazioni", "interpretazioni.attore" })
    List<Film> findAllBy();

    /**
     * Elenco film paginato.
     * Spring Data traduce il Pageable in LIMIT e OFFSET: dal database arrivano
     * soltanto i film della pagina richiesta, non l'intera tabella. Una seconda
     * query conta le righe totali, e serve a sapere quante pagine esistono.
     * Qui non si usa un EntityGraph sulle interpretazioni: il fetch di una collezione
     * impedirebbe la paginazione nel database (Hibernate paginerebbe in memoria).
     */
    Page<Film> findAllBy(Pageable pageable);

    
    /** Film in cui ha recitato un attore (navigando l'entita' Interpretazione). */
    @Query("SELECT f FROM Film f JOIN f.interpretazioni i WHERE i.attore = :attore")
    Page<Film> findByAttore(@Param("attore") Attore attore, Pageable pageable);

}

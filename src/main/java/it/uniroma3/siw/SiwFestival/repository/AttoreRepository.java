package it.uniroma3.siw.SiwFestival.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import it.uniroma3.siw.SiwFestival.model.Attore;

public interface AttoreRepository extends JpaRepository<Attore, Long> {

    List<Attore> findByCognomeIgnoreCase(String cognome);

    /** Dettaglio attore: interpretazioni e relativi film caricati con la stessa query. */
    @EntityGraph(attributePaths = { "interpretazioni", "interpretazioni.film" })
    Optional<Attore> findWithInterpretazioniById(Long id);

    @Query("SELECT DISTINCT a FROM Attore a LEFT JOIN FETCH a.interpretazioni")
    List<Attore> findAllWithInterpretazioni();



}

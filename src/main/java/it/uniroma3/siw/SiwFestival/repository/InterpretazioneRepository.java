package it.uniroma3.siw.SiwFestival.repository;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import it.uniroma3.siw.SiwFestival.model.Interpretazione;

public interface InterpretazioneRepository extends JpaRepository<Interpretazione, Long> {

    /** Cast di un film: l'attore di ogni interpretazione arriva con la stessa query. */
    @EntityGraph(attributePaths = { "attore" })
    List<Interpretazione> findByFilmIdOrderByPersonaggioAsc(Long filmId);

    List<Interpretazione> findByAttoreId(Long attoreId);

    /** Regola di business: lo stesso attore compare al massimo una volta nel cast di un film. */
    boolean existsByFilmIdAndAttoreId(Long filmId, Long attoreId);
}

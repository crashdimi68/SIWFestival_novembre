package it.uniroma3.siw.SiwFestival.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.uniroma3.siw.SiwFestival.model.Attore;
import it.uniroma3.siw.SiwFestival.repository.AttoreRepository;

@Service
public class AttoreService {

    @Autowired
    private AttoreRepository attoreRepository;

    @Transactional(readOnly = true)
    public Optional<Attore> findById(Long id) {
        return attoreRepository.findById(id);
    }

    /** Dettaglio attore: interpretazioni e film caricati con la stessa query (EntityGraph). */
    @Transactional(readOnly = true)
    public Optional<Attore> findByIdWithInterpretazioni(Long id) {
        return attoreRepository.findWithInterpretazioniById(id);
    }

    @Transactional(readOnly = true)
    public List<Attore> findAll() {
        return attoreRepository.findAll();
    }

    @Transactional
    public void save(Attore attore) {
        attoreRepository.save(attore);
    }

    @Transactional
    public void delete(Long id) {
        attoreRepository.deleteById(id);
    }


    public List<Attore> findByCognome(String cognome) {
        return attoreRepository.findByCognomeIgnoreCase(cognome);
    }
}

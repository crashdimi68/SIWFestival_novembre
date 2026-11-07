package it.uniroma3.siw.SiwFestival.service;

/**
 * Sollevata quando si prova ad aggiungere al cast di un film
 * un attore che ne fa gia' parte.
 */
public class InterpretazioneDuplicataException extends RuntimeException {

    public InterpretazioneDuplicataException(String messaggio) {
        super(messaggio);
    }
}

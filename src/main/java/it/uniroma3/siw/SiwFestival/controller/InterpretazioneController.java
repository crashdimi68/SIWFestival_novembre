package it.uniroma3.siw.SiwFestival.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.uniroma3.siw.SiwFestival.service.InterpretazioneDuplicataException;
import it.uniroma3.siw.SiwFestival.service.InterpretazioneService;

/**
 * Gestione del cast di un film (solo amministratore): aggiunta di un attore
 * con il personaggio che interpreta, e rimozione.
 */
@Controller
public class InterpretazioneController {

    @Autowired
    private InterpretazioneService interpretazioneService;

    @PostMapping("/admin/film/{filmId}/interpretazione")
    public String addInterpretazione(@PathVariable Long filmId,
            @RequestParam Long attoreId,
            @RequestParam String personaggio,
            RedirectAttributes redirectAttrs) {
        try {
            interpretazioneService.aggiungi(filmId, attoreId, personaggio);
        } catch (InterpretazioneDuplicataException e) {
            redirectAttrs.addFlashAttribute("erroreCast", e.getMessage());
        }
        return "redirect:/film/" + filmId;
    }

    @PostMapping("/admin/film/{filmId}/interpretazione/{interpretazioneId}/delete")
    public String deleteInterpretazione(@PathVariable Long filmId,
            @PathVariable Long interpretazioneId) {
        interpretazioneService.elimina(interpretazioneId);
        return "redirect:/film/" + filmId;
    }
}

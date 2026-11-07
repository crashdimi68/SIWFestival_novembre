package it.uniroma3.siw.SiwFestival.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import it.uniroma3.siw.SiwFestival.model.Attore;
import it.uniroma3.siw.SiwFestival.service.AttoreService;
import it.uniroma3.siw.SiwFestival.service.RisorsaNonTrovataException;
import jakarta.validation.Valid;

@Controller
public class AttoreController {

    @Autowired
    private AttoreService attoreService;

    @GetMapping("/attori")
    public String list(Model model) {
        model.addAttribute("attori", attoreService.findAll());
        return "listAttori";
    }

    @GetMapping("/attore/{id}")
    public String show(@PathVariable Long id, Model model) {
        Attore attore = attoreService.findByIdWithInterpretazioni(id)
                .orElseThrow(() -> new RisorsaNonTrovataException("l'attore", id));
        model.addAttribute("attore", attore);
        return "showAttore";
    }

    @GetMapping("/admin/attori/new")
    public String createForm(Model model) {
        model.addAttribute("attore", new Attore());
        return "formAttore";
    }

    @PostMapping("/admin/attori")
    public String newAttore(@Valid @ModelAttribute("attore") Attore attore,
            BindingResult bindingResult) {
        if (bindingResult.hasErrors())
            return "formAttore";
        attoreService.save(attore);
        return "redirect:/attori";
    }

    @GetMapping("/admin/attore/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Attore attore = attoreService.findById(id).orElse(null);
        if (attore == null)
            return "redirect:/attori";
        model.addAttribute("attore", attore);
        return "formAttore";
    }

    @PostMapping("/admin/attore/{id}/edit")
    public String editAttore(@PathVariable Long id,
            @Valid @ModelAttribute("attore") Attore attore,
            BindingResult bindingResult) {
        if (bindingResult.hasErrors())
            return "formAttore";
        attore.setId(id);
        attoreService.save(attore);
        return "redirect:/attore/" + id;
    }

    @PostMapping("/admin/attore/{id}/delete")
    public String deleteAttore(@PathVariable Long id) {
        attoreService.delete(id);
        return "redirect:/attori";
    }
}

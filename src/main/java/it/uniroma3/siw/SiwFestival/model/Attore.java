package it.uniroma3.siw.SiwFestival.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;

@Entity
public class Attore {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank
    private String nome;

    @NotBlank
    private String cognome;

    @NotNull
    @Past
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate dataNascita;

    @NotBlank
    private String nazionalita;

    /**
     * Un attore puo' aver recitato in piu' film, e in ogni film interpreta un personaggio.
     * La coppia (film, personaggio) sta nell'entita' Interpretazione.
     * Associazione LAZY: le interpretazioni servono solo nella pagina di dettaglio
     * dell'attore, non ogni volta che si carica un attore.
     * Eliminando un attore si eliminano anche le sue interpretazioni (cascade REMOVE).
     * Niente orphanRemoval: la modifica dell'attore salva l'oggetto del form, che ha la
     * lista vuota, e con orphanRemoval quel salvataggio cancellerebbe le interpretazioni.
     */
    @OneToMany(mappedBy = "attore", cascade = CascadeType.REMOVE, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Interpretazione> interpretazioni = new ArrayList<>();

    public Attore() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public LocalDate getDataNascita() {
        return dataNascita;
    }

    public void setDataNascita(LocalDate dataNascita) {
        this.dataNascita = dataNascita;
    }

    public String getNazionalita() {
        return nazionalita;
    }

    public void setNazionalita(String nazionalita) {
        this.nazionalita = nazionalita;
    }

    public List<Interpretazione> getInterpretazioni() {
        return interpretazioni;
    }

    public void setInterpretazioni(List<Interpretazione> interpretazioni) {
        this.interpretazioni = interpretazioni;
    }

    public String getNomeCompleto() {
        return nome + " " + cognome;
    }

    @Override
    public int hashCode() {
        return Objects.hash(nome, cognome, dataNascita);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Attore other = (Attore) obj;
        return Objects.equals(nome, other.nome)
                && Objects.equals(cognome, other.cognome)
                && Objects.equals(dataNascita, other.dataNascita);
    }
}

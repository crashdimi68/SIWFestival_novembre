package it.uniroma3.siw.SiwFestival.model;

import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import jakarta.validation.constraints.NotBlank;

/**
 * Un attore che recita in un film interpretando un personaggio
 * (ad es. Marlon Brando ne Il Padrino interpreta don Vito Corleone).
 *
 * Film e Attore sono legati da una molti-a-molti che ha un attributo proprio,
 * il personaggio: per questo non basta una @ManyToMany con tabella di join,
 * ma serve un'entita' intermedia con due @ManyToOne.
 * Il vincolo di unicita' (film, attore) impedisce di inserire due volte lo
 * stesso attore nello stesso film; il controllo applicativo sta in InterpretazioneService.
 */
@Entity
@Table(uniqueConstraints = @UniqueConstraint(name = "uk_interpretazione_film_attore",
        columnNames = { "film_id", "attore_id" }))
public class Interpretazione {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank
    private String personaggio;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "film_id")
    private Film film;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "attore_id")
    private Attore attore;

    public Interpretazione() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPersonaggio() {
        return personaggio;
    }

    public void setPersonaggio(String personaggio) {
        this.personaggio = personaggio;
    }

    public Film getFilm() {
        return film;
    }

    public void setFilm(Film film) {
        this.film = film;
    }

    public Attore getAttore() {
        return attore;
    }

    public void setAttore(Attore attore) {
        this.attore = attore;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Interpretazione other = (Interpretazione) obj;
        return Objects.equals(id, other.id);
    }
}

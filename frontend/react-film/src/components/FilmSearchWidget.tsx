import { useEffect, useMemo, useState } from 'react'
import { getFilm } from '../api'
import type { Film } from '../types'

const inputStyle: React.CSSProperties = {
  padding: '0.6rem 1rem',
  background: '#0b0509',
  border: '1px solid #5a2338',
  borderRadius: '6px',
  color: '#ffffff',
  fontFamily: 'inherit',
  fontSize: '0.9rem',
  minWidth: '260px',
  outline: 'none',
}

const filtersRowStyle: React.CSSProperties = {
  display: 'flex',
  gap: '1rem',
  flexWrap: 'wrap',
  marginBottom: '1.5rem',
}
//useState crea una var che react "ricorda" e quando cambia aggiorna la pag
//se usassi delle var normali, ad ogni aggiornamento della pag le variabili verrebbero 
//resettate senza poter fare quindi rcerche dinamiche
// [valore attuae, funzione x cambiarlo]
export default function FilmSearchWidget() {
  const [film, setFilm] = useState<Film[]>([])
  const [loading, setLoading] = useState<boolean>(true)
  const [errore, setErrore] = useState<string | null>(null)
  const [titolo, setTitolo] = useState<string>('')
  const [genereSelezionato, setGenereSelezionato] = useState<string>('')
  const [paeseSelezionato, setPaeseSelezionato] = useState<string>('')

  // La ricerca per titolo viene fatta dal backend (GET /api/movies?titolo=...),
  // con un piccolo debounce per non sparare una richiesta a ogni tasto premuto.
  // la ricerca è dinamica --> pro di usare react con api rest = chiedo al server film
  // ogni volta che cambio il titolo. UseEffect è un hook che qui lo uso per chiamare il server
  useEffect(() => {
    let annullato = false
    const timer = setTimeout(async () => {
      try {
        setLoading(true)
        const dati = await getFilm(titolo) //chiama server e aspetta risposta
        if (!annullato) {
          setFilm(dati) //modifica lo stato dei film con quelli appena presi
          setErrore(null)
        }
      } catch (e) { //se il try non funge
        if (!annullato) setErrore('Impossibile caricare i film.')
      } finally { //viene eseguito sempre nel bene o nel male
        if (!annullato) setLoading(false)
      }
    }, 300) //300 millisecondi 

    return () => {
      annullato = true
      clearTimeout(timer)
    }
  }, [titolo]) //sarebbe l'array di dipendnze, quindi se il titolo cambia rieseguo il blocco
  // se fosse stato [] avrei eseguito il blocco solo una volta, se fosse stato assente invece 
  // avrei eseguito ad ogni render, quindi ad ogni tasto premuto



  //useMemo sempr un hook che memorizza il risultato e lo tiene da parte finche i dati da cui dipende non cambiano
  const generiDisponibili = useMemo(() => {
    //faccio un new SET perchè set ammette solo valori unici 
    const generi = new Set(film.map(f => f.genere).filter(Boolean))//filter boolean scarta null e stringhe vuote
    return Array.from(generi).sort() //converte generi in un array e lo ordina (alfabetico)
  }, [film]) //ricalcola generi disponibili solo se cambia la lista dei film

  const paesiDisponibili = useMemo(() => {
    const paesi = new Set(film.map(f => f.paeseProduzione).filter(Boolean))
    return Array.from(paesi).sort()
  }, [film]) //ricalcola paesi disponibili solo se cambia la lista dei film


  // Il filtro per genere e' invece puramente lato client sui risultati gia' ottenuti
  // è la tabella che mostro davvero
  const filmFiltrati = useMemo(() => {
    return film.filter(f =>
      (!genereSelezionato || f.genere === genereSelezionato) &&
      (!paeseSelezionato || f.paeseProduzione === paeseSelezionato)
    )
  }, [film, genereSelezionato, paeseSelezionato])//riesegui se cambiano i film o il genere seleziionato o il paese selezionato

  // messaggio errore che lancio se nn riesco a caricaree gfilm dal backend
  if (errore) {
    return (
      <p style={{ color: '#f87171', textAlign: 'center', padding: '1rem 0' }}>{errore}</p>
    )
  }

  return (
    //sezione filtri
    <div>
      <div style={filtersRowStyle}>
        <input
          type="text"
          value={titolo}
          onChange={e => setTitolo(e.target.value)}
          placeholder="Cerca per titolo..."
          style={inputStyle}
        />
        <select
          value={genereSelezionato}
          onChange={e => setGenereSelezionato(e.target.value)}
          style={inputStyle}
        >
          <option value="">-- Tutti i generi --</option>
          {generiDisponibili.map(genere => (
            <option key={genere} value={genere}>{genere}</option>
          ))}
        </select>
        <select
          value={paeseSelezionato}
          onChange={e => setPaeseSelezionato(e.target.value)}
          style={inputStyle}
        >
          <option value="">-- Tutti i paesi --</option>
          {paesiDisponibili.map(paese => (
            <option key={paese} value={paese}>{paese}</option>
          ))}
        </select>
      </div>

      {/* {!loading && <p>{filmFiltrati.length} film trovati.</p>} */}

      {loading && (
        <p style={{ color: 'rgba(255,255,255,0.7)', textAlign: 'center', padding: '2rem 0' }}>
          Caricamento...
        </p>
      )}

      {!loading && filmFiltrati.length === 0 && (
        <div className="empty-state">
          <p>Nessun film corrisponde ai criteri di ricerca.</p>
        </div>
      )}

      {!loading && filmFiltrati.length > 0 && (
        <table className="data-table">
          <thead>
            <tr>
              <th>Titolo</th>
              <th>Attori</th>
              <th>Genere</th>
              <th>Paese</th>
              <th style={{ textAlign: 'right' }}>Anno</th>
              <th style={{ textAlign: 'right' }}>Durata</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {filmFiltrati.map(f => (
              <tr key={f.id}>
                <td>{f.titolo}</td>
                <td>{f.attori || '-'}</td>
                <td>{f.genere}</td>
                <td>{f.paeseProduzione}</td>
                <td style={{ textAlign: 'right' }}>{f.anno}</td>
                <td style={{ textAlign: 'right' }}>{f.durata} min</td>
                <td>
                  <a href={`/film/${f.id}`} className="btn-small">Dettagli</a>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  )
}

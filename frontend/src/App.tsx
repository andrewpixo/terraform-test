import './App.css'
import {useEffect, useState} from "react";

interface Pokemon {
  id: number;
  name: string;
  type: string;
  isCool: boolean;
}

function App() {
  const [isLoading, setIsLoading] = useState(true);
  const [pokemon, setPokemon] = useState<Pokemon[]>([]);

  useEffect(() => {
    // @ts-ignore
    fetch(`${process.env.VITE_API_URL}/pokemon`).then(res => res.json()).then(data => {
      setIsLoading(false);
      setPokemon(data);
    })
  }, [])

  return (
    <div className="App">
      {isLoading ?
          <p>Loading...</p>
: <PokemonList pokemon={pokemon} />
      }
    </div>
  )
}

function PokemonList(props: {pokemon: Pokemon[]}) {
  return <>
    <h3>Pokemon Names and Types</h3>
    <ul>
    {props.pokemon.map(p => <li key={p.id}>{p.name} - {p.type} </li>)}
  </ul></>
}

export default App

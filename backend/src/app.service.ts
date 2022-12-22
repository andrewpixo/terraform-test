import { Injectable } from '@nestjs/common';
import { Pokemon } from './db/Pokemon';
import { seedPokemon } from './db/SeedData';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!';
  }

  async getPokemon(): Promise<Pokemon[]> {
    //const repo = new PokemonRepo(AppDataSource);

    return seedPokemon;
  }
}

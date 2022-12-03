import { Injectable } from '@nestjs/common';
import {Pokemon} from "./db/Pokemon";
import PokemonRepo from "./db/PokemonRepo";
import AppDataSource from "./db/AppDataSource";

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!';
  }
  async getPokemon(): Promise<Pokemon[]> {
    const repo = new PokemonRepo(AppDataSource);

    return await repo.GetPokemon();
  }
}

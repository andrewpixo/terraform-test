import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import {Pokemon} from "./db/Pokemon";

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get("Pokemon")
  async getPokemon(): Promise<Pokemon[]> {
    return await this.appService.getPokemon();
  }
}

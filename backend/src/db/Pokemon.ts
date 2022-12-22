import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

export class Pokemon {
  id: number;
  name: string;
  type: string;
  isCool: boolean;
}

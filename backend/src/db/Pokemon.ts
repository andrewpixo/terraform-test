import {Column, Entity , PrimaryGeneratedColumn} from "typeorm";

@Entity()
export class Pokemon {
    @PrimaryGeneratedColumn()
    id: number;
    @Column({length: 255})
    name: string;
    @Column({length: 255})
    type: string;
    @Column()
    isCool: boolean;
}
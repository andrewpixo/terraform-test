import {MigrationInterface, QueryRunner} from "typeorm";
import {Pokemon} from "./Pokemon";



export const seedPokemon : Pokemon[] = [
    {
        isCool: true,
        id: 1,
        type: "water/ice",
        name: "Walrein"
    },
    {
        id: 2,
        type: "electric",
        isCool: true,
        name: "Pikachu"
    },
    {
        id: 3,
        name: "The one you like",
        type: "lame",
        isCool: false
    }
]
import {DataSource} from "typeorm";
import {Pokemon} from "./Pokemon";
import { seedPokemon} from "./SeedData";

const {DB_HOST, DB_USER, DB_PASS, DB_PORT} = process.env;

const AppDataSource = new DataSource({
    type: "postgres",
    entities: [Pokemon],
    port: Number(DB_PORT),
    host: DB_HOST,
    username: DB_USER,
    password: DB_PASS,
    database: "postgres",
    synchronize: true,
    logging: false
});


AppDataSource.initialize()
    .then((a) => {
        a.manager.getRepository(Pokemon).save(seedPokemon);
    })
    .catch((err) => {
        console.error("ERROR!!!", err)
    })


export default AppDataSource;

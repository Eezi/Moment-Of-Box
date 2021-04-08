import pg from 'pg'
import dotenv from 'dotenv'
dotenv.config()
const { Pool } = pg;

const pool = new Pool({
    "user": "postgres",
    "password": process.env.DBPASS,
    "host": "localhost",
    "port": 5432,
    "database": "tasks",
    
});

pool.connect(function (err){
    if(err)
        console.log('EERRORRRR', err);
    else
        console.log("Connected!");
});

export default pool;
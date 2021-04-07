import pg from 'pg'
const { Pool } = pg;

const pool = new Pool({
    "user": "postgres",
    "password": "task12233",
    "host": "localhost",
    "port": 5000,
    "database": "perntask"
});

export default pool;
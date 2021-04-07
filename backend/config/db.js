const Pool = require('pg').Pool;

const pool = new Pool({
    "user": "postgres",
    "password": "task12233",
    "host": "localhost",
    "port": 5000,
    "database": "perntask"
});

module.exports = pool;
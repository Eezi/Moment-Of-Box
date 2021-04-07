const express = require('express')
const app = express()
const cors = require('cors')
const pool = require('./config/db')

const port = process.env.port || 5000;

app.use(cors())
app.use(express.json())

app.listen(5000, () => console.log(`Server is running at port ${port}`))

app.post('/tasks', async (req, res) => {
    try {
       console.log('body', req.body) 
    } catch (error) {
        console.log('POST error', error.message)  
    }
})
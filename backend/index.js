import express from 'express'
const app = express()
import cors from 'cors'
import pool from './config/db.js'
import taskRoutes from './routes/taskRoutes.js'

const port = process.env.port || 5000;

app.use(cors())
app.use(express.json())

app.use('/tasks', taskRoutes);

app.listen(5000, () => console.log(`Server is running at port ${port}`))

app.post('/tasks', async (req, res) => {
    try {
       console.log('body', req.body) 
    } catch (error) {
        console.log('POST error', error.message)  
    }
})
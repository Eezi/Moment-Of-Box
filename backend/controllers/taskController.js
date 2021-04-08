import asyncHandler from "express-async-handler";
import pool from '../config/db.js'

export const getTasks = asyncHandler(async (req, res) => {
try {
  const tasks = await pool.query('SELECT * FROM task')
  res.json(tasks);
} catch (error) {
  console.log('error', error.message) 
}
});


export const getTaskById = asyncHandler(async (req, res) => {
  const { id } = req.params;
try {
  const task = await pool.query('SELECT * FROM task WHERE task_id = $1',
  [id])
  res.json(task);
} catch (error) {
  console.log('error', error.message) 
}
});

export const deleteTask = asyncHandler(async (req, res) => {
  const { id } = req.params;
try {
  await pool.query('DELETE FROM task WHERE task_id = $1',
  [id])
  res.json(`Task ID: ${id} is removed`);
} catch (error) {
  console.log('error', error.message) 
}
});

export const updateTask = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const { title, description } = req.body;

try {
  const task = await pool.query('UPDATE task SET title = $1, description = $2 WHERE task_id = $3',
  [title, description, id])
  res.json(task);
} catch (error) {
  console.log('error', error.message) 
}
});

export const createTask = asyncHandler(async (req, res) => {
  const { title, description } = req.body;
try {
  const task = await pool.query('INSERT INTO task (title, description) VALUES ($1, $2)', 
  [title, description]);

  res.json(task);
} catch (error) {
  console.log('error', error.message) 
}
});
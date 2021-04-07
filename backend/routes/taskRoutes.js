import express from 'express' 
import {
  createTask,
  getTasks,
  getTaskById,
  updateTask,
  deleteTask
} from '../controllers/taskController.js';
const router = express.Router();

router.route("/").get(getTasks).post(createTask);
router
  .route("/:id")
  .get(getTaskById)
  .delete(deleteTask)
  .put(updateTask);
  
export default router;
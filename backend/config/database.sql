CREATE DATABASE tasks;

CREATE TABLE task(
    task_id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    description VARCHAR(255)
);
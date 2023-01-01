CREATE TABLE
    IF NOT EXISTS todos (
        id SERIAL,
        todo_text TEXT,
        active BOOLEAN
    );

    INSERT INTO todos (todo_text) VALUES('learn vlang')
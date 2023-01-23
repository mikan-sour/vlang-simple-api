SET GLOBAL max_allowed_packet = 1024 * 1024 * 256;

CREATE TABLE
    IF NOT EXISTS todos (
        id SERIAL,
        todo_text TEXT,
        active BOOLEAN DEFAULT true,
        created_at DATETIME DEFAULT NOW(),
        updated_at DATETIME DEFAULT NOW()
    );

    INSERT INTO todos (todo_text) VALUES('learn vlang')
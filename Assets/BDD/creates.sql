DROP TABLE IF EXISTS desafios;
DROP TABLE IF EXISTS perguntas;
DROP TABLE IF EXISTS datasets;

-- Guarda os conjuntos de dados usados pelos desafios.
CREATE TABLE datasets (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    descricao TEXT
);

-- Guarda cada pergunta associada a um dataset.
CREATE TABLE perguntas (
    id SERIAL PRIMARY KEY,
    dataset_id INTEGER NOT NULL,
    enunciado TEXT NOT NULL,
    tipo TEXT NOT NULL, -- multipla_escolha, numero, texto
    alternativa_a TEXT,
    alternativa_b TEXT,
    alternativa_c TEXT,
    alternativa_d TEXT,
    resposta_correta TEXT NOT NULL,
    FOREIGN KEY (dataset_id) REFERENCES datasets(id)
);

-- Aqui controla: nível de dificuldade (1 a 20);
-- qual pergunta pertence a qual desafio;
-- qual dataset deve ser exibido;

CREATE TABLE desafios (
    id SERIAL PRIMARY KEY,
    nivel INTEGER NOT NULL,  -- 1 a 20
    pergunta_id INTEGER NOT NULL,
    dataset_id INTEGER NOT NULL,
    FOREIGN KEY (pergunta_id) REFERENCES perguntas(id),
    FOREIGN KEY (dataset_id) REFERENCES datasets(id)
);

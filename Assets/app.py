from flask import Flask, render_template, request, redirect, session
import psycopg2
import sys

# Ajuste de encoding (opcional para Windows)
sys.stdout.reconfigure(encoding='utf-8')
sys.stderr.reconfigure(encoding='utf-8')

app = Flask(__name__)
app.secret_key = "chave_secreta_jogo"


DB_CONFIG = {
    "host": "ep-bold-forest-ad4a87jo-pooler.c-2.us-east-1.aws.neon.tech",
    "port": 5432,
    "dbname": "neondb",
    "user": "neondb_owner",
    "password": "npg_syA7JM0FkOTd",
    "sslmode": "require"
}

def get_db_connection():
    return psycopg2.connect(**DB_CONFIG)

# Rota inicial
@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        session["nivel"] = 1
        return redirect('/jogo')
    return render_template('index.html')

# Rota do jogo
@app.route('/jogo', methods=['GET', 'POST'])
def jogo():
    nivel = session.get("nivel", 1)

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT p.id, p.enunciado,
               p.alternativa_a, p.alternativa_b,
               p.alternativa_c, p.alternativa_d,
               p.resposta_correta
        FROM desafios d
        JOIN perguntas p ON p.id = d.pergunta_id
        WHERE d.nivel = %s
    """, (nivel,))

    pergunta = cur.fetchone()
    cur.close()
    conn.close()

    if not pergunta:
        return "Parabens! Voce completou todos os niveis do jogo."

    return render_template('jogo.html', pergunta=pergunta, nivel=nivel)

# Rota da resposta
@app.route('/responder', methods=['POST'])
def responder():
    resposta_usuario = request.form.get('resposta')
    resposta_correta = request.form.get('correta')

    if resposta_usuario == resposta_correta:
        session["nivel"] = session.get("nivel", 1) + 1
        return redirect('/resultado?status=acerto')
    else:
        return redirect('/resultado?status=erro')

# Rota de resultado
@app.route('/resultado')
def resultado():
    status = request.args.get('status')
    return render_template('resultado.html', status=status)

if __name__ == '__main__':
    app.run(debug=True)

import sys
import psycopg2

# Forca o Python a trabalhar em UTF-8 no Windows
sys.stdout.reconfigure(encoding='utf-8')
sys.stderr.reconfigure(encoding='utf-8')


# teste no banco de dados local

# DB_CONFIG = {
#    "host": "localhost",
#    "port": 5432,
#    "dbname": "postgres",
#    "user": "postgres",
#    "password": "analiseJogo"
# } 

# teste no banco de dados NEON
DB_CONFIG = {
    "host": "ep-bold-forest-ad4a87jo-pooler.c-2.us-east-1.aws.neon.tech",
    "port": 5432,
    "dbname": "neondb",
    "user": "neondb_owner",
    "password": "npg_syA7JM0FkOTd",
    "sslmode": "require"
}

try:
    print("Testando conexao com o PostgreSQL local...")

    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    print("Conexao realizada com sucesso!")

    cur.execute("SELECT tablename FROM pg_tables WHERE schemaname = 'public'")
    tabelas = cur.fetchall()

    print("Tabelas encontradas:")
    if tabelas:
        for t in tabelas:
            print("-", t[0])
    else:
        print("Nenhuma tabela encontrada.")

    cur.close()
    conn.close()

except Exception as erro:
    print("Erro ao tentar conectar no banco:")
    print(repr(erro))  # <-- IMPORTANTE: evita erro de UTF-8

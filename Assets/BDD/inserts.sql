-- =========================
-- LIMPEZA (OPCIONAL)
-- =========================
DELETE FROM desafios;
DELETE FROM perguntas;
DELETE FROM datasets;

-- =========================
-- DATASETS
-- =========================
INSERT INTO datasets (nome, descricao) VALUES
('Vendas Simples', 'Tabela basica de vendas por produto'),
('Acessos Site', 'Acessos diarios no site'),
('Notas Alunos', 'Notas de avaliacao'),
('Marketing Digital', 'Campanhas e conversoes'),
('Estatistica', 'Valores para analise estatistica');

-- =========================
-- PERGUNTAS (1 a 20)
-- =========================
INSERT INTO perguntas (
dataset_id, enunciado, tipo,
alternativa_a, alternativa_b, alternativa_c, alternativa_d, resposta_correta
) VALUES
-- 1
(1,'Qual o valor total de 2 produtos de 50 cada?','multipla_escolha','50','80','100','120','C'),
-- 2
(1,'Se vendeu 3 itens de 10 reais, qual o total?','multipla_escolha','20','30','40','50','B'),
-- 3
(2,'Qual dia teve mais acessos: 30, 45 ou 20?','multipla_escolha','30','45','20','Todos iguais','B'),
-- 4
(3,'Quem teve maior nota: 7, 8 ou 6?','multipla_escolha','7','8','6','Todos','B'),
-- 5
(3,'Media de 6, 8 e 10?','multipla_escolha','6','8','9','10','C'),

-- 6
(1,'Total de vendas: 100 + 250 + 50','multipla_escolha','300','350','400','450','B'),
-- 7
(2,'Total de acessos: 10 + 20 + 30','multipla_escolha','40','50','60','70','C'),
-- 8
(1,'Qual venda foi maior: 200, 150, 180','multipla_escolha','200','150','180','Todas','A'),
-- 9
(3,'Media de 5, 10, 15','multipla_escolha','10','15','5','20','A'),
--10
(3,'Menor valor: 12, 18, 9','multipla_escolha','12','18','9','Nenhum','C'),

-- 11
(4,'Qual campanha teve mais conversoes?','multipla_escolha','A','B','C','D','B'),
--12
(4,'Taxa: 20 conversoes em 200 cliques','multipla_escolha','5%','10%','15%','20%','B'),
--13
(5,'Qual valor e um outlier: 10,12,13,50','multipla_escolha','10','12','13','50','D'),
--14
(5,'Qual a mediana: 2,4,6,8,10','multipla_escolha','4','6','8','10','B'),
--15
(2,'Tendencia: 10,20,30,40','multipla_escolha','Crescente','Decrescente','Igual','Aleatoria','A'),

-- 16
(4,'Maior taxa de conversao: 10/200, 20/150, 5/100','multipla_escolha','10/200','20/150','5/100','Todas','B'),
--17
(5,'Media de 100,150,200','multipla_escolha','150','170','180','200','A'),
--18
(5,'Variacao entre 100 e 180','multipla_escolha','60','70','80','90','C'),
--19
(1,'Projecao simples: 100,120,140','multipla_escolha','150','160','170','180','B'),
--20
(4,'Canal com maior eficiencia?','multipla_escolha','Instagram','Google','Email','TikTok','C');

-- =========================
-- DESAFIOS (1 A 20)
-- =========================
INSERT INTO desafios (nivel, pergunta_id, dataset_id)
SELECT 
    ROW_NUMBER() OVER (ORDER BY p.id) AS nivel,
    p.id,
    p.dataset_id
FROM perguntas p
ORDER BY p.id
LIMIT 20;

select * from datasets
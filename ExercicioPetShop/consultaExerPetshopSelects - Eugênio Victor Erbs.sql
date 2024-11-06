SELECT *
FROM produto
WHERE vl_venda >= 100;

SELECT *
FROM servico
WHERE vl_servico <= 50;	

SELECT nm_animal, dt_nascimento, tp_porte
FROM animal
ORDER BY dt_nascimento ASC;

SELECT nr_notal_fiscal, vl_total, dt_emissao
FROM nota_fiscal
WHERE dt_emissa BETWHEN data inicio AND data final;

SELECT *
FROM cliente
WHERE ds_email IS NULL OR ds_email = '';

SELECT *
FROM produto
WHERE vl_venda > 9.99 AND qt_estoque >= 100;

SELECT *
FROM agendamento_servico
ORDER BY vl_servico DESC;

SELECT *
FROM prestador_servico
WHERE nr_telefone LIKE '47%';

SELECT nm_animal, dt_nascimento
FROM animal
WHERE tp_porte LIKE '%G%';

SELECT *
FROM cliente
WHERE nm_cliente LIKE '%silva%';

SELECT *
FROM agendamento
WHERE dt_agendamento >= '2024-10-01' AND dt_agendamento <= '2024-10-15';

SELECT *
FROM cliente
WHERE dt_nascimento <= ' 01/01/1980';

SELECT *
FROM categoria
WHERE ds_categoria LIKE '%brinquedo%';

SELECT *
FROM cliente
WHERE ds_email LIKE '%@gmail.com%';

SELECT *
FROM produto
WHERE qt_estoque >= 20 AND vl_venda < 100;
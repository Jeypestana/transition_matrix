--consult para matriz de transicion
select distinct  merged_data.numero_radicacion , merged_data.edad_mora , merged_data.alturamora_act , merged_data.fecha_corte
from (
    SELECT * FROM mis.analisis_cosechas_historico
    UNION ALL
    SELECT * FROM mis.cosechas
    ) AS merged_data
    join abacus.credito c on c.numero_radicacion = merged_data.numero_radicacion
    where c.estado_credito not in ('CANCELADO_POR_INCONSISTENCIAS', 'ANULADO', 'NEGADO_VISACION', 'SIN_CAPACIDAD_PAGO',
	'NEGADO_EXCEPCION', 'CONSULTA_RECHAZADA',
	'NEGADO', 'SOLICITUD_CANCELADA', 'NEGADO_DESEMBOLSO', 'NEGADO_CAUSAL', 'CLIENTE_DESISTE', 'RECHAZO_CLIENTE', 'CONSULTA_CENTRALES_FALLO_TECNICO', 'CLIENTE_RECHAZO_PROSPECCION',
	'TERMINADO_REESTRUCTURACION', 'APLAZADO_ERROR_CARTERA', 'RECHAZO_REGLA_PROSPECCION')
	and merged_data.sfc = 'NO' and merged_data.periodo_cerrado = 1 and merged_data.fecha_corte >= '20230430' and merged_data.fecha_activacion_contable < '20230801'
	order by merged_data.fecha_corte  asc
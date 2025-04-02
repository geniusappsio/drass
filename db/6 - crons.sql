SELECT cron.unschedule('atualizar-visibilidade-secoes');
SELECT cron.schedule('atualizar-visibilidade-secoes', '*/10 * * * *', 'SELECT atualizar_visibilidade_secoes()');
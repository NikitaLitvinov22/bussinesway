#!/usr/bin/env bash
# Однократный деплой текущих правок на прод. Запускать с машины, у которой ЕСТЬ
# доступ к analytics.businessway22.ru (например, с вашего компьютера или через
# веб-консоль самого сервера) — из облачной песочницы Claude это не проходит
# (исходящий трафик там ограничен списком разрешённых доменов).
set -euo pipefail
cd "$(dirname "$0")"
set -a; source server.env; set +a
# --resolve обходит локальный DNS-резолвер (у него бывают зависания/таймауты) —
# соединяемся сразу по SERVER_IP, но SNI/Host остаются доменными, чтобы TLS-сертификат
# и nginx server_name отработали как обычно.
curl -sS --resolve "${DOMAIN}:443:${SERVER_IP}" -X POST "https://${DOMAIN}/internal/deploy" \
  -H "X-Deploy-Token: ${DEPLOY_TOKEN}" \
  --data-binary @app_update.tar.gz
echo
echo "Готово. Проверка:"
curl -sS --resolve "${DOMAIN}:443:${SERVER_IP}" "https://${DOMAIN}/internal/health"
echo

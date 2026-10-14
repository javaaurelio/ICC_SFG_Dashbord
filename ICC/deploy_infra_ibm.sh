#!/bin/bash

set -e

DEPLOY_DIR="/opt/IBM/SterlingControlCenter/web/ccbase/webapps"
BIN_DIR="/opt/IBM/SterlingControlCenter/bin"

echo "================================="
echo "Deploy infra-icc"
echo "================================="

echo "[2] Gerando WAR..."
cd infra-icc

rm -f infra-icc.war
zip -rq infra-icc.war *

echo "[3] Copiando WAR..."
sudo cp -f infra-icc.war "${DEPLOY_DIR}/"

echo "[4] Copiando XML..."
sudo cp -f infra-icc.xml "${DEPLOY_DIR}/"

echo "[5] Ajustando permissões..."
sudo chmod 777 "${DEPLOY_DIR}/infra-icc.war"
sudo chmod 777 "${DEPLOY_DIR}/infra-icc.xml"

echo "[6] Redeploy WebApp Server..."
cd "${BIN_DIR}"
sudo -u spsccdr1 "${BIN_DIR}/redeployWebApp.sh"

echo "================================="
echo "$(date '+%d/%m/%Y %H:%M:%S') - Deploy concluido com sucesso"

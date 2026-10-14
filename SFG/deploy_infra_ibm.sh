#!/bin/bash

# Parar Liberty
echo "Parando SIServer..."
sudo -u spbasdr1 /opt/IBM/SterlingIntegrator/install/liberty/wlp/bin/server stop SIServer

if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao parar o SIServer."
    exit 1
fi

# Gerar WAR
echo "Gerando infra-ibm.war..."
sudo /opt/IBM/SterlingIntegrator/install/jdk/bin/jar -cvf \
/opt/IBM/SterlingIntegrator/install/liberty/wlp/usr/servers/SIServer/apps/infra-ibm.war \
-C /export/home/TESTE/infra-ibm .

if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao gerar o WAR."
    exit 1
fi

# Ajustar permissões
echo "Ajustando permissões..."
sudo chmod 777 /opt/IBM/SterlingIntegrator/install/liberty/wlp/usr/servers/SIServer/apps/infra-ibm.war

if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao alterar permissões."
    exit 1
fi

# Iniciar Liberty
echo "Iniciando SIServer..."
cd /opt/IBM/SterlingIntegrator/install/bin || exit 1

sudo -u spbasdr1 /opt/IBM/SterlingIntegrator/install/bin/startLiberty.sh

if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao iniciar o SIServer."
    exit 1
fi

echo "Deploy concluído com sucesso."

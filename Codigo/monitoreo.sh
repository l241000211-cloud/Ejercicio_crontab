#!/bin/bash
# ==============================================================================
# Materia: Sistemas Operativos
# Script: monitoreo.sh
# Objetivo: Registrar salud del sistema (RAM, Disco y Top 3 procesos) cada 2 min
# ==============================================================================

# 1. Ruta del archivo de registro en el directorio personal ($HOME)
LOG_FILE="$HOME/salud_pc.log"

# 2. Marca temporal con fecha y hora actual
FECHA=$(date '+%Y-%m-%d %H:%M:%S')

# 3. Métricas de memoria RAM física en MB (consultadas con 'free -m')
RAM_TOTAL=$(free -m | awk '/^Mem:/ {print $2}')
RAM_USADA=$(free -m | awk '/^Mem:/ {print $3}')
RAM_PORC=$(( RAM_USADA * 100 / RAM_TOTAL ))

# 4. Almacenamiento libre en la partición raíz ('/' mediante 'df -h')
DISCO_LIBRE=$(df -h / | awk 'NR==2 {print $4}')

# 5. Escritura de encabezados y métricas generales en el log
echo "==================================================" >> "$LOG_FILE"
echo "[$FECHA] REPORTE DE SALUD DEL SISTEMA" >> "$LOG_FILE"
echo "RAM en uso: ${RAM_USADA}MB de ${RAM_TOTAL}MB (${RAM_PORC}%)" >> "$LOG_FILE"
echo "Espacio libre en disco (/): $DISCO_LIBRE" >> "$LOG_FILE"
echo "Top 3 procesos con mayor consumo de memoria:" >> "$LOG_FILE"

# 6. Extracción y ordenamiento del Top 3 de procesos por uso de RAM
ps -eo comm,%mem --sort=-%mem | head -n 4 | tail -n 3 >> "$LOG_FILE"
echo "==================================================" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

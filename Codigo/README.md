## 💻 Código y Scripts

* 📜 **Archivo:** [monitoreo.sh](Codigo/monitoreo.sh)

```bash
#!/bin/bash
# Script de monitoreo automatizado de recursos
LOG_FILE="$HOME/salud_pc.log"
FECHA=$(date '+%Y-%m-%d %H:%M:%S')

RAM_TOTAL=$(free -m | awk '/^Mem:/ {print $2}')
RAM_USADA=$(free -m | awk '/^Mem:/ {print $3}')
RAM_PORC=$(( RAM_USADA * 100 / RAM_TOTAL ))

DISCO_LIBRE=$(df -h / | awk 'NR==2 {print $4}')

echo "==================================================" >> "$LOG_FILE"
echo "[$FECHA] REPORTE DE SALUD DEL SISTEMA" >> "$LOG_FILE"
echo "RAM en uso: ${RAM_USADA}MB de${RAM_TOTAL}MB (${RAM_PORC}\%)" >> "$LOG_FILE"
echo "Espacio libre en disco (/): $DISCO_LIBRE" >> "$LOG_FILE"
echo "Top 3 procesos con mayor consumo de memoria:" >> "$LOG_FILE"
ps -eo comm,%mem --sort=-%mem | head -n 4 | tail -n 3 >> "$LOG_FILE"
echo "==================================================" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

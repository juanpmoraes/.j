#!/bin/bash

# memory_usage.sh - Script para monitorar uso de memória por processo

# Exibe os 10 processos que mais consomem memória
ps aux --sort -rss | head -n 11

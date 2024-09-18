# Informe de Escaneo de Nmap

Este repositorio contiene un archivo XSLT para transformar archivos de salida de Nmap en informes HTML detallados.

## Uso

1. **Preparar el Archivo XML**: Asegúrate de tener un archivo de salida de Nmap en formato XML.

2. **Transformar el Archivo XML**: Usa un transformador XSLT como `xsltproc` para aplicar la transformación.

  
   xsltproc transform.xsl nerostyle.xml -o informe.html

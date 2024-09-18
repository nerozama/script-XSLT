<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>

    <!-- Iniciar el diseño del HTML -->
    <xsl:template match="/">
        <html lang="en">
        <head>
            <meta charset="UTF-8"/>
            <title>Informe - Análisis Detallado</title>

            <!-- CSS personalizado para un estilo avanzado y responsivo -->
            <style>
               /* Paleta de colores */
body {
    background-color: #1d1f21;
    color: #c5c8c6;
    font-family: 'Fira Code', monospace;
}

h1, h2, h3 {
    color: #00ff41;
    text-transform: uppercase;
    border-bottom: 2px solid #00ff41;
    padding-bottom: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    background-color: #282a36;
    border: 1px solid #6272a4;
}

th, td {
    padding: 12px;
    text-align: left;
    color: #f8f8f2;
    border-bottom: 1px solid #6272a4;
}

th {
    background-color: #44475a;
}

td:hover {
    background-color: #373b41;
}

/* Links */
a {
    color: #50fa7b;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

/* Ascii Art */
.ascii pre {
    color: #00ff41;
    font-family: 'Source Code Pro', monospace;
    text-align: center;
}

/* Logo personalizado */
.logo {
    font-size: 24px;
    font-weight: bold;
    color: #50fa7b;
    text-shadow: 0 0 10px #50fa7b;
}

/* Estilo para el arte ASCII */
.ascii {
    background-color: #282a36;
    padding: 15px;
    border-radius: 10px;
    margin: 20px 0;
    font-family: 'Courier New', monospace;
    color: #50fa7b;
    text-align: center;
    box-shadow: 0 0 10px rgba(0, 255, 65, 0.5);
}

/* Estilo para la información personalizada */
.info {
    background-color: #282a36;
    padding: 20px;
    border-radius: 10px;
    margin: 20px 0;
    box-shadow: 0 0 10px rgba(0, 255, 65, 0.3);
}

.info p {
    margin: 10px 0;
}

.highlight {
    color: #8be9fd;
    font-style: italic;
}

.link {
    color: #ff79c6;
    text-decoration: none;
}

.link:hover {
    text-decoration: underline;
}

/* Gráfico */
canvas {
    background-color: #282a36;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
}

            </style>
            
            <!-- Script para filtros dinámicos de búsqueda -->
            <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
            <script>
                document.addEventListener("DOMContentLoaded", function() {
                    var table = document.querySelector("table");
                    var dataTable = $(table).DataTable({
                        "searching": true,
                        "paging": true,
                        "info": true
                    });
                });
            </script>
        </head>

        <body>

        <header>
            <h1>Informe de Escaneo</h1>
            <p>Resultados del análisis de red</p>
        </header>

	<!-- Arte ASCII -->
<div class="ascii">
    <pre>
    _  _                 _                      _            _   
  _| || |_              | |                    | |          | |  
 |_  __  _| ___ ___   __| | ___ _ __  _ __ ___ | |_ ___  ___| |_ 
  _| || |_ / __/ _ \ / _` |/ _ \ '_ \| '__/ _ \| __/ _ \/ __| __|
 |_  __  _| (_| (_) | (_| |  __/ |_) | | | (_) | ||  __/ (__| |_ 
   |_||_|  \___\___/ \__,_|\___| .__/|_|  \___/ \__\___|\___|\__|
                               | |                              
                               |_|                              
    </pre>
</div>

<!-- Información personalizada -->
<div class="info">
    <p><strong>Usuario</strong>: <span class="highlight">nerozama</span></p>
    <p><strong>Estado</strong>: <span class="highlight">Estudiante de Ingeniería en Ciberseguridad</span></p>
    <p><strong>Sobre mí</strong>: <span class="highlight">Reportando desde las sombras...</span></p>
    <p><strong>Portafolio</strong>: <a href="http://www.nerolandia.cl" target="_blank" class="link">www.nerolandia.cl</a></p>
</div>

	        <section>
            <!-- Comando utilizado para el escaneo -->
            <h2>Comando Usado</h2>
            <pre>
                <xsl:value-of select="/nmaprun/args"/>
            </pre>
        </section>

        <section>



            <!-- Información del host objetivo -->
            <h2>Datos del Objetivo</h2>
            <table>
                <tr>
                    <th>IP</th>
                    <td><xsl:value-of select="/nmaprun/host/address[@addrtype='ipv4']/@addr"/></td>
                </tr>
                <tr>
                    <th>Sistema Operativo</th>
                    <td><xsl:value-of select="/nmaprun/host/os/osmatch/@name"/></td>
                </tr>
                <tr>
                    <th>Hostname</th>
                    <td><xsl:value-of select="/nmaprun/host/hostnames/hostname/@name"/></td>
                </tr>
                <tr>
                    <th>Estado</th>
                    <td><xsl:value-of select="/nmaprun/host/status/@state"/></td>
                </tr>
            </table>
        </section>

        <section>
            <!-- Puertos escaneados con servicios -->
            <h2>Puertos Abiertos y Servicios</h2>
            <table id="portsTable">
                <thead>
                    <tr>
                        <th>Puerto</th>
                        <th>Protocolo</th>
                        <th>Servicio</th>
                        <th>Versión</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="/nmaprun/host/ports/port">
                        <tr>
                            <td><xsl:value-of select="@portid"/></td>
                            <td><xsl:value-of select="@protocol"/></td>
                            <td><xsl:value-of select="service/@name"/></td>
                            <td><xsl:value-of select="service/@version"/></td>
                            <td><xsl:value-of select="state/@state"/></td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </section>

        <section>
            <!-- Información de vulnerabilidades, si corresponde -->
            <h2>Vulnerabilidades Detectadas</h2>
            <table>
                <thead>
                    <tr>
                        <th>Script</th>
                        <th>Descripción</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="/nmaprun/host/ports/port/script">
                        <tr>
                            <td><xsl:value-of select="@id"/></td>
                            <td><xsl:value-of select="@output"/></td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </section>

        <!-- Sección para gráficos con Chart.js -->

	<!-- Sección para gráficos con Chart.js -->
<section style="max-width: 600px; margin: 0 auto; padding: 20px;">
    <h2 style="text-align: center; color: #333;">Distribución de Puertos</h2>
    <canvas id="portsChart"></canvas>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        var ctx = document.getElementById('portsChart').getContext('2d');
        var chartData = {
            labels: [<xsl:for-each select="/nmaprun/host/ports/port"><xsl:if test="position() != 1">, </xsl:if>"<xsl:value-of select="@portid"/>" </xsl:for-each>],
            datasets: [{
                label: 'Puertos Abiertos',
                data: [<xsl:for-each select="/nmaprun/host/ports/port"><xsl:if test="position() != 1">, </xsl:if>1</xsl:for-each>],
                backgroundColor: [
                    'rgba(0, 123, 255, 0.6)',
                    'rgba(40, 167, 69, 0.6)',
                    'rgba(255, 193, 7, 0.6)',
                    'rgba(220, 53, 69, 0.6)',
                    'rgba(23, 162, 184, 0.6)'
                ],
                borderColor: [
                    'rgba(0, 123, 255, 1)',
                    'rgba(40, 167, 69, 1)',
                    'rgba(255, 193, 7, 1)',
                    'rgba(220, 53, 69, 1)',
                    'rgba(23, 162, 184, 1)'
                ],
                borderWidth: 1
            }]
        };
        var portsChart = new Chart(ctx, {
            type: 'doughnut',
            data: chartData,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(tooltipItem) {
                                return tooltipItem.label + ': ' + tooltipItem.raw + ' puertos';
                            }
                        }
                    }
                }
            }
        });
    </script>
</section>

<!-- Cierre del HTML -->
</body>
</html>

    </xsl:template>
</xsl:stylesheet>

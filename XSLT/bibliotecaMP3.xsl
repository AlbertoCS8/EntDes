<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:template match="/">
      <html>
         <body>
            <h1>Ejercicio 1 XSLT</h1>
            <h2>
               <xsl:value-of select="MiBibliotecaMP3/@titulo" />
            </h2>
            <h2>TABLA 1 info del primer archivo mp3</h2>
            <table style="border:1px solid blue;">
               <tr style="background-color:lightblue;">
                  <th style="text-align:left">Cancion</th>
                  <th style="text-align:left">Artista</th>
                  <th style="text-align:left">Disco</th>
               </tr>
               <tr>
               <td><xsl:value-of select="//archivo[1]/cancion"></xsl:value-of></td>
               <td><xsl:value-of select="//archivo[1]/artista/@cantante"></xsl:value-of></td>
               <td><xsl:value-of select="//archivo[1]/disco"></xsl:value-of></td>
               </tr>
               <!-- Info del primer archivo mp3-->
               <tr>
               <td><xsl:value-of select="//archivo[last()]/cancion"></xsl:value-of></td>
               <td><xsl:value-of select="//archivo[last()]/artista/@cantante"></xsl:value-of></td>
               <td><xsl:value-of select="//archivo[last()]/disco"></xsl:value-of></td>
            </tr>
            </table>
            <h3>Tabla num 2</h3>
            <table style="border:1px solid blue;">
               <tr style="background-color:lightblue;">
                  <th style="text-align:left">Cancion</th>
                  <th style="text-align:left">Artista</th>
                  <th style="text-align:left">Disco</th>
               </tr>
              
               <h4>Tabla 3</h4>
               <table style="border:1px solid blue;">
                  <tr style="background-color:lightblue;">
                     <th style="text-align:left">Cancion</th>
                     <th style="text-align:left">Artista</th>
                     <th style="text-align:left">Disco</th>
                  </tr>
               <xsl:for-each select="//archivo/disco[@anio &gt;'1986']">
                  <tr>
                     <td><xsl:value-of select="../cancion"></xsl:value-of></td>
                  </tr>
                  <tr>
                     <td><xsl:value-of select="../artista"></xsl:value-of></td>
                  </tr>
                  <tr>
                     <td><xsl:value-of select="."></xsl:value-of></td>
                  </tr>
               </xsl:for-each>
               </table>
               <h4>Tabla 4 archivos ord por punt</h4>
               <table style="border:1px solid blue;">
                  <!-- Primera fila es cabecera y no se borra-->
                  <tr style="background-color:lightblue;">
                     <th style="text-align:left">Cancion</th>
                     <th style="text-align:left">Artista</th>
                     <th style="text-align:left">Disco</th>
                     <th style="text-align:left">puntuacion</th>
                  </tr>
                  <!-- Generamos dinámicamente el resto de filas-->
               <xsl:for-each select="//archivo">
                  <xsl:sort select="puntuacion" data-type="number" order="descending"></xsl:sort>
                  <xsl:if test="puntuacion=8"><!-- Condicional-->
                  <tr style="background-color:yellow">
                     <td><xsl:value-of select="cancion"/></td>
                     <td><xsl:value-of select="artista"/></td>
                     <td><xsl:value-of select="disco"/></td>
                     <td><xsl:value-of select="puntuacion"/></td>
                  </tr>
               </xsl:if>
               </xsl:for-each>
               <xsl:for-each select="//archivo">
                  <xsl:sort select="puntuacion" data-type="number" order="descending"></xsl:sort>
                  <xsl:if test="puntuacion=9"><!-- Condicional-->
                  <tr style="background-color:orange">
                     <td><xsl:value-of select="cancion"/></td>
                     <td><xsl:value-of select="artista"/></td>
                     <td><xsl:value-of select="disco"/></td>
                     <td><xsl:value-of select="puntuacion"/></td>
                  </tr>
               </xsl:if>
               </xsl:for-each>
               <xsl:for-each select="//archivo">
                  <xsl:sort select="puntuacion" data-type="number" order="descending"></xsl:sort>
                  <xsl:if test="puntuacion=10"><!-- Condicional-->
                  <tr style="background-color:red">
                     <td><xsl:value-of select="cancion"/></td>
                     <td><xsl:value-of select="artista"/></td>
                     <td><xsl:value-of select="disco"/></td>
                     <td><xsl:value-of select="puntuacion"/></td>
                  </tr>
               </xsl:if>
               </xsl:for-each>
               </table>
            </table>
            <h5>Tabla 5 archivos ord por punt</h5>
               <table style="border:1px solid blue;">
                  <!-- Primera fila es cabecera y no se borra-->
                  <tr style="background-color:lightblue;">
                     <th style="text-align:left">Cancion</th>
                     <th style="text-align:left">Artista</th>
                     <th style="text-align:left">Disco</th>
                     <th style="text-align:left">puntuacion</th>
                  </tr>
                  <!-- Generamos dinámicamente el resto de filas-->
               <xsl:for-each select="//archivo">
                  <xsl:choose>
                     <xsl:when test="puntuacion=10"><!-- Condicional-->
                     <tr style="background-color:purple">
                        <td><xsl:value-of select="cancion"/></td>
                        <td><xsl:value-of select="artista"/></td>
                        <td><xsl:value-of select="disco"/></td>
                        <td><xsl:value-of select="puntuacion"/></td>
                     </tr>
                  </xsl:when>
                  <xsl:when test="puntuacion=9"><!-- Condicional-->
                  <tr style="background-color:white">
                     <td><xsl:value-of select="cancion"/></td>
                     <td><xsl:value-of select="artista"/></td>
                     <td><xsl:value-of select="disco"/></td>
                     <td><xsl:value-of select="puntuacion"/></td>
                  </tr>
               </xsl:when>
               <xsl:when test="puntuacion=8"><!-- Condicional-->
               <tr style="background-color:grey">
                  <td><xsl:value-of select="cancion"/></td>
                  <td><xsl:value-of select="artista"/></td>
                  <td><xsl:value-of select="disco"/></td>
                  <td><xsl:value-of select="puntuacion"/></td>
               </tr>
            </xsl:when>

                  </xsl:choose>
               </xsl:for-each>
               </table>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>
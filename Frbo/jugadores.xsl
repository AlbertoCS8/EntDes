<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:template match="/">
      <html>
         <body>
            <h2>Jugadores de futbol <xsl:value-of select="futbol/@temporada"/></h2>
            <table border="1">
               <tr>
                  <th>Nombre</th>
                  <th>Año de nacimiento</th>
                  <th>Equipo</th>
                  <th>Web</th>
                  <th>Foto</th>
               </tr>
               
               <xsl:for-each select="//jugador">
               <tr>
                  <td><xsl:value-of select="@nombre"/></td>
                  <td><xsl:value-of select="@nacido"/></td>
                  <td>
                     <ul>
                        <xsl:for-each select="equipo/*">
                        <li><xsl:value-of select="."/></li>
                     </xsl:for-each>
                     </ul>
                  </td>
                  <td>
                     <xsl:if test="web != '-'">
                     <a href="{web}"><xsl:value-of select="web"/></a><!-- Entre llaves para coger el valor de-->
                     </xsl:if>
                  </td>
                  <td>
                     <img src="imagenes/{foto}" />
                  </td>
               </tr>
            </xsl:for-each>
               
            </table>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>
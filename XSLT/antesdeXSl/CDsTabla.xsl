<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:template match="/">
      <html>
         <body>
            <h2>Mi colección de CDs</h2>
            <table border="1">
               <tr bgcolor="#9acd32">
                  <th style="text-align:left">Títulos</th>
                  <th style="text-align:left">Artistas</th>
               </tr>
               <tr>
                  <td>
                     <ul>
                        <li>Empire Burlesque</li>
                        <xsl:for-each select="//title">
                           <li><xsl:value-of select="."></xsl:value-of></li>
                        </xsl:for-each>
                     </ul>
                  </td>
                  <td>
                     <ol>
                        <li>Bob Dylan</li>
                        <xsl:for-each select="//artist">
                           <li><xsl:value-of select="."></xsl:value-of></li>
                        </xsl:for-each>
                     </ol>
                  </td>
               </tr>
               <tr>
                  <xsl:for-each select="//cd">
                  <td><xsl:value-of select="min(price)"/></td>
               </xsl:for-each>
               </tr>
            </table>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>
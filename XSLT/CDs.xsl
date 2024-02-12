<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:template match="/">
      <html>
        <head>
            <title>Mi tabla de CDs</title>
        </head>
         <body>
            <h2>Mi colección de CDs</h2>
            <table border="1">
               <tr bgcolor="#9acd32">
                  <th style="text-align:left">title</th>
                  <th style="text-align:left">artist</th>
                  <th style="text-align:left">price</th>
                </tr>
               <xsl:for-each select="//cd">
               <xsl:sort select="price" data-type="number" order="descending"></xsl:sort>
               <xsl:choose>
               <xsl:when test="price &gt; 9"><!-- Condicional-->
                  <tr>
                     <td><xsl:value-of select="title"/></td>
                     <td><xsl:value-of select="artist"/></td>
                     <td style="background-color:red"><xsl:value-of select="price"/></td>
                  </tr>
               </xsl:when>
               
            <xsl:when test="price &lt;= 8.5">
            <tr >
               <td><xsl:value-of select="title"/></td>
               <td><xsl:value-of select="artist"/></td>
               <td style="background-color:green"><xsl:value-of select="price"/></td>
            </tr>
            </xsl:when>
            <xsl:otherwise> <!-- "price &lt; 9 and price &gt; 9-->
                <tr >
                    <td><xsl:value-of select="title"/></td>
                    <td><xsl:value-of select="artist"/></td>
                    <td style="background-color:blue"><xsl:value-of select="price"/></td>
                 </tr>
            </xsl:otherwise>
            
        </xsl:choose>
        
            </xsl:for-each>

            <tr><!-- Dentro de la tabla y fuera del for-each-->
               <td colspan="3">Precio total:<xsl:value-of select="round(sum(//price))"/></td>
            </tr>
            </table>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>
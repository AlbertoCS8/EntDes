<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:template match="/">
      <html>
         <body>
            <h1>Universidad de Alcalá de Henares</h1>
            <h2>Informe de notas finales 2023-2024</h2>
            <table border="1">
               <tr>
                  <th>FOTO</th>
                  <th>PRIMER APELLIDO</th>
                  <th>NOMBRE</th>
                  <th>CARRERA</th>
                  <th>NUM ASIGNATURAS</th>
                  <th>ASIGNATURAS</th>
               </tr>
               <tr>
                  <xsl:for-each select="//alumno">
                  <td>
                     <img src="imagenes/{avatar}"/>
                  </td>
                  <td><xsl:value-of select="apellido1"/></td>
                  <td><xsl:value-of select="nombre"/></td>
                  <td><xsl:value-of select="/estudios/carrera[@codigo=//carreras/carrera/@id]"/></td>
                  <td><xsl:value-of select="count(/estudios/asignaturas/asignatura)"/></td>
                  <td>
                     <ul>
                        <xsl:for-each select="/estudio/asignaturas/asignatura">
                           <xsl:variable name="codAsig" select="@codigo"/>
                              <li><xsl:value-of select="//asignatura[@id=$codAsig]/nombre"/>
                              <xsl:if test="@final >=5"></xsl:if>
                              [APROBADO]
                              <xsl:if test="@final lt; 5">
                              [SUSPENSO]
                              </xsl:if>
                                 </li><!--$ para volcar valor de la variable-->
                              <li>Administracion de Empresas [SUSPENSO]</li>
                              <li>Ingenieria del Software [APROBADO]
                              </li>
                              <li>Derecho Internacional
                              [APROBADO]
                              </li>
                        </xsl:for-each>
                     </ul>
                  </td>
               </xsl:for-each>
               </tr>
               
            </table>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>

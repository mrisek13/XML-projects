<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
   <xsl:attribute-set name="centriranje"> 
     <xsl:attribute name="style"> 
       color: blue; font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 80%; text-align: center; 
     </xsl:attribute> 
   </xsl:attribute-set>
   
   <xsl:template match="tablica_kalorija">
     <html>
       <head>
         <title>Tablica kalorija</title>
       </head>
       <body>
         <p style="font-size:200%; color:blue; text-decoration:none;">
           <a name="natrag">Popis vrsta hrane</a>
         </p>
         <ul style="color:blue; text-decoration:none;">
           <xsl:apply-templates select="kategorija_namirnice" mode="toc"/>
         </ul>
         <xsl:apply-templates/> 
       </body>
     </html>
   </xsl:template>
   
   <xsl:template match="kategorija_namirnice">
     <br />
     <h2 id="{normalize-space(.)}">
       <span style="color:grey;">
         <xsl:number format="A"/>.
       </span>
       <xsl:value-of select="."/>
     </h2>
   </xsl:template>
   
   <xsl:template match="kategorija_namirnice" mode="toc"> 
     <li> 
       <a href="#{normalize-space(.)}" style="color:blue; text-decoration:none;">
         <span style="color:grey;"> 
           <xsl:number count="tablica_kalorija/kategorija_namirnice" format="A"/>. 
         </span> 
         <xsl:value-of select="."/> 
       </a> 
     </li> 
   </xsl:template>

   <xsl:template match="vrsta_hrane">
     <table>
       <tr>
         <td style="width:400px" colspan="2">Namirnica (100 gr)</td>
         <td>Energija(kJ)</td>
         <td>Energija(kcal)</td>
         <td>UH(g)</td>
         <td>Bjelančevine(g)</td>
         <td>Masti(g)</td>
       </tr>
       <xsl:for-each select="namirnica"> 
         <xsl:sort select="naziv" lang="hr"/>
         <xsl:choose> 
           <xsl:when test="position() mod 2 = 1"> 
             <tr style="background-color: #ddddff"> 
               <td width="40px"> 
                 <xsl:number value="position()"/>. 
               </td> 
               <xsl:apply-templates/>
             </tr> 
           </xsl:when> 
           <xsl:otherwise> 
             <tr> 
               <td width="40px"> 
                 <xsl:number value="position()"/>. 
               </td> 
               <xsl:apply-templates/>
             </tr> 
           </xsl:otherwise> 
         </xsl:choose> 
       </xsl:for-each>
     </table>  
     <span>Prosječna vrijednost kalorija je: </span>
     <xsl:value-of select="round(sum(namirnica/energija[@mjera='kcal']) div count(namirnica/energija[@mjera='kcal']))"/>
	 <p><a href="#natrag" style="font-size:80%; color:blue; text-decoration:none;">Natrag na popis vrsta hrane</a></p>
   </xsl:template>
   
   <xsl:template match="naziv">
     <td>
       <xsl:value-of select="."/>
     </td>
   </xsl:template>
   
   <xsl:template match="energija | uh | bjelancevine | masti">
     <xsl:element name="td" use-attribute-sets="centriranje">
       <xsl:value-of select="."/>
     </xsl:element>
   </xsl:template>
   
</xsl:stylesheet>

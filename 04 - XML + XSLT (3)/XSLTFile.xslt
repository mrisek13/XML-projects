<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- Definiramo ključ za jedinstvene kategorije -->
  <xsl:key name="kategorije" match="kategorija_namirnice" use="."/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Tablica kalorija</title>
      </head>
      <body>
        
        <!-- Popis jedinstvenih vrsta hrane s linkovima -->
        <p style="font-size:200%; color:blue;"><a name="natrag">Popis vrsta hrane</a></p>
        <ul style="color:blue;">
          <!-- Iteracija kroz jedinstvene kategorije namirnica -->
          <xsl:for-each select="tablica_kalorija/kategorija_namirnice[generate-id() = generate-id(key('kategorije', .)[1])]">
            <!-- Varijabla za stvaranje jedinstvenog identifikatora za svaku kategoriju -->
            <xsl:variable name="id" select="concat(translate(., 'šđčćžŠĐČĆŽ ', 'sdcczSDCCZ_'), '-', position())"/>
            <li>
              <a href="#{$id}" style="color:blue;">
                <span style="color:grey;">
                  <!-- Prikaz abecedne oznake za svaku kategoriju -->
                  <xsl:number format="a. "/>
                </span>
                <xsl:value-of select="."/>
              </a>
            </li>
          </xsl:for-each>
        </ul>
        
        <!-- Prikaz kategorija hrane i njihovih tablica -->
        <xsl:for-each select="tablica_kalorija/vrsta_hrane">
          <!-- Kreiranje jedinstvenog 'id' atributa za h2 element -->
          <xsl:variable name="kategorija" select="../kategorija_namirnice"/>
          <xsl:variable name="id" select="concat(translate($kategorija, 'šđčćžŠĐČĆŽ ', 'sdcczSDCCZ_'), '-', position())"/>
          
          <!-- Prikaz kategorije hrane s jedinstvenim id atributom -->
          <h2 id="{$id}">
            <span style="color:grey;">
              <!-- Prikaz abecedne oznake za svaku kategoriju -->
              <xsl:number format="a. "/>
            </span>
            <xsl:value-of select="$kategorija"/>
          </h2>

          <!-- Tablica za svaku kategoriju -->
          <table>
            <tr>
              <td colspan="2" style="width:400px">Namirnica (100 gr)</td>
              <td>Energija(kJ)</td>
              <td>Energija(kcal)</td>
              <td>UH(g)</td>
              <td>Bjelančevine(g)</td>
              <td>Masti(g)</td>
            </tr>
            
            <!-- Popis namirnica -->
            <xsl:for-each select="namirnica">
              <tr style="background-color: #ddddff">
                <td width="40px">
                  <xsl:number format="1."/>
                </td>
                <td><xsl:value-of select="naziv"/></td>
                <td style="color: blue; font-family:Verdana; font-size:80%; text-align:center;">
                  <xsl:value-of select="energija[@mjera='kJ']"/>
                </td>
                <td style="color: blue; font-family:Verdana; font-size:80%; text-align:center;">
                  <xsl:value-of select="energija[@mjera='kcal']"/>
                </td>
                <td style="color: blue; font-family:Verdana; font-size:80%; text-align:center;">
                  <xsl:value-of select="uh"/>
                </td>
                <td style="color: blue; font-family:Verdana; font-size:80%; text-align:center;">
                  <xsl:value-of select="bjelancevine"/>
                </td>
                <td style="color: blue; font-family:Verdana; font-size:80%; text-align:center;">
                  <xsl:value-of select="masti"/>
                </td>
              </tr>
            </xsl:for-each>
          </table>
          
          <!-- Povratak na početak -->
          <p><a href="#natrag" style="font-size:80%; color:blue; text-decoration:none;">Natrag na popis vrsta hrane</a></p>
        </xsl:for-each>
        
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>

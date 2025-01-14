<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Risek Maja - Kolokvij 1 - 27.11.2024</title>
        <style>
          th { text-align: center; font-weight: bold; }
          td { text-align: left; }
          table, th, td { border: 1px solid black; }
		  th.center, td.center { text-align: center; }		  
        </style>
      </head>
      <body>
        <h1>1. Elementi s parnim atomskim brojem:</h1>
        <table>
          <thead>
            <tr>
              <th>R.BR.</th>
              <th>Ime</th>
              <th>Atom. br</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="periodicna_tabela/atom[atomski_broj mod 2 = 0]">
              <tr>
                <td class="center"><xsl:value-of select="position()"/>.</td>
                <td><xsl:value-of select="ime"/></td>
                <td><xsl:value-of select="atomski_broj"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
        <h1>2. Elementi s rasponom topline fuzije  5 -15:</h1>
        <table>
          <thead>
            <tr>
              <th>R.BR.</th>
              <th>Ime</th>
              <th>Toplina fuzije</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="periodicna_tabela/atom[toplina_fuzije &gt;= 5 and toplina_fuzije &lt;= 15]">
              <tr>
                <td class="center"><xsl:value-of select="position()"/>.</td>
                <td><xsl:value-of select="ime"/></td>
                <td><xsl:value-of select="toplina_fuzije"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
        <h1>3. Elementi s točkom vrenja iznad 2000 K:</h1>
        <table>
          <thead>
            <tr>
              <th>R.BR.</th>
              <th>Ime</th>
              <th>Točka vrenja</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="periodicna_tabela/atom[tocka_vrenja &gt; 2000]">
              <tr>
                <td class="center"><xsl:value-of select="position()"/>.</td>
                <td><xsl:value-of select="ime"/></td>
                <td><xsl:value-of select="tocka_vrenja"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
        <h1>4. Boron - karakteristike:</h1>
        <xsl:for-each select="periodicna_tabela/atom[ime = 'Boron']">
          <table>
            <thead>
              <tr>
                <th>Atribut</th>
                <th>Vrijednost</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="*">
                <tr>
                  <td><xsl:value-of select="name()"/></td>
                  <td><xsl:value-of select="."/></td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
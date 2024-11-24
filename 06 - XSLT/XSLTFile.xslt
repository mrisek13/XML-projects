<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <title>Elementi</title>
        <style>
          td, th { text-align: left; font-size: 16px; }
          th, td { font-weight: bold; }
          table, th, td { border: none; }
		  th.center, td.center { text-align: center; }
          .red { color: red; }
          .blue { color: blue; }
        </style>
      </head>
      <body>
        <h1>1. Svi elementi (crveno=plinovito stanje, plavo=kruto stanje)</h1>
        <xsl:for-each select="periodicna_tabela/atom">
          <div>
            <xsl:choose>
              <xsl:when test="@stanje='plin'">
                <span class="red">
                  <xsl:value-of select="position()"/>. <xsl:value-of select="ime"/>
                </span>
              </xsl:when>
              <xsl:when test="@stanje='kruto'">
                <span class="blue">
                  <xsl:value-of select="position()"/>. <xsl:value-of select="ime"/>
                </span>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="position()"/>. <xsl:value-of select="ime"/>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </xsl:for-each>
        
        <h1>2. Elementi koji imaju stanje plin</h1>
        <xsl:for-each select="periodicna_tabela/atom[@stanje='plin']">
          <div>
            <xsl:value-of select="position()"/>. <xsl:value-of select="ime"/>
          </div>
        </xsl:for-each>
        
        <h1>3. Elementi koji imaju poznatu točku taljenja</h1>
        <xsl:for-each select="periodicna_tabela/atom[tocka_taljenja]">
          <div>
            <xsl:value-of select="position()"/>. <xsl:value-of select="ime"/>
          </div>
        </xsl:for-each>
        
        <h1>4. Popis svih elementa sortiranih po atomskom broju uz ispis atomske mase</h1>
        <table>
          <thead>
            <tr>
              <th>R.BR.</th>
              <th class="center">Element</th>
              <th>Atomski broj</th>
              <th>Atomska težina</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="periodicna_tabela/atom">
              <xsl:sort select="atomski_broj" data-type="number" order="ascending"/>
              <tr>
                <td class="center"><xsl:value-of select="position()"/>.</td>
                <td><xsl:value-of select="ime"/></td>
                <td class="center"><xsl:value-of select="atomski_broj"/></td>
                <td class="center"><xsl:value-of select="atomska_masa"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

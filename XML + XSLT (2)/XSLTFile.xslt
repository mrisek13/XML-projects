<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:key name="kategorije" match="kategorija_namirnice" use="."/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Tablica Kalorija</title>
                <style>
                    table { 
                        width: 60%; 
                        border-collapse: collapse; 
                        border: 2px solid white;
                    }
                    th, td { 
                        border: 2px solid white;
                        text-align: left;
                    }
                    th { background-color: white; }
                    td { height: 14px; }
                    tr:nth-child(even) { background-color: #ffaa00; }
                    tr:nth-child(odd) { background-color: #ffffff; }
                </style>
            </head>
            <body>
                <xsl:for-each select="/tablica_kalorija/vrsta_hrane">
                    <xsl:variable name="currentCategory" select="preceding-sibling::kategorija_namirnice[1]"/>
                    <xsl:if test="$currentCategory != ''">
                        <h2><xsl:value-of select="$currentCategory"/></h2>
                    </xsl:if>

                    <table>
                        <tr>
                            <th>Namirnica (100 gr)</th>
                            <th>Energija (kJ)</th>
                            <th>Energija (kcal)</th>
                            <th>UH (g)</th>
                            <th>Bjelančevine (g)</th>
                            <th>Masti (g)</th>
                        </tr>
                        
                        <xsl:for-each select="namirnica">
                            <tr>
                                <td><xsl:value-of select="naziv"/></td>
                                <td><xsl:value-of select="energija[@mjera='kJ']"/></td>
                                <td><xsl:value-of select="energija[@mjera='kcal']"/></td>
                                <td><xsl:value-of select="uh"/></td>
                                <td><xsl:value-of select="bjelancevine"/></td>
                                <td><xsl:value-of select="masti"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                    
                    <div>
                        Prosječna energija (kcal): 
                        <xsl:value-of select="sum(namirnica/energija[@mjera='kcal']) div count(namirnica)"/>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

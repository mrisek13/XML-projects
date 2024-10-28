<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Zbornik radova</title>
            </head>
            <body>
                <h1>Tablica SADRŽAJ zbornika</h1>
                <table border="1">
                    <tr>
                        <th>R.Br</th>
                        <th>Autor</th>
                        <th>Fakultet/Poduzeće</th>
                        <th>Naslov</th>
                    </tr>
                    <xsl:for-each select="zbornik/sadrzaj/rad">
                        <tr>
                            <td><xsl:value-of select="rb"/>.</td>
                            <td><xsl:value-of select="autor"/></td>
                            <td><xsl:value-of select="fakultetPoduzece"/></td>
                            <td><xsl:value-of select="naslov"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <h1>Tablica PRILOZI zbornika</h1>
                <table border="1">
                    <tr>
                        <th>R.BR</th>
                        <th>Autor</th>
                        <th>Poduzeće/Fakultet</th>
                        <th>Naslov</th>
                    </tr>
                    <xsl:for-each select="zbornik/prilozi/prilog">
                        <tr>
                            <td><xsl:value-of select="rb"/>.</td>
                            <td><xsl:value-of select="autor"/></td>
                            <td><xsl:value-of select="fakultetPoduzece"/></td>
                            <td><xsl:value-of select="naslov"/></td>
                        </tr>
                    </xsl:for-each>
                </table>

                <h2>Popis naslova s više autora</h2>
                <ol>
                    <xsl:for-each select="//rad[drugiAutor]">
                        <li><xsl:value-of select="naslov"/></li>
                    </xsl:for-each>
                </ol>
                
                <h2>Popis naslova s jednim autorom</h2>
                <ol>
                    <xsl:for-each select="//rad[not(drugiAutor)] | //prilog[not(drugiAutor)]">
                        <li><xsl:value-of select="naslov"/></li>
                    </xsl:for-each>
                </ol>

                <h2>Popis fakulteta</h2>
                <ol>
                    <xsl:for-each select="//rad/fakultetPoduzece[contains(translate(., 'FAKULTET', 'fakultet'), 'fakultet')]">
                        <li><xsl:value-of select="." /></li>
                    </xsl:for-each>
                </ol>
                
                <h2>Popis poduzeća</h2>
                <ol>
                    <xsl:for-each select="//rad/fakultetPoduzece[not(contains(translate(., 'FAKULTET', 'fakultet'), 'fakultet'))] | //prilog/fakultetPoduzece">
                        <li><xsl:value-of select="." /></li>
                    </xsl:for-each>
                </ol>                
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

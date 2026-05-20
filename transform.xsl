<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Ключ 1: курсы по преподавателю -->
    <xsl:key name="coursesByTeacher" match="course" use="teachers/teacher"/>

    <!-- Ключ 2: курсы по ключевому слову -->
    <xsl:key name="coursesByKeyword" match="course" use="keywords/keyword"/>

    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Наши курсы</title>
            </head>
            <body>
                <h1>Наши курсы</h1>

                <!-- 1. Курсы Борисова И.О. -->
                <h3>Курсы, которые читает Борисов И.О.</h3>
                <ul>
                    <xsl:for-each select="key('coursesByTeacher', 'Борисов И.О.')">
                        <li><xsl:value-of select="title"/></li>
                    </xsl:for-each>
                </ul>

                <!-- 2. Курсы, где есть тема XML -->
                <h3>Курсы, которые используют XML</h3>
                <ul>
                    <xsl:for-each select="key('coursesByKeyword', 'XML')">
                        <li><xsl:value-of select="title"/></li>
                    </xsl:for-each>
                </ul>

                <!-- 3. Курсы Борисова И.О. с темой XSLT -->
                <h3>Курсы Борисова И.О., в которых есть тема XSLT</h3>
                <ul>
                    <xsl:for-each select="key('coursesByTeacher', 'Борисов И.О.')[keywords/keyword = 'XSLT']">
                        <li><xsl:value-of select="title"/></li>
                    </xsl:for-each>
                </ul>

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>

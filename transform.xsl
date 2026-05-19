<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes" />

  <!-- КЛЮЧИ (обязательное требование задания) -->
  <xsl:key name="by-teacher" match="course" use="teachers/teacher" />
  <xsl:key name="by-keyword" match="course" use="keywords/keyword" />

  <xsl:template match="/">
    <h1>Наши курсы</h1>

    <!-- Блок 1: Борисов И.О. (по ключу by-teacher) -->
    <h3>Курсы, которые читает Борисов И.О.</h3>
    <ul>
      <xsl:for-each select="key('by-teacher', 'Борисов И.О.')">
        <li><xsl:value-of select="title" /></li>
      </xsl:for-each>
    </ul>

    <!-- Блок 2: используют XML (по ключу by-keyword) -->
    <h3>Курсы, которые используют XML</h3>
    <ul>
      <xsl:for-each select="key('by-keyword', 'XML')">
        <li><xsl:value-of select="title" /></li>
      </xsl:for-each>
    </ul>

    <!-- Блок 3: Борисов И.О. + XSLT (сначала ключ, потом фильтр) -->
    <h3>Курсы Борисова И.О., в которых есть тема XSLT</h3>
    <ul>
      <xsl:for-each select="key('by-teacher', 'Борисов И.О.')[keywords/keyword = 'XSLT']">
        <li><xsl:value-of select="title" /></li>
      </xsl:for-each>
    </ul>
  </xsl:template>

</xsl:stylesheet>

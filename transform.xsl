<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes" />

  <!-- ========== 1. Ключ по преподавателю ========== -->
  <xsl:key name="courses-by-teacher" match="course" use="teachers/teacher" />

  <!-- ========== 2. Ключ по ключевому слову (XML) ========== -->
  <xsl:key name="courses-by-keyword" match="course" use="keywords/keyword" />

  <!-- ========== Главный шаблон ========== -->
  <xsl:template match="/">
    <html>
      <body>
        <h1>Наши курсы</h1>

        <!-- ===== БЛОК 1: Борисов И.О. ===== -->
        <xsl:call-template name="block-borisov" />

        <!-- ===== БЛОК 2: используют XML ===== -->
        <xsl:call-template name="block-xml" />

        <!-- ===== БЛОК 3: Борисов И.О. + тема XSLT ===== -->
        <xsl:call-template name="block-borisov-xslt" />

      </body>
    </html>
  </xsl:template>

  <!-- ****************************************************** -->
  <!-- БЛОК 1: Курсы, которые читает Борисов И.О.             -->
  <!-- ****************************************************** -->
  <xsl:template name="block-borisov">
    <h3>Курсы, которые читает Борисов И.О.</h3>
    <ul>
      <xsl:for-each select="//course[generate-id() = generate-id(key('courses-by-teacher', 'Борисов И.О.'))]">
        <li><xsl:value-of select="title" /></li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- ****************************************************** -->
  <!-- БЛОК 2: Курсы, которые используют XML                  -->
  <!-- ****************************************************** -->
  <xsl:template name="block-xml">
    <h3>Курсы, которые используют XML</h3>
    <ul>
      <xsl:for-each select="//course[generate-id() = generate-id(key('courses-by-keyword', 'XML'))]">
        <li><xsl:value-of select="title" /></li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- ****************************************************** -->
  <!-- БЛОК 3: Борисов И.О. + тема XSLT                       -->
  <!-- (сначала ключ по преподавателю, потом фильтр по XSLT)  -->
  <!-- ****************************************************** -->
  <xsl:template name="block-borisov-xslt">
    <h3>Курсы Борисова И.О., в которых есть тема XSLT</h3>
    <ul>
      <!-- берем курсы, которые ведет Борисов -->
      <xsl:for-each select="key('courses-by-teacher', 'Борисов И.О.')">
        <!-- дополнительный фильтр: есть ли keyword XSLT -->
        <xsl:if test="keywords/keyword = 'XSLT'">
          <li><xsl:value-of select="title" /></li>
        </xsl:if>
      </xsl:for-each>
    </ul>
  </xsl:template>

</xsl:stylesheet>

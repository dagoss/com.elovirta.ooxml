<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:dcmitype="http://purl.org/dc/dcmitype/"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:x="com.elovirta.ooxml"
                version="2.0"
                exclude-result-prefixes="x xs opentopic">

  <xsl:template match="/">
    <xsl:variable name="map" select="*[contains(@class, ' map/map ')]/opentopic:map"/>
    <xsl:variable name="bookmeta" select="$map/*[contains(@class, ' map/topicmeta ')]"/>
    <cp:coreProperties>
      <dc:title>
        <xsl:for-each select="$map">
          <xsl:choose>
            <xsl:when test="*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class, ' bookmap/mainbooktitle ')]">
              <xsl:value-of select="normalize-space(*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class, ' bookmap/mainbooktitle ')])"/>
            </xsl:when>
            <xsl:when test="*[contains(@class, ' topic/title ')]">
              <xsl:value-of select="normalize-space(*[contains(@class, ' topic/title ')])"/>
            </xsl:when>
            <xsl:when test="../@title">
              <xsl:value-of select="normalize-space(../@title)"/>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
      </dc:title>
      <dc:subject/>
      <dc:creator/>
      <cp:keywords>
        <xsl:value-of select="$bookmeta/*[contains(@class, ' topic/metadata ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/keyword ')]/normalize-space()"
                      separator=", "/>
      </cp:keywords>
      <dc:description/>
      <cp:lastModifiedBy/>
      <cp:revision>1</cp:revision>
      <dcterms:created xsi:type="dcterms:W3CDTF">
        <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01][Z]')"/>
      </dcterms:created>
      <!--dcterms:modified xsi:type="dcterms:W3CDTF"></dcterms:modified-->
    </cp:coreProperties>
  </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:fixr="http://fixprotocol.io/2020/orchestra/repository" xmlns:dc="http://purl.org/dc/elements/1.1" 
xmlns:sbe="http://fixprotocol.io/2017/sbe" exclude-result-prefixes="fn xs">
	<!-- Enriches datatypes with mappings for Simple Binary Encoding (SBE) -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="fixr:repository">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:copy-of select="fixr:metadata"/>
			<xsl:copy-of select="fixr:codeSets"/>
			<xsl:copy-of select="fixr:abbreviations"/>
			<xsl:apply-templates select="fixr:datatypes"/>
			<xsl:copy-of select="fixr:categories"/>
			<xsl:copy-of select="fixr:sections"/>
			<xsl:copy-of select="fixr:fields"/>
			<xsl:copy-of select="fixr:actors"/>
			<xsl:copy-of select="fixr:components"/>
			<xsl:copy-of select="fixr:groups"/>
			<xsl:copy-of select="fixr:messages"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="fixr:datatypes">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="fixr:datatype">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:copy-of select="fixr:mappedDatatype"/>
			<xsl:choose>
				<xsl:when test="@name='int'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="int" primitiveType="int32"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Length'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="Length" primitiveType="uint32"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='TagNum'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="TagNum" primitiveType="uint16"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='SeqNum'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="SeqNum" primitiveType="uint32"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='NumInGroup'">
				</xsl:when>
				<xsl:when test="@name='DayOfMonth'">
					<fixr:mappedDatatype standard="SBE" minInclusive="1" maxInclusive="31">
						<sbe:type name="DayOfMonth" primitiveType="uint8"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='float'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="float" primitiveType="double"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Qty'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:composite name="Qty">
							<sbe:type name="mantissa" primitiveType="int32"/>
							<sbe:type name="exponent" presence="constant" primitiveType="int8">0</sbe:type>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Price'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:composite name="Price">
							<sbe:type name="mantissa" presence="optional" primitiveType="int64"/>
							<sbe:type name="exponent" presence="constant" primitiveType="int8">-3</sbe:type>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='PriceOffset'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:composite name="PriceOffset">
							<sbe:type name="mantissa" presence="optional" primitiveType="int64"/>
							<sbe:type name="exponent" presence="constant" primitiveType="int8">-3</sbe:type>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Amt'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:composite name="Amt">
							<sbe:type name="mantissa" presence="optional" primitiveType="int64"/>
							<sbe:type name="exponent" presence="constant" primitiveType="int8">-3</sbe:type>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Percentage'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:composite name="Percentage">
							<sbe:type name="mantissa" presence="optional" primitiveType="int32"/>
							<sbe:type name="exponent" presence="constant" primitiveType="int8">2</sbe:type>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='char'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="char" primitiveType="char"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Boolean'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:enum name="Boolean" encodingType="uint8">
							<sbe:validValue name="false">0</sbe:validValue>
							<sbe:validValue name="true">1</sbe:validValue>
						</sbe:enum>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='String'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="String" length="16" primitiveType="char"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='MultipleCharValue'">
					<fixr:mappedDatatype standard="SBE" base="string" builtin="0">
						<sbe:composite name="MultipleCharValue">
							<sbe:type name="length" primitiveType="uint16"/>
							<sbe:type name="varData" length="0" primitiveType="uint8"/>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='MultipleStringValue'">
					<fixr:mappedDatatype standard="SBE" base="string" builtin="0">
						<sbe:composite name="MultipleStringValue">
							<sbe:type name="length" primitiveType="uint16"/>
							<sbe:type name="varData" length="0" primitiveType="uint8"/>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Country'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="Country" length="2" primitiveType="char"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Currency'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="Currency" length="3" primitiveType="char"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Exchange'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="Exchange" length="4" primitiveType="char"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='MonthYear'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:composite name="MonthYear">
							<sbe:type name="year" primitiveType="uint16"/>
							<sbe:type name="month" primitiveType="uint8"/>
							<sbe:type name="day" primitiveType="uint8"/>
							<sbe:type name="week" primitiveType="uint8"/>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='UTCTimestamp'">
					<fixr:mappedDatatype standard="SBE" base="string" parameter='"format": "date-time"' builtin="1">
						<sbe:composite name="UTCTimestamp">
							<sbe:type name="time" primitiveType="uint64"/>
							<sbe:type name="unit" primitiveType="uint8" presence="constant" valueRef="TimeUnit.nanosecond"/>
						</sbe:composite>
						<sbe:enum name="TimeUnit" encodingType="uint8">
							<sbe:validValue name="second">0</sbe:validValue>
							<sbe:validValue name="millisecond">3</sbe:validValue>
							<sbe:validValue name="microsecond">6</sbe:validValue>
							<sbe:validValue name="nanosecond">9</sbe:validValue>
						</sbe:enum>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='UTCTimeOnly'">
					<fixr:mappedDatatype standard="SBE" base="string" builtin="0">
						<sbe:composite name="UTCTimeOnly">
							<sbe:type name="time" primitiveType="uint64"/>
							<sbe:type name="unit" primitiveType="uint8" presence="constant" valueRef="TimeUnit.nanosecond"/>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='UTCDateOnly'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="UTCDateOnly" primitiveType="uint16"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='LocalMktDate'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="LocalMktDate" primitiveType="uint16"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='TZTimeOnly'">
					<fixr:mappedDatatype standard="SBE" base="string" builtin="0">
						<sbe:composite name="TZTimeOnly">
							<sbe:type name="time" primitiveType="uint64"/>
							<sbe:type name="unit" primitiveType="uint8"/>
							<sbe:type name="timezoneHour" primitiveType="int8" minValue="-12" maxValue="14"/>
							<sbe:type name="timezoneMinute" primitiveType="uint8" minValue="0" maxValue="59"/>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='TZTimestamp'">
					<fixr:mappedDatatype standard="SBE" base="string" parameter='"format": "date-time"' builtin="1">
						<sbe:composite name="TZTimestamp">
							<sbe:type name="time" primitiveType="uint64"/>
							<sbe:type name="unit" primitiveType="uint8"/>
							<sbe:type name="timezoneHour" primitiveType="int8" minValue="-12" maxValue="14"/>
							<sbe:type name="timezoneMinute" primitiveType="uint8" maxValue="59"/>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='data'">
					<fixr:mappedDatatype standard="SBE" base="string" builtin="0">
						<sbe:composite name="data">
							<sbe:type name="length" primitiveType="uint16"/>
							<sbe:type name="varData" length="0" primitiveType="uint8"/>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Tenor'">					
				</xsl:when>
				<xsl:when test="@name='Reserved100Plus'">	
				</xsl:when>
				<xsl:when test="@name='Reserved1000Plus'">
				</xsl:when>
				<xsl:when test="@name='Reserved4000Plus'">
				</xsl:when>
				<xsl:when test="@name='XMLData'">
					<fixr:mappedDatatype standard="SBE" base="string" builtin="0">
						<sbe:composite name="XMLData">
							<sbe:type name="length" primitiveType="uint16"/>
							<sbe:type name="varData" length="0" primitiveType="uint8"/>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='Language'">
					<fixr:mappedDatatype standard="SBE">
						<sbe:type name="Language" length="2" primitiveType="char"/>
					</fixr:mappedDatatype>
				</xsl:when>
				<xsl:when test="@name='LocalMktTime'">
					<fixr:mappedDatatype standard="SBE" base="string" builtin="0">
						<sbe:composite name="LocalMktTime">
							<sbe:type name="time" primitiveType="uint64"/>
							<sbe:type name="unit" primitiveType="uint8" presence="constant" valueRef="TimeUnit.nanosecond"/>
						</sbe:composite>
					</fixr:mappedDatatype>
				</xsl:when>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
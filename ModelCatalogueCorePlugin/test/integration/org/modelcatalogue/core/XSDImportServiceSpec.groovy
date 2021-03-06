package org.modelcatalogue.core

import grails.test.spock.IntegrationSpec

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
class XSDImportServiceSpec extends IntegrationSpec {

    def initCatalogueService, XSDImportService

    def "placeholder test"(){

    }


//uncomment locally

//    def "ingest XML schema 1"(){
//
//        setup:
//        initCatalogueService.initCatalogue()
//        def filenameXsd = "test/unit/resources/SACT/SACT_XMLDataTypes-v2-0.xsd" //"test/unit/resources/SACT/SACTSACT_XMLSchema_EXAMPLE2.xsd"
//        InputStream inputStream = new FileInputStream(filenameXsd)
//        XsdLoader parserXSD = new XsdLoader(inputStream)
//        def (topLevelElements, simpleDataTypes, complexDataTypes, schema, namespaces, logErrorsSACT) = parserXSD.parse()
//
//        when:
//
//        XSDImportService.createAll(simpleDataTypes, complexDataTypes, topLevelElements, "SACT", "SACT", schema, namespaces)
//
//        then:
//
//        def filenameXsd2 = "test/unit/resources/SACT/SACTSACT_XMLSchema-v2-0_Nested.xsd" //"test/unit/resources/SACT/SACTSACT_XMLSchema_EXAMPLE2.xsd"
//        InputStream inputStream2 = new FileInputStream(filenameXsd2)
//        XsdLoader parserXSD2 = new XsdLoader(inputStream2)
//        def (topLevelElements2, simpleDataTypes2, complexDataTypes2, schema2, namespaces2, logErrorsSACT2) = parserXSD2.parse()
//
//
//        when:
//
//        XSDImportService.createAll(simpleDataTypes2, complexDataTypes2, topLevelElements2, "SACT", "SACT", schema, namespaces)
//
//        then:
//
//
//
//
//        def cs_NullFlavor = ValueDomain.findByName("cs_NullFlavor")
//        def cs_UpdateMode = ValueDomain.findByName("cs_UpdateMode")
//        def cs_AddressPartType = ValueDomain.findByName("cs_AddressPartType")
//        def cs = ValueDomain.findByName("cs")
//        def ts = ValueDomain.findByName("ts")
//        def valueDomain = ValueDomain.findByNameIlike("value")
//        def cs_UpdateModeType = EnumeratedType.findByName("cs_UpdateMode")
//        def cs_NullFlavorType = EnumeratedType.findByName("cs_NullFlavor")
//
//        def nhsDateModel = Model.findByName("TS.GB-en-NHS.Date")
//        def tsModel = Model.findByName("TS")
//        def ST = Model.findByName("ST")
//        def any = Model.findByName("ANY")
//        def qty = Model.findByName("QTY")
//        def value1 = DataElement.findByNameAndDescription("value","TS.value")
//        def value2 = DataElement.findByNameAndDescription("value","TS.GB-en-NHS.Date.value")
//        def partType1 = DataElement.findByNameAndDescription("partType","ADXP.partType")
//        def partType2 = DataElement.findByNameAndDescription("partType","delimiter.partType")
//        def partType3 = DataElement.findByNameAndDescription("partType","state.partType")
//        def partType4 = DataElement.findByNameAndDescription("partType","streetNameType.partType")
//        def partType5 = DataElement.findByNameAndDescription("partType","desc.partType")
//        def nullFlavor = DataElement.findByName("nullFlavor")
//        def updateMode = DataElement.findByName("updateMode")
//        def adxp = Model.findByName("ADXP")
//        def ad = Model.findByName("AD")
//        def delimiter = Model.findByName("delimiter")
//        def state = Model.findByName("state")
//        def streetNameType = Model.findByName("streetNameType")
//        def desc = Model.findByName("desc")
//
//
//        then:
//
//        cs_NullFlavor
//        cs_UpdateMode
//        cs
//        ts
//        valueDomain
//        cs_UpdateModeType
//        cs_NullFlavorType
//        ad
//        state
//        streetNameType
//        delimiter
//        desc
//
//        cs.dataType.name == "xs:token"
//        ts.dataType.name == "xs:string"
//        cs_UpdateMode.dataType == cs_UpdateModeType
//        cs_NullFlavor.dataType == cs_NullFlavorType
//
//        valueDomain.dataType.name == "xs:string"
//
//        cs_NullFlavor.isBasedOn.contains(cs)
//        cs_UpdateMode.isBasedOn.contains(cs)
//        valueDomain.isBasedOn.contains(ts)
//
//        nhsDateModel
//        tsModel
//        any
//        qty
//        adxp
//
//        nhsDateModel.isBasedOn.contains(tsModel)
//        tsModel.isBasedOn.contains(qty)
//        qty.isBasedOn.contains(any)
//        adxp.contains.contains(nullFlavor)
//        adxp.contains.contains(updateMode)
//        adxp.contains.contains(partType1)
//        adxp.isBasedOn.contains(ST)
//        partType1.valueDomain == cs_AddressPartType
//
//
//        state.contains.contains(partType3)
//        streetNameType.contains.contains(partType4)
//        delimiter.contains.contains(partType2)
//        desc.contains.contains(partType5)
//
//        ad.parentOf.contains(state)
//        ad.parentOf.contains(streetNameType)
//        ad.parentOf.contains(delimiter)
//        ad.parentOf.contains(desc)
//
//
//        value1
//        value2
//        nullFlavor
//        updateMode
//
//        nhsDateModel.contains.contains(value2)
//        nhsDateModel.contains.contains(nullFlavor)
//        nhsDateModel.contains.contains(updateMode)
//
//        tsModel.contains.contains(value1)
//        tsModel.contains.contains(nullFlavor)
//        tsModel.contains.contains(updateMode)
//
//        qty.contains.contains(nullFlavor)
//        qty.contains.contains(updateMode)
//
//        any.contains.contains(nullFlavor)
//        any.contains.contains(updateMode)
//
//        value1.valueDomain == ts
//        value2.valueDomain == valueDomain
//        nullFlavor.valueDomain == cs_NullFlavor
//        updateMode.valueDomain == cs_UpdateMode



//    }



//    def "ingest XML schema 2"(){
//
//        setup:
//        initCatalogueService.initCatalogue()
//        def filenameXsd = "test/unit/resources/SACT/XMLDataTypes.xsd"
//        InputStream inputStream = new FileInputStream(filenameXsd)
//        XsdLoader parserXSD = new XsdLoader(inputStream)
//        def (topLevelElements, simpleDataTypes, complexDataTypes, schema, namespaces, logErrorsSACT) = parserXSD.parse()
//
//        def filenameXsd2 = "test/unit/resources/SACT/Breast_XMLSchema.xsd"
//        InputStream inputStream2 = new FileInputStream(filenameXsd2)
//        XsdLoader parserXSD2 = new XsdLoader(inputStream2)
//        def (topLevelElements2, simpleDataTypes2, complexDataTypes2, schema2, namespaces2, logErrorsSACT2) = parserXSD.parse()
//
//        when:
//
//        XSDImportService.createAll(simpleDataTypes, complexDataTypes, topLevelElements, "SACT", "SACT", schema, namespaces)
//        XSDImportService.createAll(simpleDataTypes2, complexDataTypes2, topLevelElements2, "SACT", "SACT", schema2, namespaces2)
//
////models
//        def SACT = Model.findByName("SACT")
//
//
//
//        def SACTSACTType = Model.findByName("SACTSACTType")
//        def SACTSACTRecordType = Model.findByName("SACTSACTRecordType")
//        def SACTDemographicsAndConsultantType = Model.findByName("SACTDemographicsAndConsultantType")
//
//        def SACTRecord = Model.findByName("SACTRecord")
//        def DemographicsAndConsultant = Model.findByName("DemographicsAndConsultant")
//        def ProgrammeAndRegimen = Model.findByName("ProgrammeAndRegimen")
//        def ClinicalStatus = Model.findByName("ClinicalStatus")
//
////dataElements
//        def NHSNumber = DataElement.findByName("NHSNumber")
//        def NHSNumberStatus = DataElement.findByName("NHSNumberStatus")
//
//        def value1 = DataElement.findByNameAndDescription("NHSNumber","TS.value")
//
//
//
////valueDomains
//        def NHSNumberStatusVal = ValueDomain.findByName("NHSNumberStatus")
//        def cs = ValueDomain.findByName("cs")
//        def valueDomain = ValueDomain.findByNameIlike("value")
//
////dataTypes
//        def NHSNumberStatusEnum = EnumeratedType.findByName("NHSNumberStatus")
//
//
//        then:
//
//        SACT
//        SACTSACTType
//        SACTSACTRecordType
//        SACTDemographicsAndConsultantType
//        NHSNumberStatusEnum
//
//        SACTSACTType.parentOf.contains(SACTRecord)
//        SACTRecord.isBasedOn.contains(SACTSACTRecordType)
//        SACTRecord.parentOf.contains(DemographicsAndConsultant)
//        SACTRecord.parentOf.contains(ProgrammeAndRegimen)
//        SACTRecord.parentOf.contains(ClinicalStatus)
//
//        DemographicsAndConsultant.isBasedOn.contains(SACTDemographicsAndConsultantType)
//        DemographicsAndConsultant.contains.contains(NHSNumber)
//        DemographicsAndConsultant.contains.contains(NHSNumberStatus)
//        NHSNumberStatus.valueDomain == NHSNumberStatusVal
//        NHSNumberStatusVal.dataType == NHSNumberStatusEnum
//
//    }


}

package org.modelcatalogue.gel.export

import org.codehaus.groovy.grails.commons.GrailsApplication
import org.junit.Rule
import org.junit.rules.TemporaryFolder
import org.modelcatalogue.core.*
import org.modelcatalogue.core.export.inventory.DataModelToXlsxExporterSpec
import org.modelcatalogue.core.util.Metadata
import org.modelcatalogue.core.util.builder.DefaultCatalogueBuilder
import org.modelcatalogue.core.util.test.FileOpener
import org.modelcatalogue.integration.xml.CatalogueXmlLoader
import org.modelcatalogue.spreadsheet.query.api.SpreadsheetCriteria
import org.modelcatalogue.spreadsheet.query.poi.PoiSpreadsheetQuery
import spock.lang.Ignore

class GridReportXlsxExporterSpec extends AbstractIntegrationSpec {

    public static final String ROOT_DATA_MODEL_NAME = 'Grid Report Data Model'
    ElementService elementService
    DataModelService dataModelService
    DataClassService dataClassService
    GrailsApplication grailsApplication

    @Rule TemporaryFolder temporaryFolder = new TemporaryFolder()

    DataModel dataModel

    def setup() {
        initRelationshipTypes()
        DefaultCatalogueBuilder builder = new DefaultCatalogueBuilder(dataModelService, elementService)

        CatalogueXmlLoader loader = new CatalogueXmlLoader(builder)
        loader.load(DataModelToXlsxExporterSpec.getResourceAsStream('TestDataModelV1.xml'))
        loader.load(DataModelToXlsxExporterSpec.getResourceAsStream('TestDataModelV2.xml'))
        dataModel = DataModel.findByNameAndSemanticVersion('TestDataModel', '2')

    }
    @Ignore
    def "export model to excel"() {
        setup:
        def file = temporaryFolder.newFile("${System.currentTimeMillis()}.xlsx")

        when:
        GridReportXlsxExporter.create(dataModel, dataClassService, grailsApplication, 5).export(file.newOutputStream())
        FileOpener.open(file)

        SpreadsheetCriteria query = PoiSpreadsheetQuery.FACTORY.forFile(file)

        then:
        noExceptionThrown()
    }
}

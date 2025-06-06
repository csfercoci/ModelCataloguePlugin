package org.modelcatalogue.core.generalTestSuit

import org.modelcatalogue.core.gebUtils.AbstractModelCatalogueGebSpec
import org.modelcatalogue.core.gebUtils.Common
import org.modelcatalogue.core.gebUtils.ScrollDirection
import org.modelcatalogue.core.gebUtils.AbstractModelCatalogueGebSpec
import spock.lang.IgnoreIf
import spock.lang.Stepwise

import static org.modelcatalogue.core.gebUtils.Common.*


@IgnoreIf({ !System.getProperty('geb.env') })
@Stepwise
class CreateMeasurementUnitFromFavouritesSpec extends AbstractModelCatalogueGebSpec {

    private static final String favourite = "a#role_item-detail_favorite-elementBtn"
    private static final String user = "a#role_navigation-right_user-menu-menu-item-link>span:nth-child(1)"
    private static final String favourites_menu = "a#user-favorites-menu-item-link>span:nth-child(3)"
    private static final String Model_Catalogue_ID = "tr.inf-table-header-row>th:nth-child(1)>span"
    private static final String plus_button = "tr.warning>td:nth-child(1)>a:nth-child(1)>span"
    private static final String data_model = "button#role_item_catalogue-elementBtn"
    public static final String measurement_button = "a#catalogue-element-create-measurementUnitBtn>span:nth-child(2)"
    private static final String name = "input#name"
    private static final String symbol = "input#symbol"
    private static final String icon="span.input-group-addon"
    public static final String  search ="input#value"
    private static final String  model_link="tr.inf-table-item-row>td:nth-child(2)>a"
    private static final String  modelCatalogue="span.mc-name"
    private static final String  table="td.col-md-4"
    private static final String  createdMeasurement="td.col-md-4>a"
    private static final String  measurementUnitButton="a#role_item_catalogue-element-menu-item-link>span:nth-child(3)"
    private static final String  deleteButton="a#delete-menu-item-link>span:nth-child(3)"



    def " Login to model catalogue and select a data model"() {
        when:
        loginAdmin()
        select 'Test 3'
        click favourite
        Thread.sleep(2000l)

        then:
        check modelCatalogue displayed
    }

    def "navigate to favourite tag ,click on plus button and click  on data model"() {

        when:
        remove Common.messages
        click user
        Thread.sleep(2000l)
        click favourites_menu

        then:
        check Model_Catalogue_ID displayed


        when: 'click on plus button to expand model'
        click plus_button
        then:
        check data_model displayed

        and: 'click on data model and select measurement'
        click data_model
        scroll(ScrollDirection.DOWN)
        click measurement_button


        then:
        check Common.modalHeader contains('Create Measurement Unit')
    }

    def" create Measurement unit"(){
        when:
        click icon
        Thread.sleep(3000L)
        fill search with("Test 1")
        Thread.sleep(1000L)
         selectInSearch(2)
        Thread.sleep(2000L)
        fill name with("MEASUREMENT FROM FAVOURITE ")
        fill symbol with("kilogram")
        fill Common.modelCatalogueId with("METT-902")
        fill Common.description with(" this is my measurement ${System.currentTimeSeconds()}")
        click Common.save

         then:
         check model_link displayed

 }

    def"delete the created measurement unit"(){

        when:
        click modelCatalogue

        and:
        select 'Test 1'
        selectInTree 'Measurement Units'

        then:
        check Common.rightSideTitle contains 'Active Measurement Units'

        when:
        click createdMeasurement

        and:
        click measurementUnitButton

        and:
        click deleteButton
        click Common.modalPrimaryButton

        then:
        Thread.sleep(2000L)
        check table isGone()

    }

}

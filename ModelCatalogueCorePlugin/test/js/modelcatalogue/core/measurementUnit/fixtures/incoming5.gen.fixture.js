/** Generated automatically from measurementUnit. Do not edit this file manually! */
    (function (window) {
        window['fixtures'] = window['fixtures'] || {};
        var fixtures = window['fixtures']
        fixtures['measurementUnit'] = fixtures['measurementUnit'] || {};
        var measurementUnit = fixtures['measurementUnit']

        window.fixtures.measurementUnit.incoming5 = {
   "total": 11,
   "previous": "/measurementUnit/49/incoming/relationship?max=10&offset=0",
   "page": 10,
   "itemType": "org.modelcatalogue.core.Relationship",
   "listType": "org.modelcatalogue.core.util.Relationships",
   "next": "",
   "list": [{
      "id": 3727,
      "direction": "destinationToSource",
      "removeLink": "/measurementUnit/49/incoming/relationship",
      "relation": {
         "id": 66,
         "outgoingRelationships": {
            "count": 1,
            "itemType": "org.modelcatalogue.core.Relationship",
            "link": "/measurementUnit/66/outgoing"
         },
         "symbol": "°7",
         "description": "test7 mu",
         "name": "test mu7",
         "link": "/measurementUnit/66",
         "elementTypeName": "Measurement Unit",
         "elementType": "org.modelcatalogue.core.MeasurementUnit",
         "incomingRelationships": {
            "count": 0,
            "itemType": "org.modelcatalogue.core.Relationship",
            "link": "/measurementUnit/66/incoming"
         },
         "version": 1
      },
      "type": {
         "id": 3,
         "sourceClass": "org.modelcatalogue.core.CatalogueElement",
         "sourceToDestination": "relates to",
         "destinationClass": "org.modelcatalogue.core.CatalogueElement",
         "name": "relationship",
         "link": "/relationshipType/3",
         "elementTypeName": "Relationship Type",
         "elementType": "org.modelcatalogue.core.RelationshipType",
         "destinationToSource": "is relationship of",
         "version": 0
      }
   }],
   "offset": 10,
   "success": true,
   "size": 1
}

    })(window)
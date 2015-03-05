angular.module('mc.core.ui.states.advancedSearch', ['ui.router', 'mc.util.ui'])
.config(['$stateProvider', 'catalogueProvider', ($stateProvider, catalogueProvider) ->

  $stateProvider.state 'mc.advancedSearch', {
    url: '/advancedSearch'
    templateUrl: 'modelcatalogue/core/ui/state/advancedSearch.html'
    resolve:
      elementClasses: ['$http', 'modelCatalogueApiRoot', ($http, modelCatalogueApiRoot) ->
        $http.get("#{modelCatalogueApiRoot}/relationshipType/elementClasses").then (response) -> response.data
      ]
      relationshipTypes: ['$q', 'catalogueElementResource', ($q, catalogueElementResource) ->
        deferred = $q.defer()
        types = []

        appendToRelationshipTypes = (result) ->
          for type in result.list when not type.bidirectional
            types.push type: type, value: type.sourceToDestination, relation: 'destination',  direction: 'outgoing'
            types.push type: type, value: type.destinationToSource, relation: 'source',       direction: 'incoming'

          if result.next.size > 0
            result.next().then appendToRelationshipTypes
          else
            deferred.resolve types

        catalogueElementResource('relationshipType').list(max: 100).then(appendToRelationshipTypes)

        deferred.promise

      ]

    controller: 'mc.core.ui.states.AdvancedSearchCtrl'

  }
])

.run(['$templateCache', ($templateCache) ->

  $templateCache.put 'modelcatalogue/core/ui/state/advancedSearch.html', '''
    <h2>Advanced Search</h2>
    <h3>Type</h3>
    <div class="btn-group">
        <label title="{{names.getNaturalName(names.getPropertyNameFromType(class))}}" class="btn btn-default" ng-repeat="class in elementClasses" ng-click="selectClass(class)" ng-class="{active: isClassSelected(class)}"><span class="fa-3x text-muted"ng-class="catalogue.getIcon(class)"></span></label>
    </div>
    <h3>
      Criteria
      <div class="btn-group btn-link">
        <button type="button" class="btn btn-link dropdown-toggle" data-toggle="dropdown"><span class="fa fa-fw fa-plus"></span> Add Criterion <span class="caret"></span></button>
        <ul class="dropdown-menu" role="menu">
            <li><a ng-click="addCriterion('property')">Add Property Criterion</a></li>
            <li><a ng-click="addCriterion('metadata')">Add Metadata Criterion</a></li>
            <li><a ng-click="addCriterion('relationship')">Add Relationship Criterion</a></li>
        </ul>
      </div>
    </h3>
    <div class="advanced-search-criteria">
      <div ng-repeat="criterion in criteria" ng-switch="criterion.type">
        <div class="row" ng-switch-when="property">
          <div class="col-md-3">
            <label class="text-muted">Property</label>
            <select class="form-control" ng-options="value for value in ['name', 'description']" ng-model="criterion.property"></select>
          </div>
          <div class="col-md-3">
            <label class="text-muted">Operation</label>
            <select class="form-control col-md-4" ng-options="key as value for (key, value) in operations" ng-model="criterion.operator"></select>
          </div>
          <div class="col-md-6">
            <label class="text-muted">Query</label>
            <input class="form-control col-md-4" type="text" ng-model="criterion.query">
          </div>
        </div>
        <div class="row" ng-switch-when="metadata">
          <div class="col-md-3">
            <label class="text-muted">Metadata</label>
            <input class="form-control col-md-4" type="text" ng-model="criterion.metadata">
          </div>
          <div class="col-md-3">
            <label class="text-muted">Operation</label>
            <select class="form-control col-md-4" ng-options="key as value for (key, value) in operations" ng-model="criterion.operator"></select>
          </div>
          <div class="col-md-6">
            <label class="text-muted">Query</label>
            <input class="form-control col-md-4" type="text" ng-model="criterion.query">
          </div>
        </div>
        <div class="row" ng-switch-when="relationship">
          <div class="col-md-2">
            <label class="text-muted">Relation</label>
            <select class="form-control" ng-options="type.value for type in relationshipTypes" ng-model="criterion.relation"></select>
          </div>
          <div class="col-md-2">
            <label class="text-muted">Property</label>
            <select class="form-control" ng-options="value for value in ['name', 'description']" ng-model="criterion.property"></select>
          </div>
          <div class="col-md-2">
            <label class="text-muted">Operation</label>
            <select class="form-control col-md-4" ng-options="key as value for (key, value) in operations" ng-model="criterion.operator"></select>
          </div>
          <div class="col-md-6">
            <label class="text-muted">Query</label>
            <input class="form-control col-md-4" type="text" ng-model="criterion.query">
          </div>
        </div>
        <hr ng-if="!$last"/>
      </div>
      <div class="row">
        <div class="col-md-12">
          <hr/>
          <button ng-click="search()" class="btn btn-default btn-block btn-lg" ng-disabled="!areCriteriaValid()"><span class="fa fa-fw fa-search"></span> Search</button>
        </div>
      </div>
    </div>
    <div ng-if="!list.empty">
      <h3>Results</h3>
      <infinite-table list="list" columns="columns" />
    </div>

  '''
])


.controller('mc.core.ui.states.AdvancedSearchCtrl', ['$scope', '$stateParams', '$state', 'applicationTitle', 'elementClasses', 'catalogue', 'names', 'relationshipTypes', 'enhance', 'rest', 'modelCatalogueApiRoot', ($scope, $stateParams, $state, applicationTitle, elementClasses, catalogue, names, relationshipTypes, enhance, rest, modelCatalogueApiRoot) ->
    applicationTitle "Advanced Search"

    listEnhancer = enhance.getEnhancer('list')

    $scope.list = listEnhancer.createEmptyList('catalogueElement')

    $scope.elementClasses = elementClasses
    $scope.relationshipTypes = relationshipTypes
    $scope.catalogue = catalogue
    $scope.names = names
    $scope.selectedClass = 'org.modelcatalogue.core.CatalogueElement'
    $scope.operations =
      eq: 'is'
      ne: 'is not'
      ilike: 'contains'
      nilike: 'contains not'

    $scope.properties =
      name: 'Name'
      description: 'Description'

    $scope.criteria = []

    $scope.selectClass = (cls) ->
      $scope.selectedClass = cls

    $scope.isClassSelected = (cls) ->
      $scope.selectedClass == cls

    $scope.addCriterion = (type) ->
      $scope.criteria.push type: type, property: 'name', operator: 'ilike'

    $scope.areCriteriaValid = ->
      $scope.criteria.length > 0


    $scope.search = ->
      enhance(rest(method: 'POST', url: "#{modelCatalogueApiRoot}/advancedSearch", params: {type: $scope.selectedClass}, data: $scope.criteria)).then (list) ->
        list.method = 'POST'
        $scope.list = list
])
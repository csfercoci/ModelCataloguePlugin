describe "mc.core.ui.decoratedListTable", ->

  beforeEach module 'mc.core.catalogueElementResource'
  beforeEach module 'mc.core.modelCatalogueApiRoot'
  beforeEach module 'mc.core.listEnhancer'
  beforeEach module 'mc.core.ui.decoratedListTable'

  it "element get compiled",  inject ($compile, $rootScope, $httpBackend, modelCatalogueApiRoot, catalogueElementResource) ->
    $httpBackend.when("GET", "#{modelCatalogueApiRoot}/valueDomain").respond(fixtures.valueDomain.list2)
    $httpBackend.when("GET", "#{modelCatalogueApiRoot}/valueDomain/?max=5&offset=5").respond(fixtures.valueDomain.list3)
    $httpBackend.when("GET", "#{modelCatalogueApiRoot}/valueDomain/?max=5&offset=0").respond(fixtures.valueDomain.list2)

    valueDomains = catalogueElementResource('valueDomain')

    $rootScope.muList = null

    valueDomains.list().then (response) ->
      $rootScope.muList = response

    $httpBackend.flush()

    $rootScope.columns = [
      {header: 'ID', value: 'id'}
      {header: 'Name', value: (element) -> element.name }
    ]

    element = $compile('''
    <decorated-list-table list="muList" columns="columns"></decorated-list-table>
    ''')($rootScope)

    $rootScope.$digest()


    # table gets dl-table class
    expect(element.prop('tagName').toLowerCase()).toBe('table')
    expect(element.hasClass('dl-table')).toBeTruthy()

    # well formed table head and body with expected classes
    expect(element.find('thead').length).toBe(1)
    expect(element.find('tbody').length).toBe(1)
    expect(element.find('tfoot').length).toBe(1)

    # appropriate rows count with expected classes
    expect(element.find('tr.dl-table-header-row').length).toBe(1)
    expect(element.find('tr.dl-table-item-row').length).toBe(5)

    # appropriate cells with expected classes and content
    expect(element.find('thead tr th.dl-table-header-cell').length).toBe(2)
    expect(element.find('thead tr th.dl-table-header-cell:nth-child(1)').text()).toBe('ID')
    expect(element.find('thead tr th.dl-table-header-cell:nth-child(2)').text()).toBe('Name')

    expect(element.find('tbody tr:first-child td.dl-table-item-cell').length).toBe(2)
    expect(element.find('tbody tr:first-child td.dl-table-item-cell:nth-child(1)').text()).toBe('1')
    expect(element.find('tbody tr:first-child td.dl-table-item-cell:nth-child(2)').text()).toBe('ground_speed')

    expect(element.find('tbody tr:last-child td.dl-table-item-cell').length).toBe(2)
    expect(element.find('tbody tr:last-child td.dl-table-item-cell:nth-child(1)').text()).toBe('5')
    expect(element.find('tbody tr:last-child td.dl-table-item-cell:nth-child(2)').text()).toBe('ground_speed_5')

    # next and previous links
    expect(element.find('a.dl-table-prev.disabled').length).toBe(1)
    expect(element.find('a.dl-table-next:not(.disabled)').length).toBe(1)

    expect($rootScope.muList.offset).toBe(0)

    element.find('a.dl-table-prev.disabled').click()
    expect($rootScope.muList.offset).toBe(0)

    element.find('a.dl-table-next:not(.disabled)').click()
    $httpBackend.flush()
    expect($rootScope.muList.offset).toBe(5)

    element.find('a.dl-table-prev:not(.disabled)').click()
    $httpBackend.flush()
    expect($rootScope.muList.offset).toBe(0)


    # the columns are live
    $rootScope.columns.pop()
    $rootScope.$digest()

    expect(element.find('thead tr th.dl-table-header-cell').length).toBe(1)
    expect(element.find('tbody tr:first-child td.dl-table-item-cell').length).toBe(1)



    element = $compile('''
    <decorated-list-table list="muList"></decorated-list-table>
    ''')($rootScope)
    $rootScope.$digest()

    expect(element.find('thead tr th.dl-table-header-cell').length).toBe(2)
    expect(element.find('tbody tr:first-child td.dl-table-item-cell').length).toBe(2)
    expect(element.find('thead tr th.dl-table-header-cell:first-child').text()).toBe('Name')

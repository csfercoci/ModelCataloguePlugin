package org.modelcatalogue.core

import grails.rest.RestfulController
import org.modelcatalogue.core.query.CatalogueElementQueryBuilder
import org.modelcatalogue.core.util.Lists
import org.springframework.http.HttpMethod

class AdvancedSearchController extends RestfulController<CatalogueElement> {

    AdvancedSearchController() {
        super(CatalogueElement)
    }

    static responseFormats = ['json']

    def search(Integer max, String type) {
        params.max = Math.min(max ?: 10, 100)

        CatalogueElementQueryBuilder builder = CatalogueElementQueryBuilder.create(Class.forName(type) as Class<? extends CatalogueElement>) {
            for (criterion in request.JSON) {
                if (criterion.type == 'property') {
                    property {
                        if (criterion.operator == 'eq') {
                            eq criterion.property, criterion.query
                        } else if (criterion.operator == 'ne') {
                            ne criterion.property, criterion.query
                        } else if (criterion.operator == 'ilike') {
                            ilike criterion.property, '%' + criterion.query + '%'
                        } else if (criterion.operator == 'eq') {
                            not {
                                ilike criterion.property, '%' + criterion.query + '%'
                            }
                        }
                    }
                } else if (criterion.type == 'metadata') {
                    metadata {
                        eq 'name', criterion.metadata
                        if (criterion.operator == 'eq') {
                            eq 'extensionValue', criterion.query
                        } else if (criterion.operator == 'ne') {
                            ne 'extensionValue', criterion.query
                        } else if (criterion.operator == 'ilike') {
                            ilike 'extensionValue', '%' + criterion.query + '%'
                        } else if (criterion.operator == 'eq') {
                            not {
                                ilike 'extensionValue', '%' + criterion.query + '%'
                            }
                        }
                    }
                } else if (criterion.type == 'relationship') {
                    "$criterion.relation.direction"(RelationshipType.readByName(criterion.relation.type.name)) {
                        if (criterion.operator == 'eq') {
                            eq criterion.property, criterion.query
                        } else if (criterion.operator == 'ne') {
                            ne criterion.property, criterion.query
                        } else if (criterion.operator == 'ilike') {
                            ilike criterion.property, '%' + criterion.query + '%'
                        } else if (criterion.operator == 'eq') {
                            not {
                                ilike criterion.property, '%' + criterion.query + '%'
                            }
                        }
                    }
                }
            }
        }

        def result = Lists.wrap(params, "/advancedSearch?type=${type}", Lists.fromCriteria(params, builder.criteria))

        result.method = HttpMethod.POST

        respond result
    }
}

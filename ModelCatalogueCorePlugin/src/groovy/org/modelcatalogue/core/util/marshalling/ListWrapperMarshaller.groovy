package org.modelcatalogue.core.util.marshalling

import org.modelcatalogue.core.reports.ReportsRegistry
import org.springframework.beans.factory.annotation.Autowired

abstract class ListWrapperMarshaller extends AbstractMarshallers {

    @Autowired ReportsRegistry reportsRegistry

    ListWrapperMarshaller(Class cls) {
        super(cls)
    }

    @Override
    protected Map<String, Object> prepareJsonMap(Object elements) {
        def ret = [
                base: elements.base,
                itemType: elements.itemType?.name,
                success: true,
                total: elements.total,
                offset: elements.offset,
                page: elements.page,
                size: elements.items.size(),
                list: elements.items,
                previous: elements.previous,
                next: elements.next,
                availableReports: getAvailableReports(elements),
                sort: elements.sort,
                order: elements.order,
        ]
        if (ret.hasProperty('method')) {
            ret.method = elements.method?.toString()
        }
        ret
    }
}

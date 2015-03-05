package org.modelcatalogue.core.util

import org.springframework.http.HttpMethod

interface ListWrapper<T> extends ListWithTotalAndType<T> {

    String getBase()
    String getNext()
    String getPrevious()
    String getSort()
    String getOrder()
    int getPage() // max
    int getOffset()

    HttpMethod getMethod()
    void setMethod(HttpMethod method)

}

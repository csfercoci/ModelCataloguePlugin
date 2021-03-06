package org.modelcatalogue.core.util.marshalling

import org.codehaus.groovy.grails.web.mapping.LinkGenerator
import org.modelcatalogue.core.Asset
import org.springframework.beans.factory.annotation.Autowired

class AssetMarshaller extends CatalogueElementMarshallers {

    @Autowired LinkGenerator linkGenerator

    AssetMarshaller() {
        super(Asset)
    }

    protected Map<String, Object> prepareJsonMap(el) {
        if (!el) return [:]
        def ret = super.prepareJsonMap(el)
        ret.putAll(
                contentType: el.contentType,
                originalFileName: el.originalFileName,
                size: el.size,
                md5: el.md5
        )
        if (el.md5) {
            ret.downloadUrl = linkGenerator.link(controller: 'asset', action: 'download', id: el.id, absolute: true)
        }
        ret
    }

}





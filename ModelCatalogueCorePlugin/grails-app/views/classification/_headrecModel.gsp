<%@ page import="org.modelcatalogue.core.EnumeratedType" %>
<g:if test="${models}">
    <ul style="list-style-type:none" class="list-group">
        <g:each status="j" in="${models}" var="model">
            <li class="list-item">
                <h4>${(index)}.${(j+1)} ${model.name}

            </li>
        </g:each>
    </ul>
</g:if>
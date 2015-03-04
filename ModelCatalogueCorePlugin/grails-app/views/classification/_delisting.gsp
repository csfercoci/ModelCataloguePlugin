<%@ page import="org.modelcatalogue.core.EnumeratedType" %>
<g:if test="${models}">
        <g:each status="j" in="${models}" var="model">
                <h4>${model.name}</h4>
                <p>${model.description}</p>

                <g:if test="${model.contains}">
                    <mc:relationships element="${model}" var="relationship" direction="outgoing" type="containment">
                        <div>
                            <div>
                                <h3><div id="${relationship?.destination?.id}">  ${relationship?.destination?.name} (GE${relationship?.destination?.id}) </div> </h3>
                            </div>
                            <div>
                                <p>${relationship.destination.description}</p>

                                <p><strong>Value Domain</strong></p>

                                <g:if test="${relationship?.destination?.valueDomain}">
                                    <div>
                                        %{--<g:each in="${relationship.destination?.valueDomain?.classifications}" var="cls">--}%
                                    <g:if test="${relationship?.destination?.valueDomain?.classifications[0]}"> <span class="pull-right">${relationship?.destination?.valueDomain?.classifications[0].name}</span></g:if>
                                        %{--</g:each>--}%
                                        <p><strong>${relationship?.destination?.valueDomain?.name}</strong>
                                            <g:if test="${relationship?.destination?.valueDomain?.description!=relationship?.destination?.description}">
                                                - ${relationship?.destination?.valueDomain?.description}
                                            </g:if>
                                        </p>
                                        <g:if test="${relationship.destination?.valueDomain.dataType instanceof EnumeratedType}">
                                        %{--<p>${relationship.destination.valueDomain.dataType.prettyPrint()}</p>--}%
                                            <table class="table table-striped">
                                                <thead>
                                                <tr>
                                                    <th width="200">Code</th>
                                                    <th width="200">Description</th>
                                                </tr>
                                                </thead>
                                                <g:each in="${relationship?.destination?.valueDomain?.dataType?.enumerations}" var="key, value">

                                                    <tr><td>${key}</td><td>${value}</td></tr>


                                                </g:each>
                                            </table>
                                        </g:if>
                                        <g:else>

                                            <g:if test="${relationship.destination?.valueDomain?.dataType?.name}">(${relationship.destination?.valueDomain?.dataType?.name})</g:if>
                                            <g:if test="${relationship.destination?.valueDomain?.dataType?.description}">(${relationship.destination?.valueDomain?.dataType?.description})</g:if>
                                            <g:if test="${relationship.destination?.valueDomain?.rule}"><p> Format: <code>${relationship.destination?.valueDomain?.rule}</code></p></g:if>
                                            <g:if test="${relationship.destination?.valueDomain?.unitOfMeasure?.name}">(${relationship.destination?.valueDomain?.unitOfMeasure?.name})</g:if>
                                            <g:if test="${relationship.destination?.valueDomain?.unitOfMeasure?.symbol}">(${relationship.destination?.valueDomain?.unitOfMeasure?.symbol})</g:if>
                                        </g:else>

                                    %{--<g:if test="${relationship.destination?.valueDomain?.dataType?.enumerations}">--}%
                                    %{--<g:each in="${relationship.destination.valueDomain.dataType?.enumerations}" var="en">--}%
                                    %{--<p>${en}</p>--}%
                                    %{--</g:each>--}%
                                    %{--</g:if>--}%



                                    </div>
                                </g:if>

                                <g:each in="${relationship.destination.isSynonymFor}" var="synonym">
                                    <p> This element is the same as <strong> ${synonym.name} (${synonym.ext.get("Data Item No")})</strong> in the ${synonym.containedIn[0].name} section of the ${synonym.classifications[0].name} data set
                                    </p>
                                </g:each>

                            </div>
                        </div>
                    </mc:relationships>
                </g:if>



                <g:if test="${model?.parentOf}"> <g:render template="delisting" model="${[models: model.parentOf, index: (index + "." + (j+1))]}"/></g:if>

        </g:each>
</g:if>
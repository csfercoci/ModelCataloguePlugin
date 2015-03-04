<%@ page import="org.modelcatalogue.core.EnumeratedType" %>
<g:if test="${models}">
    <ul style="list-style-type:none" class="list-group">
        <g:each status="j" in="${models}" var="model">
            <li class="list-item">
                <div id="${model.id}">
                <h${j+2}> ${model.name}</h${j+2}
                ></div>
            <p>${model.description}</p>



            <g:if test="${model.contains}">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th width="100">Name</th>
                        <th width="200">Description</th>
                        <th width="50">Reference</th>
                        <th width="50">Value Domain</th>
                        <th width="100">Same As</th>
                        %{--<th width="200">Datatype</th>--}%
                        %{--<th width="400">Allowed Valued</th>--}%
                        %{--<th width="30">Min Repeat</th>--}%
                        %{--<th width="30">Min Repeat</th>--}%
                    </tr>
                    </thead>
                    <tbody>
                    <mc:relationships element="${model}" var="relationship" direction="outgoing" type="containment">
                        <tr >
                            <td width="100"><a href="#${relationship.destination.id}">${relationship.destination.name}</a></td>
                            <td width="200">${relationship.destination.description}</td>
                            <td width="50">GE${relationship.destination.id}</td>
                            <td width="50">${relationship.destination.valueDomain.name}</td>
                            <td width="100">
                            <g:each in="${relationship.destination.isSynonymFor}" var="synonym">
                                <g:if test="${synonym.classifications[0].name!="Genomics England Forms" && synonym.classifications[0].name!="Rare Diseases" && synonym.classifications[0].name!="Cancer"}">
                                ${synonym.name} (${synonym.ext.get("Data Item No")}) from ${synonym.classifications[0].name}</g:if>
                            </g:each>
                            </td>
                            %{--<g:if test="${relationship.destination.valueDomain?.dataType}">--}%
                            %{--<td width="200">${relationship.destination.valueDomain.dataType.name}</td>--}%
                            %{--</g:if>--}%
                            %{--<g:else>--}%
                            %{--<td width="200">No Datatype defined</td>--}%
                            %{--</g:else>--}%

                            %{--<g:else>--}%
                            %{--<td width="400">${relationship.destination.valueDomain.dataType.description}</td>--}%
                            %{--</g:else>--}%
                            %{--<td width="30">${relationship.ext['Min Occurs']}</td>--}%
                            %{--<td width="30">${relationship.ext['Max Occurs']}</td>--}%
                        </tr>
                    </mc:relationships>
                    </tbody>
                </table>
            </g:if>



            <g:if test="${model?.parentOf}"> <g:render template="linkedModel" model="${[models: model.parentOf, index: j+1]}"/></g:if>
            </li>
        </g:each>
    </ul>
</g:if>
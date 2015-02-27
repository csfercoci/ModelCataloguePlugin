<%@ page import="org.modelcatalogue.core.EnumeratedType" %>
<g:if test="${models}">
    <ul style="list-style-type:none" class="list-group">
        <g:each status="j" in="${models}" var="model">
            <li class="list-item">
                <div id="${model.id}"><h4>${(index)}.${(j+1)}  ${model.name}</h4></div> <span class="badge">${model.id}</span><small><span class="badge pull-right">v${model.versionNumber}</span><span class="label label-info pull-right">${model.status}</span></small></h3></h4>
            <p>${model.description}</p>



            <g:if test="${model.contains}">
                <h4>Data Elements</h4>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th width="200">Name</th>
                        <th width="400">Description</th>
                        <th width="400">Model Catalogue Reference</th>
                        %{--<th width="200">Datatype</th>--}%
                        %{--<th width="400">Allowed Valued</th>--}%
                        %{--<th width="30">Min Repeat</th>--}%
                        %{--<th width="30">Min Repeat</th>--}%
                    </tr>
                    </thead>
                    <tbody>
                    <mc:relationships element="${model}" var="relationship" direction="outgoing" type="containment">
                        <tr >
                            <td width="200"><a href="#${relationship.destination.id}">${relationship.destination.name}</a></td>
                            <td width="400">${relationship.destination.description}</td>
                            <td width="400">${relationship.destination.id}</td>
                            %{--<g:if test="${relationship.destination.valueDomain?.dataType}">--}%
                            %{--<td width="200">${relationship.destination.valueDomain.dataType.name}</td>--}%
                            %{--</g:if>--}%
                            %{--<g:else>--}%
                            %{--<td width="200">No Datatype defined</td>--}%
                            %{--</g:else>--}%
                            %{--<g:if test="${relationship.destination.valueDomain.dataType instanceof EnumeratedType}">--}%
                            %{--<td width="400">${relationship.destination.valueDomain.dataType.prettyPrint()}</td>--}%
                            %{--</g:if>--}%
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



            <g:if test="${model?.parentOf}"> <g:render template="linkedModel" model="${[models: model.parentOf, index: (index + "." + (j+1))]}"/></g:if>
            </li>
        </g:each>
    </ul>
</g:if>
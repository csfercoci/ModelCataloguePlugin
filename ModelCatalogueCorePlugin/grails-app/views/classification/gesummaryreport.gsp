<%--
  Created by IntelliJ IDEA.
  User: david
  Date: 26/02/15
  Time: 13:13
--%>

<%@ page import="org.modelcatalogue.core.EnumeratedType; org.modelcatalogue.core.DataType; org.modelcatalogue.core.MeasurementUnit; org.modelcatalogue.core.ValueDomain; org.modelcatalogue.core.DataElement; org.modelcatalogue.core.Model; grails.util.Environment;grails.util.GrailsNameUtils" contentType="text/html;charset=UTF-8" defaultCodec="none" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Classification Summary Report</title>
    <g:if test="${Environment.current in [Environment.PRODUCTION, Environment.TEST, Environment.CUSTOM]}">
        <!-- CDNs -->
        <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.2.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css">

    </g:if>
    <g:else>
        <asset:stylesheet href="bootstrap/dist/css/bootstrap.css"/>
        <asset:stylesheet href="font-awesome/css/font-awesome"/>
        <asset:stylesheet href="modelcatalogue.css"/>
    </g:else>

</head>

<body>
<div>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="panel-heading"><h3>DATA ELEMENT LISTING</h3></div>
                <h3> Table of Contents</h3>
                <g:each status="i" in="${classification.classifies.findAll{it in Model}}" var="model1">
                    <ul>
                       <li>
                            <!--g:if test="!${model1.childOf}"-->
                           <g:if test="!${model1.childOf}">
                                <h3><a href="#${model1.id}">${i+1}. ${model1.name}</a><small><span class="badge">${model1.id}</span><span class="badge pull-right">v${model1.versionNumber}</span></small></h3>
                            </g:if>
                       </li>
                    </ul>
                </g:each>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-12">

            </br>
            </br>
            </br>
             <g:each status="i" in="${classification.classifies.findAll{it in Model}}" var="model">
                    <g:if test="!${model.childOf}">
                        <div id="${model.id}"><h3>${i+1}. ${model.name}  </div><small><span class="badge">${model.id}</span><span class="badge pull-right">v${model.versionNumber}</span> <span class="label label-info pull-right">${model.status}</span></small></div></h3>
                        <p>${model.description}</p>
                        <g:render template="linkedModel" model="${[models: model, index:i+1]}" />
                    </g:if>
                </g:each>
            </div>
        </div>
    </div>
<div class="container">
    <div class="row">
    <div class="col-md-12">
        <div class="panel-heading"><h3>DATA ELEMENT LISTING</h3></div>
    </br>
    </br>
    </br>
        <g:each status="i" in="${classification.classifies.findAll{it in Model}}" var="model">
            <g:if test="!${model.childOf}">
                <g:render template="delisting" model="${[models: model.parentOf, index:i+1]}" />
            </g:if>
        </g:each>
    </div>
    </div>
</div>
</div>
</div>
%{--<script type="application/javascript">--}%
%{--window.print()--}%
%{--</script>--}%
</body>
</html>
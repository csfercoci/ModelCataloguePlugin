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

            </br>
            </br>
            </br>
             <g:each status="i" in="${classification.classifies.findAll{it in Model}}" var="model">
                    <g:if test="!${model.childOf}">
                        <div id="${model.id}">
                            <h${i+1}>${model.name}  </div></div></h${i+1}>
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
        <div class="panel-heading"><h1>DATA ELEMENT DETAIL</h1></div>
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
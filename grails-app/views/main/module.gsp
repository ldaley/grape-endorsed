<html>
    <head>
        <title>Module - ${module}</title>
        <meta name="layout" content="main"></meta>
        <script type="text/javascript" charset="utf-8">
            function init () {
                <g:if test="${module?.hasErrors()}">
                    i = $("moduleDetailsForm").getInputs("text").find(function(it) { return it.hasClassName("error") });
                    if (i) i.focus();
                </g:if>
                <g:if test="${moduleVersion?.hasErrors()}">
                    i = $("registerVersionForm").getInputs("text").find(function(it) { return it.hasClassName("error") });
                    if (i) { i.focus(); }
                </g:if>
            }
        </script>
    </head>
    <body class="module" onload="init();">
        <h1>${module}</h1>
        <div id="moduleDetails">
            <g:form action="module" params="[module: module]" name="moduleDetailsForm">
                <fieldset>
                    <legend>Details</legend>
                    <g:if test="${module.hasErrors()}">
                        <div class="error">
                            <g:renderErrors bean="${module}" as="list" />
                        </div>
                    </g:if>
                    <label for="name" class="clearfix">Name</label>
                    <g:textField name="name" value="${fieldValue(bean:module,field:'name')}" class="text ${hasErrors(bean: module, field: 'name', ' error')}" />
                    <label for="org" class="clearfix">Organisation</label>
                    <g:textField name="org" value="${fieldValue(bean:module,field:'org')}" class="text ${hasErrors(bean: module, field: 'org', ' error')}" />
                    <p class="buttons">
                        <g:submitButton name="update" value="Update" />
                        <g:submitButton name="delete" value="Delete" onclick="return confirm('You are about to delete this module!');"/>
                    </p>
                </fieldset>
            </g:form>
        </div>
        <g:set var="unmappedGroovies" value="${module.unmappedGroovies}" />
        <g:if test="${unmappedGroovies}">
            <div class="unmappedGrooviesDiv">
                <fieldset>
                    <legend>Unmapped Groovy Versions</legend>
                    <ul>
                        <g:each var="groovy" in="${module.unmappedGroovies}">
                            <li>${groovy}</li>
                        </g:each>
                    </ul>
                    <caption>These versions of Groovy have no endorsed version of this module specified.</caption>
                </fieldset>
            </div>
        </g:if>
        <g:if test="${module.versions}">
            <div id="moduleVersionsDiv">
                <fieldset>
                    <legend>Versions</legend>
                    <g:render template="/main/moduleVersionsTable" bean="${module}" />
                </fieldset>
            </div>
        </g:if>
        <div id="newModuleVersionDiv"></div>
            <fieldset>
                <legend>Register Version</legend>
                <g:form name="registerVersionForm" action="module" params="[module: module.name]">
                <g:if test="${moduleVersion?.hasErrors()}">
                    <div class="error">
                        <g:renderErrors bean="${moduleVersion}" as="list" />
                    </div>
                </g:if>
                    <g:textField name="tag" value="${fieldValue(bean: moduleVersion, field: 'tag')}" class="${hasErrors(bean: moduleVersion, field: 'tag', ' error ')} text"/>
                    <p class="buttons">
                        <g:submitButton name="moduleVersion" value="Register" />
                    </p>
                </g:form>
            </fieldset>
        </div>
    </body>
</html>
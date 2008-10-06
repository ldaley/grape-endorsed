<html>
    <head>
        <title>An Example Page</title>
        <meta name="layout" content="main"></meta>
    </head>
    <body class="moduleInfo">
        <g:if test="${moduleVersion?.hasErrors()}">
            <div class="errors">
                <g:renderErrors bean="${moduleVersion}" as="list" />
            </div>
        </g:if>
        <div id="moduleDiv">
            <h1>${module.name}</h1>
        </div>
        <div id="deleteDiv">
            <g:form name="deleteForm" action="module" params="[module: module.name]">
                <g:submitButton name="delete" value="Delete" />
            </g:form>
        </div>
        <div id="organisationDiv">
            <h2>Organisation</h2>
            <p>${module.org}</p>
        </div>
        <div id="versionsDiv">
            <h2>Versions</h2>
            <g:render template="/main/moduleVersionsTable" bean="${module}" />
        </div>
        <div id="moduleVersionRegistrationDiv">
            <g:form name="registerVersion" action="module" params="[module: module.name]">
                <table class="registration">
                        <tr>
                            <td style="vertical-align: middle; text-align: right; width: 9em">Register Version:</td>
                            <td class="${hasErrors(bean: moduleVersion, field: 'tag', 'errors')}"><g:textField name="tag" value="${fieldValue(bean: moduleVersion, field: 'tag')}" class="${hasErrors(bean: moduleVersion, field: 'tag', 'errors')}"/></td>
                        </tr>
                </table>
            </g:form>
        </div>
        <g:set var="unmappedGroovies" value="${module.unmappedGroovies}" />
        <g:if test="${unmappedGroovies}">
        <div id="unmappedGroovyVersions">
            <h2>Unmapped Groovy Versions</h2>
            <ul>
                <g:each var="groovy" in="${module.unmappedGroovies}">
                    <li>${groovy}</li>
                </g:each>
            </ul>
        </div>
        </g:if>
        

        <div><g:link action="list">List all modules</g:link></div>
    </body>
</html>
<html>
    <head>
        <title>Module - ${module}</title>
        <meta name="layout" content="main"></meta>
    </head>
    <body>
        <h1>${module}</h1>
        <div id="moduleDetails">
            <g:form action="module" params="[module: module]" method=GET>
                <fieldset>
                    <legend>Module Details</legend>
                    <label for="name" class="clearfix">Name</label>
                    <g:textField name="name" value="${module.name}" class="text" />
                    <label for="org" class="clearfix">Organisation</label>
                    <g:textField name="org" value="${module.org}" class="text" />
                    <p class="buttons">
                        <button type="submit" class="button positive">Update</button>
                        <button type="submit" class="button negative">Delete</button>
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
        <div id="versionsDiv">
            <fieldset>
                <legend>Module Versions</legend>
                <g:render template="/main/moduleVersionsTable" bean="${module}" />
                <div id="moduleVersionRegistrationDiv" class="x">
                    <g:form name="registerVersion" action="module" params="[module: module.name]">
                    <g:if test="${moduleVersion?.hasErrors()}">
                        <div class="error">
                            <g:renderErrors bean="${moduleVersion}" as="list" />
                        </div>
                    </g:if>
                        <label for="moduleVersion" class="clearfix">New Module Version</label>
                        <g:textField name="tag" value="${fieldValue(bean: moduleVersion, field: 'tag')}" class="${hasErrors(bean: moduleVersion, field: 'tag', 'errors')} text"/>
                    </g:form>
                </div>
            </fieldset>
        </div>
    </body>
</html>
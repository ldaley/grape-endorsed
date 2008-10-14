<html>
    <head>
        <title>Grape Endorsed Modules</title>
        <script type="text/javascript" charset="utf-8">
            function init () {
                
                searchDiv = "${(showModules) ? 'moduleRegistration' : 'groovyRegistration'}";
                defaultInput = "${(showModules) ? 'moduleNameFilter' : 'groovyTagFilter'}";
                ($(searchDiv).getInputs("text").find(function(it) { return it.hasClassName("error") }) || $(defaultInput)).focus();
            }
                    
            function updateModuleTable (field) {
                var url = "<g:createLink action='list' />";
                new Ajax.Updater('moduleTable', url, { 
                    method: 'get', 
                    parameters: {
                        name: "%" + $('nameFilter').value + "%",
                        template: 'moduleTable'
                    },
                    onComplete: function(){
                        $(field).focus();
                      }
                    
                });
            }
            function changeDisplayed (selector) {
                if (selector.value == 'Groovy Versions') {
                    $('modulesDiv').hide();
                    $('groovyVersionsDiv').show();
                } else if (selector.value == 'Modules') {
                    $('groovyVersionsDiv').hide();
                    $('modulesDiv').show();
                }
            
            }
        </script>
        <meta name="layout" content="main"></meta>
    </head>
    <body onload="init();">
        <h1>Grape Endorsed Modules</h1>
        <div id="selector">
            <fieldset>
                <label>Show:</label>&nbsp;
                <g:select name="selector" value="${(showModules) ? 'Modules' : 'Groovy Versions'}" from="${['Modules', 'Groovy Versions']}" onchange="changeDisplayed(this);"/>
            </fieldset>
        </div>
        <div id="modulesDiv" style="${(showModules) ? '' : 'display: none;'}">
            <div id="moduleRegistrationDiv">
                <fieldset>
                    <legend>Register</legend>
                    <g:if test="${module?.hasErrors()}">
                        <div class="error">
                            <g:renderErrors bean="${module}" as="list" />
                        </div>
                    </g:if>
                    <g:form name="moduleRegistration" action="list">
                        <g:each var="field" in="['name', 'org']">
                            <label for="${field}" class="clearfix">${org.apache.commons.lang.StringUtils.capitalize(field)}:</label>
                            <g:textField name="${field}" value="${fieldValue(bean:module,field:field)}" class="text ${hasErrors(bean: module, field: field, ' error')}" />
                        </g:each>
                        <p class="buttons">
                            <g:submitButton name="register" value="Register" />
                        </p>
                    </g:form>
                </fieldset>
            </div>
            <div id="modulesSearchDiv">
                <fieldset>
                    <legend>Search</legend>
                    <div id="moduleFilterDiv">
                        <form onsubmit="updateModuleTable('nameFilter'); return false;">
                            <g:textField name="nameFilter" value="${name}" class="text"/>
                        </form>
                    </div>
                    <div id="moduleTable">
                        <g:render template="moduleTable" model="[modules: null]" />
                    </div>
                </fieldset>
            </div>
        </div>
        <div id="groovyVersionsDiv" style="${(showModules) ? 'display: none;' : '' }">
            <div id="GroovyRegistrationDiv">
                <fieldset>
                    <legend>Register</legend>
                    <g:if test="${groovy?.hasErrors()}">
                        <div class="error">
                            <g:renderErrors bean="${groovy}" as="list" />
                        </div>
                    </g:if>
                    <g:form name="groovyRegistration" action="list">
                            <label for="tag" class="clearfix">Version Number:</label>
                            <g:textField name="tag" value="${fieldValue(bean:groovy,field:'tag')}" class="text ${hasErrors(bean: groovy, field: 'tag', ' error')}" />
                            <label for="copyVersion" class="clearfix">Copy Endorsements From:</label>
                            <g:select name="copyVersion" value="${groovies.sort()[-1]}" from="${groovies}" />
                        <p class="buttons">
                            <g:submitButton name="registerGroovy" value="Register" />
                        </p>
                    </g:form>
                </fieldset>
            </div>
            <div id="groovySearchDiv">
                <fieldset>
                    <legend>Search</legend>
                    <div id="groovyFilterDiv">
                        <form onsubmit="updateModuleTable('nameFilter'); return false;">
                            <g:textField name="nameFilter" value="${name}" class="text"/>
                        </form>
                    </div>
                    <div id="moduleTable">
                        <g:render template="moduleTable" model="[modules: null]" />
                    </div>
                </fieldset>
            </div>
        </div>
    </body>
</html>
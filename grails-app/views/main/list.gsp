<html>
    <head>
        <title>An Example Page</title>
        <script type="text/javascript" charset="utf-8">
            function init () {
                ($("moduleRegistration").getInputs("text").find(function(it) { return it.hasClassName("errors") }) || $("nameFilter")).focus();
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
        </script>
        <meta name="layout" content="main"></meta>
    </head>
    <body onload="init();">
        <div id="moduleRegistrationDiv">
            <h2>Register Module</h2>
            <g:if test="${module?.hasErrors()}">
                <div class="errors">
                    <g:renderErrors bean="${module}" as="list" />
                </div>
            </g:if>
            <g:form name="moduleRegistration" action="list">
                <table class="">
                    <g:each var="field" in="['name', 'org']">
                        <tr>
                            <td style="vertical-align: middle; text-align: right;">${org.apache.commons.lang.StringUtils.capitalize(field)}:</td>
                            <td class="${hasErrors(bean: module, field: field, 'errors')}"><g:textField name="${field}" value="${fieldValue(bean: module, field: field)}" class="${hasErrors(bean: module, field: field, 'errors')}"/></td>
                            <td width="100%" style="vertical-align: middle;">
                                <g:hasErrors bean="${module}" field="${field}">
                                    <img src="${createLinkTo(dir:'images',file:'skin/exclamation.png')}" />
                                </g:hasErrors>
                            </td>
                        </tr>
                    </g:each>
                </table>
                <g:submitButton name="register" value="Register" />
            </g:form>
        </div>
        <div id="modules">
            <h2>Modules</h2>
            <div>
                <form onsubmit="updateModuleTable('nameFilter'); return false;">
                    Filter: <g:textField name="nameFilter" value="${name}" />
                </form>
            </div>
            <div id="moduleTable">
                <g:render template="moduleTable" model="[modules: modules]" />
            </div>
        </div>
    </body>
</html>
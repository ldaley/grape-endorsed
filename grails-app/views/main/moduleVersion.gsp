<html>
    <head>
        <title>An Example Page</title>
        <meta name="layout" content="main"></meta>
        <script type="text/javascript" charset="utf-8">
            function init () {
                i = $("moduleVersionForm").getInputs("text").find(function(it) { return it.hasClassName("error") });
                if (i) i.focus();
            }

            function toggleAssociation (checkbox, moduleVersion, groovy, associatedTo) {
                
                msg = "You are about to " + ((checkbox.checked) ? 'set' : 'unset') + " version " + moduleVersion + " as the endorsed version of '${moduleVersion.module.name}' for groovy " + groovy + ".";
                if (checkbox.checked && associatedTo != 'null') {
                    msg += "\n\nThe current endorsed version of this module for this version of groovy is " + associatedTo + "."
                }
                if (confirm(msg)) {
                    checkbox.form.submit();
                } else {
                    checkbox.checked = !checkbox.checked;
                }
            }
        </script>
    </head>
    <body class="moduleVersion" onload="init();">
        <h1>${moduleVersion.module}-${moduleVersion}</h1>
        <div id="moduleVersionDetails">
            <g:form action="moduleVersion" params="[module: moduleVersion.module, moduleVersion: moduleVersion]" name="moduleVersionForm">
                <fieldset>
                    <legend>Module Version Details</legend>
                    <g:if test="${moduleVersion.hasErrors()}">
                        <div class="error">
                            <g:renderErrors bean="${moduleVersion}" as="list" />
                        </div>
                    </g:if>
                    <label for="tag" class="clearfix">Version Number</label>
                    <g:textField name="tag" value="${fieldValue(bean:moduleVersion,field:'tag')}" class="text ${hasErrors(bean: moduleVersion, field: 'tag', ' error')}" />
                    <p class="buttons">
                        <g:submitButton name="update" value="Update" />
                        <g:submitButton name="delete" value="Delete" onclick="return confirm('You are about to delete this module version!');"/>
                    </p>
                </fieldset>
            </g:form>
        </div>
        <div id="ivyDescriptor">
            <fieldset>
                <legend>Ivy Descriptor</legend>
                <pre id="descriptor">${moduleVersion.ivyDescriptor.encodeAsHTML()}</pre>
            </fieldset>
        </div>
        <div id="groovyVersions">
            <fieldset>
                <legend>Groovy Versions</legend>
                <table>
                    <tr><th>Endorsed?</th><th>Groovy</th></tr>
                    <g:each in="${groovies}" var="groovy">
                        <g:set var="endorsedVersion" value="${moduleVersion.module[groovy.tag]}" />
                        <tr class="${(endorsedForGroovy == groovy.tag) ? 'added' : ''} ${(unendorsedForGroovy == groovy.tag) ? 'removed' : ''}">
                            <td class="checkbox">
                                <g:form name="${groovy}Form" action="moduleVersion" params="[module: moduleVersion.module, moduleVersion: moduleVersion]">
                                <g:hiddenField name="groovyAssociation" value="${groovy}" />
                                    <g:checkBox name="endorsedVersion" value="${endorsedVersion == moduleVersion}" onclick="toggleAssociation(this, '${moduleVersion}', '${groovy}', '${endorsedVersion?.tag}')"/>
                                </g:form>
                                
                            </td>
                            
                            <td class="version">
                                <g:link controller="groovy" action="show" params="[groovy: groovy.tag]">${groovy}</g:link>
                                <g:if test="${endorsedVersion && (endorsedVersion != moduleVersion)}">
                                    <span class="small">(current endorsed module version is <strong>${endorsedVersion})<strong></span>
                                </g:if>
                            </td>
                        </tr>
                    </g:each>
                </table>
            </fieldset>
        </div>
    </body>
</html>
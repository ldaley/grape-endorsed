<html>
    <head>
        <title>An Example Page</title>
        <meta name="layout" content="main"></meta>
        <script type="text/javascript" charset="utf-8">
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
    <body class="moduleVersion">
        <h1>${moduleVersion.module}-${moduleVersion}</h1>
        <div id="moduleVersionDetails">
            <g:form action="moduleVersion" params="[module: moduleVersion.module, moduleVersion: moduleVersion]">
                <fieldset>
                    <legend>Module Version Details</legend>
                    <label for="name" class="clearfix">Version Number</label>
                    <g:textField name="name" value="${moduleVersion.tag}" class="text" />
                    <p class="buttons">
                        <button type="submit" class="button positive">Update</button>
                        <button type="submit" class="button negative">Delete</button>
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
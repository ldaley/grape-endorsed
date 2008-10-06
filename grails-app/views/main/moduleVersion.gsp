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
        <style type="text/css" media="screen">
            #moduleVersionGroovyAssociations .checkbox {
                width: 1em;
            }
            #moduleVersionGroovyAssociations .currentlyAssociated {
                color: red;
                font-size: 9px;
            }
        </style>
    </head>
    <body class="moduleVersionInfo">
        <div id="module">
            <h1><g:link action="module" params="[module: moduleVersion.module.name]">${moduleVersion.module.name}</g:link></h1>
        </div>
        <div id="version">
            <h2>Version</h2>
            <p>${moduleVersion.tag}</p>
        </div>
        <div id="ivyDescriptor">
            <h2>Ivy Descriptor</h2>
            <pre id="descriptor">${moduleVersion.ivyDescriptor.encodeAsHTML()}</pre>
        </div>
        <div id="groovyVersions">
            <h2>Groovy Versions</h2>
            <ul>
                <table id="moduleVersionGroovyAssociations">
                    <g:each in="${groovies}" var="groovy">
                        <g:set var="endorsedVersion" value="${moduleVersion.module[groovy.tag]}" />
                        <tr>
                            <td class="checkbox">
                                <g:form name="${groovy}Form" action="moduleVersion" params="[module: moduleVersion.module, moduleVersion: moduleVersion]">
                                <g:hiddenField name="groovyAssociation" value="${groovy}" />
                                    <g:checkBox name="endorsedVersion" value="${endorsedVersion == moduleVersion}" onclick="toggleAssociation(this, '${moduleVersion}', '${groovy}', '${endorsedVersion?.tag}')"/>
                                </g:form>
                            </td>
                            <td class="version">
                                <g:link controller="groovy" action="show" params="[groovy: groovy.tag]">${groovy}</g:link>
                                <g:if test="${endorsedVersion && (endorsedVersion != moduleVersion)}">
                                   <span class="currentlyAssociated">(currently endorsed version is ${endorsedVersion})</span>
                                </g:if>
                            </td>
                        </tr>
                    </g:each>
                </table>
            </ul>
        </div>
    </body>
</html>
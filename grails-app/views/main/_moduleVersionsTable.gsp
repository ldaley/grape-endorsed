<table class="moduleVersions">
    <tr><th>Version</th><th>Groovy Versions</th></tr>
    <g:each var="version" in="${it.versions.sort()}">
        <tr onclick="window.location = '<g:createLink controller="main" action="moduleVersion" params="[module: it.name, moduleVersion: version.tag]" />'">
            <td class="version">
                ${version.tag}
            </td>
            <td class="groovies">
                <% 
                    tags = version.groovies.sort()*.tag.collect { tag ->
                        "<a href=\"${createLink(controller: 'groovy', action: 'show', params: [groovy: tag])}\">${tag}</a>" 
                    }
                %>
                ${tags.join(', ')}
            </td>
        </tr>
    </g:each>
</table>
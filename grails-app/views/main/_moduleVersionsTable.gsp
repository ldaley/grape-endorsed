<table class="moduleVersionListing">
    <tr><th>Version</th><th>Groovy Versions</th></tr>
    <g:each var="version" in="${it.versions.sort()}">
        <tr>
            <td class="version">
                <g:link controller="main" action="moduleVersion" params="[module: it.name, moduleVersion: version.tag]">${version.tag}</g:link>
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
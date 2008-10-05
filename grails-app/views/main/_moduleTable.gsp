<table>
    <tr><th>Name</th><th>Org</th></tr>
    <g:each var="module" in="${modules}">
        <tr>
            <td class="moduleName"><g:link controller="main" action="module" params="[module: module.name]">${module.name}</g:link></td>
            <td>${module.org}</td>
        </tr>
    </g:each>
</table>
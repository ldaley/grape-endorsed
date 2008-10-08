<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'screen.css')}" type="text/css" media="screen, projection">
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'print.css')}" type="text/css" media="print">    
        <!–[if IE]><link rel="stylesheet" href="${createLinkTo(dir:'css',file:'ie.css')}" type="text/css" media="screen, projection"><![endif]–>
        <g:layoutHead />
        <g:javascript library="application" />
        <g:javascript library="prototype" />
    </head>
    <body onload="${pageProperty(name:'body.onload')}" class="${pageProperty(name:'body.class')}">
        <div class="container">
            <g:layoutBody />
            <div>
                [ <g:link controller="main", action="list">Home</g:link> ]
                <g:each in="${footerLinks}">
                    [ <a href="${it.value}">${it.key}</a> ]
                </g:each>
            </div>
        </div> 
        
    </body>
    
</html>
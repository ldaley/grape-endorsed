import org.codehaus.groovy.grails.commons.GrailsApplication
import grails.util.GrailsUtil

class DomainBootStrap {
 
    def fixtureLoader
    
    def init = { servletContext ->
        if (GrailsUtil.environment == GrailsApplication.ENV_DEVELOPMENT) {
            fixtureLoader.load("dev")
        }
    }
    
    def destroy = {}
    
}
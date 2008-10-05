import org.codehaus.groovy.grails.commons.GrailsApplication
import grails.util.GrailsUtil

class DomainBootStrap {

    def init = { servletContext ->
        if (GrailsUtil.environment == GrailsApplication.ENV_DEVELOPMENT) {
            def g15 = new Groovy(tag: "1.5", released: new Date())
            def g151 = new Groovy(tag: "1.5.1", released: new Date())
                        
            def m1 = new Module(name: "module1", org: "org1")
            def m1v1 = new ModuleVersion(module: m1, tag: "1", groovies: [g15])
            def m1v2 = new ModuleVersion(module: m1, tag: "2", groovies: [g151])
            
            def m2 = new Module(name: "module2", org: "org1")
            def m2v1 = new ModuleVersion(module: m2, tag: "1", groovies: [g15])
            def m2v2 = new ModuleVersion(module: m2, tag: "2", groovies: [g151])

            def m3 = new Module(name: "module3", org: "org2")
            def m3v1 = new ModuleVersion(module: m3, tag: "1", groovies: [g15, g151])
            
            def m4 = new Module(name: "module4", org: "org2")
            def m4v1 = new ModuleVersion(module: m4, tag: "1", groovies: [g151])
            
            [
                g15, g151, 
                m1, m1v1, m1v2, 
                m2, m2v1, m2v2,
                m3, m3v1,
                m4, m4v1
            ].each { it.save() }
        }
    }
    
    def destroy = {}
    
}
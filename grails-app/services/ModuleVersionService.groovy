class ModuleVersionService {

    def moduleService
    def groovyService
    
    def getAt(Module mod, String tag) {

        def mv = ModuleVersion.createCriteria().get {
            and {
                eq("tag", tag)
                module {
                    eq("name", mod.name)
                }
            }
        }
        
        
        if (mv) {
            return mv
        } else {
            throw new ModuleVersionNotFoundException(mod.name, tag)
        }
    }

    def getAt(Module mod, Groovy gvy) {

        def mv = ModuleVersion.createCriteria().get {
            and {
                groovies {
                    eq("tag", gvy.tag)
                }
                module {
                    eq("name", mod.name)
                }
            }
        }
        
        
        if (mv) {
            return mv
        } else {
            throw new ModuleVersionForGroovyVersionNotFoundException(mod.name, gvy.tag)
        }
    }

    def setAsEndorsedVersion(moduleVersion, groovy) {
        def groovy = (groovy instanceof Groovy) ? groovy : groovyService[groovy]
        def existingEndorsedVersion = moduleVersion.module[groovy.tag]
        if (existingEndorsedVersion) {
            existingEndorsedVersion.removeFromGroovies(groovy)
        }
        moduleVersion.addToGroovies(groovy)
    }

    def unsetAsEndorsedVersion(moduleVersion, groovy) {
        def groovy = (groovy instanceof Groovy) ? groovy : groovyService[groovy]
        moduleVersion.removeFromGroovies(groovy)
    }

}
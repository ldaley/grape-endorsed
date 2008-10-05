class ModuleService {

    def find() {
        find([:])
    }
    
    def find(params) {
        
        def orgName = params.org
        def groovy = params.groovy
        def name = params.name
        
        Module.withCriteria {
            if ([orgName,groovy,name].findAll {it != null}) {
                and {
                    if (name != null) ilike("name", "${name}")
                    if (groovy != null) versions {
                        groovies { eq("tag", groovy) }
                    }
                    if (orgName != null) ilike("org", "%${orgName}%")
                }
            }
            order("name")
        }
    }
    
    def getAt(String name) {
        def m = Module.findByName(name)
        if (m) {
            return m
        } else {
            throw new ModuleNotFoundException(name)
        }
    }
}
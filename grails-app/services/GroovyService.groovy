class GroovyService {
    
    def getAt(String groovy) {
        def g = Groovy.findByTag(groovy)
        if (g) {
            return g
        } else {
            throw new BadGroovyVersionException(groovy)
        }
    }

}
class GroovyService {
    
    def getAt(String groovy) {
        def g = Groovy.findByTag(groovy)
        log.debug "aaa"
        if (g) {
            return g
        } else {
            throw new BadGroovyVersionException(groovy)
        }
    }

}
class GroovyService {
    
    def getAt(String groovy) {
        def g = Groovy.findByTag(groovy)
        if (g) {
            return g
        } else {
            throw new BadGroovyVersionException(groovy)
        }
    }

    def register(tag, copyEndorsementsFrom) {
        def copyFrom = this[copyEndorsementsFrom]
        def groovy = new Groovy(tag: tag)
        if (!groovy.hasErrors() && groovy.save()) {
            copyFrom.moduleVersions.each {
                it.groovies << groovy
                it.save()
            }
        }
        return groovy
    }
}
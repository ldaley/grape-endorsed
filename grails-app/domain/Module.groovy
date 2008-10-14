class Module implements Comparable {

    static hasMany = [versions: ModuleVersion]
    String name
    String org
    
    static constraints = {
        name(unique: true, nullable: false, blank: false, matches: /^\p{Alpha}.*/)
        org(nullable: false, blank: false)
    }
    
    def getAt(String groovy) {
        this.versions.find {
            it.groovies.find { it.tag == groovy } != null
        }
    }
    
    int compareTo(o) {
        this.name <=> o.name 
    }
    
    String toString() {
        name
    }
    
    def getUnmappedGroovies() {
        Groovy.getAll().findAll { groovy ->
            groovy.moduleVersions.find { it.module == this } == null
        }
    }
}

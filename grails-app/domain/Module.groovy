class Module implements Comparable {

    static hasMany = [versions: ModuleVersion]
    String name
    String org
    
    static constraints = {
        name(nullable: false, blank: false, matches: /^\p{Alpha}.*/)
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
    
}

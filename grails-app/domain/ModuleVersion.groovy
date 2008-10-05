class ModuleVersion implements Comparable {
    static hasMany = [groovies: Groovy]
    static belongsTo = Module
    Module module
    String tag
    
    def getIvyDescriptor() {
        def writer = new StringWriter()
        def xml = new groovy.xml.MarkupBuilder(writer)
        xml."ivy-module"(version:"2.0") {
            info(
                organisation: "groovy-endorsed", 
                module: module.name, 
            )
            dependencies {
                dependency(name: module.name, org: module.org, revision: tag)
            }
        }
        writer.toString()
    }
    
    int compareTo(o) {
        this.tag <=> o.tag 
    }
    
    def isVersionFor(groovy) {
        def target = (groovy instanceof Groovy) ? groovy.tag : groovy as String 
        groovies.find { it.tag == target } != null
    }
    
    String toString() {
        tag
    }
}
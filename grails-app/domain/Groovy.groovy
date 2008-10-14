class Groovy implements Comparable {
    
    static constraints = {
        tag(unique: true, nullable: false, blank: false, matches: /^\d.*/)
    }
    
    static belongsTo = ModuleVersion
    static hasMany = [moduleVersions: ModuleVersion]
    String tag
    
    int compareTo(o) {
        this.tag <=> o.tag 
    }
    
    String toString() {
        tag
    }
}

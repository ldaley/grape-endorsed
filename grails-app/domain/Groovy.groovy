class Groovy implements Comparable {
    static belongsTo = ModuleVersion
    static hasMany = [moduleVersions: ModuleVersion]
    String tag
    Date released
    
    int compareTo(o) {
        this.tag <=> o.tag 
    }
    
    String toString() {
        tag
    }
}

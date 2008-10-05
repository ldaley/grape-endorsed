class BadGroovyVersionException extends RuntimeException {

    def tag
    
    BadGroovyVersionException(tag) {
        super("'$tag' is not a valid Groovy version" as String)
        this.tag = tag
    }
}
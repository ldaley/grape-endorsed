class ModuleNotFoundException extends RuntimeException {

    def name
    
    ModuleNotFoundException(name) {
        super("'$name' is not a registered module" as String)
        this.name = name
    }
}
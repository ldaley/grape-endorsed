class ModuleVersionNotFoundException extends RuntimeException {

    def module
    def tag
    
    ModuleVersionNotFoundException(module, tag) {
        super("'$tag' is not a registered version of module '$module'" as String)
        this.module = module
        this.tag = tag
    }
}
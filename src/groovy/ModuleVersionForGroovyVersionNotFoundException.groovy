class ModuleVersionForGroovyVersionNotFoundException extends RuntimeException {

    def module
    def groovy
    
    ModuleVersionForGroovyVersionNotFoundException(module, groovy) {
        super("No version of module '$module' is registered for groovy version '$groovy'" as String)
        this.module = module
        this.groovy = groovy
    }
}
class ModuleVersionServiceTests extends GroovyTestCase {

    def moduleVersionService
    
    void testGetAt() {
        def modules = ["x", "y"].collect {
            new Module(name: it, org: it)
        }
        modules*.save(flush: true)
        
        modules.each { module ->
            ["1", "2"].each {
                new ModuleVersion(module: module, tag: it).save(flush: true)
            }
        }
        
        def x2 = moduleVersionService[modules[0], "2"]
        assertNotNull(x2)
        assertEquals("x", x2.module.name)
        assertEquals("2", x2.tag)
        
        shouldFail(ModuleVersionNotFoundException) {
            moduleVersionService[modules[1], "3"]
        }
    }
}
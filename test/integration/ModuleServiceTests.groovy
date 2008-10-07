class ModuleServiceTests extends GroovyTestCase {

    def moduleService
    
    void testGetAt() {
        ["x", "y"].each {
            assertNotNull("saving module $it", new Module(name: it, org: it).save(flush: true))
        }
        def x = moduleService["x"]
        assertNotNull(x)
        assertEquals("x", x.name)
        shouldFail(ModuleNotFoundException) {
            moduleService["z"]
        }
    }
}
class GroovyServiceTests extends GroovyTestCase {

    def groovyService
    
    void testGetAt() {
        [new Groovy(tag: "1.0", released: new Date()), new Groovy(tag: "1.1", released: new Date())]*.save(flush:true)
        
        def f = groovyService["1.0"]
        assertNotNull(f)
        assertEquals("1.0", f.tag)
        shouldFail(BadGroovyVersionException) {
            assertNull(groovyService["xxx"])
        }
    }
}

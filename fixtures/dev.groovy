beans {
    g15(Groovy) {
        tag = "1.5"
    }
    g151(Groovy) {
        tag = "1.51"
    }
    
    m1(Module) {
        name = "module1"
        org = "org1"
    }
    m1v1(ModuleVersion) {
        module = m1
        tag = "1.0"
        groovies = [g151]
    }
    m1v2(ModuleVersion) {
        module = m1
        tag = "2.0"
        groovies = [g151]
    }

    m2(Module) {
        name = "module2"
        org = "org1"
    }
    m2v1(ModuleVersion) {
        module = m2
        tag = "1.0"
        groovies = [g151]
    }
    m2v2(ModuleVersion) {
        module = m2
        tag = "2.0"
        groovies = [g151]
    }

    m3(Module) {
        name = "module3"
        org = "org2"
    }
    m3v1(ModuleVersion) {
        module = m3
        tag = "1.0"
        groovies = [g15, g151]
    }

    m4(Module) {
        name = "module4"
        org = "org2"
    }    
    m4v1(ModuleVersion) {
        module = m4
        tag = "1.0"
        groovies = [g151]
    }
}
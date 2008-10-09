class MainController {

    def groovyService
    def moduleService
    def moduleVersionService
    
    def defaultAction = "list"
    
    def module = {
        if (!params.module) redirect(action: "list")
        def model = [module: moduleService[params.module]]
        params.module = null

        if (request.post) {
            if (params.delete) {
                model.module.delete(flush:true)
                flash.notice = "module '${model.module.name}' deleted"
                redirect(uri: "/")
            } else if (params.update) {
                def oldName = model.module.name
                model.module.name = params.name
                model.module.org = params.org
                if (!model.module.hasErrors() && model.module.save()) {
                    flash.success = "Details Updated"
                    if (oldName != model.module.name)
                        redirect(action: "module", params: [module: model.module.name])
                } else {
                    model.module.refresh()
                }
            } else if (params.moduleVersion) {
                def moduleVersion = new ModuleVersion(tag: params.tag, module: model.module)
                if (!moduleVersion.hasErrors() && moduleVersion.save()) {
                    flash.success = "version '${params.tag}' registered"
                    redirect(action: "moduleVersion", params: [module: model.module.name, moduleVersion: moduleVersion.tag])
                } else {
                    model.moduleVersion = moduleVersion
                }
            }
        }
        
        model
    }
    
    def moduleVersion = { 
        
        def module = moduleService[params.module]

        def moduleVersion
        if (params.moduleVersion) {
            moduleVersion = moduleVersionService[module, params.moduleVersion]
        } else if (params.groovy) {
            moduleVersion = moduleVersionService[module, groovyService[params.groovy]]
        }
        
        def model = [
            moduleVersion: moduleVersion, 
            groovies: Groovy.findAll(),
            footerLinks: ["Parent Module": createLink(action: "module", params: [module: moduleVersion.module])]
        ]

        if (request.post) {
            if (params.groovyAssociation) {
                if (params.endorsedVersion) {
                    moduleVersionService.setAsEndorsedVersion(moduleVersion, params.groovyAssociation)
                    model.endorsedForGroovy = params.groovyAssociation
                } else {
                    moduleVersionService.unsetAsEndorsedVersion(moduleVersion, params.groovyAssociation)
                    model.unendorsedForGroovy = params.groovyAssociation
                }
            }
        }
        
        model
    }
    
    def ivy = {        
        def module = moduleService[params.module]

        def moduleVersion
        if (params.groovy) {
            moduleVersion = module[groovyService[params.groovy].tag]
        } else if (params.moduleVersion) {
            moduleVersion = moduleVersionService[module, params.moduleVersion]
        }
        
        response.contentType = "text/plain"
        render moduleVersion.ivyDescriptor
    }
    
    def list = {
        def model = [:]
        if (request.post) {
            if (params.cancel) redirect(action: "list")
            def module = new Module(params)
            if (!module.hasErrors() && module.save()) {
                redirect(action: "show", params: [module: module.name])
            } else {
                model.module = module
            }
        } else {
            model.modules = moduleService.find(name: params.name, org: params.org, groovy: params.groovy)
            if (params.template) {
                render(template: params.template, model: model)
            } else {
                return model
            }
        }
        
        model.modules = moduleService.find()
        return model
    }
}
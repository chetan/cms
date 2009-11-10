
module MyApp
    
    class ContentController < Pixelcop::Web::BaseController
                
        def index()
            
            path = @request.path
            if path =~ %r|content/(index)?(.*)| then
                @id = $2
            end
            @id = "4ae74ab1b79335f243000001" if @id.blank?
            
            
            # find some bit of content
            @text = Pixelcop::CMS::Text.load({ :id => @id })
            
            render("content.erb")
            
        end
        
        def edit()
           
            path = @request.path
            if path !~ %r|edit/(.*)| then
                # TODO raise error
            end
            @id = $1
           
            # show edit page
            @text = Pixelcop::CMS::Text.load({ :id => @id })
            
            render("content_edit.erb")
           
        end
        
        def update()
           
            path = @request.path
            if path !~ %r|update/(.*)| then
                # TODO raise error
            end
            @id = $1
           
            # show edit page
            puts @id
            @text = Pixelcop::CMS::Text.load({ :id => @id })
            
            puts @text.id
            @text.name = @request["name"]
            @text.body = @request["body"]
            @text.save
            puts @text.id
            
            render("content.erb")
           
        end
        
    end # ContentController
    
end # end MyApp

module MyApp
    
    class ContentController < Pixelcop::Web::BaseController
              
        # display content list 
        def index()
            
            # check if we got passed an id
            path = @request.path
            if path =~ %r{content/(index/?)?(.+)} then
                @id = $2
                return view()
            end            
            
            # list all content
            @content_list = Pixelcop::CMS::Text.find()        
            render("content_list.erb")
            
        end
        
        # display a specific bit of content
        def view
            
            if @id.blank? then
                path = @request.path
                if path !~ %r{content/view/(.+)} then
                    # TODO raise error
                end 
                @id = $1
            end
            
            # find some bit of content
            @text = Pixelcop::CMS::Text.load({ :id => @id })
            
            render("content.erb")

        end
        
        # show create form (same as edit)
        def create
            render("content_edit.erb")
        end
        
        # show edit form
        def edit
           
            path = @request.path
            if path !~ %r{edit/(.+)} then
                # TODO raise error
            end
            @id = $1
           
            # show edit page
            @text = Pixelcop::CMS::Text.load({ :id => @id })
            
            render("content_edit.erb")
           
        end
        
        # save changes
        def update
           
            path = @request.path
            if path !~ %r{update/(.+)} then
                # TODO raise error
            end
            @id = $1
           
            # show edit page
            if @id.blank? then
                @text = Pixelcop::CMS::Text.new
            else
                @text = Pixelcop::CMS::Text.load({ :id => @id })
            end
            
            @text.name = @request["name"]
            @text.body = @request["body"]
            @text.save

            # TODO redirect
            render("content.erb")
           
        end
        
    end # ContentController
    
end # end MyApp
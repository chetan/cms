
require "monkey"
require "cms"
require "web"

require "cms/mongo_setup"
require "cms/web/route"

require "test/unit"

class Route_Test < Test::Unit::TestCase
    
    def teardown
        Pixelcop::Web::Route.collection.drop
        Pixelcop::Web::Route.collection = nil
    end
    
    def test_save_route
       
        route = Pixelcop::Web::Route.new("/world", "MyApp::HelloWorldController", "index")
        assert_nil(route.id)
        route.save
        assert_not_nil(route.id)        
        return route
    end
    
    def test_load_route
        route = test_save_route
        # now try to load it
        loaded = Pixelcop::Web::Route.load(route.id)
        assert_not_nil(loaded)
    end
    
    def test_save_prettyroute
        route = Pixelcop::Web::PrettyRoute.new("/:controller/:action", "MyApp")
        route.save
    end
    
end
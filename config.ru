require 'dashing'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN_KAI'
  set :default_dashboard, 'kai'
  set :outboard_file, 'https://raw.githubusercontent.com/mirrorspock/kaitelligence/master/widgets/outboard/outboard.txt'  
  
  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application


require 'roby'
require 'roby/distributed'
require 'optparse'
require 'utilrb/readline'
require 'rock/webapp/syskit/app_client' 
require 'rock/webapp/syskit/roby_app_interface'

module Rock
    module WebApp
        module Syskit
            
            class API < Grape::API
                version 'v1', using: :header, vendor: :rock
                format :json
                
                syskit_url = "localhost:#{Roby::Distributed::DEFAULT_DROBY_PORT}"
                interface = RobyAppInterface.new(syskit_url) 

                resource :actions do
                    
                    desc "Lists all tasks that are currently reachable on the name services"
                    get do
                        interface.get_actions
                    end
                    
                    post ':action/start' do
                        puts "start #{params.values_at('action')}"
                        puts request.params.pretty_inspect
                        mparams = MultiJson.load(request.params["value"])
                        interface.start_action(params[:action],mparams)
                    end
                        
                     
                end
                
                resource :jobs do
                    
                    desc "Lists all tasks that are currently reachable on the name services"
                    get do
                        interface.get_jobs
                    end 
                end
                resource :msg do
                    
                    desc "Lists all tasks that are currently reachable on the name services"
                    get do
                        interface.get_messages
                    end 
                end
                
                resource :reload_actions do
                    
                    desc "Lists all tasks that are currently reachable on the name services"
                    get do
                        interface.reload_actions
                    end 
                end
                
                             
            end    
        end 
    end
end
   


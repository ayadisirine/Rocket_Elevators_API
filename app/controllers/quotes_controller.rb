class QuotesController < ApplicationController
    # skip_before_action :verify_authenticity_token
    require 'rake'
    Rails.application.load_tasks
    def create
        
      puts params
      quotes = Quote.new
      quotes.building_type = params[:building_type]
      quotes.number_of_apartments = params[:number_of_apartments]
      quotes.number_of_floors = params[:number_of_floors]
      quotes.number_of_elevators = params[:number_of_elevators]
      quotes.number_of_basements = params[:number_of_basements]
      quotes.maximum_occupancy = params[:maximum_occupancy]
      quotes.product_line = params[:product_line]
      quotes.elevators_required = params[:elevators_required]
      quotes.elevator_amount = params[:elevator_amount]
      quotes.elevator_unit_price = params[:elevator_unit_price]
      quotes.elevator_total_price = params[:elevator_total_price]
      quotes.elevator_installation_fees = params[:elevator_installation_fees]
      quotes.final_price = params[:final_price]
      quotes.company_name = params[:company_name]
      quotes.email = params[:email]
      # quotes.assign_attributes(quotes_params)
      $companyName = quotes.company_name
      quotes.save!
      
      if quotes.save
        redirect_to '/dropbox/auth'
        load File.join(Rails.root, 'lib', 'tasks', 'sync.rake')
        Rake::Task['warehouse:sync'].execute
      end
    end

    def auth
      url = authenticator.authorize_url :redirect_uri => redirect_uri
                
      redirect_to url
    end
            
    def auth_callback
        auth_bearer = authenticator.get_token(params[:code],
        :redirect_uri => redirect_uri)
        token = auth_bearer.token
        folders = DropboxApi::Client.new(token).create_folder "/" + $companyName + ""
    end
    
    private
    
    def authenticator
        client_id = "ax4aqcxipgidq04"
        client_secret = "msnz2fqng37mhpc"
            
        DropboxApi::Authenticator.new(client_id, client_secret)
    end
            
    def redirect_uri
        dropbox_auth_callback_url
    end

    def quotes_
      render '/pages/quote'
    end

    def show
      redirect_to '/admin/quote'
    end

end

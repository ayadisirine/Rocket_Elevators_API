require Rails.root.join('lib','rails_admin','map.rb')
RailsAdmin.config do |config|

  ### Popular gems integration

  RailsAdmin.config do |config|
       #config Google map 
   config.model Address do
    edit do
      field :latitude, :map do
        longitude_field :longitude
        google_api_key 'AIzaSyCeKrWjY27iJdFKVh1Sat1SBknwXV3OBoI'
        default_latitude -104.984853
        default_longitude -104.984853
      end
    end
  end 
   config.authenticate_with do
     warden.authenticate! scope: :user
   end

   config.current_user_method(&:current_user)
  end
  ## == CancanCan ==
  config.authorize_with :cancancan

  config.navigation_static_label = "Visualization"
  config.navigation_static_links = {
    'Charts' => '/blazer'
  }


  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app 
    map

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end

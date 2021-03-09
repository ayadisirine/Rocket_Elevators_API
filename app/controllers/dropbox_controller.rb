class DropboxController < ApplicationController         
    def auth_callback
        client_id = ENV['DROPBOX_ID']
        client_secret = ENV['DROPBOX_SECRET']

        DropboxApi::Authenticator.new(client_id, client_secret)
        folders = DropboxApi::Client.new(ENV['DROPBOX_TOKEN']).create_folder "/" + $company_name + ""
        redirect_to '/'
    end
end
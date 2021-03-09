class DropboxController < ApplicationController         
    def auth_callback
        client = DropboxApi::Client.new(ENV['DROPBOX_TOKEN'])
        client_id = ENV['DROPBOX_ID']
        client_secret = ENV['DROPBOX_SECRET']

        path = "/" + $company_name + ""
        file = IO.read File.join(Rails.root, 'public', $attachment.to_s)

        attachment_path = $attachment.to_s
        new_path = attachment_path.partition('/uploads/lead/attachment/').last
        new_path2 = path + "/" + new_path.partition('/').last

        DropboxApi::Authenticator.new(client_id, client_secret)

        begin
            client.get_metadata path
        rescue DropboxApi::Errors::NotFoundError
            client.create_folder path
            client.upload new_path2, file
        else
            client.upload new_path2, file
        end

        redirect_to '/#contact'
    end
end
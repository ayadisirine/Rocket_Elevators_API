class Lead < ApplicationRecord
    require 'sendgrid-ruby'
    include SendGrid
    mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
    require 'sendgrid-ruby'
    include SendGrid
    after_save :create_lead_ticket, :sendgrid

    def create_lead_ticket
        client = ZendeskAPI::Client.new do |config|
            config.url = ENV['ZENDESK_URL']
            config.username = ENV['ZENDESK_USERNAME']
            config.token = ENV['ZENDESK_TOKEN']
        end
        ZendeskAPI::Ticket.create!(client, 
            :subject => "#{self.name} from #{self.company_name}", 
            :comment => { 
                :value => "The contact #{self.name} from company #{self.company_name} can be reached at email  #{self.email} and at phone number #{self.phone}. 
                    #{self.department} has a project named #{self.project_name} which would require contribution from Rocket Elevators.
                    \n\n
                    Project Description
                    #{self.project_description}\n\n
                    Attached Message: #{self.message}"
            }, 
            :requester => { 
                "name": self.name, 
                "email": self.email 
            },
            :priority => "normal",
            :type => "question"
        )
    end

    def sendgrid
        mail = Mail.new
        mail.from = Email.new(email: 'grimmjowx9@hotmail.com')
        custom = Personalization.new
        custom.add_to(Email.new(email: self.email))
        custom.add_dynamic_template_data({
            "fullName" => self.name,
            "projectName" => self.project_name
        })
        mail.add_personalization(custom)
        mail.template_id = 'd-1ccc3d8ba35c4e9b879230de9bca725c'

        honda_civic = SendGrid::API.new(api_key: ENV['SENDGRID_API'])
        begin
            response = honda_civic.client.mail._('send').post(request_body: mail.to_json)
        rescue Exception => e
            puts e.message
        end
    end
    
end

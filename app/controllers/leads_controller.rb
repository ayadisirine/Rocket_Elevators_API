class LeadsController < ApplicationController
    
    require 'rake'
    Rails.application.load_tasks
    
    require 'sendgrid-ruby'
    include SendGrid

    def create
        
        puts params
        leads = Lead.new
        leads.name = params[:name]
        leads.company_name = params[:company_name]
        leads.email = params[:email]
        leads.phone = params[:phone]
        leads.project_name = params[:project_name]
        leads.project_description = params[:project_description]
        leads.department = params[:department]
        leads.message = params[:message]
        leads.attachment = params[:attachment]
        leads.save!
        

        if leads.save!
            #helpers.ticket_lead(lead_params)
            
            redirect_to '/'
            load File.join(Rails.root, 'lib', 'tasks', 'sync.rake')
            Rake::Task['warehouse:sync'].execute
            SendGrid_note()
        end
    end

    def SendGrid_note
        
            full_name = params[:name]
            email = params[:email]
            project_name = params[:project_name]
              
            mail = SendGrid::Mail.new
            # mail.from = SendGrid::Email.new(email: 'izere5@yahoo.fr')
            # personalization = SendGrid::Personalization.new
            # personalization.add_to(Email.new(email: email)
            # personalization.add_dynamic_template_data({
            #   "fullName" => full_name,
            #   "projectName" => project_name
            # })
            # mail.add_personalization(personalization)
            # mail.template_id = 'd-7caebd6e2057459e97cab2026f9be76f'
            
            # sg = SendGrid::API.new(api_key: ENV['SENDGRID_TOKEN'])
            # begin
            #     response = sg.client.mail._("send").post(request_body: mail.to_json)
            # rescue Exception => e
            #     puts e.message
            # end 
       
            
        # using SendGrid's Ruby Library
        # https://github.com/sendgrid/sendgrid-ruby
        

        from = SendGrid::Email.new(email: 'izere5@yahoo.fr')
        to = SendGrid::Email.new(email: email)
        subject = 'Greetings from Rocket Elevators!'
        
        content = SendGrid::Content.new(type: 'text/plain', value: 'you are grea')
        mail.template_id = 'd-7caebd6e2057459e97cab2026f9be76f'
        # mail = SendGrid::Mail.new(from, subject, to, content)

        sg = SendGrid::API.new(api_key:'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')
        response = sg.client.mail._('send').post(request_body: mail.to_json)
        # puts response.status_code
        # puts response.body
        # puts response.headers

    end
    

    def leads_
        render '/'
    end

    def show
        redirect_to '/admin/lead'
    end


end

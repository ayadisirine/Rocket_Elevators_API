class LeadsController < ApplicationController
    
    def create

        puts params
        x = params[:attachment]

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

        $attachment = leads.attachment
        $company_name = leads.company_name

        leads.save!
        

        if leads.save
            if x == nil
                redirect_to '/'
            else
                redirect_to '/dropbox/auth_callback'
            end
        end
    end

    def leads_
        render '/'
    end
  
    def show
        redirect_to '/admin/lead'
    end

end

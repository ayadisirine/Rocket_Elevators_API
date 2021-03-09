class Quote < ApplicationRecord
  after_save :create_quote_ticket

  def create_quote_ticket
      client = ZendeskAPI::Client.new do |config|
          config.url = ENV['ZENDESK_URL']
          config.username = ENV['ZENDESK_USERNAME']
          config.token = ENV['ZENDESK_TOKEN']
      end
      ZendeskAPI::Ticket.create!(client, 
          :subject => "#{self.name}", 
          :comment => { 
              :value => "The contact #{self.name} 
                  can be reached at email #{self.email} and at phone number #{self.phone}. 
                  Building type selected is #{self.bType} with product line #{self.product}. 
                  Number of suggested elevator is #{self.numElev} and total price is #{self.totalP}. \n
                  For More Information, refers to Quote ##{self.id}."
          }, 
          :requester => { 
              "name": self.name, 
              "email": self.email         
            },
          :priority => "normal",
          :type => "task"
          )
  end
end

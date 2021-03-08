class Elevator < ApplicationRecord
    belongs_to :column , foreign_key: "column_id"
    after_update :contact_tech

    def contact_tech
        if self.status == "Intervention" or self.status == "intervention"
            message = "The Elevator ID: #{self.id}, in building: #{self.column.battery.building.id}, on #{self.column.battery.building.address_building} needs maintenance"
            TwilioText.new(message).txt
        end
    end
end
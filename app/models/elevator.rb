class Elevator < ApplicationRecord
    belongs_to :column , foreign_key: "column_id"
end
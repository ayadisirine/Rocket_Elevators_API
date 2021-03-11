class BuildingsController < ApplicationController

    def getAll
        @Building = Building.getAll
    end
    
end


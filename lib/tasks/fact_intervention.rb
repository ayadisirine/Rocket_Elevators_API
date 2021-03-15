require 'pg'
namespace :intervention do

    desc "Sync Fact Intervention"
    task sync: :environment  do |t, args|

        dwh = PG::Connection.new(host:'localhost', port:'5432', dbname:'rocketelevators_dwh', user:'postgres', password:'postgres')

        



    end
end
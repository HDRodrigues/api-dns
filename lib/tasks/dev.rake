namespace :dev do

  desc "Setup Development"
  task setup: :environment do
    puts "Running the default setup"

    puts "Dropping the Data Base...#{%x(rake db:drop)}" 
    puts "Creating the DataBase...#{%x(rake db:create)}" 
    puts "Executing the Migrations...#{%x(rake db:migrate)}"
    puts "Executing the Seeds...#{%x(rake db:seed)}"

    puts "Default setup successfully executed!"
  end

end
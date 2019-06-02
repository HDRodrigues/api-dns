namespace :dev do

  desc "Setup Development"
  task setup: :environment do
    puts "Running the default setup"

    puts "Dropping the Data Base...#{%x(rake db:drop)}" 
    puts "Creating the DataBase...#{%x(rake db:create)}" 
    puts "Executing the Migrations...#{%x(rake db:migrate)}"
    puts "Executing the Seeds...#{%x(rake db:seed)}"
    puts %x(rake dev:generate_dns) 
    puts %x(rake dev:generate_hostnames) 
    puts %x(rake dev:generate_associate) 
    puts "Default setup successfully executed!"
  end


  desc "Create DNS Fake"
  task generate_dns: :environment do
    puts "Creating DOMAIN NAME SYSTEM FAKES..."

    (1..10).each do |number|
      DomainNameSystem.create!(
        ip: "#{number}.#{number}.#{number}.#{number}"
      )
    end
    puts "DOMAIN NAME SYSTEM FAKES successfully created!"
  end

  desc "Create Hostnames Fake"
  task generate_hostnames: :environment do
    puts "Creating HOSTNAMES..."

    hostnames = %w(lorem.com, ipsum.com, dolor.com, amet.com, sit.com)

    hostnames.each do |hostname|
      Hostname.create!(
        name: hostname
      )
    end
    puts "HOSTNAMES FAKES successfully created!"
  end


  desc "Associate DNS and Hostnames"
  task generate_associate: :environment do
    puts "Associating DNS and Hostnames..."

    hostnames_test = %w(lorem.com, ipsum.com, dolor.com, amet.com, sit.com)

    DomainNameSystem.all.each do |dns|
      hosts = hostnames_test.sample(rand(1..5))
      hosts.each do |host|
        dns.hostnames << Hostname.find_by_name(host)
      end
    end

    puts "DNS and Hostnames successfully associated!"
  end

end
# DNS API

## Project developed using:
Rails 5.2.3
Ruby 2.5.1p57 

### How to execute
* Make sure to update the database.yml to use the current postgres user and password in your machine

* Execute the bundle install to install all gems
```
  bundle install
```

* Execute the rake task to build the DataBase, DNS and Hostnames
```
  rake dev:setup
```

* Execute the command to run the application in the port 3002
```
rails s -p 3002
```

## Endpoints  
* Create Domain Name System endpoint - POST
```
localhost:3002/api/v1/dns
``` 
BODY
```
{
	"domain_name_system": {
		"ip": "111.111.1.6",
		"hostnames": "solo.com,amid.com, dolor.com"
	}
}
```

* Index Domain Name System endpoint - GET
```
localhost:3002/api/v1/dns
```

Optional params for GET endpoint 
```
include, exclude, page, per_page
```
E.g
```
localhost:3002/api/v1/dns?page=1&per_page=50&include=amet.com&exclude=sit.com
```
## Unit tests
* Run Unit tests 
```
rspec spec --format doc
```

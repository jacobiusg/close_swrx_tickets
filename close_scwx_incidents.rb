#! /usr/bin/ruby
#CIRT Helper to close secureworks Incidents

require 'sekken'
puts "begining"
log = "close"

count = 0
verify_count = 0

ticketid = ['Your Ticket ID']

closing_code = ['Your Closing Code']

client = Sekken.new('https://ws.secureworks.com/api/TicketingService12?wsdl') #Create a new soap client
puts "new client setup"

client.services
puts "checked the client services"

service_name = :TicketingServiceImplService
port_name = :TicketingServiceImplPort
client.operations(service_name, port_name)

puts "checket the client operation available"

service_name = :TicketingServiceImplService
port_name = :TicketingServiceImplPort
operation_name = :closeTicket
operation = client.operation(service_name, port_name, operation_name)

ticket = ticketid.last
reason = closing_code.last

count = ticketid.length
verify_count = closing_code.length

while count > 0
	puts "working"
	puts count
	puts verify_count

	operation.header = {}

	operation.body = {
		closeTicket: {
			userName: 'userName',
			password: 'passwd',
			ticketId: ticket,
			reason: reason,
			worklog: log,
			}
		}

	ticketid.pop
	closing_code.pop
	count -= 1
	puts "Closed " + ticket + " with status code " + reason
	response_a = operation.call.raw
	puts response_a

end

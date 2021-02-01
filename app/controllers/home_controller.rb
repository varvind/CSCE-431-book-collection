require 'pg'

class HomeController < ApplicationController
    def index 
        # Checks for most recent URL for 'read' because there is no form to indicate that a user has read
        if URI(request.referer).path.include? "/read" 
            flash[:notice] = "Read Book: " + URI.decode_www_form_component(URI(request.referer).path[6..])
        end
        @books = []

        #Get url for db
        url = ENV['DATABASE_URL']
        uri = URI.parse(url)

        begin 
            #connect to db
            conn = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)

            #pulls all books from db
            @books = conn.exec "SELECT * From Books"
        rescue => e
            #if there is any error with the db, error message is displayed
            puts e.message
            flash[:notice] = "Error in retreiving books, please check database connection"
        ensure
            #close connection
            conn.close if conn
        end
        
    end
end

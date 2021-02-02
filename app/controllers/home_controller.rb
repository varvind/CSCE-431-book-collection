require 'pg'

class HomeController < ApplicationController
    def index 
        # Checks for most recent URL for 'read' because there is no form to indicate that a user has read
        if(request.referer)
            if URI(request.referer).path.include? "/read" 
                flash[:notice] = "Read Book: " + URI.decode_www_form_component(URI(request.referer).path[6..])
            end
        end
        
        #Get url for db

        begin 
            @books = Book.all
        rescue => e
            #if there is any error with the db, error message is displayed
            puts e.message
            flash[:notice] = "Error in retreiving books, please check database connection"
        end
        
    end
end

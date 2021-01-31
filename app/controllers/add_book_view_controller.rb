require 'pg'
class AddBookViewController < ApplicationController
    def add_book 
    
    end
    def create
        conn = PG::Connection.open(:dbname => 'book_collection_development')
        title = params[:title]
        author = params[:author]
        genre = params[:genre]
        price = params[:price]
        pub_date = params[:published_date]

        begin
        conn.exec "INSERT INTO Books Values('#{title}', '#{author}', '#{genre}', #{price}, '#{pub_date}');"
        redirect_to '/'
        rescue
        flash[:notice] = "Invalid entry"
        redirect_to '/addbook'
        ensure
        conn.close if conn
        end
    end
    def remove 
        
    end

end

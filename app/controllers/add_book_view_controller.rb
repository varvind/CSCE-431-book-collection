require 'pg'
class AddBookViewController < ApplicationController
    def create
        # fetch db url
        url = ENV['DATABASE_URL']
        uri = URI.parse(url)

        begin
            # connect to db
            conn = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
        rescue
            flash[:notice] = "Unable to Connect To Database"
            redirect_to '/addbook'
        end

        # get form parameters and define variables
        title = params[:title]
        author = params[:author]
        genre = params[:genre]
        price = params[:price]
        pub_date = params[:published_date]

        begin
            # insert book in db
            conn.exec "INSERT INTO Books Values('#{title}', '#{author}', '#{genre}', #{price}, '#{pub_date}');"
            flash[:notice] = "Created Book: #{title}"
            redirect_to '/'
        rescue
            # if there is an error in inserting book
            flash[:notice] = "Error: Invalid Entry (Possile Reasons are duplicate entry or entering a string in the price field :))"
            redirect_to '/addbook'
        ensure
            # close connection
            conn.close if conn
        end
    end
end

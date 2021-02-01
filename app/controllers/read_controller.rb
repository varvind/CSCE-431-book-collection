class ReadController < ApplicationController
    def read
        # fetch db url
        url = ENV['DATABASE_URL']
        uri = URI.parse(url)

        # fetch title param from url
        @title = params[:title]
        @urltitle = URI.encode_www_form_component("#{@title}")
        begin
            # connect to db and get book information and displaying it
            conn = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
            @book = conn.exec "SELECT * FROM Books WHERE title = '#{@title}';"  
            @@book = @book
        rescue
            # any db error 
            flash[:notice] = "Error in retreiving book, please try again"
            redirect_to "/read/#{@title}"
        ensure
            # close connection
            conn.close if conn
        end
    end
end

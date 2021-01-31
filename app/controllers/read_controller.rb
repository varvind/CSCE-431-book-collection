class ReadController < ApplicationController
    def read
        db_name = 'book_collection_development'
        if Rails.env == 'production'
            db_name = 'book_collection_production'
        end
        @title = params[:title]
        @urltitle = URI.encode_www_form_component("#{@title}")
        begin
            conn = PG::Connection.open(:dbname => db_name)
            @book = conn.exec "SELECT * FROM Books WHERE title = '#{@title}';"  
            @@book = @book
        rescue
            flash[:notice] = "Error in retreiving book, please try again"
            redirect_to "/edit/#{@title}"
        ensure
            conn.close if conn
        end
    end
end

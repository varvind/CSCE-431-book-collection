class ReadController < ApplicationController
    def read
        # fetch db url

        # fetch title param from url
        @title = params[:title]
        @urltitle = URI.encode_www_form_component("#{@title}")
        begin
            # connect to db and get book information and displaying it
            @book = Book.where(:title => @title)
            @@book = @book
        rescue
            # any db error 
            flash[:notice] = "Error in retreiving book, please try again"
            redirect_to "/read/#{@title}"
        end
    end
end

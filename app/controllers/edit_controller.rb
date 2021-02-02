require 'pg'
require 'uri'

class EditController < ApplicationController
    # class variable created to prevent multiple postgres queries
    @@book = nil
    def editbook
        # get db url

        # params received from url
        @title = params[:title]
        @urltitle = URI.encode_www_form_component("#{@title}")

        begin
            # connect and query book information to be displayed on page
            @book = Book.where(:title => @title)  
            @@book = @book
        rescue
            # error message for any error in query
            flash[:notice] = "Error in retreiving book, please try again"
            redirect_to "/edit/#{@title}"
        end
    end

    def edit
        # define variables from form input
        title = params[:newtitle]
        author = params[:author]
        genre = params[:genre]
        price = params[:price]
        pub_date = params[:published_date]
        
        book = Book.where(:title => @@book[0]['title'])

        book.update(:title => title, :author => author, :genre => genre, :price => price, :published_date => pub_date)
        
        
        if flash[:notice] 
            redirect_to "/edit/#{@@book[0]['title']}"
        else 
            flash[:notice] = "Edited book: #{@@book[0]['title']}"
            redirect_to '/'
        end
        
    end
end

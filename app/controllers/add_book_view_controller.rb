require 'pg'
class AddBookViewController < ApplicationController
    def create
        # get form parameters and define variables
        title = params[:title]
        author = params[:author]
        genre = params[:genre]
        price = params[:price]
        pub_date = params[:published_date]
        begin
            # insert book in db
            Book.create(:title => title, :author => author, :genre => genre, :price => price, :published_date => pub_date)
            flash[:notice] = "Created Book: #{title}"
            redirect_to '/'
        rescue
            # if there is an error in inserting book
            flash[:notice] = "Error: Invalid Entry (Possile Reasons are duplicate entry or entering a string in the price field :))"
            redirect_to '/addbook'
        end
    end
end

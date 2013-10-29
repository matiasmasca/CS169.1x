class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings.keys #Todos los posibles
    @filter_ratings = Hash.new 
    @filter_ratings = params[:ratings] || session[:ratings] || Movie.all_ratings
    
=begin $Deprecado...
    if session.has_key?(:ratings) && session[:ratings].size > 0 || params.has_key?(:ratings)
        session[:ratings] = params[:ratings]
        @filter_ratings = session[:ratings] unless session[:ratings] == nil
      else
        session[:ratings] = params[:ratings] unless params[:ratings] == nil
        @filter_ratings = @all_ratings
    end
=end
   if params[:sort]
      sort = params[:sort]
      @movies = Movie.filter(@filter_ratings.keys, sort)   
    else
      @movies = Movie.filter(@filter_ratings.keys)
    end 


  end
 
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings.keys #Todos los posibles
    @filter_ratings = Hash.new 
    #@filter_ratings = session[:ratings] || params[:ratings]  
    
    #Si vienen parametros, modificar la sesion, sino dejar.
    #Si no hay nada crear.
    if session.has_key?(:ratings) && session[:ratings].size > 0 
        if params.has_key?(:ratings)
          session[:ratings] = params[:ratings]
        end  
        @filter_ratings = session[:ratings] unless session[:ratings] == nil
      else
        session[:ratings] = params[:ratings] unless params[:ratings] == nil
        @filter_ratings = Movie.all_ratings
    end
    #logger.debug "el FILTRO es: #{@filter_ratings}"
    @filter_ratings = Movie.all_ratings if @filter_ratings == nil
  
   session[:sort] = params[:sort]  unless params[:sort] == nil

   if session[:sort]
      sort = session[:sort]
      @movies = Movie.filter(@filter_ratings.keys, sort)   
    else
      @movies = Movie.filter(@filter_ratings.keys)
    end 
    session[:ratings] = @filter_ratings
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

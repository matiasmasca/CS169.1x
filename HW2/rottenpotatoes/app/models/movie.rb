class Movie < ActiveRecord::Base
  def self.all_ratings
    #return ['G','PG','PG-13','R','NC-17'] #Version estatica.
    #un arreglo dinamico
    a = {}
  	a = Movie.select(:rating).map(&:rating).uniq
  	hash = Hash[a.map {|x| [x, x]}] 
 end

  def self.filter(filtro, sort_by='')
  	#sort_by = 'title'
  find_params = Hash.new
  find_params[:order] = sort_by
  find_params[:conditions] = ["rating IN (?)", filtro]
   @movies = Movie.find(:all, find_params)

=begin 
    if sort != ''
	   #@movies = Movie.all(:order=>sort)
	   @movies = Movie.order(sort).where(rating: filtro)
	else
	   @movies = Movie.where(rating: filtro)
	end 
  end
  find_params = Hash.new
  find_params[:order] = @sort_by
  find_params[:conditions] = ["rating IN (?)", ratings]
  @movies = Movie.find(:all, find_params)

 @movies = Movie.find(:all, :conditions=>{'rating'=>filtro}, :order=>sort_by)

=end 
 end
end

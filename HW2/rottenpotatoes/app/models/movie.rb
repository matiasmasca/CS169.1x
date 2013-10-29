class Movie < ActiveRecord::Base
  def self.all_ratings
    #return ['G','PG','PG-13','R','NC-17'] #Version estatica.
    #un arreglo dinamico
    a = {}
  	a = Movie.select(:rating).map(&:rating).uniq
  	hash = Hash[a.map {|x| [x, x]}] 
 end

  def self.filter(filtro, sort_by='')
    find_params = Hash.new
    find_params[:order] = sort_by
    find_params[:conditions] = ["rating IN (?)", filtro]
    #logger.debug "LAS condiciones del filtro: #{find_params.inspect}"
    @movies = Movie.find(:all, find_params)
  end
end

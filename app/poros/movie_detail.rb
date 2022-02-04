class MovieDetail
    attr_reader :id,
                :title,
                :runtime,
                :genres,
                :summary,
                :vote_average,
                :cast,
                :reviews,
                :review_count,
                :poster_path

  def initialize(movie_details, movie_cast, movie_reviews)
    @id = movie_details[:id]
    @title = movie_details[:title]
    @runtime = (movie_details[:runtime].to_f / 60).round(2)
    @poster_path = movie_details[:poster_path]
    @genres = all_genres(movie_details)
    @summary = movie_details[:overview]
    @vote_average = movie_details[:vote_average]
    @cast = format_cast(movie_cast)
    @reviews = format_reviews(movie_reviews)
    @review_count = movie_reviews.count
  end

  def format_cast(movie_cast)
    cast_hash = Hash.new
    movie_cast.each do |actor|
      cast_hash[actor[:name]] = actor[:character]
    end
    cast_hash
  end

  def format_reviews(movie_reviews)
    review_hash = Hash.new
    movie_reviews.each do |review|
      review_hash[review[:author]] = review[:content]
    end
    review_hash
  end

  def all_genres(movie_details)
    movie_details[:genres].map do |genre|
      genre[:name]
    end
  end
end

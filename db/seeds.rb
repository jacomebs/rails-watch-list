puts 'Deleting everything...'
Bookmark.destroy_all
Movie.destroy_all

5.times do |i|
  puts "Importing movies from page #{i + 1}..."

  movies_json = JSON.parse(RestClient.get("http://tmdb.lewagon.com/movie/top_rated?page=#{i + 1}").body, symbolize_names: true)

  movies_json[:results].each do |movie_json|
    Movie.create!(
      title: movie_json[:title],
      overview: movie_json[:overview],
      poster_url: "https://image.tmdb.org/t/p/w500/#{movie_json[:poster_path]}",
      rating: movie_json[:vote_average]
    )
  end
end

puts 'Done 🎉'

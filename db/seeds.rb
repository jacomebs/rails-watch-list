puts 'Deleting everything...'
Bookmark.destroy_all
Movie.destroy_all

puts 'Creating movies...'
url = 'http://tmdb.lewagon.com/movie/top_rated'

movies_json = JSON.parse(RestClient.get(url).body, symbolize_names: true)

movies_json[:results].each do |movie_json|
  Movie.create!(
    title: movie_json[:title],
    overview: movie_json[:overview],
    poster_url: "https://image.tmdb.org/t/p/w500/#{movie_json[:poster_path]}",
    rating: movie_json[:vote_average]
  )
end

puts 'Done 🎉'

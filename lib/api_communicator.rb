require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)

  response_hash = get_hash_from_api('http://www.swapi.co/api/people/')
  
  characters = response_hash["results"]
  found_character = characters.find do |character|
    character["name"].downcase == character_name
  end
  films = found_character["films"]


  films = films.map do |film_url|
    film_hash = get_hash_from_api(film_url)
    film_hash["title"]
  end
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.

  puts "#{found_character['name']} has appeared in:"

  return films
end

def get_hash_from_api(url)
  response_string = RestClient.get(url)
  return JSON.parse(response_string)
end

def print_movies(films)
  films.each do |film|
    puts ""
    puts film
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

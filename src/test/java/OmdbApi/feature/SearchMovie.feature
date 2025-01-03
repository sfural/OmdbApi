Feature: Search for a movie using OMDB API

  Background:
    * url 'http://www.omdbapi.com/'
    * def apiKey = '71a67b9f'

  Scenario: Get the movie ID for "Harry Potter and the Sorcerer's Stone" and Search for by movie ID
    Given path ''
    And param apikey = apiKey
    And param s = 'Harry Potter'
    When method GET
    Then status 200
    And match each response.Search ==
    """
            {
            "Title": "#string",
            "Year": "#string",
            "imdbID": "#string",
            "Type": "#string",
            "Poster": "#string"
            }
    """

    # Get the movie ID from the results
    * def movie = karate.filter(response.Search, function(x){ return x.Title == "Harry Potter and the Sorcerer's Stone" })[0]
    * def movieId = movie.imdbID
    # Validate the movie ID
    * print 'The IMDb ID for Harry Potter and the Sorcerer\'s Stone is:', movieId

    Given path ''
    And param apikey = apiKey
    And param i = movieId

    When method GET
    Then status 200
    And match response contains { Title: "Harry Potter and the Sorcerer's Stone","Year": "2001","Released": "16 Nov 2001"}

    #Validate the movie details
    * print 'Movie details for the ID:', movieId, 'are:', response

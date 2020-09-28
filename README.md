# RecoMovie
Movie recommendation app

# App skeleton
First real commit. I don't consider this part of the assignment, but I like to work in a proper setup, so I spent a
little time rearranging the default new project. 

# Movie Database API
Created user account, got API key and found the right service to use:<br/>
`/3/movie/popular`<br>
Implemented model classes for receiving movie data including unit tests mocking the response.<br/>
Discovered that in order to display poster images, I also need to fetch the configuration to get base URL. Rather than
spend a lot of time fetching and parsing this data, I decided to hardcode the base URL directly where I need it.<br/>
Poster path: https://image.tmdb.org/t/p/w154 <br/>
<br/>
<i>Time spent on this part: ~35 minutes</i>

# Basic networking and pageable datasource
Created a very basic network layer for fetching json data.<br/>
Made a movie list data source protocol for exposing a (pageable) movie list to a consumer.<br/>
Implemented the move list data source that fetches data from a network (real or mocked).<br/>
Added unit tests for everything (could be more elaborate).<br/>
<br/>
<i>Time spent on this part: ~2 hours</i>

# UI for showing popular movie list
Created the view model and view (table cell) for showing the list of popular movies. Also implemented the necessary
call to fetch the poster image for the movie (path hardcoded as described earlier)<br/>
I skipped doing more unit tests for this part - also in some places error handling could be more extensive to provide a
better user experience.<br/>
<br/
<i>Time spent on this part: ~1.5 hours</i>

Project 1
================

In order to access the OMDb API, you need to get a free [api
key](http://www.omdbapi.com/apikey.aspx).

Next, there are two ways to get information from the OMDb API. You can
either build your search “By ID or Title” or “By Search”.

Lets say you have a movie title in mind, like Star Wars. Here’s a
function you can use to get data from the OMDb API about Star Wars:

``` r
library(tidyverse)
library(jsonlite)
library(httr)
search_by_title <- function(mykey,title){
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
  info_url <- paste0("&t=",title) 
  full_url <- paste0(base_url, info_url)
  full_url
  
  movie_api_call <- GET(full_url)
  movie_api_call_char <- rawToChar(movie_api_call$content)
  movie_JSON <- jsonlite::fromJSON(movie_api_call_char, flatten = TRUE) 
  movie_JSON <- as.data.frame(movie_JSON)
  tibble_movie_JSON <- as_tibble(movie_JSON)
  return(tibble_movie_JSON)
}
```

You should get a tibble that looks like this:

    ## # A tibble: 3 × 26
    ##   Title     Year  Rated Released  Runtime Genre Director Writer Actors Plot  Language Country Awards Poster Ratings.Source
    ##   <chr>     <chr> <chr> <chr>     <chr>   <chr> <chr>    <chr>  <chr>  <chr> <chr>    <chr>   <chr>  <chr>  <chr>         
    ## 1 Star Wars 1977  PG    25 May 1… 121 min Acti… George … Georg… Mark … Luke… English  United… Won 6… https… Internet Movi…
    ## 2 Star Wars 1977  PG    25 May 1… 121 min Acti… George … Georg… Mark … Luke… English  United… Won 6… https… Rotten Tomato…
    ## 3 Star Wars 1977  PG    25 May 1… 121 min Acti… George … Georg… Mark … Luke… English  United… Won 6… https… Metacritic    
    ## # … with 11 more variables: Ratings.Value <chr>, Metascore <chr>, imdbRating <chr>, imdbVotes <chr>, imdbID <chr>,
    ## #   Type <chr>, DVD <chr>, BoxOffice <chr>, Production <chr>, Website <chr>, Response <chr>

Lets say you have a valid IMDb ID. You can find an IMDb ID by searching
for a title on the [IMDb website](www.imdb.com). After you find a movie
you like, the IMDb ID will be in the URL. For example, the URL for the
IMDb page for Star Wars: Episode V - The Empire Strikes Back is
<https://www.imdb.com/title/tt0080684/?ref_=nv_sr_srsg_0>. Therefore,
its IMDb ID is tt0080684.

Here’s a function you can use if you have a valid IMDb ID:

``` r
library(tidyverse)
library(jsonlite)
library(httr)
search_by_IMDb_ID <- function(mykey,IMDb_ID){
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
  info_url <- paste0("&i=",IMDb_ID) 
  full_url <- paste0(base_url, info_url)
  full_url
  
  movie_api_call <- GET(full_url)
  movie_api_call_char <- rawToChar(movie_api_call$content)
  movie_JSON <- jsonlite::fromJSON(movie_api_call_char, flatten = TRUE) 
  movie_JSON <- as.data.frame(movie_JSON)
  tibble_movie_JSON <- as_tibble(movie_JSON)
  return(tibble_movie_JSON)
}
```

You should get a tibble that looks like this:

    ## # A tibble: 3 × 26
    ##   Title      Year  Rated Released Runtime Genre Director Writer Actors Plot  Language Country Awards Poster Ratings.Source
    ##   <chr>      <chr> <chr> <chr>    <chr>   <chr> <chr>    <chr>  <chr>  <chr> <chr>    <chr>   <chr>  <chr>  <chr>         
    ## 1 Star Wars… 1980  PG    20 Jun … 124 min Acti… Irvin K… Leigh… Mark … Afte… English  United… Won 1… https… Internet Movi…
    ## 2 Star Wars… 1980  PG    20 Jun … 124 min Acti… Irvin K… Leigh… Mark … Afte… English  United… Won 1… https… Rotten Tomato…
    ## 3 Star Wars… 1980  PG    20 Jun … 124 min Acti… Irvin K… Leigh… Mark … Afte… English  United… Won 1… https… Metacritic    
    ## # … with 11 more variables: Ratings.Value <chr>, Metascore <chr>, imdbRating <chr>, imdbVotes <chr>, imdbID <chr>,
    ## #   Type <chr>, DVD <chr>, BoxOffice <chr>, Production <chr>, Website <chr>, Response <chr>

movie title in mind, like Star Wars. Here’s a function you can use to
get data from the OMDb API about Star Wars:

This is my .Rmd file. Test. Test 2

``` r
plot(iris)
```

![](README_files/figure-gfm/plot-1.png)<!-- -->

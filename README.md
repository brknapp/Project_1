Project 1
================

-   [Lets Get Started: OMDb API Key](#lets-get-started-omdb-api-key)
-   [Build URL for One Movie Title](#build-url-for-one-movie-title)
-   [Build URL for One Movie Title and One
    Date](#build-url-for-one-movie-title-and-one-date)
-   [Build URL for One IMDb ID](#build-url-for-one-imdb-id)
-   [Build URL to Search for More than One Title in a
    Series](#build-url-to-search-for-more-than-one-title-in-a-series)
-   [Get the data!](#get-the-data)
-   [Build URL to search for More than One Title or
    Series](#build-url-to-search-for-more-than-one-title-or-series)
-   [Let’s make a data set!](#lets-make-a-data-set)

# Lets Get Started: OMDb API Key

In order to access the OMDb API, you need to get a free [api
key](http://www.omdbapi.com/apikey.aspx). In the rest of this document,
“mykey” refers to your OMDb API key.

You should also “turn on” these packages by running the code below. If
you don’t have them installed yet, run `install.packages()` with the
package in quotes. For example, to install `tidyverse`, you would run
`install.packages("tidyverse")`.

``` r
library(httr) #this package will help use use the URL we built to get information from the OMDb API
library(jsonlite) #this package will help us convert the data we get from the OMDb API to a more usable format
library(tidyverse) #this package will help us work with our nicely formatted data.
```

    ## ── Attaching packages ───────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✔ ggplot2 3.3.6     ✔ purrr   0.3.4
    ## ✔ tibble  3.1.7     ✔ dplyr   1.0.9
    ## ✔ tidyr   1.2.0     ✔ stringr 1.4.0
    ## ✔ readr   2.1.2     ✔ forcats 0.5.1

    ## ── Conflicts ──────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter()  masks stats::filter()
    ## ✖ purrr::flatten() masks jsonlite::flatten()
    ## ✖ dplyr::lag()     masks stats::lag()

In order to get information from the OMDb API, we have to build a URL
with our search criteria. It’s similar to doing a Google search. There
are two ways to build a URL: “By ID or Title” or “By Search”.

# Build URL for One Movie Title

Let’s say you have a movie title in mind, like Star Wars (1977). Here’s
a function you can use to get data from the OMDb API about Star Wars:

Note: the parameter “type” has three options: movie, series, and
episode. If “type” is not specified, it will give everything (including
movies, series, and episodes). I’m making the default for “type” be
“movie”, but you can change this if you want.

``` r
search_by_title <- function(mykey,title,type="movie"){
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
  info_url <- paste0("&t=",title,"&type=",type) 
  full_url <- paste0(base_url, info_url)
  full_url <- gsub(full_url, pattern = " ", replacement = "%20")
  
  movie_api_call <- GET(full_url)
  movie_api_call_char <- rawToChar(movie_api_call$content)
  movie_JSON <- jsonlite::fromJSON(movie_api_call_char, flatten = TRUE) 
  movie_JSON <- as.data.frame(movie_JSON)
  tibble_movie_JSON <- as_tibble(movie_JSON)
  return(tibble_movie_JSON)
}
```

You should run the function like this:

``` r
search_by_title("mykey","star_wars",type="movie")
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

# Build URL for One Movie Title and One Date

If you don’t specify a date, the OMDb API will give the first result.
So, since Star Wars (1977) was the first Star Wars movie ever made, it
gives Star Wars (1977) as the result. But, what if you wanted a
different Star Wars movie like Star Wars: Episode VII - The Force
Awakens (2015)? You can use this funciton:

``` r
search_by_title_and_date <- function(mykey,title,type="movie",date){
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
  info_url <- paste0("&t=",title,"&type=",type,"&y=",date) 
  full_url <- paste0(base_url, info_url)
  full_url <- gsub(full_url, pattern = " ", replacement = "%20")
  
  movie_api_call <- GET(full_url)
  movie_api_call_char <- rawToChar(movie_api_call$content)
  movie_JSON <- jsonlite::fromJSON(movie_api_call_char, flatten = TRUE) 
  movie_JSON <- as.data.frame(movie_JSON)
  tibble_movie_JSON <- as_tibble(movie_JSON)
  return(tibble_movie_JSON)
}
```

You should run the function like this:

``` r
search_by_title_and_date("mykey","star_wars",type="movie",date=2015)
```

Get a tibble like this:

    ## # A tibble: 3 × 26
    ##   Title      Year  Rated Released Runtime Genre Director Writer Actors Plot  Language Country Awards Poster Ratings.Source
    ##   <chr>      <chr> <chr> <chr>    <chr>   <chr> <chr>    <chr>  <chr>  <chr> <chr>    <chr>   <chr>  <chr>  <chr>         
    ## 1 Star Wars… 2015  PG-13 18 Dec … 138 min Acti… J.J. Ab… Lawre… Daisy… As a… English  United… Nomin… https… Internet Movi…
    ## 2 Star Wars… 2015  PG-13 18 Dec … 138 min Acti… J.J. Ab… Lawre… Daisy… As a… English  United… Nomin… https… Rotten Tomato…
    ## 3 Star Wars… 2015  PG-13 18 Dec … 138 min Acti… J.J. Ab… Lawre… Daisy… As a… English  United… Nomin… https… Metacritic    
    ## # … with 11 more variables: Ratings.Value <chr>, Metascore <chr>, imdbRating <chr>, imdbVotes <chr>, imdbID <chr>,
    ## #   Type <chr>, DVD <chr>, BoxOffice <chr>, Production <chr>, Website <chr>, Response <chr>

# Build URL for One IMDb ID

Lets say you have a valid IMDb ID. You can find an IMDb ID by searching
for a title on the [IMDb website](www.imdb.com). After you find a movie
you like, the IMDb ID will be in the URL. For example, the URL for the
IMDb page for Star Wars: Episode V - The Empire Strikes Back (1980) is
<https://www.imdb.com/title/tt0080684/?ref_=nv_sr_srsg_0>. Therefore,
its IMDb ID is tt0080684.

Here’s a function you can use if you have a valid IMDb ID:

``` r
library(tidyverse)
library(jsonlite)
library(httr)
search_by_IMDb_ID <- function(mykey,IMDb_ID,type="movie"){
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
  info_url <- paste0("&i=",IMDb_ID,"&type=",type) 
  full_url <- paste0(base_url, info_url)
  full_url <- gsub(full_url, pattern = " ", replacement = "%20")
  
  movie_api_call <- GET(full_url)
  movie_api_call_char <- rawToChar(movie_api_call$content)
  movie_JSON <- jsonlite::fromJSON(movie_api_call_char, flatten = TRUE) 
  movie_JSON <- as.data.frame(movie_JSON)
  tibble_movie_JSON <- as_tibble(movie_JSON)
  return(tibble_movie_JSON)
}
```

You should run the function like this:

``` r
search_by_IMDb_ID("mykey","tt0080684",type="movie")
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

# Build URL to Search for More than One Title in a Series

Let’s say you wanted to get all of the titles for all of the Star Wars
movies. You would then need to build your URL “By Search” instead.
Here’s a function you can use if you wanted to search for multiple movie
titles:

``` r
by_search_series <- function(mykey,title,type="movie"){
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
  info_url <- paste0("&s=",title,"&type=",type) 
  full_url <- paste0(base_url, info_url)
  full_url <- gsub(full_url, pattern = " ", replacement = "%20")
  
  movie_api_call <- GET(full_url)
  movie_api_call_char <- rawToChar(movie_api_call$content)
  movie_JSON <- jsonlite::fromJSON(movie_api_call_char, flatten = TRUE) 
  movie_JSON <- as.data.frame(movie_JSON)
  tibble_movie_JSON <- as_tibble(movie_JSON)
  return(tibble_movie_JSON)
}
```

You should run the function like this:

``` r
by_search_series("mykey","star_wars",type="movie")
```

You should get a tibble that looks like this:

    ## # A tibble: 10 × 7
    ##    Search.Title                                  Search.Year Search.imdbID Search.Type Search.Poster totalResults Response
    ##    <chr>                                         <chr>       <chr>         <chr>       <chr>         <chr>        <chr>   
    ##  1 Star Wars                                     1977        tt0076759     movie       https://m.me… 539          True    
    ##  2 Star Wars: Episode V - The Empire Strikes Ba… 1980        tt0080684     movie       https://m.me… 539          True    
    ##  3 Star Wars: Episode VI - Return of the Jedi    1983        tt0086190     movie       https://m.me… 539          True    
    ##  4 Star Wars: Episode VII - The Force Awakens    2015        tt2488496     movie       https://m.me… 539          True    
    ##  5 Star Wars: Episode I - The Phantom Menace     1999        tt0120915     movie       https://m.me… 539          True    
    ##  6 Star Wars: Episode III - Revenge of the Sith  2005        tt0121766     movie       https://m.me… 539          True    
    ##  7 Star Wars: Episode II - Attack of the Clones  2002        tt0121765     movie       https://m.me… 539          True    
    ##  8 Star Wars: Episode VIII - The Last Jedi       2017        tt2527336     movie       https://m.me… 539          True    
    ##  9 Rogue One: A Star Wars Story                  2016        tt3748528     movie       https://m.me… 539          True    
    ## 10 Star Wars: Episode IX - The Rise of Skywalker 2019        tt2527338     movie       https://m.me… 539          True

# Get the data!

That’s great! Now, lets get the data for all of the titles:

``` r
mat=NULL
get_data_series <- function(mykey,title){
  temp_table <- by_search_series(mykey,title,type="movie")
  list_of_titles <- unique(temp_table$Search.Title)
  
  for(movie_title in list_of_titles){
  table <- search_by_title(mykey,movie_title,type="movie")
  mat=rbind(mat,table)
  }
  return(mat)
}
```

You should run the function like this:

``` r
get_data_series("mykey","star_wars")
```

You should get a tibble that looks like this:

    ## # A tibble: 30 × 26
    ##    Title     Year  Rated Released Runtime Genre Director Writer Actors Plot  Language Country Awards Poster Ratings.Source
    ##    <chr>     <chr> <chr> <chr>    <chr>   <chr> <chr>    <chr>  <chr>  <chr> <chr>    <chr>   <chr>  <chr>  <chr>         
    ##  1 Star Wars 1977  PG    25 May … 121 min Acti… George … Georg… Mark … Luke… English  United… Won 6… https… Internet Movi…
    ##  2 Star Wars 1977  PG    25 May … 121 min Acti… George … Georg… Mark … Luke… English  United… Won 6… https… Rotten Tomato…
    ##  3 Star Wars 1977  PG    25 May … 121 min Acti… George … Georg… Mark … Luke… English  United… Won 6… https… Metacritic    
    ##  4 Star War… 1980  PG    20 Jun … 124 min Acti… Irvin K… Leigh… Mark … Afte… English  United… Won 1… https… Internet Movi…
    ##  5 Star War… 1980  PG    20 Jun … 124 min Acti… Irvin K… Leigh… Mark … Afte… English  United… Won 1… https… Rotten Tomato…
    ##  6 Star War… 1980  PG    20 Jun … 124 min Acti… Irvin K… Leigh… Mark … Afte… English  United… Won 1… https… Metacritic    
    ##  7 Star War… 1983  PG    25 May … 131 min Acti… Richard… Lawre… Mark … Afte… English  United… Nomin… https… Internet Movi…
    ##  8 Star War… 1983  PG    25 May … 131 min Acti… Richard… Lawre… Mark … Afte… English  United… Nomin… https… Rotten Tomato…
    ##  9 Star War… 1983  PG    25 May … 131 min Acti… Richard… Lawre… Mark … Afte… English  United… Nomin… https… Metacritic    
    ## 10 Star War… 2015  PG-13 18 Dec … 138 min Acti… J.J. Ab… Lawre… Daisy… As a… English  United… Nomin… https… Internet Movi…
    ## # … with 20 more rows, and 11 more variables: Ratings.Value <chr>, Metascore <chr>, imdbRating <chr>, imdbVotes <chr>,
    ## #   imdbID <chr>, Type <chr>, DVD <chr>, BoxOffice <chr>, Production <chr>, Website <chr>, Response <chr>

# Build URL to search for More than One Title or Series

Now, what if you want to get all of the data for all of the Star Wars
movies and all of the Indiana Jones movies. The function below can
handle a list of several titles or one title.

``` r
mat=NULL
by_search_one_or_more_titles <- function(mykey,title,type="movie"){
 if(length(title)<=1){ 
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
    info_url <- paste0("&s=",title,"&type=",type) 
    full_url <- paste0(base_url, info_url)
    full_url <- gsub(full_url, pattern = " ", replacement = "%20")
    
    movie_api_call <- GET(full_url)
    movie_api_call_char <- rawToChar(movie_api_call$content)
    movie_JSON <- jsonlite::fromJSON(movie_api_call_char, flatten = TRUE) 
    movie_JSON <- as.data.frame(movie_JSON)
    movie_JSON <- as_tibble(movie_JSON)
    return(movie_JSON)
 }
  if(length(title)>1){
  for(i in title){
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
  info_url <- paste0("&s=",i,"&type=",type) 
  full_url <- paste0(base_url, info_url)
  full_url <- gsub(full_url, pattern = " ", replacement = "%20")
  
  movie_api_call <- GET(full_url)
  movie_api_call_char <- rawToChar(movie_api_call$content)
  movie_JSON <- jsonlite::fromJSON(movie_api_call_char, flatten = TRUE) 
  movie_JSON <- as.data.frame(movie_JSON)
  mat=rbind(mat,movie_JSON)
  mat=as_tibble(mat)
  }
    }
  return(mat)
}
```

You can use this function to look for multiple titles or just one. For
example, if you wanted to search for both Star Wars and Indiana Jones,
you would run the function like this:

``` r
by_search_one_or_more_titles("mykey",c("star_wars","indiana_jones"),type="movie")
```

You would get the tibble below:

    ## # A tibble: 20 × 7
    ##    Search.Title                                  Search.Year Search.imdbID Search.Type Search.Poster totalResults Response
    ##    <chr>                                         <chr>       <chr>         <chr>       <chr>         <chr>        <chr>   
    ##  1 Star Wars                                     1977        tt0076759     movie       https://m.me… 539          True    
    ##  2 Star Wars: Episode V - The Empire Strikes Ba… 1980        tt0080684     movie       https://m.me… 539          True    
    ##  3 Star Wars: Episode VI - Return of the Jedi    1983        tt0086190     movie       https://m.me… 539          True    
    ##  4 Star Wars: Episode VII - The Force Awakens    2015        tt2488496     movie       https://m.me… 539          True    
    ##  5 Star Wars: Episode I - The Phantom Menace     1999        tt0120915     movie       https://m.me… 539          True    
    ##  6 Star Wars: Episode III - Revenge of the Sith  2005        tt0121766     movie       https://m.me… 539          True    
    ##  7 Star Wars: Episode II - Attack of the Clones  2002        tt0121765     movie       https://m.me… 539          True    
    ##  8 Star Wars: Episode VIII - The Last Jedi       2017        tt2527336     movie       https://m.me… 539          True    
    ##  9 Rogue One: A Star Wars Story                  2016        tt3748528     movie       https://m.me… 539          True    
    ## 10 Star Wars: Episode IX - The Rise of Skywalker 2019        tt2527338     movie       https://m.me… 539          True    
    ## 11 Indiana Jones and the Raiders of the Lost Ark 1981        tt0082971     movie       https://m.me… 83           True    
    ## 12 Indiana Jones and the Last Crusade            1989        tt0097576     movie       https://m.me… 83           True    
    ## 13 Indiana Jones and the Temple of Doom          1984        tt0087469     movie       https://m.me… 83           True    
    ## 14 Indiana Jones and the Kingdom of the Crystal… 2008        tt0367882     movie       https://m.me… 83           True    
    ## 15 Indiana Jones and the Temple of the Forbidde… 1995        tt0764648     movie       https://m.me… 83           True    
    ## 16 The Adventures of Young Indiana Jones: Treas… 1995        tt0115031     movie       https://m.me… 83           True    
    ## 17 The Adventures of Young Indiana Jones: Trave… 1996        tt0154003     movie       https://m.me… 83           True    
    ## 18 The Adventures of Young Indiana Jones: Attac… 1995        tt0154004     movie       https://m.me… 83           True    
    ## 19 Mr. Plinkett's Indiana Jones and the Kingdom… 2011        tt6330122     movie       https://m.me… 83           True    
    ## 20 The Adventures of Young Indiana Jones: Holly… 1994        tt0111806     movie       https://m.me… 83           True

If you wanted to search for one title, like Spider-Man, you would run
the function like this:

``` r
by_search_one_or_more_titles("mykey","spider-man",type="movie")
```

You would get this tibble:

    ## # A tibble: 10 × 7
    ##    Search.Title                      Search.Year Search.imdbID Search.Type Search.Poster             totalResults Response
    ##    <chr>                             <chr>       <chr>         <chr>       <chr>                     <chr>        <chr>   
    ##  1 Spider-Man                        2002        tt0145487     movie       https://m.media-amazon.c… 225          True    
    ##  2 Spider-Man: No Way Home           2021        tt10872600    movie       https://m.media-amazon.c… 225          True    
    ##  3 The Amazing Spider-Man            2012        tt0948470     movie       https://m.media-amazon.c… 225          True    
    ##  4 Spider-Man 2                      2004        tt0316654     movie       https://m.media-amazon.c… 225          True    
    ##  5 Spider-Man: Homecoming            2017        tt2250912     movie       https://m.media-amazon.c… 225          True    
    ##  6 Spider-Man 3                      2007        tt0413300     movie       https://m.media-amazon.c… 225          True    
    ##  7 Spider-Man: Into the Spider-Verse 2018        tt4633694     movie       https://m.media-amazon.c… 225          True    
    ##  8 The Amazing Spider-Man 2          2014        tt1872181     movie       https://m.media-amazon.c… 225          True    
    ##  9 Spider-Man: Far from Home         2019        tt6320628     movie       https://m.media-amazon.c… 225          True    
    ## 10 Jack Black: Spider-Man            2002        tt0331527     movie       https://m.media-amazon.c… 225          True

Now, lets get all of the data for both Star Wars and Indiana Jones:

``` r
mat=NULL
get_data_one_or_more_titles <- function(mykey,title){
  temp_table <- by_search_one_or_more_titles(mykey,title,type="movie")
  list_of_titles <- unique(temp_table$Search.Title)
  
  for(movie_title in list_of_titles){
  table <- search_by_title(mykey,movie_title,type="movie")
  mat=rbind(mat,table)
  }
  return(mat)
}
```

You would run the function like this:

``` r
get_data_one_or_more_titles("mykey",c("star_wars","indiana_jones"))
```

    ## # A tibble: 48 × 26
    ##    Title     Year  Rated Released Runtime Genre Director Writer Actors Plot  Language Country Awards Poster Ratings.Source
    ##    <chr>     <chr> <chr> <chr>    <chr>   <chr> <chr>    <chr>  <chr>  <chr> <chr>    <chr>   <chr>  <chr>  <chr>         
    ##  1 Star Wars 1977  PG    25 May … 121 min Acti… George … Georg… Mark … Luke… English  United… Won 6… https… Internet Movi…
    ##  2 Star Wars 1977  PG    25 May … 121 min Acti… George … Georg… Mark … Luke… English  United… Won 6… https… Rotten Tomato…
    ##  3 Star Wars 1977  PG    25 May … 121 min Acti… George … Georg… Mark … Luke… English  United… Won 6… https… Metacritic    
    ##  4 Star War… 1980  PG    20 Jun … 124 min Acti… Irvin K… Leigh… Mark … Afte… English  United… Won 1… https… Internet Movi…
    ##  5 Star War… 1980  PG    20 Jun … 124 min Acti… Irvin K… Leigh… Mark … Afte… English  United… Won 1… https… Rotten Tomato…
    ##  6 Star War… 1980  PG    20 Jun … 124 min Acti… Irvin K… Leigh… Mark … Afte… English  United… Won 1… https… Metacritic    
    ##  7 Star War… 1983  PG    25 May … 131 min Acti… Richard… Lawre… Mark … Afte… English  United… Nomin… https… Internet Movi…
    ##  8 Star War… 1983  PG    25 May … 131 min Acti… Richard… Lawre… Mark … Afte… English  United… Nomin… https… Rotten Tomato…
    ##  9 Star War… 1983  PG    25 May … 131 min Acti… Richard… Lawre… Mark … Afte… English  United… Nomin… https… Metacritic    
    ## 10 Star War… 2015  PG-13 18 Dec … 138 min Acti… J.J. Ab… Lawre… Daisy… As a… English  United… Nomin… https… Internet Movi…
    ## # … with 38 more rows, and 11 more variables: Ratings.Value <chr>, Metascore <chr>, imdbRating <chr>, imdbVotes <chr>,
    ## #   imdbID <chr>, Type <chr>, DVD <chr>, BoxOffice <chr>, Production <chr>, Website <chr>, Response <chr>

# Let’s make a data set!

First, I’m going to make two lists of movies:

``` r
#for these movies, I just want the first result it gives me:
titles <- c("casablanca",
            "the_wizard_of_oz",
            "it's_a_wonderful_life",
            "goodfellas",
            "taxi_driver",
            "psycho",
            "singin_in_the_rain",
            "2001:_a_space_odyssey",
            "vertigo")

#for these movies, I want all of them in the series:
series <- c("the_godfather",
            "star_wars",
            "alien",
            "fast_and_furious",
            "final_destination",
            "friday_the_13th")
```

Here is the function I’m going to use to get all of the data for all of
my movies:

``` r
mat1=NULL
mat2=NULL
mat3=NULL
get_data_titles_and_series <- function(mykey,titles,series){
  for(i in titles){
    temp_table <- search_by_title(mykey,i,type="movie")
      mat1=rbind(mat1,temp_table)
  }
  for(j in series){
    temp_table <- by_search_series(mykey,j,type="movie")
    list_of_titles <- unique(temp_table$Search.Title)
    for(movie_title in list_of_titles){
      table2 <- search_by_title(mykey,movie_title,type="movie")
      mat2=rbind(mat2,table2)
    }
  }
  mat3=rbind(mat3,mat1,mat2)
  return(mat3)
}
```

I’m going to run the function like this:

``` r
get_data_titles_and_series("mykey",titles,series)
```

Here is the tibble I get:

    ## # A tibble: 152 × 26
    ##    Title     Year  Rated Released Runtime Genre Director Writer Actors Plot  Language Country Awards Poster Ratings.Source
    ##    <chr>     <chr> <chr> <chr>    <chr>   <chr> <chr>    <chr>  <chr>  <chr> <chr>    <chr>   <chr>  <chr>  <chr>         
    ##  1 Casablan… 1942  PG    23 Jan … 102 min Dram… Michael… Juliu… Humph… A cy… English… United… Won 3… https… Internet Movi…
    ##  2 Casablan… 1942  PG    23 Jan … 102 min Dram… Michael… Juliu… Humph… A cy… English… United… Won 3… https… Rotten Tomato…
    ##  3 Casablan… 1942  PG    23 Jan … 102 min Dram… Michael… Juliu… Humph… A cy… English… United… Won 3… https… Metacritic    
    ##  4 The Wiza… 1939  G     25 Aug … 102 min Adve… Victor … Noel … Judy … Youn… English  United… Won 2… https… Internet Movi…
    ##  5 The Wiza… 1939  G     25 Aug … 102 min Adve… Victor … Noel … Judy … Youn… English  United… Won 2… https… Rotten Tomato…
    ##  6 The Wiza… 1939  G     25 Aug … 102 min Adve… Victor … Noel … Judy … Youn… English  United… Won 2… https… Metacritic    
    ##  7 It's a W… 1946  PG    07 Jan … 130 min Dram… Frank C… Franc… James… An a… English… United… Nomin… https… Internet Movi…
    ##  8 It's a W… 1946  PG    07 Jan … 130 min Dram… Frank C… Franc… James… An a… English… United… Nomin… https… Rotten Tomato…
    ##  9 It's a W… 1946  PG    07 Jan … 130 min Dram… Frank C… Franc… James… An a… English… United… Nomin… https… Metacritic    
    ## 10 Goodfell… 1990  R     21 Sep … 145 min Biog… Martin … Nicho… Rober… The … English… United… Won 1… https… Internet Movi…
    ## # … with 142 more rows, and 11 more variables: Ratings.Value <chr>, Metascore <chr>, imdbRating <chr>, imdbVotes <chr>,
    ## #   imdbID <chr>, Type <chr>, DVD <chr>, BoxOffice <chr>, Production <chr>, Website <chr>, Response <chr>

Before we can analyze this data, we need to make it more usable:

“Title”: Stay character “Year”: change to numeric

``` r
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

``` r
format_data <- function(mykey,titles,series){
  data <- get_data_titles_and_series(mykey,titles,series)
  data$Year <- as.numeric(data$Year)
  data$Released <- dmy(data$Released)
  data$Runtime <- as.numeric(gsub(" min","",data$Runtime))
  #data$Runtime <- as.numeric(data$Runtime)
  
    return(data)
}
```

    ## # A tibble: 152 × 26
    ##    Title    Year Rated Released   Runtime Genre Director Writer Actors Plot  Language Country Awards Poster Ratings.Source
    ##    <chr>   <dbl> <chr> <date>       <dbl> <chr> <chr>    <chr>  <chr>  <chr> <chr>    <chr>   <chr>  <chr>  <chr>         
    ##  1 Casabl…  1942 PG    1943-01-23     102 Dram… Michael… Juliu… Humph… A cy… English… United… Won 3… https… Internet Movi…
    ##  2 Casabl…  1942 PG    1943-01-23     102 Dram… Michael… Juliu… Humph… A cy… English… United… Won 3… https… Rotten Tomato…
    ##  3 Casabl…  1942 PG    1943-01-23     102 Dram… Michael… Juliu… Humph… A cy… English… United… Won 3… https… Metacritic    
    ##  4 The Wi…  1939 G     1939-08-25     102 Adve… Victor … Noel … Judy … Youn… English  United… Won 2… https… Internet Movi…
    ##  5 The Wi…  1939 G     1939-08-25     102 Adve… Victor … Noel … Judy … Youn… English  United… Won 2… https… Rotten Tomato…
    ##  6 The Wi…  1939 G     1939-08-25     102 Adve… Victor … Noel … Judy … Youn… English  United… Won 2… https… Metacritic    
    ##  7 It's a…  1946 PG    1947-01-07     130 Dram… Frank C… Franc… James… An a… English… United… Nomin… https… Internet Movi…
    ##  8 It's a…  1946 PG    1947-01-07     130 Dram… Frank C… Franc… James… An a… English… United… Nomin… https… Rotten Tomato…
    ##  9 It's a…  1946 PG    1947-01-07     130 Dram… Frank C… Franc… James… An a… English… United… Nomin… https… Metacritic    
    ## 10 Goodfe…  1990 R     1990-09-21     145 Biog… Martin … Nicho… Rober… The … English… United… Won 1… https… Internet Movi…
    ## # … with 142 more rows, and 11 more variables: Ratings.Value <chr>, Metascore <chr>, imdbRating <chr>, imdbVotes <chr>,
    ## #   imdbID <chr>, Type <chr>, DVD <chr>, BoxOffice <chr>, Production <chr>, Website <chr>, Response <chr>

movie title in mind, like Star Wars. Here’s a function you can use to
get data from the OMDb API about Star Wars:

This is my .Rmd file. Test. Test 2

``` r
plot(iris)
```

![](README_files/figure-gfm/plot-1.png)<!-- -->

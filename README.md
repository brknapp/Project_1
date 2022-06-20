Project 1
================

In order to access the OMDb API, you need to get a free [api
key](http://www.omdbapi.com/apikey.aspx).

Next, there are two ways to get information from the OMDb API. You can
either build your search “By ID or Title” or “By Search”.

Let’s say you have a movie title in mind, like Star Wars. Here’s a
function you can use to get data from the OMDb API about Star Wars:

``` r
library(tidyverse)
library(jsonlite)
library(httr)
search_by_title <- function(mykey,title){
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
  info_url <- paste0("&t=",title) 
  full_url <- paste0(base_url, info_url)
  
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

Let’s say you wanted to get all of the titles for all of the Star Wars
movies. You would then need to build your URL “By Search” instead.

Here’s a function you can use if you wanted to search for multiple movie
titles:

``` r
library(tidyverse)
library(jsonlite)
library(httr)
by_search <- function(mykey,title){
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
  info_url <- paste0("&s=",title) 
  full_url <- paste0(base_url, info_url)
  
  movie_api_call <- GET(full_url)
  movie_api_call_char <- rawToChar(movie_api_call$content)
  movie_JSON <- jsonlite::fromJSON(movie_api_call_char, flatten = TRUE) 
  movie_JSON <- as.data.frame(movie_JSON)
  tibble_movie_JSON <- as_tibble(movie_JSON)
  return(tibble_movie_JSON)
}
```

You should get a tibble that looks like this:

    ## # A tibble: 10 × 7
    ##    Search.Title                                  Search.Year Search.imdbID Search.Type Search.Poster totalResults Response
    ##    <chr>                                         <chr>       <chr>         <chr>       <chr>         <chr>        <chr>   
    ##  1 Star Wars                                     1977        tt0076759     movie       https://m.me… 735          True    
    ##  2 Star Wars: Episode V - The Empire Strikes Ba… 1980        tt0080684     movie       https://m.me… 735          True    
    ##  3 Star Wars: Episode VI - Return of the Jedi    1983        tt0086190     movie       https://m.me… 735          True    
    ##  4 Star Wars: Episode VII - The Force Awakens    2015        tt2488496     movie       https://m.me… 735          True    
    ##  5 Star Wars: Episode I - The Phantom Menace     1999        tt0120915     movie       https://m.me… 735          True    
    ##  6 Star Wars: Episode III - Revenge of the Sith  2005        tt0121766     movie       https://m.me… 735          True    
    ##  7 Star Wars: Episode II - Attack of the Clones  2002        tt0121765     movie       https://m.me… 735          True    
    ##  8 Star Wars: Episode VIII - The Last Jedi       2017        tt2527336     movie       https://m.me… 735          True    
    ##  9 Rogue One: A Star Wars Story                  2016        tt3748528     movie       https://m.me… 735          True    
    ## 10 Star Wars: Episode IX - The Rise of Skywalker 2019        tt2527338     movie       https://m.me… 735          True

That’s great! Now, lets get the data for all of the titles:

``` r
library(tidyverse)
library(jsonlite)
library(httr)
mat=NULL
get_data <- function(mykey,title){
  temp_table <- by_search(mykey,title)
  list_of_titles <- unique(temp_table$Search.Title)
  
  for(movie_title in list_of_titles){
  table <- search_by_title(mykey,movie_title)
  mat=rbind(mat,table)
  }
  return(mat)
}
```

You should get a tibble that looks like this:

``` r
get_data("5c7f9206","star_wars")
```

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

Now, what is you want to get all of the data for all of the Star Wars
movies and all of the Indiana Jones movies. The function below can
handle a list of several titles or one title.

Test:

``` r
library(tidyverse)
library(jsonlite)
library(httr)
mat=NULL
by_search <- function(mykey,title){
 if(length(title)<=1){ 
  base_url <- paste0("http://www.omdbapi.com/?apikey=",mykey)
    info_url <- paste0("&s=",title) 
    full_url <- paste0(base_url, info_url)
    
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
  info_url <- paste0("&s=",i) 
  full_url <- paste0(base_url, info_url)
  
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

You can use this new by_search function to look for multiple titles or
just one. For example, if you wanted to search for both Star Wars and
Indiana Jones, you would need to define `title` as
`title <- c("star_wars","indiana_jones")` before running the function.

    ## # A tibble: 20 × 7
    ##    Search.Title                                  Search.Year Search.imdbID Search.Type Search.Poster totalResults Response
    ##    <chr>                                         <chr>       <chr>         <chr>       <chr>         <chr>        <chr>   
    ##  1 Star Wars                                     1977        tt0076759     movie       https://m.me… 735          True    
    ##  2 Star Wars: Episode V - The Empire Strikes Ba… 1980        tt0080684     movie       https://m.me… 735          True    
    ##  3 Star Wars: Episode VI - Return of the Jedi    1983        tt0086190     movie       https://m.me… 735          True    
    ##  4 Star Wars: Episode VII - The Force Awakens    2015        tt2488496     movie       https://m.me… 735          True    
    ##  5 Star Wars: Episode I - The Phantom Menace     1999        tt0120915     movie       https://m.me… 735          True    
    ##  6 Star Wars: Episode III - Revenge of the Sith  2005        tt0121766     movie       https://m.me… 735          True    
    ##  7 Star Wars: Episode II - Attack of the Clones  2002        tt0121765     movie       https://m.me… 735          True    
    ##  8 Star Wars: Episode VIII - The Last Jedi       2017        tt2527336     movie       https://m.me… 735          True    
    ##  9 Rogue One: A Star Wars Story                  2016        tt3748528     movie       https://m.me… 735          True    
    ## 10 Star Wars: Episode IX - The Rise of Skywalker 2019        tt2527338     movie       https://m.me… 735          True    
    ## 11 Indiana Jones and the Raiders of the Lost Ark 1981        tt0082971     movie       https://m.me… 104          True    
    ## 12 Indiana Jones and the Last Crusade            1989        tt0097576     movie       https://m.me… 104          True    
    ## 13 Indiana Jones and the Temple of Doom          1984        tt0087469     movie       https://m.me… 104          True    
    ## 14 Indiana Jones and the Kingdom of the Crystal… 2008        tt0367882     movie       https://m.me… 104          True    
    ## 15 The Young Indiana Jones Chronicles            1992–1993   tt0103586     series      https://m.me… 104          True    
    ## 16 Lego Indiana Jones: The Original Adventures   2008        tt1149318     game        https://m.me… 104          True    
    ## 17 Indiana Jones and the Fate of Atlantis        1992        tt0245165     game        https://m.me… 104          True    
    ## 18 Indiana Jones and the Temple of the Forbidde… 1995        tt0764648     movie       https://m.me… 104          True    
    ## 19 The Adventures of Young Indiana Jones: Treas… 1995        tt0115031     movie       https://m.me… 104          True    
    ## 20 The Adventures of Young Indiana Jones: Trave… 1996        tt0154003     movie       https://m.me… 104          True

If you wanted to search for one title

movie title in mind, like Star Wars. Here’s a function you can use to
get data from the OMDb API about Star Wars:

This is my .Rmd file. Test. Test 2

``` r
plot(iris)
```

![](README_files/figure-gfm/plot-1.png)<!-- -->

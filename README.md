
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dups

<!-- badges: start -->

<!-- badges: end -->

Most data from the wild are rife with duplicates. dups is a package
based on the tidyverse that helps you detect, identify, and remove any
duplicates that exist in a dataset.

## Installation

You can install the development version of dups from this GitHub
repository:

``` r
library(devtools)
devtools::install_github("dmbwebb/dups")
library("dups")
```

## Basic usage

In a dups function, you define the dataset as the first argument, and
the id variable in the second argument. Note that all the dups functions
easily extend to allow for cases in which multiple id variables should
together uniquely identify a row.

``` r
df <- tibble(id = sample(1:100, size = 100, replace = TRUE),
             x1 = sample(runif(100)),
             x2 = sample(runif(100)))

dups_count(df, id)
#> [1] 59
```

The dups\_count function returns the total number of rows with
non-unique id variables, which in this case is 59. To find out what’s
going on with these duplicated ids, we can run some of the other dups
functions.

``` r
dups_report(df, id)
#> # A tibble: 3 x 3
#>   copies observations surplus
#>    <int>        <int>   <dbl>
#> 1      1           41       0
#> 2      2           38      19
#> 3      3           21      14
```

The dups\_report function shows us that there are 41 rows with only one
copy of that unique\_id (non-duplicated), but there are 38 rows with 2
copies, and 21 rows with 3 copies.

To easily drill down and examine only the dataset rows with duplicated
ids, use dups\_filter.

``` r
dups_filter(df, id) %>% head(5)
#> # A tibble: 5 x 3
#>      id    x1    x2
#>   <int> <dbl> <dbl>
#> 1    14 0.893 0.270
#> 2    51 0.311 0.567
#> 3    80 0.432 0.823
#> 4    90 0.944 0.306
#> 5    92 0.749 0.394
```

Here you can also use dups\_view to quickly view the resulting filtered
dataset.

Or alternatively, you might want to create a variable that indicates
whether a row has a duplicated ID, perhaps so that you can remember
which rows are duplicated when manipulating the dataset later down the
line. In this case, use dups\_tag:

``` r
dups_tag(df, id) %>% head(5)
#> # A tibble: 5 x 4
#>      id    x1    x2 dups_tag
#>   <int> <dbl> <dbl> <lgl>   
#> 1    14 0.893 0.270 TRUE    
#> 2    51 0.311 0.567 TRUE    
#> 3    80 0.432 0.823 TRUE    
#> 4    90 0.944 0.306 TRUE    
#> 5    92 0.749 0.394 TRUE
```

The above functions will help you find duplicates and diagnose their
source. Once you have found the source of the duplicates, the best
approach often involves some manual change to prevent the duplicates
from even coming into existence early on in the code.

If, on the other hand, you have rows that are duplicated but which don’t
contain different information (e.g they are exactly the same across all
variables, or all the variables that you care about), then you might
want to use dups\_drop.

``` r
dups_drop(df, id) %>% head(5)
#> Warning in dups_drop(df, id): Dropping 33 rows due to duplication
#> # A tibble: 5 x 3
#>      id    x1    x2
#>   <int> <dbl> <dbl>
#> 1    14 0.893 0.270
#> 2    51 0.311 0.567
#> 3    80 0.432 0.823
#> 4    90 0.944 0.306
#> 5    92 0.749 0.394
```

You should be careful with dups\_drop: it will always keep the first row
for each ID value, whether this was what you intended or not. So only
use it when you *know* that duplicated rows for a given ID don’t contain
differing information that you care about. In the example below, when
you run dups\_drop, it drops the second row of the dataset, which means
you lose the information that x was 0.5 for that second row.

``` r
important_dups <- tibble(id = c(1, 1, 2, 3),
                         x = c(0, 0.5, -2, -2))
dups_drop(important_dups, id)
#> Warning in dups_drop(important_dups, id): Dropping 1 rows due to duplication
#> # A tibble: 3 x 2
#>      id     x
#>   <dbl> <dbl>
#> 1     1     0
#> 2     2    -2
#> 3     3    -2
```

So you should only run this type of operation when you are sure that x
doesn’t matter - otherwise you may be erroneously dropping data without
realising.

---
title: "CCobb_Livesession3assignment"
author: "Che' Cobb"
date: "September 11, 2018"
output: 
  html_document:
    keep_md: true
---



## R Markdown

####1.GitHub Cloning (20 points):** Using Git, clone the following GitHub repository to your local machine: https://github.com/caesar0301/awesome-public-datasets.  In RMarkdown, please show the code (commented out, as it's not R syntax) that you used to create a new directory, navigate to the appropriate directory, and clone the repository to it.One Git command per line, please
* **$ mkdir HW3**
* **$ cd HW3**
* **$ git clone https://github.com/awesomedata/awesome-public-datasets.git**


**a. In R, please read in titanic.csv via either read.table() or read.csv(), assigning it to df.  This dataset follows the passengers aboard the Titanic, including their fees paid, rooms rented, and survivorship status.**


```r
df <- read.csv('titanic.csv')
head(df)
```

```
##   PassengerId Survived Pclass
## 1           1        0      3
## 2           2        1      1
## 3           3        1      3
## 4           4        1      1
## 5           5        0      3
## 6           6        0      3
##                                                  Name    Sex Age SibSp
## 1                             Braund, Mr. Owen Harris   male  22     1
## 2 Cumings, Mrs. John Bradley (Florence Briggs Thayer) female  38     1
## 3                              Heikkinen, Miss. Laina female  26     0
## 4        Futrelle, Mrs. Jacques Heath (Lily May Peel) female  35     1
## 5                            Allen, Mr. William Henry   male  35     0
## 6                                    Moran, Mr. James   male  NA     0
##   Parch           Ticket    Fare Cabin Embarked
## 1     0        A/5 21171  7.2500              S
## 2     0         PC 17599 71.2833   C85        C
## 3     0 STON/O2. 3101282  7.9250              S
## 4     0           113803 53.1000  C123        S
## 5     0           373450  8.0500              S
## 6     0           330877  8.4583              Q
```

**b. Output the respective count of females and males aboard the Titanic. Plot the frequency of females and males.  Be sure to give an accurate title and label the axes.**

```r
table(df$Sex)
```

```
## 
## female   male 
##    314    577
```

```r
counts <- table(df$Sex)
barplot(counts, main="Females and Males on the Titanic", xlab="Number", ylim=c(0,600))
```

![](CCobb_livesession3_files/figure-html/unnamed-chunk-2-1.png)<!-- -->



#### 3. Function Building (30 points): You research sleep and just got your first data set.  Later, you'll have another dataset with the same column names, so you want to create a helper function that you can analyze this dataset and the next.  Load sleep_data_01.csv (found at http://talklab.psy.gla.ac.uk/L1_labs/lab_1/homework/index.html).  Questions 3A through 3D should be answered in function(x){}.  3E can be outside of the function.  

+ a. Create objects for the median Age, the minimum and maximum Duration of sleep, and the mean and standard deviation of the Rosenberg Self Esteem scale (RSES).  You may need to specify a few options like in Problem 2 and live session. 

+ b. Create a data.frame object called report: it should consist of the median age, the RSES mean and standard deviation respectively divided by five (since there are five questions and these scores are summed), and the range of Duration (the statistical definition of range; it should be a single number.) 
  
+ c. Change the column names of this data.frame to MedianAge, SelfEsteem, SE_SD, and DurationRange. 

+ d. Round the report to at most 2 digits: leave this as the closing line to the function. 

+ e. Finally, run the function on your sleep data to show the output. 


```r
sleep <- read.csv('sleep_data_01.csv')
summary(sleep)
```

```
##      SubjID         Age         Gender           PSQI      
##  Min.   :  1   Min.   :12   Min.   :1.000   Min.   : 1.00  
##  1st Qu.: 26   1st Qu.:12   1st Qu.:1.000   1st Qu.: 4.00  
##  Median : 51   Median :14   Median :1.000   Median : 5.00  
##  Mean   : 51   Mean   :14   Mean   :1.337   Mean   : 6.22  
##  3rd Qu.: 76   3rd Qu.:15   3rd Qu.:2.000   3rd Qu.: 8.00  
##  Max.   :101   Max.   :18   Max.   :2.000   Max.   :17.00  
##                NA's   :7                    NA's   :1      
##     PSAScog           FOMO           SMUISa           SM1       
##  Min.   : 5.00   Min.   :10.00   Min.   : 6.00   Min.   : 0.00  
##  1st Qu.:12.00   1st Qu.:14.00   1st Qu.:12.00   1st Qu.:13.00  
##  Median :15.00   Median :17.00   Median :17.00   Median :15.00  
##  Mean   :17.21   Mean   :19.71   Mean   :16.48   Mean   :15.08  
##  3rd Qu.:21.00   3rd Qu.:24.00   3rd Qu.:21.00   3rd Qu.:18.00  
##  Max.   :36.00   Max.   :45.00   Max.   :30.00   Max.   :26.00  
##  NA's   :4       NA's   :6       NA's   :7       NA's   :8      
##       SM2            HADSa            HADSd             RSES      
##  Min.   : 0.00   Min.   : 0.000   Min.   : 0.000   Min.   : 3.00  
##  1st Qu.: 8.00   1st Qu.: 6.000   1st Qu.: 2.000   1st Qu.:15.00  
##  Median :15.50   Median : 8.000   Median : 5.000   Median :18.00  
##  Mean   :14.28   Mean   : 8.598   Mean   : 4.739   Mean   :18.11  
##  3rd Qu.:20.00   3rd Qu.:11.000   3rd Qu.: 7.000   3rd Qu.:22.00  
##  Max.   :28.00   Max.   :20.000   Max.   :13.000   Max.   :34.00  
##  NA's   :9       NA's   :9        NA's   :9        NA's   :14     
##     Bedtime         Latency          Duration     
##  Min.   : 8.75   Min.   :  1.00   Min.   : 4.000  
##  1st Qu.:10.00   1st Qu.: 10.00   1st Qu.: 7.000  
##  Median :11.00   Median : 20.00   Median : 8.000  
##  Mean   :11.08   Mean   : 27.29   Mean   : 7.717  
##  3rd Qu.:12.00   3rd Qu.: 30.00   3rd Qu.: 9.000  
##  Max.   :16.00   Max.   :180.00   Max.   :11.000  
##                                   NA's   :3
```



```r
median_age <- median(sleep$Age, na.rm=TRUE)
median_age
```

```
## [1] 14
```

```r
duration <- sleep$Duration
max(duration, na.rm = TRUE)
```

```
## [1] 11
```

```r
min(duration, na.rm = TRUE)
```

```
## [1] 4
```

```r
standardDev <- sd(sleep$RSES, na.rm=TRUE)
meanRSES <- mean(sleep$RSES, na.rm =TRUE)
standardDev
```

```
## [1] 6.176522
```

```r
meanRSES
```

```
## [1] 18.11494
```


```r
diff <- (max(duration, na.rm = TRUE) - min(duration, na.rm = TRUE))
report <- data.frame("MedianAge"=median_age, "SelfEsteem" = meanRSES, "SE_SD" = (standardDev/5), "DurationRange"= diff)
report[] <- lapply(report, function(x) if(is.numeric(x)) round(x, 2) else x)
report
```

```
##   MedianAge SelfEsteem SE_SD DurationRange
## 1        14      18.11  1.24             7
```

####4. FiveThirtyEight Data (30 points): Navigate on GitHub to https://github.com/rudeboybert/fivethirtyeight and read README.md. It will include everything you need.  
+ a. Install the fivethirtyeight package. 
+ b. In the listing of Data sets in package 'fivethirtyeight,' assign the 22nd data set to an object 'df.' 
+ c. Use a more detailed list of the data sets to write out the URL in a comment to the related news story. 
+ d. Using R command(s), give the dimensions and column names of this data frame. 

install.packages("fivethirtyeight")


```r
library(fivethirtyeight)
df <- fivethirtyeight::college_recent_grads
dim(df)
```

```
## [1] 173  21
```


vignette("fivethirtyeight", package = "fivethirtyeight")
#http://fivethirtyeight.com/features/the-economic-guide-to-picking-a-college-major/


#### 5. Data Summary (30 points): Use your newly assigned data frame from question 4 for this question.  
+ a. Write an R command that gives you the column names of the data frame.  Right after that, write one that counts the number of columns but not rows.  Hint: The number should match one of your numbers in Question 1d for dimensions. 
+ b. Generate a count of each unique major_category in the data frame.  I recommend using libraries to help.  To be clear, this should look like a matrix or data frame containing the major_category and the frequency it occurs in the dataset.  Assign it to major_count. + c. To make things easier to read, put par(las=2) before your plot to make the text perpendicular to the axis.  Make a barplot of major_count.  Make sure to label the title with something informative (check the vignette if you need), label the x and y axis, and make it any color other than grey.  Assign the major_category labels to their respective bar.  Flip the barplot horizontally so that bars extend to the right, not upward.  All of these options can be done in a single pass of barplot(). Note: It's okay if it's wider than the preview pane. 
+ d. Write the fivethirtyeight data to a csv file.  Make sure that it does not have row labels.


```r
colnames(df)
```

```
##  [1] "rank"                        "major_code"                 
##  [3] "major"                       "major_category"             
##  [5] "total"                       "sample_size"                
##  [7] "men"                         "women"                      
##  [9] "sharewomen"                  "employed"                   
## [11] "employed_fulltime"           "employed_parttime"          
## [13] "employed_fulltime_yearround" "unemployed"                 
## [15] "unemployment_rate"           "p25th"                      
## [17] "median"                      "p75th"                      
## [19] "college_jobs"                "non_college_jobs"           
## [21] "low_wage_jobs"
```

```r
ncol(df)
```

```
## [1] 21
```



```r
library(plyr)
major_count <- count(df, 'major_category')
major_count
```

```
##                         major_category freq
## 1      Agriculture & Natural Resources   10
## 2                                 Arts    8
## 3               Biology & Life Science   14
## 4                             Business   13
## 5          Communications & Journalism    4
## 6              Computers & Mathematics   11
## 7                            Education   16
## 8                          Engineering   29
## 9                               Health   12
## 10           Humanities & Liberal Arts   15
## 11 Industrial Arts & Consumer Services    7
## 12                   Interdisciplinary    1
## 13                 Law & Public Policy    5
## 14                   Physical Sciences   10
## 15            Psychology & Social Work    9
## 16                      Social Science    9
```


```r
barplot(major_count$freq, main="Count of Recent Graduating Majors", names.arg=major_count$major_category, las=2, xlab= 'Frequency', cex.names = .6, col="green", xlim=c(0,30), horiz = TRUE)
```

![](CCobb_livesession3_files/figure-html/barplot-1.png)<!-- -->


```r
write.csv(df, file="fivethirtyeight.csv", row.names=FALSE)
```


#### 6. Codebook (30 points):  
+ a. Start a new repository on GitHub for your SMU MSDS homework.  On your local device, make sure there is a directory for Homework at the minimum; you are welcome to add whatever you would like to this repo in addition to your requirements here.

```r
browseURL("https://github.com/ccobb73/SMU_MSDS_homework")
```

+ b. Create a README.md file which explains the purpose of the repository, the topics included, the sources for the material you post, and contact information in case of questions. Remember, the one in the root directory should be general.  You are welcome to make short READMEs for each assignment individually in other folders. 

```r
browseURL("https://github.com/ccobb73/SMU_MSDS_homework/blob/master/README.md")
```
+ c. In one (or more) of the nested directories, post your RMarkdown script, HTML file, and data from 'fivethirtyeight.'  Make sure that in your README or elsewhere that you credit fivethirtyeight in some way.

```r
browseURL("https://github.com/ccobb73/SMU_MSDS_homework/tree/master/Unit3")
```

+ d. In your RMarkdown script, please provide the link to this GitHub so the grader can see it.

```r
browseURL("https://github.com/ccobb73/SMU_MSDS_homework")
```

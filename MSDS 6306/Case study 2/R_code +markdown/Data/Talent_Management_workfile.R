# 2a
# Read raw data

casedata=data.table::as.data.table(readxl::read_excel("C:/Users/che/Desktop/SMU Books/MSDS 6306 Stuff/Case study 2/R_code +markdown/Data/CaseStudy2-data.xlsx"))
save(casedata,file="C:/Users/che/Desktop/SMU Books/MSDS 6306 Stuff/Case study 2/R_code +markdown/Data/CaseStudy2-data.RData")
load("C:/Users/che/Desktop/SMU Books/MSDS 6306 Stuff/Case study 2/R_code +markdown/Data/CaseStudy2-data.RData")
dim(casedata)
str(casedata)

# Explore data structure and print number of data rows/columns
str(casedata)
cat(paste("Rows:\t",
          dim(casedata)[1],
          "\nColumns:",
          dim(casedata)[2]
          )
    )

# 2b-d
# Clean raw data names and shorten under 12 characters
names(casedata)[3] = "TravelFreq"
names(casedata)[6] = "Distance"
names(casedata)[8] = "EducField"
names(casedata)[9] = "Count"
names(casedata)[10] = "EmployeeNum"
names(casedata)[11] = "EnvironRate"
names(casedata)[14] = "JobInvolve"
names(casedata)[17] = "JobSatis"
names(casedata)[18] = "Marriage"
names(casedata)[19] = "MonIncome"
names(casedata)[21] = "NumCompany"
names(casedata)[24] = "PayIncPct"
names(casedata)[25] = "Performance"
names(casedata)[26] = "Relationship"
names(casedata)[27] = "StdHours"
names(casedata)[28] = "StockOption"
names(casedata)[29] = "YearsWorked"
names(casedata)[30] = "TrainLastYr"
names(casedata)[31] = "WorkLifeBal"
names(casedata)[32] = "YearsAtComp"
names(casedata)[33] = "YearsInPos"
names(casedata)[34] = "LstPromoted"
names(casedata)[35] = "YearsSprvsr"

# 2d
# Convert numeric categorical variables to factors
general_ratings = c("Low", "Medium", "High", "Very High")
casedata$EnvironRate = factor(casedata$EnvironRate, labels=general_ratings)
casedata$JobInvolve = factor(casedata$JobInvolve, labels=general_ratings)
casedata$JobSatis = factor(casedata$JobSatis, labels=general_ratings)
# Though Job Level does not have equivalent string factors, the numbers will be converted to factors
casedata$JobLevel = as.factor(casedata$JobLevel)

# 1/2 (Low/Medium) factors omitted, as nobody in data set ranked their performance lower than 3
casedata$Performance = factor(casedata$Performance,
                                        labels=c("Excellent", "Outstanding")
                                        )
casedata$Relationship = factor(casedata$Relationship, labels=general_ratings)
casedata$WorkLifeBal = factor(casedata$WorkLifeBal,
                                        labels=c("Bad", "Good", "Better", "Best")
                                        )
casedata$Education = factor(casedata$Education,
                                      labels=c("Below College", "College", "Bachelor", "Master", "Doctor")
                                      )
casedata$StockOption = factor(casedata$StockOption)

# 3b
# Select 7 relevant numeric variables for descriptive statistics table
casedata_nstats = casedata[, c("Age",
                          "MonIncome",
                          "PayIncPct",
                          "Distance",
                          "YearsWorked",
                          "YearsAtComp",
                          "LstPromoted",
                          "YearsInPos"
                          )]

# Print data.frame of descriptive statistics of 7 variables
casedata_desc_stats = as.data.frame(sapply(casedata_nstats, summary))
casedata_desc_stats

# Create histograms for Age and Monthly Income
par(mfrow=c(1,2))
hist(casedata_nstats$Age,
     main="Distribution of Age",
     xlab="Age"
     )
hist(casedata_nstats$MonIncome,
     main="Distribution of Monthly Income",
     xlab="Monthly Income"
     )

# Description (add as normal text in Rmd):
# Age appears fairly normally distributed about the mean with some slight right skew.
# Monthly Income appears heavily right skewed, and also appears bimodal at approximately 5,000 and 20,000.

# 3c
# Get frequency of Education, Gender and Occupation
casedata_factors = casedata[, c("Gender",
                                     "Education",
                                     "JobRole"
                                     )
                                 ]
list_freq = sapply(sapply(casedata_factors, table), prop.table)
casedata_gender_freq = as.data.frame(list_freq[1])
casedata_educ_freq = as.data.frame(list_freq[2])
casedata_occup_freq = as.data.frame(list_freq[3])
names(casedata_gender_freq) = c("Gender", "Frequency")
names(casedata_educ_freq) = c("EducationLevel", "Frequency")
names(casedata_occup_freq) = c("JobTitle", "Frequency")
casedata_gender_freq
casedata_educ_freq
casedata_occup_freq

# Compare attrition rate betwen different groups of monthly income
salary_bins = c("0-5k", "5-10k", "10-15k", "15-20k")
casedata$IncLevels = cut(casedata$MonIncome,
                                   breaks=c(0, 5000, 10000, 15000, 20000),
                                   labels=salary_bins
                                   )
# Calculate % of employees attrition w/in salary groups
sal_counts = summary(casedata$IncLevels)
attrit_by_sal_pct = numeric()
for (level in salary_bins) {
  yes_attrit = length(casedata$IncLevels[casedata$Attrition == "Yes"
                                                   & casedata$IncLevels == level
                                                   ]
                      )
  attrit_by_sal_pct[level] = yes_attrit / sal_counts[level] * 100
}

# Plot results as a bar chart
par(mfrow=c(1,1))
barplot(attrit_by_sal_pct,
        ylim=c(0, 25),
        main="Attrition Rate by Salary Level",
        ylab="Attrition (% Yes)",
        xlab="Salary (Monthly Income)"
        )

# Comparing percent salary hike vs attrition
casedata$RaiseFactor = as.factor(casedata$PayIncPct)
raise_counts = summary(casedata$RaiseFactor)
attrit_by_raise_pct = numeric()
for (level in levels(casedata$RaiseFactor)) {
  yes_attrit = length(casedata$RaiseFactor[casedata$Attrition == "Yes"
                                                     & casedata$RaiseFactor == level
                                                     ]
                      )
  attrit_by_raise_pct[level] = yes_attrit / raise_counts[level] * 100
}

# Plot results as a scatterplot
plot(x=levels(casedata$RaiseFactor),
     y=attrit_by_raise_pct,
        ylim=c(0, 30),
        main="Attrition Rate by Raise Percentage",
        ylab="Attrition (% Yes)",
        xlab="Price Increase (%)"
)

## Function to quickly find frequencies for unique values and associated attrition
## Create Funciton to find Frequency vs Attrition to put on a table later
fun_findfreq <- function(str_column, casedata_input, counts_not_frequency = FALSE){
  vec_attr_rates = vector()
  casedata_output_freq = data.frame()
  # find total observations
  total = length(casedata_input[casedata_input[,str_column]])
  # find unique entries // if summary gives quatriles use unique instead of summary
  vec_uniquevalues = summary(casedata_input[,str_column])
  
  # set the frequency of the unique entries in the dataframe,
  casedata_output_freq = as.data.frame(names(vec_uniquevalues))
  colnames(casedata_output_freq) = str_column; 
  if (!counts_not_frequency) {casedata_output_freq["Frequency"] = (round(vec_uniquevalues/total, digits = 2))}
  else {casedata_output_freq["Count"] = (round(vec_uniquevalues, digits = 2))}
  
  # for loop to find attrition
  for (element in casedata_output_freq[,str_column]){
    int_temp_attr = length(casedata_input[casedata_input[,str_column] == element & 
                                       casedata_input$Attrition == "Yes"
                                     ,str_column])
    int_temp_attr_perc = int_temp_attr / 
      length(casedata_input[casedata_input[,str_column] == element, str_column])
    vec_attr_rates = c(vec_attr_rates, int_temp_attr_perc)
  }
  # Add attrition stats in dataframe
  casedata_output_freq["Attrition"] = round(vec_attr_rates, digits = 2)
  return(casedata_output_freq)
}

## Get & Set Attrition for Occupation
casedata_jobsatis_freq = data.frame()
casedata_jobsatis_freq = fun_findfreq("JobSatis", casedata)

## Get & Set Attrition for Performance
casedata_performance_freq = data.frame()
casedata_performance_freq = fun_findfreq("Performance", casedata)

## Get & Set Attrition for Gender
casedata_gender_freq = data.frame()
casedata_gender_freq = fun_findfreq("Gender", casedata)

## Get & Set Attrition for Education
casedata_educ_freq = data.frame()
casedata_educ_freq = fun_findfreq("Education", casedata)

## Get & Set Attrition for Education
casedata_occup_freq = data.frame()
casedata_occup_freq = fun_findfreq("JobRole", casedata)

## Get & Set Attrition for Job Level
casedata_joblevel_freq = data.frame()
casedata_joblevel_freq = fun_findfreq("JobLevel", casedata)

## Get & Set Attrition for Stock Option
casedata_stockoption_freq = data.frame()
casedata_stockoption_freq = fun_findfreq("StockOption", casedata)

## Get & Set Attrition for Job Involvement
casedata_jobinvolve_freq = data.frame()
casedata_jobinvolve_freq = fun_findfreq("JobInvolve", casedata)

## Get Management Position counts
casedata_managerlevel_counts = data.frame()
casedata_managerlevel_counts = fun_findfreq("JobRole", casedata, counts_not_frequency = TRUE)
casedata_managerlevel_countsdisplay = casedata_managerlevel_counts[casedata_managerlevel_counts$JobRole == 
                                                           c("Manager", "Manufacturing Director", "Research Director"),]

# Display tables as percentages for printing
#   df: dataframe to display as percentage
#   skip: vector of column names not to convert
library('scales')
as_pct = function (casedata, skip=c()) {
  new_df = df
  for (var in names(new_df)) {
    if (is(new_df[, var], "numeric") && ! var %in% skip) {
      new_df[, var] = percent(new_df[, var])
    }
  }
  new_df
}
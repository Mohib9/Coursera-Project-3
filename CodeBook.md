Code Book
=========

This document provides the insight into how the entire process of
getting the required means was carried out inside run\_analysis.R.

**1.Reading files into data tables** -After downloading the data set, I
used ‘read.table’ command to assign variables to the various data sets.

*features &lt;- features.txt* contains 561 obs. of 2 variables. The
features selected for this database come from the accelerometer and
gyroscope 3-axial raw signals.

*activity &lt;- activity\_labels.txt* contains 6 obs. of 2 variables.The
features selected for this database come from the accelerometer and
gyroscope 3-axial raw signals

*x\_test &lt;- X\_test.txt* contains 2947 obs. of 561 variables. It
contains recorded features test data.

*y\_test &lt;- y\_test.txt* contains 2947 obs. of 1 variable. It
basically contains test data of activities’code labels.

*subject\_test &lt;- subject\_test.txt* contains 2947 obs. of 1
variable. It contains test data for 9 of the 30 volunteers.

*x\_train &lt;- X\_train.txt* contains 7352 obs. of 561 variables. It
contains recorded features train data.

*y\_train &lt;- y\_train.txt* contains 7352 obs. of 1 variable. It
basically contains train data of activities’code labels.

*subject\_train &lt;- subject\_train.txt* contains 7352 obs. of 1
vaariable. It contains train data for 21 of the 30 volunteers.

**2.Renaming Columns** -Renamed the single column of ‘subject\_train’
and ‘subject\_test’ to “ID”. Similarly, renamed ‘y\_test’ and ‘y\_train’
column “label”.

-Also renmaed the column names of ‘x\_train’ and ‘x\_test’ with the
formulas column of features using:

*names(x\_train) &lt;- c(as.character(features$formulas))*

*names(x\_test) &lt;- c(as.character(features$formulas))*

**3.Merging Data** -Combined the test data using cbind creating new data
table ‘joined\_test’ having 2947 obs. and 563 variables.

-Similarly created ‘joined\_train’ combing train data having 7352 obs.
and 563 variables.

-Finally made a joint table of test and train data using rbind to have a
new data table named ‘comb\_data’ having 10299 obs. and 563 variables.

**4.Extracting only Mean and Standard deviation** -Used grep function to
identify columns with mean or std and stored the result in ‘stdmeancols’
having identified 86 columns.

-Since we cant to keep the ID and label columns as well, we have another
variable ‘req\_columns’ having the first 2 columns alongwtih the
stdmeancols.

-Finally, we extract the required columns and save the result in a new
cariable called ‘extracted\_data’ having 10299 obs. and 88 variables.

**5.Using Descriptive Activity Names** -All the activity labels in the
‘extracted\_data’ is replaced with full activity names.

**6.Having Descriptive Variable Names** -Removed regular expressions
from the names to be more relevent. However, I did not rename the entire
variables as it would have made it all too verbose. The current state is
concise and understandable.

**7.Calculating Mean in a Separate Data Table** -After grouping the
data, calculated the mean and saved it in a separate table called
‘finalized’. Wrote the data table into a txt file as instructed.

# Procedures

Run the script: `run_analysis.R` which performs the 5 steps described in the course project's definition.

* The first step uploads and merges the raw data together using the rbind() function.
* Second, only the fields with the mean (‘mean’) and standard deviation (‘std’) are taken from the data set and are assigned their field names through the ‘features.txt’ file.
* Next, the activity labels are updated in the data set (since the raw activity data has values 1-6) from the ‘activity_labels.txt’ file.
* Then assign appropriate field names.
* Lastly, a new data set is created with the average measures for each subject and activity file.  Output file: ‘tidy_averages_data_set.txt’.

# Variables

* `x_train`, `y_train`, `x_test`, `y_test`, `set_train` and `set_test` contain the data from the raw files.
* `x_data`, `y_data` and `aggregate_data` merge the previous datasets.
* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in `mean_and_std_data`.
* The same is done with activity names through the `activities` variable.
* `all_data` merges `x_data`, `y_data` and `aggregate_data` into a consolidated data set.
* `averages_data` contains the averages which will be later stored in a `.txt` file. `ddply()` from the plyr package is used to apply `colMeans()`.
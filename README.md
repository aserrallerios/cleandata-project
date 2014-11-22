Steps to run the R script:

1. Unzip the `getdata_projectfiles_UCI HAR Dataset.zip` file in the same directory of the file `run_analysis.R`.
2. `plyr` and `data.table` R packages are required.

What it does?

1. Reads subjects, activities, features and measurements files of 'test' and 'train' into R data.frames.
2. Replaces activity codes by ther proper labels.
3. Merges each subject with his/her activities.
4. Proper column names for subjects and activities.
5. Filter `mean` and `std` features from the measurements columns.
6. Set feature names to each measurement column.
7. Merge measurements with each subject/activity.
8. Join 'test' and 'train' subjects.
9. Apply the mean to each measurement, grouped by subject and activity.
10. Sort the result by subject and activity.

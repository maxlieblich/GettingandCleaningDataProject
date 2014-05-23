## Code Book

The script run_analysis.R does the following: 

- Reads the raw testing and training data files (located in the "UCI HAR Dataset" directory, in the "test" and "train" subdirectories)
- Reads the feature names and activity names from the files features.txt and activity_labels.txt in the "UCI HAR Dataset" directory
- Assigns the resulting feature names to the column names of the test and train data frames
- Attaches descriptive activity names and subject ids to each trial in the test and train data frames
- Merges the final test and train data using rbind
- Extracts only the columns (features) that parametrize mean and std values of the various parameters (for each trial) via grep (called from R in the usual way)
- Makes a tidy data frame that keeps only the means of the features extracted in the previous step, for each Activity and Subject
- Writes this tidy data frame to "tidy.csv"

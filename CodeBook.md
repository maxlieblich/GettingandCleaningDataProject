## Code Book

### The script run_analysis.R does the following: 

- Reads the raw testing and training data files (located in the "UCI HAR Dataset" directory, in the "test" and "train" subdirectories)
- Reads the feature names and activity names from the files features.txt and activity_labels.txt in the "UCI HAR Dataset" directory
- Assigns the resulting feature names to the column names of the test and train data frames
- Attaches descriptive activity names and subject ids to each trial in the test and train data frames
- Merges the final test and train data using rbind
- Extracts only the columns (features) that parametrize mean and std values of the various parameters (for each trial) via grep (called from R in the usual way)
- Makes a tidy data frame that keeps only the means of the features extracted in the previous step, for each Activity and Subject
- Renames the features to eliminate unnecessary symbols
- Writes this tidy data frame to "tidy.txt" as a csv file

### Feature description

- Each feature starts with t, indicating time series, or f, indicating frequency domain (post FFT). The "X", "Y" and "Z" indicate the appropriate axes of the accelerometer. When "Mag" appears in a feature name, it denotes the magnitude of the given vector (so there is no X, Y, or Z in the feature name)
- Features measure either Gravity or Body parameters. I.e., as the device moves, its coordinate frame moves relative to the Earth, so the gravity vector moves in the device's local coordinate system.
- Two devices are used: an accelerometer and a gyroscope. The corresponding features contain "Acc" or "Gyro"
- The derivative of the acceleration is called the jerk; features given by differentiating the time series are labeled with "Jerk" in the name
- For each quantity, only the mean and standard deviation are preserved for each sample. These contain "Mean" and "Std" in their names
- Examples: the name "tBodyAccJerkStd.Z" refers to the standard deviation of the Z component of the derivative of the non-gravity components of the accelerometer during a sample collection as a time series. The name "fBodyAccJerkStd.Z" refers to the standard deviation of the FFT of the Z component of that same sample collection.
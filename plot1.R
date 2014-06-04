### This function, plot1(), takes no input parameter
### but it reads the specified csv file from the working directory 
### then creates a png file, and writes to the file
### a histogram of a subset of the file's data.

plot1 <- function() {
        
        ## read.csv2() reads tabular data files 
        ## where the separator "," is a ";"
        ## (which is the case for this data)
        ##
        ## after some exploration, the first index for 
        ## 1 Feb 2007 was found to be 66637.
        ##
        ## using the knowledge that 
        ## the first index for 1 Feb 2007 is 66637 
        ## with the facts: 
        ## 		(1) R begins counting at 1,
        ## 		(2) each row of the table corresponds 
        ##			to an electricity sample at each minute,
        ##		(3) in 2 days there are
        ##
        ##             			    mins      hours
        ## 			2 days * 60 ---- * 24 ----- = 2880 mins ,
        ##             			    hour       day
        ##
        ## we can greatly reduce the number of lines to be read.
        energyData <- read.csv2("household_power_consumption.txt",
                                colClasses = "character",
                                nrows = 2880, skip = 66636)
        
        ## obtain data for global active power.
        ## convert data to numeric for plotting.
        rawGlobalActivePower <- energyData[[3]]
        globalActivePower <- as.numeric(rawGlobalActivePower)
        
        ## open png file editor
        ## create 480px-by-480px file, plot1.png 
        png(file = "plot1.png",
            width = 480,
            height = 480)
        
        ## plot histogram of global active power.
        ## red color, title "Global Active Power",
        ## x-axis label "Global Active Power (kilowatts)".
        hist(globalActivePower, col = "red",
             main = "Global Active Power",
             xlab = "Global Active Power (kilowatts)")
        
        ## close file editor.
        dev.off()        
}
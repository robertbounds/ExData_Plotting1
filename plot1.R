plot1 <- function() {
        
        ## read.csv2() reads csv files where "," is actually a ";"
        ## (which is the case for this data)
        
        ## after some exploration, the first index for 
        ## 1 Feb 2007 was found to be 66637.
        
        ## using the fact that R begins counting at 1,
        ## and also that in 2 days there are
        ##
        ##             mins      hours
        ## 2 days * 60 ---- * 24 ----- = 2880 mins ,
        ##             hour       day
        ##
        ## we can greatly reduce the number of lines to be read.
        
        energyData <- read.csv2("household_power_consumption.txt",
                                colClasses = "character",
                                nrows = 2880, skip = 66636)
        
        rawGlobalActivePower <- energyData[[3]]
        globalActivePower <- as.numeric(rawGlobalActivePower)
        ## this subset contains no NA values
        ## in the global_active_power column,
        ## so there are none to remove after
        ## conversion to numeric.
        
        
        png(file = "plot1.png",
            width = 480,
            height = 480)
        
        hist(globalActivePower, col = "red",
             main = "Global Active Power",
             xlab = "Global Active Power (kilowatts)")
        
        dev.off()        
}
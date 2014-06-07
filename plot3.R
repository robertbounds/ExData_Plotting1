plot3 <- function() {
        
        ## This function, plot3(), takes no input parameter,
        ## but it reads the specified csv file from the working directory 
        ## then creates a png file, and writes to the file
        ## a layered line plot of a few subsets of the file's data.
        ##
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
        ##                  to an electricity sample at each minute,
        ##		(3) in 2 days there are
        ##
        ##             			    mins      hours
        ## 			2 days * 60 ---- * 24 ----- = 2880 mins ,
        ##             			    hour       day
        ##
        ## we can greatly reduce the number of lines to be read.
        energyData <- read.csv2("household_power_consumption.txt",
                                colClasses = "character",
                                nrows = 2880, 
                                skip = 66636
                                )
        subMeter1  <- as.numeric(energyData[[7]])
        subMeter2  <- as.numeric(energyData[[8]])
        subMeter3  <- as.numeric(energyData[[9]])
        days       <- c("Thu", "Fri", "Sat")
        dayIndeces <- c(1, 1440, 2880)
        
        png(file = "plot3.png", width = 480, height = 480)
        
        par(bg = NA)
        
        plot(subMeter1,
             xaxt = "n",
             xlab = "",
             ylab = "Energy sub metering",
             type = "l"
             )
        
        lines(subMeter2, col = "red")
        lines(subMeter3, col = "blue")
        axis(1, at = dayIndeces, labels = days)
        legend("topright",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, 
               col = c("black", "red", "blue")
               )
        
        dev.off()
}
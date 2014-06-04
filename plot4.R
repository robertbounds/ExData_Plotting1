### This file, plot4.R, contains five functions:
###     (1) GAPplot;
###     (2) voltPlot;
###     (3) subMeterPlot;
###     (4) GRPplot;
###     (5) plot4.
###
### functions (1)-(4):
###     take required input parameters
###     (data, dayVec, and DayIndexVec)
###     to accordingly subset data, and create
###     the requested graph.

### GAPplot creates the line graph associated
### with global active power data
GAPplot <- function(data, dayVec, dayIndexVec) {
	
        globalActivePower <- as.numeric(data[[3]])
        
        ## generate plot
        plot(globalActivePower,
             xaxt = "n", xlab = "",
             ylab = "Global Active Power",
             type = "l")
        
        ## annotate plot with axis labels
        axis(1, at = dayIndexVec, labels = dayVec)
        
}

### voltPlot creates the line graph associated with voltage data
voltPlot <- function(data, dayVec, dayIndexVec) {
		
	voltage <- as.numeric(data[[5]])
	
        ## generate plot
	plot(voltage, xaxt = "n", xlab = "datetime",
             ylab = "Voltage", type = "l")
        
	## annotate plot with axis labels
        axis(1, at = dayIndexVec, labels = dayVec)

}

### subMeterPlot creates the layered line graph associated
### with the sub metering data subsets
subMeterPlot <- function(data, dayVec, dayIndexVec) {
		
	subMeter1 <- as.numeric(data[[7]])
        subMeter2 <- as.numeric(data[[8]])
        subMeter3 <- as.numeric(data[[9]])
        
        ## generate plot
        plot(subMeter1, xaxt = "n", xlab = "",
             ylab = "Energy sub metering", type = "l")
        
        ## annotate plot with 2nd and 3rd submetering data
        lines(subMeter2, col = "red")
        lines(subMeter3, col = "blue")
        
        ## annotate plot with x-axis labels
        axis(1, at = dayIndexVec, labels = dayVec)
        
        ## annotate plot with legend
        legend("topright",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, col = c("black", "red", "blue"), bty = "n")
}

### GRPplot creates the line graph associated
### with the global reactive power data
GRPplot <- function(data, dayVec, dayIndexVec) {
	
	globalReactivePower <- as.numeric(data[[4]])
	
        ## generate plot
	plot(globalReactivePower,
             xaxt = "n", xlab = "datetime",
             ylab = "Global_reactive_power",
             type = "l")
        
        ## annotate plot with x-axis labels
        axis(1, at = dayIndexVec, labels = dayVec)
}

### the plot4 function is tasked with reading in the
### necessary information from the data table,
### opening a png editor, and then calling each of
### the four screen plotting functions to write their
### images to the opened png file.
plot4 <- function() {
	
        ## read in and create required data and vectors
        ## to send as parameters to above plotting functions.
        energyData <- read.csv2("household_power_consumption.txt",
                                colClasses = "character",
                                nrows = 2880, skip = 66636)
        days <- c("Thu", "Fri", "Sat")
        dayIndeces <- c(1, 1440, 2880)
        
        ## open png file editor
        ## create 480px-by-480px file, plot4.png
        png(file = "plot4.png",
            width = 480,
            height = 480)
        	
        ## create a 2x2 "frame" (filled row-wise) for juxtaposing graphics
	par(mfrow = c(2, 2))
        
        ## plotting functions called in sequence to fill the 2x2 frame
        GAPplot(energyData, days, dayIndeces)
        voltPlot(energyData, days, dayIndeces)
        subMeterPlot(energyData, days, dayIndeces)
        GRPplot(energyData, days, dayIndeces)
        
        ## close file editor
        dev.off()
}
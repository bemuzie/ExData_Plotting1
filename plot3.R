setwd('~/ExData_Plotting1')
if (Sys.getlocale('LC_TIME')=='ru_RU.UTF-8'){
  # needed to print time axis in english language, tested only on Ubuntu 12.04
  Sys.setlocale("LC_TIME", "C")
}

#loading data set which is placed one level upper
data <- read.table('../household_power_consumption.txt',
                   sep=';',
                   header=TRUE,
                   na.strings='?',
                   as.is=c('Date','Time')) #without this R will convert Date and Time to factor variables
#subset data here to make Date&Time data class converting little bit faster 
data <- subset(data,Date %in% c('1/2/2007','2/2/2007')) 
#convert Date and Time columns from factor class to time and data classes
data$Time <- strptime(paste(data$Date,data$Time),  
                      format='%d/%m/%Y %H:%M:%S',
                      tz='GMT')
data$Date <- as.Date(data$Date,format='%d/%m/%Y')

#Plotting 
plotting3 <- function(){ 
  
  plot(data$Time,data$Sub_metering_1,
       type='l',
       main = "",
       xlab="",
       ylab="Energy of sub metering",
  )
  
  lines(data$Time,data$Sub_metering_2,
        col='red')
  lines(data$Time,data$Sub_metering_3,
        col='blue')
  legend('topright',
         c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         col=c("black","red","blue"),
         lty=1
           )
  
}
#Saving plot
png(filename="Plot3.png",
    bg='transparent' #make backround transparent like in example figures
)
plotting3()
dev.off()

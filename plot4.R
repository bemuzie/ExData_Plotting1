if (Sys.getlocale('LC_TIME')=='ru_RU.UTF-8'){
  # needed to print time axis in english language, tested only on Ubuntu 12.04
  Sys.setlocale("LC_TIME", "C")
}

#loading data set which is placed one level upper
data <- read.table('../household_power_consumption.txt',
                   sep=';',
                   header=TRUE,
                   na.strings='?',
                   as.is=c('Date','Time')) #force 'utils::read.table' keep Date and Time as character variables

#subset data here to make Date & Time class converting little bit faster 
data <- subset(data,Date %in% c('1/2/2007','2/2/2007'))
#convert Date and Time columns to time class
data$Date.Time <- strptime(paste(data$Date,data$Time),  
                           format='%d/%m/%Y %H:%M:%S',
                           tz='GMT')
#Plotting 


plotting <- function(){ 
  par(mfrow=c(2,2))  
  #1st subplot
  plot(data$Time,
       data$Global_active_power,
       type='l',
       main = "",
       xlab="",
       ylab="Global Active Power (kilowatts)",
  )
  #2nd sublot
  plot(data$Date.Time,data$Voltage,
       type='l',
       main = "",
       xlab="datetime",
       ylab="Voltage",
  )
  
  
  #3d subplot
  plot(data$Date.Time,data$Sub_metering_1,
       type='l',
       main = "",
       xlab="",
       ylab="Energy of sub metering",
  )
  
  lines(data$Date.Time,data$Sub_metering_2,
        col='red')
  lines(data$Date.Time,data$Sub_metering_3,
        col='blue')
  legend('topright',
         c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         col=c("black","red","blue"),
         lty=1,
         bty = "n"
  )
  
  #4th subplot
  plot(data$Date.Time,data$Global_reactive_power,
       type='l',
       main = "",
       xlab="datetime",
       ylab="Global_reactive_power",
  )
  
  
}
#Saving plot
png(filename="Plot4.png",
    bg='transparent' #make backround transparent like in example figures
)
plotting()


dev.off()

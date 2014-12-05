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

#all plotting procedures are in function to separate plotting and saving part of the code. 
#Seems dev.copy() isnt a good method for making exact copies of plots. 
plotting <- function(){ 
  with(data,{
    #making blank plot with appropriate axis ranges
    plot(range(Date.Time),range(Sub_metering_1,Sub_metering_2,Sub_metering_3), 
         type='n',
         main = "",
         xlab="",
         ylab="Energy of sub metering")
    lines(Date.Time,Sub_metering_1, col='black')
    lines(Date.Time,Sub_metering_2, col='red')
    lines(Date.Time,Sub_metering_3, col='blue')
    legend('topright',
           c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           col=c("black","red","blue"),
           lty=1)
  })
}
#Saving plot
png(filename="Plot3.png",
    bg='transparent' #make backround transparent like in example figures
)
plotting()
dev.off()

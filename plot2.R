if (Sys.getlocale('LC_TIME')=='ru_RU.UTF-8'){
  # needed to print time axis in english language, tested only on Ubuntu 12.04
  Sys.setlocale("LC_TIME", "C")
}
setwd('/home/denest/ExData_Plotting1')
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
      plot(data$Date.Time,
           data$Global_active_power,
           type='l',
           main = "",
           xlab="",
           ylab="Global Active Power (kilowatts)",
  )
}
#Saving plot
png(filename="Plot2.png",
    bg='transparent' #make backround transparent like in example figures
)
plotting()
dev.off()
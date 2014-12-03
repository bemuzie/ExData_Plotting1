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
                        hist(data$Global_active_power,
                             col='red',
                             main = "Global Active Power",
                             xlab="Global Active Power (kilowatts)",
                             ylab="Frequency",
                             )
                      }

#Saving plot
png(filename="Plot1.png",
    bg='transparent' #make backround transparent like in example figures
    )
plotting()
dev.off()
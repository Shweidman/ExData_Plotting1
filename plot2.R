setwd("C:/Users/weidse51/Documents/Coursera/Data Science/Exploratory Data Analysis/")
data <- read.table("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors=FALSE)

##Convert Date and Time into a formatted "datetime" variable
dateTime0<-paste(data$Date,data$Time)
datetime<-strptime(dateTime0,"%d/%m/%Y %H:%M:%S")
data<-cbind(data[,1:9],datetime)

##Subset out only rows to be used.
dataCut <- data[data$datetime>=as.POSIXct("2007-02-01 00:00:00"),]
dataFinal <- dataCut[dataCut$datetime<as.POSIXct("2007-02-03 00:00:00"),]
dataFinal <- dataFinal[complete.cases(dataFinal),]

##Add a weekday variable for the charts
weekdays <- weekday(dataFinal$datetime)
dataFinal <- cbind(dataFinal,weekdays)

##Add a timeIndex variable for the x-axis
timeIndex <- 1:nrow(dataFinal)
dataFinal <- cbind(dataFinal,timeIndex)

##Make the plot

png(file = "plot2.png", height = 480, width = 480)
plot(dataFinal$timeIndex,dataFinal$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",xaxt='n')
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
dev.off()
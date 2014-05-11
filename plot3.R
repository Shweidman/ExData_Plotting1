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

png(file = "plot3.png", height = 480, width = 480)
timeIndex <- 1:nrow(dataFinal)
cbind(dataFinal,timeIndex)
plot(dataFinal$timeIndex,dataFinal$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",xaxt='n')
lines(dataFinal$timeIndex,y=dataFinal$Sub_metering_2,col="red")
lines(dataFinal$timeIndex,y=dataFinal$Sub_metering_3,col="blue")
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
legend(x = "topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1)
dev.off()
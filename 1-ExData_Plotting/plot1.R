## plot 1. histogram of Global Active Power

dt<-read.table("household_power_consumption.txt",sep=";",
               header=TRUE,stringsAsFactors=FALSE)
## read data

dt$Time<-strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %H:%M:%S")
dt$Date<-as.Date(dt$Date,"%d/%m/%Y")
## convert Date and Time variables 

dt_s<-subset(dt,Date=="2007-02-01"|Date=="2007-02-02")
## subset datasets from dates 2007-02-01 and 2007-02-02

hist(as.numeric(dt_s$Global_active_power),col="red",
     xlab="Global Active Power (kilowatts)",main="Global Active Power")
## plot histogram

dev.copy(png,"plot1.png",width=480,height=480,units="px")
dev.off()
## save plot to PNG file

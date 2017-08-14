## plot 2. Global Active Power as a function of Time

dt<-read.table("household_power_consumption.txt",sep=";",
               header=TRUE,stringsAsFactors=FALSE)
## read data

dt$Time<-strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %H:%M:%S")
dt$Date<-as.Date(dt$Date,"%d/%m/%Y")
## convert Date and Time variables 

dt_s<-subset(dt,Date=="2007-02-01"|Date=="2007-02-02")
## subset datasets from dates 2007-02-01 and 2007-02-02

plot(dt_s$Time,dt_s$Global_active_power,type="l",xlab=NA,
     ylab="Global Active Power (kilowatts)")
## plot Global_active_power vs Time

dev.copy(png,"plot2.png",width=480,height=480,units="px")
dev.off()
## save plot to PNG file

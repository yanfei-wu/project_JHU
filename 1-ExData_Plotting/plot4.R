## plot 4

dt<-read.table("household_power_consumption.txt",sep=";",
               header=TRUE,stringsAsFactors=FALSE)
## read data

dt$Time<-strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %H:%M:%S")
dt$Date<-as.Date(dt$Date,"%d/%m/%Y")
## convert Date and Time variables 

dt_s<-subset(dt,Date=="2007-02-01"|Date=="2007-02-02")
## subset datasets from dates 2007-02-01 and 2007-02-02

par(mfrow = c(2,2),oma=c(0,0,1,0)+0.2,mar=c(4,4,0,0)+0.5)

with(dt_s,{
     plot(Time,Global_active_power,type="l",xlab=NA,
          ylab="Global Active Power (kilowatts)")
     plot(Time,Voltage,type="l",xlab="datetime")
})
## plot the top two plots

with(dt_s,{
    plot(Time,Sub_metering_1,xlab=NA,
               ylab="Energy sub metering",type="n")
    lines(Time,Sub_metering_1,col="black")
    lines(Time,Sub_metering_2,col="red")
    lines(Time,Sub_metering_3,col="blue")
    })
legend("topright",lty=1,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n",cex=0.75)
## plot the bottom left plot

with(dt_s,plot(Time,Global_reactive_power,type="l",xlab="datetime"))
## plot the bottom right plot

dev.copy(png,"plot4.png",width=480,height=480,units="px")
dev.off()
## save plot to PNG file






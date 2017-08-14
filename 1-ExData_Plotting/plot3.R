## plot 3. Sub_metering as a function of Time

dt<-read.table("household_power_consumption.txt",sep=";",
               header=TRUE,stringsAsFactors=FALSE)
## read data

dt$Time<-strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %H:%M:%S")
dt$Date<-as.Date(dt$Date,"%d/%m/%Y")
## convert Date and Time variables 

dt_s<-subset(dt,Date=="2007-02-01"|Date=="2007-02-02")
## subset datasets from dates 2007-02-01 and 2007-02-02

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
       cex=0.75)
## Plot Sub_metering_1 through Sub_metering_3 vs Time

dev.copy(png,"plot3.png",width=480,height=480,units="px")
dev.off()
## save plot to PNG file

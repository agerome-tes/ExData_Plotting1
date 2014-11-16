# load data and add a new column with the date column converted into a date and another one as the concatenation of the date and time columns
library(plyr)
data1<-read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "?")
data2<-mutate(
  data1,
  Date2=strptime(data1$Date,"%d/%m/%Y"),
  DateTime=strptime(paste(data1$Date,data1$Time," "),"%d/%m/%Y %H:%M:%S")
)

# subset data
data3<-data2[data2$Date2=="2007-02-01"|data2$Date2=="2007-02-02",]

# open png device for a 480x480px image 2x2 layout
png(file="plot4.png",width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))

# plot 1
with(
  data3,
  plot(
    x=DateTime,
	y=Global_active_power,
	xlab="",
	ylab="Global Active Power",
	type="l"
  )
)
# plot 2
with(data3,plot(x=DateTime,y=Voltage,xlab="datetime",type="l"))
# plot 3
with(data3,plot(x=DateTime,y=Sub_metering_1,col="black",xlab="",ylab="Energy sub metering",type="l"))
with(data3,lines(x=DateTime,y=Sub_metering_2,col="red"))
with(data3,lines(x=DateTime,y=Sub_metering_3,col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty="n")
# plot 4
with(data3,plot(x=DateTime,y=Global_reactive_power,xlab="datetime",type="l"))

# close device
dev.off()
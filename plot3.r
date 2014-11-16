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

# open png device for a 480x480px image, insert plot and line graph
png(file="plot3.png",width = 480, height = 480, units = "px")
# blank x axis title, custom y axis title, black line for Sub_metering_1
with(data3,plot(x=DateTime,y=Sub_metering_1,col="black",xlab="",ylab="Energy sub metering",type="l"))
# red line for Sub_metering_2
with(data3,lines(x=DateTime,y=Sub_metering_2,col="red"))
# blue line for Sub_metering_3
with(data3,lines(x=DateTime,y=Sub_metering_3,col="blue"))
# top right legend with coloured lines
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.off()
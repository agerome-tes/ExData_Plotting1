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

# open png device for a 480x480px image, insert plot and line, blank x axis title, custom y axis title, close device
png(file="plot2.png",width = 480, height = 480, units = "px")
with(data3,plot(x=DateTime,y=Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l"))
dev.off()
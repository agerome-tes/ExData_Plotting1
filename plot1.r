# load data and add a new column with the date column converted into a date
library(plyr)
data1<-read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "?")
data2<-mutate(data1,Date2=strptime(data1$Date,"%d/%m/%Y"))

# subset data
data3<-data2[data2$Date2=="2007-02-01"|data2$Date2=="2007-02-02",]

# open png device for a 480x480px image, insert histogram with title, custom x axis title, red fill, close device
png(file="plot1.png",width = 480, height = 480, units = "px")
hist(data3$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()
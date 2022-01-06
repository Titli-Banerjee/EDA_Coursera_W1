## Getting full the dataset
########################
df <- read.csv("./Datasets/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
               nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
head(df)
dim(df)

df$Date = as.Date(df$Date, format="%d/%m/%Y")

## Subsetting the data
########################
df_subset_dates = subset(df, (Date >= "2007-02-01" & Date <= "2007-02-02"))
dim(df_subset_dates)
rm(df)

## Converting dates
########################
df_conv_subset_dates <- paste(as.Date(df_subset_dates$Date), df_subset_dates$Time)
df_subset_dates$Datetime <- as.POSIXct(df_conv_subset_dates)

## Fourth Plot
########################
par(mfrow=c(2,2))
with(df_subset_dates, {
  plot(Global_active_power~Datetime, 
       type="l",xlab="",ylab="Global Active Power")

  
  plot(Voltage~Datetime,
       type="l", xlab="datetime",
       ylab="Voltage")
  
  
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
  
})


## Save
########################
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

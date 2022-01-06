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

## Second Plot
########################
plot(df_subset_dates$Global_active_power~df_subset_dates$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save
########################
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

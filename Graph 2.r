#### LOAD DATA ####

# Read the full table ofthe file household_power_consumption.txt
powerconsumption <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?") 
powerconsumption$Date <- as.character(powerconsumption$Date)

# Subset the table so that only the first two days of february are included
powerconsumption_subset <- powerconsumption[powerconsumption$Date == "1/2/2007" | powerconsumption$Date ==  "2/2/2007", ]
powerconsumption_subset <- powerconsumption_subset[complete.cases(powerconsumption_subset),] 

# Convert the date column to date format
powerconsumption_subset$Date <- as.Date.character(powerconsumption_subset$Date, format = "%d/%m/%Y")

# Create new column - datetime to combine the date and time for each row 
powerconsumption_subset$datetime <- as.POSIXct(paste(
    powerconsumption_subset$Date, powerconsumption_subset$Time), format="%Y-%m-%d %H:%M:%S")



#### CREATE GRAPHS ####
# Plot 2 
png("Plot 2.png", 480,480)
plot(powerconsumption_subset$datetime, powerconsumption_subset$Global_active_power, 
     pch = "", 
     xlab = "", 
     ylab = "Global active power (kilowatts)"
)
lines(powerconsumption_subset$datetime, powerconsumption_subset$Global_active_power)
dev.off()
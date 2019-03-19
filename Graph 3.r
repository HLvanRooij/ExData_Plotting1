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



#### CREATE GRAPHS ####'
# Plot 3 
png("Plot 3.png", 480,480)
plot(powerconsumption_subset$datetime, powerconsumption_subset$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Enegery Sub Metering", 
     pin = c(4,10), 
     mar = c(1,1,1,10))  
lines(powerconsumption_subset$datetime, powerconsumption_subset$Sub_metering_1)
lines(powerconsumption_subset$datetime, powerconsumption_subset$Sub_metering_2, col = "red")
lines(powerconsumption_subset$datetime, powerconsumption_subset$Sub_metering_3, col = "blue")

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1,
       cex = 0.75)

dev.off()
library(readxl)
library(writexl)
library(dplyr)

rm(list=ls(all=TRUE))
# Define a function to convert all columns to character
convert_to_character <- function(df) {
  df[] <- lapply(df, as.character)
  return(df)
}

# Get the sheet names
sheet_names <- excel_sheets("kilifi_households.xlsx")

# Initialize an empty list to store data frames
all_sheets <- list()

# Read each sheet without using the first row as header and convert columns to character
for (sheet in sheet_names) {
  df <- read_excel("kilifi_households.xlsx", sheet = sheet, col_names = FALSE)
  df <- convert_to_character(df)
  all_sheets[[sheet]] <- df
}

# Combine the list of data frames into one data frame
combined_data <- bind_rows(all_sheets)

# Write the combined data frame to a new Excel file
write_xlsx(combined_data, "combined_data.xlsx")

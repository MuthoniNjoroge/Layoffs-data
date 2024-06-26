# Layoffs-data
## Layoff dataset cleaning using MSQL
![](intro.jpg)
### Introduction.
I found this dataset while working on my project. It contains information on companies from all over the world that laid off their employees between 2020 and 2023, making it an excellent resource for improving my SQL skills
### Steps I followed while cleaning the data
1. Removing Dublicates
2. Standardizing the data
3. Dealing with Null and blank Values
4. Removed unused columns
## Step 1 Creating a dublicate table
i assumed that this was a real life work project, so i started by creating a dublicate table so that i could work on it with out  changing the origal table.

![](dublicate.png)
## step 2 Removing dublicates
I first created a row_number column since the table had no unique_key column i could use.
I did this by using a window function

![](row.png)

Then i searched for the columns that had duplicates and deleted the dublicates.

## Step 3 Standardizing data
Then i trimmed off the spaces that were before and after the columns and made sure all the columns were in the right format and 

the company names, industy names and country names were written correctly and were standard. 
Next i had to change the date datatype from text to date formate since i imported it as text.

![](date.png)------- ![](trimming.png)

## Step 4 Workig with nulls and blanks
Here i transformed all the blanks spaces to nulls so that i could be able to work with them as nulls.
Then i looked looked for the nulls in the industry column that could be populated by looking for companies that were in simiral industry and used joins, to join the ones that were null to the ones that were not null but simillar and this filled the up the nulls. 

![](nulls.png)

Then i looked for the ones that could not be populated mostly the total_laid_off and the percentage_laid_off and deleted them.

![](deleting.pn)

## Step 5 Dropping the unneeded columns
Then i droped the row_num column i created at the start of the project since it was no longer needed.
![](droped.png)

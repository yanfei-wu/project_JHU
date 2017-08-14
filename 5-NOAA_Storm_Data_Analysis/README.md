# NOAA Stom Data Analysis 

Storms and other severe weather events can cause both public health and economic problems for communities and municipalities. Many severe events can result in fatalities, injuries, and property damage, and preventing such outcomes to the extent possible is a key concern.   

This project explores the U.S. National Oceanic and Atmospheric Administration's (NOAA) storm database. The major storms and weather events occured from 1950 to November 2011 in the United States are analyzed.

The dataset is cleaned with the following steps: 
- Filtering the records 
- Converting units of measurements 
- Re-assign values for `EVTYPE` (event type) categorical variable by clustering event types with *Jaro-Winkler* distance algorithm 

The cleaned dataset is used to analyze and identify types of events that are most harmful to the population health and have the greatest economic consequences.  


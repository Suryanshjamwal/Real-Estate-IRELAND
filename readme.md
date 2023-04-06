# Exploratory Data Analysis: Real Estate Market Trends in Ireland (2010-2021)

<table align = "center">
  <td><img src="pic.png"  width="700" height="380" />
 </table>

This project is an exploratory data analysis of the real estate market trends in Ireland from the year 2010 to 2021. The purpose of this analysis is to provide insights into the performance of the Irish real estate market over this period, and to identify any notable trends or patterns that may be of interest to potential buyers, investors, or other stakeholders in the industry.

## Data Source

The data used for this analysis was sourced from Central Statistics Office (CSO), one of the largest online statistics platforms in Ireland, gov.ie, property price register and EU Central Bank. 

The dataset pulled from property register includes information on around 600,000 property listings over the period from January 2010 to December 2023. Rest other datasets from CSO and EU Central Bank include data from 2010-2021 of Rental properties, Buyers demographics, Gross Value added, population, migration, unemployement rate, interest rates, income and inflation rate. 

These datasets were chosen to find out how each one of the decision metrics inlfuenced property and rental prices in the Irish market.

## Data Exploration

The data was first cleaned and preprocessed to ensure that it was ready for analysis. This involved removing any duplicate entries, handling missing values, and converting the data into a more usable format.

Once the data was cleaned, a series of exploratory data analysis (EDA) techniques were used to examine the trends and patterns in the data. This included the use of descriptive statistics, data visualization, and time-series analysis.

For this project I used SQL and Excel for exploring all the data in hand.

## Data Cleaning and Transformation

Using SQL and Excel, the datasets were queried to find out any abnormalities or duplicate values. 

### Some key relevant Excel transformations used

* Fetching County names from a variety of Addresses
* Left and right formula transformation
* Adding year column with Year Funtion
* TRIM values 
* Using VLOOKUP funtion to add Region field based on County names
* Correcting Datatypes
* Deleting irrelevant fields and rows
* Currency modifications 
* Translating Irish phrases to English
* Excluding data before 2010
* INDEX and FILTER data
* Concatenate relevant datasheets 
* Find and replace values

### SQL Querying 

Using the query language most of the transforamtions, extraction and manipulations were handled.

This [sql file](code.sql) contains some of the key relevant queries used for this analysis project. SQL commands like JOIN ON, UPDATE, PARTITION BY, GROUP BY, ORDER BY, DELETE, etc helped in general manipulation tasks.

## Data Visualisation 

<div class='tableauPlaceholder' id='viz1680807121880' style='position: relative'><noscript><a href='#'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Re&#47;RealEstateAnalysis-Ireland&#47;Summary&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='RealEstateAnalysis-Ireland&#47;Summary' /><param name='tabs' value='yes' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Re&#47;RealEstateAnalysis-Ireland&#47;Summary&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1680807121880');                    var vizElement = divElement.getElementsByTagName('object')[0];                    if ( divElement.offsetWidth > 800 ) { vizElement.style.width='100%';vizElement.style.height=(divElement.offsetWidth*0.75)+'px';} else if ( divElement.offsetWidth > 500 ) { vizElement.style.width='100%';vizElement.style.maxWidth='1450px';vizElement.style.height=(divElement.offsetWidth*0.75)+'px';vizElement.style.maxHeight='910px';} else { vizElement.style.width='100%';vizElement.style.height='2150px';}                     var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>


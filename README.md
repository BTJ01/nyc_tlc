# New York City - Taxi & Limo Commission:<br/>Yellow Taxi Trip Records
#### [Source Data & Documentation](https://learn.microsoft.com/en-us/azure/open-datasets/dataset-taxi-yellow?tabs=azureml-opendatasets)

## Objective
Create a scalable, easily maintainable solution that does the following: 
- [x] Ingests the dataset (NYC Taxi and Limousine, yellow dataset) 
- [x] Summarizes:
  - [x] Mean & median costs, prices, and passenger counts
  - [x] Aggregate by payment type, year, month
- [x] Results are output in csv or parquet format
- [x] Includes source code and a ReadMe File with information on how to run your script and any other dependencies

## Approach
1. Review NYC TLC Dataset Documentation:
   - Timeframe: 2009 to 2018
   - Format: Parquet
   - Size: ~50 GB, roughly 1.5B rows as of 2018
   - Azure Region: East US 
   - data dictionary is **not 100% accurate**
     - *ex1*: vendorID listed twice, as `string` & `int`, the description for both entries matches `int` entry, but the field data type in the table is `string`
     - *ex2*: paymentType has datatype `string`, but description mentions "numeric code signifying how the passenger paid for the trip" - description is innaccurate/outdated based on `string` values in the actual data
2. Create Microsoft Account and sign into Azure Portal - $200 free credits with new accounts!
3. Create & configure an Azure Databricks workspace instance 
   - *name*: gray_matter
   - *resource group*: nyc_tlc
   - *region*: East US (chosen for affinity with dataset, also stored in East US)
4. Launch workspace
5. Create & configure Personal Compute Cluster
   - *runtime version*: 14.2 ML (includes Apache Spark 3.5.0, Scala 2.12)
   - *node type*: standard_ds3_v2, 14 GB, 4 cores
6. Launch compute cluster
7. Review data dictionary and document column requirments and notes (see below)
8. Create Notebook (NYC_TLC)
   - Ingest data (used modified spark sample from documentation)
   - Review relevant columns
   - Find mean & median using Spark SQL & pySpark

### Columns of Interest + notes:
 * vendor: `vendorID` - Three letter code indicating vendor, 7 codes
 * payment type: `paymentType` - alpha code indicating how passenger paid (CSH, CRD, etc)
 * passengers: `passengerCount` - # of passengers in the vehicle, driver-entered value
 * dates: `puMonth` , `puYear`
 * financial:
    - `extra` - $0.50 and $1 rush hour and overnight charges
    - `fareAmount` - time-and-distance fare calculated by the meter.
    - `improvementSurcharge` - 0.30 improvement surcharge assessed trips at the flag drop. 
      - **The improvement surcharge began being levied in 2015**
    - `mtaTax` - $0.50 MTA tax that is automatically triggered based on the metered rate in use
    - `tipAmount` - automatically populated for credit card tips.
      - **Cash tips are not included in** `tipAmount`
      - `tipAmount` **not included in** `totalAmount`
    - `tollsAmount` - Total amount of all tolls paid in trip
    - `totalAmount` - total amount charged to passengers. Does not include cash tips

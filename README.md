# New York City - Taxi & Limo Commission: Yellow Taxi Trip Records
#### [Source Data & Documentation](https://learn.microsoft.com/en-us/azure/open-datasets/dataset-taxi-yellow?tabs=azureml-opendatasets)

## Objective
Create a scalable, easily maintainable solution that does the following: 
- [x] Ingests the dataset (NYC Taxi and Limousine yellow dataset) 
- [ ] Summarizes:
  - [ ] Mean/median costs, prices and passenger counts.
  - [ ] Aggregate by payment type, year, month. 
- [ ] Results are output in csv or parquet format
- [ ] Includes source code and a ReadMe File with information on how to run your script and any other dependencies.

## Approach used to complete assignment
1. Review NYC TLC Documentation.
   
   *Noteworthy details:*
   - Timeframe: 2009 to 2018
   - Format: Parquet
   - Size: ~50 GB, roughly 1.5B rows as of 2018
   - Azure Region: East US 
   - data dictionary is **not 100% accurate**
     - e.g. vendorID listed twice, as `string` & `int`, desc for both entries matches `int` entry, but the field in the table is string
2. Create Microsoft Account and sign into Azure Portal
3. Create & configure an Azure Databricks workspace instance 
   - name: gray_matter
   - resource group: nyc_tlc
   - region: East US
4. Launch workspace
5. Create & configure Personal Compute Cluster
6. Launch compute cluster
7. Create Notebook (NYC_TLC)
8. Ingest data using spark sample from documentation listed above
9. Review data dictionary and document what's needed

### Columns Required + notes:
 * vendor: `vendorID`
 * payment type: `paymentType`
 * passengers: `passengerCount` - # of passengers in the vehicle, driver-entered value
 * dates: `puMonth` , `puYear`, 
 * money: 
    - `extra` - $0.50 and $1 rush hour and overnight charges
    - `fareAmount` - time-and-distance fare calculated by the meter.
    - `improvementSurcharge` - 0.30 improvement surcharge assessed trips at the flag drop. 
      **The improvement surcharge began being levied in 2015**
    - `mtaTax` - $0.50 MTA tax that is automatically triggered based on the metered rate in use
    - `tipAmount` - automatically populated for credit card tips.
      
      **Cash tips are not included in** `tipAmount`

      `tipAmount` **not included in** `totalAmount`
    - `tollsAmount` - Total amount of all tolls paid in trip
    - `totalAmount` - total amount charged to passengers. Does not include cash tips

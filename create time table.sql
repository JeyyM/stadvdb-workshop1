
-- original schema's tripID is not unique so I'll insert the data as is, no foreign key integrity
DROP TABLE IF EXISTS date_dimension;
CREATE TABLE date_dimension (
  timeID INT AUTO_INCREMENT PRIMARY KEY,
  tripID VARCHAR(45) NOT NULL,

  pickup_year  INT,
  pickup_month INT,
  pickup_day   INT,
  dropoff_year  INT,
  dropoff_month INT,
  dropoff_day   INT
) ENGINE=InnoDB;

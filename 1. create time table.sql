-- original schema's tripID is not unique so I'll insert the data as is, no foreign key integrity
DROP TABLE IF EXISTS date_dimension;
CREATE TABLE date_dimension (
  timeID INT AUTO_INCREMENT PRIMARY KEY,
  tripID VARCHAR(45) NOT NULL,
  tripYear INT,
  tripMonth INT,
  tripDay INT
) ENGINE=InnoDB;

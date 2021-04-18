-- Create and use database for stock price data
CREATE DATABASE stock_db;

USE stock_db;

-- Create tables stock_prices and stock_info
CREATE TABLE `stock_info` (
  `symbol` varchar(10) NOT NULL,
  `company` varchar(100) DEFAULT NULL,
  `sector` varchar(100) DEFAULT NULL,
  `exchange` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`symbol`)
);

CREATE TABLE `stock_prices` (
  `date` datetime NOT NULL,
  `stock_type` varchar(10) NOT NULL,
  `price_type` varchar(10) NOT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`date`,`stock_type`,`price_type`),
  FOREIGN KEY (stock_type) REFERENCES stock_info(symbol)
);

-- Query the close price for Tesla for all trading days
SELECT p.date, p.stock_type, p.price_type, CONCAT('$', format(p.price, 2)) AS price  
FROM stock_prices p
WHERE p.stock_type = (SELECT symbol 
                    FROM stock_info 
                    WHERE company REGEXP '^Tesla')
	  AND p.price_type = 'close';
      
-- Query the low and high prices for Gamestop for all trading days
SELECT p.date, p.stock_type, p.price_type, CONCAT('$', format(p.price, 2)) AS price 
FROM stock_prices p
WHERE p.stock_type = (SELECT symbol 
                    FROM stock_info 
                    WHERE company REGEXP '^Gamestop')
	  AND price_type IN ('low', 'high')
ORDER BY p.date, p.price_type;  

-- Query the maximum close price for each company
SELECT (SELECT company 
        FROM stock_info s 
		WHERE s.symbol = p.stock_type) AS company
, CONCAT('$', format(MAX(p.price), 2)) AS max_close_price
FROM stock_prices p
WHERE price_type = 'close'
GROUP BY company
ORDER BY company;

-- This is the max closing price per company with the month that
-- the company closed at their max - thought it would be interesting
WITH a AS (
SELECT (SELECT company 
        FROM stock_info s 
		WHERE s.symbol = p.stock_type) AS company
, MAX(p.price) AS max_close_price
FROM stock_prices p
WHERE price_type = 'close'
GROUP BY company
ORDER BY company
)
SELECT a.company, CONCAT('$', format(a.max_close_price, 2)) AS max_close_price, CONCAT(MONTHNAME(p.date), " ", YEAR(p.date)) AS month
FROM a
LEFT JOIN stock_prices p
ON p.price = a.max_close_price
   AND a.company = (SELECT company 
                       FROM stock_info
                       WHERE symbol = p.stock_type);

-- Query the maximum close price for each company in each month
SELECT Year(p.date) AS year
, MONTHNAME(p.date) AS month
, (SELECT company FROM stock_info s WHERE s.symbol = p.stock_type) AS company
, CONCAT('$', format(MAX(p.price), 2)) AS max_close_price
FROM stock_prices p
WHERE price_type = 'close'
GROUP BY YEAR(date), MONTHNAME(date), company
ORDER BY YEAR(date), MONTHNAME(date), company;


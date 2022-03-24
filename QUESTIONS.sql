USE MYSQLPROJECT ;

# Q1. FIND THOSE HOTEL IN VARANASI WHICH HAVE LOW FAIR ?

SELECT HOTEL_BOOKING.CITY,HOTEL_BOOKING.HOTEL_NAME, HOME_STAY_DETAILS.HOME_STAY_NAME,HOTEL_BOOKING.AVL_ROOM  AS HOTEL_AVL_ROOM,
HOME_STAY_DETAILS.AVL_ROOM AS HOMESTAY_AVL_ROOM,HOTEL_BOOKING.HOTEL_FARE,HOME_STAY_DETAILS.FARE AS HOME_STAY_FARE 
FROM HOTEL_BOOKING
JOIN HOME_STAY_DETAILS
ON HOTEL_BOOKING.LOCALITY_ID = HOME_STAY_DETAILS.LOCALITY_ID
JOIN HOME_STAY_ADDRESS
ON HOTEL_BOOKING.CITY = HOME_STAY_ADDRESS.CITY_NAME
WHERE HOTEL_BOOKING.CITY = 'VARANASI' AND HOME_STAY_ADDRESS.CITY_NAME = 'VARANASI' 
GROUP BY HOTEL_BOOKING.HOTEL_NAME 
ORDER BY HOTEL_BOOKING.HOTEL_FARE AND HOME_STAY_DETAILS.FARE ASC ;

-----------------------------------------------------------------------------------------------
# Q2. FIND NEARBY TOURIST LOCATION IN NEW DELHI ?

SELECT ACTIVITY_ID.CITY ,ACTIVITY_LOCATION.CITY_ID, ACTIVITY_LOCATION.ACTIVITY, ACTIVITY_LOCATION.LOCATION , ACTIVITY_DETAILS.PERSON_NO ,
 ACTIVITY_DETAILS.ADULTS_FARE , ACTIVITY_DETAILS.CHILDS_FARE , ACTIVITY_DETAILS.PLAN_HOUR , ACTIVITY_RATING.ACTIVITY_RATING
FROM ACTIVITY_ID
JOIN ACTIVITY_LOCATION 
ON  ACTIVITY_ID.CITY_ID = ACTIVITY_LOCATION.CITY_ID
JOIN ACTIVITY_DETAILS 
ON ACTIVITY_LOCATION.CITY_ID = ACTIVITY_DETAILS.CITY_ID
JOIN ACTIVITY_RATING
ON ACTIVITY_DETAILS.CITY_ID = ACTIVITY_RATING.CITY_ID
WHERE ACTIVITY_ID.CITY = 'NEW DELHI' ; 
------------------------------------------------------------------------------------------------
 # Q3. FIND BUS FROM AMRITSAR TO NEW DELHI FOR MINIMUM FARE IN SLEEPER CLASS?

SELECT BUS_RESERVATION.BUS_ID , BUS_RESERVATION.SERVICE_PROVIDER , BUS_RESERVATION.UP_STATION , 
BUS_RESERVATION.DOWN_STATION , BUS_RESERVATION.DEPT_DATE , BUS_RESERVATION.SEAT_TYPE , MIN(BUS_RESERVATION.FARE) AS FARE ,
BUS_RESERVATION.SEAT_AVL , BUS_ARVL_TIME.ARVL_TIME  , BUS_RATINGS.RATING , BUS_DEPT_TIME.DEPT_TIME , BUS_JOURNEY_HR.JOURNEY_HR
FROM BUS_RESERVATION 
JOIN BUS_ARVL_TIME
ON BUS_RESERVATION.BUS_ID = BUS_ARVL_TIME.BUS_ID
JOIN BUS_DEPT_TIME
ON BUS_ARVL_TIME.BUS_ID = BUS_DEPT_TIME.BUS_ID
JOIN BUS_RATINGS
ON BUS_DEPT_TIME.BUS_ID = BUS_RATINGS.BUS_ID
JOIN BUS_JOURNEY_HR
ON BUS_RATINGS.BUS_ID = BUS_JOURNEY_HR.BUS_ID
WHERE BUS_RESERVATION.UP_STATION = 'AMRITSAR' AND BUS_RESERVATION.DOWN_STATION = 'NEW DELHI' AND BUS_RESERVATION.SEAT_TYPE = 'SLEEPER' ;
---------------------------------------------------------------------------------------------------------------------------------------------
 # Q4. FIND 4 SEATER SEDAN CABS FROM NEW DELHI TO AGRA ?

SELECT CAB_DURATION.* , CAB_FARE.SEATER , CAB_FARE.CAB_FARE  , CAB_FARE.CAB_AVG_RATE_KM , CAB_SERVICE_CITY.TOTAL_AVL_CAB
FROM CAB_DURATION
JOIN CAB_FARE
ON CAB_DURATION.CAB_ID = CAB_FARE.CAB_ID
JOIN CAB_SERVICE_CITY
ON CAB_FARE.CAB_ID = CAB_SERVICE_CITY.CAB_ID
WHERE CAB_DURATION.CAB_TYPE = 'SEDAN'
AND CAB_DURATION.UP_STATION = 'NEW DELHI'
AND CAB_DURATION.DOWN_STATION = 'AGRA'
GROUP BY CAB_DURATION.CAB_ID 
HAVING CAB_SERVICE_CITY.TOTAL_AVL_CAB =   1; 
--------------------------------------------------------------------------------------------------------------------------------------------
 # Q5. AVAILABLE CABS FROM MUMBAI TO PUNE ?

SELECT cab_fare.CAB_ID,cab_fare.CAB_TYPE,cab_fare.UP_STATION,
cab_fare.DOWN_STATION,cab_fare.SEATER,cab_fare.CAB_FARE,
cab_fare.CAB_AVG_RATE_KM
FROM
mysqlproject.cab_fare
WHERE cab_fare.UP_STATION ='MUMBAI'
      AND cab_fare.DOWN_STATION='PUNE'
GROUP BY cab_fare.CAB_ID;
------------------------------------------------------------------------------
# Q6. FIND ACTIVITY PLACE IN KOLKATA HAVING PLAN HOUR MORE THAN 3 AND RATING IS 5.

SELECT ACTIVITY_TABLE_MAIN.CITY,
ACTIVITY_TABLE_MAIN.LOCATION,
ACTIVITY_TABLE_MAIN.ACTIVITY,
ADULTS_FARE,CHILDS_FARE
FROM 
mysqlproject.ACTIVITY_TABLE_MAIN
WHERE CITY = 'KOLKATA'
      AND PLAN_HOUR < 3
      AND ACTIVITY_RATING =5 ;
--------------------------------------------------------------------------------------
# Q7. LIST OF ALL CITY WHICH HAVE MORE THAN 4 PLACE TO VISIT ?

SELECT DISTINCT CITY
FROM 
	mysqlproject.ACTIVITY_TABLE_MAIN
GROUP BY CITY
HAVING
      COUNT(CITY) >4 ;
--------------------------------------------------------------------------------------
# Q8. FIND HTEL IN AMRITSAR ,WHICH HAVE AVL ROOM MORE THAN 1 AND HAVING  AC FACILITY ?

SELECT HOTEL_TABLE_MAIN.HOTEL_NAME, HOTEL_TABLE_MAIN.HOTEL_LOCALITY,
HOTEL_TABLE_MAIN.HOTEL_FARE
FROM 
mysqlproject.HOTEL_TABLE_MAIN
WHERE 
	 CITY='AMRITSAR'
     AND AVL_ROOM > 1
     AND ROOM_FACILITY = 'AC'
     GROUP BY HOTEL_TABLE_MAIN.HOTEL_NAME;
------------------------------------------------------------------------------------------
# Q9. WHICH HOTEL OR HOMESTAY IS BETTER IN DELHI AS PER THE FARE AND ROOM SERVICE ?

SELECT HOMESTAY_TABLE_MAIN.HOME_STAY_NAME,HOMESTAY_TABLE_MAIN.FARE,
         HOMESTAY_TABLE_MAIN.AVL_ROOM,HOMESTAY_TABLE_MAIN.ROOM_SERVICE,
           HOTEL_TABLE_MAIN.HOTEL_NAME,HOTEL_TABLE_MAIN.HOTEL_FARE,
             HOTEL_TABLE_MAIN.AVL_ROOM,HOTEL_TABLE_MAIN.ROOM_SERVICES
FROM 
mysqlproject.HOMESTAY_TABLE_MAIN LEFT JOIN mysqlproject.HOTEL_TABLE_MAIN
ON HOMESTAY_TABLE_MAIN.LOCALITY_ID=HOTEL_TABLE_MAIN.LOCALITY_ID
WHERE 
     HOMESTAY_TABLE_MAIN.CITY_NAME = 'GOA'
     AND HOMESTAY_TABLE_MAIN.CHECK_IN_DATE ='2022-02-24'
     AND HOMESTAY_TABLE_MAIN.ROOM_SERVICE = 'YES'
     AND HOTEL_TABLE_MAIN.ROOM_SERVICES ='YES'
GROUP BY HOMESTAY_TABLE_MAIN.CITY_NAME;  
------------------------------------------------------------------------------------------------
# Q10. FIND TRAIN BETWEEN HOWRAH TO MUMBAI ON DATE 20TH FEB,2022 .

SELECT TRAIN_DATA.TRAIN_NO,
          TRAIN_DATA.TRAIN_NAME,
              TRAIN_DATA.DEPT_TIME,
			      TRAIN_DATA.ARVL_TIME 
FROM 
     mysqlproject.TRAIN_DATA
WHERE
     TRAIN_DATA.UP_STATION='HOWRAH'
     AND TRAIN_DATA.DOWN_STATION='NEW DELHI'
     AND TRAIN_DATA.DEPT_DATE='2022-02-20';
-------------------------------------------------------------------------------------------------------
# Q11. FIND THE FARE OF TRAINS BETWEEN HOWRAH TO NEW DELHI ON DATE 20TH FEB,2022.

SELECT TRAINS_DETAIL.TRAIN_NO,
         TRAINS_DETAIL.TRAIN_NAME,
           TRAINS_DETAIL.CLASS,
             TRAINS_DETAIL.FARE,
               TRAINS_DETAIL.SEATS,
                 TRAINS_DETAIL.STATUS
FROM 
    mysqlproject.TRAINS_DETAIL
WHERE 
     TRAINS_DETAIL.UP_STATION='HOWRAH'
     AND TRAINS_DETAIL.DOWN_STATION='NEW DELHI'
     AND TRAINS_DETAIL.DEPT_DATE='2022-02-20';
------------------------------------------------------------------------------------------------------

# Q12. FIND TRAIN DETAILS FROM HOWRAH TO CHENNAI ON DATE 20TH FEB,2022.

SELECT TRAIN_DATA.TRAIN_NO,
          TRAIN_DATA.TRAIN_NAME,
            TRAIN_DATA.DEPT_DATE,
               TRAIN_DATA.DEPT_TIME,
				 TRAIN_DATA.ARVL_TIME,
                   TRAINS_DETAIL.CLASS,
                     TRAINS_DETAIL.FARE,
                        TRAINS_DETAIL.SEATS,
                           TRAINS_DETAIL.STATUS
FROM  mysqlproject.TRAINS_DETAIL LEFT JOIN mysqlproject.TRAIN_DATA
ON TRAINS_DETAIL.TRAIN_NO =TRAIN_DATA.TRAIN_NO
WHERE
     TRAIN_DATA.UP_STATION='HOWRAH'
     AND TRAIN_DATA.DOWN_STATION='CHENNAI'
     AND TRAIN_DATA.DEPT_DATE='2022-02-20'
GROUP BY TRAINS_DETAIL.CLASS ;
---------------------------------------------------------------------------------------------------------------------------

 

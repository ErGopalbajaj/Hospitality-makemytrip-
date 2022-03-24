USE MYSQLPROJECT;

CREATE VIEW ACTIVITY_TABLE_MAIN AS
SELECT activity_id.CITY_ID,activity_id.CITY,activity_location.LOCATION,
activity_details.ACTIVITY,activity_date.ACTIVITY_DATE,activity_details.PERSON_NO,
activity_details.ADULTS_FARE,activity_details.CHILDS_FARE,
activity_details.PLAN_HOUR,activity_rating.ACTIVITY_RATING
FROM 
mysqlproject.activity_id LEFT JOIN mysqlproject.activity_details
ON activity_id.CITY_ID=activity_details.CITY_ID
LEFT JOIN mysqlproject.activity_location
ON activity_id.CITY_ID=activity_location.CITY_ID
LEFT JOIN mysqlproject.activity_rating
ON activity_id.CITY_ID=activity_rating.CITY_ID
LEFT JOIN mysqlproject.activity_date
ON activity_id.CITY_ID=activity_date.CITY_ID;

SELECT * FROM mysqlproject.ACTIVITY_TABLE_MAIN;
------------------------------------------------------------------------------------------------------------
CREATE VIEW DETAILS_FLIGHT AS
SELECT flight_dept_date.FLIGHT_ID,flight_journey_hr.FLIGHT_SERVICES_PROVIDER,
flight_dept_date.FLIGHT_DEPT_DATE,flight_journey_hr.UP_STATION,flight_dept_time.DEPT_TIME,
flight_journey_hr.DOWN_STATION,flight_arvl_time.ARVL_TIME,flight_journey_hr.JOURNEY_HR
FROM 
mysqlproject.flight_dept_date LEFT JOIN mysqlproject.flight_journey_hr
ON flight_dept_date.FLIGHT_ID=flight_journey_hr.FLIGHT_ID
LEFT JOIN mysqlproject.flight_dept_time
ON flight_dept_date.FLIGHT_ID=flight_dept_time.FLIGHT_ID
LEFT JOIN mysqlproject.flight_arvl_time
ON flight_dept_date.FLIGHT_ID=flight_arvl_time.FLIGHT_ID;

SELECT * FROM  mysqlproject.DETAILS_FLIGHT;
---------------------------------------------------------------------------------------------------------
CREATE VIEW HOMESTAY_TABLE_MAIN AS
SELECT home_stay_address.LOCALITY_ID,home_stay_address.HOME_STAY_NAME,
home_stay_address.CITY_NAME,home_stay_address.LOCALITY_NAME,
home_stay_address.LANDMARK,home_stay_details.HOME_STAY_ROOM_TYPE,
home_stay_check_in.CHECK_IN_DATE,home_stay_check_in.CHECK_IN_TIME,
home_stay_check_in.CHECK_OUT_TIME,home_stay_details.AVL_ROOM,
home_stay_details.GUEST,home_stay_details.BED_TYPE,home_stay_details.FARE,
home_stay_details.ROOM_SERVICE,home_stay_ratings.HOME_STAY_RATING
FROM 
mysqlproject.home_stay_address LEFT JOIN mysqlproject.home_stay_details
ON home_stay_address.LOCALITY_ID=home_stay_details.LOCALITY_ID
LEFT JOIN mysqlproject.home_stay_check_in
ON home_stay_address.LOCALITY_ID=home_stay_check_in.LOCALITY_ID
LEFT JOIN mysqlproject.home_stay_ratings
ON home_stay_address.LOCALITY_ID=home_stay_ratings.LOCALITY_ID ;


SELECT * FROM mysqlproject.HOMESTAY_TABLE_MAIN;
------------------------------------------------------------------------------------------------------
CREATE VIEW HOTEL_TABLE_MAIN AS
SELECT hotel_booking.LOCALITY_ID,hotel_booking.CITY,hotel_booking.HOTEL_NAME,
hotel_address.HOTEL_LOCALITY,hotel_address.STREET_ADDRESS,
home_stay_facility.ROOM_TYPE,hotel_booking.AVL_ROOM,
home_stay_facility.ROOM_FACILITY,hotel_booking.HOTEL_FARE,
hotel_booking.ROOM_SERVICES,hotel_booking.CHECK_IN_DATE,
hotel_booking.CHECK_IN_TIME,hotel_booking.CHECK_OUT_TIME,
home_stay_ratings.HOME_STAY_RATING
FROM 
mysqlproject.hotel_address LEFT JOIN mysqlproject.hotel_booking
ON hotel_address.LOCALITY_ID=hotel_booking.LOCALITY_ID
LEFT JOIN mysqlproject.home_stay_facility
ON hotel_address.LOCALITY_ID=home_stay_facility.LOCALITY_ID
LEFT JOIN mysqlproject.home_stay_ratings
ON hotel_address.LOCALITY_ID=home_stay_ratings.LOCALITY_ID
GROUP BY hotel_ADDRESS.HOTEL_NAME
ORDER BY hotel_booking.LOCALITY_ID;

SELECT * FROM mysqlproject.HOTEL_TABLE_MAIN;
----------------------------------------------------------------------------------------
CREATE VIEW TRAIN_DATA AS
SELECT train_details.TRAIN_NO,train_details.TRAIN_NAME,
train_dept_date.DEPT_DATE,train_dept_time.UP_STATION,
train_dept_time.DEPT_TIME,train_arvl_time.DOWN_STATION,
train_arvl_time.ARVL_TIME
FROM mysqlproject.train_details LEFT JOIN  mysqlproject.train_dept_date
ON train_details.TRAIN_NO=train_dept_date.TRAIN_NO
LEFT JOIN mysqlproject.train_dept_time
ON train_details.TRAIN_NO=train_dept_time.TRAIN_NO
LEFT JOIN mysqlproject.train_arvl_time
ON train_details.TRAIN_NO=train_arvl_time.TRAIN_NO;

SELECT * FROM mysqlproject.TRAIN_DATA;
----------------------------------------------------------------------------------------------------------------
CREATE VIEW TRAINS_DETAIL AS
select * from mysqlproject.train_sl_reservation 
UNION 
select * from  mysqlproject.train_2s_reservation
UNION 
select * from mysqlproject.train_3a_reservation
UNION 
select * from  mysqlproject.train_2a_reservation
UNION
select * from mysqlproject.train_1a_reservation

SELECT * FROM mysqlproject.TRAINS_DETAIL;
-------------------------------------------------------------------------------------------------------------------

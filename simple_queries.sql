---------------------------------------------
----------  Riders' User Stories  ----------
---------------------------------------------

------ 1 ------


------ 2 ------

\echo -----------------------------------------------------------------
\echo   All destinations Rider R001 has been to using Uber.
\echo -----------------------------------------------------------------
\echo

    SELECT loc_end_lat as destination_lattitude, loc_end_long as destination_longitude
      FROM Trip_Details 
INNER JOIN Trip
        ON Trip.tdid = Trip_Details.tdid
     WHERE Trip.rid = 'R001';

------ 3 ------

\echo -----------------------------------------------------------------
\echo  The average rating for Driver D003.
\echo -----------------------------------------------------------------
\echo

  SELECT AVG(driver_score) as average_rating
    FROM Rating
   WHERE did = 'D003'
GROUP BY did;

---------------------------------------------
-----------  Drivers' User Stories  ----------
---------------------------------------------

------ 4 ------

\echo -----------------------------------------------------------------
\echo   All complaints filed against Rider R003.
\echo -----------------------------------------------------------------
\echo

    SELECT driver_complaint
      FROM Rider_Rating
INNER JOIN Rating
        ON Rating.rating_id = Rider_Rating.rating_id
     WHERE Rating.rid = 'R003';

------ 5 ------

\echo -----------------------------------------------------------------
\echo   All earnings made by Driver D002 on every day worked, sorted by date.
\echo -----------------------------------------------------------------
\echo

    SELECT DATE(start_datetime) as date, SUM(cost) as Total_Earnings
      FROM Trip_Details as TD
INNER JOIN Trip
        ON Trip.tdid = TD.tdid
     WHERE did = 'D002'
  GROUP BY DATE(start_datetime);


------ 6 ------

\echo -----------------------------------------------------------------
\echo   The full name and location of rider the driver needs to pickup on a certain trip.
\echo -----------------------------------------------------------------
\echo

SELECT R.r_fname as first_name, TD.loc_start_lat as pickup_lattitude, TD.loc_start_long as pickup_longitude
  FROM Rider as R, Trip_Details as TD
 WHERE R.rid = (SELECT T.rid
                  FROM   Trip as T
                 WHERE T.tdid = TD.tdid);


---------------------------------------------
-----------  Riders' User Stories  ----------
---------------------------------------------

------ 7 ------



------ 8 ------

------ 9 ------

\echo -----------------------------------------------------------------
\echo   The names of all drivers that drive an UberXL car type.
\echo -----------------------------------------------------------------
\echo

    SELECT D.d_fname as first, D.d_lname as last
      FROM Driver as D
INNER JOIN Type
        ON Type.model = D.model
     WHERE Type.uber_type = 'UberXL';

----- 10 ------

\echo -----------------------------------------------------------------
\echo   The average time a rider has to wait for Drive D002 to arrive to the pick up location
\echo -----------------------------------------------------------------
\echo

    SELECT AVG(TD.start_datetime - TD.request_datetime) as avg_waittime
      FROM Trip_Details as TD
INNER JOIN Trip 
        ON Trip.tdid = TD.tdid
     WHERE Trip.did = 'D002';


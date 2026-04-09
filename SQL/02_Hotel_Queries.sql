-- Q1: Last booked room per user
SELECT b.user_id, b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_date
    FROM bookings
    GROUP BY user_id
) AS t
ON b.user_id = t.user_id AND b.booking_date = t.last_date;

-- Q2: Booking id and total billing amount in November 2021
SELECT b.booking_id,
       SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE b.booking_date BETWEEN '2021-11-01' AND '2021-11-30 23:59:59'
GROUP BY b.booking_id;

-- Q3: Bills > 1000 in October 2021
SELECT bc.bill_id,
       SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE bc.bill_date BETWEEN '2021-10-01' AND '2021-10-31 23:59:59'
GROUP BY bc.bill_id
HAVING bill_amount > 1000;

-- Q4: Most and least ordered item per month 2021
SELECT MONTH(bc.bill_date) AS month, item_id,
       SUM(item_quantity) AS total_qty,
       RANK() OVER(PARTITION BY MONTH(bc.bill_date) ORDER BY SUM(item_quantity) DESC) AS most_ordered_rank,
       RANK() OVER(PARTITION BY MONTH(bc.bill_date) ORDER BY SUM(item_quantity) ASC) AS least_ordered_rank
FROM booking_commercials bc
GROUP BY MONTH(bc.bill_date), item_id;

-- Q5: Customers with 2nd highest bill per month
SELECT month, user_id, total_bill
FROM (
    SELECT MONTH(bc.bill_date) AS month,
           b.user_id,
           SUM(bc.item_quantity * i.item_rate) AS total_bill,
           DENSE_RANK() OVER(PARTITION BY MONTH(bc.bill_date) ORDER BY SUM(bc.item_quantity * i.item_rate) DESC) AS rnk
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY MONTH(bc.bill_date), b.user_id
) AS t
WHERE rnk = 2;
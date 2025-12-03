1.SELECT b.user_id,b.room_no FROM bookings b where b.booking_date=(SELECT MAX(booking_date) FROM bookings WHERE user_id=b.user_id);
2.SELECT bt.booking_id,SUM(bt.bill_rate * bt.item_quantity) AS total_amount FROM booking_transactions bt JOIN bookings b ON bt.booking_id=b.booking_id WHERE strftime("%m",b.booking_date)='11' AND strftime("%Y",b.booking_date)='2021' GROUP BY bt.booking_id;
3.SELECT bt.bill_id,
       SUM(bt.bill_rate * bt.item_quantity) AS bill_amount
FROM booking_transactions bt
WHERE strftime('%m', bt.bill_date) = '10'
  AND strftime('%Y', bt.bill_date) = '2021'
GROUP BY bt.bill_id
HAVING bill_amount > 1000;
5.WITH monthly_bills AS (
    SELECT strftime('%m', bt.bill_date) AS month,
           b.user_id,
           bt.bill_id,
           SUM(bt.bill_rate * bt.item_quantity) AS bill_amount
    FROM booking_transactions bt
    JOIN bookings b ON bt.booking_id = b.booking_id
    WHERE strftime('%Y', bt.bill_date) = '2021'
    GROUP BY month, bt.bill_id
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY month ORDER BY bill_amount DESC) AS bill_rank
    FROM monthly_bills
)
SELECT month, user_id, bill_id, bill_amount
FROM ranked
WHERE bill_rank = 2;

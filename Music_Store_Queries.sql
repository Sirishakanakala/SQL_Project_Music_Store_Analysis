Some  Queries 

-- 1Q Who is the senior most employee  based on job title ? 

select * from employee order by levels desc limit 1
  
-- 2Q Which countries have the most Invoices ? --

select COUNT(*) AS INVOICES , billing_country 
from invoice 
group by billing_country 
order by INVOICES desc

 -- 3Q What are the top 3 values of total invoice?

select total from invoice 
order by total desc
limit 3

-- Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.
--  Write a query that returns one city that has the highest sum of invoice totals.
--  Return both the city name & sum of all invoice totals

select sum(total)as sum,billing_city 
from invoice 
group by billing_city 
order by sum 

-- Q5: Who is the best customer?
--  The customer who has spent the most money will be declared the best customer. 
--  Write a query that returns the person who has spent the most money.

select customer.customer_id , customer.first_name, customer.last_name, sum(invoice.total) as total
from customer
JOIN invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1

-- Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
--  Return your list ordered alphabetically by email starting with A

select distinct email, first_name, last_name
 from customer
 join invoice on customer.customer_id = invoice.customer_id
 join invoice_line on invoice.invoice_id = invoice_line.invoice_id
 where track_id in (
        select track_id from track 
        JOIN genre on track.genre_id = genre.genre_id 
        where genre.name LIKE 'ROCK'
 )
 order by email

--  Q6 Let's invite the artists who have written the most rock music in our dataset. 
--  Write a query that returns the Artist name and total track count of the top 10 rock bands

select artist.artist_id, artist.name , count(artist.artist_id)  as total_no_of_tracks
from track
JOIN album on album.album_id = track.album_id
JOIN artist on artist.artist_id = album.artist_id
JOIN genre on genre.genre_id = track.genre_id
where genre.name LIKE 'Rock'
group by artist.artist_id
order by total_no_of_tracks desc
limit 10

-- Q7 Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

select track.name , track.milliseconds 
from track 
where milliseconds > ( 
        select avg(milliseconds)  as avg_track_length
        from track )
order by track.milliseconds desc


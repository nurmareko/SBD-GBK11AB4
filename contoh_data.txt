INSERT INTO user (username, email, password_hash, full_name, phone_number, role, is_dorm_resident, dorm_room, verified, wallet_balance, reward_point)
VALUES
  ('maikelhulu', 'maikelhulu@student.telu.ac.id', '$2b$12$hashvalue2', 'Maikel Hulu', 8123456782, 'student', True, 'Asrama Putra 10, Kamar 319', True, 273714.55, 691),
  ('yehezkielenrico', 'yehezkielenrico@student.telu.ac.id', '$2b$12$hashvalue1', 'Yehezkiel enrico', 8123456781, 'student', False, '', True, 821177.44, 14),
  ('rahmawatidewi', 'rahmawati@yandex.ru', '$2b$12$hashvalue3', 'Rahmawati Dewi', 8123456783, 'guest', False, '', True, 962609.24, 346),
  ('budisantoso', 'budi@email.com', '$2b$12$hashvalue4', 'Budi Santoso', 8123456784, 'guest', False, '', True, 839170.99, 627),
  ('indahlestari', 'indah@email.com', '$2b$12$hashvalue5', 'Indah Lestari', 8123456785, 'guest', False, '', False, 0.00, 0);

INSERT INTO merchant (name, email, password_hash, phone_number, store_name, pickup_location, rating_avg, rating_count)
VALUES
  ('Syamsudin T', 'syamsudin@email.com', '$2b$12$merchanthash1', 8987654321, 'Rasa Nusantara', 'Gerai 01', 4.58, 354),
  ('Rahmat M', 'rahmat@email.com', '$2b$12$merchanthash2', 8987654322, 'Dapur Lezat', 'Gerai 02', 4.74, 376),
  ('Siska S', 'siska@email.com', '$2b$12$merchanthash3', 8987654323, 'Santapan Sehat', 'Gerai 03', 4.57, 347),
  ('Ihkam A', 'ihkam@email.com', '$2b$12$merchanthash4', 8987654324, 'Warung Selera', 'Gerai 04', 4.72, 171),
  ('Kurniawati J', 'kurniawati@email.com', '$2b$12$merchanthash5', 8987654325, 'piyo', 'Gerai 05', 4.92, 247);

INSERT INTO product (merchant_id, name, price, stock, preparation_time_minutes, is_special, last_stock_update, special_available_date)
VALUES
  (1, 'Soto medan', 18000.0, 27, 20, False, '2025-06-20 00:00:00', null),
  (1, 'Es Teh Manis', 5000.00, 12, 5, False, '2025-06-20 00:00:00', null),
  (3, 'Mie Kuah Nusantara', 17000.00, 25, 30, False, '2025-06-20 00:00:00', null),
  (3, 'Dimsum mix isi 4', 22000.00, 17, 10, False, '2025-06-20 00:00:00', null),
  (5, 'Katsu Curry', 30000.00, 19, 15, True, '2025-06-20 00:00:00', '2025-06-20 00:00:00');

INSERT INTO customer_order (user_id, order_datetime, required_datetime, estimated_duration_minutes, completed_datetime, total_price, is_delivery, delivery_location, order_status)
VALUES
  (3, '2025-06-03 07:24:50.735000', '2025-06-10 08:24:50.735000', 57, '2025-06-10 07:50:50.735000', 60000.00, False, '', 'completed'),
  (1, '2025-06-06 07:24:50.735000', '2025-06-11 08:24:50.735000', 48, '2025-06-11 08:30:50.735000', 49000.00, True, 'Room 103', 'completed'),
  (5, '2025-05-31 07:24:50.735000', '2025-06-08 08:24:50.735000', 39, '2025-06-10 07:24:50.735000', 30000.00, False, '', 'pending'),
  (4, '2025-05-29 07:24:50.735000', '2025-06-10 08:24:50.735000', 41, '2025-06-10 07:24:50.735000', 90000.00, False, '', 'pending'),
  (2, '2025-06-01 07:24:50.735000', '2025-06-09 08:24:50.735000', 27, '2025-06-10 07:24:50.735000', 25000.00, True, 'Room 106', 'ready');

INSERT INTO order_detail (order_id, product_id, unit_price, quantity)
VALUES
  (5, 2, 10000.00, 3),
  (4, 4, 90000.00, 1),
  (1, 5, 49000.00, 1),
  (3, 1, 40000.00, 1),
  (3, 5, 20000.00, 1);

INSERT INTO payment (order_id, method, ewallet_amount, wallet_amount, debit_amount)
VALUES
  (1, 'wallet', 0.0, 49000.00, 0.00),
  (2, 'ewallet', 30000.00, 0.00, 0.00),
  (3, 'mixed', 50000.00, 10000.00, 0.00),
  (4, 'ewallet', 90000.00, 0.00, 0.00),
  (5, 'mixed', 5000.00, 5000.00, 0.00);

INSERT INTO rating (user_id, merchant_id, order_id, rating_value, review_text, created_at)
VALUES
  (1, 2, 4, 5, 'mantab', '2025-06-11 03:59:01.319243'),
  (1, 2, 1, 1, '', '2025-06-11 03:59:01.319253'),
  (4, 5, 4, 2, '', '2025-06-11 03:59:01.319256'),
  (3, 5, 2, 3, 'biasa aja', '2025-06-11 03:59:01.319258'),
  (1, 4, 3, 5, 'enak', '2025-06-11 03:59:01.319261');

INSERT INTO voucher (code, value, min_transaction, start_date, end_date, merchant_id, max_redemption, current_redemption)
VALUES
  ('DISC10', 11000.00, 30000.00, '2025-06-11', '2025-07-11', 5, 100, 11),
  ('DISC20', 25000.00, 100000.00, '2025-06-11', '2025-07-11', 3, 100, 37),
  ('DISC30', 30000.00, 150000.00, '2025-06-11', '2025-07-11', 4, 100, 17),
  ('DISC40', 5000.00, 30000.00, '2025-06-11', '2025-07-11', 3, 100, 41),
  ('DISC50', 20000.00, 90000.00, '2025-06-11', '2025-07-11', 5, 100, 0);

INSERT INTO promo (name, type, merchant_id, start_time, end_time, volume_limit, used_count)
VALUES
  ('Promo 1', 'time', 4, '2025-06-11 03:59:01.321235', '2025-06-18 03:59:01.321237', NULL, 14),
  ('Promo 2', 'time', 1, '2025-06-11 03:59:01.321246', '2025-06-18 03:59:01.321247', NULL, 12),
  ('Promo 3', 'time', 3, '2025-06-11 03:59:01.321251', '2025-06-18 03:59:01.321251', NULL, 19),
  ('Promo 4', 'volume', 3, '2025-06-11 03:59:01.321254', '2025-06-18 03:59:01.321255', 100.0, 3),
  ('Promo 5', 'time', 2, '2025-06-11 03:59:01.321260', '2025-06-18 03:59:01.321261', NULL, 18);

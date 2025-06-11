
![FIT Telkom University Logo](logo_fit.png)

# Laporan Tugas Besar Sistem Basis Data I

- **Drestayumna Nurmareko** – 607062400056  
- **Maikel Buala Beriman Hulu** – 607062430007  
- **Yehezkiel Enrico Bangun** – 6706213082

---

## Daftar Isi

1. [Deskripsi Topik](#deskripsi-topik)
2. [Asumsi Tambahan](#asumsi-tambahan)
3. [Entity Relationship Diagram (ERD)](#entity-relationship-diagram-erd)
4. [Skema Relasi](#skema-relasi)
5. [Deskripsi Tabel](#deskripsi-tabel)
6. [Sintak SQL](#sintak-sql)

---

## Deskripsi Topik

### Topik M – Smart Canteen

**DigiFood Campus** adalah sistem smart kantin digital yang diimplementasikan di sebuah kampus dengan sekitar 5000 mahasiswa. Tujuan utama sistem ini adalah mengurangi antrian panjang saat jam makan siang dan meningkatkan efisiensi pelayanan melalui aplikasi mobile serta sistem kiosk digital.

#### Aturan Bisnis:
1. Pengguna dapat memesan makanan melalui aplikasi mobile atau kiosk di kampus, baik langsung maupun menggunakan fitur pre-order (hingga H-1). Tiap transaksi memiliki nomor antrian digital yang bisa dilacak. Pengguna bisa memiliki banyak pesanan aktif dan dalam satu transaksi dapat memesan dari beberapa merchant sekaligus.
2. Pengguna memilih lokasi pengambilan berdasarkan merchant. Merchant harus menyiapkan pesanan maksimal dalam 1 jam, jika tidak maka statusnya "terlambat". Untuk pesanan multi-merchant, pengambilan dilakukan di kasir yang akan memverifikasi dan memperbarui status pesanan.
3. Pesanan bisa dibatalkan sebelum merchant mengonfirmasi. Modifikasi hanya diperbolehkan sebelum pembayaran. Jika terjadi kesalahan dari merchant, pengguna bisa memilih pengembalian saldo atau substitusi menu.
4. Top-up saldo kantin bisa dilakukan melalui aplikasi, minimarket kampus, atau transfer bank, minimal Rp20.000 dan maksimal Rp2.000.000.
5. Pembayaran dapat dilakukan menggunakan saldo kantin, e-wallet (OVO, GoPay, Dana, ShopeePay), dan kartu debit kampus. Bila menggunakan kombinasi, saldo kantin digunakan terlebih dahulu. Cashback (maksimal 10%) hanya untuk transaksi berikutnya. Reward points diberikan 1 poin per Rp10.000 transaksi dan dapat dikonversi menjadi diskon atau voucher. Biaya pengantaran Rp5.000 jika berlaku.
6. Merchant wajib memperbarui stok setiap 2 jam. Merchant dengan rating < 3.5 selama 3 bulan berturut-turut akan dievaluasi dan dikenai sanksi. Rating dan ulasan dapat diberikan oleh pengguna. Merchant dengan rating > 4.5 selama 6 bulan berturut-turut akan mendapat badge “Top Merchant”.
7. Verifikasi akun lewat email wajib dilakukan sebelum transaksi pertama. Menu spesial harus diajukan H-3 sebelum tampil di aplikasi.
8. Promo terbagi menjadi dua tipe: berdasarkan volume (contoh: 100 orang pertama) dan berdasarkan waktu/periode (contoh: jam 12–13 pada 27–29 Januari). Promo dapat berlaku umum atau terbatas pada merchant tertentu.

---

## Asumsi Tambahan

1. **Login menggunakan SSO Mahasiswa**  
   Sistem menggunakan integrasi Single Sign-On (SSO) kampus untuk autentikasi pengguna aplikasi mobile.

2. **Kiosk digital adalah tablet di meja kantin**  
   Setiap meja di kantin memiliki tablet (kiosk digital) yang dapat digunakan untuk memesan makanan.

3. **Pengguna kiosk tidak perlu login**  
   Pemesanan melalui kiosk tidak memerlukan login, sehingga dapat digunakan secara anonim untuk efisiensi.

4. **Fitur pengantaran (delivery) hanya untuk penghuni asrama**  
   Fitur ini dibatasi untuk mahasiswa yang tinggal di asrama kampus untuk memudahkan distribusi.

5. **Nomor antrian digantikan dengan status pesanan dan estimasi waktu selesai**  
   - **Alasan**: Sistem antrian kurang efisien dalam model pelayanan asinkron.  
   - Sistem memberikan status real-time (misalnya: *dalam antrian, diproses, selesai*) dan estimasi waktu selesai yang lebih relevan bagi pengguna.

6. **Setiap menu memiliki waktu persiapan masing-masing**  
   - **Alasan**: Waktu persiapan berbeda untuk setiap jenis makanan. Informasi ini digunakan untuk menghitung estimasi penyelesaian pesanan.

---

## Entity Relationship Diagram (ERD)

###### ![ERD Diagram](smart_canteen_ERD.png)

---

## Skema Relasi

![ERD Diagram](skema_relasi.png)

---

## Deskripsi Tabel

### 1. Tabel `user`
- **Jenis Tabel**: Master  
- **Laju**: 6.000/tahun  
- **Deskripsi**: Menyimpan informasi pengguna sistem.

#### Atribut:

| Nama Atribut       | Tipe Data               | Keterangan                  |
| ------------------ | ----------------------- | --------------------------- |
| user\_id           | INT                     | Primary Key, Auto Increment |
| username           | VARCHAR(50)             | Unique                      |
| email              | VARCHAR(100)            | Not Null, Unique            |
| password\_hash     | TEXT                    | Not Null                    |
| full\_name         | VARCHAR(100)            | Not Null                    |
| phone\_number      | VARCHAR(20)             | Opsional                    |
| role               | ENUM('student','guest') | Not Null                    |
| is\_dorm\_resident | BOOLEAN                 | Default FALSE               |
| dorm\_room         | VARCHAR(50)             | Opsional                    |
| verified           | BOOLEAN                 | Default FALSE               |
| wallet\_balance    | DECIMAL(12,2)           | Maksimal Rp 2.000.000       |
| reward\_point      | INT                     | Default 0                   |

---

### 2. Tabel `merchant`
- **Jenis Tabel**: Master  
- **Laju**: 25/tahun  
- **Deskripsi**: Menyimpan informasi pemilik usaha kantin, termasuk login, lokasi pickup, dan rating.

#### Atribut:

| Nama Atribut     | Tipe Data    | Keterangan                  |
| ---------------- | ------------ | --------------------------- |
| merchant\_id     | INT          | Primary Key, Auto Increment |
| name             | VARCHAR(100) | Not Null                    |
| email            | VARCHAR(100) | Not Null, Unique            |
| password\_hash   | TEXT         | Not Null                    |
| phone\_number    | VARCHAR(20)  | Not Null                    |
| store\_name      | VARCHAR(100) | Not Null                    |
| pickup\_location | TEXT         | Not Null                    |
| rating\_avg      | DECIMAL(3,2) | Default 0.00                |
| rating\_count    | INT          | Default 0                   |

---

### 3. Tabel `product`
- **Jenis Tabel**: Master  
- **Laju**: 500/tahun  
- **Deskripsi**: Menyimpan data menu yang ditawarkan oleh merchant termasuk stok dan waktu persiapan.

#### Atribut:

| Nama Atribut               | Tipe Data     | Keterangan                  |
| -------------------------- | ------------- | --------------------------- |
| product\_id                | INT           | Primary Key, Auto Increment |
| merchant\_id               | INT           | Foreign Key ke `merchant`   |
| name                       | VARCHAR(100)  | Not Null                    |
| price                      | DECIMAL(12,2) | Not Null                    |
| stock                      | INT           | Default 0                   |
| last\_stock\_update        | DATETIME      | Not Null                    |
| preparation\_time\_minutes | INT           | Not Null                    |
| is\_special                | BOOLEAN       | Default FALSE               |
| special\_available\_date   | DATE          | Not Null                    |

---

### 4. Tabel `customer_order`
- **Jenis Tabel**: Transaksi  
- **Laju**: 60.000/tahun  
- **Deskripsi**: Mencatat transaksi pemesanan makanan oleh pengguna.

#### Atribut:

| Nama Atribut                 | Tipe Data                                                   | Keterangan                  |
| ---------------------------- | ----------------------------------------------------------- | --------------------------- |
| order\_id                    | INT                                                         | Primary Key, Auto Increment |
| user\_id                     | INT                                                         | Foreign Key ke `user`       |
| order\_datetime              | TIMESTAMP                                                   | Default CURRENT\_TIMESTAMP  |
| required\_datetime           | TIMESTAMP                                                   | Default CURRENT\_TIMESTAMP  |
| estimated\_duration\_minutes | INT                                                         | Not Null                    |
| completed_datetime | TIMESTAMP                                                         | Not Null                    |
| total\_price                 | DECIMAL(12,2)                                               | Not Null                    |
| pickup_location | VARCHAR(100)                                                | Opsional                    |
| is\_delivery                 | BOOLEAN                                                     | Default FALSE               |
| delivery\_location           | VARCHAR(100)                                                | Opsional                    |
| order\_status                | ENUM('pending','preparing','ready','completed','cancelled') | Default 'pending'           |

---

### 5. Tabel `order_detail`
- **Jenis Tabel**: Transaksi  
- **Laju**: 100.000/tahun  
- **Deskripsi**: Mencatat rincian tiap pesanan seperti produk yang dibeli, jumlah, dan harga satuan.

#### Atribut:

| Nama Atribut      | Tipe Data     | Keterangan                      |
| ----------------- | ------------- | ------------------------------- |
| order\_detail\_id | INT           | Primary Key, Auto Increment     |
| order\_id         | INT           | Foreign Key ke `customer_order` |
| product\_id       | INT           | Foreign Key ke `product`        |
| unit\_price       | DECIMAL(12,2) | Not Null                        |
| quantity          | INT           | Default 1                       |

---

### 6. Tabel `payment`
- **Jenis Tabel**: Transaksi  
- **Laju**: 60.000/tahun  
- **Deskripsi**: Menyimpan informasi metode dan jumlah pembayaran untuk setiap pesanan.

#### Atribut:

| Nama Atribut    | Tipe Data                                | Keterangan                      |
| --------------- | ---------------------------------------- | ------------------------------- |
| payment\_id     | INT                                      | Primary Key, Auto Increment     |
| order\_id       | INT                                      | Foreign Key ke `customer_order` |
| method          | ENUM('wallet','ewallet','mixed','debit') | Not Null                        |
| ewallet\_amount | DECIMAL(12,2)                            | Default 0.00                    |
| wallet\_amount  | DECIMAL(12,2)                            | Default 0.00                    |
| debit\_amount   | DECIMAL(12,2)                            | Default 0.00                    |

---

### 7. Tabel `rating`
- **Jenis Tabel**: Transaksi  
- **Laju**: 40.000/tahun  
- **Deskripsi**: Menyimpan ulasan dan nilai rating dari pengguna terhadap merchant setelah transaksi selesai.

#### Atribut:

| Nama Atribut  | Tipe Data | Keterangan                      |
| ------------- | --------- | ------------------------------- |
| rating\_id    | INT       | Primary Key, Auto Increment     |
| user\_id      | INT       | Foreign Key ke `user`           |
| merchant\_id  | INT       | Foreign Key ke `merchant`       |
| order\_id     | INT       | Foreign Key ke `customer_order` |
| rating\_value | INT       | Check: 1–5                      |
| review\_text  | TEXT      | Opsional                        |
| created\_at   | TIMESTAMP | Default CURRENT\_TIMESTAMP      |

---

### 8. Tabel `voucher`
- **Jenis Tabel**: Referensi  
- **Laju**: 100/tahun  
- **Deskripsi**: Menyimpan informasi kode voucher, nilai diskon, dan batas penggunaan.

#### Atribut:

| Nama Atribut        | Tipe Data     | Keterangan                  |
| ------------------- | ------------- | --------------------------- |
| voucher\_id         | INT           | Primary Key, Auto Increment |
| code                | VARCHAR(50)   | Unique, Not Null            |
| value               | DECIMAL(12,2) | Not Null                    |
| min\_transaction    | DECIMAL(12,2) | Opsional                    |
| start\_date         | DATE          | Opsional                    |
| end\_date           | DATE          | Opsional                    |
| merchant\_id        | INT           | Foreign Key ke `merchant`   |
| max\_redemption     | INT           | Not Null                    |
| current\_redemption | INT           | Default 0                   |

---

### 9. Tabel `promo`
- **Jenis Tabel**: Referensi  
- **Laju**: 50/tahun  
- **Deskripsi**: Menyimpan data promo berdasarkan waktu atau volume pengguna serta merchant terkait.

#### Atribut:

| Nama Atribut  | Tipe Data             | Keterangan                  |
| ------------- | --------------------- | --------------------------- |
| promo\_id     | INT                   | Primary Key, Auto Increment |
| name          | VARCHAR(100)          | Not Null                    |
| type          | ENUM('volume','time') | Not Null                    |
| merchant\_id  | INT                   | Foreign Key ke `merchant`   |
| start\_time   | TIMESTAMP             | Opsional                    |
| end\_time     | TIMESTAMP             | Opsional                    |
| volume\_limit | INT                   | Opsional                    |
| used\_count   | INT                   | Default 0                   |

---

## Sintak SQL

### Data Definition Language (DDL)

```mysql
CREATE DATABASE smart_canteen;
-- ===========================================================================

CREATE TABLE user (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  
  -- Login credentials
  username VARCHAR(50) UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  
  -- Personal information
  full_name VARCHAR(100) NOT NULL,
  phone_number VARCHAR(20),
  role ENUM('student', 'guest') NOT NULL,
  
  -- Residence status for student
  is_dorm_resident BOOLEAN DEFAULT FALSE,
  dorm_room VARCHAR(50),
  
  -- Account status and wallet
  verified BOOLEAN DEFAULT FALSE,
  wallet_balance DECIMAL(12,2) DEFAULT 0.00 CHECK (wallet_balance <= 2000000),
  reward_point INT DEFAULT 0
);

-- ===========================================================================
CREATE TABLE merchant (
  merchant_id INT AUTO_INCREMENT PRIMARY KEY,
  
  -- Personal info and login credentials
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  phone_number VARCHAR(20),
  
  -- Business info
  store_name VARCHAR(100) NOT NULL,
  pickup_location TEXT,
  
  -- Rating info
  rating_avg DECIMAL(3,2) DEFAULT 0.00,
  rating_count INT DEFAULT 0
);

-- ===========================================================================
CREATE TABLE product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  
  -- Relationship
  merchant_id INT NOT NULL,
  FOREIGN KEY (merchant_id) REFERENCES merchant(merchant_id),
  
  -- Product details
  name VARCHAR(100) NOT NULL,
  price DECIMAL(12,2) NOT NULL,
  stock INT DEFAULT 0,
  last_stock_update datetime,
  preparation_time_minutes INT,
  
  -- Special product info
  is_special BOOLEAN DEFAULT FALSE,
  special_available_date DATE
);

-- ===========================================================================
CREATE TABLE customer_order (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  
  -- Relationship
  user_id INT,
  FOREIGN KEY (user_id) REFERENCES user(user_id),
  
  -- Order time and price
  order_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  required_datetime TIMESTAMP NOT NULL,
  estimated_duration_minutes INT, -- after the order accepted
  total_price DECIMAL(12,2) NOT NULL,
  
  -- Delivery details
  is_delivery BOOLEAN DEFAULT FALSE,
  delivery_location VARCHAR(100),
  
  -- Status
  order_status ENUM('pending', 'preparing', 'ready', 'completed', 'cancelled') DEFAULT 'pending',
  payment_status ENUM('pending', 'paid') DEFAULT 'pending'
);

-- ===========================================================================
CREATE TABLE order_detail (
  order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
  
  -- Relationships
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES customer_order(order_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  
  -- Purchase info
  unit_price DECIMAL(12,2) NOT NULL,
  quantity INT NOT NULL DEFAULT 1
);

-- ===========================================================================
CREATE TABLE payment (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  
  -- Relationship
  order_id INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES customer_order(order_id),
  
  -- Payment method
  method ENUM('wallet', 'ewallet', 'mixed', 'debit') NOT NULL,
  
  -- eWallet
  ewallet_type ENUM('OVO', 'GoPay', 'Dana', 'ShopeePay'),
  ewallet_amount DECIMAL(12,2) DEFAULT 0.00,
  
  -- Wallet and debit
  wallet_amount DECIMAL(12,2) DEFAULT 0.00,
  debit_amount DECIMAL(12,2) DEFAULT 0.00
);

-- ===========================================================================
CREATE TABLE rating (
  rating_id INT AUTO_INCREMENT PRIMARY KEY,
  
  -- Relationships
  user_id INT NOT NULL,
  merchant_id INT NOT NULL,
  order_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(user_id),
  FOREIGN KEY (merchant_id) REFERENCES merchant(merchant_id),
  FOREIGN KEY (order_id) REFERENCES customer_order(order_id),
  
  -- Rating content
  rating_value INT NOT NULL CHECK (rating_value BETWEEN 1 AND 5),
  review_text TEXT,
  
  -- Creation time
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================================================
CREATE TABLE voucher (
  voucher_id INT AUTO_INCREMENT PRIMARY KEY,
  
  -- Voucher code and value
  code VARCHAR(50) UNIQUE NOT NULL,
  price INT NOT NULL,
  value DECIMAL(12,2) NOT NULL,
  min_transaction DECIMAL(12,2),
  
  -- Valid period
  start_date DATE,
  end_date DATE,
  
  -- Issuer
  merchant_id INT,
  FOREIGN KEY (merchant_id) REFERENCES merchant(merchant_id),
  
  -- Redemption
  max_redemption INT NOT NULL,
  current_redemption INT DEFAULT 0
);

-- ===========================================================================
CREATE TABLE promo (
  promo_id INT AUTO_INCREMENT PRIMARY KEY,
  
  -- Promo details
  name VARCHAR(100) NOT NULL,
  type ENUM('volume', 'time') NOT NULL,
  
  -- Relationship
  merchant_id INT,
  FOREIGN KEY (merchant_id) REFERENCES merchant(merchant_id),
  
  -- Time-based promo
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  
  -- Volume-based promo
  volume_limit INT,
  used_count INT DEFAULT 0
);
```

### Data Manipulation Language (DML)

```mysql
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
```

---

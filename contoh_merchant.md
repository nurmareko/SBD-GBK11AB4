# Proses Penggunaan Sistem DigiFood Campus oleh Merchant

Simulasi ini menggambarkan alur penggunaan sistem oleh seorang merchant yang mendaftarkan toko, menambahkan produk, dan menerima pesanan.

---

## **Registrasi Merchant**
Merchant mendaftar menggunakan email dan data toko.

**Data:**

```
name: Ibu Ros
email: rossi@email.com
store_name: Warung Medan
pickup_location: kedai 07
```

---

**Tabel Merchant:**

| Atribut         | Data                                 |
| --------------- | ------------------------------------ |
| merchant_id     | 1                                    |
| name            | Ibu Ros                              |
| email           | rossi@email.com |
| password_hash   | $2b$12$@#jd9832jhf##                   |
| phone_number    | 081234567890                         |
| store_name      | Warung Medan                         |
| pickup_location | kedai 07         |
| rating_avg      | 0.00                                 |
| rating_count    | 0                                    |

---

## **Menambahkan Produk Baru**
Merchant menambahkan dua produk: Soto Medan dan Es Teh Manis.

**Produk:**
```
(1) Soto Medan – Rp18.000 – stok 50 – waktu masak 15 menit
(2) Es Teh Manis – Rp5.000 – stok 100 – waktu masak 3 menit
```

---

**Tabel Produk:**

| product_id | merchant_id | name          | price   | stock | preparation_time_minutes | is_special | special_available_date | last_stock_update     |
| ---------- | ----------- | ------------- | ------- | ----- | ------------------------- | ---------- | ---------------------- | --------------------- |
| 1          | 1           | Soto Medan    | 18000.00| 50    | 15                        | FALSE      |                        | 2025-06-11 07:00:00   |
| 2          | 1           | Es Teh Manis  | 5000.00 | 100   | 3                         | FALSE      |                        | 2025-06-11 07:00:00   |

---

## **Menerima Pesanan**
Merchant menerima satu pesanan untuk Soto Medan ×3 dan Es Teh Manis ×2.

**Rincian Pesanan:**
```
total_price: 64.000
required_datetime: 2025-06-12 13:00:00
delivery_location: Asrama Putra 10, Kamar 319
```

---

**Tabel Customer Order:**

| Atribut                      | Data                       |
| ---------------------------- | -------------------------- |
| order_id                    | 1                          |
| user_id                     | 1                          |
| order_datetime              | 2025-06-12 07:30:00        |
| required_datetime           | 2025-06-12 13:00:00        |
| estimated_duration_minutes  | 30                         |
| completed_datetime          |                            |
| total_price                 | 64.000                     |
| is_delivery                 | TRUE                       |
| delivery_location           | Asrama Putra 10, Kamar 319 |
| order_status                | pending                    |

---

## **Memproses dan Menyelesaikan Pesanan**
Merchant menyiapkan pesanan dan menandainya sebagai selesai.

**Status:**
```
order_status: completed
completed_datetime: 2025-06-12 12:48:00
```

---

**Tabel Customer Order (Setelah Update):**

| Atribut                      | Data                       |
| ---------------------------- | -------------------------- |
| order_id                    | 1                          |
| user_id                     | 1                          |
| order_datetime              | 2025-06-12 07:30:00        |
| required_datetime           | 2025-06-12 13:00:00        |
| estimated_duration_minutes  | 30                         |
| completed_datetime          | 2025-06-12 12:48:00        |
| total_price                 | 64.000                     |
| is_delivery                 | TRUE                       |
| delivery_location           | Asrama Putra 10, Kamar 319 |
| order_status                | completed                  |

---

## **Mendapatkan Rating**
Merchant menerima ulasan dari pelanggan.

**Rating:**
```
rating_value: 4
review_text: "Sotonya mantap, porsi besar. es teh juga tidak terlalu manis"
```

---

**Tabel Rating:**

| Atribut       | Data                                                         |
| ------------- | ------------------------------------------------------------ |
| rating_id     | 1                                                            |
| user_id       | 1                                                            |
| merchant_id   | 1                                                            |
| order_id      | 1                                                            |
| rating_value  | 4                                                            |
| review_text   | Sotonya mantap, porsi besar. es teh juga tidak terlalu manis |
| created_at    | 2025-06-12 15:00:00                                          |

---

**Tabel Merchant (Update Rating):**

| Atribut         | Data                                 |
| --------------- | ------------------------------------ |
| merchant_id     | 1                                    |
| name            | Ibu Ros                              |
| email           | warungmedan@telkomuniversity.ac.id   |
| password_hash   | $2b$12$@#jd9832jhf##                   |
| phone_number    | 081234567890                         |
| store_name      | Warung Medan                         |
| pickup_location | Kantin Teknik, Blok C                |
| rating_avg      | 4.00                                 |
| rating_count    | 1                                    |

---

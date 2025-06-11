
# Proses Penggunaan Sistem DigiFood Campus

Simulasi ini menggambarkan alur penggunaan sistem oleh seorang mahasiswa yang memesan makanan dan juga merchant yang mendaftarkan tokonya.

---

## **Registrasi Pengguna**
Mahasiswa mendaftar menggunakan akun SSO kampus.

**Data:**

```
username: maikelhulu
email: maikelhulu@student.telu.ac.id
verified: TRUE
wallet_balance: 0.00
```

---

**Tabel User:**

| Atrbut             | Data                          |
| ------------------ | ----------------------------- |
| user\_id           | 1                             |
| username           | maikelhulu                    |
| email              | maikelhulu@student.telu.ac.id |
| password\_hash     | $2b$12$@#$@$fwqdfF#@R3        |
| full\_name         | Maikel Hulu                   |
| phone\_number      | 082110778883                  |
| role               | student                       |
| is\_dorm\_resident | TRUE                          |
| dorm\_room         | Asrama Putra 10, Kamar 319    |
| verified           | TRUE                          |
| wallet\_balance    | 0.00                          |
| reward\_point      | 0                             |

---

## **Top-Up Saldo Kantin**
Pengguna melakukan top-up saldo sebesar Rp100.000.

**Perubahan:**
```
wallet_balance: 100000.00
```

---

**Tabel User:**

| Atrbut             | Data                          |
| ------------------ | ----------------------------- |
| user\_id           | 1                             |
| username           | maikelhulu                    |
| email              | maikelhulu@student.telu.ac.id |
| password\_hash     | $2b$12$@#$@$fwqdfF#@R3        |
| full\_name         | Maikel Hulu                   |
| phone\_number      | 082110778883                  |
| role               | student                       |
| is\_dorm\_resident | TRUE                          |
| dorm\_room         | Asrama Putra 10, Kamar 319    |
| verified           | TRUE                          |
| wallet\_balance    | 100000.00                     |
| reward\_point      | 0                             |

---

## **Pemesanan Pre-Order dengan Delivery**
Pengguna memesan satu Nasi Lemak Medan dan satu Bihun Bebek Medan dengan pengiriman ke asrama.

**Pesanan:**
```
Soto Medan ×3
Es Teh Manis ×2
total_price: 64.000
is_delivery: TRUE
delivery_location: Asrama Putra 10, Kamar 319
required_datetime: 2025-06-12 13:00:00
```

---

**Tabel Customer Order:**

| Atribut                      | Data                       |
| ---------------------------- | -------------------------- |
| order\_id                    | 1                          |
| user\_id                     | 1                          |
| order\_datetime              | 2025-06-12 07:30:00        |
| required\_datetime           | 2025-06-12 13:00:00        |
| estimated\_duration\_minutes | 30                         |
| completed_datetime           |                            |
| total\_price                 | 64.000                     |
| pickup_location              |                            |
| is\_delivery                 | TRUE                       |
| delivery\_location           | Asrama Putra 10, Kamar 319 |
| order\_status                | pending                    |

---

## **Detail Produk pada Pesanan**
Sistem mencatat detail pesanan berdasarkan item yang dipesan.

**Detail:**
```
(1) Soto Medan – Rp18.000 ×3
(2) Es Teh Manis – Rp5.000 ×2
```

---

**Tabel Order Detail:**

| order\_detail\_id      | order\_id      | product\_id       |unit\_price       |quantity          |
| ----------------- | ------------- | ------------- | ------------- | ------------- |
| 1 | 1           | 1           | 18.000     | 3 |
| 2 | 1           | 2           | 5.000      | 2 |

---

## **Pembayaran Menggunakan Saldo Kantin**
Pengguna melakukan pembayaran penuh dengan saldo kantin.

**Pembayaran:**
```
method: wallet
wallet_amount: 64000.00
```

---

**Tabel Pembayaran:**

| Atribut         | Data     |
| --------------- | -------- |
| payment\_id     | 1        |
| order\_id       | 1        |
| method          | wallet   |
| ewallet\_amount | 0.00     |
| wallet\_amount  | 64000.00 |
| debit\_amount   | 0.00     |

---

## **Saldo Kantin Berkurang**
Saldo pengguna diperbarui setelah transaksi.

**Saldo:**
```
wallet_balance: 36000.00
```

---

**Tabel User:**

| Atrbut             | Data                          |
| ------------------ | ----------------------------- |
| user\_id           | 1                             |
| username           | maikelhulu                    |
| email              | maikelhulu@student.telu.ac.id |
| password\_hash     | $2b$12$@#$@$fwqdfF#@R3        |
| full\_name         | Maikel Hulu                   |
| phone\_number      | 082110778883                  |
| role               | student                       |
| is\_dorm\_resident | TRUE                          |
| dorm\_room         | Asrama Putra 10, Kamar 319    |
| verified           | TRUE                          |
| wallet\_balance    | 36000.00                     |
| reward\_point      | 0                             |

---

## **Status Pesanan Berubah**
Pesanan diproses dan selesai tepat waktu.

**Status:**
```
order_status: completed
```

---

**Tabel Customer Order:**

| Atribut                      | Data                       |
| ---------------------------- | -------------------------- |
| order\_id                    | 1                          |
| user\_id                     | 1                          |
| order\_datetime              | 2025-06-12 07:30:00        |
| required\_datetime           | 2025-06-12 13:00:00        |
| estimated\_duration\_minutes | 30                         |
| completed_datetime           | 2025-06-12 12:48:00        |
| total\_price                 | 64.000                     |
| pickup_location              |                            |
| is\_delivery                 | TRUE                       |
| delivery\_location           | Asrama Putra 10, Kamar 319 |
| order\_status                | completed                  |

---

## **Pengguna Memberi Rating dan Ulasan**
Pengguna memberikan ulasan positif setelah menerima makanannya.

**Rating:**
```
rating_value: 4
review_text: "Sotonya mantap, porsi besar. es teh juga tidak terlalu manis"
```

---

**Tabel Rating:**

| Atribut       | Data                                                         |
| ------------- | ------------------------------------------------------------ |
| rating\_id    | 1                                                            |
| user\_id      | 1                                                            |
| merchant\_id  | 1                                                            |
| order\_id     | 1                                                            |
| rating\_value | 4                                                            |
| review\_text  | Sotonya mantap, porsi besar. es teh juga tidak terlalu manis |
| created\_at   | 2025-06-12 15:00:00                                          |

---

## **Mendapatkan Poin**
Setelah pengguna memberikan ulasan makan berhak mendapat poin.

**point:**
```
rewar_point: 15
```

**Tabel User:**

---

| Atrbut             | Data                          |
| ------------------ | ----------------------------- |
| user\_id           | 1                             |
| username           | maikelhulu                    |
| email              | maikelhulu@student.telu.ac.id |
| password\_hash     | $2b$12$@#$@$fwqdfF#@R3        |
| full\_name         | Maikel Hulu                   |
| phone\_number      | 082110778883                  |
| role               | student                       |
| is\_dorm\_resident | TRUE                          |
| dorm\_room         | Asrama Putra 10, Kamar 319    |
| verified           | TRUE                          |
| wallet\_balance    | 100000.00                     |
| reward\_point      | 15                             |

---
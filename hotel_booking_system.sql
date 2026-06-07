-- ============================================================
--  HOTEL BOOKING SYSTEM — MySQL Mini Project
--  Tables: room_types, rooms, guests, bookings, payments
-- ============================================================

CREATE DATABASE IF NOT EXISTS hotel_booking_db;
USE hotel_booking_db;

-- ============================================================
-- TABLE CREATION
-- ============================================================

CREATE TABLE room_types (
    type_id        INT AUTO_INCREMENT PRIMARY KEY,
    type_name      VARCHAR(50)    NOT NULL UNIQUE,
    price_per_night DECIMAL(8,2)  NOT NULL,
    max_occupancy  INT            NOT NULL DEFAULT 2,
    amenities      VARCHAR(200)   NOT NULL
);

CREATE TABLE rooms (
    room_id       INT AUTO_INCREMENT PRIMARY KEY,
    type_id       INT            NOT NULL,
    room_number   VARCHAR(10)    NOT NULL UNIQUE,
    floor         VARCHAR(5)     NOT NULL,
    status        ENUM('available','occupied','maintenance') NOT NULL DEFAULT 'available',
    FOREIGN KEY (type_id) REFERENCES room_types(type_id)
);

CREATE TABLE guests (
    guest_id    INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100)   NOT NULL,
    email       VARCHAR(100)   NOT NULL UNIQUE,
    phone       VARCHAR(15)    NOT NULL,
    city        VARCHAR(60)    NOT NULL,
    id_proof    VARCHAR(50)    NOT NULL,
    joined_date DATE           NOT NULL DEFAULT (CURRENT_DATE)
);

CREATE TABLE bookings (
    booking_id   INT AUTO_INCREMENT PRIMARY KEY,
    guest_id     INT            NOT NULL,
    room_id      INT            NOT NULL,
    check_in     DATE           NOT NULL,
    check_out    DATE           NOT NULL,
    num_guests   INT            NOT NULL DEFAULT 1,
    status       ENUM('confirmed','checked_in','checked_out','cancelled') NOT NULL DEFAULT 'confirmed',
    total_amount DECIMAL(10,2)  NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id)  REFERENCES rooms(room_id),
    CHECK (check_out > check_in),
    CHECK (num_guests >= 1)
);

CREATE TABLE payments (
    payment_id     INT AUTO_INCREMENT PRIMARY KEY,
    booking_id     INT            NOT NULL,
    amount_paid    DECIMAL(10,2)  NOT NULL,
    payment_mode   ENUM('cash','card','upi','net_banking') NOT NULL,
    payment_date   DATE           NOT NULL,
    payment_status ENUM('pending','completed','refunded') NOT NULL DEFAULT 'completed',
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- ============================================================
-- DATA INSERTION
-- ============================================================

-- Room Types (6 categories)
INSERT INTO room_types (type_name, price_per_night, max_occupancy, amenities) VALUES
('Standard Single',  1200.00, 1, 'AC, TV, WiFi, Hot Water'),
('Standard Double',  1800.00, 2, 'AC, TV, WiFi, Hot Water, Mini Fridge'),
('Deluxe Double',    2800.00, 2, 'AC, TV, WiFi, Hot Water, Mini Fridge, Balcony'),
('Suite',            5500.00, 4, 'AC, TV, WiFi, Jacuzzi, Living Room, Kitchenette'),
('Family Room',      3500.00, 5, 'AC, TV, WiFi, Hot Water, Mini Fridge, Extra Beds'),
('Executive Suite',  8000.00, 2, 'AC, TV, WiFi, Jacuzzi, Office Desk, City View, Lounge');

-- Rooms (30 rooms)
INSERT INTO rooms (type_id, room_number, floor, status) VALUES
(1,'101','1','available'),(1,'102','1','available'),(1,'103','1','occupied'),
(1,'104','1','available'),(1,'105','1','maintenance'),
(2,'201','2','available'),(2,'202','2','occupied'),(2,'203','2','available'),
(2,'204','2','available'),(2,'205','2','occupied'),
(3,'301','3','available'),(3,'302','3','occupied'),(3,'303','3','available'),
(3,'304','3','available'),(3,'305','3','occupied'),
(4,'401','4','available'),(4,'402','4','occupied'),(4,'403','4','available'),
(4,'404','4','maintenance'),
(5,'501','5','available'),(5,'502','5','occupied'),(5,'503','5','available'),
(5,'504','5','available'),
(6,'601','6','available'),(6,'602','6','occupied'),(6,'603','6','available'),
(2,'206','2','available'),(2,'207','2','available'),
(3,'306','3','available'),(1,'106','1','available');

-- Guests (50 guests)
INSERT INTO guests (name, email, phone, city, id_proof, joined_date) VALUES
('Arjun Sharma',      'arjun.sharma@gmail.com',    '9876543210','Chennai',   'Aadhaar-1234','2023-01-10'),
('Priya Nair',        'priya.nair@gmail.com',       '9876543211','Kochi',     'PAN-AB123',  '2023-01-15'),
('Rohit Verma',       'rohit.verma@yahoo.com',      '9876543212','Delhi',     'Passport-P01','2023-02-01'),
('Sneha Reddy',       'sneha.reddy@gmail.com',      '9876543213','Hyderabad', 'Aadhaar-5678','2023-02-14'),
('Kiran Patel',       'kiran.patel@hotmail.com',    '9876543214','Ahmedabad', 'DL-GJ01',    '2023-03-05'),
('Meera Iyer',        'meera.iyer@gmail.com',       '9876543215','Bangalore', 'Aadhaar-9012','2023-03-20'),
('Vijay Kumar',       'vijay.kumar@gmail.com',      '9876543216','Mumbai',    'PAN-VK456',  '2023-04-02'),
('Ananya Singh',      'ananya.singh@yahoo.com',     '9876543217','Lucknow',   'Aadhaar-3456','2023-04-18'),
('Suresh Menon',      'suresh.menon@gmail.com',     '9876543218','Trivandrum','Passport-P02','2023-05-01'),
('Divya Krishnan',    'divya.k@gmail.com',          '9876543219','Coimbatore','Aadhaar-7890','2023-05-10'),
('Arun Balaji',       'arun.balaji@gmail.com',      '9876543220','Chennai',   'PAN-AB789',  '2023-05-22'),
('Lakshmi Devi',      'lakshmi.devi@hotmail.com',   '9876543221','Mysore',    'Aadhaar-1122','2023-06-01'),
('Naveen Raj',        'naveen.raj@gmail.com',       '9876543222','Madurai',   'DL-TN01',    '2023-06-15'),
('Pooja Mehta',       'pooja.mehta@yahoo.com',      '9876543223','Surat',     'Passport-P03','2023-07-02'),
('Deepak Nanda',      'deepak.nanda@gmail.com',     '9876543224','Pune',      'Aadhaar-3344','2023-07-20'),
('Rekha Pillai',      'rekha.pillai@gmail.com',     '9876543225','Kochi',     'PAN-RP321',  '2023-08-01'),
('Sanjay Gupta',      'sanjay.gupta@yahoo.com',     '9876543226','Jaipur',    'Aadhaar-5566','2023-08-14'),
('Kavitha Rao',       'kavitha.rao@gmail.com',      '9876543227','Hyderabad', 'DL-AP01',    '2023-08-28'),
('Harish Nair',       'harish.nair@gmail.com',      '9876543228','Thrissur',  'Passport-P04','2023-09-05'),
('Sunita Sharma',     'sunita.sharma@hotmail.com',  '9876543229','Jaipur',    'Aadhaar-7788','2023-09-18'),
('Manoj Tiwari',      'manoj.tiwari@gmail.com',     '9876543230','Patna',     'PAN-MT654',  '2023-10-01'),
('Priyanka Das',      'priyanka.das@yahoo.com',     '9876543231','Kolkata',   'Aadhaar-9900','2023-10-15'),
('Rajan Pillai',      'rajan.pillai@gmail.com',     '9876543232','Palakkad',  'DL-KL01',    '2023-11-01'),
('Geetha Raj',        'geetha.raj@gmail.com',       '9876543233','Bangalore', 'Passport-P05','2023-11-12'),
('Sunil Bose',        'sunil.bose@hotmail.com',     '9876543234','Kolkata',   'Aadhaar-1144','2023-12-01'),
('Nithya Suresh',     'nithya.suresh@gmail.com',    '9876543235','Chennai',   'PAN-NS987',  '2023-12-14'),
('Ashok Kumar',       'ashok.kumar@yahoo.com',      '9876543236','Delhi',     'Aadhaar-2255','2024-01-05'),
('Vandana Mishra',    'vandana.mishra@gmail.com',   '9876543237','Varanasi',  'DL-UP01',    '2024-01-20'),
('Rajesh Pillai',     'rajesh.pillai@gmail.com',    '9876543238','Kottayam',  'Passport-P06','2024-02-03'),
('Sumathi Devi',      'sumathi.devi@hotmail.com',   '9876543239','Salem',     'Aadhaar-3366','2024-02-14'),
('Vivek Anand',       'vivek.anand@gmail.com',      '9876543240','Trichy',    'PAN-VA159',  '2024-03-01'),
('Chitra Balan',      'chitra.balan@yahoo.com',     '9876543241','Calicut',   'Aadhaar-4477','2024-03-18'),
('Anil Kapoor',       'anil.kapoor@gmail.com',      '9876543242','Mumbai',    'DL-MH01',    '2024-04-02'),
('Radha Krishnan',    'radha.k@gmail.com',          '9876543243','Tirunelveli','Passport-P07','2024-04-15'),
('Sudha Menon',       'sudha.menon@hotmail.com',    '9876543244','Kochi',     'Aadhaar-5588','2024-05-01'),
('Prakash Raj',       'prakash.raj@gmail.com',      '9876543245','Chennai',   'PAN-PR753',  '2024-05-12'),
('Mala Srinivasan',   'mala.srini@yahoo.com',       '9876543246','Pondicherry','Aadhaar-6699','2024-06-01'),
('Balaji Raman',      'balaji.raman@gmail.com',     '9876543247','Vellore',   'DL-TN02',    '2024-06-18'),
('Saranya Mohan',     'saranya.mohan@gmail.com',    '9876543248','Erode',     'Passport-P08','2024-07-01'),
('Ganesh Kumar',      'ganesh.k@hotmail.com',       '9876543249','Coimbatore','Aadhaar-7711','2024-07-20'),
('Usha Nair',         'usha.nair@gmail.com',        '9876543250','Kannur',    'PAN-UN246',  '2024-08-03'),
('Bala Murugan',      'bala.m@yahoo.com',           '9876543251','Madurai',   'Aadhaar-8822','2024-08-14'),
('Kavya Pillai',      'kavya.pillai@gmail.com',     '9876543252','Thrissur',  'DL-KL02',    '2024-09-01'),
('Ravi Shankar',      'ravi.shankar@gmail.com',     '9876543253','Bangalore', 'Passport-P09','2024-09-15'),
('Tamilselvi R',      'tamil.r@hotmail.com',        '9876543254','Dindigul',  'Aadhaar-9933','2024-10-01'),
('Aditya Nair',       'aditya.nair@gmail.com',      '9876543255','Palakkad',  'PAN-AN369',  '2024-10-18'),
('Bharathi S',        'bharathi.s@yahoo.com',       '9876543256','Tiruppur',  'Aadhaar-0044','2024-11-01'),
('Saravanan M',       'saravanan.m@gmail.com',      '9876543257','Chennai',   'DL-TN03',    '2024-11-14'),
('Jothi Lakshmi',     'jothi.l@gmail.com',          '9876543258','Thanjavur', 'Passport-P10','2024-12-01'),
('Murugesan K',       'murugesan.k@hotmail.com',    '9876543259','Tirunelveli','Aadhaar-1155','2024-12-15');

-- Bookings (80 bookings)
INSERT INTO bookings (guest_id, room_id, check_in, check_out, num_guests, status, total_amount) VALUES
(1,  1,  '2024-01-05','2024-01-08', 1,'checked_out', 3600.00),
(2,  6,  '2024-01-10','2024-01-13', 2,'checked_out', 5400.00),
(3,  11, '2024-01-15','2024-01-18', 2,'checked_out', 8400.00),
(4,  16, '2024-01-20','2024-01-24', 3,'checked_out',22000.00),
(5,  20, '2024-01-25','2024-01-28', 4,'checked_out',10500.00),
(6,  24, '2024-02-01','2024-02-03', 2,'checked_out',16000.00),
(7,  2,  '2024-02-05','2024-02-07', 1,'checked_out', 2400.00),
(8,  7,  '2024-02-10','2024-02-14', 2,'checked_out', 7200.00),
(9,  12, '2024-02-15','2024-02-17', 2,'checked_out', 5600.00),
(10, 17, '2024-02-20','2024-02-23', 2,'checked_out',16500.00),
(11, 21, '2024-02-25','2024-02-28', 3,'checked_out',10500.00),
(12, 25, '2024-03-01','2024-03-04', 2,'checked_out',24000.00),
(13, 3,  '2024-03-05','2024-03-08', 1,'checked_out', 3600.00),
(14, 8,  '2024-03-10','2024-03-13', 2,'checked_out', 5400.00),
(15, 13, '2024-03-15','2024-03-19', 2,'checked_out',11200.00),
(16, 18, '2024-03-20','2024-03-22', 2,'checked_out',11000.00),
(17, 22, '2024-03-25','2024-03-28', 4,'checked_out',10500.00),
(18, 26, '2024-04-01','2024-04-04', 2,'checked_out',24000.00),
(19, 4,  '2024-04-05','2024-04-07', 1,'checked_out', 2400.00),
(20, 9,  '2024-04-10','2024-04-14', 2,'checked_out', 7200.00),
(21, 14, '2024-04-15','2024-04-17', 1,'checked_out', 5600.00),
(22, 27, '2024-04-20','2024-04-23', 2,'checked_out', 5400.00),
(23, 28, '2024-04-25','2024-04-28', 2,'checked_out', 5400.00),
(24, 29, '2024-05-01','2024-05-05', 2,'checked_out',11200.00),
(25, 30, '2024-05-06','2024-05-09', 1,'checked_out', 3600.00),
(26, 1,  '2024-05-10','2024-05-12', 1,'checked_out', 2400.00),
(27, 6,  '2024-05-15','2024-05-19', 2,'checked_out', 7200.00),
(28, 11, '2024-05-20','2024-05-22', 1,'checked_out', 5600.00),
(29, 16, '2024-05-25','2024-05-28', 3,'checked_out',16500.00),
(30, 20, '2024-06-01','2024-06-04', 3,'checked_out',10500.00),
(31, 24, '2024-06-05','2024-06-08', 2,'checked_out',24000.00),
(32, 2,  '2024-06-10','2024-06-12', 1,'checked_out', 2400.00),
(33, 7,  '2024-06-15','2024-06-18', 2,'checked_out', 5400.00),
(34, 12, '2024-06-20','2024-06-24', 2,'checked_out',11200.00),
(35, 17, '2024-06-25','2024-06-28', 2,'checked_out',16500.00),
(36, 21, '2024-07-01','2024-07-05', 4,'checked_out',14000.00),
(37, 25, '2024-07-06','2024-07-09', 2,'checked_out',24000.00),
(38, 3,  '2024-07-10','2024-07-12', 1,'checked_out', 2400.00),
(39, 8,  '2024-07-15','2024-07-19', 2,'checked_out', 7200.00),
(40, 13, '2024-07-20','2024-07-22', 2,'checked_out', 5600.00),
(41, 18, '2024-07-25','2024-07-28', 1,'checked_out',16500.00),
(42, 22, '2024-08-01','2024-08-04', 3,'checked_out',10500.00),
(43, 26, '2024-08-05','2024-08-08', 2,'checked_out',24000.00),
(44, 4,  '2024-08-10','2024-08-13', 1,'checked_out', 3600.00),
(45, 9,  '2024-08-15','2024-08-18', 2,'checked_out', 5400.00),
(46, 14, '2024-08-20','2024-08-23', 2,'checked_out', 8400.00),
(47, 27, '2024-08-25','2024-08-28', 2,'checked_out', 5400.00),
(48, 28, '2024-09-01','2024-09-04', 2,'checked_out', 5400.00),
(49, 29, '2024-09-05','2024-09-08', 2,'checked_out', 8400.00),
(50, 30, '2024-09-10','2024-09-14', 1,'checked_out', 4800.00),
(1,  6,  '2024-09-15','2024-09-18', 2,'checked_out', 5400.00),
(2,  11, '2024-09-20','2024-09-23', 1,'checked_out', 8400.00),
(3,  16, '2024-09-25','2024-09-28', 2,'checked_out',16500.00),
(4,  20, '2024-10-01','2024-10-05', 3,'checked_out',14000.00),
(5,  24, '2024-10-06','2024-10-09', 2,'checked_out',24000.00),
(6,  1,  '2024-10-10','2024-10-12', 1,'checked_out', 2400.00),
(7,  7,  '2024-10-15','2024-10-18', 2,'checked_out', 5400.00),
(8,  12, '2024-10-20','2024-10-24', 2,'cancelled',  11200.00),
(9,  17, '2024-10-25','2024-10-28', 2,'checked_out',16500.00),
(10, 21, '2024-11-01','2024-11-04', 4,'checked_out',10500.00),
(11, 25, '2024-11-05','2024-11-08', 2,'checked_out',24000.00),
(12, 3,  '2024-11-10','2024-11-13', 1,'checked_out', 3600.00),
(13, 8,  '2024-11-15','2024-11-18', 2,'cancelled',   5400.00),
(14, 13, '2024-11-20','2024-11-23', 2,'checked_out', 8400.00),
(15, 18, '2024-11-25','2024-11-28', 2,'checked_out',16500.00),
(16, 22, '2024-12-01','2024-12-05', 5,'checked_out',14000.00),
(17, 26, '2024-12-06','2024-12-09', 2,'checked_out',24000.00),
(18, 4,  '2024-12-10','2024-12-13', 1,'checked_out', 3600.00),
(19, 9,  '2024-12-15','2024-12-18', 2,'checked_out', 5400.00),
(20, 14, '2024-12-20','2024-12-24', 2,'checked_out',11200.00),
(21, 27, '2024-12-25','2024-12-28', 2,'confirmed',   5400.00),
(22, 28, '2024-12-26','2024-12-30', 2,'confirmed',   7200.00),
(23, 29, '2025-01-01','2025-01-05', 2,'confirmed',  11200.00),
(24, 30, '2025-01-06','2025-01-09', 1,'confirmed',   3600.00),
(25, 2,  '2025-01-10','2025-01-14', 1,'checked_in',  4800.00),
(26, 6,  '2025-01-10','2025-01-13', 2,'checked_in',  5400.00),
(27, 11, '2025-01-11','2025-01-14', 2,'checked_in',  8400.00),
(28, 16, '2025-01-11','2025-01-15', 3,'checked_in', 22000.00),
(29, 20, '2025-01-12','2025-01-15', 4,'checked_in', 10500.00),
(30, 24, '2025-01-12','2025-01-14', 2,'checked_in', 16000.00);

-- Payments (90 payments covering all bookings + some partial/pending)
INSERT INTO payments (booking_id, amount_paid, payment_mode, payment_date, payment_status) VALUES
(1,  3600.00,'card',       '2024-01-05','completed'),
(2,  5400.00,'upi',        '2024-01-10','completed'),
(3,  8400.00,'net_banking','2024-01-15','completed'),
(4,  22000.00,'card',      '2024-01-20','completed'),
(5,  10500.00,'cash',      '2024-01-25','completed'),
(6,  16000.00,'upi',       '2024-02-01','completed'),
(7,  2400.00,'cash',       '2024-02-05','completed'),
(8,  7200.00,'card',       '2024-02-10','completed'),
(9,  5600.00,'upi',        '2024-02-15','completed'),
(10, 16500.00,'net_banking','2024-02-20','completed'),
(11, 10500.00,'card',      '2024-02-25','completed'),
(12, 24000.00,'upi',       '2024-03-01','completed'),
(13, 3600.00,'cash',       '2024-03-05','completed'),
(14, 5400.00,'card',       '2024-03-10','completed'),
(15, 11200.00,'upi',       '2024-03-15','completed'),
(16, 11000.00,'net_banking','2024-03-20','completed'),
(17, 10500.00,'card',      '2024-03-25','completed'),
(18, 24000.00,'upi',       '2024-04-01','completed'),
(19, 2400.00,'cash',       '2024-04-05','completed'),
(20, 7200.00,'card',       '2024-04-10','completed'),
(21, 5600.00,'upi',        '2024-04-15','completed'),
(22, 5400.00,'cash',       '2024-04-20','completed'),
(23, 5400.00,'card',       '2024-04-25','completed'),
(24, 11200.00,'net_banking','2024-05-01','completed'),
(25, 3600.00,'upi',        '2024-05-06','completed'),
(26, 2400.00,'cash',       '2024-05-10','completed'),
(27, 7200.00,'card',       '2024-05-15','completed'),
(28, 5600.00,'upi',        '2024-05-20','completed'),
(29, 16500.00,'net_banking','2024-05-25','completed'),
(30, 10500.00,'card',      '2024-06-01','completed'),
(31, 24000.00,'upi',       '2024-06-05','completed'),
(32, 2400.00,'cash',       '2024-06-10','completed'),
(33, 5400.00,'card',       '2024-06-15','completed'),
(34, 11200.00,'upi',       '2024-06-20','completed'),
(35, 16500.00,'net_banking','2024-06-25','completed'),
(36, 14000.00,'card',      '2024-07-01','completed'),
(37, 24000.00,'upi',       '2024-07-06','completed'),
(38, 2400.00,'cash',       '2024-07-10','completed'),
(39, 7200.00,'card',       '2024-07-15','completed'),
(40, 5600.00,'upi',        '2024-07-20','completed'),
(41, 16500.00,'net_banking','2024-07-25','completed'),
(42, 10500.00,'card',      '2024-08-01','completed'),
(43, 24000.00,'upi',       '2024-08-05','completed'),
(44, 3600.00,'cash',       '2024-08-10','completed'),
(45, 5400.00,'card',       '2024-08-15','completed'),
(46, 8400.00,'upi',        '2024-08-20','completed'),
(47, 5400.00,'net_banking','2024-08-25','completed'),
(48, 5400.00,'card',       '2024-09-01','completed'),
(49, 8400.00,'upi',        '2024-09-05','completed'),
(50, 4800.00,'cash',       '2024-09-10','completed'),
(51, 5400.00,'card',       '2024-09-15','completed'),
(52, 8400.00,'upi',        '2024-09-20','completed'),
(53, 16500.00,'net_banking','2024-09-25','completed'),
(54, 14000.00,'card',      '2024-10-01','completed'),
(55, 24000.00,'upi',       '2024-10-06','completed'),
(56, 2400.00,'cash',       '2024-10-10','completed'),
(57, 5400.00,'card',       '2024-10-15','completed'),
(58, 11200.00,'upi',       '2024-10-20','refunded'),
(59, 16500.00,'net_banking','2024-10-25','completed'),
(60, 10500.00,'card',      '2024-11-01','completed'),
(61, 24000.00,'upi',       '2024-11-05','completed'),
(62, 3600.00,'cash',       '2024-11-10','completed'),
(63, 5400.00,'card',       '2024-11-15','refunded'),
(64, 8400.00,'upi',        '2024-11-20','completed'),
(65, 16500.00,'net_banking','2024-11-25','completed'),
(66, 14000.00,'card',      '2024-12-01','completed'),
(67, 24000.00,'upi',       '2024-12-06','completed'),
(68, 3600.00,'cash',       '2024-12-10','completed'),
(69, 5400.00,'card',       '2024-12-15','completed'),
(70, 11200.00,'upi',       '2024-12-20','completed'),
(71, 5400.00,'net_banking','2024-12-25','pending'),
(72, 7200.00,'card',       '2024-12-26','pending'),
(73, 11200.00,'upi',       '2025-01-01','pending'),
(74, 3600.00,'cash',       '2025-01-06','pending'),
(75, 4800.00,'card',       '2025-01-10','pending'),
(76, 5400.00,'upi',        '2025-01-10','pending'),
(77, 8400.00,'net_banking','2025-01-11','pending'),
(78, 22000.00,'card',      '2025-01-11','pending'),
(79, 10500.00,'upi',       '2025-01-12','pending'),
(80, 16000.00,'cash',      '2025-01-12','pending'),
-- Extra payments (advance + balance split for some bookings)
(4,  5000.00,'upi',        '2024-01-18','completed'),
(10, 3500.00,'cash',       '2024-02-18','completed'),
(16, 2000.00,'card',       '2024-03-18','completed'),
(29, 4000.00,'net_banking','2024-05-23','completed'),
(35, 3000.00,'upi',        '2024-06-23','completed'),
(41, 1500.00,'card',       '2024-07-23','completed'),
(53, 2000.00,'cash',       '2024-09-23','completed'),
(59, 1000.00,'upi',        '2024-10-23','completed'),
(65, 1500.00,'card',       '2024-11-23','completed'),
(67, 3000.00,'net_banking','2024-12-04','completed');

-- ============================================================
-- STORED PROCEDURES
-- ============================================================

DELIMITER $$

-- 1. Insert a new guest
CREATE PROCEDURE sp_insert_guest(
    IN p_name     VARCHAR(100),
    IN p_email    VARCHAR(100),
    IN p_phone    VARCHAR(15),
    IN p_city     VARCHAR(60),
    IN p_id_proof VARCHAR(50)
)
BEGIN
    INSERT INTO guests (name, email, phone, city, id_proof, joined_date)
    VALUES (p_name, p_email, p_phone, p_city, p_id_proof, CURRENT_DATE);
    SELECT LAST_INSERT_ID() AS new_guest_id;
END$$

-- 2. Create a new booking
CREATE PROCEDURE sp_insert_booking(
    IN p_guest_id    INT,
    IN p_room_id     INT,
    IN p_check_in    DATE,
    IN p_check_out   DATE,
    IN p_num_guests  INT
)
BEGIN
    DECLARE nights       INT;
    DECLARE price_night  DECIMAL(8,2);
    DECLARE total        DECIMAL(10,2);

    SET nights = DATEDIFF(p_check_out, p_check_in);

    SELECT rt.price_per_night INTO price_night
    FROM rooms r
    JOIN room_types rt ON r.type_id = rt.type_id
    WHERE r.room_id = p_room_id;

    SET total = nights * price_night;

    INSERT INTO bookings (guest_id, room_id, check_in, check_out, num_guests, status, total_amount)
    VALUES (p_guest_id, p_room_id, p_check_in, p_check_out, p_num_guests, 'confirmed', total);

    UPDATE rooms SET status = 'occupied' WHERE room_id = p_room_id;

    SELECT LAST_INSERT_ID() AS new_booking_id, total AS total_amount;
END$$

-- 3. Record a payment
CREATE PROCEDURE sp_insert_payment(
    IN p_booking_id    INT,
    IN p_amount        DECIMAL(10,2),
    IN p_payment_mode  VARCHAR(20)
)
BEGIN
    INSERT INTO payments (booking_id, amount_paid, payment_mode, payment_date, payment_status)
    VALUES (p_booking_id, p_amount, p_payment_mode, CURRENT_DATE, 'completed');
    SELECT LAST_INSERT_ID() AS new_payment_id;
END$$

-- 4. Update booking status
CREATE PROCEDURE sp_update_booking_status(
    IN p_booking_id INT,
    IN p_status     VARCHAR(20)
)
BEGIN
    UPDATE bookings SET status = p_status WHERE booking_id = p_booking_id;
    IF p_status = 'checked_out' OR p_status = 'cancelled' THEN
        UPDATE rooms r
        JOIN bookings b ON r.room_id = b.room_id
        SET r.status = 'available'
        WHERE b.booking_id = p_booking_id;
    END IF;
    SELECT ROW_COUNT() AS rows_affected;
END$$

-- 5. Update room status
CREATE PROCEDURE sp_update_room_status(
    IN p_room_id INT,
    IN p_status  VARCHAR(20)
)
BEGIN
    UPDATE rooms SET status = p_status WHERE room_id = p_room_id;
    SELECT ROW_COUNT() AS rows_affected;
END$$

-- 6. Delete a booking (with FK safety — deletes payments first)
CREATE PROCEDURE sp_delete_booking(
    IN p_booking_id INT
)
BEGIN
    DECLARE v_room_id INT;

    SELECT room_id INTO v_room_id FROM bookings WHERE booking_id = p_booking_id;

    DELETE FROM payments WHERE booking_id = p_booking_id;
    DELETE FROM bookings  WHERE booking_id = p_booking_id;

    UPDATE rooms SET status = 'available' WHERE room_id = v_room_id;

    SELECT ROW_COUNT() AS rows_affected;
END$$

-- 7. Select: full booking details with joins
CREATE PROCEDURE sp_get_booking_details(
    IN p_booking_id INT
)
BEGIN
    SELECT
        b.booking_id,
        g.name          AS guest_name,
        g.phone,
        r.room_number,
        rt.type_name    AS room_type,
        b.check_in,
        b.check_out,
        DATEDIFF(b.check_out, b.check_in) AS nights,
        b.num_guests,
        b.status        AS booking_status,
        b.total_amount,
        COALESCE(SUM(p.amount_paid), 0) AS total_paid,
        b.total_amount - COALESCE(SUM(p.amount_paid), 0) AS balance_due
    FROM bookings b
    JOIN guests     g  ON b.guest_id = g.guest_id
    JOIN rooms      r  ON b.room_id  = r.room_id
    JOIN room_types rt ON r.type_id  = rt.type_id
    LEFT JOIN payments p ON b.booking_id = p.booking_id AND p.payment_status = 'completed'
    WHERE b.booking_id = p_booking_id
    GROUP BY b.booking_id, g.name, g.phone, r.room_number, rt.type_name,
             b.check_in, b.check_out, b.num_guests, b.status, b.total_amount;
END$$

-- 8. Select: available rooms by type
CREATE PROCEDURE sp_get_available_rooms(
    IN p_type_name VARCHAR(50)
)
BEGIN
    SELECT r.room_id, r.room_number, r.floor, rt.type_name, rt.price_per_night, rt.amenities
    FROM rooms r
    JOIN room_types rt ON r.type_id = rt.type_id
    WHERE r.status = 'available'
      AND (p_type_name IS NULL OR rt.type_name = p_type_name)
    ORDER BY r.room_number;
END$$

DELIMITER ;

-- ============================================================
-- VIEWS
-- ============================================================

-- View 1: Current bookings with guest and room details
CREATE VIEW vw_current_bookings AS
SELECT
    b.booking_id,
    g.name          AS guest_name,
    g.phone,
    g.city,
    r.room_number,
    rt.type_name    AS room_type,
    b.check_in,
    b.check_out,
    DATEDIFF(b.check_out, b.check_in) AS nights,
    b.status,
    b.total_amount
FROM bookings b
JOIN guests     g  ON b.guest_id = g.guest_id
JOIN rooms      r  ON b.room_id  = r.room_id
JOIN room_types rt ON r.type_id  = rt.type_id
WHERE b.status IN ('confirmed','checked_in');

-- View 2: Revenue summary per room type
CREATE VIEW vw_revenue_by_room_type AS
SELECT
    rt.type_name,
    COUNT(b.booking_id)              AS total_bookings,
    SUM(b.total_amount)              AS gross_revenue,
    AVG(b.total_amount)              AS avg_booking_value,
    SUM(DATEDIFF(b.check_out, b.check_in)) AS total_nights_sold
FROM bookings b
JOIN rooms      r  ON b.room_id  = r.room_id
JOIN room_types rt ON r.type_id  = rt.type_id
WHERE b.status != 'cancelled'
GROUP BY rt.type_name
ORDER BY gross_revenue DESC;

-- View 3: Monthly revenue report
CREATE VIEW vw_monthly_revenue AS
SELECT
    YEAR(p.payment_date)  AS yr,
    MONTH(p.payment_date) AS mo,
    MONTHNAME(p.payment_date) AS month_name,
    COUNT(DISTINCT p.booking_id) AS bookings_paid,
    SUM(p.amount_paid)           AS total_collected
FROM payments p
WHERE p.payment_status = 'completed'
GROUP BY YEAR(p.payment_date), MONTH(p.payment_date), MONTHNAME(p.payment_date)
ORDER BY yr, mo;

-- View 4: Guest booking history
CREATE VIEW vw_guest_booking_history AS
SELECT
    g.guest_id,
    g.name          AS guest_name,
    g.email,
    g.city,
    COUNT(b.booking_id)   AS total_bookings,
    SUM(b.total_amount)   AS total_spent,
    MAX(b.check_in)       AS last_check_in,
    SUM(CASE WHEN b.status = 'cancelled' THEN 1 ELSE 0 END) AS cancellations
FROM guests g
LEFT JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.name, g.email, g.city;

-- View 5: Room occupancy status (all rooms)
CREATE VIEW vw_room_status AS
SELECT
    r.room_id,
    r.room_number,
    r.floor,
    rt.type_name,
    rt.price_per_night,
    r.status,
    b.booking_id,
    g.name      AS current_guest,
    b.check_in,
    b.check_out
FROM rooms r
JOIN room_types rt ON r.type_id = rt.type_id
LEFT JOIN bookings b ON r.room_id = b.room_id AND b.status = 'checked_in'
LEFT JOIN guests   g ON b.guest_id = g.guest_id
ORDER BY r.room_number;

-- View 6: Payment collection summary
CREATE VIEW vw_payment_summary AS
SELECT
    p.payment_mode,
    COUNT(*)          AS transaction_count,
    SUM(p.amount_paid) AS total_collected,
    AVG(p.amount_paid) AS avg_transaction
FROM payments p
WHERE p.payment_status = 'completed'
GROUP BY p.payment_mode
ORDER BY total_collected DESC;

-- View 7: Top 10 guests by spending
CREATE VIEW vw_top_guests AS
SELECT
    g.guest_id,
    g.name,
    g.city,
    COUNT(b.booking_id)   AS bookings,
    SUM(b.total_amount)   AS total_spent
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
WHERE b.status != 'cancelled'
GROUP BY g.guest_id, g.name, g.city
ORDER BY total_spent DESC
LIMIT 10;

-- View 8: Rooms under maintenance
CREATE VIEW vw_maintenance_rooms AS
SELECT
    r.room_id,
    r.room_number,
    r.floor,
    rt.type_name,
    rt.price_per_night
FROM rooms r
JOIN room_types rt ON r.type_id = rt.type_id
WHERE r.status = 'maintenance';

-- View 9: Cancelled and refunded bookings
CREATE VIEW vw_cancelled_bookings AS
SELECT
    b.booking_id,
    g.name       AS guest_name,
    g.phone,
    r.room_number,
    rt.type_name,
    b.check_in,
    b.check_out,
    b.total_amount,
    COALESCE(SUM(CASE WHEN p.payment_status='refunded' THEN p.amount_paid END), 0) AS refunded_amount
FROM bookings b
JOIN guests     g  ON b.guest_id = g.guest_id
JOIN rooms      r  ON b.room_id  = r.room_id
JOIN room_types rt ON r.type_id  = rt.type_id
LEFT JOIN payments p ON b.booking_id = p.booking_id
WHERE b.status = 'cancelled'
GROUP BY b.booking_id, g.name, g.phone, r.room_number, rt.type_name,
         b.check_in, b.check_out, b.total_amount;

-- View 10: Outstanding balance (bookings with pending/partial payment)
CREATE VIEW vw_outstanding_balances AS
SELECT
    b.booking_id,
    g.name         AS guest_name,
    g.phone,
    b.total_amount,
    COALESCE(SUM(CASE WHEN p.payment_status='completed' THEN p.amount_paid ELSE 0 END), 0) AS amount_paid,
    b.total_amount - COALESCE(SUM(CASE WHEN p.payment_status='completed' THEN p.amount_paid ELSE 0 END), 0) AS balance_due,
    b.status
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
LEFT JOIN payments p ON b.booking_id = p.booking_id
WHERE b.status NOT IN ('cancelled','checked_out')
GROUP BY b.booking_id, g.name, g.phone, b.total_amount, b.status
HAVING balance_due > 0;

-- ============================================================
-- SAMPLE QUERIES (demonstrating required SQL concepts)
-- ============================================================

-- 1. INNER JOIN: All completed bookings with guest and room info
SELECT g.name, r.room_number, rt.type_name,
       b.check_in, b.check_out, b.total_amount
FROM bookings b
INNER JOIN guests     g  ON b.guest_id = g.guest_id
INNER JOIN rooms      r  ON b.room_id  = r.room_id
INNER JOIN room_types rt ON r.type_id  = rt.type_id
WHERE b.status = 'checked_out'
ORDER BY b.check_out DESC;

-- 2. LEFT JOIN: All guests including those with no bookings yet
SELECT g.guest_id, g.name, g.city,
       COUNT(b.booking_id) AS total_bookings
FROM guests g
LEFT JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.name, g.city
ORDER BY total_bookings DESC;

-- 3. GROUP BY + HAVING: Room types with more than 10 bookings
SELECT rt.type_name,
       COUNT(b.booking_id)  AS booking_count,
       SUM(b.total_amount)  AS total_revenue
FROM bookings b
JOIN rooms      r  ON b.room_id  = r.room_id
JOIN room_types rt ON r.type_id  = rt.type_id
WHERE b.status != 'cancelled'
GROUP BY rt.type_name
HAVING booking_count > 10
ORDER BY total_revenue DESC;

-- 4. Subquery: Guests who spent more than the average booking amount
SELECT g.name, g.city, b.total_amount
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
WHERE b.total_amount > (SELECT AVG(total_amount) FROM bookings WHERE status != 'cancelled')
ORDER BY b.total_amount DESC;

-- 5. Aggregate: Revenue, average stay, total nights by month in 2024
SELECT
    MONTHNAME(check_in) AS month,
    COUNT(*)             AS bookings,
    ROUND(AVG(DATEDIFF(check_out, check_in)), 1) AS avg_stay_nights,
    SUM(total_amount)    AS monthly_revenue
FROM bookings b
WHERE YEAR(check_in) = 2024 AND status != 'cancelled'
GROUP BY MONTH(check_in), MONTHNAME(check_in)
ORDER BY MONTH(check_in);

-- 6. Indexing (bonus marks)
CREATE INDEX idx_bookings_guest   ON bookings(guest_id);
CREATE INDEX idx_bookings_room    ON bookings(room_id);
CREATE INDEX idx_bookings_checkin ON bookings(check_in);
CREATE INDEX idx_payments_booking ON payments(booking_id);

-- ============================================================
-- END OF FILE
-- ============================================================

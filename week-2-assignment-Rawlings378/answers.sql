
 USE hospital_db;
 -- part 3 creating tables--
 -- creating patients table--
 CREATE TABLE patients(
patient_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255),
date_of_birth DATE NOT NULL,
gender VARCHAR(255) NOT NULL,
language VARCHAR(255) NOT NULL
) ;
-- creating providers table--
 CREATE TABLE providers(
 provider_id INT PRIMARY KEY AUTO_INCREMENT,
 first_name VARCHAR(255) NOT NULL,
 last_name VARCHAR(255) NOT NULL,
 provider_speciality VARCHAR(255) NOT NULL,
 email_address VARCHAR(15),
 phone_number VARCHAR(15),
 date_joined DATE NOT NULL
 );
 -- creating visits table--
CREATE TABLE visits(
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    provider_id INT,
    date_of_visit DATE NOT NULL,
    date_scheduled DATE NOT NULL,
    visit_department_id INT NOT NULL,
    visit_type VARCHAR(255) NOT NULL, 
    blood_pressure_systolic INT,
    blood_pressure_diastolic DECIMAL (5,2),
    pulse DECIMAL(5,2), 
    visit_status VARCHAR(255) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES providers(provider_id)
);
-- creating admissions table--


CREATE TABLE admissions(
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    discharge_disposition VARCHAR(255) NOT NULL,
    service VARCHAR(255),
    primary_diagnosis VARCHAR(255) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
-- creating ed_visits table--
CREATE TABLE ed_visits(
    ed_visit_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT,
    patient_id INT,
    acuity INT NOT NULL,
    reason_for_visit VARCHAR(255) NOT NULL, 
    disposition VARCHAR(255) NOT NULL,
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
-- creating discharges table--
CREATE TABLE discharges(
    discharge_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT,
    patient_id INT,
    discharge_date DATE NOT NULL,
    discharge_disposition VARCHAR(255) NOT NULL, 
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
-- part 1 basic data retrieval--
SELECT*FROM patients first_name, last_name, date_of_birth;
SELECT*FROM providers provider_id, last_name, provider_specialty;
-- part 2 Pattern-Based Filtering--
SELECT*FROM patients WHERE first_name LIKE   '%ab';
SELECT*FROM providers  WHERE provider_specialty LIKE '%y';
-- part 3 comparison operators --
SELECT*FROM patients first_name, last_name, date_of_birth
WHERE date_of_birth >'1980-01-01';
SELECT*FROM ed_visits ed_visit_id, visit_id, patient_id, acuity,reason_for_visit, 
disposition WHERE acuity > '2';
 -- PART 4 Where clause with logical operators --
SELECT*FROM patients first_name, last_name, language WHERE language ='spanish';
SELECT*FROM ed_visit  ed_visit_id, ed_visit.reason_for_visit, ed_visit.disposition WHERE reason_for_visit ='Migraine' AND dispostion ='Admitted';
SELECT*FROM patients first_name, last_name, date_of_birth WHERE date_of_birth BETWEEN '1975-01-01' AND '1980-12-13';
-- PART 5  Sorting data --
SELECT*FROM patients first_name, last_name ORDER BY last_name ASC;
SELECT*FROM visits visit_id, patient_id, provider_id, date_of_visit ORDER BY date_of_visit DESC;
-- PART 6 Advanced filtering --
SELECT*FROM admissions admission_id, patient_id, admission_date, discharge_date, discharge_disposition, primary_diagnosis 
WHERE primary_diagnosis = 'stroke' AND discharge_disposition = 'HOME'; 
SELECT  provider_id, first_name, last_name, provider_speciality, date_joined
FROM providers 
WHERE date_joined > '1995-12-31' AND provider_speciality IN ('pediatrics', 'cardiology');
-- PART 7 BONUS QUIZZ --
SELECT*FROM discharges WHERE discharge_disposition = 'HOME' AND discharge_date  BETWEEN '2018-03-01' '2018-03-07'



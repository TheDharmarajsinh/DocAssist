-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 13, 2025 at 03:06 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `doc_assist`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `aemail` varchar(255) NOT NULL,
  `apassword` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`aemail`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`aemail`, `apassword`) VALUES
('admin@docassist.com', '123');

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
CREATE TABLE IF NOT EXISTS `appointment` (
  `appoid` int NOT NULL AUTO_INCREMENT,
  `pid` int DEFAULT NULL,
  `apponum` int DEFAULT NULL,
  `scheduleid` int DEFAULT NULL,
  `appodate` date DEFAULT NULL,
  PRIMARY KEY (`appoid`),
  KEY `pid` (`pid`),
  KEY `scheduleid` (`scheduleid`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appoid`, `pid`, `apponum`, `scheduleid`, `appodate`) VALUES
(15, 1, 1, 17, '2024-12-25'),
(16, 1, 1, 16, '2024-12-25'),
(12, 1, 1, 9, '2024-12-22');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
CREATE TABLE IF NOT EXISTS `doctor` (
  `docid` int NOT NULL AUTO_INCREMENT,
  `docemail` varchar(255) DEFAULT NULL,
  `docname` varchar(255) DEFAULT NULL,
  `docpassword` varchar(255) DEFAULT NULL,
  `docnic` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `doctel` varchar(15) DEFAULT NULL,
  `specialties` int DEFAULT NULL,
  PRIMARY KEY (`docid`),
  KEY `specialties` (`specialties`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`docid`, `docemail`, `docname`, `docpassword`, `docnic`, `doctel`, `specialties`) VALUES
(1, 'doctor@docassist.com', 'Dr. Rajesh Thakur', '123', '000000000', '0110000000', 1),
(2, 'rohan.mehta@gmail.com', 'Dr. Rohan Mehta', '123', 'IN-MED-CCI-0012', '+91 98765 43210', 3),
(3, 'priya.nambiar@gmail.com', 'Dr. Priya Nambiar', '123', 'IN-MED-DER-0056', '+91 87654 32109', 12),
(4, 'arvind.kapoor@gmail.com', 'Dr. Arvind Kapoor', '123', 'IN-MED-NSG-0098', '+91 99876 54321', 20),
(5, 'shweta.rao@gmail.com', 'Dr. Shweta Rao', '123', 'IN-MED-PED-0034', '+91 91234 56789', 15),
(6, 'rajesh.khanna@gmail.com', 'Dr. Rajesh Khanna', '123', 'IN-MED-INF-0078', '+91 92345 67890', 22),
(7, 'sneha.iyer@gmail.com', 'Dr. Sneha Iyer', '123', 'IN-MED-GAS-0011', '+91 93456 78901', 8),
(8, 'amit.bhattacharya@gmail.com', 'Dr. Amit Bhattacharya', '123', 'IN-MED-PLS-0023', '+91 94567 89012', 23),
(9, 'kavita.desai@gmail.com', 'Dr. Kavita Desai', '123', 'IN-MED-RAD-0045', '+91 95678 90123', 19),
(10, 'manish.patil@gmail.com', 'Dr. Manish Patil', '123', 'IN-MED-RHE-0067', '+91 96789 01234', 21),
(11, 'anjali.verma@gmail.com', 'Dr. Anjali Verma', '123', 'IN-MED-URO-0089', '+91 97890 12345', 24);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `pemail` varchar(255) DEFAULT NULL,
  `pname` varchar(255) DEFAULT NULL,
  `ppassword` varchar(255) DEFAULT NULL,
  `paddress` varchar(255) DEFAULT NULL,
  `pnic` varchar(15) DEFAULT NULL,
  `pdob` date DEFAULT NULL,
  `ptel` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`pid`, `pemail`, `pname`, `ppassword`, `paddress`, `pnic`, `pdob`, `ptel`) VALUES
(1, 'patient@docassist.com', 'Raj Kumar', '123', 'India', '9764318520', '2003-08-08', '9876543210');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE IF NOT EXISTS `schedule` (
  `scheduleid` int NOT NULL AUTO_INCREMENT,
  `docid` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `scheduledate` date DEFAULT NULL,
  `scheduletime` time DEFAULT NULL,
  `nop` int DEFAULT NULL,
  PRIMARY KEY (`scheduleid`),
  KEY `docid` (`docid`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`scheduleid`, `docid`, `title`, `scheduledate`, `scheduletime`, `nop`) VALUES
(17, '3', 'Pediatric Vaccination', '2024-12-26', '16:00:00', 12),
(18, '4', 'Infection Control', '2024-12-26', '10:00:00', 6),
(15, '1', 'Skin Checkups', '2024-12-26', '11:00:00', 8),
(16, '2', 'Neuro Follow-up', '2024-12-26', '14:00:00', 5),
(19, '5', 'Gastroenterology Appointments', '2024-12-27', '10:30:00', 8),
(20, '6', 'Plastic Surgery Consult', '2024-12-27', '13:00:00', 4),
(21, '7', 'Radiology Reviews', '2024-12-27', '15:00:00', 7),
(22, '8', 'Arthritis Consultations', '2024-12-27', '09:30:00', 9),
(23, '9', 'Urology Checkups', '2024-12-27', '11:30:00', 6),
(24, '10', 'Dermatology Consultations', '2024-12-28', '10:00:00', 10),
(25, '11', 'Laboratory Medicine Consultation', '2024-12-26', '09:00:00', 10),
(26, '10', 'Immunology Consultation', '2024-12-26', '11:00:00', 8),
(27, '9', 'General Surgery Consultation', '2024-12-26', '13:00:00', 5),
(28, '8', 'Internal Medicine Consultation', '2024-12-26', '15:00:00', 12),
(29, '7', 'Clinical Chemistry Consultation', '2024-12-26', '17:00:00', 6),
(30, '6', 'Infectious Diseases Consultation', '2024-12-27', '09:30:00', 8),
(31, '5', 'Gastro-enterologic Surgery Consultation', '2024-12-27', '11:30:00', 7),
(32, '4', 'Geriatrics Consultation', '2024-12-27', '13:00:00', 10),
(33, '3', 'Dermato-venerology Consultation', '2024-12-27', '15:30:00', 6),
(34, '2', 'Anaesthetics Consultation', '2024-12-27', '10:00:00', 9),
(35, '1', 'Accident and Emergency Medicine Consultation', '2024-12-28', '08:00:00', 12);

-- --------------------------------------------------------

--
-- Table structure for table `specialties`
--

DROP TABLE IF EXISTS `specialties`;
CREATE TABLE IF NOT EXISTS `specialties` (
  `id` int NOT NULL,
  `sname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `specialties`
--

INSERT INTO `specialties` (`id`, `sname`) VALUES
(1, 'Accident and emergency medicine'),
(2, 'Allergology'),
(3, 'Anaesthetics'),
(4, 'Biological hematology'),
(5, 'Cardiology'),
(6, 'Child psychiatry'),
(7, 'Clinical biology'),
(8, 'Clinical chemistry'),
(9, 'Clinical neurophysiology'),
(10, 'Clinical radiology'),
(11, 'Dental, oral and maxillo-facial surgery'),
(12, 'Dermato-venerology'),
(13, 'Dermatology'),
(14, 'Endocrinology'),
(15, 'Gastro-enterologic surgery'),
(16, 'Gastroenterology'),
(17, 'General hematology'),
(18, 'General Practice'),
(19, 'General surgery'),
(20, 'Geriatrics'),
(21, 'Immunology'),
(22, 'Infectious diseases'),
(23, 'Internal medicine'),
(24, 'Laboratory medicine'),
(25, 'Maxillo-facial surgery'),
(26, 'Microbiology'),
(27, 'Nephrology'),
(28, 'Neuro-psychiatry'),
(29, 'Neurology'),
(30, 'Neurosurgery'),
(31, 'Nuclear medicine'),
(32, 'Obstetrics and gynecology'),
(33, 'Occupational medicine'),
(34, 'Ophthalmology'),
(35, 'Orthopaedics'),
(36, 'Otorhinolaryngology'),
(37, 'Paediatric surgery'),
(38, 'Paediatrics'),
(39, 'Pathology'),
(40, 'Pharmacology'),
(41, 'Physical medicine and rehabilitation'),
(42, 'Plastic surgery'),
(43, 'Podiatric Medicine'),
(44, 'Podiatric Surgery'),
(45, 'Psychiatry'),
(46, 'Public health and Preventive Medicine'),
(47, 'Radiology'),
(48, 'Radiotherapy'),
(49, 'Respiratory medicine'),
(50, 'Rheumatology'),
(51, 'Stomatology'),
(52, 'Thoracic surgery'),
(53, 'Tropical medicine'),
(54, 'Urology'),
(55, 'Vascular surgery'),
(56, 'Venereology');

-- --------------------------------------------------------

--
-- Table structure for table `webuser`
--

DROP TABLE IF EXISTS `webuser`;
CREATE TABLE IF NOT EXISTS `webuser` (
  `email` varchar(255) NOT NULL,
  `usertype` char(1) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `webuser`
--

INSERT INTO `webuser` (`email`, `usertype`) VALUES
('admin@docassist.com', 'a'),
('doctor@docassist.com', 'd'),
('patient@docassist.com', 'p'),
('kavita-desai@gmail.com', 'd'),
('amit.bhattacharya@gmail.com', 'd'),
('sneha.iyer@gmail.com', 'd'),
('rajesh.khanna@gmail.com', 'd'),
('shweta.rao@gmail.com', 'd'),
('arvind-kapoor@gmail.com', 'd'),
('priya.nambiar@gmail.com', 'd'),
('rohan.mehta@gmail.com', 'd'),
('manish.patil@gmail.com', 'd'),
('aniali.verma@qmail.com', 'd');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

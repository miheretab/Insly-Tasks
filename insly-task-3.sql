CREATE DATABASE IF NOT EXISTS `insly` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `insly`;

--
-- Database: `insly`
--


-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE IF NOT EXISTS `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'Name',
  `birth_date` date NOT NULL COMMENT 'Birth Date',
  `ssn` varchar(255) NOT NULL COMMENT 'ID code / SSN',
  `is_employee` tinyint(1) NOT NULL COMMENT 'Is a current employee?',
  `email` varchar(255) NOT NULL COMMENT 'Email',
  `phone` varchar(255) NOT NULL COMMENT 'Phone',
  `address` varchar(255) NOT NULL COMMENT 'Address',
  `created` datetime NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `educations`
--

CREATE TABLE IF NOT EXISTS `educations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title_en` varchar(255) NOT NULL,
  `title_es` varchar(255) NOT NULL,
  `title_fr` varchar(255) NOT NULL,
  `institution` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created` date NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `modified` date DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_educ_employee_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `experiences`
--

CREATE TABLE IF NOT EXISTS `experiences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title_en` varchar(255) NOT NULL,
  `title_es` varchar(255) NOT NULL,
  `title_fr` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created` date NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `modified` date DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exp_employee_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `introductions`
--

CREATE TABLE IF NOT EXISTS `introductions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title_en` text NOT NULL,
  `title_es` text NOT NULL,
  `title_fr` text CHARACTER SET utf16 NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_intro_employee_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--
--
-- Constraints for table `experiences`
--
ALTER TABLE `educations`
  ADD CONSTRAINT `fk_educ_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `experiences`
--
ALTER TABLE `experiences`
  ADD CONSTRAINT `fk_exp_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `introductions`
--
ALTER TABLE `introductions`
  ADD CONSTRAINT `fk_intro_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- one test data insert
--

INSERT INTO `employees` (`id`, `name`, `birth_date`, `ssn`, `is_employee`, `email`, `phone`, `address`, `created`, `created_by`, `modified`, `modified_by`)
VALUES (NULL, 'Miheretab Alemu', '1988-05-07', '12456789', '1', 'mihrtab@gmail.com', '+251911920438', 'Addis Ababa', '2018-11-08 00:00:00', 'Miheretab', NULL, NULL);

INSERT INTO `introductions` (`id`, `title_en`, `title_es`, `title_fr`, `created`, `created_by`, `modified`, `modified_by`, `employee_id`)
VALUES (NULL, 'Title English', 'Title Español', 'Title français', '2018-11-08 00:00:00', 'Miheretab', NULL, NULL, '1');

INSERT INTO `educations` (`id`, `title_en`, `title_es`, `title_fr`, `institution`, `start_date`, `end_date`, `created`, `created_by`, `modified`, `modified_by`, `employee_id`)
VALUES (NULL, 'Educ English', 'Educ Español', 'Educ français', 'AAU', '2005-09-01', '2009-06-30', '2018-11-08 00:00:00', 'Miheretab', NULL, NULL, '1');

INSERT INTO `experiences` (`id`, `title_en`, `title_es`, `title_fr`, `company`, `start_date`, `end_date`, `created`, `created_by`, `modified`, `modified_by`, `employee_id`)
VALUES (NULL, 'Expe English', 'Expe Español', 'Expe français', 'Apposit', '2011-09-01', '2013-06-30', '2018-11-08 00:00:00', 'Miheretab', NULL, NULL, '1');


--
-- Write example query to get 1-person data in all languages
--

--
-- Introduction and Basic Info
--

SELECT emp.name AS 'Name', emp.birth_date AS 'Birth Date', emp.ssn AS 'ID code /SSN', emp.phone AS 'Phone', emp.address AS 'Address',
    intro.title_en AS 'Introduction in English', intro.title_es AS 'Introduction in Spanish', intro.title_fr AS 'Introduction in French'
    FROM employees AS emp
    LEFT JOIN introductions AS intro ON intro.employee_id = emp.id
WHERE emp.email = 'mihrtab@gmail.com';

--
-- Experience and Basic Info
--

SELECT emp.name AS 'Name', emp.birth_date AS 'Birth Date', emp.ssn AS 'ID code /SSN', emp.phone AS 'Phone', emp.address AS 'Address',
    expe.title_en AS 'Experience in English', expe.title_es AS 'Experience in Spanish', expe.title_fr AS 'Experience in French'
    FROM employees AS emp
    LEFT JOIN experiences AS expe ON expe.employee_id = emp.id
WHERE emp.email = 'mihrtab@gmail.com';

--
-- Education and Basic Info
--
SELECT emp.name AS 'Name', emp.birth_date AS 'Birth Date', emp.ssn AS 'ID code /SSN', emp.phone AS 'Phone', emp.address AS 'Address',
    educ.title_en AS 'Education in English', educ.title_es AS 'Education in Spanish', educ.title_fr AS 'Education in French'
    FROM employees AS emp
    LEFT JOIN educations AS educ ON educ.employee_id = emp.id
WHERE emp.email = 'mihrtab@gmail.com';
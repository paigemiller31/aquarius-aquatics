BEGIN TRANSACTION;

DROP TABLE IF EXISTS users, customer, employee, reviews, address, appointment, schedule, service, service_provided, service_booked CASCADE;

CREATE TABLE users (
	user_id SERIAL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS customer (
	customer_id int,
	first_name varchar(64),
	last_name varchar(64),
	phone_number varchar(64),
	email_address varchar(128),
	CONSTRAINT PK_customer PRIMARY KEY (customer_id),
	CONSTRAINT FK_customer_users FOREIGN KEY (customer_id) REFERENCES users (user_id)
);

CREATE TABLE IF NOT EXISTS employee (
	employee_id int,
	first_name varchar(64),
	last_name varchar(64),
	phone_number varchar(64),
	email_address varchar(128),
	CONSTRAINT PK_employee PRIMARY KEY (employee_id),
	CONSTRAINT FK_employee_users FOREIGN KEY (employee_id) REFERENCES users (user_id)
);

CREATE TABLE IF NOT EXISTS reviews (
	review_id SERIAL,
	customer_id int,
	stars int,
	review text,
	response text,
	CONSTRAINT PK_review PRIMARY KEY (review_id),
	CONSTRAINT FK_review_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

CREATE TABLE IF NOT EXISTS address (
	address_id SERIAL,
	customer_id int,
	address_line_1 varchar (128),
	address_line_2 varchar (128),
	city varchar (64),
	state varchar (64),
	zip_code varchar (64),
	CONSTRAINT PK_address PRIMARY KEY (address_id),
	CONSTRAINT FK_address_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

CREATE TABLE IF NOT EXISTS appointment (
	appointment_id SERIAL,
	customer_id int,
	employee_id int,
	date_created timestamp,
	start_time timestamp,
	end_time_expected timestamp,
	end_time_actual timestamp,
	price_expected decimal(10,2),
	price_full decimal(10,2),
	discount decimal(10,2),
	price_final decimal(10,2),
	canceled boolean,
	cancellation_reason text,
	CONSTRAINT PK_appointment PRIMARY KEY (appointment_id),
	CONSTRAINT FK_appointment_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
	CONSTRAINT FK_appointment_employee FOREIGN KEY (employee_id) REFERENCES employee (employee_id)
);

CREATE TABLE IF NOT EXISTS schedule (
	schedule_id SERIAL,
	employee_id int,
	day_of_week varchar (10),
	start_time timestamp,
	end_time timestamp,
	is_available boolean,
	reason_of_unavailability text,
	CONSTRAINT PK_schedule PRIMARY KEY (schedule_id),
	CONSTRAINT FK_schedule_employee FOREIGN KEY (employee_id) REFERENCES employee (employee_id)
);

CREATE TABLE IF NOT EXISTS service (
	service_id SERIAL,
	name varchar (128),
	description text,
	duration int,
	price decimal (10,2),
	CONSTRAINT PK_service PRIMARY KEY (service_id)
);

CREATE TABLE IF NOT EXISTS service_provided (
	service_provided_id SERIAL,
	appointment_id int,
	service_id int,
	price decimal (10,2),
	CONSTRAINT PK_service_provided PRIMARY KEY (service_provided_id),
	CONSTRAINT FK_service_provided_appointment FOREIGN KEY (appointment_id) REFERENCES appointment (appointment_id),
	CONSTRAINT FK_service_provided_service FOREIGN KEY (service_id) REFERENCES service (service_id)
);

CREATE TABLE IF NOT EXISTS service_booked (
	service_booked_id SERIAL,
	appointment_id int,
	service_id int,
	price decimal (10,2),
	CONSTRAINT PK_service_booked PRIMARY KEY (service_booked_id),
	CONSTRAINT FK_service_booked_appointment FOREIGN KEY (appointment_id) REFERENCES appointment (appointment_id),
	CONSTRAINT FK_service_booked_service FOREIGN KEY (service_id) REFERENCES service (service_id)
);

COMMIT TRANSACTION;

CREATE	database IF NOT EXISTS librarydb;
USE librarydb;


CREATE TABLE IF NOT EXISTS addresses (
    id INTEGER auto_increment,
    number_building INTEGER,
    number_street INTEGER,
    city VARCHAR(20),
    postcode INTEGER,
    country VARCHAR(20),
    CONSTRAINT addresses_pk PRIMARY KEY (id)
);


INSERT addresses (number_building, number_street, city, postcode, country)
VALUES 
(15, 10, 'Prague', 16500, 'Czech Republic'),
(14, 11, 'Prague', 16500, 'Czech Republic'),
(13, 12, 'Prague', 16500, 'Czech Republic'),
(12, 12, 'Prague', 16500, 'Czech Republic'),
(10, 11, 'Prague', 16500, 'Czech Republic'),
(9, 12, 'Prague', 16500, 'Czech Republic'),
(8, 13, 'Prague', 16500, 'Czech Republic');

CREATE TABLE IF NOT EXISTS library (
    id INTEGER AUTO_INCREMENT,
    address_id INTEGER,
    library_name VARCHAR(20),
    library_detail VARCHAR(20),
    CONSTRAINT library_pk PRIMARY KEY (id)
);


INSERT library(address_id, library_name, library_detail)
VALUES 
(2, 'Natinal library', 'Big lib'),
(5, 'University library', 'Middle lib');


CREATE TABLE IF NOT EXISTS books_at_libraries (
    library_id INTEGER,
    book_id INTEGER,
    quantity_in_stock INTEGER
);

INSERT books_at_libraries (library_id, book_id, quantity_in_stock)
VALUES
(2, 1, 50),
(2, 2, 23),
(2, 3, 18),
(2, 4, 4),
(2, 5, 1),
(1, 6, 78),
(1, 7, 5),
(1, 8, 6),
(1, 9, 1),
(1, 10, 4);

CREATE TABLE IF NOT EXISTS book (
    id INTEGER AUTO_INCREMENT,
    book_title VARCHAR(100),
    date_of_publication DATE,
    CONSTRAINT book_pk PRIMARY KEY (id)
);

INSERT book (book_title, date_of_publication)
VALUES
("A Tale of Two Cities", "1859-08-14"),
("The Hobbit", "1937-12-4"),
("Harry Potter and the Philosopher's Stone", "1997-12-7"),
("The Little Prince", "1943-08-25"),
('Dream of the Red Chamber', "1750-06-14"),
('And Then There Were None', "1939-07-15"),
('The Lion, the Witch and the Wardrobe', "1950-02-02"),
('She: A History of Adventure', "1887-03-03"),
('The Adventures of Pinocchio', "1881-03-03"),
('The Da Vinci Code', "2003-03-03");


CREATE TABLE IF NOT EXISTS categories (
    id INTEGER AUTO_INCREMENT,
    category_name VARCHAR(40) UNIQUE,
    CONSTRAINT categories_pk PRIMARY KEY (id)
);

INSERT categories(category_name)
VALUES
('Historical Literature'),
('Fantasy'),
('Novella'),
('Family saga'),
('Mystery'),
("Children's fiction"),
('Adventure'),
('Thriller');

CREATE TABLE IF NOT EXISTS books_by_category (
    id INTEGER auto_increment,
    category_id INTEGER,
    book_id INTEGER,
    CONSTRAINT books_by_category_pk PRIMARY KEY (id)
);


INSERT books_by_category(category_id, book_id)
VALUES
(1,1),
(2,2),
(2,3),
(3,4),
(4,5),
(5,6),
(2,7),
(6,7),
(7,8),
(2,9),
(6,9),
(8,10),
(5,10);

CREATE TABLE IF NOT EXISTS authors (
    id INTEGER AUTO_INCREMENT,
    authore_surname VARCHAR(20),
    CONSTRAINT authors_pk PRIMARY KEY (id)
);

INSERT authors(authore_surname)
VALUES
('Dickens'),
('Tolkien'),
('Rowling'),
('Exupéry'),
('Xueqin'),
('Christie'),
('Lewis'),
('Haggard'),
('Collodi'),
('Brown');


CREATE TABLE IF NOT EXISTS books_by_authore (
	id INTEGER auto_increment,
    authore_id INTEGER,
    book_id INTEGER,
    CONSTRAINT books_by_authore_pk PRIMARY KEY (id)
);


INSERT books_by_authore (authore_id, book_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

CREATE TABLE IF NOT EXISTS member_request (
    id INTEGER AUTO_INCREMENT,
    member_id INTEGER,
    book_id INTEGER,
    date_requested DATE,
    date_expire DATE,
    other_request_data VARCHAR(20),
    CONSTRAINT member_request_pk PRIMARY KEY (id)
);

INSERT member_request(member_id, book_id, date_requested, date_expire)
VALUES
(1, 1, "2022-01-16", "2022-02-16"),
(1, 2, "2022-01-11", "2022-02-11"),
(1, 3, "2022-01-11", "2022-02-11"),
(3, 5, "2022-01-14", "2022-02-14"),
(2, 1, "2022-01-9", "2022-02-9"),
(2, 4, "2022-01-6", "2022-02-6"),
(2, 8, "2022-01-8", "2022-02-8");

CREATE TABLE IF NOT EXISTS members (
    id INTEGER AUTO_INCREMENT,
    address_id INTEGER,
    member_first_name VARCHAR(20),
    member_last_name VARCHAR(20),
    contry_code VARCHAR(4),
    number_wo_code INTEGER,
    email_address VARCHAR(40) UNIQUE,
    other_member_data VARCHAR(20),
    CONSTRAINT members_pk PRIMARY KEY (id)
);

INSERT members(address_id, member_first_name, member_last_name, contry_code, email_address)
VALUES
(1, 'Rahim', 'Ivanov', 'RU', 'RI@mail.ru'),
(3, 'Vika', 'Abramova', 'RU', 'VA@mail.ru'),
(4, 'Anya', 'Ivanova', 'RU', 'AI@mail.ru'),
(6, 'Andrey', 'Smirnov', 'RU', 'AS@mail.ru'),
(7, 'Gleb', 'Kyznecov', 'RU', 'GK@mail.ru');

ALTER table library
ADD CONSTRAINT library_to_addresses_fk foreign key(address_id) REFERENCES addresses(id);

ALTER table books_at_libraries
ADD CONSTRAINT books_at_libraries_to_library_fk foreign key(library_id) REFERENCES library(id),
ADD CONSTRAINT book_at_lobraries_to_book_fk foreign key (book_id) REFERENCES book(id);

ALTER table books_by_category
ADD CONSTRAINT books_by_category_to_categories_fk foreign key (category_id) REFERENCES categories(id),
ADD CONSTRAINT books_by_category_to_book_fk foreign key (book_id) REFERENCES book(id);

ALTER table categories
ADD CONSTRAINT categories_to_books_by_category_fk foreign key (id) REFERENCES books_by_category(category_id);


ALTER table books_by_authore
ADD CONSTRAINT books_by_authore_to_authors_fk foreign key (authore_id) REFERENCES authors(id),
ADD CONSTRAINT books_by_authore_to_book_fk foreign key (book_id) REFERENCES book(id);

ALTER table authors
ADD CONSTRAINT authors_to_books_by_authore_fk foreign key (id) REFERENCES books_by_authore(authore_id);

ALTER table member_request
ADD CONSTRAINT member_request_to_members_fk foreign key (member_id) REFERENCES members(id),
ADD CONSTRAINT member_request_to_book_fk foreign key (book_id) REFERENCES book(id);

ALTER table members
ADD CONSTRAINT members_to_addresses_fk foreign key (address_id) REFERENCES addresses(id);

ALTER table book
ADD CONSTRAINT book_to_books_at_libraries_fk foreign key (id) REFERENCES books_at_libraries(book_id),
ADD CONSTRAINT book_to_books_by_authore_fk foreign key (id) REFERENCES books_by_authore(book_id),
ADD CONSTRAINT book_to_books_by_category_fk foreign key (id) REFERENCES books_by_category(book_id);



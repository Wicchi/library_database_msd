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


CREATE TABLE IF NOT EXISTS library (
    id INTEGER AUTO_INCREMENT,
    address_id INTEGER,
    library_name VARCHAR(20),
    library_detail VARCHAR(20),
    CONSTRAINT library_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS books_at_libraries (
    library_id INTEGER,
    book_id INTEGER,
    quantity_in_stock INTEGER
);

CREATE TABLE IF NOT EXISTS book (
    id INTEGER AUTO_INCREMENT,
    book_title VARCHAR(20),
    date_of_publication DATE,
    CONSTRAINT book_pk PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS categories (
    id INTEGER AUTO_INCREMENT,
    category_name VARCHAR(20),
    CONSTRAINT categories_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS books_by_category (
    category_id INTEGER,
    book_id INTEGER,
    CONSTRAINT books_by_category_pk PRIMARY KEY (category_id)
);


CREATE TABLE IF NOT EXISTS authors (
    id INTEGER AUTO_INCREMENT,
    authore_first_name VARCHAR(20),
    authore_last_name VARCHAR(20),
    CONSTRAINT authors_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS books_by_authore (
    authore_id INTEGER,
    book_id INTEGER,
    CONSTRAINT books_by_authore_pk PRIMARY KEY (authore_id)
);


CREATE TABLE IF NOT EXISTS member_request (
    id INTEGER AUTO_INCREMENT,
    member_id INTEGER,
    book_id INTEGER,
    date_requested DATE,
    date_expire DATE,
    other_request_data VARCHAR(20),
    CONSTRAINT member_request_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS members (
    id INTEGER AUTO_INCREMENT,
    address_id INTEGER,
    request_id INTEGER,
    member_first_name VARCHAR(20),
    member_last_name VARCHAR(20),
    contry_code INTEGER,
    number_wo_code INTEGER,
    email_address VARCHAR(20) UNIQUE,
    other_member_data VARCHAR(20),
    CONSTRAINT members_pk PRIMARY KEY (id)
);

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
ADD CONSTRAINT members_to_addresses_fk foreign key (address_id) REFERENCES addresses(id),
ADD CONSTRAINT members_to_member_request_fk foreign key (request_id) REFERENCES member_request(id);

ALTER table book
ADD CONSTRAINT book_to_books_at_libraries_fk foreign key (id) REFERENCES books_at_libraries(book_id),
ADD CONSTRAINT book_to_books_by_authore_fk foreign key (id) REFERENCES books_by_authore(book_id),
ADD CONSTRAINT book_to_books_by_category_fk foreign key (id) REFERENCES books_by_category(book_id);




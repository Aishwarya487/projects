CREATE DATABASE DigitalLibrary;
USE DigitalLibrary;
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255),
    ISBN VARCHAR(13),
    Publisher VARCHAR(255),
    PublicationYear INT
)
INSERT INTO Books (Title, ISBN, Publisher, PublicationYear) 
VALUES 
('Database Systems', '1234567890123', 'Tech Publisher', 2020),
('Artificial Intelligence', '2345678901234', 'AI Publisher', 2019),
('Physics for Beginners', '3456789012345', 'Science Publisher', 2018),
('Evolution of Species', '4567890123456', 'Bio Publisher', 1859),
('Calculus Made Easy', '5678901234567', 'Math Publisher', 1908),
('Theory of Relativity', '6789012345678', 'Physics Publisher', 1916),
('Quantum Mechanics', '7890123456789', 'Physics Publisher', 1930),
('The Origin of Life', '8901234567890', 'Bio Publisher', 1869),
('Principia Mathematica', '9012345678901', 'Physics Publisher', 1687),
('The Universe in a Nutshell', '0123456789012', 'Cosmos Publisher', 2001)
select * from Books
CREATE TABLE Journals (
    JournalID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255),
    ISSN VARCHAR(8),
    Publisher VARCHAR(255),
    Volume INT,
    Issue INT,
    PublicationYear INT
)
INSERT INTO Journals (Title, ISSN, Publisher, Volume, Issue, PublicationYear) 
VALUES 
('Journal of Computer Science', '12345678', 'SciPublisher', 5, 2, 2021),
('Nature Physics', '23456789', 'Nature Publishing', 10, 4, 2022),
('Astrobiology', '34567890', 'Space Publisher', 15, 6, 2020),
('Journal of Chemistry', '45678901', 'Chem Publisher', 8, 1, 2019),
('Mathematics Today', '56789012', 'Math Publisher', 12, 5, 2021),
('Journal of Robotics', '67890123', 'Tech Publisher', 6, 3, 2020),
('Modern Biology', '78901234', 'Bio Publisher', 9, 2, 2022),
('Computational Theory', '89012345', 'Tech Publisher', 11, 7, 2023),
('Space Exploration', '90123456', 'Space Publisher', 14, 8, 2021),
('Quantum Computing', '01234567', 'Quantum Publisher', 13, 9, 2023)
select * from Journals
CREATE TABLE PrimarySources (
    SourceID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255),
    Type VARCHAR(50),  -- e.g., Manuscript, Letter, etc.
    Date DATE,
    Description TEXT
)
INSERT INTO PrimarySources (Title, Type, Date, Description) 
VALUES 
('Ancient Manuscript', 'Manuscript', '1500-01-01', 'A manuscript from the 16th century.'),
('Letter from Albert Einstein', 'Letter', '1921-04-18', 'A letter discussing the theory of relativity.'),
('Newton\'s Principia', 'Book', '1687-07-05', 'The original manuscript of Principia Mathematica.'),
('Marie Curie\'s Lab Notes', 'Notebook', '1898-06-01', 'Notes on the discovery of radium.'),
('Darwin\'s Beagle Diary', 'Diary', '1839-01-01', 'Charles Darwin\'s observations from the HMS Beagle voyage.'),
('Turing\'s Enigma Notes', 'Notebook', '1940-05-10', 'Notes on breaking the Enigma code.'),
('Lovelace\'s Algorithm', 'Manuscript', '1843-01-01', 'Ada Lovelace\'s notes on the analytical engine.'),
('Tesla\'s Patents', 'Patent', '1891-09-10', 'Patents for AC electrical systems.'),
('Sagan\'s Voyager Message', 'Recording', '1977-08-20', 'Message included in the Voyager spacecraft.'),
('Hawking\'s Black Hole Thesis', 'Thesis', '1966-02-01', 'Stephen Hawking\'s thesis on black holes.')
select * from PrimarySources
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255)
)
INSERT INTO Authors (FirstName, LastName)
VALUES ('John', 'Doe'),
('Jane', 'Smith'),
('Albert', 'Einstein'),
('Marie', 'Curie'),
('Isaac', 'Newton'),
('Charles', 'Darwin'),
('Ada', 'Lovelace'),
('Alan', 'Turing'),
('Carl', 'Sagan'),
('Stephen', 'Hawking'),
('Nikola', 'Tesla')
select * from Authors
CREATE TABLE Author_Book (
    AuthorID INT,
    BookID INT,
    PRIMARY KEY (AuthorID, BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
)
INSERT INTO Author_Book (AuthorID, BookID) 
VALUES 
(1, 1),  
(2, 2), 
(3, 6),  
(4, 3),  
(5, 9),  
(6, 4),  
(7, 5),  
(8, 7),  
(9, 10),
(10, 8)
select * from Author_Book
CREATE TABLE Author_Journal (
    AuthorID INT,
    JournalID INT,
    PRIMARY KEY (AuthorID, JournalID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (JournalID) REFERENCES Journals(JournalID)
)
INSERT INTO Author_Journal (AuthorID, JournalID) 
VALUES 
(2, 1),  
(3, 2),  
(9, 3), 
(4, 4),  
(7, 5),  
(8, 6), 
(5, 7),  
(10, 8), 
(11, 9), 
(8, 10)
select *from Author_Journal
CREATE TABLE Author_PrimarySource (
    AuthorID INT,
    SourceID INT,
    PRIMARY KEY (AuthorID, SourceID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (SourceID) REFERENCES PrimarySources(SourceID)
)
INSERT INTO Author_PrimarySource (AuthorID, SourceID) 
VALUES 
(1, 1),  
(3, 2),  
(5, 3),  
(4, 4), 
(6, 5),  
(8, 6), 
(7, 7),  
(11, 8), 
(9, 9),  
(10, 10)
select * from Author_PrimarySource
SELECT Author_Book.BookID, Authors.FirstName, Authors.LastName FROM Authors inner JOIN Author_Book ON Author_Book.AuthorID = Authors.AuthorID;
select a.firstname,a.lastname,b.AuthorID,b.bookID from Authors as a Left join Author_Book as b on a.AuthorID=b.AuthorID
select a.firstname,a.lastname,b.bookID from Authors as a Right join Author_Book as b on a.AuthorID=b.AuthorID
select a.title,a.type,b.AuthorID,b.SourceID from PrimarySources as a cross join Author_PrimarySource as b
select a.title,a.PublicationYear,b.isbn from journals as a,books as b where a.PublicationYear=b.PublicationYear
select title,publisher from journals order by Issue desc limit 2
select count(title),title from books group by title 
select AuthorID,JournalID from Author_Journal where AuthorID=(select AuthorID from Authors where lastname = "Newton") 
select * from (select volume,publicationyear,title from Journals where volume > 5) as Journ_paper where title like 'j%';
select issn,issue from journals union all select isbn, title from books
//CASE//
SELECT Title,Publisher, PublicationYear,
CASE
WHEN PublicationYear >2001 THEN "PublicationYear is greater than 2001"
WHEN PublicationYear=1869 THEN "PublicationYear is 1869"
ELSE "PublicationYear is under 1869"
END AS Bookdet
FROM Books; 

//VIEW//
create view Journalsdet as select Title, Publisher,  Issue from Journals where PublicationYear>2021; 
select * from Journalsdet;
//STORE PROCEDURES//
DELIMITER //
CREATE PROCEDURE Booksdetails()
BEGIN
SELECT * FROM Books;
END //
DELIMITER ;
CALL Booksdetails(); 

DELIMITER //
CREATE PROCEDURE Authorsdetails()
BEGIN
DECLARE Total INT DEFAULT 0;
SELECT COUNT(AuthorID)
INTO Total
FROM Authors;
SELECT Total;
END //
DELIMITER ;  
CALL Authorsdetails();


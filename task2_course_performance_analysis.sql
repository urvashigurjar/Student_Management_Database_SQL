-- =====================================================
-- SQL DATA ANALYSIS INTERNSHIP - PROJECT TASK 2
-- COURSE PERFORMANCE ANALYSIS
-- =====================================================

-- Select the existing Student Management Database
USE StudentManagement;


-- =====================================================
-- 1. CREATE COURSES TABLE
-- =====================================================

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);


-- =====================================================
-- 2. CREATE ENROLLMENTS TABLE
-- =====================================================

CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    Grade INT,

    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID),

    FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
);


-- =====================================================
-- 3. INSERT COURSE DATA
-- =====================================================

INSERT INTO Courses VALUES
(1, 'Mathematics'),
(2, 'Science'),
(3, 'English');


-- =====================================================
-- 4. INSERT ENROLLMENT DATA
-- =====================================================

INSERT INTO Enrollments VALUES
(101, 1, 85),
(101, 2, 78),
(102, 1, 92),
(102, 3, 88),
(103, 2, 35),
(103, 3, 42),
(104, 1, 76),
(104, 2, 81),
(105, 2, 30),
(105, 3, 67);


-- =====================================================
-- 5. DISPLAY ALL COURSES
-- =====================================================

SELECT *
FROM Courses;


-- =====================================================
-- 6. DISPLAY ALL ENROLLMENTS
-- =====================================================

SELECT *
FROM Enrollments;


-- =====================================================
-- QUERY 1: LIST ALL STUDENTS ENROLLED IN EACH COURSE
-- =====================================================

SELECT
    s.Name AS StudentName,
    c.CourseName
FROM Enrollments e
JOIN Students s
    ON e.StudentID = s.StudentID
JOIN Courses c
    ON e.CourseID = c.CourseID
ORDER BY c.CourseName, s.Name;


-- =====================================================
-- QUERY 2: FIND AVERAGE GRADE PER COURSE
-- =====================================================

SELECT
    c.CourseName,
    AVG(e.Grade) AS AverageGrade
FROM Enrollments e
JOIN Courses c
    ON e.CourseID = c.CourseID
GROUP BY c.CourseID, c.CourseName;


-- =====================================================
-- QUERY 3: FIND TOP 3 STUDENTS OVERALL
-- =====================================================

SELECT
    s.StudentID,
    s.Name,
    AVG(e.Grade) AS AverageGrade
FROM Enrollments e
JOIN Students s
    ON e.StudentID = s.StudentID
GROUP BY s.StudentID, s.Name
ORDER BY AverageGrade DESC
LIMIT 3;


-- =====================================================
-- QUERY 4: COUNT STUDENTS WHO FAILED
-- GRADE BELOW 40 IS CONSIDERED FAIL
-- =====================================================

SELECT
    COUNT(DISTINCT StudentID) AS FailedStudentCount
FROM Enrollments
WHERE Grade < 40;
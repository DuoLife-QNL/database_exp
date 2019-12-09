USE 学生选课
GO

-- 为学生表增加主键
-- ALTER TABLE student$
--     ALTER COLUMN 学生ID号 NVARCHAR(255) NOT NULL
-- ALTER TABLE student$ ADD PRIMARY KEY (学生ID号)


-- 尝试添加违反实体完整性约束的记录
-- INSERT INTO student$
--     VALUES('g0940303', 'Ethan', 'id', 'male', '1999', '2017', 'nowhere')

-- 设置班级表的主键
-- ALTER TABLE class$
--     ALTER COLUMN 班级号 NVARCHAR(255) NOT NULL
-- GO
-- ALTER TABLE class$ ADD PRIMARY KEY (班级号)

-- 为学生表添加外键
-- ALTER TABLE student$
--     ADD FOREIGN KEY (班级ID号) REFERENCES class$

-- -- 尝试插入违反参照完整性约束的记录
-- -- INSERT INTO student$
-- --     VALUES('2017211121', 'Ethan', '2017211301', 'male', '1999', '2017', 'nowhere')

-- -- 添加教材表的约束
-- ALTER TABLE book$
--     ALTER COLUMN 教材ID号 NVARCHAR(255) NOT NULL
-- GO
-- ALTER TABLE book$ ADD PRIMARY KEY (教材ID号)

-- -- 添加class_course表的完整性约束
-- ALTER TABLE class_course$
--     ALTER COLUMN 班级号 NVARCHAR(255) NOT NULL
-- GO
-- ALTER TABLE class_course$
--     ALTER COLUMN 课程号 NVARCHAR(255) NOT NULL
-- GO
-- ALTER TABLE class_course$ ADD PRIMARY KEY (班级号,课程号)
-- GO

-- ALTER TABLE class_course$
--     ADD FOREIGN KEY (班级号) REFERENCES class$

-- -- 下面这个参照完整性约束依然由于数据本身有问题无法添加，但本人实在懒得再修改数据了……意会吧
-- -- (注意需要先完成对于course表的主键设置)
-- ALTER TABLE class_course$
--     ADD FOREIGN KEY (课程号) REFERENCES course$

-- -- 添加course表的约束
-- ALTER TABLE course$
--     ALTER COLUMN 课程号 NVARCHAR(255) NOT NULL
-- GO

-- ALTER TABLE course$ ADD PRIMARY KEY (课程号)
-- GO

-- -- 设置学院表的主键
-- ALTER TABLE department$
--     ALTER COLUMN 部门ID号 NVARCHAR(255) NOT NULL
-- GO

-- ALTER TABLE department$ ADD PRIMARY KEY (部门ID号)
-- GO

-- -- 设置教师表
-- ALTER TABLE teacher$
--     ALTER COLUMN 教师ID号 NVARCHAR(255) NOT NULL
-- GO

-- ALTER TABLE teacher$ ADD PRIMARY KEY (教师ID号)
-- GO

-- ALTER TABLE teacher$
--     ADD FOREIGN KEY (部门ID号) REFERENCES department$
-- GO

-- -- 教师类别表
-- ALTER TABLE teacher_category$
--     ALTER COLUMN 类别编号 FLOAT NOT NULL
-- GO

-- ALTER TABLE teacher_category$ ADD PRIMARY KEY (类别编号)
-- GO

-- -- 教师教课表
-- ALTER TABLE teacher_course_class$
--     ALTER COLUMN 教师编号 NVARCHAR(255) NOT NULL
-- GO
-- ALTER TABLE teacher_course_class$
--     ALTER COLUMN 课程号 NVARCHAR(255) NOT NULL
-- GO
-- ALTER TABLE teacher_course_class$
--     ALTER COLUMN 班级号 NVARCHAR(255) NOT NULL
-- GO
-- ALTER TABLE teacher_course_class$ ADD PRIMARY KEY (教师编号,课程号,班级号)
-- GO

-- ALTER TABLE teacher_course_class$
--     ADD FOREIGN KEY (教师编号) REFERENCES teacher$
-- GO

-- ALTER TABLE teacher_course_class$
--     ADD FOREIGN KEY (课程号) REFERENCES course$
-- GO

-- ALTER TABLE teacher_course_class$
--     ADD FOREIGN KEY (班级号) REFERENCES class$
-- GO


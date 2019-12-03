USE 学生选课
GO

-- 1
-- SELECT 学生ID号, 学生姓名
-- FROM student$
-- WHERE 班级ID号 = 'g09402'

-- 2
-- SELECT 周学时, 课程学分
-- FROM course$
-- WHERE 课程名称 = '网络技术与实践'

-- 3
-- SELECT 学生ID号, 分数
-- FROM student_course$
-- WHERE 课程ID号 = 'dep04_s001'
-- ORDER BY 分数 DESC

-- 4
-- SELECT *
-- FROM student$
-- WHERE 学生姓名 LIKE '张%'

-- 5
-- SELECT *
-- FROM student$
-- WHERE 出生时间 BETWEEN '1994-01-01' AND '1995-12-31'

-- 6
-- SELECT 学生ID号, 学生姓名, 性别, 出生时间
-- FROM student$
-- WHERE 出生时间 >= '1992-01-01' AND 性别 = '女'
-- ORDER BY 出生时间 DESC

-- 7-1
-- SELECT *
-- FROM student$

-- 7-2
-- SELECT COUNT(*) AS 'total_num'
-- FROM student$

-- 8
SELECT s.学生ID号, 学生姓名, 分数
FROM student$ AS s JOIN student_course$ as sc ON s.学生ID号 = sc.学生ID号
WHERE 课程ID号 = 'dep04_s002' AND 分数 > 85

-- 9
-- SELECT  s.学生ID号, s.学生姓名, c.课程名称, sc.分数
-- FROM student$ AS s, student_course$ AS sc, course$ as c
-- WHERE s.学生ID号 = sc.学生ID号 AND sc.课程ID号 = c.课程号

-- 10
-- SELECT c.课程名称, sc.学分, sc.分数
-- FROM student$ AS s, student_course$ AS sc, course$ as c
-- WHERE s.学生姓名 = '林红' AND s.学生ID号 = sc.学生ID号 AND sc.课程ID号 = c.课程号

-- 11
-- SELECT t.*, tc.类别名称
-- FROM teacher$ AS t, teacher_category$ AS tc
-- WHERE t.类别编号 = tc.类别编号

-- 12
-- SELECT t.教师ID号, tcc.课程号, tcc.班级号, tcc.学期, tcc.学年, tcc.排课标识, tcc.授课地点, tcc.教材编号
-- FROM teacher$ AS t FULL OUTER JOIN teacher_course_class$ AS tcc
--     ON t.教师ID号 = tcc.教师编号

-- 13
-- SELECT sc.学生ID号, COUNT(sc.课程ID号) AS 选课数量
-- FROM student_course$ AS sc
-- GROUP BY sc.学生ID号
-- ORDER BY COUNT(sc.课程ID号) DESC

-- 14
-- WITH course_num(course_id, student_num) AS(
--     SELECT sc.课程ID号, COUNT(sc.学生ID号)
--     FROM student_course$ AS sc
--     GROUP BY sc.课程ID号
-- )
-- SELECT cn.course_id, tcc.教师编号, cn.student_num
-- FROM course_num AS cn JOIN teacher_course_class$ AS tcc ON cn.course_id = tcc.课程号
-- WHERE tcc.教师编号 IN (
--     SELECT t.教师ID号
--     FROM department$ AS d JOIN teacher$ AS t ON d.部门ID号 = t.部门ID号
--     WHERE d.部门名称 = '计算机科学'
-- )

-- 15
-- 先筛选出两个老师的所有课（要用聚集函数去重），然后按照课程聚集，最后选出授课人数=2人的课程，就是两人同时教授的课程
-- WITH simp_tbl(teacher_id, course_id) AS(
--     SELECT tcc.教师编号, tcc.课程号
--     FROM teacher_course_class$ AS tcc
--     GROUP BY tcc.教师编号, tcc.课程号
--     HAVING tcc.教师编号 IN (
--         SELECT t.教师ID号
--         FROM teacher$ AS t
--         WHERE t.教师姓名 = '纪云' OR t.教师姓名 = '乔红'
--     )
-- )
-- SELECT c.课程名称
-- FROM course$ AS c
-- where c.课程号 IN(
--     SELECT simp_tbl.course_id
--     FROM simp_tbl
--     GROUP BY simp_tbl.course_id
--     HAVING COUNT(simp_tbl.teacher_id) = 2
-- )

-- 16
-- WITH tbl(teacher_name, teacher_id, course_id, course_name) AS(
--     SELECT  t.教师姓名, tcc.教师编号, c.课程号, c.课程名称
--     FROM course$ AS c, teacher_course_class$ AS tcc, teacher$ AS t
--     WHERE c.课程号 = tcc.课程号 AND tcc.教师编号 = t.教师ID号
-- )
-- (
--     SELECT course_id, course_name
--     FROM tbl
--     WHERE teacher_name = '严为'
-- )
-- EXCEPT
-- (
--     SELECT course_id, course_name
--     FROM tbl
--     WHERE teacher_name = '乔红'
-- )

-- 17
-- SELECT sc.学生ID号, s.学生姓名
-- FROM student_course$ AS sc JOIN student$ AS s ON s.学生ID号 = sc.学生ID号
-- GROUP BY sc.学生ID号, s.学生姓名
-- HAVING COUNT(sc.课程ID号) >= 3

-- 18
-- SELECT AVG(sc.分数) AS 'AVG of dep04_b001'
-- FROM student_course$ AS sc
-- GROUP BY sc.课程ID号
-- HAVING sc.课程ID号 = 'dep04_b001'

-- 19
-- WITH tbl(学号, 选修课最高分) AS(
--     SELECT sc.学生ID号, MAX(sc.分数)
--     FROM student_course$ AS sc
--     GROUP BY sc.学生ID号
-- )
-- SELECT s.学生姓名, tbl.学号, tbl.选修课最高分
-- FROM tbl JOIN student$ AS s ON tbl.学号 = s.学生ID号

-- 20
-- WITH tbl(course_id, student_id, student_name, student_class, grade) AS(
--     SELECT tcc.课程号, sc.学生ID号, s.学生姓名, s.班级ID号, sc.分数
--     FROM teacher$ AS t, teacher_course_class$ AS tcc, course$ AS c, student$ AS s, student_course$ AS sc
--     WHERE t.教师ID号 = tcc.教师编号 AND tcc.课程号 = c.课程号 AND t.教师姓名 = '严为' AND tcc.学年 = '2011/2012' AND c.课程名称 = '软件开发技术' AND s.学生ID号 = sc.学生ID号 AND sc.课程ID号 = tcc.课程号
-- )
-- SELECT *
-- FROM tbl AS t
-- WHERE t.grade IN (
--     SELECT MAX(s.grade)
--     FROM tbl AS s
-- )

-- 21
-- SELECT DISTINCT b.教材名, b.作者, b.出版社
-- FROM teacher_course_class$ AS tcc, book$ AS b, course$ AS c
-- WHERE tcc.教材编号 = b.教材ID号 AND tcc.课程号 = c.课程号 AND c.课程名称 = 'SQL Server数据库开发技术'

-- 22
-- SELECT t.教师姓名, t.职称或职业
-- FROM teacher_course_class$ AS tcc, teacher$ AS t, course$ AS c
-- WHERE c.课程名称 = 'JAVA程序设计与开发' AND tcc.教师编号 = t.教师ID号 AND c.课程号 = tcc.课程号

-- 23
-- SELECT t.教师姓名, t.性别
-- FROM teacher$ AS t
-- WHERE t.教师ID号 IN (
--     SELECT s.教师ID号
--     FROM teacher$ AS s
--     WHERE s.职称或职业 = '副教授' AND s.性别 = '女'
-- )

-- 24
-- SELECT s.*
-- FROM teacher$ AS s
-- WHERE s.教师ID号 IN (
--     SELECT tcc.教师编号
--     FROM teacher_course_class$ AS tcc
--     WHERE tcc.课程号 = 'dep01_s002'
-- )

-- 25
-- SELECT s.学生ID号, s.学生姓名
-- FROM student$ AS s
-- WHERE s.学生ID号 IN (
--     SELECT sc.学生ID号
--     FROM student_course$ AS sc
--     WHERE sc.课程ID号 = 'dep04_s001'
-- )

-- 26
-- SELECT s.学生姓名, s.性别
-- FROM student$ AS s
-- WHERE s.学生ID号 IN(
--     SELECT DISTINCT sc.学生ID号
--     FROM student_course$ AS sc
--     WHERE sc.分数 < 60
-- )

-- 27
-- SELECT s.学生姓名, s.性别, s.家庭住址
-- FROM student$ AS s
-- WHERE s.学生ID号 IN(
--     SELECT sc.学生ID号
--     FROM student_course$ AS sc JOIN course$ AS c ON sc.课程ID号 = c.课程号
--     WHERE c.课程名称 = '网页设计' AND sc.分数 < 60
-- )

-- 28
-- SELECT s.学生ID号, s.学生姓名
-- FROM student$ AS s
-- WHERE s.学生ID号 IN(
--     SELECT sc.学生ID号
--     FROM student_course$ AS sc JOIN course$ AS c ON sc.课程ID号 = c.课程号
--     WHERE c.课程名称 = '计算机基础'
-- )

-- 29
-- (
--     SELECT s.学生ID号, s.学生姓名
--     FROM student$ AS s
-- )
-- EXCEPT
-- (
--     SELECT s.学生ID号, s.学生姓名
--     FROM student$ AS s
--     WHERE s.学生ID号 IN(
--         SELECT sc.学生ID号
--         FROM student_course$ AS sc JOIN course$ AS c ON sc.课程ID号 = c.课程号
--         WHERE c.课程名称 = '计算机基础'
--     )
-- )

-- 30
-- SELECT s.学生ID号, s.学生姓名
-- FROM student$ AS s
-- WHERE NOT EXISTS(
--     (
--         SELECT sc.课程ID号
--         FROM student_course$ AS sc
--         WHERE sc.学生ID号 = 'g0940201'    
--     )
--     EXCEPT
--     (
--         SELECT sc.课程ID号
--         FROM student_course$ AS sc
--         WHERE sc.学生ID号 = s.学生ID号
--     )
-- )
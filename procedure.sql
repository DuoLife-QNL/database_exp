use 学生选课
go

create procedure find_teacher
as
select t.教师姓名, t.性别, t.职称或职业, c.课程名称
from teacher$ as t, teacher_course_class$ as tcc, course$ as c
where t.教师ID号 = tcc.教师编号 and tcc.课程号 = c.课程号
go
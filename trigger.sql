use 学生选课
go

-- -- 创建对于学生表插入条目后将所有学生学号+1触发器
-- create trigger id_inc on student$ after insert
-- as 
-- 	update student$
-- 		set 学生ID号 = SUBSTRING(学生ID号, 1, 5) + CAST(CAST(SUBSTRING(学生ID号,6,8) as int) + 1 as nvarchar)
-- go

-- -- trigger test
-- INSERT student$
-- VALUES('g1740302','Ethan', 'g10403', '男', '1999-05-28', '2017-09-01', 'Dalian')
-- GO

-- -- 创建UPDATEClass触发器，当对班级信息表主键"班级号"进行修改时，应对学生表中相应的"班级号"也进行修改
-- CREATE TRIGGER UpdateClass ON class$ AFTER UPDATE
-- AS
-- BEGIN
--     DECLARE @class_id_new NVARCHAR(255)
--     DECLARE @class_id_old NVARCHAR(255)
--     SELECT @class_id_old=班级号 FROM DELETED
--     SELECT @class_id_new=班级号 FROM INSERTED
--     UPDATE student$
--         SET 班级ID号=@class_id_new
--         WHERE 班级ID号 = @class_id_old
-- END
-- GO

-- new trigger
CREATE TRIGGER UpdateClass ON class$ AFTER UPDATE
AS
BEGIN
    DECLARE @class_id_new NVARCHAR(255)
    DECLARE @class_id_old NVARCHAR(255)
    SELECT @class_id_old=班级号 FROM DELETED
    SELECT @class_id_new=班级号 FROM INSERTED
    BEGIN
    UPDATE student$
        SET 班级ID号=@class_id_new
        WHERE 班级ID号=@class_id_old
    UPDATE class_course$
        SET 班级号=@class_id_new
        WHERE 班级号=@class_id_old
    UPDATE teacher_course_class$
        SET 班级号=@class_id_new
        WHERE 班级号=@class_id_old
    END
END
GO

-- -- trigger test
UPDATE class$
SET 班级号 = 'g09406'
WHERE 班级号 = 'g09402'
GO

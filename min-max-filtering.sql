WITH tg AS (
	SELECT s.id, s.student_name, MAX(sg.final_grade) AS top_grade
    FROM students s 
	INNER JOIN student_grades sg
		ON s.id = sg.student_id
	GROUP BY s.id, s.student_name
    ORDER BY s.id
	)
    
SELECT tg.id, tg.student_name, tg.top_grade, sg.class_name
FROM tg 
LEFT JOIN student_grades sg
	ON tg.id = sg.student_id AND tg.top_grade = sg.final_grade;
    
-- OR
SELECT * FROM
(SELECT s.id, s.student_name, sg.class_name, sg.final_grade,
	DENSE_RANK() OVER (PARTITION BY s.student_name ORDER BY sg.final_grade DESC) AS grade_rank
FROM students s 
LEFT JOIN student_grades sg
	ON s.id = sg.student_id) AS gr
WHERE grade_rank = 1;
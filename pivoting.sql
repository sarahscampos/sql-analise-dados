SELECT sg.department,
	ROUND(AVG(CASE WHEN s.grade_level = 9 THEN sg.final_grade END)) AS freshman,
    ROUND(AVG(CASE WHEN s.grade_level = 10 THEN sg.final_grade END)) AS sophomore,
    ROUND(AVG(CASE WHEN s.grade_level = 11 THEN sg.final_grade END)) AS junior,
    ROUND(AVG(CASE WHEN s.grade_level = 12 THEN sg.final_grade END)) AS senior
FROM students s 
LEFT JOIN student_grades sg
	ON s.id = sg.student_id
WHERE sg.department IS NOT NULL
GROUP BY sg.department
ORDER BY sg.department;
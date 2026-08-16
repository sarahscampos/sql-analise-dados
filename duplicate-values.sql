WITH sc AS (
	SELECT id, student_name, email,
		ROW_NUMBER() OVER (PARTITION BY student_name ORDER BY id DESC) AS student_count
	FROM students
	)
    
SELECT *
FROM sc
WHERE student_count = 1;
-- 1. Returns a list with the first surname, second surname and the name of all students. The list must be ordered alphabetically from minor to major by the first surname, second surname and name.

SELECT
    persona.apellido1,
    persona.apellido2,
    persona.nombre
FROM
    universidad.persona
INNER JOIN
    universidad.alumno_se_matricula_asignatura a
    ON persona.id = a.id_alumno
    GROUP BY
    persona.apellido1,
    persona.apellido2,
    persona.nombre
ORDER BY persona.apellido1, persona.apellido2, nombre;

-- 2. Find out the name and two surnames of students who have not registered their phone number in the database. (number, apellido1, apellido2)

SELECT DISTINCT
    persona.nombre,
    persona.apellido1,
    persona.apellido2
FROM universidad.persona
INNER JOIN universidad.alumno_se_matricula_asignatura a
    ON persona.id = a.id_alumno
WHERE persona.telefono IS NULL;

-- 3. Returns the list of students who were born in 1999. (id, number, apellido1, apellido2, fecha_nacimiento)

SELECT
    persona.id,
    persona.nif,
    persona.apellido1,
    persona.apellido2,
    persona.fecha_nacimiento
FROM universidad.persona
INNER JOIN universidad.alumno_se_matricula_asignatura a
    ON persona.id = a.id_alumno
WHERE YEAR(persona.fecha_nacimiento) = 1999
ORDER BY persona.apellido1, persona.apellido2;

-- 4. Returns the list of teachers who have not registered their phone number in the database and also their NIF ends in K. (number, apellido1, apellido2, nif)

SELECT
    persona.id,
    persona.apellido1,
    persona.apellido2,
    persona.fecha_nacimiento,
    persona.nif
FROM universidad.persona
INNER JOIN universidad.profesor p
    ON persona.id = p.id_profesor
WHERE persona.nif LIKE '%k'
AND persona.telefono IS null;

-- 5. Returns the list of the subjects taught in the first semester, in the third year of the degree that has the identifier 7. (id, number, semester, course, id_grado)


SELECT
    asignatura.id,
    asignatura.nombre,
    CASE
        WHEN asignatura.cuatrimestre IN (1, 2) THEN '1 Semester'
        WHEN asignatura.cuatrimestre IN (3, 4) THEN '2 Semester'
        ELSE 'Semestre desconocido'
    END AS semester,
    asignatura.id_grado,
    asignatura.curso
FROM
	universidad.asignatura
WHERE (asignatura.cuatrimestre=1 OR asignatura.cuatrimestre=2)
	AND asignatura.curso=3 and id_grado=7;

-- 6. Returns a list of teachers together with the name of the department to which they are linked. The list must return four columns, first surname, second surname, name and name of the department. The result will be alphabetically ordered from lowest to highest by surnames and name. (apellido1, apellido2, nombre, departamento)

SELECT
    persona.apellido1,
    persona.apellido2,
    persona.nombre,
    departamento.nombre as nombre_departamento
FROM universidad.persona
INNER JOIN universidad.profesor p
    ON persona.id = p.id_profesor
INNER JOIN universidad.departamento
    ON p.id_departamento = departamento.id
ORDER BY persona.apellido1, persona.apellido2, persona.nombre;

-- 7. Returns a list with the name of the subjects, year of beginning and year of end of the school year of the student with NIF 26902806M. (number, anyo_inicio, anyo_fin)

SELECT DISTINCT
    persona.nombre as nombre_estudiante,
    c.anyo_inicio,
    c.anyo_fin
FROM universidad.persona
INNER JOIN universidad.alumno_se_matricula_asignatura a
    ON persona.id = a.id_alumno
INNER JOIN universidad.curso_escolar c
    ON a.id_curso_escolar = c.id
WHERE persona.nif='26902806M';

-- 8. Returns a list with the name of all the departments that have teachers who teach a subject in the Degree in Computer Engineering (Plan 2015). (number)

SELECT
    departamento.nombre as nombre_departamento
FROM universidad.departamento
INNER JOIN universidad.profesor p
    ON departamento.id = p.id_departamento
INNER JOIN universidad.asignatura a
    ON p.id_profesor = a.id_profesor
WHERE a.id = '13';

--9. Returns a list with all students who have enrolled in a subject during the 2018/2019 school year. (number, apellido1, apellido2)

SELECT DISTINCT
    persona.nombre,
    persona.apellido1,
    persona.apellido2
FROM universidad.persona
INNER JOIN universidad.alumno_se_matricula_asignatura a
    ON persona.id = a.id_alumno
INNER JOIN universidad.curso_escolar c
	ON a.id_curso_escolar = c.id
WHERE c.anyo_inicio=2018 AND c.anyo_fin=2019;

-- Solve the following 6 queries using the LEFT JOIN and RIGHT JOIN clauses.

-- 10. Returns a list with the names of all the teachers and the departments they have linked. The list must also show those teachers who do not have any associated department. The list must return four columns, name of the department, first surname, second surname and name of the teacher. The result will be alphabetically ordered from minor to major by the name of the department, surnames and name. (departamento, apellido1, apellido2, number)

SELECT
    d.nombre AS departamento,
    pe.apellido1,
    pe.apellido2,
    pe.nombre
FROM universidad.profesor pr
INNER JOIN universidad.persona pe
    ON pr.id_profesor = pe.id
LEFT JOIN universidad.departamento d
    ON pr.id_departamento = d.id
ORDER BY
    d.nombre ASC,
    pe.apellido1 ASC,
    pe.apellido2 ASC,
    pe.nombre ASC;

-- 11. Returns a list with teachers who are not associated with a department. (apellido1, apellido2, number)

SELECT
    pe.apellido1,
    pe.apellido2,
    pe.nombre
FROM universidad.profesor pr
JOIN universidad.persona pe
    ON pr.id_profesor = pe.id
LEFT JOIN universidad.departamento d
    ON pr.id_departamento = d.id
WHERE d.id IS NULL
ORDER BY
    pe.apellido1,
    pe.apellido2,
    pe.nombre;

-- 12. Returns a list with departments that do not have associate professors. (number)

SELECT
    d.nombre
FROM universidad.departamento d
LEFT JOIN universidad.profesor pr
    ON pr.id_departamento = d.id
WHERE pr.id_profesor IS NULL
ORDER BY d.nombre;

-- 13. Returns a list with teachers who do not teach any subject. (apellido1, apellido2, number)

SELECT
    pe.apellido1,
    pe.apellido2,
    pe.nombre
FROM universidad.profesor pr
JOIN universidad.persona pe
    ON pr.id_profesor = pe.id
LEFT JOIN universidad.asignatura a
    ON a.id_profesor = pr.id_profesor
WHERE a.id IS NULL
ORDER BY
    pe.apellido1,
    pe.apellido2,
    pe.nombre;

-- 14. Returns a list with the subjects that do not have an assigned teacher. (id, number)

SELECT
    a.id,
    a.nombre
FROM universidad.asignatura a
LEFT JOIN universidad.profesor pr
    ON a.id_profesor = pr.id_profesor
WHERE pr.id_profesor IS NULL
ORDER BY
    a.id;

-- 15. Returns a list with all departments that have not taught subjects in any school year. (number)

SELECT d.nombre
FROM universidad.departamento d
LEFT JOIN universidad.profesor pr
    ON pr.id_departamento = d.id
LEFT JOIN universidad.asignatura a
    ON a.id_profesor = pr.id_profesor
WHERE a.curso IS NULL;

Summary queries:

-- 16. Returns the total number of students there. (total)

  SELECT COUNT(*)
   FROM universidad.alumno_se_matricula_asignatura;

-- 17. Calculate how many students were born in 1999. (total)

SELECT COUNT(*)
FROM universidad.alumno_se_matricula_asignatura a
INNER JOIN universidad.persona p
ON a.id_alumno = p.id
WHERE YEAR(fecha_nacimiento)=1999;

--18. Calculate how many teachers are in each department. The result should only show two columns, one with the name of the department and another with the number of teachers in that department. The result must only include the departments that have associate professors and must be ordered from highest to lowest by the number of teachers. (department, total)

SELECT
    d.nombre AS department,
    COUNT(p.id_profesor) AS total
FROM
    universidad.departamento d
INNER JOIN
    universidad.profesor p ON d.id = p.id_departamento
GROUP BY
    d.id, d.nombre
HAVING
    COUNT(p.id_profesor) > 0
ORDER BY
    total DESC;

--19. Returns a list of all the departments and the number of teachers in each of them. Please note that there may be departments that do not have associate professors. These departments must also appear in the list. (departamento, total)

SELECT
    d.nombre AS departamento,
    COUNT(p.id_profesor) AS total
FROM
    universidad.departamento d
LEFT JOIN
    universidad.profesor p ON d.id = p.id_departamento
GROUP BY
    d.id, d.nombre
ORDER BY
    total DESC;

--20. Returns a list with the name of all the existing degrees in the database and the number of subjects each. Keep in mind that there may be degrees that do not have associated subjects. These degrees should also appear in the list. The result must be ordered from highest to lowest by the number of subjects. (degree, total)

SELECT
    g.nombre AS grado,
    COUNT(a.id) AS total
FROM
    universidad.grado g
LEFT JOIN
    universidad.asignatura a ON g.id = a.id_grado
GROUP BY
    g.id, g.nombre
ORDER BY
    total DESC;

-- 21. Returns a list with the name of all the existing degrees in the database and the number of subjects that each one has, of the degrees that have more than 40 associated subjects. (degree, total)

-- 22. Returns a list that shows the name of the degrees and the sum of the total number of credits that exist for each type of subject. The result must have three columns: name of the degree, type of subject and the sum of the credits of all the subjects that exist of this type. (degree, type, total_creditos)

-- 23. Returns a list that shows how many students have enrolled for a subject in each of the school years. The result must show two columns, one column with the year of beginning of the school year and another with the number of students enrolled. (anyo_inicio, total)

-- 24. Returns a list with the number of subjects taught by each teacher. The list must take into account those teachers who do not teach any subject. The result will show five columns: id, name, first surname, second surname and number of subjects. The result will be ordered from highest to lowest by the number of subjects. (id, number, apellido1, apellido2, total)

-- 25. Returns all the data of the youngest student.

-- 26. Returns a list with teachers who have an associated department and do not teach any subject. (apellido1, apellido2, number)

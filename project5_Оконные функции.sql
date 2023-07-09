DROP TABLE IF EXISTS cars;
CREATE TABLE Cars
(
    id    INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NULL,
    cost  INT NULL
);

INSERT INTO Cars (name, cost) VALUES ('Audi', 52642);
INSERT INTO Cars (name, cost) VALUES ('Mercedes', 57127);
INSERT INTO Cars (name, cost) VALUES ('Skoda', 9000);
INSERT INTO Cars (name, cost) VALUES ('Volvo', 29000);
INSERT INTO Cars (name, cost) VALUES ('Bentley', 350000);
INSERT INTO Cars (name, cost) VALUES ('Citroen', 21000);
INSERT INTO Cars (name, cost) VALUES ('Hummer', 41400);
INSERT INTO Cars (name, cost) VALUES ('Volkswagen', 21600);

SELECT * FROM Cars;

-- 1.	Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

CREATE VIEW cars_1_1 AS
SELECT * FROM Cars
WHERE cost < 25000;

-- 2.	Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

ALTER VIEW cars_1_2 AS
SELECT * FROM Cars
WHERE cost < 30000;

-- 3. 	Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” 

CREATE VIEW cars_1_3 AS
SELECT * FROM Cars
WHERE name = "Audi" OR name = "Skoda";

-- 2. Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.

SELECT * FROM analysis;
SELECT * FROM gruppa;
SELECT * FROM zakaz;


SELECT an_name, an_price, ord_datetime
FROM analysis
JOIN zakaz
ON analysis.an_id = zakaz.ord_id
WHERE zakaz.ord_datetime >= '2020-02-05' AND zakaz.ord_datetime <= DATE_ADD('2020-02-05', INTERVAL 1 WEEK);


-- 3. Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение, мы вычитаем время станций
-- для пар смежных станций. Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно.
-- Проще это сделать с помощью оконной функции LEAD . Эта функция сравнивает значения из одной строки со следующей строкой,
-- чтобы получить результат. В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.

SELECT * FROM trains;

SELECT *,
SUBTIME(LEAD(station_time) OVER(PARTITION BY trains_id ORDER BY station_time), station_time)
AS time_to_next_station
FROM trains;
# Cортировка данных

- [Cортировка данных](#cортировка-данных)
  - [Используемая база данных](#используемая-база-данных)
  - [Оператор ORDER BY](#оператор-order-by)
    - [Сортировка по нескольким полям](#сортировка-по-нескольким-полям)
    - [Сортировка по положению поля](#сортировка-по-положению-поля)
    - [Указание направления сортировки](#указание-направления-сортировки)
  - [Примечания](#примечания)
    - [Примечание 1](#примечание-1)
    - [Примечание 2](#примечание-2)
    - [Примечание 3](#примечание-3)
    - [Примечание 4](#примечание-4)

## Используемая база данных

Перед тем как приступить к теме урока, рассмотрим базу данных, которая будет использоваться в последующих примерах. Она состоит из одной таблицы с именем `Songs`, которая содержит информацию о пяти наиболее популярных песнях на некоторой площадке для прослушивания музыки:

```sql
+----+-------+----------------------+------------+---------+--------------+
| id | place | trackname            | artist     | streams | release_date |
+----+-------+----------------------+------------+---------+--------------+
| 1  | 4     | Crazy On You         | Heart      | 76338   | 2009-12-19   |
| 2  | 3     | My Lover             | The Sounds | 99488   | 2009-05-31   |
| 3  | 2     | Running up That Hill | Kate Bush  | 121495  | 1985-08-05   |
| 4  | 5     | Thrill               | The Sounds | 49345   | 2016-11-11   |
| 5  | 1     | Spent the Day in Bed | Morrissey  | 174994  | 2017-10-17   |
+----+-------+----------------------+------------+---------+--------------+
```

Первое поле этой таблицы содержит идентификатор песни, второе — позицию песни в топе, третье — название песни, четвертое — псевдоним исполнителя или название группы, пятое — количество прослушиваний, шестое — дату выхода.

Скрипт для создания таблицы `Songs`:

```sql
DROP TABLE IF EXISTS Songs;
CREATE TABLE Songs
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    place        INT,
    trackname    VARCHAR(30),
    artist       VARCHAR(30),
    streams      INT,
    release_date DATE
);

INSERT INTO Songs (place, trackname, artist, streams, release_date)
VALUES (4, 'Crazy On You', 'Heart', 76338, '2009-12-19'),
       (3, 'My Lover', 'The Sounds', 99488, '2009-05-31'),
       (2, 'Running up That Hill', 'Kate Bush', 121495, '1985-08-05'),
       (5, 'Thrill', 'The Sounds', 49345, '2016-11-11'),
       (1, 'Spent the Day in Bed', 'Morrissey', 174994, '2017-10-17');
```

## Оператор ORDER BY

Нередко при извлечении данных возникает необходимость получить их в определенном упорядоченном виде. Например, во время работы с персональными данными людей может понадобиться расположить их в лексикографическом порядке имен или в порядке увеличения возраста. В SQL для подобных задач предназначен оператор `ORDER BY`.

Чтобы извлечь информацию из базы данных в отсортированном виде, достаточно дополнить запрос оператором `ORDER BY` и указать название поля, по которому необходимо осуществить сортировку.

Результатом приведенного ниже запроса:

```sql
SELECT artist, trackname, release_date
FROM Songs
ORDER BY release_date;
```

является:

```sql
+------------+----------------------+--------------+
| artist     | trackname            | release_date |
+------------+----------------------+--------------+
| Kate Bush  | Running up That Hill | 1985-08-05   |
| The Sounds | My Lover             | 2009-05-31   |
| Heart      | Crazy On You         | 2009-12-19   |
| The Sounds | Thrill               | 2016-11-11   |
| Morrissey  | Spent the Day in Bed | 2017-10-17   |
+------------+----------------------+--------------+
```

> Обратите внимание, что по умолчанию оператор `ORDER BY` выполняет сортировку именно **по возрастанию**.

### Сортировка по нескольким полям

Часто сортировки лишь по одному полю бывает недостаточно, поскольку несколько записей могут содержать одно и то же значение в том поле, по которому выполняется сортировка. Чтобы выполнить сортировку по нескольким полям, нужно перечислить их через запятую.

Результатом приведенного ниже запроса:

```sql
SELECT artist, trackname, streams
FROM Songs
ORDER BY artist, streams;
```

является:

```sql
+------------+----------------------+---------+
| artist     | trackname            | streams |
+------------+----------------------+---------+
| Heart      | Crazy On You         | 76338   |
| Kate Bush  | Running up That Hill | 121495  |
| Morrissey  | Spent the Day in Bed | 174994  |
| The Sounds | Thrill               | 49345   |
| The Sounds | My Lover             | 99488   |
+------------+----------------------+---------+
```

Запрос выше выполняет сортировку сначала по полю `artist`, затем по полю `streams`. Если какие-либо две записи имеют разные значения в поле `artist`, они сортируются согласно этим значениям. Если какие-либо две записи имеют одинаковые значения в поле `artist`, они сортируются согласно значениям в поле `streams`.

### Сортировка по положению поля

Вместо имен полей оператор `ORDER BY` позволяет указывать порядковые номера полей, по которым необходимо выполнить сортировку. Однако сортировка таким методом возможна только по тем полям, которые присутствуют в результирующей таблице. Нумеруются поля с единицы: первое поле результирующей таблицы имеет порядковый номер 1, второе — 2 и так далее.

Например, запрос:

```sql
SELECT artist, trackname, streams
FROM Songs
ORDER BY artist, streams;
```

можно переписать следующим образом:

```sql
SELECT artist, trackname, streams
FROM Songs
ORDER BY 1, 3;
```

### Указание направления сортировки

Сортировать данные можно не только по возрастанию, но и по убыванию. Чтобы сортировка выполнялась в порядке убывания, необходимо после имени поля указать ключевое слово `DESC`.

Результатом приведенного ниже запроса:

```sql
SELECT place, trackname
FROM Songs
ORDER BY place DESC;
```

является:

```sql
+-------+----------------------+
| place | trackname            |
+-------+----------------------+
| 5     | Thrill               |
| 4     | Crazy On You         |
| 3     | My Lover             |
| 2     | Running up That Hill |
| 1     | Spent the Day in Bed |
+-------+----------------------+
```

> Если необходимо отсортировать записи в порядке убывания значений нескольких полей, нужно обязательно указать ключевое слово `DESC` после каждого из них.

## Примечания

### Примечание 1

Аналогично тому, как для сортировки в порядке убывания существует ключевое слово `DESC`, для сортировки в порядке возрастания предусмотрено ключевое слово `ASC`, использовать которое необязательно.

Приведенный ниже запрос:

```sql
SELECT title
FROM Songs
ORDER BY title;
```

полностью идентичен следующему запросу:

```sql
SELECT title
FROM Songs
ORDER BY title ASC;
```

### Примечание 2

Сортировка является одной из завершающих операций и выполняется уже после формирования результирующей таблицы, поэтому в блоке оператора `ORDER BY` можно указывать как фактические имена полей таблицы, из которой извлекаются данные, так и их псевдонимы.

Результатом приведенного ниже запроса:

```sql
SELECT artist, trackname AS track, release_date
FROM Songs
ORDER BY track;
```

является:

```sql
+------------+----------------------+--------------+
| artist     | track                | release_date |
+------------+----------------------+--------------+
| Heart      | Crazy On You         | 2009-12-19   |
| The Sounds | My Lover             | 2009-05-31   |
| Kate Bush  | Running up That Hill | 1985-08-05   |
| Morrissey  | Spent the Day in Bed | 2017-10-17   |
| The Sounds | Thrill               | 2016-11-11   |
+------------+----------------------+--------------+
```

Если псевдоним состоит из нескольких слов, то при сортировке данных по этому псевдониму необходимо заключать его в обратные апострофы (\`\`).

### Примечание 3

Ключевое слово `DESC` — это сокращение от **DESCENDING** (убывание). Его антоним – ключевое слово `ASC` – сокращение от `ASCENDING` (возрастание).

### Примечание 4

При сортировке строковых значений регистр не учитывается. Данное поведение может быть изменено в настройках СУБД, однако выбирать, учитывать регистр или нет, с помощью оператора `ORDER BY` нельзя.

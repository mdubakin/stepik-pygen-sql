# Фильтрация данных

- [Фильтрация данных](#фильтрация-данных)
  - [Используемая база данных](#используемая-база-данных)
  - [Метасимволы и оператор LIKE](#метасимволы-и-оператор-like)
    - [Метасимвол %](#метасимвол-)
    - [Метасимвол \_](#метасимвол-_)
  - [Оператор LIKE BINARY](#оператор-like-binary)
  - [Примечание](#примечание)

## Используемая база данных

Перед тем как приступить к теме урока, рассмотрим базу данных, которая будет использоваться в последующих примерах. Она состоит из одной таблицы с именем `Songs`, которая содержит информацию о пяти наиболее популярных песнях на некоторой площадке для прослушивания музыки:

```sql
+----+-------+--------------------------------------+---------------+
| id | place | trackname                            | artist        |
+----+-------+--------------------------------------+---------------+
| 1  | 4     | You Just Haven't Earned It Yet, Baby | The Smiths    |
| 2  | 3     | Crazy On You                         | Heart         |
| 3  | 2     | Dark Days                            | Theredsunband |
| 4  | 5     | Wish You Were Here                   | The Sounds    |
| 5  | 1     | Let Me Kiss You                      | Morrissey     |
+----+-------+--------------------------------------+---------------+
```

Первое поле таблицы содержит идентификатор песни, второе — позицию песни в топе, третье — название песни, четвертое — псевдоним исполнителя или название группы.

Скрипт для создания таблицы `Songs`:

```sql
DROP TABLE IF EXISTS Songs;
CREATE TABLE Songs
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    place     INT,
    trackname VARCHAR(50),
    artist    VARCHAR(30)
);

INSERT INTO Songs (place, trackname, artist)
VALUES (4, "You Just Haven't Earned It Yet, Baby", 'The Smiths'),
       (3, 'Crazy On You', 'Heart'),
       (2, 'Dark Days', 'Theredsunband'),
       (5, 'Wish You Were Here', 'The Sounds'),
       (1, 'Let Me Kiss You', 'Morrissey');
```

## Метасимволы и оператор LIKE

Операторы сравнения (`=`, `>`, `BETWEEN` и другие) позволяют достаточно точно фильтровать данные, однако они несколько ограничены в своем функционале, так как выполняют фильтрацию по известным значениям. Например, если бы нам было необходимо среди множества музыкальных исполнителей отыскать только тех, названия которых начинаются с последовательности символов `The`, с помощью обычных операторов сравнения мы бы это сделать не смогли. Для подобных случаев предусмотрен поиск с использованием **метасимволов**, которые позволяют создавать **шаблоны поиска** и находить значения, соответствующие не чему-либо конкретному, а именно этим шаблонам.

Метасимволы сами по себе являются специальными знаками, которые трактуются языком особым образом. Чтобы использовать их в условиях отбора записей, необходимо задействовать оператор `LIKE`, который говорит о том, что следующий шаблон поиска необходимо анализировать с учетом метасимволов, а не искать точные совпадения.

> Шаблоны поиска представляют собой строки, состоящие из обычных символов, метасимволов или любой их комбинации, поэтому поиск с использованием метасимволов может осуществляться только в строковых полях.

### Метасимвол %

Наиболее часто используемым метасимволом является знак процента (`%`), который в шаблоне поиска соответствует последовательности любых символов, причем число символов в последовательности может быть от 0 и более. Например, чтобы найти информацию о песнях, названия исполнителей которых начинаются с последовательности символов The, можно составить следующий шаблон поиска: `The%`.

Результатом приведенного ниже запроса:

```sql
SELECT trackname, artist
FROM Songs
WHERE artist LIKE 'The%';
```

является:

```sql
+--------------------------------------+---------------+
| trackname                            | artist        |
+--------------------------------------+---------------+
| You Just Haven't Earned It Yet, Baby | The Smiths    |
| Dark Days                            | Theredsunband |
| Wish You Were Here                   | The Sounds    |
+--------------------------------------+---------------+
```

### Метасимвол _

Еще одним полезным метасимволом является знак нижнего подчеркивания (`_`), который в шаблоне поиска соответствует одному любому символу. Например, с его помощью можно составить запрос, который поможет отыскать информацию о песнях, названия которых начинаются с какого-либо четырехсимвольного слова.

Результатом приведенного ниже запроса:

```sql
SELECT trackname, artist
FROM Songs
WHERE trackname LIKE '____ %';
```

является:

```sql
+--------------------+---------------+
| trackname          | artist        |
+--------------------+---------------+
| Dark Days          | Theredsunband |
| Wish You Were Here | The Sounds    |
+--------------------+---------------+
```

## Оператор LIKE BINARY

Важной особенностью оператора `LIKE` является то, что при поиске с его помощью строк, соответствующих шаблону, не учитывается регистр символов, используемых в этом шаблоне.

Поэтому в случаях, когда регистр символов важен, используется оператор `LIKE BINARY`, который работает аналогично оператору `LIKE`, но учитывает регистр символов, используемых в шаблоне поиска.

Результатом приведенного ниже запроса:

```sql
SELECT trackname, artist
FROM Songs
WHERE trackname LIKE BINARY '%You%';
```

является:

```sql
+--------------------------------------+------------+
| trackname                            | artist     |
+--------------------------------------+------------+
| You Just Haven't Earned It Yet, Baby | The Smiths |
| Crazy on You                         | Heart      |
| Wish You Were Here                   | The Sounds |
| Let Me Kiss You                      | Morrissey  |
+--------------------------------------+------------+
```

## Примечание

Метасимволы в шаблоне поиска соответствуют набору символов или одному любому символу, однако иногда может понадобиться отыскать совпадение только для самого метасимвола, например, символа процента (`%`). В подобных случаях используется экранирование с помощью ключевого слова `ESCAPE`, которое указывается после шаблона поиска и определяет символ, отвечающий за экранирование.

Например, условие для поиска значений вида `10%`, `24%`, `49%` и так далее может выглядеть следующим образом:

```sql
...
WHERE <название поля> LIKE '__/%' ESCAPE '/';
```

Здесь для экранирования используется прямой слеш (`/`), который в шаблоне указывает на то, что символ, стоящий после прямого слеша, не следует рассматривать как метасимвол.

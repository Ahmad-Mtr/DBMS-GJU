# DBMS CheatSheet

***
**Metadata**: The self-describing data is called metadata, which is
data about data.

| TableName | NumberColumns | PrimaryKey                   |
|-----------|---------------|------------------------------|
| STUDENT   | 4             | StudentNumber                |
| CLASS     | 4             | ClassNumber                  |
| GRADE     | 3             | (StudentNumber, ClassNumber) |

***
**Note:** `TOP` controls NumofRows (similar to limit).

```mysql
/* *** SQL-Query-CH02-06 *** */
SELECT TOP 5 Buyer, Department
FROM SKU_DATA;
```

```mysql
/* *** SQL-Query-CH02-07 *** */
SELECT TOP 75 PERCENT Buyer, Department
FROM SKU_DATA;
```

#### Top 75% in integers, so suppose there were 10 Rows, in this case the Results are 7 Rows.

***

### SQL Comparison Operators

| Operator    | Meaning                                                    |
|-------------|------------------------------------------------------------|
| =           | equal to                                                   |
| <>          | Is NOT Equal to                                            |
| <=          | Is less than OR equal to                                   |
| >=          | Is greater than OR equal to                                |
| IN          | Is equal to one of a set of values                         |
| NOT IN      | Is NOT equal to one of a set of values                     |
| BETWEEN     | Is within a range of numbers (includes the end points)     |
| NOT BETWEEN | Is NOT within a range of numbers (includes the end points) |
| LIKE        | Matches a sequence of characters                           |
| NOT LIKE    | LIKE Does NOT match a sequence of characters               |
| IS NULL     | Is equal to NULL                                           |
| IS NOT NULL | Is NOT equal to NULL                                       |

#### Wild Card Charachters:

* `%`: represents any sequence of contiguous,
  unspecified characters (including spaces) in a specific
  position in the character string.

* `_`: represents a single, unspecified character in a
  specific position in the character string.

***

### Concatenation

#### Examples:

```mysql
SELECT (GreetingPhrase + '_'
    + WorldTranslation)              AS Greeting,

       CONCAT(GreetingPhrase, '_',
              WorldTranslation)      AS Greeting2,

       RTRIM(GreetingPhrase) + '_'
           + RTRIM(WorldTranslation) AS Greeting3

FROM DATA
where Lang = 'English'; -- returns: Hello_World
```

### Summary of Normalization Theory

|    **Sources of Anomaly**     |  **Normal Forms**   |                              **Design Principles**                               |
|:-----------------------------:|:-------------------:|:--------------------------------------------------------------------------------:|
|    Functional Dependencies    | 1NF, 2NF, 3NF, BCNF |                   Design so every determinant is candidate key                   |
|   Multivalued dependencies    |         4NF         |           4NF: Move each multivalued dependency to a table of its own            |
| Data constraints and oddities |     5NF, DK/NF      | DK/NF: Make every constraint a logical consequence of candidate keys and domains |

***

### Normal Forms:

1. `1NF`:
    - Is a Relation
    - Has a Defined Primary Key.
2. `2NF`:
    - Is a `1NF`
    - all non-key attributes are
      determined by the **entire** primary key.
    - Example: 
    -  (A,B) →  N,O P
    - `A → N , B → N`

3. `3NF`:
    - Is a `2NF`
    - there are no non-key 
attributes determined by another non-key attribute.
    - **Important:** non-key attribute means
      -  Not a candidate key
      - Not a part of a composite candidate key.
4. Boyce-Codd `BCNF`:
    - Is a `3NF`
    - Every determinant is a candidate 
key.
   5. `4NF`: **Multivalued Anomalies**: Solve it simply by putting each multivalued dependicy in a relation
* Converting to `BCNF`: Either Check for 1,2,3-NF or check for Transitives and Candidate Keys.

***
### Advantages and Disadvantages of Normalization
   * **Advantages**
   * Eliminate modification anomalies
   * Reduce duplicated data
     - Eliminate data integrity problems
     - Save file space
     - Single table queries will run faster
* **Disadvantages**
  - More complicated SQL required for multiple 
  subqueries and joins
   - Extra work for DBMS can mean slower applications

---

### Other Notes

1. **Partial Dependency:**

```
(Student ID, Activity) → ActivityFee
Activity → ActivityFee
```

2. **Transitive dependency:** A non-key attribute determined by another non-key attribute, `Buyer → Department`
1. U can use `DISTINCT` within Agg. func.

```mysql
/* *** SQL-Query-CH02-38 *** */
SELECT COUNT(DISTINCT Department) AS
           DeptCount
FROM SKU_DATA;

```

2. **WHERE** clause operates on rows (choosing
   which rows will be displayed), whereas the **aggregate functions**
   operate on columns.


3.
    * **Explicit join**: `Join` is mentioned directly.
    * **Implicit join**  `JOIN` operator is not used as
      part of the SQL statement.

_Example:_

```mysql
SELECT *
FROM RETAIL_ORDER,
     ORDER_ITEM
WHERE RETAIL_ORDER.OrderNumber = ORDER_ITEM.OrderNumber;
```

4.
    * SQL subqueries and SQL joins both process multiple
      tables.
    * An SQL subquery can only be used to retrieve data from
      the “top table.”
    * An SQL join can be used to obtain data from any number
      of tables, including the “top table” of the subquery.
5. A recursive relationship (in database structures) is a
   relationship between two columns in the same table.


6. `UNION` The result is all the row values in one or both tables.
   `INTERSECT` The result is all the row values common to both tables.
   `   EXCEPT` The result is all the row values common to both tables
7. **Domain Integrity Constraint:** The requirement that all the values in a column are of the
   same kind.
8. **Entity Integrity Constraint:** the
   primary key must have unique data values inserted into
   every row of the table.
9. **Referential Integrity Constraint:** All foreign keys exist as a primary key in their original table.

***
### Date Functions
* **DATE_FORMAT** 
```mysql
DATE_FORMAT(NOW(), '%D %M %Y') = '1st June 2023' 

DATE_FORMAT(NOW(), '%D-%M-%Y') = '1st-June-2023'
```
* **DATE_ADD**
```mysql
DATE_ADD(date, INTERVAL unit)

DATE_ADD(NOW(), INTERVAL 1000 MICROSECOND) AS DateBatata
# returns 2023-12-04 00:05:12.001000 for example
```
* CURRENT_TIMESTAMP()
```mysql
CURRENT_TIMESTAMP() 
# returns current time with Hrs:Mins:Secs
```
---
### Quiz Solution (Not all 100% correct)

For all projects starting after may, 1, 2010, find the project number and the IDs and names of all workers assigned to
them.

```mysql
select p1.projNO, w1.empID, w1.firstname, w1.lastname
from Project p1
         JOIN Worker w1
              join Assign a1 on p1.projNO = a1.projNO AND w1.empID = a1.empID
where startDate > "05-01-2010";
```

Find the employees names and department manager names of all workers who are not assigned to any project

```mysql
select emp.firstName, emp2.firstName
from Worker emp
         join department dept
         JOIN Worker emp2
              on dept.mgrID = emp2.empid
where emp.empid not in (select empId from assign)
  AND dept.mgrid not in (select empId from assign);
;
```

Get a list of project numbers and names and starting dates of all projects that have the same starting Date.

```mysql
select p1.projNum, p1.projname, p1.stDate
FROM Project p1
         left join Project p2
                   on p1.projNum != p2.projNum AND p1.stDate = p2.stDate;
```

 A relation R (A, B, N, O, P) with the composite key (A, B) means 
that none of the non-key attributes N, O, or P can be determined 
by just A or B.



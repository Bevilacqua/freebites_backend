# Freebites Backend

The backend for the Freebites iOS app.

# Setup

1.  `$ bundle`
2.  `$ rake db:migrate`
3.  Add the file `.env` to the root of this project and add an entry for `DEVISE_JWT_SECRET_KEY`
4.  `rails s`

# Deployment

1.  Add remote from heroku
2.  `git push heroku master`

_Note:_ you must be added as a collaborator on heroku
https://devcenter.heroku.com/articles/git

# API Definition

- Root url: **TODO!**

## 401 errors and user verification

All endpoints with the exception of: 1. [POST /signup](#POST /signup) 2. [POST /signin](#POST /signup)

require a JWT token to be passed in the Authorization header of the request.

The format should be: `Authorization: Bearer JWT_TOKEN_STRING`. You can retrieve a JWT token string by calling [POST /signin](#POST /signup).

If the JWT token is not present or expired (expiration of 365 days) you will receive a 401 error in the following format:

```
{
	"status": 401,
	"message": "You need to sign in or sign up before continuing."
}
```

## User

### POST /signup

Signs up the user.


**Expected JSON format for students:**

```
{
	"email": "test@ucdavis.edu",
	"password": "password"
}
```

**Expected JSON format for organization:**

```
{
	"email": "org@ucdavis.edu",
	"password": "password",
	"name": "ORGANIZATION A",
	"account_type": "organization"
}
```

---

**Successful response (_201_):**

```
{
	"status": 201,
	"user": {
		"id": 8,
		"email": "test@ucdavis.edu",
		"name": null,
		"account_type": "student",
		"created_at": "2018-11-07T10:08:26.976Z",
		"updated_at": "2018-11-07T10:08:26.976Z"
	}
}
```

**Unsuccessful response (_400_):**

```
{
	"status": 400,
	"errors": {
		"status": "400",
		"title": "Bad Request",
		"detail": {
			"email": [
				"has already been taken",
				"has already been taken"
			]
		},
		"code": "100"
	}
}
```

### POST /signin

Sign the user in.

**Expected JSON format:**

```
{
	"user": {
		"email": "test@ucdavis.edu",
		"password": "password"
	}
}
```

---

**Successful response (_200_):**

```
{
	"id": 15,
	"email": "test@ucdavis.edu",
	"name": null,
	"account_type": "student",
	"created_at": "2018-11-07T10:21:19.556Z",
	"updated_at": "2018-11-07T10:22:08.951Z"
}
```

**Unsuccessful response (_401_):**

```
{
	"status": 401,
	"message": "Invalid Email or password."
}
```

### GET /user (show)

Display information about the user.


**Expected JSON format:**
_Empty body_

---

**Successful response (_200_):**

```
{
	"id": 0
	"email": "test@ucdavis.edu",
	"name": null,
	"account_type": "student",
	"created_at": "2018-11-07T10:21:19.556Z"
}
```

## Post _(/post)_


### GET /posts

Get all posts

**Expected JSON format:**

```
{
"active": true,
"expired": false
}
```
---

The active and expired field in the JSON body are optional with default true. If you leave the JSON body empty it is equivalent to getting all records.

**Successful response (_200_):**

```
[
	{
		"id": 11,
		"title": "Raman new",
		"location": "Wellman 211",
		"created_at": "2018-11-08T07:42:59.561Z",
		"active": true,
		"time_left": 1764.929788 # Note this is in seconds
	}
]
```

### GET /posts/:id

_ex: rooturl/post/10_  
Get information about a post

**Expected JSON format:**
_Empty body_

---

**Successful response (_200_):**

```
{
	"id": 8,
	"title": "Raman",
	"description": "Description",
	"location": "Wellman 211",
	"created_at": "2018-11-08T04:03:24.489Z",
	"updated_at": "2018-11-08T04:03:24.489Z",
	"user": {
		"id": 16,
		"email": "test2@ucdavis.edu"
	}
}
```


**Unsuccessful response (_404_):**

```
{
	"status": 404,
	"message": "Post not found with id: 100"
}
```

### POST /posts

Create a new post

**Expected JSON format:**

```
{
	"title": "Burgers",
	"description": "Look at all these burgers!",
	"location": "Wellman 211"
}
```

---

**Successful response (_201_):**

```
{
	"id": 8,
	"title": "Raman",
	"description": "Description",
	"location": "Wellman 211",
	"created_at": "2018-11-08T04:03:24.489Z",
	"updated_at": "2018-11-08T04:03:24.489Z",
	"user": {
		"id": 16,
		"email": "test2@ucdavis.edu"
	}
}
```

**Unsuccessful response (_400_):**

```
{
	"status": 400,
	"message": "Unable to create new post.",
	"errors": {
		"status": "400",
		"title": "Bad Request",
		"detail": {
			"title": [
				"can't be blank"
			]
		},
		"code": "100"
	}
}
```

**Unsuccessful response (_403_):**  
If a student attempts to make a food post

```
{
	"status": 403,
	"message": "Only organizations may create new food posts."
}
```

# Collaborators

- Jacob Bevilacqua
- Thomas Chen
- Lynn Miyashita
- Kim Quach

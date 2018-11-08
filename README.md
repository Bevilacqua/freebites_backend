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

## User

### POST /signup

Signs up the user.

---

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

---

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

**NOTE:** you can retrieve the users JWT token by looking at the responses `Authorization` header. It will be int the format `Bearer JWT_TOKEN_STRING`

**Unsuccessful response (_401_):**

```
{
	"status": 401,
	"message": "Invalid Email or password."
}
```

### GET /user (show)

Display information about the user.

---

**Expected JSON format:**
_Empty body_

**NOTE:** this method requires a signed in user. Send the Authorization header with the bearer token strategy.

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

**Unsuccessful response (_401_):**

```
{
	"status": 401,
	"message": "You need to sign in or sign up before continuing."
}
```

## Post _(/post)_

### GET /posts/:id

_ex: rooturl/post/10_  
Get information about a post

---

**Expected JSON format:**
_Empty body_

**NOTE:** this method requires a signed in user. Send the Authorization header with the bearer token strategy.

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

**Unsuccessful response (_401_):**

```
{
	"status": 401,
	"message": "You need to sign in or sign up before continuing."
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

---

**Expected JSON format:**

```
{
	"title": "Burgers",
	"description": "Look at all these burgers!",
	"location": "Wellman 211"
}
```

**NOTE:** this method requires a signed in user. Send the Authorization header with the bearer token strategy.

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

```

```

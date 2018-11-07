# Freebites Backend

The backend for the Freebites iOS app.

# Setup

1.  `$ bundle`
2.  `$ rake db:migrate`
3.  Add the file `.env` to the root of this project and add an entry for `DEVISE_JWT_SECRET_KEY`
4.  `rails s`

# Deployment

**TODO!**

# API Definition

- Root url: **TODO!**

## User

#### /signup

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

## Post _(/post)_

**TODO!**

# Collaborators

- Jacob Bevilacqua
- Thomas Chen
- Lynn Miyashita
- Kim Quach

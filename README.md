# Freebites Backend

The backend for the Freebites iOS app.

# Setup

1.  `$ bundle`
2.  `$ rake db:migrate`
3.  Add the file `.env` to the root of this project and add an entry for `DEVISE_JWT_SECRET_KEY`
4. 	Obtain AWS credentials and add them to `.env`: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_KEY`, `AWS_REGION`, `S3_BUCKET_NAME`
5. 	Place default image url into `.env` (`DEFAULT_IMAGE_URL`)
6.  `rails s`

# Deployment

1.  Add remote from heroku
2.  `git push heroku master`

_Note:_ you must be added as a collaborator on heroku
https://devcenter.heroku.com/articles/git

# API Definition

- Root url: `https://freebites.herokuapp.com/`

## 401 errors and user verification

All endpoints with the exception of:  
* `POST /signup`
* `POST /login`

require a JWT token to be passed in the Authorization header of the request.

The format should be: `Authorization: Bearer JWT_TOKEN_STRING`. You can retrieve a JWT token string by calling `POST /login` or `POST /signup`.

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
	"email": "test3@ucdavis.edu",
	"password": "password",
	"account_type": "organization",
	"name": "#include"
}
```

---

**Successful response (_201_):**

```
{
	"status": 201,
	"user": {
		"id": 17,
		"email": "test3@ucdavis.edu",
		"name": "#include",
		"account_type": "organization",
		"created_at": "2018-11-08T21:45:59.273Z",
		"updated_at": "2018-11-08T21:45:59.273Z"
	}
}
```
**NOTE:** The JWT token string can be found in the Authorization header of the response.

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

### POST /login

Sign the user in.

**Expected JSON format:**

```
{
	"user": {
		"email": "test3@ucdavis.edu",
		"password": "password"
	}
}
```

---

**Successful response (_200_):**

```
{
	"id": 17,
	"email": "test3@ucdavis.edu",
	"name": "#include",
	"account_type": "organization",
	"created_at": "2018-11-08T21:45:59.273Z",
	"updated_at": "2018-11-08T21:45:59.273Z"
}
```

**NOTE:** The JWT token string can be found in the Authorization header of the response.

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
_Empty body_

---

**Successful response (_200_):**

```
{
	"active": [
		{
			"id": 17,
			"title": "Sushi",
			"location": "Kemper 330",
			"created_at": "2018-11-09T01:56:13.267Z",
			"active": true,
			"time_left": 381.035708,
			"food_image": "https://freebites-images.s3.us-west-1.amazonaws.com/development/post/17/food_image.jpeg",
			"slip_present": false
		},
		{
			"id": 18,
			"title": "Raman",
			"location": "Wellman 211",
			"created_at": "2018-11-09T02:19:16.926Z",
			"active": true,
			"time_left": 1764.690612,
			"food_image": "https://freebites-images.s3.us-west-1.amazonaws.com/development/post/18/food_image.jpeg",
			"slip_present": true
		}
	],
	"expired": [
		{
			"id": 16,
			"title": "Sushi",
			"location": "Kemper 330",
			"created_at": "2018-11-09T01:49:21.033Z",
			"active": false,
			"food_image": "https://freebites-images.s3.us-west-1.amazonaws.com/development/post/16/food_image.png",
			"slip_present": false
		}
	]
}
```

The `time_left` attribute has a unit of seconds. **It is preferable to calculate time left on the front end in order to keep an active countdown!** A maximum of 5 expired posts will be provided.

### GET /posts/:id

_ex: rooturl/post/10_  
Get information about a post

**Expected JSON format:**
_Empty body_

---

**Successful response (_200_):**

```
{
	"id": 18,
	"title": "Raman",
	"description": "Description",
	"location": "Wellman 211",
	"created_at": "2018-11-09T02:19:16.926Z",
	"updated_at": "2018-11-09T02:19:16.926Z",
	"active": true,
	"time_left": 1691.130079,
	"food_image": "https://freebites-images.s3.us-west-1.amazonaws.com/development/post/18/food_image.jpeg",
	"slip_image": "https://freebites-images.s3.us-west-1.amazonaws.com/development/post/18/slip_image.jpeg",
	"slip_present": true,
	"organization": {
		"id": 16,
		"email": "test2@ucdavis.edu",
		"name": null
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
	"title": "Sushi",
	"description": "Litt",
	"location": "Kemper 330",
	"food_image": "data:image/png;base64,iVBO..." 	# food_image param is expected to be in base64
	"slip_image": "data:image/png;base64,iVBO..." 	# slip_image param is expected to be in base64
}
```

---

**Successful response (_201_):**

```
{
	"id": 18,
	"title": "Raman",
	"description": "Description",
	"location": "Wellman 211",
	"created_at": "2018-11-09T02:19:16.926Z",
	"updated_at": "2018-11-09T02:19:16.926Z",
	"active": true,
	"time_left": 1799.389542,
	"food_image": "https://freebites-images.s3.us-west-1.amazonaws.com/development/post/18/food_image.jpeg",
	"slip_image": "https://freebites-images.s3.us-west-1.amazonaws.com/development/post/18/slip_image.jpeg",
	"slip_present": true,
	"organization": {
		"id": 16,
		"email": "test2@ucdavis.edu",
		"name": null
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

### DELETE /posts/:id

_ex: rooturl/post/10_  
Delete a food posting.

**Expected JSON format:**
_Empty body_

---

**Successful response (_204_):**
_Empty body_

**Unsuccessful response (_404_):**
If a user tries to delete a post that no longer exists

```
{
	"status": 404,
	"message": "Post not found with id: 100"
}
```

**Unsuccessful response (_403_):**
If a user tries to delete someone else's post.

```
{
	"status": 403,
	"message": "Current user does not own the post with id: 13"
}
```

# Collaborators

- Jacob Bevilacqua
- Thomas Chen
- Lynn Miyashita
- Kim Quach

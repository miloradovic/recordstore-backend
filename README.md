# About the app

## Recordstore web app


Main reason for this app: Research purpose for Final papers submitted to FON University 

### Architecture of the application

![Web application architecture](public\ArhitekturaAplikacije.png)

To try out app yourself, you need to start Redis server before going with Rails.  
Then using Terminal go inside *recordstore-backend* and type `rails s` to start Rails app.  
Then go inside *recordstore-backend/recordstore-frontend* and type `npm run dev` to start Node that will serve VueJS app.

Rails will work on port:3000  
VueJS will work on port:8080

---
### Few things about backend:

* Ruby version: 2.6.6

* Rails version: 6.0.3

* Also uses: Redis, bcrypt, jwt_sessions

### Few things about frontend:

* Vue.js version: 2.6.12

* bootstrap-vue version: 2.16

* Also uses: Vue-Router, Vuex, Axios

---
### Screenshot of the Vue Artists page

![Screenshot of Vue page](public\Artists.png)

### Screenshot of the ActiveAdmin Home page

![Screenshot of ActiveAdmin Home page](public\Admin-Dashboard.png)
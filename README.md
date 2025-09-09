# 🚀 Laravel Dockerized Development Environment

This repository provides a **Docker Compose setup** for Laravel development.  
It bundles PHP-FPM, Nginx, MySQL, phpMyAdmin, and Mailpit into a single development stack, so you can start coding without worrying about local dependencies.

---

## ✨ Features

- 🐘 **PHP-FPM 8.4** – optimized for Laravel
- 🌐 **Nginx** – fast web server for serving Laravel
- 🗄️ **MySQL 8.0** – relational database
- 🖥️ **phpMyAdmin** – optional database management UI
- 📬 **Mailpit** – optional email testing web interface
- 🔄 Volume mounting for hot reload
- 🧩 Extensible with more services (Redis, Horizon, etc.)

---

## 📋 Prerequisites

Before you start, ensure you have:

- [Docker](https://www.docker.com/get-started) (>= 20.10)
- [Docker Compose](https://docs.docker.com/compose/install/) (>= 2.x)
- Git (optional, if cloning repository)

---

## ⚙️ Setup

#### Automated Setup (New Project)

```
# Create your project directory then go into it:
mkdir -p ~/Sites/laravelapp
cd $_
git clone https://github.com/your-username/docker-laravel.git .

# Run this automated one-liner from the project directory
$ onelinesetup

```

## 🎯 Quick Test

-  Open <a href="http://laravelapp:8080" target="_blank">http://laravelapp:8080</a>  
   → You should see **Laravel’s welcome page**.

-  Go to <a href="http://laravelapp:8081" target="_blank">http://laravelapp:8081</a>  
   → Use **phpMyAdmin** to manage your database.

- Send a test email from Laravel  
   → View it in <a href="http://laravelapp:8025" target="_blank">http://laravelapp:8025</a>.


## 📜 License
[MIT](https://opensource.org/licenses/MIT)
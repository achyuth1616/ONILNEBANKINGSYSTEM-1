# PostgreSQL Setup Quick Reference

## 🌍 Environment Variables for Render

Copy and paste these into your Render dashboard under Environment Variables:

```
# Render PostgreSQL Connection
DB_URL=postgresql://username:password@dpg-xxxxx.onrender.com:5432/bankdb
DB_USERNAME=bankdbuser
DB_PASSWORD=your-strong-password-here
DB_DRIVER=org.postgresql.Driver
DB_DIALECT=org.hibernate.dialect.PostgreSQLDialect

# Application Settings
PORT=8080
APP_BASE_URL=https://your-app-name.onrender.com
FLYWAY_ENABLED=true

# Email Configuration (Gmail SMTP)
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-16-char-app-password
```

## 📊 PostgreSQL Connection String Format

```
postgresql://username:password@host:port/database
```

**Example:**
```
postgresql://postgres:mypassword@dpg-abc123.onrender.com:5432/bankdb
```

## 🐳 Docker Quick Commands

### Start with Docker Compose
```bash
# Build and run everything
docker-compose -f docker-compose.postgres.yml up --build

# Run in background
docker-compose -f docker-compose.postgres.yml up -d --build

# View logs
docker-compose -f docker-compose.postgres.yml logs -f app

# Stop services
docker-compose -f docker-compose.postgres.yml down

# Remove data (fresh start)
docker-compose -f docker-compose.postgres.yml down -v
```

### Build Docker Image
```bash
# Build image
docker build -f Dockerfile.postgres -t online-banking:postgres .

# Run container
docker run -p 8080:8080 \
  -e DB_URL=jdbc:postgresql://host.docker.internal:5432/bankdb \
  -e DB_USERNAME=postgres \
  -e DB_PASSWORD=password \
  online-banking:postgres
```

## 📱 Local PostgreSQL Setup

### Install PostgreSQL
```bash
# macOS
brew install postgresql@15

# Ubuntu/Debian
sudo apt-get install postgresql postgresql-contrib

# Windows
# Download from https://www.postgresql.org/download/windows/
```

### Create Database
```bash
# Login to PostgreSQL
psql -U postgres

# Create database
CREATE DATABASE bankdb;

# Create user
CREATE USER bankdbuser WITH ENCRYPTED PASSWORD 'yourpassword';

# Grant privileges
GRANT ALL PRIVILEGES ON DATABASE bankdb TO bankdbuser;

# Connect to database
\c bankdb

# Exit
\q
```

### Connection String
```
jdbc:postgresql://localhost:5432/bankdb
```

## 🧪 Testing PostgreSQL Connection

### From Command Line
```bash
# Test connection
psql -h localhost -U postgres -d bankdb -c "SELECT 1"

# Get version
psql -h localhost -U postgres -d bankdb -c "SELECT version()"

# List tables
psql -h localhost -U postgres -d bankdb -c "\dt"
```

### From Java (Spring Boot)
```bash
# Build and run locally
mvn spring-boot:run

# Check application logs for:
# "HikariPool-1 - Starting..."
# "Successfully validated X migrations"
# "Hibernate: select 1"
```

## 🚀 Deploy to Render

### Step 1: Create PostgreSQL Database
```
1. Login to Render.com > Dashboard
2. Click "New" > "PostgreSQL"
3. Name: online-banking-db
4. Region: Choose nearest
5. Note the connection details
```

### Step 2: Create Web Service
```
1. Click "New" > "Web Service"
2. Connect GitHub repo or upload code
3. Build Command: mvn clean package -DskipTests
4. Start Command: java -jar target/online-banking-0.0.1-SNAPSHOT.jar
5. Plan: Select your tier
6. Click "Create Web Service"
```

### Step 3: Add Environment Variables
```
1. Go to Web Service > Environment
2. Add all DB_* and MAIL_* variables
3. Click "Save"
4. Service will auto-restart
```

## 📊 Monitor Render Deployment

### View Logs
```
Dashboard > Your Service > Logs

# Look for:
- "Started OnlineBankingApplication"
- "Successfully validated X migrations"
- "Tomcat started on port 8080"
```

### Check Application Health
```bash
# From command line
curl https://your-app-name.onrender.com

# Should return HTML login page
```

### Database Health
```
Dashboard > Your Database > Settings

# Check:
- Status: "Available"
- CPU/Memory usage
- Connections active
```

## 🔧 Common Issues & Fixes

### Issue: "connection refused"
**Check:**
- PostgreSQL is running: `pg_isready -h host -p 5432`
- Firewall allows connections
- Database exists: `psql -l`
- Credentials are correct

### Issue: "Relations does not exist"
**Check:**
- Flyway migrations ran: Check logs for "Successfully validated"
- User has GRANT privileges: `GRANT ALL ON DATABASE bankdb TO user;`
- Schema was created: `psql -c "\d" -d bankdb`

### Issue: "Timeout waiting..."
**Check:**
- Database is running
- Network connectivity: `psql -h host -U user -d db -c "SELECT 1"`
- Render database is in "Available" state

### Issue: Email not sending
**Check:**
- Gmail 2FA enabled
- App password created (16 chars)
- String doesn't contain spaces
- Credentials in environment variables

## 📝 Database Backup

### Backup from Render
```bash
# Render automatically backups daily (check dashboard)
# Manual backup:
pg_dump -h host -U username -d bankdb > backup.sql
```

### Restore from Backup
```bash
# Create fresh database
psql -U postgres -d bankdb -f backup.sql
```

## ⚡ Performance Tips

### PostgreSQL Tuning (optional)
In `application.properties`:
```properties
spring.jpa.properties.hibernate.jdbc.batch_size=10
spring.jpa.properties.hibernate.order_inserts=true
spring.jpa.properties.hibernate.order_updates=true
spring.jpa.properties.hibernate.jdbc.fetch_size=50
```

### Connection Pool
```properties
spring.datasource.hikari.maximum-pool-size=5
spring.datasource.hikari.minimum-idle=2
spring.datasource.hikari.connection-timeout=20000
```

## 📱 Login Test

After deployment:
```
URL: https://your-app-name.onrender.com

Default Credentials:
- Username: yu71
- Password: 53cret
```

## 🆘 Support Resources

- **Render Issues**: https://render.com/support
- **PostgreSQL Issues**: https://www.postgresql.org/support/
- **Spring Boot Issues**: https://spring.io/support
- **Docker Issues**: https://docs.docker.com/support/

## 📋 Pre-Deployment Checklist

- [ ] PostgreSQL database created on Render
- [ ] Connection credentials noted
- [ ] Environment variables configured
- [ ] pom.xml updated (PostgreSQL driver)
- [ ] application.properties updated
- [ ] SQL migrations converted to PostgreSQL
- [ ] Application built locally: `mvn clean package`
- [ ] Docker image tested locally
- [ ] .env.example reviewed
- [ ] RENDER_DEPLOYMENT.md read completely
- [ ] Email credentials configured
- [ ] Deploy command ready

## 🔄 Post-Deployment Checklist

- [ ] Application started successfully
- [ ] Flyway migrations completed
- [ ] Database tables created
- [ ] Application health check passes
- [ ] Login page accessible
- [ ] Test login with yu71 / 53cret
- [ ] Accounts display correctly
- [ ] Deposit/Withdraw works
- [ ] Transactions show
- [ ] Email notifications work (if configured)
- [ ] Monitor logs for errors

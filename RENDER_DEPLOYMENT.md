# Deployment Guide: Render with PostgreSQL

This guide covers the migration from MySQL to PostgreSQL and deployment to Render.

## Changes Made

All files have been updated to support PostgreSQL instead of MySQL:

### 1. **pom.xml** - Updated Dependencies
- ❌ Removed: `mysql-connector-j`
- ❌ Removed: `flyway-mysql`
- ❌ Removed: `testcontainers-mysql`
- ✅ Added: `flyway-postgresql`
- ✅ Added: `testcontainers-postgresql`
- ✅ Kept: PostgreSQL driver (already present)

### 2. **application.properties** - Database Configuration
- Changed default connection URL to PostgreSQL format:
  ```properties
  spring.datasource.url=jdbc:postgresql://localhost:5432/bankdb
  ```
- Changed driver class to: `org.postgresql.Driver`
- Changed dialect to: `org.hibernate.dialect.PostgreSQLDialect`
- Changed default credentials for PostgreSQL

### 3. **SQL Migration Files** - Schema Updates
All 10 migration scripts (V1-V10) have been converted:

#### Syntax Changes:
- `AUTO_INCREMENT` → `BIGSERIAL` (for sequences)
- `SERIAL` → `SERIAL PRIMARY KEY` 
- `bigint(20)` → `BIGINT`
- `int(11)` → `INT`
- `datetime` → `TIMESTAMP`
- `bit(1)` → `BOOLEAN`
- `double` → `double precision`
- `ENGINE=InnoDB`, `DEFAULT CHARSET=utf8` → Removed (PostgreSQL specific)
- `LOCK TABLES` / `UNLOCK TABLES` → Removed (not needed in PostgreSQL)

#### Foreign Key Updates:
- Added explicit index creation using `CREATE INDEX`
- Reserved keyword `user` quoted as `"user"`
- All constraint names prefixed with `fk_`
- Clean `ALTER TABLE` statements with `IF NOT EXISTS` clauses

## Prerequisites

1. **Render Account** - Sign up at https://render.com
2. **PostgreSQL Database** - Create a PostgreSQL database on Render
3. **Java/Maven** - Build the application locally

## Step-by-Step Deployment

### Step 1: Create PostgreSQL Database on Render

1. Go to **Render Dashboard** → **New Database**
2. Select **PostgreSQL**
3. Set the following:
   - **Name**: `online-banking-db`
   - **Region**: Choose closest to you
   - **PostgreSQL Version**: 15+ (recommended)
4. Click **Create Database**
5. Save the connection details (you'll need them in Step 4)

### Step 2: Build the Application

```bash
# Clone or navigate to your project
cd /path/to/Online-banking-angular-springboot-mysql

# Clean and build
mvn clean package -DskipTests

# You should have: target/online-banking-0.0.1-SNAPSHOT.jar
```

### Step 3: Create Web Service on Render

1. Go to **Render Dashboard** → **New Service** → **Web Service**
2. Select **Deploy an existing image** or **Build and deploy from Git**
3. Configure:
   - **Name**: `online-banking-app`
   - **Runtime**: `Docker` (or use `JAR` if available)
   - **Build Command**: `mvn clean package -DskipTests`
   - **Start Command**: `java -jar target/online-banking-0.0.1-SNAPSHOT.jar`
   - **Port**: `8080`

### Step 4: Set Environment Variables

Add these environment variables in Render dashboard:

```env
# Database Configuration
DB_URL=postgresql://<username>:<password>@<host>:<port>/<database>
DB_USERNAME=<postgres_username>
DB_PASSWORD=<postgres_password>
DB_DRIVER=org.postgresql.Driver
DB_DIALECT=org.hibernate.dialect.PostgreSQLDialect

# PostgreSQL specific settings (optional but recommended)
spring.jpa.properties.hibernate.jdbc.batch_size=10
spring.jpa.properties.hibernate.order_inserts=true
spring.jpa.properties.hibernate.order_updates=true

# App Configuration
PORT=8080
APP_BASE_URL=https://<your-app-name>.onrender.com

# Email Configuration
MAIL_USERNAME=<your-email@gmail.com>
MAIL_PASSWORD=<your-app-password>

# Flyway
FLYWAY_ENABLED=true
```

### Step 5: Deploy

1. Connect your GitHub repo (if using Git) or upload the JAR file
2. Render will automatically:
   - Install dependencies
   - Build the application
   - Run database migrations (Flyway)
   - Start the service

### Step 6: Verify Deployment

```bash
# Check application status
curl https://<your-app-name>.onrender.com

# Check logs in Render dashboard
# Navigate to your service → Logs
```

## Environment Variables Reference

| Variable | Value | Required |
|----------|-------|----------|
| `DB_URL` | PostgreSQL connection URL | Yes |
| `DB_USERNAME` | Database username | Yes |
| `DB_PASSWORD` | Database password | Yes |
| `DB_DRIVER` | `org.postgresql.Driver` | Yes |
| `DB_DIALECT` | `org.hibernate.dialect.PostgreSQLDialect` | Yes |
| `PORT` | `8080` | No (default) |
| `MAIL_USERNAME` | Gmail email address | Yes |
| `MAIL_PASSWORD` | Gmail app password | Yes |
| `APP_BASE_URL` | Your Render app URL | No |
| `FLYWAY_ENABLED` | `true` | No |

## Connecting to Render PostgreSQL Database

### From Local Machine (for testing):

```bash
# Install PostgreSQL client tools
# macOS: brew install postgresql
# Windows: Install PostgreSQL from postgresql.org
# Linux: sudo apt-get install postgresql-client

# Connect to your database
psql -h <host> -U <username> -d <database> -p 5432

# Enter your password when prompted
```

### Connection String Format:
```
postgresql://username:password@host:port/database
```

Example:
```
postgresql://myuser:mypassword@dpg-abc123.onrender.com:5432/bankdb
```

## Troubleshooting

### Database Migration Fails

**Problem**: Flyway migrations fail on first run
**Solution**:
1. Check Render logs for specific SQL errors
2. Ensure all reserved keywords (`user`, `role`, etc.) are quoted
3. Verify PostgreSQL version supports all syntax used

### Connection Refused

**Problem**: Application can't connect to database
**Solution**:
1. Verify database is in RUNNING state on Render
2. Check environment variables are correctly set
3. Ensure network access is allowed (no firewall issues)
4. Test connection locally:
   ```bash
   psql -h host -U username -d database -c "SELECT 1"
   ```

### Foreign Key Constraint Issues

**Problem**: Migration fails on foreign key creation
**Solution**:
1. Ensure parent tables are created before child tables
2. Flyway migrations run in order (V1, V2, V3, etc.)
3. Check that quoted table names match: `"user"` vs `user`

## Verify PostgreSQL is Working

After deployment, check:

1. **Connection**: Application logs should show successful database connection
2. **Migrations**: Flyway should show "Successfully validated N migrations"
3. **Web Interface**: Access login page at `https://<app-name>.onrender.com`
4. **Test Login**: Use credentials:
   - Username: `yu71`
   - Password: `53cret`

## Performance Notes for PostgreSQL

The updated migration scripts include optimizations for PostgreSQL:
- Indexes on foreign key columns
- Proper sequence management with BIGSERIAL
- TIMESTAMP for audit logging
- Case-insensitive queries (PostgreSQL default)

## Rollback (If Needed)

If you need to rollback to MySQL:
1. Revert pom.xml changes
2. Revert SQL migration files
3. Update application.properties for MySQL
4. Redeploy

## Additional Resources

- [Render PostgreSQL Documentation](https://render.com/docs/databases)
- [Spring Boot PostgreSQL Guide](https://spring.io/guides/gs/accessing-data-postgresql/)
- [Flyway Migration Guide](https://flywaydb.org/documentation/migrations)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## Support

For issues with:
- **Render Deployment**: https://render.com/support
- **Spring Boot**: https://spring.io/support
- **PostgreSQL**: https://www.postgresql.org/support/

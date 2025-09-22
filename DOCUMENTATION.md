# Spendwise (I2I Fullstack Expense Tracker)
CodeRL Github Brief - Sep 21st 2025  
Github Url  
https://github.com/code-wizard/I2I-Fullstack-Expense-Tracker

## Target Task Categories
- Knowledge Sharing  
- Code Implementation  
- Refactoring  
- Testing and Verification  
- Debugging and Code Correction  
- Performance and Scaling  
- Data and APIs  
- DevOps  
- Security  
- UI/UX  

## Codebase Summary
Spendwise is a modern full-stack expense tracking web application built with Spring Boot, React, and MySQL, designed for efficient day-to-day financial management. It features comprehensive user authentication, multi-role functionality, user-friendly dashboards for transaction management, budget tracking, and financial analytics with advanced search, filter, and pagination capabilities. The application also includes additional microservices for currency conversion and mock advertisements. Below is a summary of the key folders in the I2I Fullstack Expense Tracker repository, explained down to a maximum of two levels from the parent folder.

### Root Level Folders

#### /backend - Spring Boot Backend API
The Spring Boot backend application directory contains the RESTful API built with Spring Boot 3.2.1, integrated with MySQL using JPA/Hibernate. This folder holds the entire server-side codebase including authentication, transaction management, and business logic.

- `src/main/java/com/fullStack/expenseTracker/`: Main source code directory for the Spring Boot application
  - `controllers/`: REST controllers handling HTTP requests and responses for various endpoints
  - `models/`: JPA entity classes defining database table structures and relationships
  - `repository/`: Data access layer interfaces extending JpaRepository for database operations
  - `services/`: Business logic layer containing service classes for core application functionality
  - `security/`: Spring Security configuration for authentication and authorization
  - `dto/`: Data Transfer Objects for request/response mapping and validation
  - `exceptions/`: Custom exception classes and global exception handlers
  - `handlers/`: Event handlers and specialized processing components
  - `factories/`: Factory pattern implementations for object creation
  - `enums/`: Enumeration types for constant values and status definitions
  - `dataSeeders/`: Database initialization and seeding utilities

- `src/main/resources/`: Configuration files and static resources
  - `application.properties`: Spring Boot configuration properties
  - `database_export.sql`: Database schema and initial data export

**Technologies Used in Backend:**
- Spring Boot 3.2.1 (Web, Data JPA, Security, Actuator, Validation, Mail)
- MySQL 8.0 with JPA/Hibernate
- JWT Authentication (JSON Web Tokens)
- Lombok (Code generation)
- Maven (Dependency management)

#### /frontend - React Frontend Application
The React frontend application directory contains the single-page application (SPA) built with React 18, featuring a modern UI for expense tracking and financial management. This folder holds the entire client-side codebase, routing, and component architecture.

- `src/`: Main source code directory for the React application
  - `components/`: Reusable UI components organized by feature areas
    - `sidebar/`: Navigation sidebar components and link management
    - `userDashboard/`: Dashboard widgets including charts, budget displays, and summary boxes
    - `userProfile/`: User profile management components including password change functionality
    - `userTransactions/`: Transaction-related components for forms, lists, and management
    - `utils/`: Utility components and helper functions
  - `pages/`: Top-level page components organized by user roles
    - `welcome.js`: Landing/welcome page component
    - `auth/`: Authentication pages (login, register, forgot password)
    - `user/`: User-specific pages and layouts
    - `admin/`: Administrative interface pages
  - `services/`: API service layers for backend communication
    - `auth.service.js`: Authentication service methods
    - `userService.js`: User-related API calls
    - `adminService.js`: Admin-specific API operations
    - `auth.config.js`: Authentication configuration
  - `hooks/`: Custom React hooks for state and logic reuse
  - `contexts/`: React Context providers for global state management
  - `assets/`: Static assets including images and stylesheets

- `public/`: Static assets served directly by the web server
  - `index.html`: Main HTML template
  - `favicon.ico`: Browser favicon

**Technologies Used in Frontend:**
- React 18.2.0
- React Router DOM (Navigation)
- Axios (HTTP client)
- React Hook Form (Form management)
- Recharts & React Donut Chart (Data visualization)
- React Hot Toast (Notifications)
- React Spinners (Loading indicators)

#### /currency-converter-api - Python Currency Service
A lightweight Python Flask/FastAPI microservice providing real-time currency conversion functionality for the expense tracker application.

- `main.py`: Main application entry point and API endpoints
- `requirements.txt`: Python dependencies specification
- `static_data/`: Static currency data and exchange rates
  - `currencies.json`: Available currency definitions
  - `currency_rates_usd.json`: Exchange rate data relative to USD

#### /mock-ads-api - Python Advertisement Service  
A Python-based microservice that provides mock advertisement data for the application, simulating real advertisement integration.

- `main.py`: Flask/FastAPI application serving advertisement endpoints
- `requirements.txt`: Python package dependencies
- `static_data/ads.json`: Mock advertisement data
- `images/`: Advertisement image assets for various brands

## Local Setup Instructions

### Prerequisites
- **Java Development Kit (JDK) 17** (LTS) - Required for Spring Boot compatibility
- **Node.js 20.x** or higher and npm 10.x or higher
- **MySQL 8.0** or higher
- **Maven 3.6** or higher
- **Python 3.8+** (for microservices)
- Git for version control

### Manual Setup:

#### 1. Clone the repository and navigate to the project directory
```bash
git clone https://github.com/code-wizard/I2I-Fullstack-Expense-Tracker
cd I2I-Fullstack-Expense-Tracker
```

#### 2. Database Setup
**Option A: Local MySQL Installation**
1. Install MySQL 8.0+ and create a database named `expensetracker`
2. Import the database schema:
```bash
mysql -u root -p expensetracker < backend/src/main/resources/database_export.sql
```

**Option B: Docker MySQL (Recommended)**
```bash
docker run -d --name mysql_container \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=expensetracker \
  -e MYSQL_USER=user \
  -e MYSQL_PASSWORD=userpassword \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  mysql:8.0
```

#### 3. Backend Setup:
Navigate to backend directory:
```bash
cd backend
```

Create `application.properties` file (if not exists) with:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/expensetracker
spring.datasource.username=user
spring.datasource.password=userpassword
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
server.port=8080

# JWT Configuration
app.jwtSecret=mySecretKey
app.jwtExpirationInMs=604800000

# Email Configuration (Optional)
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=your_email@gmail.com
spring.mail.password=your_app_password
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
```

Build and run the backend:
```bash
# Using Maven Wrapper (Recommended)
./mvnw clean install
./mvnw spring-boot:run

# Or using system Maven
mvn clean install  
mvn spring-boot:run
```

#### 4. Frontend Setup:
Navigate to frontend directory:
```bash
cd ../frontend
```

Create `.env` file with:
```env
REACT_APP_API_BASE_URL=http://localhost:8080/api
REACT_APP_CURRENCY_API_URL=http://localhost:8001
REACT_APP_ADS_API_URL=http://localhost:8002
```

Install dependencies and start the application:
```bash
npm install
npm start
```

#### 5. Microservices Setup (Optional):
**Currency Converter API:**
```bash
cd currency-converter-api
pip install -r requirements.txt
python main.py
# Runs on http://localhost:8001
```

**Mock Ads API:**
```bash
cd mock-ads-api  
pip install -r requirements.txt
python main.py
# Runs on http://localhost:8002
```

## Quick Start with Docker

### Prerequisites
- Docker 19.03.0+
- Docker Compose

### Build & Run with Docker Compose (Recommended)
1. Clone the repository:
```bash
git clone https://github.com/code-wizard/I2I-Fullstack-Expense-Tracker
cd I2I-Fullstack-Expense-Tracker
```

2. Build and start all services:
```bash
docker-compose up --build -d
```

This will:
- Start MySQL database with persistent data volume
- Start the currency converter API at http://localhost:8001
- Start the mock ads API at http://localhost:8002
- Start the Spring Boot backend at http://localhost:8080
- Start the React frontend at http://localhost:3000

3. Stop the services:
```bash
docker-compose down
```

4. View logs:
```bash
docker-compose logs -f [service_name]
```

### Verification:
- **Frontend Application**: http://localhost:3000
- **Backend API**: http://localhost:8080/api
- **Currency Converter API**: http://localhost:8001
- **Mock Ads API**: http://localhost:8002
- **MySQL Database**: localhost:3306

## Troubleshooting

### Java Version Issues
**Error**: `UnsupportedClassVersionError` or compilation errors  
**Solution**: Ensure you're using JDK 17. Check with:
```bash
java -version
javac -version
```

### MySQL Connection Issues
**Error**: `Communications link failure` or `Access denied`  
**Solutions**:
1. Verify MySQL is running: `sudo service mysql status`
2. Check database credentials in `application.properties`
3. Ensure database `expensetracker` exists
4. Grant proper privileges to the user

### Port Conflicts
**Error**: `Port already in use`  
**Solution**: Check which process is using the port and kill it:
```bash
# Check what's using port 8080
lsof -i :8080
# Kill the process
kill -9 <PID>
```

### Frontend Build Issues
**Error**: Node.js version incompatibility  
**Solution**: Use Node.js 18+ or 20+:
```bash
# Using nvm (recommended)
nvm install 20
nvm use 20
```

### Docker Issues
**Error**: Docker containers not starting  
**Solutions**:
1. Ensure Docker Desktop is running
2. Check for port conflicts
3. Clear Docker cache: `docker system prune -a`
4. Rebuild containers: `docker-compose up --build --force-recreate`

### Database Migration Issues
**Error**: Schema/table creation failures  
**Solution**: Reset database and re-import:
```bash
# Drop and recreate database
mysql -u root -p -e "DROP DATABASE IF EXISTS expensetracker; CREATE DATABASE expensetracker;"
# Re-import schema
mysql -u root -p expensetracker < backend/src/main/resources/database_export.sql
```

## Testing Setup
For email functionality testing, you can use Mailtrap:
1. Sign up at [mailtrap.io](https://mailtrap.io)
2. Create an inbox and get SMTP credentials
3. Update `application.properties` with Mailtrap settings:
```properties
spring.mail.host=sandbox.smtp.mailtrap.io
spring.mail.port=587
spring.mail.username=your_mailtrap_username
spring.mail.password=your_mailtrap_password
```

## Docker File References
Individual Dockerfiles are available for each service:
- Backend: `/backend/Dockerfile`
- Frontend: `/frontend/Dockerfile` 
- Currency Converter: `/currency-converter-Dockerfile`
- Mock Ads: `/mock-ads-Dockerfile`
- Main orchestration: `/docker-compose.yml`

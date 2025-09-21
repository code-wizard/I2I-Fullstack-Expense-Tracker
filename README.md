# Spendwise
A modern expense tracking solution built with Spring Boot, React, and MySQL.

- Created a comprehensive full-stack expense tracking web application, enabling efficient day-to-day financial management.
- Integrated multi-role functionality with user authentication to ensure secure access for both users and administrators, including features such as sign-in, sign-up, password reset, and email verification.
- Designed user-friendly dashboards for managing transactions, tracking upcoming/recurring expenses, generating monthly summaries and statistics, and overseeing budgets.
- Added management features such as search, filter, and pagination for enhanced usability.

## Prerequisites

### Development Tools
- IDE, for example:
  - [Visual Studio Code](https://code.visualstudio.com/)
    - Install extension packs for <b>Java and Spring boot in vscode</b>. These will take care of building the springboot backend.
      - Java Extension Pack: https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack
      - Spring Boot Extension Pack: https://marketplace.visualstudio.com/items?itemName=vmware.vscode-boot-dev-pack
      - Lombok Annotations Support for VS Code: https://marketplace.visualstudio.com/items?itemName=GabrielBB.vscode-lombok
  - [IntelliJ IDEA](https://www.jetbrains.com/idea/) (Community or Ultimate edition)
    - Lombok Plugin (usually pre-installed)
    - Enable Annotation Processing: Settings → Build, Execution, Deployment → Compiler → Annotation Processors

### Backend Requirements
- Java Development Kit (JDK) 17 (LTS) - **Required for compatibility**
- Maven 3.6 or higher

### Frontend Requirements
- [Node.js](https://nodejs.org/) 20.x or higher
- npm 10.x or higher

### Database Requirements
- [MySQL](https://dev.mysql.com/downloads/) 8.0 or higher
- Database Client (optional but recommended):
  - [MySQL Workbench](https://www.mysql.com/products/workbench/)
  - [DBeaver](https://dbeaver.io/) (Universal Database Tool)
  - [TablePlus](https://tableplus.com/)

### Alternative Database Setup (Docker)
- [Docker](https://www.docker.com/products/docker-desktop/) and Docker Compose (included with Docker Desktop)

## Installation Steps

### 1. Setting Up Development Environment

#### Install Git
```bash
# macOS (using Homebrew)
brew install git

# Windows
Download and install from https://git-scm.com/
```

#### Install Java 17 (Required)
```bash
# macOS (using Homebrew) - Recommended approach
brew install openjdk@17

# Set Java 17 as the default (add to ~/.zshrc or ~/.bash_profile)
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

# Windows
Download and install JDK 17 from https://www.oracle.com/java/technologies/downloads/
# Or use Eclipse Temurin: https://adoptium.net/temurin/releases/?version=17
```

#### Install Node.js and npm
```bash
# macOS (using Homebrew)
brew install node

# Windows
Download and install from https://nodejs.org/
```

#### Install MySQL
```bash
# macOS (using Homebrew)
brew install mysql
brew services start mysql

# Windows
Download and install from https://dev.mysql.com/downloads/installer/

# Set up MySQL (if not done during installation)
mysql_secure_installation
```

### 2. Database Setup

#### Option A: Local MySQL Setup (Recommended)
```bash
# 1. Create the database
mysql -u root -p
CREATE DATABASE IF NOT EXISTS expensetracker;
exit

# 2. Import the database schema
mysql -u root -p expensetracker < backend/src/main/resources/database_export.sql

# 3. Verify tables were created
mysql -u root -p -e "USE expensetracker; SHOW TABLES;"
```

#### Option B: Docker Setup (Alternative)
```bash
# Start the MySQL database using Docker Compose
docker-compose up -d
```

### 3. Backend Setup
```bash
# Navigate to the backend directory
cd backend

# Ensure Java 17 is being used
java -version
# Should show: openjdk version "17.x.x"

# Clean and compile the project
mvn clean compile

# Run the Spring Boot application
mvn spring-boot:run
```

**Note**: The backend will start on `http://localhost:8080`

### 4. Frontend Setup
```bash
# Navigate to the frontend directory
cd frontend

# Install dependencies
npm install

# Start the development server
npm start
```

**Note**: The frontend will start on `http://localhost:3000`

### 5. Test the Application
You can log in using the following users:
- admin@gmail.com / testing1234
- user@gmail.com / testing 1234

## Verifying Installation

1. Backend API should be running on `http://localhost:8080`
2. Frontend application should be accessible at `http://localhost:3000`
3. MySQL database should be running on port `3306`

## Key Configuration Changes for Local Development

This project has been optimized for local development with the following key changes:

### Backend Configuration Updates
- **Java Version**: Upgraded from Java 21 to Java 17 (LTS) for better compatibility
- **Maven Compiler**: Updated to version 3.11.0 with proper Lombok annotation processing
- **Lombok Support**: Enhanced annotation processor configuration to resolve compilation issues
- **Database**: Supports both local MySQL and Docker-based MySQL setup

### Build Configuration
The `pom.xml` has been updated with:
- Java 17 compatibility settings
- Enhanced Lombok annotation processor paths
- Updated Maven compiler plugin for better Java 17 support

### Database Schema
- Complete database schema is provided in `backend/src/main/resources/database_export.sql`
- Includes all necessary tables: users, roles, categories, transactions, budgets, etc.
- Pre-populated with initial data for testing

## Common Issues and Troubleshooting

### Java-related Issues
1. **Java Version Compatibility**: This project requires Java 17. If you have multiple Java versions:
   ```bash
   # Check current Java version
   java -version
   
   # Set Java 17 for current session
   export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
   
   # Make it permanent (add to ~/.zshrc or ~/.bash_profile)
   echo 'export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home' >> ~/.zshrc
   echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
   ```

2. **Lombok Issues**: If you encounter "cannot find symbol" errors for getters/setters:
   ```bash
   cd backend
   mvn clean compile
   ```

### Database Issues
3. **MySQL Connection**: Verify MySQL is running:
   ```bash
   # Check if MySQL is running
   brew services list | grep mysql
   # or
   sudo systemctl status mysql
   ```

4. **Database Schema**: If tables are missing:
   ```bash
   mysql -u root -p expensetracker < backend/src/main/resources/database_export.sql
   ```

### Application Issues
5. **Port Conflicts**: Ensure ports 8080, 3000, and 3306 are not in use by other applications
6. **Maven Build Issues**: Clean and rebuild:
   ```bash
   cd backend
   mvn clean install
   ```

7. **Frontend Dependencies**: If npm install fails:
   ```bash
   cd frontend
   rm -rf node_modules package-lock.json
   npm install
   ```

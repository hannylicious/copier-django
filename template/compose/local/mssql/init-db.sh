#!/bin/bash
set -e

echo "Waiting for SQL Server to be ready..."
until /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -Q "SELECT 1" &>/dev/null; do
    echo "SQL Server is unavailable - sleeping"
    sleep 5
done

echo "SQL Server is up - executing init script"

# Create database if MSSQL_DB is set
# The essential idea for this script is originally taken from the
# `run_custom_setup.sh` script present in 2022-latest image.
if [ -n "$MSSQL_DB" ]; then
    echo "Creating database $MSSQL_DB"
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -Q "CREATE DATABASE [$MSSQL_DB]"

    # Create user if MSSQL_USER is set and not 'sa'
    if [[ -n "$MSSQL_USER" && "$MSSQL_USER" != "sa" ]]; then
        echo "Creating login $MSSQL_USER"
        /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -Q "
            CREATE LOGIN [$MSSQL_USER] WITH PASSWORD = '$MSSQL_PASSWORD';
            USE [$MSSQL_DB];
            CREATE USER [$MSSQL_USER] FROM LOGIN [$MSSQL_USER];
            ALTER ROLE db_owner ADD MEMBER [$MSSQL_USER];
        "
    fi
fi

echo "Database initialization complete"

#!/bin/bash
#
# This script executes the custom setup phase that runs after the SQL Server process has started.
#

SQLCMD=/opt/mssql-tools18/bin/sqlcmd
if [ ! -x $SQLCMD ]; then
    SQLCMD=/opt/mssql-tools/bin/sqlcmd
    if [ ! -x $SQLCMD ]; then
        echo "sqlcmd not available at $SQLCMD, unable to execute custom setup."
        exit 1
    fi
fi

SQLCMD_SA="$SQLCMD -C -U sa -P $MSSQL_SA_PASSWORD"

function IsSqlServerReady {
    IS_SERVER_READY_QUERY='SET NOCOUNT ON; Select SUM(state) from sys.databases'
    dbStatus=$($SQLCMD_SA -h -1 -Q "$IS_SERVER_READY_QUERY" 2>/dev/null)
    errCode=$?
    if [[ "$errCode" -eq "0" && "$dbStatus" -eq "0" ]]; then
        return 0
    else
        return 1
    fi
}

echo "Waiting for Sql Server to be ready before executing custom setup"
until IsSqlServerReady; do
    sleep 5
done

if [ -n "$MSSQL_DB" ]; then
    echo "Creating database $MSSQL_DB"
    $SQLCMD_SA -Q "CREATE DATABASE [$MSSQL_DB]"

    if [[ -n $MSSQL_USER && "$MSSQL_USER" != "sa" ]]; then
        echo "Creating login $MSSQL_USER with password defined in MSSQL_PASSWORD environment variable"

        cmd="CREATE LOGIN $MSSQL_USER WITH PASSWORD = '$MSSQL_PASSWORD';"
        cmd+="USE $MSSQL_DB;"
        cmd+="CREATE USER $MSSQL_USER FROM LOGIN $MSSQL_USER;"
        cmd+="GRANT CONTROL to $MSSQL_USER;"
        $SQLCMD_SA -Q "$cmd"
    fi
fi

if [ -n "${MSSQL_SETUP_SCRIPTS_LOCATION}" ]; then
    for file in $MSSQL_SETUP_SCRIPTS_LOCATION/*; do
        echo "Executing custom setup script $file"
        $SQLCMD_SA -i $file
    done
fi

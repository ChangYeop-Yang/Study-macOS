/*
 * Copyright (c) 2019 양창엽. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SQLite3
import Foundation

/// Open SQLite Database
private func openSQLite(path: String) -> OpaquePointer? {
    
    var database: OpaquePointer? = nil
    
    // Many of the SQLite functions return an Int32 result code. Most of these codes are defined as constants in the SQLite library. For example, SQLITE_OK represents the result code 0.
    guard sqlite3_open(path, &database) == SQLITE_OK else {
        print("‼️ Unable to open database.")
        return nil
    }
    
    // Success Open SQLite Database
    print("✅ Successfully opened connection to database at \(path)")
    return database
}

/// Create SQLite Database Table
private func createSQLiteTable(database: OpaquePointer, statement: String) -> Bool {
    
    var createStatement: OpaquePointer? = nil
    
    // You must always call sqlite3_finalize() on your compiled statement to delete it and avoid resource leaks.
    defer { sqlite3_finalize(createStatement) }
        
    guard sqlite3_prepare_v2(database, statement, EOF, &createStatement, nil) == SQLITE_OK else {
        print("‼️ CREATE TABLE statement could not be prepared.")
        return false
    }
    
    // sqlite3_step() runs the compiled statement.
    if sqlite3_step(createStatement) == SQLITE_DONE {
        print("✅ Success, Contact table created.")
    } else {
        print("‼️ Fail, Contact table could not be created.")
    }
    
    return true
}

/// Insert Data into SQLite Database Table
private func insertSQLiteTable(database: OpaquePointer, statement: String) -> Bool {
    
    var insertStatement: OpaquePointer? = nil
    
    // You must always call sqlite3_finalize() on your compiled statement to delete it and avoid resource leaks.
    defer { sqlite3_finalize(insertStatement) }
    
    guard sqlite3_prepare_v2(database, statement, EOF, &insertStatement, nil) == SQLITE_OK else {
        print("‼️ Insert TABLE statement could not be prepared.")
        return false
    }
    
    // Use the sqlite3_step() function to execute the statement and verify that it finished.
    if sqlite3_step(insertStatement) == SQLITE_DONE {
        print("✅ Success, Insert Data.")
    } else {
        print("‼️ Fail, Insert Data.")
    }
    
    return true
}

/// Implement Query SQLite
private func qeurySQLite(database: OpaquePointer, statment: String) -> Bool {
    
    var queryStatment: OpaquePointer? = nil
    
    // You must always call sqlite3_finalize() on your compiled statement to delete it and avoid resource leaks.
    defer { sqlite3_finalize(queryStatment) }
    
    guard sqlite3_prepare_v2(database, statment, EOF, &queryStatment, nil) == SQLITE_OK else {
        print("‼️ Query statement could not be prepared.")
        return false
    }
    
    while sqlite3_step(queryStatment) == SQLITE_ROW {
        
        let id = sqlite3_column_int(queryStatment, 0)
        let name = sqlite3_column_text(queryStatment, 1)
        
        print("→ \(id) | \(String(describing: name))")
    }
    
    return true
}

guard let db = openSQLite(path: "/Users/yangchang-yeob/Downloads/sqlite.db") else {
    assert(false, "‼️ Fail, Open SQLite Database.")
}

let createStatment: String = """
CREATE TABLE Contact (
id INT PRIMARY KEY NOT NULL,
name CHAR(255)
);
"""

if createSQLiteTable(database: db, statement: createStatment) {
    print("✅ Success, Create SQLite Table.")
}

let insertStatment: String = "INSERT INTO Contact (id, name) VALUES (10, 'CHCH');"
if insertSQLiteTable(database: db, statement: insertStatment) {
    print("✅ Success, Insert data into SQLite Table.")
}

let queryStatment: String = "SELECT * FROM Contact;"
if qeurySQLite(database: db, statment: queryStatment) {
    print("✅ Success, Query SQLite.")
}

#define SQLITE_OK           0   /* Successful result */
/* beginning-of-error-codes */
#define SQLITE_ERROR        1   /* Generic error */
#define SQLITE_INTERNAL     2   /* Internal logic error in SQLite */
#define SQLITE_PERM         3   /* Access permission denied */
#define SQLITE_ABORT        4   /* Callback routine requested an abort */
#define SQLITE_BUSY         5   /* The database file is locked */
#define SQLITE_LOCKED       6   /* A table in the database is locked */
#define SQLITE_NOMEM        7   /* A malloc() failed */
#define SQLITE_READONLY     8   /* Attempt to write a readonly database */
#define SQLITE_INTERRUPT    9   /* Operation terminated by sqlite3_interrupt()*/
#define SQLITE_IOERR       10   /* Some kind of disk I/O error occurred */
#define SQLITE_CORRUPT     11   /* The database disk image is malformed */
#define SQLITE_NOTFOUND    12   /* Unknown opcode in sqlite3_file_control() */
#define SQLITE_FULL        13   /* Insertion failed because database is full */
#define SQLITE_CANTOPEN    14   /* Unable to open the database file */
#define SQLITE_PROTOCOL    15   /* Database lock protocol error */
#define SQLITE_EMPTY       16   /* Internal use only */
#define SQLITE_SCHEMA      17   /* The database schema changed */
#define SQLITE_TOOBIG      18   /* String or BLOB exceeds size limit */
#define SQLITE_CONSTRAINT  19   /* Abort due to constraint violation */
#define SQLITE_MISMATCH    20   /* Data type mismatch */
#define SQLITE_MISUSE      21   /* Library used incorrectly */
#define SQLITE_NOLFS       22   /* Uses OS features not supported on host */
#define SQLITE_AUTH        23   /* Authorization denied */
#define SQLITE_FORMAT      24   /* Not used */
#define SQLITE_RANGE       25   /* 2nd parameter to sqlite3_bind out of range */
#define SQLITE_NOTADB      26   /* File opened that is not a database file */
#define SQLITE_NOTICE      27   /* Notifications from sqlite3_log() */
#define SQLITE_WARNING     28   /* Warnings from sqlite3_log() */
#define SQLITE_ROW         100  /* sqlite3_step() has another row ready */
#define SQLITE_DONE        101  /* sqlite3_step() has finished executing */
/* end-of-error-codes */
#define SQLITE_OK           0   /* Successful result */
/* beginning-of-error-codes */
#define SQLITE_ERROR        1   /* Generic error */
#define SQLITE_INTERNAL     2   /* Internal logic error in SQLite */
#define SQLITE_PERM         3   /* Access permission denied */
#define SQLITE_ABORT        4   /* Callback routine requested an abort */
#define SQLITE_BUSY         5   /* The database file is locked */
#define SQLITE_LOCKED       6   /* A table in the database is locked */
#define SQLITE_NOMEM        7   /* A malloc() failed */
#define SQLITE_READONLY     8   /* Attempt to write a readonly database */
#define SQLITE_INTERRUPT    9   /* Operation terminated by sqlite3_interrupt()*/
#define SQLITE_IOERR       10   /* Some kind of disk I/O error occurred */
#define SQLITE_CORRUPT     11   /* The database disk image is malformed */
#define SQLITE_NOTFOUND    12   /* Unknown opcode in sqlite3_file_control() */
#define SQLITE_FULL        13   /* Insertion failed because database is full */
#define SQLITE_CANTOPEN    14   /* Unable to open the database file */
#define SQLITE_PROTOCOL    15   /* Database lock protocol error */
#define SQLITE_EMPTY       16   /* Internal use only */
#define SQLITE_SCHEMA      17   /* The database schema changed */
#define SQLITE_TOOBIG      18   /* String or BLOB exceeds size limit */
#define SQLITE_CONSTRAINT  19   /* Abort due to constraint violation */
#define SQLITE_MISMATCH    20   /* Data type mismatch */
#define SQLITE_MISUSE      21   /* Library used incorrectly */
#define SQLITE_NOLFS       22   /* Uses OS features not supported on host */
#define SQLITE_AUTH        23   /* Authorization denied */
#define SQLITE_FORMAT      24   /* Not used */
#define SQLITE_RANGE       25   /* 2nd parameter to sqlite3_bind out of range */
#define SQLITE_NOTADB      26   /* File opened that is not a database file */
#define SQLITE_NOTICE      27   /* Notifications from sqlite3_log() */
#define SQLITE_WARNING     28   /* Warnings from sqlite3_log() */
#define SQLITE_ROW         100  /* sqlite3_step() has another row ready */
#define SQLITE_DONE        101  /* sqlite3_step() has finished executing */
/* end-of-error-codes */

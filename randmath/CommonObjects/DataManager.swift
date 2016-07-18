//
//  DataManager.swift
//  randmath
//
//  Created by Vineeth Vijayan on 26/04/16.
//  Copyright © 2016 Vineeth Vijayan. All rights reserved.
//

import Foundation
import SQLite
import SwiftFilePath
import EZSwiftExtensions

class DataManager {
    internal static var con: Connection!
    internal static var currentAppDBVersionMannual: Int = 1
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true
            ).first!
        print(path)
        DataManager.con = try! Connection("\(path)/db.sqlite3")
        CreateDataBase()
    }
    
    internal static func dropCreateDataBase() {
        
        let path = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true
            ).first
        
        if Path(path! + "/db.sqlite3").exists == true {
            Path(path! + "/db.sqlite3").remove()
        }
        else {
            print("not exist")
        }
    }
    
    func CreateDataBase() {
        let strDataBaseVersion = "DataBaseVersion"
        
        let table = Table(strDataBaseVersion)
        if !DataManager.con.tableExists(strDataBaseVersion) {
            let DataBaseVersion = Expression<String?>(strDataBaseVersion)
            
            try! DataManager.con.run(table.create { t in
                t.column(DataBaseVersion)
                })
            
            let bindStmt = try! DataManager.con.prepare("INSERT INTO " + strDataBaseVersion + " (" + strDataBaseVersion + ") values (?)")
            
            try! DataManager.con.transaction(block: { _ in
                var bindings: [Binding?] = []
                bindings.append("0")
                try! bindStmt.run(bindings)
            })
            
            DataBaseCreateVersion_1()
        }
        else {
            let DataBaseVersion = Expression<String?>(strDataBaseVersion)
            
            var appDBVersion: Int = 0
            for row in try! DataManager.con.prepare(table) {
                let strVer = (row[DataBaseVersion]) == nil ? "" : (row[DataBaseVersion])!
                appDBVersion = strVer.toInt()!
            }
            if appDBVersion == DataManager.currentAppDBVersionMannual {
                return
            }
            else {
                for index in appDBVersion ... DataManager.currentAppDBVersionMannual {
                    if index < 1 {
                        DataBaseCreateVersion_1()
                        continue
                    }
                }
            }
        }
    }
    
    func updateTableVersion(ver : String) {
        let table = Table("DataBaseVersion")
        let DataBaseVersion = Expression<String?>("DataBaseVersion")
        _ = try! DataManager.con.run(table.update(DataBaseVersion <- ver))
    }
    
    func DataBaseCreateVersion_1() {
        updateTableVersion("1")
    }
}

extension Connection {
    func tableExists(tableName: String) -> Bool {
        let count: Int64 = DataManager.con.scalar(
            "SELECT EXISTS(SELECT name FROM sqlite_master WHERE name = ?)", tableName
            ) as! Int64
        if count > 0 {
            return true
        }
        else {
            return false
        }
    }
}
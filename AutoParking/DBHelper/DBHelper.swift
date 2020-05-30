//
//  DBHelper.swift
//  AutoParking
//
//  Created by Heber Echeverria on 5/28/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//


import Foundation
import FMDB

class DBHelper:NSObject {
    
    //Tipo Vehiculo
    let tpId        = "id"
    let tpType      = "tipo"
    
    //Tipo Vehiculo
    let pId        = "id"
    let pTipo      = "tipo"
    let pPlaca     = "placa"
    let pNombreTipo = "nombretipo"
    
    var database: FMDatabase!
    let util = Util()
    override init() {
        super.init()
        
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            let fileURL = try! FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("databse.sqlite")
            
            database = FMDatabase(url: fileURL)
            print("open database ",database.databaseURL!)
            
            // Open the database.
            if database.open() {
                
                
                let createTipoVehiculo = "CREATE TABLE IF NOT EXISTS 'TipoVehiculo' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'tipo' TEXT)"
                
                let createPlacaVehiculo = "CREATE TABLE IF NOT EXISTS 'Placa' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'placa' TEXT, 'tipo' INTEGER)"
                
                let createRegistro = "CREATE TABLE IF NOT EXISTS 'Registro' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'idplaca' INTEGER, 'entrada' INTEGER, 'salida' INTEGER, 'estado' INTEGER, 'intervalo' INTEGER)"
                
                
                
                do {
                    try database.executeUpdate(createTipoVehiculo, values: nil)
                    try database.executeUpdate(createPlacaVehiculo, values: nil)
                    try database.executeUpdate(createRegistro, values: nil)
                    
                    
                    if util.usage() == false {
                        util.savePeriodo()
                        let querya = "INSERT INTO TipoVehiculo (tipo) VALUES ('Oficial')"
                        let queryb = "INSERT INTO TipoVehiculo (tipo) VALUES ('Residente')"
                        let queryc = "INSERT INTO TipoVehiculo (tipo) VALUES ('Visita')"
                        try database.executeUpdate(querya, values: nil)
                        try database.executeUpdate(queryb, values: nil)
                        try database.executeUpdate(queryc, values: nil)
                        
                        let p1 = "INSERT INTO Placa (placa,tipo) VALUES ('P 234 3','2')"
                        try database.executeUpdate(p1, values: nil)
                        let p2 = "INSERT INTO Placa (placa,tipo) VALUES ('P 154 2','2')"
                        try database.executeUpdate(p2, values: nil)
                        let p3 = "INSERT INTO Placa (placa,tipo) VALUES ('P 293 5','1')"
                        try database.executeUpdate(p3, values: nil)
                        let p4 = "INSERT INTO Placa (placa,tipo) VALUES ('P 234 567','2')"
                        try database.executeUpdate(p4, values: nil)
                        let p5 = "INSERT INTO Placa (placa,tipo) VALUES ('P 238 68','2')"
                        try database.executeUpdate(p5, values: nil)
                        let p6 = "INSERT INTO Placa (placa,tipo) VALUES ('P 939 5','3')"
                        try database.executeUpdate(p6, values: nil)
                        let p7 = "INSERT INTO Placa (placa,tipo) VALUES ('P 434 567','2')"
                        try database.executeUpdate(p7, values: nil)
                        let p8 = "INSERT INTO Placa (placa,tipo) VALUES ('P 234 5','2')"
                        try database.executeUpdate(p8, values: nil)
                        let p9 = "INSERT INTO Placa (placa,tipo) VALUES ('P 534 67','1')"
                        try database.executeUpdate(p9, values: nil)
                        let p10 = "INSERT INTO Placa (placa,tipo) VALUES ('P 634 57','2')"
                        try database.executeUpdate(p10, values: nil)
                        
                    }
                    
                }
                catch {
                    print("Could not create table.")
                    print(error.localizedDescription)
                }
                database.close()
            }
            else {
                print("Could not open the database.")
            }
        }
        if !database.isOpen {
            database.open()
        }
        return true
    }
    
    
    
    func getTipo() -> [Tipo] {
        
        var tipos : [Tipo] = []
        let query = "SELECT * FROM TipoVehiculo ORDER BY id DESC"
        if openDatabase() {
            do {
                let results = try database.executeQuery(query, values: nil)
                while results.next() == true {
                    let rowId       = results.int(forColumn: tpId)
                    let rowTitle    = results.string(forColumn: tpType)
                    let tipo = Tipo()
                    tipo.id = Int(rowId)
                    tipo.tipo = rowTitle!
                    tipos.append(tipo)
                    print(tipo.id)
                }
                
                print(tipos)
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        return tipos
        
    }
    
    
    func saveTipo(tipo : String) {
        if openDatabase() {
            let query = "INSERT INTO TipoVehiculo (tipo) VALUES (?)"
            do {
                try database.executeUpdate(query, values: [tipo])
                
            } catch {
                print("error \(error)")
            }
            database.close()
        }
    }
    
    func updateNote(tipo : Tipo) {
        if openDatabase() {
            let query = "UPDATE List SET title = ?, body = ?, date = ? WHERE id = ?"
            do {
                try database.executeUpdate(query, values: [tipo.tipo])
                
            } catch {
                print("error \(error)")
            }
            database.close()
        }
    }
    func deleteTipo(idTipo : Int) {
        if openDatabase() {
            let query = "DELETE FROM TipoVehiculo WHERE id = ?"
            do {
                try database.executeUpdate(query, values: [idTipo])
                
            } catch {
                print("error \(error)")
            }
            database.close()
        }
    }
    
    func getPlaca() -> [SearchPlaca] {
        
        var placas : [SearchPlaca] = []
        let query = "SELECT p.id, p.placa, p.tipo AS tipo, t.tipo AS nombretipo FROM Placa as p JOIN TipoVehiculo as t ON p.tipo = t.id ORDER BY p.id DESC"
        if openDatabase() {
            do {
                let results = try database.executeQuery(query, values: nil)
                while results.next() == true {
                    let rowId       = results.int(forColumn: pId)
                    let rowPlaca    = results.string(forColumn: pPlaca)
                    let rowTipo    = results.string(forColumn: pNombreTipo)
                    let placa = SearchPlaca()
                    placa.id         = Int(rowId)
                    placa.placa      = rowPlaca!
                    placa.nombreTipo = rowTipo!
                    placas.append(placa)
                    print(rowId)
                }
                
                print(placas)
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        return placas
        
    }
    
    func savePlaca(placa : Placa) {
        if openDatabase() {
            let query = "INSERT INTO Placa (placa, tipo) VALUES (?,?)"
            do {
                try database.executeUpdate(query, values: [placa.placa,placa.tipo])
                
            } catch {
                print("error \(error)")
            }
            database.close()
        }
    }
    
    func deletePlaca(id : Int) {
        if openDatabase() {
            let query = "DELETE FROM Placa WHERE id = ?"
            do {
                try database.executeUpdate(query, values: [id])
                
            } catch {
                print("error \(error)")
            }
            database.close()
        }
    }
    
    
    func getSearchPlaca(search : String) -> [SearchPlaca] {
        var query = ""
        var value = ""
        
        if search == "" {
            query = "SELECT p.id, p.placa, p.tipo AS tipo, t.tipo AS nombretipo FROM Placa as p JOIN TipoVehiculo as t ON p.tipo = t.id ORDER BY p.id DESC"
            value = ""
        }else{
            
            query = "SELECT p.id, p.placa, p.tipo AS tipo, t.tipo AS nombretipo FROM Placa as p JOIN TipoVehiculo as t ON p.tipo = t.id WHERE p.placa LIKE ? ORDER BY p.id DESC"
            value = "%\(search)%"
            
        }
        
        
        
        
        var placas : [SearchPlaca] = []
        
        if openDatabase() {
            do {
                let results = try database.executeQuery(query, values: [value])
                while results.next() == true {
                    let rowId       = results.int(forColumn: pId)
                    let rowPlaca    = results.string(forColumn: pPlaca)
                    let rowTipo    = results.string(forColumn: pNombreTipo)
                    let placa = SearchPlaca()
                    placa.id         = Int(rowId)
                    placa.placa      = rowPlaca!
                    placa.nombreTipo = rowTipo!
                    placas.append(placa)
                    print(rowPlaca)
                }
                
                print(placas)
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        return placas
        
    }
    
    func getRegistros(idPlaca : Int, last : Bool) -> [Registros] {
        let fact = util.getPeriodo()
        let inicio = Int(fact["inicio"]!.timeIntervalSince1970)
        
        var regs : [Registros] = []
        var query = "SELECT * FROM Registro WHERE idplaca = ? AND entrada > ? ORDER BY id DESC"
        if last {
            query = query + " LIMIT 1"
        }
        
        if openDatabase() {
            do {
                let results = try database.executeQuery(query, values: [idPlaca,inicio])
                while results.next() == true {
                    let rowId       = results.int(forColumn: "id")
                    let rowIdPlaca  = results.int(forColumn: "idplaca")
                    let rowEntrada  = results.int(forColumn: "entrada")
                    let rowSalida   = results.int(forColumn: "salida")
                    let rowEstado   = results.int(forColumn: "estado")
                    let rowIntervalo = results.int(forColumn: "intervalo")
                    let reg = Registros()
                    reg.id      = Int(rowId)
                    reg.idPlaca = Int(rowIdPlaca)
                    reg.entrada = Int(rowEntrada)
                    reg.salida  = Int(rowSalida)
                    reg.estado  = Int(rowEstado)
                    reg.intervalo  = Int(rowIntervalo)
                    regs.append(reg)
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        return regs
        
    }
    
    
    func registroEntrada(reg : Registros) {
        if openDatabase() {
            let query = "INSERT INTO Registro (idplaca, entrada, estado) VALUES (?,?,?)"
            do {
                try database.executeUpdate(query, values: [reg.idPlaca, reg.entrada, reg.estado])
                
            } catch {
                print("error \(error)")
            }
            database.close()
        }
    }
    func registroSalida(reg : Registros) {
        if openDatabase() {
            let query = "UPDATE Registro SET salida = ?, estado = ?, intervalo = ? WHERE id = ?"
            do {
                try database.executeUpdate(query, values: [reg.salida, reg.estado, reg.intervalo, reg.id])
                
            } catch {
                print("error \(error)")
            }
            database.close()
        }
    }
    func getInformes(placa : Int, search : Bool) -> [Registros] {
        let fact = util.getPeriodo()
        let inicio = Int(fact["inicio"]!.timeIntervalSince1970)
        print(inicio)
        var values : [Any] = []
        var regs : [Registros] = []
        
        
        var query = ""
        if search {
            query = "SELECT r.id AS rid,r.idplaca, r.entrada, r.salida, r.estado, SUM(r.intervalo) AS intervalo, p.placa,t.tipo FROM Registro AS r JOIN Placa as p ON p.id = r.idplaca JOIN TipoVehiculo as t ON p.tipo = t.id WHERE r.idplaca = ? AND entrada > ? GROUP BY r.idplaca ORDER BY r.id DESC"
            //SELECT r. id AS rid,r.idplaca, r.entrada, r.salida, r.estado, SUM(r.intervalo), p.placa FROM Registro AS r JOIN Placa as p ON p.id = r.idplaca WHERE r.idplaca = ? AND entrada > ? GROUP BY r.idplaca ORDER BY r.id DESC
            values = [placa,inicio]
        }else{
            query = "SELECT r.id AS rid,r.idplaca, r.entrada, r.salida, r.estado, SUM(r.intervalo) AS intervalo, p.placa,t.tipo FROM Registro AS r JOIN Placa as p ON p.id = r.idplaca JOIN TipoVehiculo as t ON p.tipo = t.id WHERE entrada > ? GROUP BY r.idplaca ORDER BY r.id DESC"
            values = [inicio]
        }
        // "SELECT p.id, p.placa FROM Placa as p JOIN TipoVehiculo as t ON p.tipo = t.id ORDER BY p.id DESC"
        if openDatabase() {
            do {
                let results = try database.executeQuery(query, values: values)
                while results.next() == true {
                    let rowId       = results.int(forColumn: "rid")
                    let rowIdPlaca  = results.int(forColumn: "idplaca")
                    let rowPlaca    = results.string(forColumn: "placa")
                    let rowEntrada  = results.int(forColumn: "entrada")
                    let rowSalida   = results.int(forColumn: "salida")
                    let rowEstado   = results.int(forColumn: "estado")
                    let rowIntervalo = results.int(forColumn: "intervalo")
                    let rowTipo    = results.string(forColumn: "tipo")
                    let reg = Registros()
                    reg.id      = Int(rowId)
                    reg.idPlaca = Int(rowIdPlaca)
                    reg.placa   = rowPlaca!
                    reg.entrada = Int(rowEntrada)
                    reg.salida  = Int(rowSalida)
                    reg.estado  = Int(rowEstado)
                    reg.intervalo  = Int(rowIntervalo)
                    reg.tipo   = rowTipo!
                    regs.append(reg)
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        return regs
        
    }
}

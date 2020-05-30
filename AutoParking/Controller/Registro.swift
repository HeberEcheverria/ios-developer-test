//
//  Registro.swift
//  AutoParking
//
//  Created by Heber Echeverria on 5/29/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import UIKit

class Registro: UIViewController {
    var objPlaca = SearchPlaca()
    let db = DBHelper()
    let util = Util()
    
    @IBOutlet weak var btnTipo: UIButton!
    @IBOutlet weak var txtPlaca: UITextField!
    @IBOutlet weak var lblEntrada: UILabel!
    @IBOutlet weak var lblSalida: UILabel!
    @IBOutlet weak var lblIntervalo: UILabel!
    @IBOutlet weak var lblAcumulado: UILabel!
    @IBOutlet weak var lblCosto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(objPlaca.id)
        getRegistro()
        
        txtPlaca.text = objPlaca.placa
        btnTipo.setTitle(objPlaca.nombreTipo, for: .normal)
    }
    
    @IBAction func btnTipo(_ sender: Any) {
        
    }
    
    @IBAction func btnEntrada(_ sender: Any) {
        
        let last = getRegistro()
        if last.estado == 1 {
            util.showAlert(title: "Vehiculo actualmente dentro", msg: "", delegate: self)
        }else{
            let reg = Registros()
            reg.entrada = getTimeStamp()
            reg.estado = 1
            reg.idPlaca = objPlaca.id
            db.registroEntrada(reg: reg)
            getRegistro()
            
        }
        
        
        
        
        
        
    }
    
    @IBAction func btnSalida(_ sender: Any) {
        
        let last = getRegistro()
        if last.estado == 1 {
            
            let interval    = getTimeStamp() - last.entrada
            let reg = Registros()
            reg.salida  = getTimeStamp()
            reg.estado  = 2
            reg.id      = last.id
            reg.intervalo = interval
            db.registroSalida(reg: reg)
            showTicket(obj: getRegistro())
        }else{
            util.showAlert(title: "No se ha registrado entrada de este vehiculo", msg: "", delegate: self)
            print("no se peye")
        }
        
    }
    
    func getTimeStamp() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
    
    func getRegistro() -> Registros {
        let objs = db.getRegistros(idPlaca: objPlaca.id, last: true)
        if objs.count > 0 {
            let obj = objs[0]
            if obj.estado == 1 {
                let dEntrada    = Date(timeIntervalSince1970: TimeInterval(obj.entrada))
                lblEntrada.text = util.formatter(date: dEntrada)
            }else{
                lblEntrada.text = "No ingresado a estacionamiento"
            }
            
            return obj
        }else{
            return Registros()
        }
        
    }
    
    func getTotal() -> Double {
        let objs = db.getRegistros(idPlaca: objPlaca.id, last: false)
        
        var total : Double = 0.0
        for obj in objs{
            
            let interval    = obj.salida - obj.entrada
            let costo = (Double(interval)/60 * 0.05)
            
            print("tiempo",obj.salida - obj.entrada)
            print("costo",costo)
            total = total + costo
        }
        
        print("total",total)
        return total
        
        
    }
    
    func showTicket(obj : Registros) {
        let interval    = obj.salida - obj.entrada
        let dEntrada    = Date(timeIntervalSince1970: TimeInterval(obj.entrada))
        let dSalida     = Date(timeIntervalSince1970: TimeInterval(obj.salida))
        print("interval ",interval)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "Ticket") as? Ticket
        vc?.placa     = objPlaca.placa
        vc?.tipo     = objPlaca.nombreTipo
        vc?.entrada     = util.formatter(date:dEntrada)
        vc?.salida      = util.formatter(date:dSalida)
        vc?.intervalo   =  TimeInterval(interval).toReadableString()
        vc?.importe      = "$\(String(format: "%0.2f", (Double(interval)/60 * 0.05)))"
        vc?.acumulado   = "$\(String(format: "%0.2f", getTotal()))"
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    
    
    func stringFromTime(interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: interval)!
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


//
//  Util.swift
//  AutoParking
//
//  Created by Heber Echeverria on 5/28/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import Foundation

import UIKit
class Util : NSObject{
    func showAlert(title: String, msg : String, delegate : AnyObject){
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        delegate.present(alert, animated: true, completion: nil)
    
    }
    func formatter(date : Date) -> String{
        let dateFormat = DateFormatter()
        dateFormat.locale = NSLocale.current
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormat.string(from: date)
    }
    
    func savePeriodo(){
        let dateFin = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        
        let factu = UserDefaults.standard
        factu.set(["inicio":Date(),"fin":dateFin!], forKey: "Periodo")
    }
    
    func getPeriodo() -> [String:Date]{
        let factu = UserDefaults.standard
        return (factu.dictionary(forKey: "Periodo"))! as! [String : Date]
    }
    
    func usage()->Bool{
        
        let ud = UserDefaults.standard
        //ud.removeObject(forKey: "status")
        
        var estado = ud.bool(forKey: "status")
        
        if (estado == false) {
             ud.set(true, forKey: "status")
            estado = true
            return false
        }
       return estado
        
    }
    
    
    
}
extension TimeInterval {

    func toReadableString() -> String {

        let s = Int(self) % 60
        let mn = (Int(self) / 60) % 60
        let hr = (Int(self) / 3600)

        var readableStr = ""
        if hr != 0 {
            readableStr += String(format: "%0.2dhr ", hr)
        }
        if mn != 0 {
            readableStr += String(format: "%0.2dmin ", mn)
        }
        if s != 0 {
            readableStr += String(format: "%0.2ds ", s)
        }


        return readableStr
    }
}

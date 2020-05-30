//
//  PeriodoFacturacion.swift
//  AutoParking
//
//  Created by Heber Echeverria on 5/29/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import UIKit

class PeriodoFacturacion: UIViewController {
    
    @IBOutlet weak var lblInicio: UILabel!
    @IBOutlet weak var btnPeriodo: UIButton!
    @IBOutlet weak var lblFin: UILabel!
    
    let util = Util()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPeriodo()
    }
    
    @IBAction func btnPeriodo(_ sender: Any) {
        util.savePeriodo()
        showPeriodo()
    }
    
    func showPeriodo() {
        let obj = util.getPeriodo()
        lblInicio.text = util.formatter(date: obj["inicio"]!)
        lblFin.text = util.formatter(date: obj["fin"]!)
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

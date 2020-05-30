//
//  Ticket.swift
//  AutoParking
//
//  Created by Heber Echeverria on 5/30/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import UIKit

class Ticket: UIViewController {
    var placa = ""
    var tipo = ""
    var entrada = ""
    var salida = ""
    var intervalo = ""
    var importe = ""
    var acumulado = ""
    
    @IBOutlet weak var lblEntrada: UILabel!
    @IBOutlet weak var lblSalida: UILabel!
    @IBOutlet weak var lblTiempo: UILabel!
    @IBOutlet weak var lblCosto: UILabel!
    @IBOutlet weak var lblAcumulado: UILabel!
    @IBOutlet weak var lblTitleAcumulado: UILabel!
    @IBOutlet weak var lblPlaca: UILabel!
    @IBOutlet weak var lblTipo: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tipo == "Oficial" {
            importe = "-"
            acumulado = "-"
            
        }else if tipo == "Visita" {
            acumulado = "-"
        }
        lblEntrada.text     = entrada
        lblSalida.text      = salida
        lblTiempo.text      = intervalo
        lblCosto.text       = importe
        
        lblAcumulado.text   = acumulado
        
        lblPlaca.text = placa
        lblTipo.text = tipo
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
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

//
//  RegistrarPlaca.swift
//  AutoParking
//
//  Created by Heber Echeverria on 5/29/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import UIKit

class RegistrarPlaca: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var placa = ""
    var dataArray : [SearchPlaca] = []
    let db = DBHelper()
    let util = Util()
    var tipoVehiculos : [Tipo] = []
    var idTipo = -1
    
    
    @IBOutlet weak var txtPlaca: UITextField!
    @IBOutlet weak var btnTipo: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
        tableView.keyboardDismissMode = .onDrag
        txtPlaca.delegate = self
        tipoVehiculos = db.getTipo()
        txtPlaca.text = placa
        
       
        
    }
    
    
    
    @IBAction func btnTipo(_ sender: Any) {
        let deleteAlert = UIAlertController(title: "Seleccione un tipo de vehiculo", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        for  obj in tipoVehiculos{
            let unfollowAction = UIAlertAction(title: obj.tipo, style: .default) { (action: UIAlertAction) in
                self.btnTipo.setTitle(obj.tipo, for: .normal)
                self.idTipo = obj.id
                print(obj.id)
            }
            deleteAlert.addAction(unfollowAction)
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        deleteAlert.addAction(cancelAction)
        self.present(deleteAlert, animated: true, completion: nil)
    }
    @IBAction func btnGuardar(_ sender: Any) {
        save()
    }
    func fillData(){
        dataArray = db.getPlaca()
        tableView.reloadData()
        txtPlaca.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let obj = dataArray[indexPath.row]
        cell.lblTitle.text      = obj.placa
        cell.lblSubtitle.text   = obj.nombreTipo
        return cell
    }
    
    
    func save(){
        let placa = txtPlaca.text ?? ""
        if (placa == ""){
            util.showAlert(title: "", msg: "Favor ingresa la placa", delegate: self)
        }else if (btnTipo.titleLabel?.text == "Selecciona tipo de vehículo"){
            util.showAlert(title: "", msg: "Favor ingresa el tipo de vehículo", delegate: self)
        }else{
            txtPlaca.resignFirstResponder()
            print("excusa",idTipo)
            let obj = Placa()
            obj.placa   = placa
            obj.tipo    = idTipo
            db.savePlaca(placa: obj)
            let refresh = Notification.Name("refresh")
            NotificationCenter.default.post(name: refresh, object: nil)
            self.fillData()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        save()
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTipo(id: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func deleteTipo(id : Int){
        
        let alert = UIAlertController(title: "Desea eliminar esta placa?", message: "Al eliminarlo desapareceran todos los registros asociados", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
            let obj = self.dataArray[id]
            print("dos patadas",obj.placa)
            print("dos patadas",obj.id)
            self.db.deletePlaca(id: obj.id)
            self.fillData()
        }))
        self.present(alert, animated: true, completion: nil)
        
        
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

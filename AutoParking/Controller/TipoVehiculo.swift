//
//  TipoVehiculo.swift
//  AutoParking
//
//  Created by Heber Echeverria on 5/28/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import UIKit


class TipoVehiculo: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var dataArray : [Tipo] = []
    let db = DBHelper()
    let util = Util()
    
    func fillData(){
        dataArray = db.getTipo()
        tableView.reloadData()
        txtTipo.text = ""
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let obj = dataArray[indexPath.row]
        cell.lblTitle.text = obj.tipo
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtTipo: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
        tableView.keyboardDismissMode = .onDrag
        txtTipo.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func btnGuardar(_ sender: Any) {
        save()
        
    }
    
    func save(){
        let tipo = txtTipo.text ?? ""
        if (tipo == ""){
            util.showAlert(title: "", msg: "Favor ingresa el tipo de vehículo", delegate: self)
        }else{
            txtTipo.resignFirstResponder()
            db.saveTipo(tipo: tipo)
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
        
        let alert = UIAlertController(title: "Desea eliminar este tipo de vehículo?", message: "Al eliminarlo desapareceran las placas asociadas", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
            let obj = self.dataArray[id]
            self.db.deleteTipo(idTipo: obj.id)
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

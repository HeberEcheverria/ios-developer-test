//
//  Informes.swift
//  AutoParking
//
//  Created by Heber Echeverria on 5/30/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import UIKit

class Informes: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var placa = ""
       var dataArray : [Registros] = []
       let db = DBHelper()
       let util = Util()
    @IBOutlet weak var txtPlaca: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPlaca.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        txtPlaca.delegate = self
        tableView.keyboardDismissMode = .onDrag
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        dataArray = db.getInformes(placa: 0, search: false)
        tableView.reloadData()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        print(textField.text)
        let placasArray = db.getSearchPlaca(search: textField.text!)
        
        print(placasArray.count)
        if textField.text == "" {
            dataArray = db.getInformes(placa: 0, search: false)
        }else{
            let obj = placasArray[0]
            dataArray = db.getInformes(placa: obj.id, search: true)
        }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let obj = dataArray[indexPath.row]
        let interval    = obj.intervalo
        cell.lblTitle.text      = obj.placa
        cell.lblTipo.text      = obj.tipo
        if obj.salida > 0 {
            cell.lblDate.text       = "\(String(format: "%0.1f",Double(interval)/60)) mins"
            if obj.tipo == "Oficial" {
                cell.lblSubtitle.text   = "$ -"
            }else{
                cell.lblSubtitle.text   = "$\(String(format: "%0.2f", (Double(interval)/60 * 0.05)))"
            }
            
        }else{
            cell.lblDate.text       = "En curso"
            cell.lblSubtitle.text   = "En curso"
            
        }
        
        
        return cell
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

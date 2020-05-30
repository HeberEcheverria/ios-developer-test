//
//  ControlRegistro.swift
//  AutoParking
//
//  Created by Heber Echeverria on 5/28/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import UIKit

class ControlRegistro: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    
    
    
    var dataArray : [SearchPlaca] = []
    let db = DBHelper()
    let util = Util()
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtPlaca: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectioView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPlaca.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        txtPlaca.delegate = self
        dataArray = db.getSearchPlaca(search: "")
        btnAdd.isEnabled = false
        
        let hideButton = Notification.Name("refresh")
               NotificationCenter.default.addObserver(self, selector: #selector(refreshAction), name: hideButton, object: nil)
        
        // Do any additional setup after loading the view.
    }
    @objc func refreshAction(_ notification: Notification)
    {
       print("tratame bonito")
        dataArray = db.getSearchPlaca(search: "")
        collectionView.reloadData()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        print(textField.text)
        dataArray = db.getSearchPlaca(search: textField.text!)
        print(dataArray.count)
        if dataArray.count == 0 {
            btnAdd.isEnabled = true
        }else{
            btnAdd.isEnabled = false
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! CustomItem
        
        let obj = dataArray[indexPath.row]
        cell.lblPlaca.text = obj.placa
        cell.lblTipo.text = "\(obj.nombreTipo)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = dataArray[indexPath.row]
          
          let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
          let vc = storyboard.instantiateViewController(withIdentifier: "Registro") as? Registro
          vc?.objPlaca   = obj
          self.navigationController?.show(vc!, sender: nil)
    }
   
    @IBAction func btnAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegistrarPlaca") as? RegistrarPlaca

        vc?.placa   = txtPlaca.text!
        self.navigationController?.show(vc!, sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.txtPlaca.endEditing(true)
        
        return true
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

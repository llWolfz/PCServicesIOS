//
//  CompanyPicker.swift
//  Proyecto Final
//
//  Created by David Salazar on 06/05/20.
//  Copyright © 2020 llWolfz. All rights reserved.
//
import UIKit

class CompanyPicker: PickerController {
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start(frame: CGRect){
        self.fillPicker()
        super.createPicker(frame: frame)
    }
    
    func getActiveCompanyId() -> String{
        return self.companies[super.activePickerId].idCompany
    }
    
    func fillPicker(){
        var temp: [String] = []
        super.bringData(completion: { result in
            for element in result["data"] as! [AnyObject] {
                var company = Company(idCompany: "", name: "", email: "", created_at: "")
                for (key, value) in element as! Dictionary<String, AnyObject> {
                    switch key {
                    case "name":
                        company?.name = value as! String
                        break
                    case "email":
                        company?.email = value as! String
                        break
                    case "idCompany":
                        company?.idCompany = value.stringValue
                        break
                    case "created_at":
                        company?.created_at = value as! String
                        break
                    default:
                        break
                    }
                }
                self.companies.append(company!)
                temp.append(company!.name)
            }
            self.pickerOptions = temp
        }, url: "companies")
    }
}

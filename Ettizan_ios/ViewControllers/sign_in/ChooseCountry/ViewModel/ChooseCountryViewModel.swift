//
//  ChooseCountryViewModel.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 28/11/2023.
//

import Foundation
import UIKit


class ChooseCountryViewModel {
    let idCell = CountryTableViewCell.ID
    
    var countries : [Country]? {
        get {
            return Constants.shared.countries
        }
    }
    
    var countrySelect : Country?
    
    var VC : ChooseCountryVC?
    init(VC: ChooseCountryVC) {
        self.VC = VC
        registerNib()
    }
    
    func registerNib(){
        let nib = UINib(nibName: idCell, bundle: nil)
        VC?.tableView.register(nib, forCellReuseIdentifier: idCell)
    }
    
    func getCount() -> Int{
        return countries?.count ?? 0
    }
    
    func getCell(tableView : UITableView , indexPath : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! CountryTableViewCell
        if let country = countries?[indexPath.row]{
            let select = selectedCell(country: country, countrySelect: countrySelect)
            cell.config(country: country, countrySelect: select, row: indexPath.row)
        }
        
        cell.selectRow = { row in
            self.countrySelect = self.countries?[row]
            self.VC?.tableView.reloadData()
        }
        
        return cell
    }
    
    func selectedCell(country : Country , countrySelect : Country?) -> Bool{
        if let selected = countrySelect , selected.id == country.id{
            return true
        }else{
            return false
        }
    }
    
    
    func saveBtn(){
        if let select = self.countrySelect {
            self.VC?.selectedCountry?(select)
        }
    }
    
}

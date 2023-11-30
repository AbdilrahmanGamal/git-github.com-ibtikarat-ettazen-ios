//
//  ChooseCountryVC.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 28/11/2023.
//

import UIKit

class ChooseCountryVC : UIViewController{
    
    static var storBoardName = "ChooseCountry"
    static var storBoardID = "ChooseCountryVC"
    
    static var viewController : ChooseCountryVC? {
        get {
            let storyBorad = UIStoryboard(name: storBoardName, bundle: nil)
            let viewCont = storyBorad.instantiateViewController(withIdentifier: storBoardID) as? ChooseCountryVC
            return viewCont
        }
    }
    
    @IBOutlet weak var tableView : UITableView!
    
    var viewModel : ChooseCountryViewModel?
    
    var selectedCountry : ((Country)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ChooseCountryViewModel(VC: self)
    }
    
    
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        self.dismiss(animated: true) {
            self.viewModel?.saveBtn()
        }
    }
    
    
}

extension ChooseCountryVC : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel?.getCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

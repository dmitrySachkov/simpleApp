//
//  ViewController.swift
//  SimpleApp
//
//  Created by Dmitry Sachkov on 30.01.2021.
//

import UIKit
import Moya
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var hz: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var scroll: UIPickerView!
    
    
    var dataMain = [Datum]()
    var otherData: DataClass? = nil
    var titleHz = ""
    
    let apiService = MoyaProvider<Api>()
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        apiService.request(.read) { (result) in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(Welcome.self, from: response.data)
                    self.dataMain = json.data
                    self.otherData = self.dataMain[2].data
                    self.hz.text = self.dataMain[1].data.text!
                    let url = URL(string: self.dataMain[1].data.url!)
                    self.picture.kf.setImage(with: url)
                    self.scroll.reloadAllComponents()
                }
                catch {
                }
            case .failure(let error):
                print(error)
            }
        }
        
        scroll.dataSource = self
        scroll.delegate = self
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return otherData?.variants?.count ?? 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = otherData?.variants?[row].text
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = otherData?.variants?[row]
        textField.text = title?.text
    }
}

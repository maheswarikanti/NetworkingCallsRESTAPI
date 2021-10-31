//
//  ViewController.swift
//  NetworkingCallsRESTAPI
//
//  Created by Maheswari Kanti on 10/30/21.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire

class ViewController: UIViewController {
    
    let baseURL = "https://financialmodelingprep.com/api/v3/quote-short/"
    let apiKey = "37f7ce2fbfb21606353494d2815fb685"

    @IBOutlet weak var txtStock: UITextField!
    
    @IBOutlet weak var lblStock: UILabel!

    @IBAction func getStockVal(_ sender: Any) {
        if lblStock.text == "" {
                    return;
                }
        
                let url = baseURL + txtStock.text! + "?apikey=" + apiKey
        
                SwiftSpinner.show("Getting Stock Value")
        
        AF.request(url).responseJSON { [self] response in
                    SwiftSpinner.hide()
                    if response.error != nil {
                        print(response.error!)
                        return;
                    }
                    print(response.data)
                    
                    let stocks = JSON(response.data!).array
                    
                    if stocks?.isEmpty == true {
                        print("Stock symbol is incorrect")
                        return
                    }
                    
//                    guard let firstStock = stocks[0] else {
//                        print("Stock symbol is incorrect")
//                        return
//                    }
                    let firstStock = stocks![0]
                    let price = firstStock["price"]
                    let symbol = firstStock["symbol"]
                    let volume = firstStock["volume"]
                    
                    self.lblStock.text = "\(symbol) price = \(price)";
                    
                    
                    print("Stock \(symbol) price = \(price) volume = \(volume)")
                }
    }
    //    @IBAction func getStockValue(_ sender: Any) {
//        if lblStock.text == "" {
//            return;
//        }
//
//        let url = baseURL + lblStock.text! + "?apikey=" + apiKey
//
//        SwiftSpinner.show("Getting Stock Value")
//
//        AF.request(url).responseJSON { response in
//            SwiftSpinner.hide()
//            if response.error != nil {
//                print(response.error!)
//                return;
//            }
//            print(response.data)
//            print("Mahi")
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


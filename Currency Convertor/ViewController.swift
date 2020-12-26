//
//  ViewController.swift
//  Currency Convertor
//
//  Created by shubham Garg on 03/06/20.
//  Copyright © 2020 shubham Garg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var selectFromCurrencyBtn: UIButton!
    @IBOutlet weak var selectToCurrencyBtn: UIButton!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyLbl: UILabel!
    @IBOutlet weak var convertBtn: UIButton!
    //Cunversion rate Based on USD
    //https://api.exchangeratesapi.io/history?start_at=2020-06-02&end_at=2020-06-03&base=USD
    var currencyConvertRateDict = ["CAD":1.3448367167,"HKD":7.7501323919,"ISK":131.4210061783,"PHP":49.8296557811,"DKK":6.5811120918,"HUF":304.1659311562,"CZK":23.4677846425,"GBP":0.7894792586,"RON":4.2702559576,"SEK":9.2012356575,"IDR":14018.0052956752,"INR":75.5781112092,"BRL":5.059929391,"RUB":68.6809355693,"HRK":6.6827007944,"JPY":109.2409532215,"THB":31.4651368049,"CHF":0.9590467785,"EUR":0.8826125331,"MYR":4.2669902913,"BGN":1.7262135922,"TRY":6.7737864078,"CNY":7.0917034422,"NOK":9.3030008826,"NZD":1.5350397176,"ZAR":16.8422771403,"USD":1.0,"MXN":21.7533980583,"SGD":1.392321271,"AUD":1.4322153575,"ILS":3.4573698147,"KRW":1205.2691968226,"PLN":3.9210061783]
    var fromCurrency = ""
    var toCurrency = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Currency Convertor"
        // Do any additional setup after loading the view.
    }

    @IBAction func selectFromCurrencyBtnAxn(_ sender: UIButton) {
        //Create an action sheet to show currencies
        let sheet = UIAlertController(title: "Select From Currency", message: nil, preferredStyle: .actionSheet)
        // for loop to adding all currency from currencyConvertRateDict
        for key in self.currencyConvertRateDict.keys{
            // Create action to select any one of currency
            let action = UIAlertAction(title: key, style: .default) { (action) in
                // assign Values
                self.fromCurrency = key
                // Change Button text
                self.selectFromCurrencyBtn.setTitle(key, for: .normal)
                // cleanup calculation
                self.toCurrencyLbl.text = ""
                
            }
            //add action on sheet
            sheet.addAction(action)
        }
        if let popoverPresentationController = sheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = sender.bounds
        }
        self.present(sheet, animated: true, completion: nil)
        
    }
    
    @IBAction func selectToCurrencyBtnAxn(_ sender: UIButton) {
        //Create an action sheet to show currencies
         let sheet = UIAlertController(title: "Select To Currency", message: nil, preferredStyle: .actionSheet)
         // for loop to adding all currency from currencyConvertRateDict
         for key in self.currencyConvertRateDict.keys{
             // Create action to select any one of currency
             let action = UIAlertAction(title: key, style: .default) { (action) in
                 // assign Values
                 self.toCurrency = key
                 // Change Button text
                 self.selectToCurrencyBtn.setTitle(key, for: .normal)
                // cleanup calculation
                self.toCurrencyLbl.text = ""
             }
             //add action on sheet
             sheet.addAction(action)
         }
        if let popoverPresentationController = sheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = sender.bounds
        }
         self.present(sheet, animated: true, completion: nil)
    }
    
    @IBAction func convertBtnAxn(_ sender: Any) {
        // Convert from and To Currency to USD
        //LOGIC
        //1 USD = 1.35 CAD
//        1 CAD = 1/1.35 USD
//        1 CAD = 0.74 USD
//        1 USD = 75.20 INR
//        1 CAD = 0.74 USD = 0.74 * 75.20 INR = 55.65 INR
        if let fromCurrencyRate = currencyConvertRateDict[fromCurrency], let toCurrencyRate = currencyConvertRateDict[toCurrency], let textFieldVal = fromCurrencyTextField.text, let val: Double = Double(textFieldVal){
             let usdVal = 1.0/fromCurrencyRate
            let toCurrencyVal = usdVal * toCurrencyRate
            let totalVal = val * toCurrencyVal
            self.toCurrencyLbl.text = String(totalVal)
        }
       
        
    }
}


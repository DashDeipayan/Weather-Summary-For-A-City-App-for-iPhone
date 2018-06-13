//
//  ViewController.swift
//  What's The Weather
//
//  Created by Deipayan Dash on 12/06/18.
//  Copyright © 2018 Deipayan Dash. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet var cityName: UITextField!
    
    @IBOutlet var results: UILabel!
    
    
    @IBAction func searchButton(_ sender: Any) {
        if let url = URL(string: "https://www.weather-forecast.com/locations/"+cityName.text!.replacingOccurrences(of: " ", with: "-")+"/forecasts/latest"){
        let request = NSMutableURLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            var message = ""
            
            if error != nil {
                print(error!)
            }
            else {
                if let unwrapped = data {
                    let datastring  = NSString(data: unwrapped, encoding: String.Encoding.utf8.rawValue)
                    var stringSeparator = "(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    
                    if let contentArray = datastring?.components(separatedBy: stringSeparator){
                        if contentArray.count > 1{
                            stringSeparator = "</span>"
                            
                            let newContentSeparator = contentArray[1].components(separatedBy: stringSeparator)
                            if newContentSeparator.count > 0 {
                                message = newContentSeparator[0].replacingOccurrences(of: "&deg;", with: "° ")
                                print(message)
                                
                                
                                
                            }
                        }
                     }
                    
                    
                    
                }
            }
            if message == ""{
                message = "Failed to load data. Try Again"
            }
            DispatchQueue.main.sync(execute: {
                self.results.text = message
            })
        }
        task.resume()
        }else {
            results.text = "Failed to load data. Try Again"
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.

        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


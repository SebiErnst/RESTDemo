//
//  ViewController.swift
//  RESTDemo
//
//  Created by Sebastian Ernst on 23/11/2016.
//  Copyright © 2016 KIS AGH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var zastepstwa: [String:Any] = [:]
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
func updateView() {
    textView.text = ""
    for (nauczyciel, jegoZastepstwa) in self.zastepstwa {
        textView.text.append(nauczyciel)
        textView.text.append("\n")
        for (lekcja, komunikat) in jegoZastepstwa as! [String:String] {
            textView.text.append("  – lekcja \(lekcja): \(komunikat)\n")
        }
        textView.text.append("\n")
    }
}
    
    @IBAction func updateSubstitutions(_ sender: Any) {
let url = URL(string: "http://borg.kis.agh.edu.pl/~sebi/zastepstwa.php?date=2016-11-22")
let session = URLSession.shared
let task = session.dataTask(with: url!)
{ data, response, err in
    if data != nil {
        self.zastepstwa = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
        DispatchQueue.main.async {
            self.updateView()
        }
    }
}
task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


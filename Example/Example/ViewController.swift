//
//  ViewController.swift
//  Example
//
//  Created by teda on 2023/11/08.
//

import UIKit
import TickerView

class ViewController: UIViewController {
    @IBOutlet weak var tickerView: TickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tickerView.setText("TickerView")
        tickerView.startAnimation()
    }


}


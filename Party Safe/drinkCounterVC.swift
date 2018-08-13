//
//  drinkCounterVC.swift
//  Party Safe
//
//  Created by Josh Jaslow on 8/18/17.
//  Copyright © 2017 Jaslow Enterprises. All rights reserved.
//

import UIKit

class drinkCounterVC: UIViewController {

    var beers: Int = 0 {
        didSet {
            numBeers.text = "\(beers)"
            
            if beers == 1 {
                beersLabel.text = "Beer"
            } else {
                beersLabel.text = "Beers"
            }
            
            calculateBAC()
        }
    }
    var wines: Int = 0 {
        didSet {
            numWines.text = "\(wines)"
            
            if wines == 1 {
                winesLabel.text = "Glass of wine"
            } else {
                winesLabel.text = "Glasses of wine"
            }
            
            calculateBAC()
        }
    }
    var shots: Int = 0 {
        didSet {
            numShots.text = "\(shots)"
            
            if shots == 1 {
                shotsLabel.text = "Shot"
            } else {
                shotsLabel.text = "Shots"
            }
            
            calculateBAC()
        }
    }
    
    var BAC: Double = 0 {
        didSet {
            BACLabel.text = "\(BAC)%"
            
            if BAC > 0.2 {
                print("Call 911")
            }
        }
    }
    
    @IBOutlet weak var beersLabel: UILabel!
    @IBOutlet weak var winesLabel: UILabel!
    @IBOutlet weak var shotsLabel: UILabel!
    
    @IBOutlet weak var numBeers: UILabel!
    @IBOutlet weak var numWines: UILabel!
    @IBOutlet weak var numShots: UILabel!
    
    @IBOutlet weak var BACLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addBeer(_ sender: UIButton) {
        beers += 1
    }
    
    @IBAction func addWine(_ sender: UIButton) {
        wines += 1
    }
    
    @IBAction func addShot(_ sender: UIButton) {
        shots += 1
    }
    
    func calculateBAC() {
        let SD: Double = Double(beers + wines + shots)
        let sally = person(gender: .female, weight: 135)
        let BW: Double = sally.BW
        let WT: Double = sally.WT
        let MR: Double = 0.017
        let DP: Double = 2
        var result: Double = 0
        
        let exp1 = (0.806 * SD * 1.2)//2.9016
        let exp2 = (BW * WT)//66.15
        let exp3 = MR * DP//.034
        
        if DP != 0 && SD != 0 {
            result = ((exp1 / exp2) - exp3) * 10
            if result > 0 {
                let tempy = String(result)
                let index = tempy.index(tempy.startIndex, offsetBy: 4)
                BAC = Double(tempy.substring(to: index))!
            }
        }
    }
    
}

class person {
    
    enum sex {
        case male
        case female
    }
    
    var BW: Double
    var WT: Double
    
    init(gender: sex, weight: Double) {
        switch gender {
            case .male:
                BW = 0.58
            case .female:
                BW = 0.49
        }
        WT = weight
    }
}

//MARK: - Global

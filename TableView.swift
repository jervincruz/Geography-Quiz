//
//  TableView.swift
//  GeoQuiz
//
//  Created by Jervin Cruz on 12/13/16.
//  Copyright © 2016 Jervin Cruz. All rights reserved.
//

import UIKit

class TableView : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    let textCellIdentifier = "TextCell"
    
    @IBOutlet var country: UILabel!
    @IBOutlet var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        country.text = chosenCountry
        country.font = UIFont(name: "Zapfino", size:
            30)
        country.textAlignment = .Center
        country.sizeToFit()
        questionLabel.font = UIFont(name: "Zapfino", size:
            20)

    }
    
    // Know number of sections
    func NumberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Know number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    
    // tableView requesting information
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = wrongCapitals[row]
        if row == 0{
            if chosenCountryTag == 0 {
            cell.textLabel?.text = capitalsFromFile[0]
            }
            if chosenCountryTag == 1 {
                cell.textLabel?.text = capitalsFromFile[1]
            }
            if chosenCountryTag == 2 {
                cell.textLabel?.text = capitalsFromFile[2]
            }
            if chosenCountryTag == 3 {
                cell.textLabel?.text = capitalsFromFile[3]
            }
            if chosenCountryTag == 4 {
                cell.textLabel?.text = capitalsFromFile[4
                ]
            }
        }
        
        return cell
    }
    
    
    // Selected row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        let row = indexPath.row
        if(indexPath.row == 0){
            points++
            correct = true
        }else{
            correct = false
        }
        // When user chooses answer, go back
        self.performSegueWithIdentifier("goBack", sender: self)
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if(indexPath.row == 0){
        cell?.contentView.backgroundColor = UIColor.greenColor()
        }
        else if(indexPath.row != 0){
        cell?.contentView.backgroundColor = UIColor.redColor()
        }
    }
    
        
    
}
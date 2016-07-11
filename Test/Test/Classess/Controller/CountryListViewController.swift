//
//  CountryListViewController.swift
//  Test
//
//  Created by Vijay on 7/8/16.
//  Copyright © 2016 Vijay. All rights reserved.
//

import UIKit
import SQLite
import SDWebImage

// MARK: - Class -

class CountryListViewController: ViewController {

    // MAKR: - Outlets -
    
    @IBOutlet weak var countriesListTableView: UITableView!
    
    // MARK: - Properties -
    
    var countries = [Country]() {
        didSet{
            countriesListTableView.reloadData()
        }
    }
    
    var allCountries = [Country]()
    
    var fileURL : String?
    
    // MARK: - UIViewController -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        setupSQliteDatabase()
    }

    // MARK: -  Fetch DB -
    
    func setupSQliteDatabase() {
        
        fileURL = getFileUrl()
        let fileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(fileURL!) {
            let urlString = "https://github.com/tknizam/goswiff-mobile-test/blob/master/data/GoSwiff.db?raw=true"
            let url = NSURL(string: urlString)!
            
            let data = NSData(contentsOfURL: url)!
            
            data.writeToFile(fileURL!, atomically: true)

        }
        connectDB()
    }
    
    func getFileUrl() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        let filePath = NSURL(string: documentDirectory)!.URLByAppendingPathComponent("GoSwift.db")
        return filePath.absoluteString
    }
    
    // MARK: - Read DB -
    
    func connectDB() {
        
        let newdb = try! Connection(fileURL!)
    
        for row in try! newdb.prepare("SELECT * FROM countries") {
            let country = Country(row: row)
            allCountries.append(country)
        }
        countries.appendContentsOf(allCountries)
    }

}

// MARK: - UITableViewDataSource

extension CountryListViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CountryCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! CountryCell
        let flagUrl = NSURL(string: countries[indexPath.row].flag32UrlString)!
        cell.countryNameLabel.text = countries[indexPath.row].name
        cell.flagImageView.sd_setImageWithURL(flagUrl)
        return cell
    }
    
}

// MARK: - UITableViewDelegate -

extension CountryListViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        pushViewController(CountryDetailViewController.self, parameters: ["country" : countries[indexPath.row]], animated: true)
    }
    
}

// MARK: - UISearchBarDelegate -

extension CountryListViewController : UISearchBarDelegate {

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            let filteredCountries = allCountries.filter({(c : Country) -> Bool in
                let stringMatch = c.officialName.lowercaseString.rangeOfString(searchText.lowercaseString)
                return (stringMatch != nil)
            })
            countries = filteredCountries
        }
        else {
            countries.removeAll()
            countries.appendContentsOf(allCountries)
        }
        
    }
    
}














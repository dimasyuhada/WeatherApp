//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by admin on 09/06/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var _temperature: UILabel!
    @IBOutlet weak var _summary: UILabel!
    @IBOutlet weak var _icon: UIImageView!
    @IBOutlet weak var _bg: UIImageView!
    @IBOutlet weak var _searchBar: UISearchBar!
    
    var forecastData = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty{
            //updateWeather
            updateWeatherLocation(location: locationString)
        }
    }
    
    func updateWeatherLocation (location:String){
        CLGeocoder().geocodeAddressString(location) {(placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil{
                if let location = placemarks?.first?.location {
                    Weather.forecast(withLocation: location.coordinate, completion: { (results:[Weather]?) in
                        if let weatherData = results {
                            self.forecastData = weatherData
                            DispatchQueue.main.async {
                                self.loadWeatherData()
                            }
                        }
                    })
                }
            }
            
        }
    }
    
    func loadWeatherData(){
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  WeatherDataSource.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

final class WeatherDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var place: Place?
    private weak var tableView: UITableView?

    required init(tableView: UITableView) {
        self.tableView = tableView

        super.init()
    }

    func update(withPlace place: Place?) {
        self.place = place

        dispatch_async(dispatch_get_main_queue()) { 
            self.tableView?.reloadData()
        }
    }

    //MARK: UITableViewDelegate methods

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let weatherCell = cell as? WeatherViewCell else {
            fatalError("Unexpected cell type at \(indexPath)")
        }

        weatherCell.flashScrollIndicators()
    }

    //MARK: UITableViewDataSource methods

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.place != nil) ? 1 : 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(WeatherViewCell.reuseIdentifier) as? WeatherViewCell else {
            fatalError("Unexpected cell type at \(indexPath)") 
        }

        cell.configure(forObject: self.place!)

        return cell
    }


}

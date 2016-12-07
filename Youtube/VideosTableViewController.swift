//
//  VideosTableViewController.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/23/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import UIKit

class VideosTableViewController: UITableViewController {
    
    private var videosList:[Video] = []
    var delegate: YoutubeVideosTableViewDelegete?
    
    func setVideosList(_ videosList: [Video]) {
        self.videosList = videosList
        tableView.setContentOffset(CGPoint.zero, animated: false)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videosList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.setCellData(videosList[indexPath.row])
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return delegate != nil
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let video =  videosList.remove(at: indexPath.row)
            delegate!.removeVideoFromList(video, videosList.count == 0)
            tableView.deleteRows(at: [indexPath], with: .left)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "videoDetails"{
            let detailedVideoViewController = segue.destination as? DetailedVideoViewController
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            detailedVideoViewController?.video = CoreDataHelper.saveVideo(videosList[index],.History)
        }

    }
  
}

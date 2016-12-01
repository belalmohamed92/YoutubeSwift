//
//  CoreDataHelper.swift
//  Youtube
//
//  Created by Modeso-M.MAC on 11/29/16.
//  Copyright © 2016 Modeso-M.MAC. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    
    enum SaveType: String {
        case History = "isHistory"
        case Favorites = "isFavorite"
    }
    
    static func saveVideo( _ video:Video, _ saveType: SaveType) -> Bool {
        //TODO Find a away to cast the object from the coreDate to Video object ( Extending NSManagedObject)
        let context = getContext()
        
        if !checkVideoAlreadyExistAndUpdate(video, context, saveType, true) {
            
            let nsManagedVideoObject = NSEntityDescription.insertNewObject(forEntityName: "Video", into: context)
            nsManagedVideoObject.setValue(video.getId()!, forKey: "videoId")
            nsManagedVideoObject.setValue(video.getDescription()!, forKey: "videoDescription")
            nsManagedVideoObject.setValue(video.getName()!, forKey: "videoTitle")
            nsManagedVideoObject.setValue(video.getThumbnailUrl()!, forKey: "videoThumbnailUrl")
            nsManagedVideoObject.setValue(video.getPublishedDateAsDate()!, forKey: "publishDate")
            nsManagedVideoObject.setValue(video.getChannelTitle()!, forKey: "videoChannelTitle")
            nsManagedVideoObject.setValue(saveType == .History, forKey: "isHistory")
            nsManagedVideoObject.setValue(saveType == .Favorites, forKey: "isFavorite")
            nsManagedVideoObject.setValue(Date(), forKey: "saveDate")
        }
    
        do{
         try context.save()
        }catch{
            return false
        }
        
        return true
    }
    
    static func removeVideo(_ video:Video, _ saveType: SaveType) -> Bool {
        let context = getContext()
        _ = checkVideoAlreadyExistAndUpdate(video, context, saveType, false)
        return true
    }
    
    static func getVideosList(_ saveType: SaveType) -> [Video] {
        return getVideos(saveType,nil)
    }
    
    static func isVideoExist(_ saveType:SaveType, videoId: String) -> Bool{
        return getVideos(saveType, videoId).count > 0
    }
    
    
    private static func getVideos(_ saveType: SaveType,_ videoId: String?) -> [Video] {
        var videos: [Video] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Video")
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: getPredicates(saveType,videoId))
        request.sortDescriptors = [NSSortDescriptor(key: "saveDate", ascending: false)]
        request.returnsObjectsAsFaults = false
        
        if let results = try? getContext().fetch(request) {
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    let videoTitle = result.value(forKey: "videoTitle") as? String ?? ""
                    let videoId = result.value(forKey: "videoId") as? String ?? ""
                    let videoDescription = result.value(forKey: "videoDescription") as? String ?? ""
                    let videoPublishDate = result.value(forKey: "publishDate") as? Date
                    let videoChannelTitle = result.value(forKey: "videoChannelTitle") as? String ?? ""
                    let videoThumbnailUrl = result.value(forKey: "videoThumbnailUrl") as? String ?? ""
                    
                    let video = Video(videoTitle,videoId,videoDescription,videoThumbnailUrl,videoPublishDate,videoChannelTitle)
                    videos.append(video)
                    
                }
            }
        }
        
       return videos
    }
    
    private static func getPredicates(_ saveType:SaveType , _ videoId: String?) -> [NSPredicate] {
        var predicates = [NSPredicate(format: "\(saveType.rawValue) = %@", NSNumber(booleanLiteral: true))]
        
        if let vidId = videoId {
            predicates.append(NSPredicate(format: "videoId = %@", vidId))
        }
        
        return predicates
    }
    
    private static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       return appDelegate.persistentContainer.viewContext
    }
    
    private static func checkVideoAlreadyExistAndUpdate(_ video: Video, _ context: NSManagedObjectContext, _ saveType: SaveType, _ isAdd: Bool) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Video")
        request.predicate = NSPredicate(format: "videoId = %@",video.getId()!)
        request.returnsObjectsAsFaults = false
        
        if let results = try? context.fetch(request) {
            if results.count > 0 {
                let results = results as! [NSManagedObject]
                let result = results[0]
                if !isAdd && (!(result.value(forKey: SaveType.History.rawValue) as! Bool) || !(result.value(forKey: SaveType.Favorites.rawValue)as! Bool)) {
                    context.delete(result)
                }else {
                result.setValue(Date(), forKey: "saveDate")
                result.setValue(isAdd, forKey: saveType.rawValue)
                }
                try? context.save()
                return true
            }
        }
        return false
    }
}

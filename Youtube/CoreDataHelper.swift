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
    
    static func saveVideo( _ video:Video, _ saveType: SaveType) -> Video {
        //TODO Find a away to cast the object from the coreDate to Video object ( Extending NSManagedObject)
        let context = getContext()
        
        if let video = checkVideoAlreadyExistAndUpdate(video, context, saveType, true) {
            return video
        }else {
            let nsManagedVideoObject = NSEntityDescription.insertNewObject(forEntityName: "Video", into: context)
            nsManagedVideoObject.setValue(video.getId(), forKey: "videoId")
            nsManagedVideoObject.setValue(video.getDescription()!, forKey: "videoDescription")
            nsManagedVideoObject.setValue(video.getName()!, forKey: "videoTitle")
            nsManagedVideoObject.setValue(video.getThumbnailUrl()!, forKey: "videoThumbnailUrl")
            nsManagedVideoObject.setValue(video.getPublishedDateAsDate()!, forKey: "publishDate")
            nsManagedVideoObject.setValue(video.getChannelTitle()!, forKey: "videoChannelTitle")
            nsManagedVideoObject.setValue(saveType == .History, forKey: "isHistory")
            nsManagedVideoObject.setValue(saveType == .Favorites, forKey: "isFavorite")
            nsManagedVideoObject.setValue(Date(), forKey: "saveDate")
            try? context.save()
            return video
        }
    }
    
    static func removeVideo(_ video:Video, _ saveType: SaveType) -> Video? {
        let context = getContext()
        return checkVideoAlreadyExistAndUpdate(video, context, saveType, false)
    }
    
    static func getVideosList(_ saveType: SaveType) -> [Video] {
        return getVideos(saveType,nil)
    }
    
    static func saveAudioUrl(_ videoId: String, _ audioUrl: String) -> Bool {
        let context = getContext()
        if let videoManagedObject = getvideoManagedObject(videoId, context) {
            videoManagedObject.setValue(audioUrl, forKey: "localAudioUrl")
            return saveContext(context)
        }
        return false
    }
    
    private static func getVideos(_ saveType: SaveType,_ videoId: String?) -> [Video] {
        var videos: [Video] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Video")
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: getPredicates(saveType,videoId))
        request.sortDescriptors = [NSSortDescriptor(key: "saveDate", ascending: false)]
        request.returnsObjectsAsFaults = false
        
        if let results = try? getContext().fetch(request), results.count > 0 {
            for result in results as! [NSManagedObject] {
                videos.append(castVideoNSManagedObject(result))
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
    
    private static func checkVideoAlreadyExistAndUpdate(_ video: Video, _ context: NSManagedObjectContext, _ saveType: SaveType, _ isAdd: Bool) -> Video? {
        var updatedVideo: Video?
            if let videoManagedObject = getvideoManagedObject(video.getId(), context) {
                if !isAdd && (!(videoManagedObject.value(forKey: SaveType.History.rawValue) as! Bool) || !(videoManagedObject.value(forKey: SaveType.Favorites.rawValue)as! Bool)) {
                    context.delete(videoManagedObject)
                }else {
                    
                    if isAdd {
                        let saveDate = Date()
                        videoManagedObject.setValue(saveDate, forKey: "saveDate")
                    }
                    videoManagedObject.setValue(isAdd, forKey: saveType.rawValue)
                    updatedVideo = castVideoNSManagedObject(videoManagedObject)
                }
               _ = saveContext(context)
            }
        
        return updatedVideo
    }
    
    private static func castVideoNSManagedObject(_ videoNSManagedObject: NSManagedObject) -> Video {
        
        let videoTitle = videoNSManagedObject.value(forKey: "videoTitle") as? String ?? ""
        let videoId = videoNSManagedObject.value(forKey: "videoId") as? String ?? ""
        let videoDescription = videoNSManagedObject.value(forKey: "videoDescription") as? String ?? ""
        let videoPublishDate = videoNSManagedObject.value(forKey: "publishDate") as? Date
        let videoChannelTitle = videoNSManagedObject.value(forKey: "videoChannelTitle") as? String ?? ""
        let videoThumbnailUrl = videoNSManagedObject.value(forKey: "videoThumbnailUrl") as? String ?? ""
        let videoIsHistory = videoNSManagedObject.value(forKey: "isHistory") as? Bool ?? false
        let videoIsFavorite = videoNSManagedObject.value(forKey: "isFavorite") as? Bool ?? false
        let videoLocalUrl = videoNSManagedObject.value(forKey: "localAudioUrl") as? String ?? ""
        let videoSaveDate = videoNSManagedObject.value(forKey: "saveDate") as? Date
        
        let video = Video(videoTitle, videoId, videoDescription, videoThumbnailUrl, videoPublishDate, videoChannelTitle)
        video.setHistory(videoIsHistory)
        video.setFavorite(videoIsFavorite)
        video.setLocalUrl(videoLocalUrl)
        video.setSaveDate(videoSaveDate)
        
        return video
    }
    
    private static func getvideoManagedObject(_ videoId: String, _ context: NSManagedObjectContext) -> NSManagedObject? {
        let request = getFetchRequest(videoId)
        if let results = try? context.fetch(request) , results.count > 0 {
           return (results as! [NSManagedObject])[0]
        }
        return nil
    }
    
    private static func getFetchRequest(_ videoId: String) -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Video")
        request.predicate = NSPredicate(format: "videoId = %@",videoId)
        request.returnsObjectsAsFaults = false
        
        return request
    }
    
    private static func saveContext(_ context: NSManagedObjectContext) -> Bool {
        do {
            try context.save()
            return true
        } catch {
            print(error)
            return false
        }
    }
}

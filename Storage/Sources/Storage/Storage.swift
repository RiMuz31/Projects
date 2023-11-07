import Foundation
import DTOObjects
import CoreData

public struct ConvertRaMEpisode {
    public var name: String
    public var air_date: String
    public var episode: String
}
public protocol Storage: AnyObject {
    var cashDict: [String:ConvertRaMEpisode] { get set }
    func getEpisode(from url: String)
    func setEpisode(_ episode: RaMEpisode, with url: String)
}
public struct StorageFactory {
    public static var storage:Storage?
    public static func make() -> Storage {
        if let storage = StorageFactory.storage {
            return storage
        }
        let storage = CoreDataStorage()
        StorageFactory.storage = storage
        return storage
    }
}
private class StorageImpl: Storage {
    public var cashDict:[String:ConvertRaMEpisode] = [:]
    public func getEpisode(from url:String) {
        }
    public func setEpisode(_ episode: RaMEpisode, with url:String) {
        var convertRaMepisodeInstanse = ConvertRaMEpisode(name: "", air_date: "", episode: "")
        if let episodeName = episode.name, let episodeAir_date = episode.air_date, let episodeEpisode = episode.episode {
            convertRaMepisodeInstanse.name = episodeName
            convertRaMepisodeInstanse.air_date = episodeAir_date
            convertRaMepisodeInstanse.episode = episodeEpisode
        }
        cashDict[url] = convertRaMepisodeInstanse
    }
}
open class PersistentContainer: NSPersistentContainer {
    }

private class CoreDataStorage: Storage {
    var persistentContainer: PersistentContainer = {
        let modelURL = Bundle.module.url(forResource:"Model", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOf: modelURL!)
        let container = PersistentContainer(name:"Model",managedObjectModel:model!)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    print("Unresolved error \(error), \(error.userInfo)")
                }
            })
        return container
    }()
    
    public var cashDict:[String:ConvertRaMEpisode] = [:]

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    public func getEpisode(from url: String) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Episode> = Episode.fetchRequest()
        do {
            let tasks = try context.fetch(fetchRequest)
            for item in tasks {
                let elem = ConvertRaMEpisode(name: item.name!, air_date: item.air_date!, episode: item.episode!)
                if let item = item.id {
                cashDict[item] = elem
                    }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    public func setEpisode(_ episode: RaMEpisode, with url: String) {
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Episode", in: context) else { return }
        let taskObject = Episode(entity: entity, insertInto: context)
        taskObject.id = url
        taskObject.name = episode.name
        taskObject.air_date = episode.air_date
        taskObject.episode = episode.episode
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    public func removeAllMenegedObjectsInPersistentConteiner() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Episode> = Episode.fetchRequest()
        if let episode = try? context.fetch(fetchRequest) {
            for episode in episode {
                context.delete(episode)
            }
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}



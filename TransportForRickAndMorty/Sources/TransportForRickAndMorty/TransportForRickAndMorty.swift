import Foundation
import DTOObjects

public enum TransportError: Error {
    case unknown
    case server(String)
    case parsing
}

public protocol Transport: AnyObject {
    func fetchCharacters(_ numberOfPages:Int, completion: @escaping (Result<RaMCharacterInfo,TransportError>) -> Void)
    func fetchEpisode(_ episodeUrl:String, completion: @escaping (Result<RaMEpisode,TransportError>) -> Void)
    
    func fetchOrigin(_ urlInCell:String, completion: @escaping (Result<RaMCharacterOrigin,TransportError>) -> Void)
}
public struct TransportFactory {
   public static func make() -> Transport {
        TransportRM()
    }
}
private let baseURL = "https://rickandmortyapi.com/api/"

private class TransportRM: Transport {
    func fetchCharacters(_ numberOfPages:Int, completion: @escaping (Result<RaMCharacterInfo,TransportError>) -> Void) {
        let urlString = baseURL + "character/" + "?page=" + String(numberOfPages)
        guard let url = URL(string: urlString) else {
            completion(.failure(.unknown))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unknown))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }
            guard response.statusCode >= 200, response.statusCode < 300 else {
                completion(.failure(.server("status code: \(response.statusCode)")))
                return
            }
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            do {
                let parser = RaMCharacterParser()
                let characters = try parser.parsJSON(data: data)
                    completion(.success(characters))
            } catch {
                    completion(.failure(.parsing))
            }
        }
        task.resume()
    }
    func fetchEpisode(_ episodeUrl:String, completion: @escaping (Result<RaMEpisode,TransportError>) -> Void) {
        let urlString = episodeUrl
        guard let url = URL(string: urlString) else {
            completion(.failure(.unknown))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unknown))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }
            guard response.statusCode >= 200, response.statusCode < 300 else {
                completion(.failure(.server("status code: \(response.statusCode)")))
                return
            }
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            do {
                let parser = RaMEpisodeParser()
                let characters = try parser.parsJSON(data: data)
                    completion(.success(characters))
            } catch {
                    completion(.failure(.parsing))
            }
        }
        task.resume()
    }
    func fetchOrigin(_ urlInCell:String, completion: @escaping (Result<RaMCharacterOrigin,TransportError>) -> Void) {
        let urlString = urlInCell
        guard let url = URL(string: urlString) else {
            completion(.failure(.unknown))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unknown))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }
            guard response.statusCode >= 200, response.statusCode < 300 else {
                completion(.failure(.server("status code: \(response.statusCode)")))
                return
            }
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            do {
                let parser = RaMOriginParser()
                let characters = try parser.parsJSON(data: data)
                    completion(.success(characters))
            } catch {
                    completion(.failure(.parsing))
            }
        }
        task.resume()
    }
}

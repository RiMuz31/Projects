import Foundation
import DTOObjects

public enum TransportError: Error {
    case unknown
    case server(String)
    case parsing
}

public protocol Transport: AnyObject {
    func fetchCharacters(_ page:Int,completion: @escaping (Result<CharacterInfo,TransportError>) -> Void)
    func fetchEpisode(_ episodeUrl:String, completion: @escaping (Result<EpisodeRM,TransportError>) -> Void)
    func fetchOrigin(_ originUrl:String, completion: @escaping (Result<CharacterOrigin,TransportError>) -> Void)
}
public struct TransportFactory {
   public static func make() -> Transport {
        TransportForRaM()
    }
}
private let baseURL = "https://rickandmortyapi.com/api/"

private class TransportForRaM: Transport {
    
    func fetchCharacters(_ page:Int, completion: @escaping (Result<CharacterInfo,TransportError>) -> Void) {
        let urlString = baseURL + "character" + "/?page=" + String(page)

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
                let parser = CharacterParser()
                let characters = try parser.parsJSON(data: data)
                    completion(.success(characters))
            } catch {
                    completion(.failure(.parsing))
            }
        }
        task.resume()
    }
    func fetchEpisode(_ episodeUrl:String, completion: @escaping (Result<EpisodeRM,TransportError>) -> Void) {
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
                let parser = EpisodeParser()
                let characters = try parser.parsJSON(data: data)
                    completion(.success(characters))
            } catch {
                    completion(.failure(.parsing))
            }
        }
        task.resume()
    }
    func fetchOrigin(_ originUrl:String, completion: @escaping (Result<CharacterOrigin,TransportError>) -> Void) {
        let urlString = originUrl

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
                let parser = OriginParser()
                let characters = try parser.parsJSON(data: data)
                    completion(.success(characters))
            } catch {
                    completion(.failure(.parsing))
            }
        }
        task.resume()
    }
}

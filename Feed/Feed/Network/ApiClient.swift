//
// Created by Иван Лизогуб on 11.02.2021.
//

import Foundation

class ApiClient {
    private let apiKey = "d6e7caff0c4ffdc48aa4f36d4ae8b3cc"
    
    private let includeAdult = false
    private let includeVideo = false
    private lazy var baseComponents: URLComponents = {
        var result = URLComponents()

        result.scheme = "https"
        result.host = "api.themoviedb.org"
        result.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "include_adult", value: "\(includeAdult)"),
            URLQueryItem(name: "include_video", value: "\(includeVideo)")
        ]
        return result
    }()

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()


    func requestMovies<T: Decodable>(params: MoviesParams, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = makeURL(with: params) else {
            completion(.failure(InternalError.wrongURL))
            return
        }
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) -> () in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            else if let data = data {
                DispatchQueue.main.async {
                    do {
                        let decodedObject = try self.decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(decodedObject))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(InternalError.InternalServerError))
                }
            }
        }
        dataTask.resume()
    }


    private func makeURL(with params: MoviesParams) -> URL? {
        var result = baseComponents
        result.path = "/3/discover/movie"
        result.queryItems?.append(contentsOf: [URLQueryItem(name: "page", value: "\(params.page)")])
        return result.url
    }
}

private enum InternalError: Error {
    case wrongURL
    case InternalServerError
}
//
//  NetworkingService.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import Foundation


enum networkingError:Error{
    case invalidInput
    case invalidURL
    case badResponse
    case error
    case nilData
    
    case notFound
}


class NetworkingSerivce{
    
    func getRequest<T:Decodable>(path:String, completion:@escaping (Result<T,networkingError>)->()){
        
        //Base URL
        //        let path = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        //Creating URL
        let url = URL(string: path)
        
        //Checking URL
        guard let url = url else {
            print("Error:Invalid url")
            completion(.failure(.invalidURL))
            return
        }
        
        //Request & Session
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error:\(String(describing: error?.localizedDescription))")
                completion(.failure(.error))
                return
            }
            
            
            if let httpResponse = response as? HTTPURLResponse{
                print ("httpResponse.statusCode: \(httpResponse.statusCode)")
                if (200 < httpResponse.statusCode) && (httpResponse.statusCode>299){
                    print("Suc")
                }
                else{
                    print("Bad")
                }
            }
            
            
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404{
                completion(.failure(.notFound))
                print("not found city")
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                let decodedData = try? decoder.decode(T.self, from: data)
                
                if decodedData == nil{
                    completion(.failure(.nilData))
                }
                if let decodedData = decodedData{                   //or we can force unwrap it also
                    completion(.success(decodedData))
                }
                //                do{
                //                    let finalData = try decoder.decode(T.self, from: data)
                //                    completion(.success(finalData))
                //                }
                //                catch{
                //                    print("errror agin")
                //                    completion(.failure(.nilData))
                //                }
            }
        }.resume()
    }
}


enum NetworkingError:Error{
    case badURL
    case badResponse
    case decodingFailed
    case unknownError
    
    case encodingFailed
}

protocol Networking{
    func postJSON<E:Encodable, D:Decodable>(url urlString:String,requestData:E,responseType:D.Type)async throws->D
    func postJSONFormData<D:Decodable>(url urlString:String,requestData:[String:Any],responseType:D.Type)async throws->D
    func getJSON<T:Decodable>(url urlString:String,type:T.Type)async throws -> T
}


protocol NetworkingHelper{
    func makeRequest(url urlString:String)throws ->URLRequest
    func decodeData<T:Decodable>(data:Data,type:T.Type)throws->T
    func getPostString(params:[String:Any]) -> String
}


/*
 Task --> .yield()
 Priority of Tasks
 
 Child task inherentane from parent task
 -> .detached() { DO NOT USE! }
 -> Task Group
 -> Cancel Task (or) use .task{ } modifier, it handles cancelling for tasks
    -> Check cancellation
 -> async let -> Multiple async at once, waiting for all
 
 */
//Actors are basically classes but thread Safe
//Probaly OverKill in this situation
actor NetworkingManager{
    
    func postJSON<E:Encodable, D:Decodable>(url urlString:String,requestData:E,responseType:D.Type)async throws->D{
        do{
            //Request
            var request = try makeRequest(url: urlString)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = try encodeData(requestData: requestData)
            
            //URL Session..
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let res = response as? HTTPURLResponse, (200..<300).contains(res.statusCode) else{
                print(">>Bad Response")
                throw NetworkingError.badResponse
            }
            print(">>Response: \(res.statusCode)")
            
            //Decoding Data
            let decodedData = try decodeData(data: data, type: D.self)
            return decodedData
        }
        catch(let error){
            throw error
        }
    }
    
    
    func postJSONFormData<D:Decodable>(url urlString:String,requestData:[String:Any],responseType:D.Type,token:String = "")async throws->D{
        do{
            //Request
            var request = try makeRequest(url: urlString)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            if !token.isEmpty{
                request.setValue( "\(token)", forHTTPHeaderField: "Token")
            }
            
            print("")
            let postString = getPostString(params: requestData)
            request.httpBody = postString.data(using: .utf8)
            
            //URL Session..
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let res = response as? HTTPURLResponse, (200..<300).contains(res.statusCode) else{
                print(">>Bad Response")
                throw NetworkingError.badResponse
            }
            print(">>Response: \(res.statusCode)")
            
            //Decoding Data
            let decodedData = try decodeData(data: data, type: D.self)
            return decodedData
        }
        catch(let error){
            throw error
        }
    }
    
    func getJSON<T:Decodable>(url urlString:String,type:T.Type)async throws -> T{
        
        do{
            let request = try makeRequest(url: urlString)
            
            let (data,response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse, (200..<300).contains(res.statusCode) else{
                Logger.logError("Bad Response")
                throw NetworkingError.badResponse
            }
            
            Logger.logMessage("Response: \(res.statusCode)")
            
            let decodedData = try decodeData(data: data, type: T.self)
            return decodedData
        }
        
        catch(let error){
            Logger.logError("Error Occured: \(error.localizedDescription)")
            throw error
        }
    }
}




extension NetworkingManager{
    
    private func makeRequest(url urlString:String)throws ->URLRequest {
        guard let url = URL(string: urlString)
        else {
            Logger.logError("Invalid URL")
            throw NetworkingError.badURL
        }
        
        return URLRequest(url: url)
    }
    
    private func encodeData<E:Encodable>(requestData:E)throws->Data{
        let encoder = JSONEncoder()
        do{
            let encodedData = try encoder.encode(requestData)
            return encodedData
        }
        catch{
            throw NetworkingError.encodingFailed
        }
    }
    
    private func decodeData<T:Decodable>(data:Data,type:T.Type)throws->T{
        let decoder = JSONDecoder()
        do{
            
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        }
        catch{
            Logger.logError("Decoding Failed")
            throw NetworkingError.decodingFailed
        }
    }
    
    private func getPostString(params:[String:Any]) -> String{
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}

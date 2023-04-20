//
//  ViewController.swift
//  getting method
//
//  Created by Donald Ng on 12/04/2023.
//

import UIKit

 

class ViewController: UIViewController {

 

    override func viewDidLoad() {
        super.viewDidLoad()
    }

 

    struct Account: Codable {
        let id: Int
        let first_name: String
        let last_name: String
        let username: String
        let password:String
        let email: String
    }

    struct exercise: Codable {
        let id: Int
        let exercise_type: String
        let datetime: String
        let account: Int
        let quality:String
        let video_file: URL
        let csv_file: URL
    }
    
    struct workout: Codable {
        let id: Int
        let account: Int
        let startTime: String
        let endTime: String
    }
 

    @IBAction func button(_ sender: Any) {
        guard let url = URL(string: "http://192.168.0.21:8000/api/accounts/") else {
            return
        }

 

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

 

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

 

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response: \(String(describing: response))")
                return
            }

 

            guard let data = data else {
                print("No data received.")
                return
            }

 



 

            do {
                let accounts = try JSONDecoder().decode([Account].self, from: data)
                print("Accounts: \(accounts)")
            } catch {
                print("Error decoding response data: \(error.localizedDescription)")
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .typeMismatch(let type, let context):
                        print("Type mismatch for type '\(type)': \(context.debugDescription)")
                    case .valueNotFound(let type, let context):
                        print("Value not found for type '\(type)': \(context.debugDescription)")
                    case .keyNotFound(let key, let context):
                        print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context.debugDescription)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
            }
        }

 

        task.resume()
    }
    
    
    
    
    
    
    @IBAction func getexercisebutton(_ sender: Any) {
        
        guard let url = URL(string: "http://192.168.0.21:8000/api/exercises/1/") else {
            return
        }
        //create a HTTP get request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("No data received.")
                return
            }
            do {
                let exercises = try JSONDecoder().decode([exercise].self, from: data)
                print("exercises: \(exercises)")
            } catch {
                print("Error decoding response data: \(error.localizedDescription)")
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .typeMismatch(let type, let context):
                        print("Type mismatch for type '\(type)': \(context.debugDescription)")
                    case .valueNotFound(let type, let context):
                        print("Value not found for type '\(type)': \(context.debugDescription)")
                    case .keyNotFound(let key, let context):
                        print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context.debugDescription)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
            }
        }

 

        task.resume()
    }
    
    
    @IBAction func getworkoutbutton(_ sender: Any) {
        guard let url = URL(string: "http://192.168.0.21:8000/api/workouts/1/") else {
            return
        }

 

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

 

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

 

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response: \(String(describing: response))")
                return
            }

 

            guard let data = data else {
                print("No data received.")
                return
            }

 



            do {
                let workouts = try JSONDecoder().decode([workout].self, from: data)
                print("Workouts: \(workouts)")
            } catch {
                print("Error decoding response data: \(error.localizedDescription)")
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .typeMismatch(let type, let context):
                        print("Type mismatch for type '\(type)': \(context.debugDescription)")
                    case .valueNotFound(let type, let context):
                        print("Value not found for type '\(type)': \(context.debugDescription)")
                    case .keyNotFound(let key, let context):
                        print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context.debugDescription)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
            }
        }

 

        task.resume()
        
    }
    
    
    
    @IBAction func getexercisebyworkoutbutton(_ sender: Any) {
        //url
        let id = 4
        guard let url = URL(string: "http://192.168.0.21:8000/api/exercises_by_workout/\(id)/") else {
            return
        }
        // creating a http get request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response: \(String(describing: response))")
                return
            }


            guard let data = data else {
                print("No data received.")
                return
            }

            //decode the json file that is retrieve from the server
            do {
                let workouts = try JSONDecoder().decode([exercise].self, from: data)
                print("Workouts: \(workouts)")
            } catch {
                print("Error decoding response data: \(error.localizedDescription)")
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .typeMismatch(let type, let context):
                        print("Type mismatch for type '\(type)': \(context.debugDescription)")
                    case .valueNotFound(let type, let context):
                        print("Value not found for type '\(type)': \(context.debugDescription)")
                    case .keyNotFound(let key, let context):
                        print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context.debugDescription)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
            }
        }

 

        task.resume()
        
    }
    
    
    
    
    @IBAction func getspecificaccountbutton(_ sender: Any) {
        let id = 1
        guard let url = URL(string: "http://192.168.0.21:8000/api/account/\(id)") else {
            return
        }

 

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

 

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

 

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response: \(String(describing: response))")
                return
            }

 

            guard let data = data else {
                print("No data received.")
                return
            }

 



 

            do {
                let accounts = try JSONDecoder().decode(Account.self, from: data)
                print("Accounts: \(accounts)")
            } catch {
                print("Error decoding response data: \(error.localizedDescription)")
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .typeMismatch(let type, let context):
                        print("Type mismatch for type '\(type)': \(context.debugDescription)")
                    case .valueNotFound(let type, let context):
                        print("Value not found for type '\(type)': \(context.debugDescription)")
                    case .keyNotFound(let key, let context):
                        print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context.debugDescription)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
            }
        }

 

        task.resume()
    }
    
    @IBAction func deleteaccountbutton(_ sender: Any) {
        let id = 2 
        let urlString = "http://192.168.0.21:8000/api/account/\(id)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if response.statusCode == 204 {
                print("Account deleted successfully")
            } else {
                print("Failed to delete account. Status code: \(response.statusCode)")
            }
        }

        task.resume()

    }
    
}

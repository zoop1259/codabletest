//
//  ViewController.swift
//  codabletest
//
//  Created by 강대민 on 2021/12/10.
//

//import UIKit
//import Foundation
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//
//        getData()
//    }
//
//    func getData() {
//        let urlString = "https://api.sunrise-sunset.org/json?date=2020-8-1&lng=37.3230&lat=-122.0322&formatted=0"
//
//        guard let url = URL(string: urlString) else {
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//
//            print(data)
//
//            var result: APIResponse?
//            do {
//                result = try JSONDecoder().decode(APIResponse.self, from: data)
//            }
//            catch {
//                print("Failed to decode with error: \(error)")
//            }
//
//
//            guard let final = result else {
//                return
//            }
//
//            print(final.results.sunset)
//            print(final.results.sunrise)
//            print(final.results.day_length)
//        })
//
//        task.resume()
//
//    }
//
//    struct APIResponse: Codable {
//        let results: APIResponseResults //안에 객체들이 또 있으니 string으로 만들지 않는다.
//        let status: String
//    }
//
//    struct  APIResponseResults: Codable {
//        let sunrise: String
//        let sunset: String
//        let solar_noon: String
//        let day_length: Int
//        let civil_twilight_begin: String
//        let civil_twilight_end: String
//        let nautical_twilight_begin: String
//        let nautical_twilight_end: String
//        let astronomical_twilight_begin: String
//        let astronomical_twilight_end: String
//    }
//
//
//}

/*
{
  "results": {
    "sunrise": "2020-08-01T01:43:09+00:00",
    "sunset": "2020-08-01T17:30:54+00:00",
    "solar_noon": "2020-08-01T09:37:02+00:00",
    "day_length": 56865,
    "civil_twilight_begin": "2020-08-01T02:25:23+00:00",
    "civil_twilight_end": "2020-08-01T16:48:40+00:00",
    "nautical_twilight_begin": "2020-08-01T03:13:26+00:00",
    "nautical_twilight_end": "2020-08-01T16:00:37+00:00",
    "astronomical_twilight_begin": "2020-08-01T03:59:25+00:00",
    "astronomical_twilight_end": "2020-08-01T15:14:39+00:00"
  },
  "status": "OK"
}
*/

//   let NameList = try? newJSONDecoder().decode(ChampList.self, from: jsonData)
import UIKit
import Foundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getData()
    }
    
    func getData() {
        let urlString = "http://ddragon.leagueoflegends.com/cdn/11.23.1/data/ko_KR/champion.json"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            //print(data)
            
            var result: NameList?
            do {
                result = try JSONDecoder().decode(NameList.self, from: data)
            }
            catch {
                print("Failed to decode with error: \(error)")
            }
            
            
            guard let final = result else {
                return
            }
            
            print(final.version)
            
            print(final.data.ahri.name)
            print(final.data.ahri.image.full)
            
        })
        
        task.resume()
        
        // MARK: - ChampList
        struct NameList: Codable {
            let type, format, version: String
            let data: DataClass
        }

        // MARK: - DataClass
        struct DataClass: Codable {
            let aatrox, ahri, akali: Aatrox

            enum CodingKeys: String, CodingKey {
                case aatrox = "Aatrox"
                case ahri = "Ahri"
                case akali = "Akali"
            }
        }

        // MARK: - Aatrox
        struct Aatrox: Codable {
            let version, id, key, name: String
            let title, blurb: String
            let info: Info
            let image: Image
            let tags: [String]
            let partype: String
            let stats: [String: Double]
        }

        // MARK: - Image
        struct Image: Codable {
            let full, sprite, group: String
            let x, y, w, h: Int
        }

        // MARK: - Info
        struct Info: Codable {
            let attack, defense, magic, difficulty: Int
        }

    }
    
    
    //        // MARK: - ChampList
    //        struct NameList: Codable {
    //            let type: TypeEnum
    //            let format: String
    //            let version: String
    //            let data: [String: Datum]
    //        }
    //
    //        // MARK: - Datum
    //        struct Datum: Codable {
    //            let version: String
    //            let id, key, name, title: String
    //            let blurb: String
    //            let info: Info
    //            let image: Image
    //            let tags: [Tag]
    //            let partype: Partype
    //            let stats: [String: Double]
    //        }
    //
    //        // MARK: - Image
    //        struct Image: Codable {
    //            let full: String
    //            let sprite: Sprite
    //            let group: TypeEnum
    //            let x, y, w, h: Int
    //        }
    //
    //        enum TypeEnum: String, Codable {
    //            case champion = "champion"
    //        }
    //
    //        enum Sprite: String, Codable {
    //            case champion0PNG = "champion0.png"
    //            case champion1PNG = "champion1.png"
    //            case champion2PNG = "champion2.png"
    //            case champion3PNG = "champion3.png"
    //            case champion4PNG = "champion4.png"
    //            case champion5PNG = "champion5.png"
    //        }
    //
    //        // MARK: - Info
    //        struct Info: Codable {
    //            let attack, defense, magic, difficulty: Int
    //        }
    //
    //        enum Partype: String, Codable {
    //            case 기력 = "기력"
    //            case 기류 = "기류"
    //            case 마나 = "마나"
    //            case 보호막 = "보호막 "
    //            case 분노 = "분노"
    //            case 없음 = "없음"
    //            case 열기 = "열기"
    //            case 용기 = "용기"
    //            case 투지 = "투지"
    //            case 피의샘 = "피의 샘"
    //            case 핏빛격노 = "핏빛 격노"
    //            case 흉포 = "흉포"
    //        }
    //
    //        enum Tag: String, Codable {
    //            case assassin = "Assassin"
    //            case fighter = "Fighter"
    //            case mage = "Mage"
    //            case marksman = "Marksman"
    //            case support = "Support"
    //            case tank = "Tank"
    //        }
            
            // This file was generated from JSON Schema using quicktype, do not modify it directly.
            // To parse the JSON, add this file to your project and do:
            //
            //   let champList = try? newJSONDecoder().decode(ChampList.self, from: jsonData)

}



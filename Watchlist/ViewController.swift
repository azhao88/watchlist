//
//  ViewController.swift
//  queue
//
//  Created by Anthony Zhao on 4/29/18.
//  Copyright © 2018 Anthony Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation

class ViewController: UIViewController{

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var rottenTomatoesLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var watchLabel: UILabel!
    
    @IBOutlet weak var rottenImage: UIImageView!
    @IBOutlet weak var imdbImage: UIImageView!
    @IBOutlet weak var runtimeLabel2: UILabel!
    @IBOutlet weak var directorLabel2: UILabel!
    @IBOutlet weak var genreLabel2: UILabel!
    @IBOutlet weak var ratingLabel2: UILabel!
    
    
    
    
    let idArray = [
        "tt0111161",
        "tt0068646",
        "tt0071562",
        "tt0468569",
        "tt0050083",
        "tt0060196",
        "tt0108052",
        "tt0110912",
        "tt0167260",
        "tt0080684",
        "tt0109830",
        "tt0120737",
        "tt0137523",
        "tt1375666",
        "tt0073486",
        "tt0099685",
        "tt0133093",
        "tt0167261",
        "tt0076759",
        "tt0102926",
        "tt0110413",
        "tt0114369",
        "tt0114814",
        "tt0118799",
        "tt0120815",
        "tt0245429",
        "tt0317248",
        "tt0816692",
        "tt0034583",
        "tt0054215",
        "tt0078748",
        "tt0078788",
        "tt0082971",
        "tt0088763",
        "tt0103064",
        "tt0110357",
        "tt0120586",
        "tt0120689",
        "tt0172495",
        "tt0209144",
        "tt0253474",
        "tt0407887",
        "tt0482571",
        "tt1675434",
        "tt2582802",
        "tt0081505",
        "tt0090605",
        "tt0112573",
        "tt0169547",
        "tt0364569",
        "tt0411008",
        "tt0455275",
        "tt0910970",
        "tt1345836",
        "tt1520211",
        "tt1853728",
        "tt0062622",
        "tt0066921",
        "tt0071853",
        "tt0075314",
        "tt0086190",
        "tt0086250",
        "tt0093058",
        "tt0097576",
        "tt0105236",
        "tt0114709",
        "tt0119217",
        "tt0119488",
        "tt0180093",
        "tt0208092",
        "tt0211915",
        "tt0338013",
        "tt0361748",
        "tt0372784",
        "tt0435761",
        "tt1049413",
        "tt0083658",
        "tt0095016",
        "tt0113277",
        "tt0117951",
        "tt0120735",
        "tt0268978",
        "tt0434409",
        "tt0457430",
        "tt0993846",
        "tt2096673",
        "tt0075148",
        "tt0107290",
        "tt0116282",
        "tt0118715",
        "tt0120382",
        "tt0167404",
        "tt0198781",
        "tt0246578",
        "tt0264464",
        "tt0266543",
        "tt0266697",
        "tt0405159",
        "tt0469494",
        "tt0477348",
        "tt0758758",
        "tt0848228",
        "tt0892769",
        "tt1130884",
        "tt1201607",
        "tt1205489",
        "tt1392190",
        "tt1392214",
        "tt2015381",
        "tt2024544",
        "tt2267998",
        "tt2278388",
        "tt3315342",
        "tt0073195",
        "tt0088247",
        "tt0095953",
        "tt0107048",
        "tt0114746",
        "tt0317705",
        "tt0325980",
        "tt0365748",
        "tt0378194",
        "tt0381061",
        "tt0382932",
        "tt0401792",
        "tt0440963",
        "tt0450259",
        "tt0796366",
        "tt0947798",
        "tt1010048",
        "tt1431045",
        "tt1504320",
        "tt1659337",
        "tt1663202",
        "tt1798709",
        "tt1877832",
        "tt2084970",
        "tt2488496",
        "tt3659388",
        ]
    
    let key = "9c02bf5"
    var favoritesArray = [Movie]()
    var soundPlayer = AVAudioPlayer()
    var oldFrame: CGRect!
    var counter = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.isHidden = true
        ratingLabel2.isHidden = true
        genreLabel2.isHidden = true
        directorLabel2.isHidden = true
        runtimeLabel2.isHidden = true
        posterImage.isHidden = true
        rottenImage.isHidden = true
        imdbImage.isHidden = true
        oldFrame = posterImage.frame
    }
    
    //MARK:- Functions
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        //can we load a sound
        if let sound = NSDataAsset(name: soundName) {
            //check if sound.data is a sound file
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: data in \(soundName) couldn't be played as a sound")
            }
        } else {
            print("ERROR: file \(soundName) didn't load")
        }
    }
    
    func hideLabels(bool: Bool) {
        titleLabel.isHidden = bool
        ratingLabel.isHidden = bool
        genreLabel.isHidden = bool
        directorLabel.isHidden = bool
        runtimeLabel.isHidden = bool
        ratingLabel2.isHidden = bool
        genreLabel2.isHidden = bool
        directorLabel2.isHidden = bool
        runtimeLabel2.isHidden = bool
        rottenImage.isHidden = bool
        rottenTomatoesLabel.isHidden = bool
        imdbImage.isHidden = bool
        imdbLabel.isHidden = bool
        plotLabel.isHidden = bool
        button.isHidden = bool
        watchLabel.isHidden = bool
    }
    
    
    @IBAction func posterTapped(_ sender: Any) {
        
        let newFrame = CGRect(x: 20, y: 20, width: view.frame.width - 40, height: view.frame.height - 40)
        
        if counter == 0 {
            
            UIView.animate(withDuration: 0.5, animations: {self.posterImage.frame = newFrame})
            counter = 1
            hideLabels(bool: true)
            
            } else {
            
            UIView.animate(withDuration: 0.5, animations: {self.posterImage.frame = self.oldFrame})
            counter = 0
            hideLabels(bool: false)
        }
    }
    
    
    func callOMDB() {
        self.playSound(soundName: "moviesound", audioPlayer: &self.soundPlayer)
        
        titleLabel.isHidden = false
        ratingLabel2.isHidden = false
        genreLabel2.isHidden = false
        directorLabel2.isHidden = false
        runtimeLabel2.isHidden = false
        posterImage.isHidden = false
        rottenImage.isHidden = false
        imdbImage.isHidden = false
        
        let randNum = Int(arc4random_uniform(UInt32(idArray.count)))
        let id = idArray[randNum]
        let searchURL = "http://www.omdbapi.com/?i=\(id)&apikey=\(key)"
        
        Alamofire.request(searchURL).responseJSON { response in
            print(response)
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                let title = json["Title"].stringValue
                let year = json["Year"].stringValue
                let rated = json["Rated"].stringValue
                let genre = json["Genre"].stringValue
                let plot = json["Plot"].stringValue
                let director = json["Director"].stringValue
                let runtime = json["Runtime"].stringValue
                let imdb = json["Ratings"][0]["Value"].stringValue
                let rottenTomatoes = json["Ratings"][1]["Value"].stringValue
                let poster = json["Poster"].stringValue
//
//                let randomMovie = (Movie(title: title, year: year, rated: rated, genre: genre, plot: plot, director: director,  runtime: runtime, imdb: imdb, rottenTomatoes: rottenTomatoes, poster: poster))
//                self.movieArray.append(randomMovie)
                
                let url = NSURL(string: poster)
                let data = NSData(contentsOf : url! as URL)
                let image = UIImage(data: data! as Data)
                
                self.titleLabel.text = "\(title) (\(year))"
                self.ratingLabel.text = rated
                self.genreLabel.text = genre
                self.directorLabel.text = director
                self.runtimeLabel.text = runtime
                self.posterImage.image = image
                self.plotLabel.text = "Synopsis: \(plot)"
                self.rottenTomatoesLabel.text = rottenTomatoes
                self.imdbLabel.text = imdb

            case.failure(let error):
                print("Error, could not grab movie data")
            }
        }
    }
    
    


    
    @IBAction func randomMoviePressed(_ sender: Any) {
        button.setTitle("Try Again", for: .normal)
        callOMDB()
        
    }
    
}



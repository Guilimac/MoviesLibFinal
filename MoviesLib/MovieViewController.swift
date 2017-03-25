//
//  ViewController.swift
//  MoviesLib
//
//  Created by Eric on 06/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MovieViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var tvSinopsis: UITextView!
    @IBOutlet weak var lcButtonX: NSLayoutConstraint!
    @IBOutlet weak var viTrailler: UIView!
    
    // MARK: Properties
    var movie: Movie!
    var moviePlayer: AVPlayer!
    var moviePlayerController: AVPlayerViewController!
    
    
    
    // MARK: Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareVideo()
        if UserDefaults.standard.bool(forKey: SettingTypes.autoPlay.rawValue){
            changeMovieeStatus(play: true)
            
        }else{
            let old = ivPoster.frame.height
            ivPoster.frame.size.height = 0
            UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseInOut, animations: { 
                self.ivPoster.frame.size.height = old
            }, completion: { (success: Bool) in
                print("fim da animação")
            })
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ivPoster.image = UIImage(named: movie.imageWide)
        lbTitle.text = movie.title
        lbDuration.text = movie.duration
        lbScore.text = "⭐️ \(movie.rating)/10"
        if let categories = movie.categories {
            lbGenre.text = categories.map({($0 as! Category).name!}).joined(separator: " | ")
        }
        if let image = movie.poster as? UIImage {
            ivPoster.image = image
        }
        tvSinopsis.text = movie.summary
    }
    @IBAction func playVideo(_ sender: UIButton) {
        sender.isHidden = true
        changeMovieeStatus(play: true)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieRegisterViewController {
            vc.movie = movie
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        changeMovieeStatus(play: false)
        
    }

    func prepareVideo(){
        let url = URL(string: "http://goo.gl/8XmNn8")!
        moviePlayer = AVPlayer(url: url)
        moviePlayerController = AVPlayerViewController()
        moviePlayerController.player = moviePlayer
        moviePlayerController.showsPlaybackControls = true
        moviePlayerController.view.frame = viTrailler.bounds
        viTrailler.addSubview(moviePlayerController.view)
        
    }
    func changeMovieeStatus(play:Bool){
        viTrailler.isHidden=false
        if play{
        moviePlayer.play()
        }else{
            moviePlayer.pause()
        }
    }
    
}

//
//  MovieRegisterViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 17/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit

class MovieRegisterViewController: UIViewController {

    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var lbCategories: UILabel!
    @IBOutlet weak var tfRating: UITextField!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var tvSummary: UITextView!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var btAddUpdate: UIButton!
    
    var movie: Movie!
    var smallImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if movie != nil {
            
            tfTitle.text = movie.title
            tfRating.text = "\(movie.rating)"
            tfDuration.text = movie.duration
            tvSummary.text = movie.summary
            if let image = movie.poster as? UIImage{
                ivPoster.image = image
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CategoriesViewController;
        if movie == nil {
            movie = Movie(context: context)
        }
        vc.movie = movie
    }
    @IBAction func addPoster(_ sender: UIButton) {
        let alert = UIAlertController(title: "Poster!", message: "Qual origem da foto?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            }
            
            alert.addAction(cameraAction)
            
        }
        
        
        
        let libraryAction = UIAlertAction(title: "Biblioteca", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
            
        }
        alert.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func close(_ sender: UIButton?) {
        dismiss(animated: true, completion: nil)
        if(movie != nil && movie.title == nil){
            context.delete(movie)
        }
    }
    
    func selectPicture(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addUpdateMovie(_ sender: UIButton) {
        if movie == nil {
            movie = Movie(context: context)
        }
        movie.title = tfTitle.text!
        movie.rating = Double(tfRating.text!)!
        movie.summary = tvSummary.text
        movie.duration = tfDuration.text
        if(smallImage != nil){
            movie.poster = smallImage
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        close(nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if movie != nil {
            
            
            if let categories = movie.categories{
                if categories.count > 0 {
                    lbCategories.text = categories.map({($0 as! Category).name!}).joined(separator:" | ")
                }else{
                    lbCategories.text = "Categorias"
                }
            }
            
            
            btAddUpdate.setTitle("Atualizar", for: .normal)
        }
    }
    
    
    
    
    
}

extension MovieRegisterViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: AnyObject]?) {
        
        let smallSize = CGSize(width: 300, height: 280)
        UIGraphicsBeginImageContext(smallSize)
        image.draw(in: CGRect(x: 0, y: 0, width: smallSize.width, height: smallSize.height))
        smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        ivPoster.image = smallImage
        
        dismiss(animated: true, completion: nil)
    }
}

//
//  PlanetCell.swift
//  AstronomyPhotos
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class PlanetCell: UITableViewCell {

  @IBOutlet weak var planetImageView: UIImageView!
  // objective: stop flickering while dequeue resusable cells
  // solution: keep track of the image url string by using a string variable on the cell
  
  private var urlString = ""
  
  override func prepareForReuse() {
    super.prepareForReuse()
    // empty out the image view
    planetImageView.image = nil
  }
  
  func configureCell(with urlString: String) {
    
    // set the cell's urlString
    self.urlString = urlString
    
    planetImageView.getImage(with: urlString) { [weak self] result in
      switch result {
      case .failure:
        DispatchQueue.main.async {
          self?.planetImageView.image = UIImage(systemName: "exclamationmark.triangle")
        }
      case .success(let image):
        DispatchQueue.main.async {
          
          // only if the cell's urlString is the same as the one being
          // passed in from the cellForRowAt will we change the current
          // image view's image
          // 1. self.urlSring is the cell's property
          // 2. urlString is the argument from our configureCell method
          if self?.urlString == urlString {
            self?.planetImageView.image = image
          }
          
        }
      }
    }
  }
  
}

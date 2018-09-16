import UIKit
import Imaginary

open class LightboxImage {
  
  open fileprivate(set) var image: UIImage?
  open fileprivate(set) var imageURL: URL?
  open fileprivate(set) var imageClosure: (() -> UIImage?)?
  open fileprivate(set) var videoURLClosure:(() -> URL?)?
  open var text: String
  
  // MARK: - Initialization
  
  internal init(text: String = "") {
    self.text = text
  }

  public init(image: UIImage, text: String = "", videoURLClosure: @escaping (() -> URL)? = nil) {
    self.image = image
    self.text = text
    self.videoURLClosure = videoURLClosure
  }

  public init(imageURL: URL, text: String = "", videoURLClosure: @escaping (() -> URL)? = nil) {
    self.imageURL = imageURL
    self.text = text
    self.videoURLClosure = videoURLClosure
  }
  
  public init(imageClosure: @escaping () -> UIImage?, text: String = "", videoURLClosure: @escaping (() -> URL)? = nil) {
    self.imageClosure = imageClosure
    self.text = text
    self.videoURLClosure = videoURLClosure
    let lul = videoURLClosure!()
  }
  
  open func addImageTo(_ imageView: UIImageView, completion: ((UIImage?) -> Void)? = nil) {
    if let image = image {
      imageView.image = image
      completion?(image)
    } else if let imageURL = imageURL {
      LightboxConfig.loadImage(imageView, imageURL, completion)
    } else if let imageClosure = imageClosure {
      let img = imageClosure()
      imageView.image = img
      completion?(img)
    } else {
      imageView.image = nil
      completion?(nil)
    }
  }
}

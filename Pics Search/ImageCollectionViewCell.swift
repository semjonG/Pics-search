//
//  ImageCollectionViewCell.swift
//  Pics Search
//
//  Created by mac on 07.12.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
//    cell id
    static let identifier = "ImageCollectionViewCell"
    
//    imageView
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
//    раскладка
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
//    функция принимает URL
    func configure(with urlString: String) {
//        создаем объект URL из типа String
        guard let url = URL(string: urlString) else {
            return
        }
//        получение данных по URL и конвертация их в image
        URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageView.image = image
            }
        } .resume()
    }
}

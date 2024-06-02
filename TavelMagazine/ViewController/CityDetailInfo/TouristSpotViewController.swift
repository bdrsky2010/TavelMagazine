//
//  TouristSpotViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import UIKit

class TouristSpotViewController: UIViewController {

    static let identifier = "TouristSpotViewController"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var topNicknameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var numberOfSaveLabel: UILabel!
    
    @IBOutlet var starImageViewList: [UIImageView]!
    
    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var bottomNicknameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public var row: Int?
    public var delegate: TravelDelegate?
    
    public var travel: Travel?
    public var profileImageURL: URL?
    public var profileName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        configureUI()
    }
}

extension TouristSpotViewController {
    
    private func configureUI() {
        
        guard let travel else { return }
        
        configureProfileImageView()
        configureTopNicknameLabel(nickname: profileName ?? "")
        configureMainImageView(imageURL: travel.travel_image?.stringToURL)
        configureLikeImageView(isLike: travel.like ?? false)
        configureNumberOfSaveLabel(numberOfSave: "저장 \((travel.save ?? 0).formatted())")
        configureStarImageViewList(grade: travel.roundGradeToInt)
        configureGradeLabel(grade: travel.grade ?? 0.0)
        configureBottomNicknameLabel(nickname: profileName ?? "")
        configureTitleLabel(title: travel.title)
        configureDescriptionLabel(description: travel.description ?? "")
    }
    
    private func configureProfileImageView() {
        
        configureImageView(profileImageView,
                           url: profileImageURL,
                           contentMode: .scaleAspectFill,
                           cornerRadius: profileImageView.frame.width / 2,
                           borderColor: UIColor.label.cgColor,
                           borderWidth: 1)
    }
    
    private func configureTopNicknameLabel(nickname: String) {
        
        configureLabel(topNicknameLabel, text: nickname, font: UIFont.systemFont(ofSize: 14, weight: .bold))
    }
    
    private func configureMainImageView(imageURL: URL?) {
        
        configureImageView(mainImageView, url: imageURL, contentMode: .scaleAspectFill)
    }
    
    private func configureLikeImageView(isLike: Bool) {
        
        configureImageView(likeImageView,
                           systemName: isLike ? "heart.fill" : "heart",
                           tintColor: .systemRed)
        
        let likeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeImageTapped))
        
        likeImageView.isUserInteractionEnabled = true
        likeImageView.addGestureRecognizer(likeTapGestureRecognizer)
    }
    
    @objc
    private func likeImageTapped(sender: UITapGestureRecognizer) {
        
        guard let row else { return }
        
        travel?.like?.toggle()
        delegate?.setCityCellLike?(row)
        
        if let isLike = travel?.like {
            configureImageView(likeImageView,
                               systemName: isLike ? "heart.fill" : "heart",
                               tintColor: .systemRed)
        }
    }
    
    private func configureNumberOfSaveLabel(numberOfSave: String) {
        configureLabel(numberOfSaveLabel, text: numberOfSave, font: UIFont.systemFont(ofSize: 15, weight: .bold))
    }
    
    private func configureStarImageViewList(grade: Int) {
        
        starImageViewList.enumerated().forEach {
            
            let index = $0.offset
            let imageView = $0.element
            
            let systemName = "star.fill"
            let tintColor: UIColor = index < grade ? .systemYellow : .systemGray3
            
            configureImageView(imageView, systemName: systemName, tintColor: tintColor)
        }
    }
    
    private func configureGradeLabel(grade: Double) {
        
        configureLabel(gradeLabel,
                       text: "(\(grade))",
                       font: .systemFont(ofSize: 14, weight: .bold))
    }
    
    private func configureBottomNicknameLabel(nickname: String) {
        
        configureLabel(bottomNicknameLabel, text: nickname, font: UIFont.systemFont(ofSize: 14, weight: .bold))
    }
    
    private func configureTitleLabel(title: String) {
        
        configureLabel(titleLabel, text: title, font: UIFont.systemFont(ofSize: 15, weight: .regular))
    }
    
    private func configureDescriptionLabel(description: String) {
        
        configureLabel(descriptionLabel, text: description, font: UIFont.systemFont(ofSize: 14, weight: .regular))
    }
    
    private func configureImageView(_ imageView: UIImageView, url: URL? = nil, systemName: String? = nil, contentMode: UIView.ContentMode? = nil, tintColor: UIColor? = nil, cornerRadius: CGFloat? = nil, borderColor: CGColor? = nil, borderWidth: CGFloat? = nil) {
        
        if let url { imageView.configureImageWithKF(url: url) }
        if let systemName { imageView.image = UIImage(systemName: systemName) }
        if let contentMode { imageView.contentMode = contentMode }
        if let tintColor { imageView.tintColor = tintColor }
        if let cornerRadius { imageView.layer.cornerRadius = cornerRadius }
        if let borderColor { imageView.layer.borderColor = borderColor }
        if let borderWidth { imageView.layer.borderWidth = borderWidth }
    }
    
    private func configureLabel(_ label: UILabel, text: String, font: UIFont? = nil, textColor: UIColor? = nil, textAlignment: NSTextAlignment? = nil, numberOfLines: Int? = nil) {
        
        if let font { label.font = font }
        if let textColor { label.textColor = textColor }
        if let textAlignment { label.textAlignment = textAlignment }
        if let numberOfLines { label.numberOfLines = numberOfLines }
        label.text = text
    }
}

extension TouristSpotViewController: CellToMoveViewControllerProtocol {
    
    func configureNavigation() {
        
        navigationItem.title = travel?.title
        navigationController?.navigationBar.tintColor = .label
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftBarButtonAction))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    private func leftBarButtonAction() {
        
        navigationController?.popViewController(animated: true)
    }
}

//
//  ViewController.swift
//  Destini
//
//  Created by Леонид Турко on 14.04.2023.
//

import UIKit
import SwiftUI
import SnapKit

class DestiniViewController: UIViewController {
  //  MARK: - Private Properties
  private lazy var backgroundImage: UIImageView = {
    let element = UIImageView()
    element.image = UIImage(named: "background")
    element.contentMode = .scaleAspectFill
    return element
  }()
  
  private lazy var stackView: UIStackView = {
    let element = UIStackView()
    element.axis = .vertical
    element.spacing = 15
    return element
  }()
  
  private lazy var storyLabel: UILabel = {
    let element = UILabel()
    element.text = "Story Text"
    element.textAlignment = .center
    element.textColor = .white
    element.font = UIFont.systemFont(ofSize: 30, weight: .medium)
    element.numberOfLines = 0
    return element
  }()
  
  private lazy var roseButton: UIButton = {
    let element = UIButton(type: .system)
    element.setBackgroundImage(UIImage(named: "choice1Background"), for: .normal)
    element.setTitle("Take a left", for: .normal)
    element.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
    element.tintColor = .white
    element.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    element.titleLabel?.lineBreakMode = .byWordWrapping
    return element
  }()
  
  private lazy var purpleButton: UIButton = {
    let element = UIButton(type: .system)
    element.setBackgroundImage(UIImage(named: "choice2Background"), for: .normal)
    element.setTitle("Take a right", for: .normal)
    element.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
    element.tintColor = .white
    element.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    element.titleLabel?.lineBreakMode = .byWordWrapping
    return element
  }()
  
  private var storyBrain = StoryBrain()

  //  MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setViews()
    setConstraints()
    updateUI()
  }
  
  @objc func buttonPressed(_ sender: UIButton) {
    guard let title = sender.currentTitle else { return }
    storyBrain.getNextStory(userChoice: title)
    updateUI()
  }
}

//  MARK: -  Private Methods
extension DestiniViewController {
  private func updateUI() {
    storyLabel.text = storyBrain.getStoryText()
    roseButton.setTitle(storyBrain.getRoseTitle(), for: .normal)
    purpleButton.setTitle(storyBrain.getPurpleTitle(), for: .normal)
    
  }
  
  private func setViews() {
    view.addSubview(backgroundImage)
    view.addSubview(stackView)
    stackView.addArrangedSubview(storyLabel)
    stackView.addArrangedSubview(roseButton)
    stackView.addArrangedSubview(purpleButton)
  }
  
  private func setConstraints() {
    backgroundImage.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    stackView.snp.makeConstraints { make in
      make.edges.equalTo(view.snp.margins)
    }
    
    roseButton.snp.makeConstraints { make in
      make.height.equalTo(100)
    }
    
    purpleButton.snp.makeConstraints { make in
      make.height.equalTo(roseButton.snp.height)
    }
  }
}

//  MARK: - Show Canvas
struct ContentViewController: UIViewControllerRepresentable {
  
  typealias UIViewControllerType = DestiniViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    return DestiniViewController()
  }
  
  func updateUIViewController(_ uiViewController: DestiniViewController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
  static var previews: some View {
    ContentViewController()
      .edgesIgnoringSafeArea(.all)
      .colorScheme(.light) // or .dark
  }
}

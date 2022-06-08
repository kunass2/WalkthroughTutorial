//
//  TutorialConfiguration.swift
//  WalkthroughTutorial
//
//  Created by Bartłomiej Semańczyk on 08/06/2022.
//
public class TutorialConfiguration {
    public var skipButtonTitle = "Skip"
    public var skipButtonColor = UIColor.white
    public var skipButtonFont = UIFont.systemFont(ofSize: 14)
    public var nextButtonTitle = "Next"
    public var nextButtonColor = UIColor.white
    public var nextButtonFont = UIFont.systemFont(ofSize: 14)
    public var titleColor = UIColor.white
    public var descriptionColor = UIColor.white
    public var titleFont = UIFont.boldSystemFont(ofSize: 32)
    public var descriptionFont = UIFont.systemFont(ofSize: 16)
    public var offset: CGFloat = 4
    public let blurEffect: UIBlurEffect
    
    public init(blurEffect: UIBlurEffect) {
        self.blurEffect = blurEffect
    }
}

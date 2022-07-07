//
//  UIOnboardingHelper.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 07.07.2022.
//

import UIKit
import UIOnboarding

struct UIOnboardingHelper {
    static func setUpIcon() -> UIImage {
        .init(named: Photos.lubaBlack120)!
    }
    
    // First Title Line
    // Welcome Text
    static func setUpFirstTitleLine() -> NSMutableAttributedString {
        .init(string: "Welcome to", attributes: [.foregroundColor: UIColor.label])
    }
    
    // Second Title Line
    // App Name
    static func setUpSecondTitleLine() -> NSMutableAttributedString {
        .init(
            string: "Verbovka",
            attributes: [ .foregroundColor: UIColor.successTaskColor ]
        )
    }
    
    static func setUpFeatures() -> Array<UIOnboardingFeature> {
        .init([
            .init(
                icon: .init(named: Photos.tort)!,
                title: "Знала, с кем общалась",
                description: "Хола сеньорита. Рады приветствовать Вас в нашем маленьком мирке свифтеров. Сейчас тебе предстоит НЕЛЕГКАЯ задача пройти вербовку на великий праздник этого года."
            ),
            .init(
                icon: .init(named: Photos.kos)!,
                title: "Загадки?",
                description: "Ты любишь сложности? Мы тебе их предоставили!\nМы собрали самые сложные загадки из потаенных уголков наших  “Капусток”"
            ),
            .init(
                icon: .init(named: Photos.hear)!,
                title: "Плюс уши",
                description: "Не забудь включить звук и наслаждаться процессом"
            )
        ])
    }
    
    static func setUpNotice() -> UIOnboardingTextViewConfiguration {
        // Иконка сердца
        .init(
            icon: .init(named: Photos.heart)!,
            text: "С наилучшими пожеланиями, твои друзья"
        )
    }
    
    static func setUpButton() -> UIOnboardingButtonConfiguration {
        .init(
            title: "Начать путешествие",
            titleColor: .darkBlueColor,
            backgroundColor: .successTaskColor
        )
    }
}

extension UIOnboardingViewConfiguration {
    static func setUp() -> UIOnboardingViewConfiguration {
        .init(
            appIcon: UIOnboardingHelper.setUpIcon(),
            firstTitleLine: UIOnboardingHelper.setUpFirstTitleLine(),
            secondTitleLine: UIOnboardingHelper.setUpSecondTitleLine(),
            features: UIOnboardingHelper.setUpFeatures(),
            textViewConfiguration: UIOnboardingHelper.setUpNotice(),
            buttonConfiguration: UIOnboardingHelper.setUpButton()
        )
    }
}

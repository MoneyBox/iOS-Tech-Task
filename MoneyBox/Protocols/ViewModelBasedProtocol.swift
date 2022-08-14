//
//  ViewModelBasedProtocol.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import UIKit
import Reusable

protocol ViewModelBased: AnyObject {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
}

extension ViewModelBased where Self: StoryboardSceneBased & UIViewController {

    static func instantiate(with viewModel: ViewModel) -> Self {
        let viewController = instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
}

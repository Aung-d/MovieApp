//
//  SearchViewDelegate.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation

protocol SearchViewDelegate {
    
    func didSearchButtonClicked(_ text: String)
    
    func didEnterSearch()
    
    func didCancelSearch()
}

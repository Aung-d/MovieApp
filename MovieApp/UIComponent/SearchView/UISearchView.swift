//
//  UISearchView.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import UIKit
import SnapKit

@IBDesignable
class UISearchView: UITextField, UITextFieldDelegate {
    
    private var contentInsetX: CGFloat = 45.0
    var searchDelegate: SearchViewDelegate?
    
    init() {
        super.init(frame: .zero)
        configureSearchView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSearchView()
    }
    
    private func configureSearchView() {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.delegate = self
        self.returnKeyType = UIReturnKeyType.search
        addLeftImage()
        addRightImage()
    }
    
    private func addLeftImage() {
        self.leftViewMode = .always
        let containerView = UIView()
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .white
        containerView.addSubview(imageView)
        self.leftView = containerView
        
        containerView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
        }
    }
    
    private func addRightImage() {
        self.rightViewMode = .never
        let containerView = UIView()
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        clearButton.tintColor = .lightGray
        clearButton.addTarget(
            self, action: #selector(onClearButtonClicked), for: .touchUpInside)
        containerView.addSubview(clearButton)
        self.rightView = containerView
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        clearButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc private func onClearButtonClicked() {
        self.rightViewMode = .never
        self.text = ""
        self.resignFirstResponder()
        searchDelegate?.didCancelSearch()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: contentInsetX, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: contentInsetX, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: contentInsetX, dy: 0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchDelegate?.didSearchButtonClicked(textField.text ?? "")
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        searchDelegate?.didEnterSearch()
        self.rightViewMode = .always
        return true
    }
    
}

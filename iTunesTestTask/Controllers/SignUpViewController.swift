//
//  SignUpViewController.swift
//  iTunesTestTask
//
//  Created by Никита Козловский on 14.10.2024.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "First Name"
        textField.delegate = self
        return textField
    }()
    
    private lazy var secondNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Second Name"
        textField.delegate = self
        return textField
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "email"
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.delegate = self
        return textField
    }()
    
    private lazy var firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ageValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Sign up", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
        return datePicker
    }()
    
    private lazy var elementsStackView = UIStackView(arrangedSubviews: [firstNameTextField, firstNameValidLabel, secondNameTextField, secondNameValidLabel, datePicker, ageValidLabel, phoneNumberTextField, phoneValidLabel, emailTextField, emailValidLabel, passwordTextField, passwordValidLabel], axis: .vertical, spacing: 10, distribution: .fillProportionally)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        title = "Sign Up"
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(signUpButton)
    }
    
    @objc private func signUpButtonTapped() {
        
    }
}

//MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
}

//MARK: - SetConstraints

extension SignUpViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            elementsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            elementsStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            elementsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            elementsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 30),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

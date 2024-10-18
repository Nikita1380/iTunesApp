//
//  ViewController.swift
//  iTunesTestTask
//
//  Created by Никита Козловский on 14.10.2024.
//

import UIKit

class AuthViewController: UIViewController {
    
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
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter password"
        textField.delegate = self
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter email"
        textField.delegate = self
        return textField
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
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Sign in", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textFieldStackView = UIStackView(
        arrangedSubviews: [emailTextField, passwordTextField],
        axis: .vertical,
        spacing: 10,
        distribution: .fillProportionally
    )
    
    private lazy var buttonsStackView = UIStackView(
        arrangedSubviews: [signInButton, signUpButton],
        axis: .horizontal,
        spacing: 10,
        distribution: .fillEqually
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        registerKeyboardNotigication()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    @objc private func signInButtonTapped() {
        
        let mail = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let user = findUserDataBase(mail: mail)
        
        if user == nil {
            loginLabel.text = "User not found"
            loginLabel.textColor = .red
        } else if user?.password == password {
            let navVC = UINavigationController(rootViewController: AlbumsViewController())
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)
            
            guard let activeUser = user else { return }
            DataBase.shared.saveActiveUser(user: activeUser)
        } else {
            loginLabel.text = "Wrong password"
            loginLabel.textColor = .red
        }
    }
    
    private func findUserDataBase(mail: String) -> User? {
        
        let dataBase = DataBase.shared.users
        
        for user in dataBase {
            if user.email == mail {
                return user
            }
        }
        
        return nil
    }
    
    @objc private func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }

    
    private func setupViews() {
        title = "Sign In"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(backgroundView)
        view.addSubview(textFieldStackView)
        view.addSubview(loginLabel)
        view.addSubview(buttonsStackView)
    }
}

//MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

extension AuthViewController {
    
    private func registerKeyboardNotigication() {
        
        // - Проверяем, что клавиатура появилась
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        // - Проверяем, что клавиатура скрылась
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeyboardNotification() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // - Когда клавиатура будет появляться, будем вызывать этот метод
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2)
    }
    
    // - Когда клавиатура будет скрываться, будем вызывать этот метод
    @objc private func keyboardWillHide() {
        // - Скрываем клавиатуру по нажатию на кнопку return/done и тд
        scrollView.contentOffset = CGPoint.zero
    }
}

//MARK: - SetConstraints

extension AuthViewController {
    
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
            textFieldStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            textFieldStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            textFieldStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            textFieldStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: textFieldStackView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            buttonsStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 30),
            buttonsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
    }
}

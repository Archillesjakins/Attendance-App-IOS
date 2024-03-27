import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let checkInButton = UIButton(type: .system)
        checkInButton.setTitle("Check-In", for: .normal)
        checkInButton.addTarget(self, action: #selector(checkInButtonTapped), for: .touchUpInside)
        checkInButton.translatesAutoresizingMaskIntoConstraints = false
        
        let checkOutButton = UIButton(type: .system)
        checkOutButton.setTitle("Check-Out", for: .normal)
        checkOutButton.addTarget(self, action: #selector(checkOutButtonTapped), for: .touchUpInside)
        checkOutButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(checkInButton)
        view.addSubview(checkOutButton)
        
        NSLayoutConstraint.activate([
            checkInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkInButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            checkOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkOutButton.topAnchor.constraint(equalTo: checkInButton.bottomAnchor, constant: 20),
        ])
    }
    
    @objc private func checkInButtonTapped() {
        // Simulate check-in process
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: currentDate)
        
        // Save check-in time to user defaults or database
        UserDefaults.standard.set(formattedDate, forKey: "checkInTime")
        UserDefaults.standard.synchronize()
        
        showAlert(title: "Checked In", message: "You have successfully checked in at \(formattedDate)")
    }

    @objc private func checkOutButtonTapped() {
        // Retrieve check-in time
        if let checkInTime = UserDefaults.standard.string(forKey: "checkInTime") {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.string(from: currentDate)
            
            // Calculate duration between check-in and check-out
            let duration = calculateDuration(from: checkInTime, to: formattedDate)
            
            // Display check-out message with duration
            showAlert(title: "Checked Out", message: "You have successfully checked out at \(formattedDate). You were checked in for \(duration).")
            
            // Remove check-in time from user defaults
            UserDefaults.standard.removeObject(forKey: "checkInTime")
            UserDefaults.standard.synchronize()
        } else {
            showAlert(title: "Error", message: "You haven't checked in yet.")
        }
    }

    private func calculateDuration(from checkInTime: String, to checkOutTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let startDate = dateFormatter.date(from: checkInTime),
              let endDate = dateFormatter.date(from: checkOutTime) else {
            return "Error calculating duration"
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: startDate, to: endDate)
        
        if let hours = components.hour, let minutes = components.minute {
            return "\(hours) hours and \(minutes) minutes"
        } else {
            return "Error calculating duration"
        }
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

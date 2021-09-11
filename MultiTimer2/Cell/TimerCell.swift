//
//  TimerCell.swift
//  MultiTimer2
//
//  Created by User on 11.09.2021.
//


import UIKit
import SnapKit

class TimerCell: UITableViewCell {
    
    var timer: NewTimers?
    
    var timerLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    var stopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("String.Error.initNotImplemented")
    }
    
    private func layout() {
        contentView.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(25)
            make.centerY.equalTo(contentView)
        }
        
        
        contentView.addSubview(stopButton)
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        stopButton.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
            let size = contentView.bounds.height
            make.height.width.equalTo(size)
        }
        
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.right.equalTo(stopButton).inset(45)
            //            make.right.equalTo(snp.right).inset(45)
            make.centerY.equalTo(contentView)
            make.left.greaterThanOrEqualTo(timerLabel.snp.right).offset(16)
        }
        
        let priority = UILayoutPriority(740)
        timerLabel.setContentCompressionResistancePriority(priority, for: .horizontal)
    }
    
    
    func schedulet(time: Int, complession: @escaping(Int)->()) {
        var times = time
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] timers in
            if self.timer?.conditional == false {
                self.timeLabel.textColor = .red
                self.backgroundColor = .white
                times -= 1
                if times < 5{
                    self.backgroundColor = .systemPink
                    self.timeLabel.textColor = .white
                }
                if times == 0 {
                    self.backgroundColor = .white
                    timers.invalidate()
                    
                } else {
                    complession(times)
                }
            } else {
                self.backgroundColor = .red
                self.timeLabel.textColor = .white
            }
        }
    }
    
    @objc func stopTimer(sender: UIButton!) {
        if timer?.conditional == false {
            timer?.conditional = true
            stopButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        } else {
            timer?.conditional = false
            stopButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        }
    }
    
    
    func fill(timer: NewTimers, complession: @escaping()->()) {
        DispatchQueue.init(label: "", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none).async {
            self.timer = timer
            DispatchQueue.main.async {
                self.timerLabel.text = timer.timerName
                self.displayTime(timer.time) {
                    complession()
                }
            }
        }
        
    }
    
    
    
    
    func displayTime(_ time: Int, complession: @escaping()->()) {
        
        self.schedulet(time: time) { lastTime in
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional
            let formattedString = formatter.string(from: TimeInterval(lastTime))
            self.timeLabel.text = formattedString
            guard lastTime <= 1 else {return}
            complession()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.timeLabel.text = nil
    }
}

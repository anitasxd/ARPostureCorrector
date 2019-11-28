//
//  JointViewController.swift
//  PostureCorrector
//
//  Created by Anita Shen on 10/12/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit
import Vision
import CoreMedia
import AVFoundation
import CoreData

class JointViewController: UIViewController {
    public typealias DetectObjectsCompletion = ([PredictedPoint?]?, Error?) -> Void
    
    // MARK: - UI Properties
    @IBOutlet weak var videoPreview: UIView!
    @IBOutlet weak var jointView: DrawingJointView!
    //@IBOutlet weak var labelsTableView: UITableView!
    
    @IBOutlet weak var inferenceLabel: UILabel!
    @IBOutlet weak var etimeLabel: UILabel!
    @IBOutlet weak var fpsLabel: UILabel!
    
    var endButton: UIButton!
    
    var player: AVAudioPlayer?
    var postureAlert: UIView!
    var timeStart = 0.0
    var timer = Timer()
    var timeLabel: UILabel!
//
//    var counterLabel: UILabel!
    
    var totalCounter = 5
    var badCounter = 0
    
    var userBadCount = 0
    var userScore = 100.0

    var sessionDate = ""
    
    var settingsThreshold : Float?
    var threshold = 284
    
    var settingsSensitivity : Float?
    var sensitivity = 40

    // MARK: - Performance Measurement Property
    private let 👨‍🔧 = 📏()
    
    // MARK: - AV Property
    var videoCapture: VideoCapture!
    
    // MARK: - ML Properties
    // Core ML model
    typealias EstimationModel = model_cpm
    
    // Preprocess and Inference
    var request: VNCoreMLRequest?
    var visionModel: VNCoreMLModel?
    
    // Postprocess
    var postProcessor: HeatmapPostProcessor = HeatmapPostProcessor()
    var mvfilters: [MovingAverageFilter] = []
    private var mvFilterAngle: MovingAverageFilterAngle = MovingAverageFilterAngle()
    
    // Inference Result Data
    private var tableData: [PredictedPoint?] = []
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thresholdChanges(_settingThreshold: settingsThreshold ?? 0.0)
        sensitivityChanges(_settingsSensitivity: settingsSensitivity ?? 0.0)
//        print("this is threshold \(settingsThreshold)")
//        print("this is sensitvitiy \(settingsSensitivity)")
        //navigationController?.navigationBar.barTintColor = UIColor.background
       postureAlert = UIView(frame: CGRect(x: 30, y: 3*view.frame.height/4, width: view.frame.width-60, height: 60))
        //view.addSubview(postureAlert)
        view.backgroundColor = UIColor.background
        uiSetup()
        // setup the model
        setUpModel()
        // setup camera
        setUpCamera()
        
        // setup tableview datasource on bottom
        //labelsTableView.dataSource = self
        
        // setup delegate for performance measurement
        👨‍🔧.delegate = self
    }
    
    func thresholdChanges(_settingThreshold: Float) {
        switch settingsThreshold {
        case 1.0:
            threshold = 284
        case 0.75:
            threshold = 280
        case 0.5:
            threshold = 276
        case 0.25:
            threshold = 272
        default:
            threshold = 284
        }
    }
    
    func sensitivityChanges(_settingsSensitivity: Float) {
        switch settingsSensitivity {
        case 1.0:
            sensitivity = 40
        case 0.75:
            sensitivity = 60
        case 0.5:
            sensitivity = 80
        case 0.25:
            sensitivity = 100
        default:
            sensitivity = 40
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.videoCapture.start()
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Sessions")
        
        do {
            UserData.userSessions = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.videoCapture.stop()
    }
    
    func uiSetup() {
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        // get the date time String from the date object
        sessionDate = formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
        
        timeLabel = UILabel(frame: CGRect(x: 60, y: videoPreview.frame.minY, width: (view.frame.width/2)-120, height: 30))
        timeLabel.text = String(timeStart)
        //view.addSubview(timeLabel)
//
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        endButton = UIButton(frame: CGRect(x: 60, y: videoPreview.frame.maxY, width: view.frame.width-120, height: 30))
        endButton.setTitle("end session", for: .normal)
        endButton.titleLabel!.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        endButton.backgroundColor = UIColor.purple3
        //        UIColor(red:0.33, green:0.77, blue:0.77, alpha:1.0)
        endButton.layer.borderWidth = 0
        endButton.layer.cornerRadius = endButton.frame.height/4
        endButton.setTitleColor(.white, for: .normal)
        endButton.addTarget(self, action: #selector(goToMain), for: .touchUpInside)
        view.addSubview(endButton)
        
//        counterLabel = UILabel(frame: CGRect(x: 120, y: videoPreview.frame.minY, width: 60, height: 30))
//        counterLabel.text = "\((badCounter/totalCounter) * 100) %"
//        view.addSubview(counterLabel)
    }
    
    @objc func updateTimer() {
        timeStart = timeStart + 0.1
        timeLabel.text = String(format: "%.1f", timeStart)
    }

    // MARK: - Setup Core ML
    func setUpModel() {
        if let visionModel = try? VNCoreMLModel(for: EstimationModel().model) {
            self.visionModel = visionModel
            request = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestDidComplete)
            request?.imageCropAndScaleOption = .scaleFill
        } else {
            fatalError("cannot load the ml model")
        }
    }
    
    // MARK: - SetUp Video
    func setUpCamera() {
        videoCapture = VideoCapture()
        videoCapture.delegate = self
        videoCapture.fps = 30
        videoCapture.setUp(sessionPreset: .vga640x480, cameraPosition: .front) { success in
            
            if success {
                // add preview view on the layer
                if let previewLayer = self.videoCapture.previewLayer {
                    self.videoPreview.layer.addSublayer(previewLayer)
                    self.resizePreviewLayer()
                }
                
                // start video preview when setup is done
                self.videoCapture.start()
            }
        }
    }
    
    func addToUserSessions(duration: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Sessions", in: managedContext)!
        
        let session = NSManagedObject(entity: entity, insertInto: managedContext)
        session.setValue(totalCounter, forKeyPath: "totalPostureCount")
        session.setValue(badCounter, forKeyPath: "badPostureCount")
        session.setValue(duration, forKey: "sessionDuration")
        session.setValue(sessionDate, forKey: "date")
        
        do {
            try managedContext.save()
            UserData.userSessions.append(session)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resizePreviewLayer()
    }
    
    func resizePreviewLayer() {
        videoCapture.previewLayer?.frame = videoPreview.bounds
    }
    
    @objc func goToMain() {
        
//        let alert = UIAlertController(title: "Session Ending", message: "Are you sure you want to end this session?", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
//        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//
//        self.present(alert, animated: true)
        timer.invalidate()
        let duration = String(timeStart)
        addToUserSessions(duration: duration)
        performSegue(withIdentifier: "endToMain", sender: self)
    }
    
    
}

// MARK: - VideoCaptureDelegate
extension JointViewController: VideoCaptureDelegate {
    func videoCapture(_ capture: VideoCapture, didCaptureVideoFrame pixelBuffer: CVPixelBuffer?, timestamp: CMTime) {
        // the captured image from camera is contained on pixelBuffer
        if let pixelBuffer = pixelBuffer {
            // start of measure
            self.👨‍🔧.🎬👏()
            
            // predict!
            self.predictUsingVision(pixelBuffer: pixelBuffer)
        }
    }
}

extension JointViewController {
    // MARK: - Inferencing
    func predictUsingVision(pixelBuffer: CVPixelBuffer) {
        guard let request = request else { fatalError() }
        // vision framework configures the input size of image following our model's input configuration automatically
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try? handler.perform([request])
    }
    
    // MARK: - Postprocessing
    func visionRequestDidComplete(request: VNRequest, error: Error?) {
        self.👨‍🔧.🏷(with: "endInference")
        if let observations = request.results as? [VNCoreMLFeatureValueObservation],
            let heatmaps = observations.first?.featureValue.multiArrayValue {
            
            /* =================================================================== */
            /* ========================= post-processing ========================= */
            
            /* ------------------ convert heatmap to point array ----------------- */
            var predictedPoints = postProcessor.convertToPredictedPoints(from: heatmaps)
            
            /* --------------------- moving average filter ----------------------- */
            if predictedPoints.count != mvfilters.count {
                mvfilters = predictedPoints.map { _ in MovingAverageFilter(limit: 3) }
            }
            for (predictedPoint, filter) in zip(predictedPoints, mvfilters) {
                filter.add(element: predictedPoint)
            }
            predictedPoints = mvfilters.map { $0.averagedValue() }
            /* =================================================================== */
            
            /* =================================================================== */
            /* ======================= display the results ======================= */
            DispatchQueue.main.sync {
                // draw line
                self.jointView.bodyPoints = predictedPoints
                
                if let p1: CGPoint = predictedPoints[0]?.maxPoint, //neck point
                    let p2: CGPoint = predictedPoints[2]?.maxPoint, //right shoulder
                    let p3: CGPoint = predictedPoints[5]?.maxPoint{ //left shoulder
                    let result: Double = Double.radianAngle(p1: p1, p2: p2, p3: p3)
                    mvFilterAngle.addAngle(newAngle: result)
                    let angle = mvFilterAngle.angle
                    //self.angleLabel.text = "\(String(format: "%.1f", angle))"
                    if abs(angle) > Double(threshold) {
                        print("good POSTURE")
                        self.postureAlert.backgroundColor = .green
                        totalCounter+=1
                    } else {
                        print("bad POSTURE")
                        totalCounter+=1
                        badCounter+=1
                        print(totalCounter)
                        if badCounter % sensitivity == 0 {
                            badPostureIndication()
                        }
                    
                    }
                }
                
                // show key points description
                //self.showKeypointsDescription(with: predictedPoints)
                
                // end of measure
                self.👨‍🔧.🎬🤚()
            }
            /* =================================================================== */
        } else {
            // end of measure
            self.👨‍🔧.🎬🤚()
        }
    }
    
//    func showKeypointsDescription(with n_kpoints: [PredictedPoint?]) {
//        self.tableData = n_kpoints
//        self.labelsTableView.reloadData()
//    }
    func badPostureIndication() {
        self.postureAlert.backgroundColor = .red
        let deadlineTime = DispatchTime.now() + .seconds(1)
        userBadCount = userBadCount + 1
        userScore =  (1 - (Double(badCounter) / Double(totalCounter))) * 100
        print("userScore \(userScore)")
        
        let window = UIApplication.shared.keyWindow!
        
        let rectangleView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        rectangleView.backgroundColor = UIColor.redOverlay
        
        //        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
        //        label.text = "Sit up straight!"
        
        //        rectangleView.addSubview(label)
        
        window.addSubview(rectangleView)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            rectangleView.removeFromSuperview()
        }
        //        self.view.backgroundColor = .clear
//        UIView.animate(withDuration: 0.7, animations: {
//            self.view.backgroundColor = UIColor(red: 232, green: 67, blue: 66, alpha: 0.1)
//        }, completion:nil)
        playSound()
    }
    
    
    /*
     sets the play sounds set by number of bad posture counts / 20
     */
    func playSound() {
        let path = Bundle.main.path(forResource: "ding", ofType : "wav")!
        let url = URL(fileURLWithPath : path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("ding!!!!!!!")
            
        } catch {
            
            print ("There is an issue with this code!")
            
        }
    }
}


// MARK: - UITableView Data Source
extension JointViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count// > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text = PoseEstimationForMobileConstant.pointLabels[indexPath.row]
        if let body_point = tableData[indexPath.row] {
            let pointText: String = "\(String(format: "%.3f", body_point.maxPoint.x)), \(String(format: "%.3f", body_point.maxPoint.y))"
            cell.detailTextLabel?.text = "(\(pointText)), [\(String(format: "%.3f", body_point.maxConfidence))]"
        } else {
            cell.detailTextLabel?.text = "N/A"
        }
        return cell
    }
}

// MARK: - 📏(Performance Measurement) Delegate
extension JointViewController: 📏Delegate {
    func updateMeasure(inferenceTime: Double, executionTime: Double, fps: Int) {
        self.inferenceLabel.text = "Time: \((timeLabel.text)!) seconds"
        self.etimeLabel.text = "Posture Count: \(userBadCount)"
        self.fpsLabel.text = "Score: \(userScore)%"
    }
}

class MovingAverageFilterAngle {
    
    let maximumCount: Int = 8
    var angles: [Double] = []
    func addAngle(newAngle: Double) {
        angles.append(newAngle)
        if angles.count > maximumCount {
            angles.remove(at: 0)
        }
    }
    var angle: Double {
        guard angles.count > 0 else { return 0 }
        return (angles.reduce(0) { $0 + $1 }) / Double(angles.count)
    }
}


extension Double {
    static func angle(p1: CGPoint, p2: CGPoint, p3: CGPoint) -> Double {
        let angle1: Double = Double(atan2(p1.y - p3.y, p1.x - p3.x));
        let angle2: Double = Double(atan2(p2.y - p3.y, p2.x - p3.x));
        
        return angle1 - angle2;
    }
    static func radianAngle(p1: CGPoint, p2: CGPoint, p3: CGPoint) -> Double {
        return (angle(p1: p1, p2: p2, p3: p3) / pi) * 180
    }
}

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
    
    var totalCounter = 0
    var badCounter = 0
    
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
       
        postureAlert = UIView(frame: CGRect(x: 30, y: 3*view.frame.height/4, width: view.frame.width-60, height: 60))
        view.addSubview(postureAlert)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.videoCapture.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.videoCapture.stop()
    }
    
    func uiSetup() {
        endButton = UIButton(frame: CGRect(x: 60, y: videoPreview.frame.maxY, width: view.frame.width-120, height: 30))
        endButton.titleLabel?.font = .boldSystemFont(ofSize: 35)
        endButton.setTitle("end session", for: .normal)
        endButton.titleLabel?.textColor = .white
        endButton.backgroundColor = UIColor.purple3
        endButton.addTarget(self, action: #selector(goToMain), for: .touchUpInside)
        view.addSubview(endButton)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resizePreviewLayer()
    }
    
    func resizePreviewLayer() {
        videoCapture.previewLayer?.frame = videoPreview.bounds
    }
    
    @objc func goToMain() {
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
                    if abs(angle) > 284 {
                        print("good POSTURE")
                        self.postureAlert.backgroundColor = .green
                        totalCounter+=1
                    } else {
                        print("bad POSTURE")
                        totalCounter+=1
                        badCounter+=1
                        print(totalCounter)
                        if badCounter % 20 == 0 {
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
        UIView.animate(withDuration: 1.0, animations: {
            self.view.backgroundColor = UIColor(red: 232, green: 67, blue: 66, alpha: 0.1)
        }, completion:nil)
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
        self.inferenceLabel.text = "inference: \(Int(inferenceTime*1000.0)) ms"
        self.etimeLabel.text = "execution: \(Int(executionTime*1000.0)) ms"
        self.fpsLabel.text = "fps: \(fps)"
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

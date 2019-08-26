//
//  ProjectMessagesVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation
class ProjectMessagesVC: UIViewController  , UIDocumentMenuDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    var recorder: AVAudioRecorder!
    var player: AVAudioPlayer!
    var meterTimer: Timer!
    var soundFileURL: URL!
    var isRecord = true
    var Addons = [AddonsModelClass]()
    var contracts = [ContractModelClass]()
    var Attachments = [AttachmentModelClass]()
    @IBOutlet weak var txtContract: UITextView!
    var http = HttpHelper()
    var RequestID = ""
    var pickerview  = UIPickerView()
    var toolBar = UIToolbar()
    var AlertController: UIAlertController!
    let imgpicker = UIImagePickerController()
    var documentInteractionController = UIDocumentInteractionController()
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet var popupRecord: UIView!
    @IBOutlet var popupContractor: UIView!
    @IBOutlet var popRecorded: UIView!
     var ISComefromNotification = false
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTimer.text = "Tab To Record"
        http.delegate = self
        GetContracttext()
        SetupActionSheet()
         popupContractor.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupContractor)
        
        popRecorded.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popRecorded)
        popupContractor.isHidden = true
        popRecorded.isHidden = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]
        
        
        //Record
        lblStatus.text = "Record"
        setSessionPlayback()
        askForNotifications()
        checkHeadphones()
        
        
       
        // Do any additional setup after loading the view.
    }
    
    @objc func updateAudioMeter(_ timer: Timer) {
        
        if let recorder = self.recorder {
            if recorder.isRecording {
                let min = Int(recorder.currentTime / 60)
                let sec = Int(recorder.currentTime.truncatingRemainder(dividingBy: 60))
                let s = String(format: "%02d:%02d", min, sec)
                lblTimer.text = s
                recorder.updateMeters()
                // if you want to draw some graphics...
                //var apc0 = recorder.averagePowerForChannel(0)
                //var peak0 = recorder.peakPowerForChannel(0)
            }
        }
    }
    
    func Record(){
        
        print("\(#function)")
        
        if player != nil && player.isPlaying {
            print("stopping")
            player.stop()
        }
        
        if recorder == nil {
            print("recording. recorder nil")
            recordWithPermission(true)
            return
        }
        
        if recorder != nil && recorder.isRecording {
            print("pausing")
            recorder.pause()
            
        } else {
            print("recording")
            //            recorder.record()
            recordWithPermission(false)
        }
    }
    
    func stop() {
        
        print("\(#function)")
        
        recorder?.stop()
        player?.stop()
        
        meterTimer.invalidate()
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false)
        } catch {
            print("could not make session inactive")
            print(error.localizedDescription)
        }
        
        //recorder = nil
    }
    
    func setupRecorder() {
        print("\(#function)")
        
        let format = DateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        let currentFileName = "recording-\(format.string(from: Date())).m4a"
        print(currentFileName)
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.soundFileURL = documentsDirectory.appendingPathComponent(currentFileName)
        print("writing to soundfile url: '\(soundFileURL!)'")
        
        if FileManager.default.fileExists(atPath: soundFileURL.absoluteString) {
            // probably won't happen. want to do something about it?
            print("soundfile \(soundFileURL.absoluteString) exists")
        }
        
        let recordSettings: [String: Any] = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 32000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        
        
        do {
            recorder = try AVAudioRecorder(url: soundFileURL, settings: recordSettings)
            recorder.delegate = self
            recorder.isMeteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        } catch {
            recorder = nil
            print(error.localizedDescription)
        }
        
    }
    
    func recordWithPermission(_ setup: Bool) {
        print("\(#function)")
        
        AVAudioSession.sharedInstance().requestRecordPermission {
            [unowned self] granted in
            if granted {
                
                DispatchQueue.main.async {
                    print("Permission to record granted")
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder.record()
                    
                    self.meterTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                                           target: self,
                                                           selector: #selector(self.updateAudioMeter(_:)),
                                                           userInfo: nil,
                                                           repeats: true)
                }
            } else {
                print("Permission to record not granted")
            }
        }
        
        if AVAudioSession.sharedInstance().recordPermission == .denied {
            print("permission denied")
        }
    }
    
    func setSessionPlayback() {
//        print("\(#function)")
//
        let session = AVAudioSession.sharedInstance()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)

        } catch {
            print("could not set session category")
            print(error.localizedDescription)
        }

        do {
            try session.setActive(true)
        } catch {
            print("could not make session active")
            print(error.localizedDescription)
        }
    }
    
    func setSessionPlayAndRecord() {
        print("\(#function)")
        
        let session = AVAudioSession.sharedInstance()
        do {
//            try session.setCategory(AVAudioSession.Category.playAndRecord, with: .defaultToSpeaker)
        } catch {
            print("could not set session category")
            print(error.localizedDescription)
        }
        
        do {
            try session.setActive(true)
        } catch {
            print("could not make session active")
            print(error.localizedDescription)
        }
    }
    func askForNotifications() {
//        print("\(#function)")
//
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ProjectMessagesVC.background(_:)),
                                               name:
            UIApplication.willResignActiveNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ProjectMessagesVC.foreground(_:)),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)

//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(ProjectMessagesVC.routeChange(_:)),
//                                               name: NSNotification.Name.AVAudioSession.routeChangeNotification,
//                                               object: nil)
    }
    
    @objc func background(_ notification: Notification) {
        print("\(#function)")
        
    }
    
    @objc func foreground(_ notification: Notification) {
        print("\(#function)")
        
    }
    
    
    @objc func routeChange(_ notification: Notification) {
        print("\(#function)")
        
        if let userInfo = (notification as NSNotification).userInfo {
            print("routeChange \(userInfo)")
            
            //print("userInfo \(userInfo)")
            if let reason = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt {
                //print("reason \(reason)")
                switch AVAudioSession.RouteChangeReason(rawValue: reason)! {
                case AVAudioSession.RouteChangeReason.newDeviceAvailable:
                    print("NewDeviceAvailable")
                    print("did you plug in headphones?")
                    checkHeadphones()
                case AVAudioSession.RouteChangeReason.oldDeviceUnavailable:
                    print("OldDeviceUnavailable")
                    print("did you unplug headphones?")
                    checkHeadphones()
                case AVAudioSession.RouteChangeReason.categoryChange:
                    print("CategoryChange")
                case AVAudioSession.RouteChangeReason.override:
                    print("Override")
                case AVAudioSession.RouteChangeReason.wakeFromSleep:
                    print("WakeFromSleep")
                case AVAudioSession.RouteChangeReason.unknown:
                    print("Unknown")
                case AVAudioSession.RouteChangeReason.noSuitableRouteForCategory:
                    print("NoSuitableRouteForCategory")
                case AVAudioSession.RouteChangeReason.routeConfigurationChange:
                    print("RouteConfigurationChange")
                    
                }
            }
        }
    }
    func checkHeadphones() {
        print("\(#function)")
        
        // check NewDeviceAvailable and OldDeviceUnavailable for them being plugged in/unplugged
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        if !currentRoute.outputs.isEmpty {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSession.Port.headphones {
                    print("headphones are plugged in")
                    break
                } else {
                    print("headphones are unplugged")
                }
            }
        } else {
            print("checking headphones requires a connection to a device")
        }
    }
    func exportAsset(_ asset: AVAsset, fileName: String) {
        print("\(#function)")
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let trimmedSoundFileURL = documentsDirectory.appendingPathComponent(fileName)
        print("saving to \(trimmedSoundFileURL.absoluteString)")
        
        
        
        if FileManager.default.fileExists(atPath: trimmedSoundFileURL.absoluteString) {
            print("sound exists, removing \(trimmedSoundFileURL.absoluteString)")
            do {
                if try trimmedSoundFileURL.checkResourceIsReachable() {
                    print("is reachable")
                }
                
                try FileManager.default.removeItem(atPath: trimmedSoundFileURL.absoluteString)
            } catch {
                print("could not remove \(trimmedSoundFileURL)")
                print(error.localizedDescription)
            }
            
        }
        
        print("creating export session for \(asset)")
        
        if let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A) {
            exporter.outputFileType = AVFileType.m4a
            exporter.outputURL = trimmedSoundFileURL
            
            let duration = CMTimeGetSeconds(asset.duration)
            if duration < 5.0 {
                print("sound is not long enough")
                return
            }
            // e.g. the first 5 seconds
            let startTime = CMTimeMake(value: 0, timescale: 1)
            let stopTime = CMTimeMake(value: 5, timescale: 1)
            exporter.timeRange = CMTimeRangeFromTimeToTime(start: startTime, end: stopTime)
            
            //            // set up the audio mix
            //            let tracks = asset.tracksWithMediaType(AVMediaTypeAudio)
            //            if tracks.count == 0 {
            //                return
            //            }
            //            let track = tracks[0]
            //            let exportAudioMix = AVMutableAudioMix()
            //            let exportAudioMixInputParameters =
            //            AVMutableAudioMixInputParameters(track: track)
            //            exportAudioMixInputParameters.setVolume(1.0, atTime: CMTimeMake(0, 1))
            //            exportAudioMix.inputParameters = [exportAudioMixInputParameters]
            //            // exporter.audioMix = exportAudioMix
            
            // do it
            exporter.exportAsynchronously(completionHandler: {
                print("export complete \(exporter.status)")
                
                switch exporter.status {
                case  AVAssetExportSession.Status.failed:
                    
                    if let e = exporter.error {
                        print("export failed \(e)")
                    }
                    
                case AVAssetExportSession.Status.cancelled:
                    print("export cancelled \(String(describing: exporter.error))")
                default:
                    print("export complete")
                }
            })
        } else {
            print("cannot create AVAssetExportSession for asset \(asset)")
        }
        
    }
    
    @IBAction
    func speed() {
        let asset = AVAsset(url: self.soundFileURL!)
        exportSpeedAsset(asset, fileName: "trimmed.m4a")
    }
    
    func exportSpeedAsset(_ asset: AVAsset, fileName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let trimmedSoundFileURL = documentsDirectory.appendingPathComponent(fileName)
        
        let filemanager = FileManager.default
        if filemanager.fileExists(atPath: trimmedSoundFileURL.absoluteString) {
            print("sound exists")
        }
        
        print("creating export session for \(asset)")
        
        if let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A) {
            exporter.outputFileType = AVFileType.m4a
            exporter.outputURL = trimmedSoundFileURL
            
            
            //             AVAudioTimePitchAlgorithmVarispeed
            //             AVAudioTimePitchAlgorithmSpectral
            //             AVAudioTimePitchAlgorithmTimeDomain
            exporter.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithm.varispeed
            
            
            
            
            let duration = CMTimeGetSeconds(asset.duration)
            if duration < 5.0 {
                print("sound is not long enough")
                return
            }
            // e.g. the first 5 seconds
            //            let startTime = CMTimeMake(0, 1)
            //            let stopTime = CMTimeMake(5, 1)
            //            let exportTimeRange = CMTimeRangeFromTimeToTime(startTime, stopTime)
            //            exporter.timeRange = exportTimeRange
            
            // do it
            exporter.exportAsynchronously(completionHandler: {
                switch exporter.status {
                case  AVAssetExportSession.Status.failed:
                    print("export failed \(String(describing: exporter.error))")
                case AVAssetExportSession.Status.cancelled:
                    print("export cancelled \(String(describing: exporter.error))")
                default:
                    print("export complete")
                }
            })
        }
    }
    



    
    
    
    
    
    
    @IBAction func btnStartRecord(_ sender: Any) {
        if isRecord == true {
            Record()
            lblStatus.text = "Stop"
           isRecord = false
        }else{
            stop()
        }
    }
    @IBAction func btnRecord(_ sender: Any) {
        popRecorded.isHidden = false
        popupContractor.isHidden = false
        popRecorded.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
    }
    @IBAction func btnAcceptContract(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProjectDetails", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "MakeAaqdVC") as! MakeAaqdVC
        cont.RequestID = RequestID
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnRecive(_ sender: Any) {
        RecieveProject()
        
    }
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }
    
    @IBAction func btnContact(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Help", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "HelpMethodVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnNotificationPayement(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Paid", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "PaymentVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnPayment(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Paid", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "PaymentVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnHidePopup(_ sender: Any) {
        popupContractor.isHidden = true
    }
    @IBAction func btnDetails(_ sender: Any) {
        GetRequestDetails()
    }
    
    @IBAction func btnContract(_ sender: Any) {
        popupContractor.isHidden = false
        popupContractor.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
    }
    @IBAction func btnAttachment(_ sender: Any) {
        imgpicker.delegate = self
        imgpicker.allowsEditing = false
        self.present(AlertController, animated: true, completion: nil)
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func GetRequestDetails(){
        
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken,
                      "request_id" : RequestID ] as [String: Any]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.GetRequestDetails, method: .post, parameters: params, tag: 2, header: nil)
    }
    
    func GetContracttext(){
    print(RequestID)
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken,
                      "request_id" : RequestID ] as [String: Any]
        let headers = [
            "Authorization": AccessToken]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.GetRequestContract, method: .post, parameters: params, tag: 1, header: headers)
        
    }
    func RecieveProject(){
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        print(RequestID)
        let params = ["token": AccessToken,
                      "request_id" : RequestID ] as [String: Any]
        let headers = [
            "Authorization": AccessToken]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.RecieveProject, method: .post, parameters: params, tag: 3, header: headers)
    }
    
    func SetupActionSheet()
    {
        AlertController = UIAlertController(title:"" , message:AppCommon.sharedInstance.localization("المرفقات") , preferredStyle: UIAlertController.Style.actionSheet)
        
        let Cam = UIAlertAction(title: "الكاميرا", style: UIAlertAction.Style.default, handler: { (action) in
            self.openCameraImagePicker()
        })
        let Gerall = UIAlertAction(title: "المعرض", style: UIAlertAction.Style.default, handler: { (action) in
            self.openGalleryImagePicker()
        })
        
        let Docs = UIAlertAction(title: "الملفات", style: UIAlertAction.Style.default, handler: { (action) in
            self.openDcumentPicker()
        })
        let Map = UIAlertAction(title: "الموقع", style: UIAlertAction.Style.default, handler: { (action) in
            self.openGalleryImagePicker()
        })
        
        let Cancel = UIAlertAction(title: AppCommon.sharedInstance.localization("cancel"), style: UIAlertAction.Style.cancel, handler: { (action) in
            //
        })
        
        self.AlertController.addAction(Cam)
        self.AlertController.addAction(Gerall)
        self.AlertController.addAction(Docs)
        self.AlertController.addAction(Map)
        self.AlertController.addAction(Cancel)
    }
    
    // Delegate Method for UIDocumentMenuDelegate.
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    // Delegate Method for UIDocumentPickerDelegate.
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("url: \(url)")
        let fileName = url.lastPathComponent
        print("fileName: \(fileName)")
        if (url.absoluteString.hasSuffix("pdf")) {
            print("pdf")
            
        }
        else if (url.absoluteString.hasSuffix("doc")) {
            print("doc")
            
        }
        else if (url.absoluteString.hasSuffix("docx")) {
            print("docx")
            
        }
        else if (url.absoluteString.hasSuffix("xlsx")) {
            print("xlsx")
            
        }
        else if (url.absoluteString.hasSuffix("xls")) {
            print("xls")
            
        }
        else if (url.absoluteString.hasSuffix("txt")) {
            print("txt")
            
        }
        else if (url.absoluteString.hasSuffix("pptx")) {
            print("pptx")
            
        }
        else if (url.absoluteString.hasSuffix("PPT")) {
            print("ppt")
            
        }
        else {
            print("Unknown")
        }
        
    }
    // Method to handle cancel action.
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        //        dismiss(animated: true, completion: nil)
    }
    
    func openDcumentPicker() {
        
        let pdf = String("kUTTypePDF")
        //        let zip = String(kUTTypeZipArchive)
        let docs = String("kUTTypeCompositeContent")
        //        let archive = String(kUTTypeArchive)
        let number = String("kUTTypeLog")
        let spreadsheet = String("kUTTypeSpreadsheet")
        //        let movie = String(kUTTypeMovie)
        //        let aviMovie = String(kUTTypeAVIMovie)
        let importMenu = UIDocumentMenuViewController(documentTypes: [pdf, docs, number, spreadsheet], in: UIDocumentPickerMode.import)
        importMenu.delegate = self
        
        //        if Helper.isDeviceiPad() {
        //
        //            if let popoverController = importMenu.popoverPresentationController {
        //                popoverController.sourceView = sender
        //            }
        //        }
        
        
        self.present(importMenu, animated: true, completion: nil)
    }
    
    func openGalleryImagePicker() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true)
    }
    
    func openCameraImagePicker() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        //        imageProfile.contentMode = .scaleAspectFit
        print("image: \(image)")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        let assetPath = info[UIImagePickerControllerReferenceURL] as! URL
        //        let imgName = assetPath.lastPathComponent
        
        if #available(iOS 11.0, *) {
            if let assetPath = info["UIImagePickerControllerImageURL"] as? URL{
                let imgName = assetPath.lastPathComponent
                print(imgName)
                if (assetPath.absoluteString.hasSuffix("jpg")) {
                    print("jpg")
                    if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                        print("image: \(pickedImage)")
                        
                    }
                }else if (assetPath.absoluteString.hasSuffix("jpeg")) {
                    print("jpeg")
                    
                }
                else if (assetPath.absoluteString.hasSuffix("png")) {
                    print("png")
                }
                else if (assetPath.absoluteString.hasSuffix("gif")) {
                    print("gif")
                    
                }
                else {
                    print("Unknown")
                }
                
            }else {
                if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                    //  sendImg.image = pickedImage
                    let imagePath = URL(fileURLWithPath: "")
                    
                }
            }
        } else {
            // Fallback on earlier versions
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
extension ProjectMessagesVC : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        if Tag == 1 {
            let status =  json["status"]
            let data = json["data"]
            let message = json["msg"]
            
            if status.stringValue == "0" {
                txtContract.text = data["text"].stringValue
                let name = data["name"].stringValue
                if ISComefromNotification == true
                {
                    ISComefromNotification = false
                    popupContractor.isHidden = false
                }
            } else {
                Loader.showError(message: message.stringValue )
            }
        }
        else if Tag == 2 {
            let status =  json["status"]
            let data = json["data"]
            let message = json["msg"]
            let Jaddons = data["addons"].arrayValue
            let JContracts = data["contracts"].arrayValue
            let JAttachment = data["attachments"].arrayValue
            
            if status.stringValue == "0" {
                
                for json in Jaddons{
                    let obj = AddonsModelClass(
                        id: "",
                        name: json["name"].stringValue,
                        price: ""
                        
                    )
                    //print(obj)
                    Addons.append(obj)
                }
                for json in JContracts{
                    let obj = ContractModelClass(
                        name: json["name"].stringValue,
                        pdf: json["pdf"].stringValue
                    )
                    //print(obj)
                    contracts.append(obj)
                }
                for json in JAttachment{
                    let obj = AttachmentModelClass(
                        file: json["file"].stringValue,
                        size: json["size"].stringValue,
                        upload_date: json["upload_date"].stringValue
                    )
                    //print(obj)
                    Attachments.append(obj)
                }
                
                GRequestDetail = RequestDetailModelClass(
                    request_name: data["request_name"].stringValue,
                    request_descr: data["request_descr"].stringValue,
                    start_time: data["start_time"].stringValue,
                    end_time: data["end_time"].stringValue,
                    service_name: data["service_name"].stringValue,
                    start_from: data["start_from"].stringValue,
                    total_time: data["total_time"].stringValue,
                    terms: data["terms"].stringValue,
                    addons: Addons,
                    Contracts: contracts,
                    Attachment: Attachments
                )
                
                let storyboard = UIStoryboard(name: "ProjectDetails", bundle: nil)
                let cont = storyboard.instantiateViewController(withIdentifier: "DetailSeguVC") as! DetailSeguVC
                cont.RequestID = RequestID
                self.show(cont, sender: true)
                
                
            } else {
                Loader.showError(message: message.stringValue )
            }
        }
        else if Tag == 3 {
            let status =  json["status"]
            let data = json["data"]
            let message = json["msg"]
            let ProjectURL = data["project_url"]
            
            if status.stringValue == "0" {
                
                let storyboard = UIStoryboard(name: "Help", bundle: nil)
                let cont = storyboard.instantiateViewController(withIdentifier: "CongratulationVC") as! CongratulationVC
                cont.ProjectURL = ProjectURL.stringValue
                cont.RequestID = RequestID
                self.present(cont, animated: true, completion: nil)
                
            } else {
                Loader.showError(message: message.stringValue )
            }
        }
        
    }
    
    func receivedErrorWithStatusCode(statusCode: Int) {
        print(statusCode)
        AppCommon.sharedInstance.alert(title: "Error", message: "\(statusCode)", controller: self, actionTitle: AppCommon.sharedInstance.localization("ok"), actionStyle: .default)
        
        AppCommon.sharedInstance.dismissLoader(self.view)
    }
    func retryResponse(numberOfrequest: Int) {
        
    }
    
}
// MARK: AVAudioRecorderDelegate
extension ProjectMessagesVC: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder,
                                         successfully flag: Bool) {
        
        print("\(#function)")
        
        print("finished recording \(flag)")
        // iOS8 and later
        let alert = UIAlertController(title: "Recorder",
                                      message: "Finished Recording",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Keep", style: .default) {[unowned self] _ in
            print("keep was tapped")
            self.recorder = nil
        })
        alert.addAction(UIAlertAction(title: "Delete", style: .default) {[unowned self] _ in
            print("delete was tapped")
            self.recorder.deleteRecording()
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder,
                                          error: Error?) {
        print("\(#function)")
        
        if let e = error {
            print("\(e.localizedDescription)")
        }
    }
    
}

// MARK: AVAudioPlayerDelegate
extension ProjectMessagesVC: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("\(#function)")
        
        print("finished playing \(flag)")
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("\(#function)")
        
        if let e = error {
            print("\(e.localizedDescription)")
        }
        
    }
}

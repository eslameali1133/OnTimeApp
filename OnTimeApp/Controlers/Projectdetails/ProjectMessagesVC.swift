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
import MobileCoreServices
class ProjectMessagesVC: UIViewController  , UIDocumentMenuDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    var Socket : SocketModelClass!
    var HasChat = true
    let rest = RestManager()
    var VideoData : Data!
    var videoUrl : URL!
    var picker : MediaPickerController!
    var ContractStatus = ""
    var Selectedimg : UIImage!
    var FileType = "no_file" //no_file
    var messagesList = [MessageModelClass]()
    var recorder: AVAudioRecorder!
    var player: AVAudioPlayer!
    var meterTimer: Timer!
    var soundFileURL: URL!
    var isRecord = true
    var Addons = [AddonsModelClass]()
    var contracts = [ContractModelClass]()
    var Attachments = [AttachmentModelClass]()
    var Components = [ComponentModelClass]()
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
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet var popupRecord: UIView!
    @IBOutlet var popupContractor: UIView!
    @IBOutlet weak var txtimgChat: UITextField!
    @IBOutlet var popRecorded: UIView!
    @IBOutlet var popupImgChat: UIView!
    @IBOutlet weak var ContractView: UIView!
    @IBOutlet weak var ChatView: UITableView!
    var ISComefromNotification = false
    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet weak var imgChat: customImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        SocketManger.shared.handleNewMessage { (message) in
            print(message)
//            if self.SelectedPlayer.user_id == message._from {
//
//                self.messages.append(message)
//                self.tableView.reloadData()
//                self.scrollToBottomOfChat()
            }
        lblTimer.text = "Tab To Record"
        http.delegate = self
        SetupActionSheet()
         popupContractor.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupContractor)
        
        popupImgChat.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupImgChat)
        
        popRecorded.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popRecorded)
        popupContractor.isHidden = true
        popRecorded.isHidden = true
        popupImgChat.isHidden = true
        let attributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        
        //Record
        lblStatus.text = "Record"
        setSessionPlayback()
        askForNotifications()
        checkHeadphones()
        if HasChat == true {
        GetMessages()
        }
        else{
            ChatView.isHidden = true
            ContractView.isHidden = false
            HasChat = true
        }
        tblChat.dataSource = self
        tblChat.delegate = self
        
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelImgChat(_ sender: Any) {
        popupImgChat.isHidden = true
        FileType = "no_file"
    }
    @IBAction func btnSendImg(_ sender: Any) {
        SendMessage()
    }
    @IBAction func btnSendMessage(_ sender: Any) {
        SendMessage()
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
        
        Addons.removeAll()
        Attachments.removeAll()
        Components.removeAll()
        contracts.removeAll()
        
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken,
                      "request_id" : RequestID ] as [String: Any]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.GetRequestDetails, method: .post, parameters: params, tag: 2, header: nil)
    }
    
    func SendMessage(){
    //no_file - voice - video - img - file - url
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        print(RequestID)
        if FileType == "no_file"{
            let params = [
                      "token": AccessToken,
                      "request_id" : RequestID,
                      "msg_text" : txtMessage.text!,
                      "file_type" : FileType
                     ] as [String: Any]
       
            Alamofire.upload(
                multipartFormData: { multipartFormData in

                    for (key,value) in params {
                        if let value = value as? String {
                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }
                    
            },to: "https://appontime.net/mobile/send_chat_msg.php",
              method: .post, headers: nil,
              encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseString { response in
                        debugPrint(response)
                        // If the request to get activities is succesfull, store them
                        
                        print(response.result)
                        print("Response : ", response)
                        
                        if response.result.isSuccess
                        {
                            //AppCommon.sharedInstance.dismissLoader(self.view)
                            let json = JSON(response.data as Any)
                            print(json)
                            let status =  json["status"]
                            let message = json["msg"]
                            let Jsocket = json["socket"]
                            if status.stringValue == "0" {
                                self.tblChat.reloadData()
                                self.txtMessage.text = ""
                                self.Socket = SocketModelClass(
                                    user_id: Jsocket["user_id"].stringValue,
                                    room_id: Jsocket["room_id"].stringValue,
                                    time: Jsocket["time"].stringValue,
                                    file_type: Jsocket["file_type"].stringValue,
                                    msg_type: Jsocket["msg_type"].stringValue,
                                    msg_text: Jsocket["msg_text"].stringValue,
                                    file_url: Jsocket["file_url"].stringValue,
                                    request_id: Jsocket["request_id"].stringValue)
                            }
                            SocketManger.shared.sendObject(data: self.Socket)
                            
                            
                        }
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                    AppCommon.sharedInstance.dismissLoader(self.view)
                }
            }
            )
            
        }else if FileType == "img"{
            let imgdata = self.imgChat.image!.jpegData(compressionQuality: 0.5)
            print(imgdata!)
            let params = ["token": AccessToken,
                          "request_id" : RequestID,
                          "msg_text" : txtimgChat.text!,
                          "file_type" : FileType,
                          "file" : imgdata!,
                          ] as [String: Any]
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imgdata!, withName: "file", fileName: "file\(arc4random_uniform(100))"+".jpeg", mimeType: "image/jpg")
                    
                    for (key,value) in params {
                        if let value = value as? String {
                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }
                    
            },to: "https://appontime.net/mobile/send_chat_msg.php",
              method: .post, headers: nil,
              encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseString { response in
                        debugPrint(response)
                        // If the request to get activities is succesfull, store them
                        
                        print(response.result)
                        print("Response : ", response)
                        
                        if response.result.isSuccess
                        {
                            //AppCommon.sharedInstance.dismissLoader(self.view)
                            let json = JSON(response.data as Any)
                            print(json)
                            let status =  json["status"]
                            let message = json["msg"]
                            let socket = json["socket"]
                            if status.stringValue == "0" {
                            self.popupImgChat.isHidden = true
                              self.tblChat.reloadData()
                                self.txtimgChat.text = ""
                                self.FileType = "no_file"
                                                            }
                            
                        }
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                    AppCommon.sharedInstance.dismissLoader(self.view)
                }
            }
            )
            
        }else if FileType == "video"{
            print(VideoData!)
            let params = ["token": AccessToken,
                          "request_id" : RequestID,
                          "msg_text" : txtimgChat.text!,
                          "file_type" : FileType,
                          "file" : VideoData!,
                          ] as [String: Any]
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(self.VideoData!, withName: "file", fileName: "file\(arc4random_uniform(100))"+".mp4", mimeType: "video/mp4")
                    
                    for (key,value) in params {
                        if let value = value as? String {
                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }
                    
            },to: "https://appontime.net/mobile/send_chat_msg.php",
              method: .post, headers: nil,
              encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseString { response in
                        debugPrint(response)
                        // If the request to get activities is succesfull, store them
                        
                        print(response.result)
                        print("Response : ", response)
                        
                        if response.result.isSuccess
                        {
                            //AppCommon.sharedInstance.dismissLoader(self.view)
                            let json = JSON(response.data as Any)
                            print(json)
                            let status =  json["status"]
                            let message = json["msg"]
                            let socket = json["socket"]
                            if status.stringValue == "0" {
                                self.popupImgChat.isHidden = true
                                self.tblChat.reloadData()
                                self.txtimgChat.text = ""
                                self.FileType = "no_file"
                            }
                            
                        }
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                    AppCommon.sharedInstance.dismissLoader(self.view)
                }
            }
            )
            
        }
        else if FileType == "file"{
            
                let fileURL = Bundle.main.url(forResource: "sampleText", withExtension: "txt")
            print(fileURL!)
                let fileInfo = RestManager.FileInfo(withFileURL: fileURL, filename: "sampleText.txt", name: "uploadedFile", mimetype: "text/plain")
                
                rest.httpBodyParameters.add(value: AccessToken, forKey: "token")
                rest.httpBodyParameters.add(value: RequestID, forKey: "request_id")
            rest.httpBodyParameters.add(value: txtMessage.text!, forKey: "msg_text")
            rest.httpBodyParameters.add(value: FileType, forKey: "file_type")
            rest.httpBodyParameters.add(value: fileInfo, forKey: "file")
            rest.httpBodyParameters.add(value: fileURL!, forKey: "file_url")
                upload(files: [fileInfo], toURL: URL(string: "https://appontime.net/mobile/send_chat_msg.php"))
            
            
        
            
        }
        
    }
    
    
    func upload(files: [RestManager.FileInfo], toURL url: URL?) {
        if let uploadURL = url {
            rest.upload(files: files, toURL: uploadURL, withHttpMethod: .post) { (results, failedFilesList) in
                print("HTTP status code:", results.response?.httpStatusCode ?? 0)
                
                if let error = results.error {
                    print(error)
                }
                
                if let data = results.data {
                    if let toDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                        print(toDictionary)
                    }
                }
                
                if let failedFiles = failedFilesList {
                    for file in failedFiles {
                        print(file)
                    }
                }
            }
        }
    }
    
    func GetMessages(){
   
        messagesList.removeAll()
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        print(RequestID)
        let params = ["token": AccessToken,
                      "request_id" : RequestID ] as [String: Any]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.GetMessages, method: .post, parameters: params, tag: 4, header: nil)
    
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
//        let Map = UIAlertAction(title: "الموقع", style: UIAlertAction.Style.default, handler: { (action) in
//            self.openGalleryImagePicker()
//        })
        
        let Cancel = UIAlertAction(title: AppCommon.sharedInstance.localization("cancel"), style: UIAlertAction.Style.cancel, handler: { (action) in
            //
        })
        
        self.AlertController.addAction(Cam)
        self.AlertController.addAction(Gerall)
        self.AlertController.addAction(Docs)
        //self.AlertController.addAction(Map)
        self.AlertController.addAction(Cancel)
    }
    
    // Delegate Method for UIDocumentMenuDelegate.
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
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
        
//        guard let myURL = urls.first else {
//            return
//        }
//        print("import result : \(myURL)")
//
    }
    // Method to handle cancel action.
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
                dismiss(animated: true, completion: nil)
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
        importMenu.modalPresentationStyle = .formSheet

        
        //        if Helper.isDeviceiPad() {
        //
        //            if let popoverController = importMenu.popoverPresentationController {
        //                popoverController.sourceView = sender
        //            }
        //        }
        
        
        self.present(importMenu, animated: true, completion: nil)
    }
    
    func openGalleryImagePicker() {
        
        
        self.picker = MediaPickerController(type: .imageAndVideo, presentingViewController: self)
        self.picker.delegate = self
        self.picker.show()
        
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.allowsEditing = false
//        picker.sourceType = .photoLibrary
//        //picker.mediaTypes = ["public.image", "public.movie"]
//        picker.modalPresentationStyle = .fullScreen
//        self.present(picker, animated: true)
    }
    
    func openVideoPicker(){
        func showImagePicker(){
            let picker = UIImagePickerController()
            picker.delegate = self
           // picker.mediaTypes = [kUTTypeMovie as String]
            self.present(picker, animated: true, completion: nil)
        }
        
        
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
    
    func imagePickerController(_ imgpicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //guard let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
//            return
//        }
//        do {
//            let data = try Data(contentsOf: videoUrl, options: .mappedIfSafe)
//            print(data)
//            //  here you can see data bytes of selected video, this data object is upload to server by multipartFormData upload
//        } catch  {
//        }
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        popupImgChat.isHidden = false
        popupImgChat.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
        imgChat.image = selectedImage
        FileType = "img"
        imgpicker.dismiss(animated: true, completion: nil)
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
            
            let JComponents = data["components"].arrayValue
            
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
                
                for json in JComponents{
                    let obj = ComponentModelClass(
                        component_name: json["name"].stringValue, price: "", duration: "",
                        done: json["done"].stringValue, end_date: json["end_date"].stringValue
                        
                    )
                    //print(obj)
                    Components.append(obj)
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
                    Attachment: Attachments, components: Components
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
        }else if Tag == 5 {
            let status =  json["status"]
            let socket = json["socket"]
            let message = json["msg"]
            
            if status.stringValue == "0" {
                
                
                
            } else {
                Loader.showError(message: message.stringValue )
            }
        }
        else if Tag == 4 {
            let status =  json["status"]
            let data = json["data"].arrayValue
            let message = json["msg"]
            
            if status.stringValue == "0" {
                ChatView.isHidden = false
                ContractView.isHidden = true
                for json in data{
                    let obj = MessageModelClass(
                        id: json["id"].stringValue,
                        msg_text: json["msg_text"].stringValue,
                        file_type: json["file_type"].stringValue,
                        file_url: json["file_url"].stringValue,
                        time: json["time"].stringValue,
                        msg_type: json["msg_type"].stringValue,
                        readed: json["readed"].stringValue
                    )
                    //print(obj)
                    messagesList.append(obj)
                }
                tblChat.reloadData()
                
                
            }else if status.stringValue == "217" {
                GetContracttext()
                ContractStatus = "Unsigned"
                ChatView.isHidden = true
                ContractView.isHidden = false
            }else if status.stringValue == "218" {
                ContractStatus = "Unverified"
                ChatView.isHidden = true
                ContractView.isHidden = false
            }else {
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
extension ProjectMessagesVC: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messagesList[indexPath.row]
        if message._msg_type == "client_to_team" {
             //no_file - voice - video - img - url -  file
            if message._file_type == "img" {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "outgoingimgcell", for: indexPath) as! outgoingimgcell
                let messagePic = message._file_url
                cell.img.loadimageUsingUrlString(url: messagePic)
                
                cell.lblTime.text = message._time
                cell.lblDescription.text = message._msg_text
                return cell
            }else if message._file_type == "file" {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "outgoingfilecell", for: indexPath) as! outgoingfilecell
//                let messagePic = message.ImagePath
//                let fileName = message.ImageName!
//                //                let fileName = messagePic?.replacingOccurrences(of: "\(APIConstants.SERVER_URL)/Images/", with: "")
//                if let url = URL.init(string: messagePic!) {
//                    if (url.absoluteString.hasSuffix("docx")) {
//                        print("docx")
//                        cell.fileImageExt.image = #imageLiteral(resourceName: "docExt")
//                        cell.fileNameLabel.text = "\(fileName).docx"
//                    }
//                    else if (url.absoluteString.hasSuffix("xls")) {
//                        print("xls")
//                        cell.fileImageExt.image = #imageLiteral(resourceName: "xlsExt")
//                        cell.fileNameLabel.text = "\(fileName).xls"
//                    }
//                    else if (url.absoluteString.hasSuffix("txt")) {
//                        print("txt")
//                        cell.fileImageExt.image = #imageLiteral(resourceName: "txtsExt")
//                        cell.fileNameLabel.text = "\(fileName).txt"
//                    }
//                    else if (url.absoluteString.hasSuffix("pdf")) {
//                        print("pdf")
//                        cell.fileImageExt.image = #imageLiteral(resourceName: "pdfExt")
//                        cell.fileNameLabel.text = "\(fileName).pdf"
//                    }
//                    else if (url.absoluteString.hasSuffix("xlsx")) {
//                        print("xlsx")
//                        cell.fileImageExt.image = #imageLiteral(resourceName: "xlsxExt")
//                        cell.fileNameLabel.text = "\(fileName).xlsx"
//                    }
//                    else if (url.absoluteString.hasSuffix("ppt")) {
//                        print("xlsx")
//                        cell.fileImageExt.image = #imageLiteral(resourceName: "pptExt")
//                        cell.fileNameLabel.text = "\(fileName).ppt"
//                    }
//                    else {
//                        print("Unknown")
//                    }
//                }
                //cell.messageTimeLabel.text = message.MessageTime
                return cell
            }else if message._file_type == "voice" {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "outgoingvoicecell", for: indexPath) as! outgoingvoicecell
                
                return cell
            }else if message._file_type == "video" {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "outgoingvideocell", for: indexPath) as! outgoingvideocell
                
                return cell
            }else if message._file_type == "url" {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "outgoingurlcell", for: indexPath) as! outgoingurlcell
                
                return cell
            }
            else {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "outgoingtxtcell", for: indexPath) as! outgoingtxtcell
//                DispatchQueue.main.async {
//                    cell.recevierMessageView.roundCorners([.bottomLeft, .bottomRight, .topLeft], radius: 10)
//                }
                cell.lblMessage.text = message._msg_text
                cell.lblTime.text = message._time
                return cell
            }
            
        }else {
            if message._file_type == "img" {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "incomingimgcell", for: indexPath) as! incomingimgcell
                let messagePic = message._file_url
                let trimmedString = messagePic.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                cell.img.image = #imageLiteral(resourceName: "officePlaceholder")
                if let url = URL.init(string: trimmedString!) {
                    cell.img.loadimageUsingUrlString(url: trimmedString!)
                    
                    
                } else{
                    print("nil")
                }
                cell.lblTime.text = message._time
                cell.lblDescreption.text = message._msg_text
                return cell
            }else if message._file_type == "file" {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "incomingfilecell", for: indexPath) as! incomingfilecell
                
                return cell
            }else if message._file_type == "voice" {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "incomingvoicecell", for: indexPath) as! incomingvoicecell
                
                return cell
            }else if message._file_type == "video" {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "incomingvideocell", for: indexPath) as! incomingvideocell
                
                return cell
            }else if message._file_type == "url" {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "incomingurlcell", for: indexPath) as! incomingurlcell
                
                return cell
            }
            else {
                let cell = tblChat.dequeueReusableCell(withIdentifier: "incomimingtxtcell", for: indexPath) as! incomimingtxtcell
                              //  DispatchQueue.main.async {
                //                    cell.recevierMessageView.roundCorners([.bottomLeft, .bottomRight, .topLeft], radius: 10)
                //                }
                cell.lblMessage.text = message._msg_text
                cell.lblTime.text = message._time
                return cell
            }
        }
    }
}
extension ProjectMessagesVC: MediaPickerControllerDelegate {
    
    func mediaPickerControllerDidPickImage(_ image: UIImage) {
        //self.statusLabel.text = "Picked Image\nPreview:"
        popupImgChat.isHidden = false
        popupImgChat.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
        FileType = "img"
        self.imgChat.image = image
    }
    
    func mediaPickerControllerDidPickVideo(url: URL, data: Data, thumbnail: UIImage) {
        //self.statusLabel.text = "Picked Video\nURL in device: \(url.absoluteString)\nThumbnail Preview:"
        popupImgChat.isHidden = false
        popupImgChat.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
        FileType = "video"
        self.imgChat.image = thumbnail
        self.videoUrl = url
        self.VideoData = data
    }
    
}

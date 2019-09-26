//
//  SocketManager.swift
//  SocketChatiOS
//
//  Created by Chhaileng Peng on 12/19/18.
//  Copyright © 2018 Chhaileng Peng. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON
//var Gmessage : Message!
class SocketManger {

    static let shared = SocketManger()
    let socket = SocketIOClient(socketURL: URL(string: "https://appontime.net:49160")!, config: [.log(false), .forceWebsockets(true) ])
 //   [.log(false), .forceWebsockets(true), .connectParams(["user_token":"\(ChatToken)"]) ])

    //["query":["user_token":"\(ChatToken)"]]
    //var socket = SocketIOClient(socketURL: URL(string: "172.107.175.8:5000")!, config: [.log(false), .forceWebsockets(true),.connectParams(["query" : "user_token=\(ChatToken)"])])

    func connect() {
        socket.connect()
    }

    func disconnect() {
        socket.disconnect()
    }


    func onConnect(handler: @escaping () -> Void) {
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        let param = ["token" : AccessToken ]
        socket.on("connect") { (_, _) in
            self.socket.emit("initialize_user", param)
            //handler()
        }
    }
    
    func sendObject (data : SocketModelClass){
        let param = [
            "user_id" :data._user_id,
            "room_id" :data._room_id,
            "time" :data._time,
            "file_type" :data._file_type,
            "msg_type" :data._msg_type,
            "msg_text" :data._msg_text,
            "file_url" :data._file_url,
            "request_id" :data._request_id
        ]
        self.socket.emit("user_chat_msg", param)
    }


    func handleNewMessage(handler: @escaping
        (_ message: SocketModelClass) -> Void) {
        socket.on("connect") { (data, ack) in
            print(data)
            //let data = data[0] as! [String: Any]
            let json = JSON(data)
            print(json)
            let from = json[0]["from"]
            let msg = json[0]["msg"]
            let user_id = json[0]["user_id"]
            print(from)
            print(msg)
            print(user_id)
            //user and message model
          //  let Muser = User(user_id: user_id.stringValue ,from: from.stringValue)
            //let message = Message(user_id: user,msg: msg.stringValue,from: from.stringValue)
//            let message = MessageModelClass(
//                username : Muser.from,
//                id: "",
//                message: msg.stringValue,
//                from: Muser.user_id,
//                to:  AppCommon.sharedInstance.getJSON("Profiledata")["id"].stringValue,
//                seen: "",
//                created_at: "",
//                updated_at: ""
//            )
////            if GIsAtChatRoom == false {
//                //if CurrentPlayer.user_id == message._to{}
//                self.appDelegate?.scheduleNotification(message: message)
//
//            }
          //  handler(message)

        }
    }


    func handleUserTyping(handler: @escaping () -> Void) {
        socket.on("userTyping") { (_, _) in
            handler()
        }
    }

    func handleUserStopTyping(handler: @escaping () -> Void) {
        socket.on("userStopTyping") { (_, _) in
            handler()
        }
    }

    func handleActiveUserChanged(handler: @escaping (_ count: Int) -> Void) {
        socket.on("count") { (data, ack) in
            let count = data[0] as! Int
            handler(count)
        }
    }

//    func sendMessage(message: MessageModelClass) {
////        let msg: [String: Any] = [
////            "user_id": message.user_id,
////            "msg": message.msg,
////            "from": message.from,
////            ]
//       // socket.emit("sendMessage", with: [msg])
//
////        print(message._from)
////        print(message._message)
//     //   print(message._id)
//
//        let AccessToken = UserDefaults.standard.string(forKey: "access_token")!
//        let token_type = UserDefaults.standard.string(forKey: "token_type")!
//        print("\(token_type) \(AccessToken)")
//        let params = [
//            "user_id" : "message._to",
//            "msg" : "message._message"
//            ] as [String: Any]
//        print(params)
//        let headers = [
//            "Accept": "application/json" ,
//            "Content-Type": "application/json" ,
//               "lang":SharedData.SharedInstans.getLanguage() ,
//            "Authorization" : "\(token_type) \(AccessToken)",
//        ]
//
//        http.requestWithBody(url: APIConstants.SendMessage, method: .post, parameters: params, tag: 1, header: headers)
//
//    }

//    func sendMessage(message: GroupMessageModelClass , GroupID : String) {
//
//    print(message._from)
//    print(message._message)
//    print(message._id)
//    print(GroupID)
//    let AccessToken = UserDefaults.standard.string(forKey: "access_token")!
//    let token_type = UserDefaults.standard.string(forKey: "token_type")!
//    print("\(token_type) \(AccessToken)")
//    let params = [
//        "group_id" : GroupID ,
//        "msg" : message._message
//        ] as [String: Any]
//    print(params)
//    let headers = [
//        "Accept": "application/json" ,
//        "Content-Type": "application/json" ,
//           "lang":SharedData.SharedInstans.getLanguage() ,
//        "Authorization" : "\(token_type) \(AccessToken)",
//    ]
//
//    http.requestWithBody(url: APIConstants.SendGroupMessage, method: .post, parameters: params, tag: 2, header: headers)
//
//}

    }

extension SocketManger: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        let json = JSON(dictResponse)
        print(json.boolValue)
        if Tag == 1 {

            let isSend =  json["success"]

            if isSend == true {
                print("success")
                //Loader.showSuccess(message: "success")
            }else {
                print("Faild")
               // Loader.showError(message: "Faild")
            }

        }
        if Tag == 2 {

            let isSend =  json["success"]

            if isSend == true {
                print("success")
                //Loader.showSuccess(message: "success")
            }else {
                print("Faild")
                // Loader.showError(message: "Faild")
            }

        }

        }

    func receivedErrorWithStatusCode(statusCode: Int) {
        print(statusCode)
    }

    func retryResponse(numberOfrequest: Int) {

    }


}



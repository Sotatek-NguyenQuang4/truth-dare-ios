//
//  AppConstant.swift
//  Earable
//
//  Created by Nguyen Quoc Tung on 5/25/20.
//  Copyright © 2020 Earable. All rights reserved.
//

import Foundation
import UIKit

struct AppConstant {
    static var cardSize: CGSize {
        let width = (UIScreen.main.bounds.size.width - 16 - 16 - 16) / 2
        let height = width * 2346 / 1459
        return CGSize(width: width, height: height - 25)
    }
    
    static let apiErrorTitle: String = "Api-title".localizedString()
    static let apiErrorMess: String = "Api-mess".localizedString()
    static let apiRetry: String = "Api-retry".localizedString()
    static let policy: String = "https://truth.wgt-solution.net/privacy-policy"
    static let term: String = "https://truth.wgt-solution.net/terms"
    static let adsBanner = "ca-app-pub-5818009499885344/6808819188"
    static let appAdsId = "ca-app-pub-5818009499885344~3447895342"
    
    
    static var isInapp: String {
        get {
            return KeychainService.shared.loadString(key: "inAppState") ?? InAppState.notActive.rawValue
        }
        
        set {
            _ = KeychainService.shared.saveString(key: "inAppState", string: newValue)
        }
    }
    
    static var listTopicActive: String {
        //        get { UserDefaults.standard.object([String].self, with: "listTopicActive") ?? [] }
        //        set { UserDefaults.standard.set(object: newValue, forKey: "listTopicActive") }
        get {
            return KeychainService.shared.loadString(key: "listTopicActive") ?? ""
        }
        
        set {
            _ = KeychainService.shared.saveString(key: "listTopicActive", string: newValue)
        }
    }
    
    static var listPayment: [Purchase] {
        get { UserDefaults.standard.object([Purchase].self, with: "listPayment") ?? [] }
        set { UserDefaults.standard.set(object: newValue, forKey: "listPayment") }
    }
    
    static var accessToken: String {
        get {
            return UserDefaults.standard.string(forKey: "access-token") ?? ""
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "access-token")
        }
    }
    
    static var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "refresh-token")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "refresh-token")
        }
    }
    
    static var currentLang: String {
        get {
            return UserDefaults.standard.string(forKey: "current-lang") ?? Lang.en.rawValue
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "current-lang")
        }
    }
    
    static let categories: [Topic] = [
        Topic(name: "Family",
              url_icon: "kids",
              truths: ["Would you prefer to dominate me in bed or do you want me to dominate you in bed?",
                       "What is the most embarrassing item in your room?",
                       "If you could have anyone here in the room to be your slave, who would it be and what would you make them do?",
                       "Was there any teacher you thought was hot? Which one? Why?",
                       "Do you like to exercise?",
                       "If you could marry one teacher in the school, who would you pick and why?",
                       "How far would you go with someone that you just met?",
                       "Do you keep a journal?","What's the dirtiest sext you've ever sent?",
                       "Who in this room you'd like to have sex with?"],
              dares: ["Crabwalk across the room.",
                      "Rate 3 boys and girls you find hot, and want to make out with.",
                      "Be blindfolded for the next 3 rounds.",
                      "Talk to your hand like you re making a game plan to sleep with someone else who is in the room.",
                      "Hold two ice cubes with your hands against your head. Don't let go until they're melted.",
                      "Massage the person on your right.",
                      "Go outside and howl at the moon.",
                      "Massage your partner's feet.",
                      "Make out with someone of the opposite gender for 2 minutes.",
                      "Draw a picture of a cow blindfolded."]),
        
        Topic(name: "Love",
              url_icon: "mixed",
              truths: ["Would you prefer to dominate me in bed or do you want me to dominate you in bed?",
                       "What is the most embarrassing item in your room?",
                       "If you could have anyone here in the room to be your slave, who would it be and what would you make them do?",
                       "Was there any teacher you thought was hot? Which one? Why?",
                       "Do you like to exercise?",
                       "If you could marry one teacher in the school, who would you pick and why?",
                       "How far would you go with someone that you just met?",
                       "Do you keep a journal?","What's the dirtiest sext you've ever sent?",
                       "Who in this room you'd like to have sex with?"],
              dares: ["Crabwalk across the room.",
                      "Rate 3 boys and girls you find hot, and want to make out with.",
                      "Be blindfolded for the next 3 rounds.",
                      "Talk to your hand like you re making a game plan to sleep with someone else who is in the room.",
                      "Hold two ice cubes with your hands against your head. Don't let go until they're melted.",
                      "Massage the person on your right.",
                      "Go outside and howl at the moon.",
                      "Massage your partner's feet.",
                      "Make out with someone of the opposite gender for 2 minutes.",
                      "Draw a picture of a cow blindfolded."]),
        
        Topic(name: "School",
              url_icon: "classic",
              truths: ["Have you ever taken money from your roommate?",
                       "Say something about squirrels.",
                       "What is the latest thing you bought?",
                       "How young were you when you started buying your own alcohol? Did you need a fake ID?","What is your biggest pet peeve?","What are you really really good at?",
                       "What is the strangest dream you've ever had?",
                       "What is the funniest youtube video you have ever seen?",
                       "Have you ever broken something and blamed someone else?",
                       "What is the most embarrassing thing you've done till now?"],
              dares: ["Take off your socks for 3 turns.",
                      "Kiss a stuffed animal like it's your crush.",
                      "Give a 3-minute stand-up comedy routine.",
                      "Lick the floor.",
                      "Spell out the last word of each of your sentences for 5 turns.",
                      "Jump on one leg for 30 seconds.",
                      "Lick the wall.",
                      "Eat a snack without using your hands."]),
        
        Topic(name: "Teens",
              url_icon: "kids",
              truths: ["What is the creepiest animal?",
                       "Have you ever watched a movie or TV show that you know you are not allowed?",
                       "What is your biggest fear?",
                       "Do you prefer tacos or pizza?",
                       "Have you ever cheated to win a game?",
                       "What do you like the most about everyone in the room?",
                       "Have you ever skipped a meal?",
                       "Which superhero do you dig the most?",
                       "Have you tried to befriend a stray dog or cat?",
                       "Would you rather be a princess or a mermaid?"],
              dares: ["Order a prepaid cheese pizza for your neighbor anonymously and leave a nice note with it.",
                      "Make up a poem out loud.",
                      "Snort excessively every time you laugh.",
                      "Act like a bird.",
                      "Remove one sock and shoe so that one foot is bare for the rest of the game.",
                      "Make a face mask out of sliced cheese.","Send a text with only using your nose.",
                      "Do the Hokey Pokey without singing it.",
                      "Do the next dare for the next person that gets one.",
                      "Use lipstick and write the word 'funky monkey across your face. Keep it there at least an hour."]),
        
        Topic(name: "Party",
              url_icon: "party",
              truths: ["Have you ever blacked out because of drinking?",
                       "What would you do if you were the opposite sex for a month?",
                       "Have you ever tried or wanted to try BDSM?",
                       "What is the best party that you've ever been to?",
                       "Would you do a threesome?",
                       "How many boys girls have you slept with?",
                       "Who are the last 3 persons you made cry, and what did you do to them?",
                       "How many times a week do you touch yourself?",
                       "Have you ever talked on the phone while being pleasured?",
                       "Have you ever had someone write a paper for you?"],
              dares: ["Repeat each of your sentences twice.",
                      "Do a backbend.",
                      "Make a freestyle rap song about three people in the group.",
                      "Fake sex noises.",
                      "Sing 'Twinkle Twinkle, Little Star' while beat boxing.",
                      "Set your cell phone language to Chinese for the next 60 minutes.",
                      "Fold yourself into a pretzel.",
                      "Make up a short rap about another player.",
                      "Pick who licks a full circle around your face.",
                      "Make a fish face."]),
        
        Topic(name: "Trending",
              url_icon: "hot",
              truths: ["Do you prefer making a first step in relationship or do you prefer your SO to do it?",
                       "What was your best sexual experience?",
                       "What's the craziest object you've ever used to turn yourself on?",
                       "What kind of foreplay would you like to try the next time we are in bed?",
                       "What does you partner prefer on you: briefs, boxers, thong?",
                       "Have you ever thought about having a threesome?",
                       "Have you ever had sex outside?",
                       "Do you prefer to be on top or bottom?",
                       "What's the stupidest thing you've ever done for love?",
                       "If you had to be in a relationship with one person in this room, who would it be?"],
              dares: ["Share a shirt with the person to your right for the next 3 rounds.",
                      "Clean the toilet with a toothbrush.",
                      "For a guy: put on makeup. For a girl: wash off your make up.",
                      "Demonstrate a move on me that you saw and liked while watching porn.",
                      "Drag me to the closet for an adult round of seven minutes in heaven. You must keep the making out above the belt.",
                      "Remove 2 pieces of clothes.",
                      "Step into a bathroom with somebody of your choice and don't come out for 5 minutes.",
                      "Spell out a short, sultry message on my body with your tongue.",
                      "Person to your right decides whom you have to ask out on a date right now.",
                      "In your most sultry voice, tell me what you loved about the last time we had sex."]),
        
        Topic(name: "Mixed",
              url_icon: "mixed",
              truths: ["Would you prefer to dominate me in bed or do you want me to dominate you in bed?",
                       "What is the most embarrassing item in your room?",
                       "If you could have anyone here in the room to be your slave, who would it be and what would you make them do?",
                       "Was there any teacher you thought was hot? Which one? Why?",
                       "Do you like to exercise?",
                       "If you could marry one teacher in the school, who would you pick and why?",
                       "How far would you go with someone that you just met?",
                       "Do you keep a journal?","What's the dirtiest sext you've ever sent?",
                       "Who in this room you'd like to have sex with?"],
              dares: ["Crabwalk across the room.",
                      "Rate 3 boys and girls you find hot, and want to make out with.",
                      "Be blindfolded for the next 3 rounds.",
                      "Talk to your hand like you re making a game plan to sleep with someone else who is in the room.",
                      "Hold two ice cubes with your hands against your head. Don't let go until they're melted.",
                      "Massage the person on your right.",
                      "Go outside and howl at the moon.",
                      "Massage your partner's feet.",
                      "Make out with someone of the opposite gender for 2 minutes.",
                      "Draw a picture of a cow blindfolded."]),
    ]
}

enum Lang: String {
    case vi = "vi"
    case en = "en"
}

enum InAppState: String {
    case active = "ACTIVE"
    case notActive = "NOACTIVE"
}

class Topic {
    let name: String
    let url_icon: String
    let truths: [String]
    let dares: [String]
    var isLock: Bool = true
    
    init(name: String, url_icon: String, truths: [String], dares: [String]) {
        self.name = name
        self.url_icon = url_icon
        self.truths = truths
        self.dares = dares
    }
}

extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}

func stringFromArray(_ array: [String]) -> String? {
    return (try? JSONSerialization.data(withJSONObject: array, options: []))?.base64EncodedString()
}

func arrayFromString(_ string: String) -> [String]? {
    guard let data = Data(base64Encoded: string) else {
        return nil
    }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String]
}

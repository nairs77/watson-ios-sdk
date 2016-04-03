/**
 * Copyright IBM Corporation 2015
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/**
 * The IBM Watson The Tone Analyzer service uses linguistic analysis to detect 
 * emotional tones, social propensities, and writing styles in written communication. 
 * Then it offers suggestions to help the writer improve their intended language tones.
**/
public class ToneAnalyzer: WatsonService {
    
    // The shared WatsonGateway singleton.
    let gateway = WatsonGateway.sharedInstance
    
    // The authentication strategy to obtain authorization tokens.
    let authStrategy: AuthenticationStrategy
    
    // The version date
    var versionDate:String = "2016-02-11"
    
    // TODO: comment this initializer
    public required init(authStrategy: AuthenticationStrategy) {
        self.authStrategy = authStrategy
    }
    
    // TODO: comment this initializer
    public convenience required init(username: String, password: String) {
        let authStrategy = BasicAuthenticationStrategy(tokenURL: Constants.tokenURL,
            serviceURL: Constants.serviceURL, username: username, password: password)
        
        self.init(authStrategy: authStrategy)
    }

    /**
       Analyzes the "tone" of a piece of text. The message is analyzed from several tones (social
       tone, emotional tone, writing tone), and for each of them various traits are derived (such as
       conscientiousness, agreeableness, openness).
     
     - parameter text:              The text to analyze
     - parameter completionHandler: completionHandler ToneAnalysis result or NSError
     */
    public func getTone(text:String, completionHandler: (ToneAnalysis?, NSError?) -> Void) {
        
        // construct request
        let request = WatsonRequest(
            method: .GET,
            serviceURL: Constants.serviceURL,
            endpoint: Constants.tone,
            authStrategy: authStrategy,
            accept: .JSON,
            urlParams: [NSURLQueryItem(name: "text", value: text),NSURLQueryItem(name: "version", value: self.versionDate)])
        
        // execute request
        gateway.request(request, serviceError: ToneAnalyzerError()) { data, error in

            var json:AnyObject?
            var toneAnalysis:ToneAnalysis?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                if let json = json {
                    toneAnalysis = ToneAnalysis.init(anyObject: json)
                }
            } catch let jsonError {
                print(jsonError)
            }
            completionHandler(toneAnalysis, error)
        }
    }
}
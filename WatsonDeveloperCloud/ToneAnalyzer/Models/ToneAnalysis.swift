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

extension ToneAnalyzer {
    
    /**
     *
     * Main object containing the result of running Tone Analyzer on a document. 
     * It contains both the sentence-level and document-level results.
     */
    public struct ToneAnalysis{
        
        // The tone analysis of the full document.
        public var documentTone:ElementTone?
        
        /// The sentence level tone analysis.
        public var sentencesTones:[SentenceTone]? = []
        
        init(anyObject: AnyObject) {
            self.documentTone = ElementTone.init(anyObject: anyObject["document_tone"] as! [String: AnyObject])
            for jsonSentenceTone in anyObject["sentences_tone"] as! [AnyObject] {
                sentencesTones?.append(SentenceTone.init(anyObject: jsonSentenceTone))
            }
        }
    }
}
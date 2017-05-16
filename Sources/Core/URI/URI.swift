/**
 The generic URI [syntax](https://tools.ietf.org/html/rfc3986#section-1) consists of a hierarchical sequence of
 components referred to as the `scheme`, `userInfo`, `host`, `port`, `path`, `query`, and
 `fragment`.

 The following example URI and their component parts:
 
 ```
 foo://username:password@example.com:8042/over/there?name=ferret#nose
 \_/   \_______________/ \_________/ \__/ \________/ \_________/ \__/
 |           |                |       |       |           |       |
 scheme  user info           host    port    path       query  fragment
 ```
 */
public struct URI {
    public var scheme: String?
    public var userInfo: UserInfo?
    public var host: String?
    public var port: Int?
    public var path: String?
    public var query:  String?
    public var fragment: String?
    
    public var parameters: Parameters
    
    public init(
        scheme: String? = nil,
        userInfo: UserInfo? = nil,
        host: String? = nil,
        port: Int? = nil,
        path: String? = nil,
        query: String? = nil,
        fragment: String? = nil
    ) {
        self.scheme = scheme
        self.userInfo = userInfo
        self.host = host
        self.port = port
        self.path = path
        self.query = query
        self.fragment = fragment
        self.parameters = Parameters(query: query)
    }
    
    public struct Parameters {
        var parameters: [String: String]
        
        init(query: String?) {
            var parameters: [String: String] = [:]
            let components = query?.components(separatedBy: "&") ?? []
            
            for component in components {
                let pair = component.components(separatedBy: "=")
                
                if pair.count == 2 {
                    parameters[pair[0]] = pair[1]
                }
            }
            
            self.parameters = parameters
        }
    }
    
    public struct UserInfo {
        public var username: String
        public var password: String
        
        public init(username: String, password: String) {
            self.username = username
            self.password = password
        }
    }
}

extension URI.UserInfo : CustomStringConvertible {
    public var description: String {
        return username + ":" + password
    }
}

extension URI : CustomStringConvertible {
    public var description: String {
        var string = ""
        
        if let scheme = scheme {
            string += "\(scheme)://"
        }
        
        if let userInfo = userInfo {
            string += "\(userInfo)@"
        }
        
        if let host = host {
            string += "\(host)"
        }
        
        if let port = port {
            string += ":\(port)"
        }
        
        if let path = path {
            string += "\(path)"
        }
        
        if let query = query {
            string += "\(query)"
        }
        
        if let fragment = fragment {
            string += "#\(fragment)"
        }
        
        return string
    }
}
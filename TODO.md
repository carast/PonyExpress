
### GENERAL
- rename sender and receiver to denote UDP
- sort out bundles
- take stance on port reuse, either reuse and demo multicast or don't and don't

### MESSAGE
- add initializers with vararg
- make debug buffer dump multi-line and byte-gap configurable
- implement Timetag
- do a better job with NSData allocation and writing in -_data
- ignore unknown types (is that even possible?)

### SENDER
- document 9k UDP limit and Blob use
- replace sender delegate with a block, which could simulate a delate pattern anyways
- migrate message cache to an NSCache

### RECEIVER
- consider some sort of simple router

### UNIT TESTS
- test message argument serialization
- test message argument deserialization
- test sender with bad host
- remove port in use / privileged port tests as they 

### FUNCTIONAL TESTS
- functional check receipt of message
- functional check delivery of message
- functional check handling of send bad message data
- functional check handling of receive bad message data
- send data on privileged port, < 1024
- try to connect/send data to port in use
- send data to bad host
- receive data on privileged port, < 1024
- try to connect/receive data to port in use

### MISC
- sample router? ?*[!-]{,}//
- example message snooper

### LATER
- mDNS receiver announcement
- consider a PEOSCValue class to wrap boxing
- add socket management layer to allow sharing
- static library option for iOS
- add TCP and Serial sender/receiver classes
- allow end points to be discovered through query proposal
import Foundation

public struct ZipArchiver {
    
    public struct FileEntry {
        public let name: String
        public let data: Data
        
        public init(name: String, text: String) {
            self.name = name
            self.data = text.data(using: .utf8) ?? Data()
        }
        
        public init(name: String, data: Data) {
            self.name = name
            self.data = data
        }
    }
    
    /// Creates a standard uncompressed PKZIP (store) archive data from a list of files.
    /// Compatible with macOS Archive Utility, Windows Explorer, Linux unzip, and iOS Files.
    public static func createZip(files: [FileEntry]) -> Data {
        var zipData = Data()
        var centralDirectory = Data()
        
        let dosTimeDate: UInt32 = 0x546B6B21 // 2026-05-11 13:25:34
        
        for file in files {
            let offset = UInt32(zipData.count)
            let fileNameData = file.name.data(using: .utf8) ?? Data()
            let fileNameLength = UInt16(fileNameData.count)
            let fileSize = UInt32(file.data.count)
            let crc = crc32(data: file.data)
            
            // 1. Local File Header (30 bytes + filename)
            var localHeader = Data()
            localHeader.append(contentsOf: [0x50, 0x4B, 0x03, 0x04]) // signature 0x04034b50
            localHeader.append(UInt16(20).littleEndianData)          // version needed (2.0)
            localHeader.append(UInt16(0).littleEndianData)           // general purpose bit flag
            localHeader.append(UInt16(0).littleEndianData)           // compression method (0 = store)
            localHeader.append(dosTimeDate.littleEndianData)         // mod time and date
            localHeader.append(crc.littleEndianData)                 // crc-32
            localHeader.append(fileSize.littleEndianData)            // compressed size
            localHeader.append(fileSize.littleEndianData)            // uncompressed size
            localHeader.append(fileNameLength.littleEndianData)      // file name length
            localHeader.append(UInt16(0).littleEndianData)           // extra field length
            localHeader.append(fileNameData)                         // file name
            
            zipData.append(localHeader)
            zipData.append(file.data)
            
            // 2. Central Directory Header (46 bytes + filename)
            var cdHeader = Data()
            cdHeader.append(contentsOf: [0x50, 0x4B, 0x01, 0x02])   // signature 0x02014b50
            cdHeader.append(UInt16(20).littleEndianData)            // version made by
            cdHeader.append(UInt16(20).littleEndianData)            // version needed
            cdHeader.append(UInt16(0).littleEndianData)             // general purpose bit flag
            cdHeader.append(UInt16(0).littleEndianData)             // compression method
            cdHeader.append(dosTimeDate.littleEndianData)           // mod time and date
            cdHeader.append(crc.littleEndianData)                   // crc-32
            cdHeader.append(fileSize.littleEndianData)              // compressed size
            cdHeader.append(fileSize.littleEndianData)              // uncompressed size
            cdHeader.append(fileNameLength.littleEndianData)        // file name length
            cdHeader.append(UInt16(0).littleEndianData)             // extra field length
            cdHeader.append(UInt16(0).littleEndianData)             // file comment length
            cdHeader.append(UInt16(0).littleEndianData)             // disk number start
            cdHeader.append(UInt16(0).littleEndianData)             // internal file attributes
            cdHeader.append(UInt32(0).littleEndianData)             // external file attributes
            cdHeader.append(offset.littleEndianData)                // relative offset of local header
            cdHeader.append(fileNameData)                           // file name
            
            centralDirectory.append(cdHeader)
        }
        
        let cdOffset = UInt32(zipData.count)
        let cdSize = UInt32(centralDirectory.count)
        let totalEntries = UInt16(files.count)
        
        zipData.append(centralDirectory)
        
        // 3. End of Central Directory Record (22 bytes)
        var eocd = Data()
        eocd.append(contentsOf: [0x50, 0x4B, 0x05, 0x06])           // signature 0x06054b50
        eocd.append(UInt16(0).littleEndianData)                      // number of this disk
        eocd.append(UInt16(0).littleEndianData)                      // disk with central directory
        eocd.append(totalEntries.littleEndianData)                   // total entries on this disk
        eocd.append(totalEntries.littleEndianData)                   // total entries in central directory
        eocd.append(cdSize.littleEndianData)                         // size of central directory
        eocd.append(cdOffset.littleEndianData)                       // offset of start of central directory
        eocd.append(UInt16(0).littleEndianData)                      // zipfile comment length
        
        zipData.append(eocd)
        return zipData
    }
    
    // Standard CRC-32 implementation
    private static func crc32(data: Data) -> UInt32 {
        var crc: UInt32 = 0xFFFFFFFF
        for byte in data {
            let index = UInt32((crc ^ UInt32(byte)) & 0xFF)
            crc = (crc >> 8) ^ crcTable[Int(index)]
        }
        return crc ^ 0xFFFFFFFF
    }
    
    private static let crcTable: [UInt32] = {
        (0...255).map { i -> UInt32 in
            var c = UInt32(i)
            for _ in 0..<8 {
                if (c & 1) != 0 {
                    c = 0xEDB88320 ^ (c >> 1)
                } else {
                    c = c >> 1
                }
            }
            return c
        }
    }()
}

private extension UInt16 {
    var littleEndianData: Data {
        var val = self.littleEndian
        return Data(bytes: &val, count: MemoryLayout<UInt16>.size)
    }
}

private extension UInt32 {
    var littleEndianData: Data {
        var val = self.littleEndian
        return Data(bytes: &val, count: MemoryLayout<UInt32>.size)
    }
}

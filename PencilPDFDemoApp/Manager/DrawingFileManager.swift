//
//  DrawingFileManager.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/6/24.
//

import Foundation

class DrawingFileManager {
    static var share = DrawingFileManager()
    private let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private lazy var drawingDatasURL = documentsURL.appendingPathComponent("DrawingDatas")
    
    func checkDirectory(bookId: String) -> Bool {
        let url = documentsURL.appendingPathComponent(bookId)
        return url.isFileURL
    }
    
    func makeDirectory(bookId: String) {
        let bookURL = drawingDatasURL.appendingPathComponent(bookId)
        do {
            try FileManager.default.createDirectory(at: bookURL, withIntermediateDirectories: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveDrawingDatas(datas: [Data], bookId: String) {
        for i in 0..<datas.count {
            let path = drawingDatasURL.appendingPathComponent(bookId).appendingPathComponent("data\(i)")
            let data = datas[i]
            do {
                try data.write(to: path)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getDrawingDatas(bookId: String, totalPage: Int) -> [Data] {
        var datas = [Data]()
        
        for i in 0..<totalPage {
            let path = drawingDatasURL.appendingPathComponent(bookId).appendingPathComponent("data\(i)")
            do {
                let data = try Data.init(contentsOf: path)
                datas.append(data)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return datas
    }
}

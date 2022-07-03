//
//  KnownBySquarePresenter.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 26.06.2022.
//

import UIKit
import CoreMotion
import CoreData

final class KnownBySquarePresenter: NSObject, KnownBySquareViewOutput {
    
    // MARK: - Properties
    
    private weak var view: KnownBySquareViewInput?
    private weak var router: KnownBySquareRouterProtocol?
    private var motionManager: CMMotionManager?
    
    private var orientationLast: UIInterfaceOrientation = {
        let orientation = UIInterfaceOrientation(rawValue: 0)!
        return orientation
    }()
    
    // MARK: - Init
    
    init(view: KnownBySquareViewInput, router: KnownBySquareRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}

// MARK: - Core Motion
extension KnownBySquarePresenter {
    
    func addCoreMotion() {
        let updateTimer: TimeInterval = 0.5
        
        motionManager = CMMotionManager()
        motionManager?.gyroUpdateInterval = updateTimer
        motionManager?.accelerometerUpdateInterval = updateTimer
        motionManager?.startAccelerometerUpdates(to: (OperationQueue.current)!, withHandler: {
            (acceleroMeterData, error) -> Void in
            if error == nil {
                let acceleration = (acceleroMeterData?.acceleration)!
                self.deviceOrientationChanged(acceleration)
            }
            else {
                print("error : \(error!)")
            }
        })
    }
    
    func deviceOrientationChanged(_ acceleration: CMAcceleration) {
        
        var orientationNew: UIInterfaceOrientation
        let splitAngle: Double = 0.75
        
        if acceleration.x >= splitAngle {
            orientationNew = .landscapeLeft
        } else if acceleration.x <= -(splitAngle) {
            orientationNew = .landscapeRight
        } else if acceleration.y <= -(splitAngle) {
            orientationNew = .portrait
        } else if acceleration.y >= splitAngle {
            orientationNew = .portraitUpsideDown
        } else {
            orientationNew = UIInterfaceOrientation(rawValue: 0)!
        }
        
        if orientationNew != orientationLast && orientationNew != .unknown {
            orientationLast = orientationNew
            if orientationNew.rawValue == 2 {
                view?.animateSquare()
                print("dropup")
            }
        }
        
    }
}

extension KnownBySquarePresenter {
    func saveTask(at screen: Screens) {
        guard
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        else { return }

        let fetchResult = fetch(context)
        let index = Screens.allCases.firstIndex(of: screen) ?? 0 as Int
        let managedObject = fetchResult[index]
        managedObject.setValue(true, forKey: CDKeys.isCompleted)
        save(context)
    }
}

private extension KnownBySquarePresenter {
    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetch(_ context: NSManagedObjectContext) -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

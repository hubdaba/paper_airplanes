//
//  HelloWorldViewController.m
//  HelloWorld
//
//  Created by Daniel Jeng on 5/10/13.
//  Copyright (c) 2013 Daniel Jeng. All rights reserved.
//

#import "HelloWorldViewController.h"

@interface HelloWorldViewController ()

@end

@implementation HelloWorldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    vMagMax = 0;
    
    v1Total = 0;
    v2Total = 0;
    v3Total = 0;
    
    timeSinceLastUpdate = CACurrentMediaTime();
    
    phoneOrientation = [[Orientation alloc] init];
    self.motionManager = [[CMMotionManager alloc] init];
    
    
    self.motionManager.deviceMotionUpdateInterval = 0.01;
    
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                            [self outputDeviceData:motion];
                                            if (error) {
                                                NSLog(@"%@", error);
                                            }
                                        }];
    
}

-(void)outputDeviceData:(CMDeviceMotion*) motion {
    double currentTime = CACurrentMediaTime();
    double deltaTime = currentTime - timeSinceLastUpdate;
    timeSinceLastUpdate = currentTime;
    
    CMAcceleration acc = motion.userAcceleration;
    
    if (acc.x * deltaTime < 0.001 && acc.y * deltaTime < 0.001 && acc.z * deltaTime < 0.001) {
        return;
    }
     
   /* double xangle = motion.rotationRate.x * deltaTime * 2 * M_PI;
    double yangle = motion.rotationRate.y * deltaTime * 2 * M_PI;
    double zangle = motion.rotationRate.z * deltaTime * 2 * M_PI;
    
    
    int iters = 10;
    
    //NSLog(@"xangle is %f %f %f", xangle, yangle, zangle);
    // NSLog(@"delta time is %f", deltaTime);
    for (int i = 0; i < iters; i++) {
        [phoneOrientation rotateX:xangle/iters];
        [phoneOrientation rotateY:yangle/iters];
        [phoneOrientation rotateZ:zangle/iters];
    }
    
    Orientation* xAxis = [phoneOrientation getX];
    Orientation* yAxis = [phoneOrientation getY];
    Orientation* zAxis = [phoneOrientation getZ];*/
    
   /*v1Total += [xAxis v1] * acc.x * deltaTime + [yAxis v1] * acc.y * deltaTime + [zAxis v1] * acc.z * deltaTime;
    v2Total += [xAxis v2] * acc.x * deltaTime + [yAxis v2] * acc.y * deltaTime + [zAxis v2] * acc.z * deltaTime;
    v3Total += [xAxis v3] * acc.x * deltaTime + [yAxis v3] * acc.y * deltaTime + [zAxis v3] * acc.z * deltaTime;

    
    v1Total += acc.x * deltaTime;
    v2Total += acc.y * deltaTime;
    v3Total += acc.z * deltaTime;
*/
    vMagMax += sqrt(acc.x * deltaTime * acc.x * deltaTime + acc.y *acc.y * deltaTime * deltaTime  + acc.z * acc.z * deltaTime * deltaTime);
/*    double vMag = sqrt(v1Total * v1Total + v2Total * v2Total + v3Total * v3Total);
    if (vMagMax < vMag) {
        vMagMax = vMag;
    }*/
    NSLog(@"%g", vMagMax);
    
    self.velocity.text = [NSString stringWithFormat:@"%f m/s", vMagMax];
   // NSLog(@"x: %g %g %g", v1Total, v2Total, v3Total);

    
   //NSLog(@"xaxis is %@", [xAxis stringRep]);
}


- (IBAction)resetMaxValues:(id)sender {
    vMagMax = 0;
    v1Total = 0;
    v2Total = 0;
    v3Total = 0;
      self.velocity.text = [NSString stringWithFormat:@"%f m/s", vMagMax];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) showMessage
{
    UIAlertView *helloWorldAlert = [[UIAlertView alloc]
                                    initWithTitle:@"My First App"
                                    message:@"Hello, World!"
                                    delegate:nil
                                    cancelButtonTitle:@"OK"
                                    otherButtonTitles:nil];
    
    [helloWorldAlert show];
}


@end

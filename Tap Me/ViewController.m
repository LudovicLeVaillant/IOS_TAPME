//
//  ViewController.m
//  Tap Me
//
//  Created by ludovic Le Vaillant on 13/07/2014.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
    scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_score.png"]];
    timerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_time.png"]];
    
    buttonBeep = [self SetupAudiPlayerWithFile:@"ButtonTap" type:@"wav"];
    secondBeep = [self SetupAudiPlayerWithFile:@"SecondBeep" type:@"wav"];
    backgroundMusic = [self SetupAudiPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];
    [self SetupGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed {
    count++;
    
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%li", count];
    
    [buttonBeep play];
}

-(void)SetupGame{
    count=0;
    seconds=5;
    
    timerLabel.text = [NSString stringWithFormat:@"Time :%li", seconds];
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%li", count];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(substracTime)
                                           userInfo:nil
                                            repeats:YES];
    [backgroundMusic setVolume:0.3];
    [backgroundMusic play];
}
-(void)substracTime{
    seconds--;
        timerLabel.text = [NSString stringWithFormat:@"Time :%li", seconds];
    
    [secondBeep play];
    
    if (seconds == 0)
    {
        [timer invalidate];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!"
                                                        message:[NSString stringWithFormat:@"You're score is %li", count]
                                                       delegate:self
                                              cancelButtonTitle:@"Play Again!"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self SetupGame];
}

-(AVAudioPlayer *)SetupAudiPlayerWithFile:(NSString *)file type:(NSString *)type{
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSError *error;
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!audioPlayer){
        NSLog(@"%@",[error description]);
    }
    return audioPlayer;
}
@end

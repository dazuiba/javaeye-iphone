int main(int argc, char *argv[]) 
{    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"EBAppDelegate");
    [pool release];
    return retVal;
}

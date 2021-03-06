/* Audio class - by Al Biles
 Declares and loads all audio assets.
 Should be called in setup().
 Also provides methods that make life easier for playing or triggering
 sounds from the other classes.
 safePlay() plays a sound only if the sound isn't already playing.
 safePlay() has an overload that plays the sound at a given pan loc.
 triggerWhere() triggers an AudioSample at a given pan location.
 panPlay() is a specialized method for playing the torpedo track sound
 by panning it with the torpedo from the sub's location on launch
 to the right edge of the window and then fading it out from there. 
 This tab also contains the PingTone class, which uses Minim UGens
 to synthesize sonar ping tones as an example of using synthesis
 techniques for sound effects.
 */
class Audio
{
  AudioPlayer forwardSnd;
  AudioPlayer reverseSnd;
  AudioPlayer diveSnd;
  AudioSample bangSnd;
  AudioSample disarmSnd;
  AudioSample zapSnd;
  AudioSample groundSnd;
  AudioPlayer noMoreSnd;
  AudioPlayer fireSnd;
  AudioPlayer tooLeftSnd;
  AudioPlayer tooRightSnd;
  AudioPlayer tooUpSnd;
  AudioPlayer tooDownSnd;
  AudioPlayer sinkingSnd;
  AudioPlayer sunkSnd;
  AudioPlayer winSnd;
  AudioPlayer bubbleSnd;
  AudioPlayer torpRunSnd;
  
  AudioPlayer backSnd; //Music
  AudioPlayer ambient1Snd;
  AudioPlayer ambient2Snd;
  
  AudioPlayer disarmDialog;
  AudioPlayer diveDialog;
  AudioPlayer fireDialog;
  AudioPlayer forwardDialog;
  AudioPlayer sinkingDialog;
  AudioPlayer sunkDialog;

  AudioOutput out;    // Used for PingTone

  void loadAudio()    // Called in setup()
  {
    forwardSnd = minim.loadFile("Audio/Ours/Forward.wav", 512);
    forwardSnd.setGain(0.0);     // Turn it down
    reverseSnd = minim.loadFile("Audio/Ours/Reverse.wav", 512);
    reverseSnd.setGain(-5.0);
    diveSnd = minim.loadFile("Audio/Ours/Dive.wav", 512);
    diveSnd.setGain(0.0);
    bangSnd = minim.loadSample("Audio/Ours/Bang.wav", 512);
    disarmSnd = minim.loadSample("Audio/Ours/Disarm.wav", 512);
    zapSnd = minim.loadSample("Audio/Ours/Zap.wav", 512);
    zapSnd.setGain(-8.0);
    groundSnd = minim.loadSample("Audio/Ours/Grounded.wav", 512);
    noMoreSnd = minim.loadFile("Audio/Ours/NoMore.wav", 512);
    fireSnd = minim.loadFile("Audio/Ours/Fire.wav", 512);
    tooLeftSnd = minim.loadFile("Audio/Ours/Dialog/TooFarLeft.wav", 512);
    tooRightSnd = minim.loadFile("Audio/Ours/Dialog/TooFarRight.wav", 512);
    tooRightSnd.setGain(5.0);
    tooUpSnd = minim.loadFile("Audio/Ours/Dialog/TooFarUp.wav", 512);
    tooDownSnd = minim.loadFile("Audio/Ours/Dialog/TooFarDown.wav", 512);
    sinkingSnd = minim.loadFile("Audio/Ours/Dialog/Sinking.wav", 512);
    sunkSnd = minim.loadFile("Audio/Ours/Dialog/Sunk.wav", 512);
    winSnd = minim.loadFile("Audio/Ours/Win.wav", 512);
    bubbleSnd = minim.loadFile("Audio/Ours/Bubbles.wav", 512);
    bubbleSnd.setGain(-12.0);
    torpRunSnd = minim.loadFile("Audio/Ours/TorpedoRun.wav", 512);
    
    //Ambient / Music
    backSnd = minim.loadFile("Audio/Ours/Anthem.wav", 512);
    backSnd.setGain(-10.0);
    ambient1Snd = minim.loadFile("Audio/Ours/ambientSnd3.wav", 512);
    ambient2Snd = minim.loadFile("Audio/Ours/spookyWaters.wav", 512);
    ambient2Snd.setGain(-24.0); 
    // Dialog
    disarmDialog = minim.loadFile("Audio/Ours/Dialog/Disarm.wav", 512);
    disarmDialog.setGain(5.0);

    diveDialog = minim.loadFile("Audio/Ours/Dialog/Down.wav", 512);
    fireDialog = minim.loadFile("Audio/Ours/Dialog/Fire.wav", 512);
    forwardDialog = minim.loadFile("Audio/Ours/Dialog/Forward.wav", 512);
    sinkingDialog = minim.loadFile("Audio/Ours/Dialog/Sinking.wav", 512);
    sunkDialog = minim.loadFile("Audio/Ours/Dialog/Sunk.wav", 512);

    out = minim.getLineOut();    // Used for PingTone
  }

  void pauseAll()  // Called when user types 'q' to quit
  {    
    forwardSnd.pause();
    reverseSnd.pause();
    diveSnd.pause();
    bangSnd.stop();
    disarmSnd.stop();
    zapSnd.stop();
    groundSnd.stop();
    noMoreSnd.pause();
    fireSnd.pause();
    backSnd.pause();
    tooLeftSnd.pause();
    tooRightSnd.pause();
    tooUpSnd.pause();
    tooDownSnd.pause();
    sinkingSnd.pause();
    sunkSnd.pause();
    winSnd.pause();
    bubbleSnd.pause();
    torpRunSnd.pause();
    out.mute();
    
    ambient1Snd.pause();
    ambient2Snd.pause();
    
    disarmDialog.pause();
    diveDialog.pause();
    fireDialog.pause();
    forwardDialog.pause();
    sinkingDialog.pause();
    sunkDialog.pause();
  }

  void closeAll()  // Called from stop() in main
  {
    forwardSnd.close();
    reverseSnd.close();
    diveSnd.close();
    bangSnd.close();
    disarmSnd.close();
    zapSnd.close();
    groundSnd.close();
    noMoreSnd.close();
    fireSnd.close();
    backSnd.close();
    tooLeftSnd.close();
    tooRightSnd.close();
    tooUpSnd.close();
    tooDownSnd.close();
    sinkingSnd.close();
    sunkSnd.close();
    winSnd.close();
    bubbleSnd.close();
    torpRunSnd.close();
    
    ambient1Snd.close();
    ambient2Snd.close();
    
    disarmDialog.close();
    diveDialog.close();
    fireDialog.close();
    forwardDialog.close();
    sinkingDialog.close();
    sunkDialog.close();
  }
  
  void randomPlay(AudioPlayer snd, float chance, float location) 
  {
    if(!snd.isPlaying() &&
       !disarmDialog.isPlaying() &&
       !diveDialog.isPlaying() &&
       !fireDialog.isPlaying() &&
       !forwardDialog.isPlaying() &&
       !sinkingDialog.isPlaying() &&
       !sunkDialog.isPlaying() &&
       !tooLeftSnd.isPlaying() &&
       !tooRightSnd.isPlaying() &&
       !tooUpSnd.isPlaying() &&
       !tooDownSnd.isPlaying()) {
      float r = random(100);
      println(r);
      if(r < chance) {
       safePlay(snd, location);
      }
    }
  }

  // Plays snd beginning at pan location x, panning in real time
  // toward right window edge, given initial torpedo speed launchV
  void panPlay(AudioPlayer snd, float x, float launchV)
  {
    if (! snd.isPlaying())
    {
      float panStart = map(x, 0, width, -1.0, 1.0);  // Where to start pan
      int panTime = figurePanTime(x, launchV);  // How long pan will take
      snd.rewind();
      snd.setGain(0.0);
      snd.shiftPan(panStart, 1.0, panTime);     // Start panning the sound
      snd.play();                               // Start playing the sound
    }
  }

  // Figures how many milliseconds it will take for torpedo to move from
  // x location to right window edge, given initial speed initV
  int figurePanTime(float x, float initV)
  {
    float where = x;       // Starting at x, move where
    float velX = initV;    // Initial velocity
    int nPanFrames = 0;    // Count number of frames
    while (where < width)
    {
      where += velX;       // move to next x location
      velX += t1.a.x;      // Apply drag effect
      nPanFrames++;        // Count the frame
    }
    return int (nPanFrames * 1000 / frameRate);  // Convert to milliseconds
  }

  // Fade out snd over the rest of its playing
  void fadeOut(AudioPlayer snd)
  {
    if (snd.isPlaying())
    {
      int fadeTime = snd.length() - snd.position();    // How much left
      snd.shiftGain(snd.getGain(), -15.0, fadeTime);   // Fade that long
    }
  }

  // Play sound only if it's not already playing
  void safePlay (AudioPlayer snd)
  {
    if (! snd.isPlaying())
    {
      snd.rewind();
      snd.play();
    }
  }

  // Overload to play at loc x mapped to L/R pan
  void safePlay (AudioPlayer snd, float x)
  {
    if (! snd.isPlaying())
    {
      snd.rewind();
      snd.setPan(map(x, 0, width, -1.0, 1.0));
      snd.play();
    }
  }

  // Trigger at pan value mapped from x location
  void triggerWhere(AudioSample snd, float x)
  {
    snd.setPan(map(x, 0, width, -1.0, 1.0));
    snd.trigger();
  }

  void oscOn()
  {
    /*
    println("Entering oscOn");
     wave.reset();
     damp.activate();
     // turn on the ADSR
     adsr.noteOn();
     // patch to the output
     myDelay.patch( out );
     */
  }

  void oscOff()
  {
    // tell the ADSR to unpatch after the release is finished
    //damp.unpatchAfterDamp( out );
    /*
    // call the noteOff 
     adsr.noteOff();
     */
  }

  // Triggered when sub moves too far out of the window
  void tooFarLeft()  // Plays when sub too far left out of the window
  {
    safePlay(tooLeftSnd, 0.0);
  }

  void tooFarRight()
  {
    safePlay(tooRightSnd, width);
  }

  void tooFarUp()
  {
    safePlay(tooUpSnd);
  }

  void tooFarDown()
  {
    safePlay(tooDownSnd);
  }
  
}

/* PingTone class - by Al Biles
 Uses Minim UGens to implement a synthesis chain that generates
 sonar pings at a random pan location.
 Main creates a PingTone object and calls noteOn() to start pinging
 */
class PingTone
{
  Oscil myWave;      // Sine wave oscillator for the ping sound
  Damp myDamp;       // Damp envelope for decay after quick attack
  Delay myDelay;     // Use Delay effect for echo
  Pan myPan;         // Pan it somewhere in the stereo field

  PingTone()         // Constructor creates an object for the pings
  {
    myWave = new Oscil( 1000, 0.5, Waves.SINE ); // 1000 Hz, kinda loud
    myDamp = new Damp( 0.05, 0.25, 0.9 );         // Attack, decay time, amp
    myDelay = new Delay( 0.75, 0.5, true, true ); // Delay with feedback
    myPan = new Pan(random(-1.0, 1.0));          // Random pan location
    myWave.patch(myDamp).patch(myDelay).patch(myPan); // Chain together
  }

  void noteOn()      // Called from main to start pinging
  {
    myDamp.activate();          // Turn on the envelope
    myPan.patch( aud.out );     // Patch end of chain to out to hear it
    myDamp.unpatchAfterDamp( aud.out );
  }

  void noteOff()                // Not needed with the Delay envelope
  {
    myDamp.unpatchAfterDamp( aud.out );
  }
}


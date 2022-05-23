void LoadSounds() {
  // Load a soundfile from the /data folder of the sketch and play it back

  BeginSound = new SoundFile(this, "BeginSound.aif");
  Scenario0Sound = new SoundFile(this, "Scenario0Sound.aif");
  Scenario1Sound = new SoundFile(this, "Scenario1Sound.aif");
  Scenario2Sound = new SoundFile(this, "Scenario2Sound.aif");
  Scenario3Sound = new SoundFile(this, "Scenario3Sound.aif");
  Scenario4Sound = new SoundFile(this, "Scenario4Sound.aif");
  Scenario5Sound = new SoundFile(this, "Scenario5Sound.aif");
  Scenario6Sound = new SoundFile(this, "Scenario6Sound.aif");
  Scenario7Sound = new SoundFile(this, "Scenario7Sound.aif");

  RightQR = new SoundFile(this, "RightQR.wav");
  WrongQR = new SoundFile(this, "WrongQR.wav");
}

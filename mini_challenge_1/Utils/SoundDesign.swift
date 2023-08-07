import AVFoundation

class SoundDesign {
    
    static let shared = SoundDesign()
    
    private var backgroundMusicPlayer: AVAudioPlayer? // background music player
    private var soundEffectPlayer: AVAudioPlayer? // sfx player
    
    private init() {}
    
    // Adds the background music
    func playBackgroundMusic(filename: String) {
        guard let music = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("Arquivo da música de fundo não encontrado.")
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: music) // initialize the audioplayer
            backgroundMusicPlayer?.numberOfLoops = -1 // sets the audio to loop forever
            backgroundMusicPlayer?.volume = 0.03 // sets the volume at 3%
            backgroundMusicPlayer?.play() // plays the music
            
            
            
        } catch {
            print("Erro ao reproduzir a música de fundo: \(error.localizedDescription)")
        }
    }
    
    // Adds the sound effects
    func playSoundEffect(filename: String) {
        guard let sound = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("Arquivo de efeito sonoro não encontrado.")
            return
        }
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: sound)
            soundEffectPlayer?.numberOfLoops = -1
            soundEffectPlayer?.volume = 0.05 // Volume at 5%
            soundEffectPlayer?.prepareToPlay() // prepares the sfx to play. Makes if less likely to delay
            soundEffectPlayer?.play()
        } catch {
            print("Erro ao reproduzir o efeito sonoro: \(error.localizedDescription)")
        }
    }
        
    // Efeito de fade in da música:
    func fadeInMusic(filename: String, duration: TimeInterval) {
        guard let music = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("Arquivo da música de fundo (fade-in) não encontrado.")
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: music)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.volume = 0
            backgroundMusicPlayer?.play()
            backgroundMusicPlayer?.setVolume(0.03, fadeDuration: duration) // setup for the fade-in (volume and duration)
            
        } catch {
            print("Erro ao reproduzir a música de fundo: \(error.localizedDescription)")
        }
    }
    
    // Fade-out effect (option parameter to check if the effect was completed)
    func fadeOutMusic(duration: TimeInterval, completion: (() -> Void)?) {
        guard let player = backgroundMusicPlayer else { return }
        player.setVolume(0, fadeDuration: duration)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { // forces the next action to wait for the completion of the fade-out effect
            completion?()
        }
    }
    
    // Fade-out effect (option parameter to check if the effect was completed)
    func fadeOutSoundEffect(duration: TimeInterval, completion: (() -> Void)?) {
        guard let player = soundEffectPlayer else { return }
        player.setVolume(0, fadeDuration: duration)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { // forces the next action to wait for the completion of the fade-out effect
            completion?()
        }
    }
    
    func muteMusic() {
        backgroundMusicPlayer?.volume = 0
    }
    
    func muteSoundEffect() {
        soundEffectPlayer?.volume = 0
    }
    
    func unmuteMusic() {
        backgroundMusicPlayer?.volume = 0.03
    }
    
    func unmuteSoundEffet() {
        soundEffectPlayer?.volume = 0.05
    }
    
    func stopSoundEffect() {
        soundEffectPlayer?.stop()
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
}

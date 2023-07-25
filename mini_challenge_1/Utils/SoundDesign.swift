import AVFoundation

class SoundDesign {
    
    static let shared = SoundDesign()
    
    private var backgroundMusicPlayer: AVAudioPlayer? // Reprodutor de música de fundo
    private var soundEffectPlayer: AVAudioPlayer? // Reprodutor de efeito sonoro
    
    private init() {}
    
    // Função para adicionar uma música de fundo:
    func playBackgroundMusic(filename: String) {
        guard let music = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("Arquivo da música de fundo não encontrado.")
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: music) // Inicializa o reprodutor com o URL do arquivo de música
            backgroundMusicPlayer?.numberOfLoops = -1 // Coloca a música em loop infinito
            backgroundMusicPlayer?.volume = 0.1 // Volume em 20%
            backgroundMusicPlayer?.play() // Inicia a música
            
            
            
        } catch {
            print("Erro ao reproduzir a música de fundo: \(error.localizedDescription)")
        }
    }
    
    // Função para adicionar efeitos sonoros:
    func playSoundEffect(filename: String) {
        guard let sound = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("Arquivo de efeito sonoro não encontrado.")
            return
        }
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: sound)
            soundEffectPlayer?.numberOfLoops = -1
            soundEffectPlayer?.volume = 0.1 // Volume em 50%
            soundEffectPlayer?.prepareToPlay() // Deixa o som preparado para tocar. Diminui possíveis delays
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
            backgroundMusicPlayer?.setVolume(0.1, fadeDuration: duration) // Determina o volume do fade-in e a duração
            
        } catch {
            print("Erro ao reproduzir a música de fundo: \(error.localizedDescription)")
        }
    }
    
    // Efeito de fade-out da música (recebe um parâmetro opcional para checar se o efeito foi concluído):
    func fadeOutMusic(duration: TimeInterval, completion: (() -> Void)?) {
        guard let player = backgroundMusicPlayer else { return }
        player.setVolume(0, fadeDuration: duration)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { // Obriga a próxima ação esperar a conclusão do fade-out.
            completion?()
        }
    }
    
    // Efeito de fade-out do efeito sonoro (recebe um parâmetro opcional para checar se o efeito foi concluído):
    func fadeOutSoundEffect(duration: TimeInterval, completion: (() -> Void)?) {
        guard let player = soundEffectPlayer else { return }
        player.setVolume(0, fadeDuration: duration)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { // Obriga a próxima ação esperar a conclusão do fade-out.
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
        backgroundMusicPlayer?.volume = 0.1
    }
    
    func unmuteSoundEffet() {
        soundEffectPlayer?.volume = 0.1
    }
    
    func stopSoundEffect() {
        soundEffectPlayer?.stop()
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
}

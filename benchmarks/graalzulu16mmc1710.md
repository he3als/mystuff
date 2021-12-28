# GraalVM vs Zulu Benchmark
Here I benchmarked the Zulu JRE provided by Lunar Client vs GraalVM (both Java 16). Java 16 was used for these benchmarks, because Lunar Client currently uses Java 16 for versions below 1.12.2. I do not know why, but that is how it is. Java 16 is no longer supported by GraalVM and it was labelled as experimental when it was last released. I stood completely still in the MMC spawn and did not even move my mouse.

![image](https://user-images.githubusercontent.com/65787561/147582844-5fb9af62-6919-4a12-90fa-ca43ef6b29c0.png)
![image](https://user-images.githubusercontent.com/65787561/147582942-c7409d49-c3a4-4642-81b2-c7e7d1b98e03.png)

## Averages
#### Zulu:
- 0.1% percentile FPS: 712.95
- 1% percentile FPS: 843.6
- Average FPS: 1491.8

Score (adding them all up): 3048.35

#### GraalVM:
- 0.1% percentile FPS: 723.266666667
- 1% percentile FPS: 830.016666667
- Average FPS: 1468.3

Score (adding them all up): 3021.58333333

## Startup Times
#### GraalVM:
1. 00:12.13
2. 00:12.39
3. 00:12.42
Mean: 12.3133333333 seconds
Version: graalvm-ce-java16-21.2.0 (provided by GitHub releases)

#### Zulu (Hotspot):
1. 00:12.96
2. 00:12.66
3. 00:12.40
Mean: 12.6733333333 seconds
Version: zulu16.30.15-ca-fx-jre16.0.1-win_x64 (provided by Lunar Client in the `%USERPROFILE%\.lunarclient\jre\1.7\` directory)

## Memory Usage
#### GraalVM:
![Taskmgr_hXiYpJ2mWG](https://user-images.githubusercontent.com/65787561/147586377-167efa88-ded6-42b8-882b-a4543b4b82df.png)
#### Zulu:
![Taskmgr_glbZS7wDub](https://user-images.githubusercontent.com/65787561/147586392-01f6c778-7526-470e-86b9-e1158158f2e4.png)

I am not sure why GraalVM takes up more memory... I used the same JVM flags. Just a guess, but I presume it could be the fact that I tested with an old and unsupported version of GraalVM (Java 16 experimental).
## Configuration
#### Specs:
- CPU: Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz
- GPU: GeForce GTX 970 (GM204 with 4GB memory )
- Memory: 2x Kingston KHX1600C10D3/8G  8192 MB @ 1600 MHz (DIMM DDR3) (16GB in total)
- Motherboard: MSI B85-G43 (MS-7816)

#### Peripherals:
- Mouse: Endgame Gear XM1 Wired Mouse (1000hz polling rate)
- Keyboard: Razer Hunstman TE
- Headset: SteelSeries Arctis 3
- Microphone: Blue Snowball

#### Windows:
- Services: https://paste.gg/p/anonymous/140872cbdec240dc872f473936757e0c/files/4d01eaa0e9cd4154a26bbf3f6c5e93b4/raw (exported with ServiWin)
- Drivers: https://paste.gg/p/anonymous/f09c588e724a4a08b89591a357175a16/files/59278cba2e2f48c9b453f0e13f93e2ef/raw (exported with ServiWin)
- Windows Version: Win 10 21H2 Pro
- Game Mode: Off
- CapFrameX used to benchmark without overlay

#### Lunar Configuration:
- Lunar Client version: 1.7.10-2026cf6/master
- LCLPy version: Latest, running from source with no GUI
- LCLPy config: https://paste.gg/p/anonymous/283064e00c0b48cb8764ae4df3cd6f9c/files/f490e08613b04e459c44dfd7d44e75bb/raw
- Java 16 was used for these benchmarks, because Lunar Client currently uses Java 16 for versions below 1.12.2. I do not know why, but that is how it is.

## How I Benchmarked
1. Launch Lunar Client with LCLPy (no GUI)
2. Multiplayer -> Minemen Club (EU Proxy)
3. Wait 20 seconds for everything to load and do not move the mouse or move at all
4. Capture with CapFrameX using keybind for 20 secs
5. Repeat 3 times, reboot then repeat 3 times. Then move onto the next JVM

## Conclusion
Technically, the Zulu JRE performed better in this instance. However, it is that close that it is most likely just normal flucuations. Both GraalVM and the Zulu JRE performed around the same. Keep in mind that support for Java 16 with GraalVM was labeled as experimental (when GraalVM CE 16 was last released) and now GraalVM CE 17 is not labeled as experimental. This most likely means that they have improved GraalVM since then.

## What next?
- 1.8.9 benchmarking
- Singleplayer
- Different servers/spawns
- Different JVM arguments
- I am not sure, I will think of more.

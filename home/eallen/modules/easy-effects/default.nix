{...}: {
  services.easyeffects = {
    enable = true;
    preset = "default";
    extraPresets = {
      default.input = {
        blocklist = [];
        plugins_order = [
          "rnnoise#0"
          "deesser#0"
          "bass_enhancer#0"
          "compressor#0"
          "filter#0"
        ];

        "rnnoise#0" = {
          "bypass" = false;
          "enable-vad" = true;
          "input-gain" = 0.0;
          "model-name" = "";
          "output-gain" = 0.0;
          "release" = 20.0;
          "vad-thres" = 50.0;
          "wet" = 0.0;
        };

        "deesser#0" = {
          "bypass" = false;
          "detection" = "RMS";
          "f1-freq" = 6000.0;
          "f1-level" = 0.0;
          "f2-freq" = 4500.0;
          "f2-level" = 12.0;
          "f2-q" = 1.0;
          "input-gain" = 0.0;
          "laxity" = 15;
          "makeup" = 0.0;
          "mode" = "Wide";
          "output-gain" = 0.0;
          "ratio" = 3.0;
          "sc-listen" = false;
          "threshold" = -18.0;
        };

        "bass_enhancer#0" = {
          "amount" = 8.2;
          "blend" = 0.0;
          "bypass" = false;
          "floor" = 20.0;
          "floor-active" = false;
          "harmonics" = 8.5;
          "input-gain" = 0.0;
          "output-gain" = 0.0;
          "scope" = 100.0;
        };

        "filter#0" = {
          "balance" = 0.0;
          "bypass" = false;
          "equal-mode" = "IIR";
          "frequency" = 100.0;
          "gain" = 0.0;
          "input-gain" = 0.0;
          "mode" = "RLC (BT)";
          "output-gain" = 0.0;
          "quality" = 0.0;
          "slope" = "x1";
          "type" = "High-pass";
          "width" = 4.0;
        };

        "compressor#0" = {
          "attack" = 20.0;
          "boost-amount" = 12.0;
          "boost-threshold" = -72.0;
          "bypass" = false;
          "dry" = -100.0;
          "hpf-frequency" = 10.0;
          "hpf-mode" = "off";
          "input-gain" = 0.0;
          "knee" = -6.0;
          "lpf-frequency" = 20000.0;
          "lpf-mode" = "off";
          "makeup" = 0.0;
          "mode" = "Boosting";
          "output-gain" = 0.0;
          "ratio" = 4.0;
          "release" = 100.0;
          "release-threshold" = -100.0;
          "sidechain" = {
            "lookahead" = 0.0;
            "mode" = "RMS";
            "preamp" = 0.0;
            "reactivity" = 10.0;
            "source" = "Middle";
            "stereo-split-source" = "Left/Right";
            "type" = "Feed-forward";
          };
          "stereo-split" = false;
          "threshold" = -12.0;
          "wet" = 0.0;
        };
      };
    };
  };
}

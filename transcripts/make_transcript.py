#!/usr/bin/env python3
"""Convert whisper VTT output to cleaned transcript format."""
import sys
import re

TITLES = {
    "01": "Recapitulation of Quantum Mechanics",
    "02": "Composite Systems and Dynamics",
    "03": "Stinespring Dilation and Fock Space",
    "04": "Second Quantisation and Gaussian States",
    "05": "Gaussian States and Covariance Matrices",
    "06": "Continuous Variables and Quantum Optics",
    "07": "Lindblad Equations I",
    "08": "Lindblad Equations II",
    "09": "Decoherence",
    "10": "Classical Noise and Stochastic Calculus",
    "11": "Quantum Stochastic Calculus I",
    "12": "Quantum Stochastic Calculus II",
    "13": "Feedback and Control",
}

URLS = {
    "01": "mKpURUtQgZ4", "02": "ToZuBpbHlcU", "03": "Vc7rx39ifvY",
    "04": "ZvOBigJWx8I", "05": "hZGbWfZ8B48", "06": "fuJt35tnyNc",
    "07": "LTj5UL89-ro", "08": "YpnVwa8rqHA", "09": "u7UrxIC_XW0",
    "10": "dkKgXSEQYXs", "11": "ZlCtw8-Vy5s", "12": "nkS35o9WiCI",
    "13": "MwkXEDx35wQ",
}

def process(lec_num):
    num = f"{lec_num:02d}"
    vtt_path = f"lec{num}_audio.vtt"
    out_path = f"lec{num}_transcript.txt"

    title = TITLES.get(num, f"Lecture {lec_num}")
    vid = URLS.get(num, "UNKNOWN")

    header = f"""# Theory of Quantum Noise and Decoherence, Lecture {lec_num}: {title}
# YouTube: https://www.youtube.com/watch?v={vid}
# Whisper transcription (base model, whisper-ctranslate2)
"""

    with open(vtt_path) as f:
        vtt = f.read()

    lines = []
    for block in vtt.strip().split("\n\n"):
        block_lines = block.strip().split("\n")
        if block_lines[0] == "WEBVTT":
            continue
        ts_line = None
        text_lines = []
        for line in block_lines:
            if "-->" in line:
                ts_line = line
            elif ts_line is not None:
                text_lines.append(line)
        if ts_line and text_lines:
            start = ts_line.split("-->")[0].strip()
            parts = start.split(":")
            if len(parts) == 3:
                h, m, s = parts
                total_min = int(h) * 60 + int(m)
                ts = f"[{total_min:02d}:{float(s):05.2f}]"
            else:
                m, s = parts
                ts = f"[{int(m):02d}:{float(s):05.2f}]"
            text = " ".join(text_lines)
            lines.append(f"{ts} {text}")

    with open(out_path, "w") as f:
        f.write(header + "\n")
        f.write("\n".join(lines) + "\n")

    print(f"lec{num}_transcript.txt: {len(lines)} lines")

if __name__ == "__main__":
    for arg in sys.argv[1:]:
        process(int(arg))

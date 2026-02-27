# Quantum Noise and Decoherence — Handoff

## Project overview

LaTeX lecture notes for Tobias Osborne's "Theory of Quantum Noise and Decoherence" course, following the same architecture as the completed `generalrelativity` (23 lectures) and `quantumcomputing` (3 lectures) projects.

## Current status

- **Lecture 1**: Complete (`latex/lectures/lec01.tex`, 496 lines — recapitulation of QM)
- **Lecture 2**: Audio downloaded (`transcripts/lec02_audio.mp3`, 47 MB), transcription not yet run
- **Style**: Updated to match `quantumcomputing` conventions (two-tier box design, hyperref, etc.)

## What was done this session

### 1. Style conformance update (completed)

Updated `qnd-style.sty` to match `qc-style.sty` from `../quantumcomputing`:

- Added `hyperref` package with colored links (cgblue/munsell)
- Added `matrix` TikZ library
- Added `patchplots,fillbetween` pgfplots libraries
- Replaced old box designs (attached-title style) with QC's two-tier system:
  - `greybox` — grey background, no border (base for grey-type boxes)
  - `highlightbox` — yellow background, blue border (base for highlight-type boxes)
  - `keyresult` → highlight style
  - `intuition` → grey style
  - `historical` → grey style
  - `algorithmbox` → grey style (new)
  - `\figbox` — figure placeholder (new)
- Build verified: `./build.sh --draft` succeeds, PDF renders correctly

### 2. Build script update (completed)

Rewrote `build.sh` to match `quantumcomputing/build.sh` structure:
- Case-based argument parsing (replaces function-based)
- Added `--watch` mode (continuous rebuild via `inotifywait`)
- Added `-h`/`--help` with usage header
- Cleaner variable naming

### 3. Lecture 2 video — partial

- **Found**: YouTube URL is `https://www.youtube.com/watch?v=ToZuBpbHlcU`
- **Playlist**: `https://www.youtube.com/watch?v=mKpURUtQgZ4&list=PLDfPUNusx1EotNvZr1mbu3-0QThQYilFD`
- **Channel**: `https://www.youtube.com/@tobiasjosborne`
- **Audio downloaded**: `transcripts/lec02_audio.mp3` (47 MB)
- **Transcription**: NOT YET DONE — `openai-whisper` installation via `uv tool install` was interrupted

## Next steps

1. **Install whisper and transcribe lecture 2**:
   ```bash
   uv tool install openai-whisper
   cd transcripts
   whisper lec02_audio.mp3 --model base --language en
   ```
   Then clean the transcript (same workflow as lec01).

2. **Read relevant pages from PDF notes** (`notes/Theory of quantum noise and decoherence.pdf`) for lecture 2 content. The PDF is too large to read in one go — read page ranges corresponding to lecture 2.

3. **Create `latex/lectures/lec02.tex`** using transcript + PDF notes, following lec01.tex conventions.

4. **Add `\input{lectures/lec02}` to `QuantumNoiseAndDecoherence.tex`**.

## Architecture reference

### File structure
```
latex/
  QuantumNoiseAndDecoherence.tex   # Master document
  qnd-style.sty                    # Formatting (matches qc-style.sty)
  qnd-macros.sty                   # Quantum noise macros
  references.bib                   # Bibliography
  lectures/lec01.tex               # Lecture 1
  figures/                         # (empty, for future TikZ)
transcripts/
  lec01_audio.mp3                  # Lec 1 audio (gitignored)
  lec01_audio.txt                  # Lec 1 raw whisper output
  lec01_transcript.txt             # Lec 1 cleaned transcript
  lec02_audio.mp3                  # Lec 2 audio (gitignored)
notes/
  Theory of quantum noise and decoherence.pdf  # Source PDF (gitignored)
```

### Shared conventions (across GR, QC, QND)
- Document class: `amsart` (12pt, oneside)
- Build engine: xelatex (3-pass + bibtex)
- Color palette: spacecadet, cgblue, munsell, banana, isabelline
- Font stack: Times LT Std + Whitney + mtpro2 (fallback: `--cmfonts`)
- Box design: two-tier (greybox/highlightbox) with semantic wrappers
- Tools installed: `yt-dlp` (via `uv tool install`)

### YouTube lecture playlist
Full playlist: `https://www.youtube.com/watch?v=mKpURUtQgZ4&list=PLDfPUNusx1EotNvZr1mbu3-0QThQYilFD`

| Lecture | YouTube URL |
|---------|-------------|
| 1 | `https://www.youtube.com/watch?v=mKpURUtQgZ4` |
| 2 | `https://www.youtube.com/watch?v=ToZuBpbHlcU` |

# Quantum Noise and Decoherence — Handoff

## Project overview

LaTeX lecture notes for Tobias Osborne's "Theory of Quantum Noise and Decoherence" course (13 lectures), following the same architecture as the completed `generalrelativity` (23 lectures) and `quantumcomputing` (3 lectures) projects.

## Current status

**All 13 lectures complete.** Full build: **45-page PDF**, zero errors.

- 4,004 lines of LaTeX across 13 lecture files
- 5,137 lines of timestamped transcripts
- 564 MB of audio (gitignored)

## Document structure

| Section | Lectures | Topics |
|---------|----------|--------|
| 1. Recapitulation of QM | 1--2 | Kinematics, observables, effects, states, density operators, composite systems, partial trace, Schmidt decomposition, entanglement vs correlations, dynamics, Heisenberg/Schrödinger pictures, unitary evolution, open systems, quantum channels, complete positivity |
| 2. CP maps and dilation theory | 3 | Constructive operations, Stinespring dilation theorem |
| 3. Quantum many-particle systems | 3--4 | Fock space, identical particles, symmetrisation, creation/annihilation operators, single-mode Fock space |
| 4. Continuous variables | 4--6 | Displacement operators, coherent states, characteristic functions, Gaussian states, covariance matrices, Wigner function, quadrature operators, symplectic transformations, Williamson's theorem, thermal states |
| 5. Lindblad equations | 7--10 | Born-Markov derivation, radiative damping, cavity emission, quantum-dot master equation, fermion systems |
| 6--7. Stochastic calculus | 10--12 | Repeated measurements, von Neumann model, quantum trajectories, stochastic Schrödinger equation, input-output formalism |
| 8. Feedback and control | 13 | Classical/quantum feedback, controllability, linear quantum control |

## Architecture reference

### File structure
```
latex/
  QuantumNoiseAndDecoherence.tex   # Master document (inputs lec01--lec13)
  qnd-style.sty                    # Formatting (matches qc-style.sty)
  qnd-macros.sty                   # Quantum noise macros
  references.bib                   # Bibliography
  lectures/lec01.tex -- lec13.tex  # All 13 lectures
  figures/                         # (empty, for future TikZ)
transcripts/
  lec0N_audio.mp3                  # Audio files (gitignored)
  lec0N_audio.{txt,json,srt,vtt}  # Raw whisper outputs
  lec0N_transcript.txt             # Cleaned transcripts with timestamps
  make_transcript.py               # Helper script: VTT → cleaned transcript
notes/
  Theory of quantum noise and decoherence.pdf  # Source PDF (gitignored)
```

### Tools used
- `yt-dlp` — YouTube audio download (via `uv tool install`)
- `whisper-ctranslate2` — speech-to-text, base model, CPU (via `uv tool install`)
- `ffmpeg` — audio conversion (static binary via `imageio-ffmpeg`, symlinked to `~/.local/bin/ffmpeg`)
- `xelatex` + `bibtex` — LaTeX compilation (3-pass)

### Shared conventions (across GR, QC, QND)
- Document class: `amsart` (12pt, oneside)
- Build engine: xelatex (3-pass + bibtex)
- Color palette: spacecadet, cgblue, munsell, banana, isabelline
- Font stack: Times LT Std + Whitney + mtpro2 (fallback: `--cmfonts`)
- Box design: two-tier (greybox/highlightbox) with semantic wrappers

### YouTube lecture playlist
Full playlist: `https://www.youtube.com/watch?v=mKpURUtQgZ4&list=PLDfPUNusx1EotNvZr1mbu3-0QThQYilFD`

| Lec | YouTube ID | Status |
|-----|-----------|--------|
| 1 | mKpURUtQgZ4 | Complete |
| 2 | ToZuBpbHlcU | Complete |
| 3 | Vc7rx39ifvY | Complete |
| 4 | ZvOBigJWx8I | Complete |
| 5 | hZGbWfZ8B48 | Complete |
| 6 | fuJt35tnyNc | Complete |
| 7 | LTj5UL89-ro | Complete |
| 8 | YpnVwa8rqHA | Complete |
| 9 | u7UrxIC_XW0 | Complete |
| 10 | dkKgXSEQYXs | Complete |
| 11 | ZlCtw8-Vy5s | Complete |
| 12 | nkS35o9WiCI | Complete |
| 13 | MwkXEDx35wQ | Complete |

## Potential future work

1. **Cross-check with PDF notes** (`notes/Theory of quantum noise and decoherence.pdf`) — not available on this machine. Could enrich mathematical detail.
2. **TikZ figures** — several lectures would benefit from diagrams (Bloch sphere decoherence, cavity input-output, feedback loops).
3. **Bibliography** — add missing references cited in the text (CavesMilburn87, etc.).
4. **Consistency pass** — ensure section numbering flows correctly across all 13 files; unify notation for Lindblad operators, jump operators, etc.

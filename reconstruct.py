from pathlib import Path

PARTS = sorted(Path("parts").glob("Delta-2.738.1397.zip.part*"))
OUT = Path("Delta-2.738.1397.zip")

if not PARTS:
    raise SystemExit("No split parts found in ./parts")

with OUT.open("wb") as dst:
    for part in PARTS:
        with part.open("rb") as src:
            while chunk := src.read(1024 * 1024):
                dst.write(chunk)

print(f"Reconstructed {OUT} from {len(PARTS)} parts.")

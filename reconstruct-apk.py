from pathlib import Path
import hashlib

parts = sorted(Path("parts").glob("Delta-2.738.1397.apk.part*"))
out = Path("Delta-2.738.1397.apk")

if not parts:
    raise SystemExit("No APK parts found in ./parts")

with out.open("wb") as dst:
    for part in parts:
        with part.open("rb") as src:
            while chunk := src.read(1024 * 1024):
                dst.write(chunk)

digest = hashlib.sha256(out.read_bytes()).hexdigest()
print(f"Reconstructed {out} from {len(parts)} parts")
print(f"SHA-256: {digest}")

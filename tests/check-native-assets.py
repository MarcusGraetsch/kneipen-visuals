from pathlib import Path
import struct
root = Path(__file__).resolve().parents[1]
png = (root / "textures/pirata_logo.png").read_bytes()
assert png[:8] == b"\x89PNG\r\n\x1a\n"
assert png[12:16] == b"IHDR"
w, h = struct.unpack(">II", png[16:24])
assert w > 0 and h > 0
for name in ("Pirata_Laser", "Pirata_3D_Electric", "Pirata_Crimson_Eye", "Pirata_Acid_Storm"):
    preset = (root / "presets" / (name + ".milk")).read_text()
    assert "sampler_fc_pirata_logo" in preset
    assert "shader_body" in preset
    assert preset.count("{") == preset.count("}")
for script in ("setup.sh", "setup-windows.ps1"):
    assert "pirata_logo.png" in (root / script).read_text()
print(f"PNG {w}x{h}, native preset and installer paths OK")

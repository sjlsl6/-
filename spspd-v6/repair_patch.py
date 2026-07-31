from pathlib import Path
import base64
import hashlib

ROOT = Path(__file__).resolve().parent / "patch-b64"
FIXES = {
    "part-01": [[268, 269, "ag=="]],
    "part-04": [
        [3305, 3306, "dw=="],
        [3637, 3638, "dw=="],
        [5781, 5781, "d29ySUNBZ0lDQWdJQ0JEYjI1bWFXZDFjbVZYYVc1a2IzY29SR1YyUTJGMFpXZHZjbmtnWTJGMFpXZHZjbmtzSUVOc1lYTnpQRDhnWlhoMFpXNWtj"],
        [5782, 5782, "QkpkR1Z0UGlCcGRHVnRRMnhoYzNNc0lHWnNiMkYwSUhKbGRIVnlibE5qY205c2JDa2dld29ySUM="],
        [5792, 5804, "SUNBZ2Mz"],
        [5805, 5850, ""],
        [5851, 5896, ""],
        [5898, 5903, "SW9L"],
        [5904, 5914, ""],
        [5934, 5964, "Um8="],
        [5965, 5984, "WE11"],
        [5995, 5996, "Z1BTQmpZWFJsWjI5eWVUc0s="],
    ],
    "part-05": [[2833, 2834, "dw=="]],
}
EXPECTED = {
    "part-01": "7adfc43f51b63a3668162932a88e07fad03ba062e148cbbe7198708f276ed979",
    "part-04": "107489fcb7787b159c0d36490f7d2a3d90c39e210540c42cbcb0e81716ce18dd",
    "part-05": "b660662f050a822bdb2146d2f006fdc9897c9be03ec935f7540d0916bb86c2a5",
}

for name, operations in FIXES.items():
    path = ROOT / name
    source = path.read_bytes()
    output = bytearray()
    cursor = 0
    for start, end, replacement in operations:
        output.extend(source[cursor:start])
        output.extend(base64.b64decode(replacement))
        cursor = end
    output.extend(source[cursor:])
    digest = hashlib.sha256(output).hexdigest()
    if digest != EXPECTED[name]:
        raise SystemExit(f"{name} repair checksum mismatch: {digest}")
    path.write_bytes(output)

assembled = b"".join(path.read_bytes() for path in sorted(ROOT.glob("part-*")))
patch = base64.b64decode(assembled)
patch_digest = hashlib.sha256(patch).hexdigest()
expected_patch = "2de8128b312e0e2ceae1cede650774c9c63eaf6f7f607f4b3e681df187860195"
if patch_digest != expected_patch:
    raise SystemExit(f"assembled patch checksum mismatch: {patch_digest}")
Path("v6.patch").write_bytes(patch)
print(f"V6 patch verified: {patch_digest}")

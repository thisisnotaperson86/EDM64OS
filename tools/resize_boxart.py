#!/usr/bin/env python3
"""Convert a folder of images to the exact PNG size required by NRMenu."""
from __future__ import annotations
import argparse
from pathlib import Path
from PIL import Image, ImageOps

SUPPORTED = {'.png','.jpg','.jpeg','.bmp','.webp','.tif','.tiff'}

def parse_size(value: str) -> tuple[int,int]:
    try:
        w,h=value.lower().split('x',1)
        w,h=int(w),int(h)
        if w <= 0 or h <= 0: raise ValueError
        return w,h
    except ValueError as exc:
        raise argparse.ArgumentTypeError('Usar ANCHOxALTO, por ejemplo 92x65') from exc

def main() -> int:
    ap=argparse.ArgumentParser()
    ap.add_argument('input', type=Path)
    ap.add_argument('output', type=Path)
    ap.add_argument('--size', type=parse_size, default=(92,65))
    ap.add_argument('--mode', choices=('stretch','fit','crop'), default='stretch')
    args=ap.parse_args()
    if not args.input.is_dir():
        ap.error(f'No existe la carpeta: {args.input}')
    args.output.mkdir(parents=True,exist_ok=True)
    ok=bad=0
    for src in sorted(args.input.iterdir()):
        if not src.is_file() or src.suffix.lower() not in SUPPORTED: continue
        try:
            with Image.open(src) as im:
                im=im.convert('RGBA')
                if args.mode=='stretch': out=im.resize(args.size,Image.Resampling.LANCZOS)
                elif args.mode=='fit': out=ImageOps.pad(im,args.size,method=Image.Resampling.LANCZOS,color=(0,0,0,0))
                else: out=ImageOps.fit(im,args.size,method=Image.Resampling.LANCZOS)
                out.save(args.output/(src.stem.upper()+'.png'),'PNG',optimize=True)
            ok += 1
        except Exception as exc:
            bad += 1
            print(f'ERROR {src.name}: {exc}')
    print(f'Convertidas: {ok}; errores: {bad}; salida: {args.output}')
    return 1 if bad else 0

if __name__=='__main__':
    raise SystemExit(main())

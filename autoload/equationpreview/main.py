import os
import tempfile
import subprocess
import platform
from pathlib import Path
from typing import Optional, List

eqpreview_tmpdir: Optional[tempfile.TemporaryDirectory] = None


def eqpreview_close() -> None:
    global eqpreview_tmpdir
    if eqpreview_tmpdir is not None:
        eqpreview_tmpdir.cleanup()
        eqpreview_tmpdir = None


def eqpreview_main(eq_str: str, texcmd: str, fontsize: int,
                   packages: List[str], opts: List[str]) -> None:
    global eqpreview_tmpdir
    shell = False
    if platform.system() == 'Windows':
        cmd = 'start'
        shell = True
    elif platform.uname()[0] == 'Darwin':
        cmd = 'open'
    elif platform.uname()[0] == 'Linux':
        cmd = 'xdg-open'
    else:
        print('Unsupported platform')
        return
    if eqpreview_tmpdir is None:
        eqpreview_tmpdir = tempfile.TemporaryDirectory()
    index = 0
    os.chdir(eqpreview_tmpdir.name)
    while True:
        tmp_file = Path(f'eqpreview{index}.tex')
        if not tmp_file.is_file():
            break
        index += 1
    with open(tmp_file, 'w') as tmp:
        for p in packages:
            tmp.write(p+'\n')
        tmp.write(r'\begin{document}''\n')
        tmp.write(r'\fontsize'
                  f'{{{fontsize}pt}}{{{fontsize}pt}}'
                  r'\selectfont''\n')
        tmp.write(r'  \begin{equation*}''\n')
        tmp.write(r'    \begin{split}''\n')
        tmp.write(eq_str)
        tmp.write('\n'r'    \end{split}''\n')
        tmp.write(r'  \end{equation*}''\n')
        tmp.write(r'\end{document}''\n')

    target = f'eqpreview{index}'
    out = subprocess.run([texcmd, target] + opts, capture_output=True)
    out_file = target+'.pdf'
    if os.path.isfile(out_file):
        out = subprocess.run([cmd, out_file], shell=shell,
                             capture_output=True)
    else:
        print('failed to create pdf file')

Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3D39FCBF
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141032; cv=pass; b=rb8DmiHUykzCiee1uxu7enXRdTzB4teRTj+P6pGRObYP6f+uAtft4BaR6w899UQhLyaBQX08DOLbKGpVfCSneCxfAiq+zg9ePh/sBV0muI0f+chKWljnocRdsdkFeMvkeEkfgQfYAgjlhypeTK7VyBUra9aQpr91zTJszotU7Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141032; c=relaxed/simple;
	bh=z2XmUurrdaFn9IJL5P6rDgEK1R9WYZnkPljTKi9bUJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiQ+3gg03LR97zVkcmFxfIg0WIsqo7Q9YrYkSf5uE4pcAkUcrXtXtIVqQTtd79cyq9oqMtqwgJAn6oDWjf9TFBt/7VRcQp6zvNjEhfNK+TB8Ej2mfZQhLUh/PZ9rJD5lpwEf34WcnhUytC5PnugBCsomQPCwD8hK79Cb2rqU4oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b9k0ipyq; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9k0ipyq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53113d72966so108301cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 22:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790141029; cv=none;
        d=google.com; s=arc-20260327;
        b=Cr4Tjb10Lx82TWrfePE+hbUTm6+qAnP8wXmaicsWgH4wYYt8a0ZHB73rMtzlYy9qBm
         LhZksrxKh0FV+9L2w5+Zti5zExWXip1rVUMrm4zFQGWj5Jcl2lILPIuVs93kJnGPXzxc
         JYgackgtTJUJoFKpV1ICZbXUHEbP/wp+IkSLXaVENnE6wgix/4hbR4cfsEmWnzokkGWE
         270teLbdadrMqAtaF/9MtMfotBipVmDqIOa/cXVV12TO9E6V6+9t/uitw1vfMC5DOwvS
         soNS0v0cuO/aFjx4lI/Q/1NROPXR25FIwuX+SjysYD3abRSfrKPgkVchHQSj6dCyfUD4
         Ylbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DJ8tFHSPqqN6XSKLF22vu/A2mJhFTCet2bEk0JY5vC8=;
        fh=pQxpBkfxj4Z33QgatTvIZE5cEFAPLKdM7dY7cvfjSUA=;
        b=cxfWyuEX38NLpLkJLKGA0dE1qh9Nl/3W15ElNNF5Kghck4hNSdMACwkDESlimw435I
         XANnppHO880ioamhkmk5RrT4ec3FDITYWzWm7gy9Beqic7O5tCFOjC6ji7ffffY+bAZu
         CpxNr7fo+Om7sKya9v4Pjd2pOro3uPP8VJIfpm3uc64OKt7gKnnq1Oux14WsK7xN+ZQW
         2/HCfsb/CbuYPur6gAgI0YF4q2VYMoMwvhcttGCXPN6fjqa9/dJQGMGxHlFNimps2j1i
         SMQz2tW1eJt4h+OujYTl0FM8mK5m9puHDqPoGh8JLWFVHYZWr1axNDVfFP2E9nL8rlpY
         jJFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790141029; x=1790745829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DJ8tFHSPqqN6XSKLF22vu/A2mJhFTCet2bEk0JY5vC8=;
        b=b9k0ipyqFz06VuClUbRuo2f0zKamjD1q+v+tJHXrGxtt4iXEJsTFLzHsumvFOohPHJ
         KDNHgPG4KEx9adk8fZy2Rw955/ESt2mW/LM09f7/UqB+So5A8E+ZxV5xn2idDpyuf4KS
         5tVcDioPHJhOUlnWYs6lLaEIoQIlWduQq8njdMuQrcuiadv4BNDUAAJlOG6y80jPV5vB
         t73Dar2hHJg2F3Oqz3dTClQ22gooTdC7DYJYoLV0/KlccFwkM9daMuBc1g8cwAWUmcQQ
         2JwhsBcyisDU8bBwxv/Fw++E8DyM0cs+pcyUTfneJzuCz3a4V+m6MPzavoEQ+h5KpijE
         duPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790141029; x=1790745829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJ8tFHSPqqN6XSKLF22vu/A2mJhFTCet2bEk0JY5vC8=;
        b=SpXwcteHM3WxtLD7EsaycIa/yWvshrkAU7ZCzdFpUkNANLhYKEeXsU5LtnJs7TdgR3
         yev7xbsKSJ4gZ5PvR6Ngrj0/QzSfLGPNV31aDr0LoyttIsO3KL8SLCpQ4z8RFUpI0Tqy
         vUdUKUUNu3t9On6SangpmN3yoGK5Jt4a2Cfw2IYKa44Up+GSb29azXUOKJYg0OD4EMn5
         hFmEJpxwlnWLeoPfLBPuEiQpbJunOZ4z5oi+48hJgmKzo7ccYA1ZxZaV6imIuLv689Q2
         qYxVxvzJ1Z32xr4UESUjTIqsdD0b8GrUu6u8LVEn/QtdY1HpJxIsupIndlI/SYaB1wbh
         96ww==
X-Forwarded-Encrypted: i=1; AKwUvBxdrwAQJu6C7eamw8L5DUh8HJjKT5n2L+PmrqzpNgvelvuEVGXGhfRJ/wVCCbdK3ARRCtFu+pVbaBtubjU5jzRf@vger.kernel.org
X-Gm-Message-State: AFuF++k6xDibIFnpJ6r8uyEz6A/hO2oFsh8jcxAZSsAQrmA2s3IGS/82
	8qKwXn/3VXCbq+Ze6JuQMnu4I8jMMg0G1LroP18P/g7RcMRsQVBlL6WODOYyDxBzIb4fIy18U6D
	glbSkWlb92aErp6FDgDKW+ai87k7zBgfnnoXfFfiW
X-Gm-Gg: AYBFou1dwFsmLn1QqUEIv/VwierCi6TqYwUKeDIHs7X803JfpBN5Ci1ATwPEJZqn2b7
	xWWN7xln+WsoCf6aIVk9s3KwlJHS/g7vaGVXN2GHw2hi9auY/Fp+ajw3Ek+RXgjCE/m5qERRCEP
	+4qgZ0BPyso08q5du9aqdGXqwnzjJqGIhYT4YMTRCh372XARsyyjaEB5g85sF9xYtU0DweP2Ec0
	zpIFaQkMfzbTJmxHYpQ/0cMs4Z8BcWNUmIdNKp1tl2g4Asa1pjf9kDwLVC1rsHMkLHJbSdXSjxF
	Sn4K9y19VcDuacKqIu/9AoA97ZhWxjjEMSN2irI3JOKEUQr3EtDVq8VAnf2a1dG/yg==
X-Received: by 2002:a05:622a:4d4:b0:532:8a04:af52 with SMTP id
 d75a77b69052e-532edf4fe9emr6554391cf.9.1790141028672; Tue, 22 Sep 2026
 22:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>
 <967f2941-2f7c-464e-8a8e-eb0a78f586d6@linaro.org>
In-Reply-To: <967f2941-2f7c-464e-8a8e-eb0a78f586d6@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Sep 2026 22:23:36 -0700
X-Gm-Features: AcwNN1XSTB27P0c1GTbe9FvUK3O9Ii5iu8NEPwyQXcEdjeGxjaYPFbwOB0_uK_I
Message-ID: <CAP-5=fXz5S-Va1BdvQjvDqcKovToyoODC-T1gVV46pLPEbiVvQ@mail.gmail.com>
Subject: Re: [PATCH v2 38/49] perf python: Port arm-cs-trace-disasm to perf module
To: James Clark <james.clark@linaro.org>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 6:12=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 21/09/2026 06:06, Ian Rogers wrote:
> > Port arm-cs-trace-disasm.py to a standalone script in tools/perf/python=
/
> > using the perf module directly.
> >
> > Improvements compared to the legacy script:
> > - Encapsulate trace disassembly state in a TraceDisasm class
> > - Automatically search standard kernel debug paths (find_vmlinux())
> >    when -k/--vmlinux is not specified, and query
> >    perf.config_get("annotate.objdump") for the default objdump binary.
> > - Bound DISASM_CACHE memory consumption by evicting the cache at 1024
> >    entries and skipping caching of oversized (> 512 lines) objdump
> >    outputs.
> > - Use sample.srccode() from the perf extension module to annotate
> >    disassembly output with source filenames, line numbers, and source
> >    lines.
> >
> > Update the ARM CoreSight disassembly shell test
> > (test_arm_coresight_disasm.sh) to invoke the standalone script.
> >
> > Assisted-by: Antigravity:gemini-3.1-pro
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/python/arm-cs-trace-disasm.py      | 356 +++++++++++++++++=
+
> >   .../coresight/test_arm_coresight_disasm.sh    |  24 +-
> >   tools/perf/tests/shell/lib/setup_python.sh    |   4 +
> >   3 files changed, 378 insertions(+), 6 deletions(-)
> >   create mode 100755 tools/perf/python/arm-cs-trace-disasm.py
> >
> > diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/pyth=
on/arm-cs-trace-disasm.py
> > new file mode 100755
> > index 000000000000..1a9d9a01d1e4
> > --- /dev/null
> > +++ b/tools/perf/python/arm-cs-trace-disasm.py
> > @@ -0,0 +1,356 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +"""
> > +arm-cs-trace-disasm.py: ARM CoreSight Trace Dump With Disassember usin=
g perf python module
> > +"""
> > +from __future__ import annotations
> > +
> > +import os
> > +from os import path
> > +import re
> > +from subprocess import CalledProcessError, check_output
> > +import argparse
> > +import platform
> > +import sys
> > +from typing import Dict, List, Optional
> > +
> > +import perf
> > +
> > +# Initialize global dicts and regular expression
> > +DISASM_CACHE: Dict[str, List[str]] =3D {}
> > +CPU_DATA: Dict[str, int] =3D {}
> > +DISASM_RE =3D re.compile(r"^\s*([0-9a-fA-F]+):")
> > +DISASM_FUNC_RE =3D re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
> > +CACHE_SIZE =3D 1024
> > +class _State:
> > +    sample_idx: int =3D -1
> > +    source_file_name: Optional[str] =3D None
> > +    line_number: Optional[int] =3D None
> > +    dso: Optional[str] =3D None
> > +
> > +_STATE =3D _State()
> > +
> > +KVER =3D platform.release()
> > +VMLINUX_PATHS =3D [
> > +    f"/usr/lib/debug/boot/vmlinux-{KVER}.debug",
> > +    f"/usr/lib/debug/lib/modules/{KVER}/vmlinux",
> > +    f"/lib/modules/{KVER}/build/vmlinux",
> > +    f"/usr/lib/debug/boot/vmlinux-{KVER}",
> > +    f"/boot/vmlinux-{KVER}",
> > +    "/boot/vmlinux",
> > +    "vmlinux"
> > +]
> > +
> > +def default_objdump() -> str:
> > +    """Return the default objdump path from perf config or 'objdump'."=
""
> > +    try:
> > +        config =3D perf.config_get("annotate.objdump")
> > +        return str(config) if config else "objdump"
> > +    except (AttributeError, TypeError):
> > +        return "objdump"
> > +
> > +def find_vmlinux() -> Optional[str]:
> > +    """Find the vmlinux file in standard paths."""
> > +    if hasattr(find_vmlinux, "path"):
> > +        return getattr(find_vmlinux, "path")
> > +
> > +    for v in VMLINUX_PATHS:
> > +        if os.access(v, os.R_OK):
> > +            setattr(find_vmlinux, "path", v)
> > +            return v
> > +    setattr(find_vmlinux, "path", None)
> > +    return None
> > +
> > +def get_dso_file_path(dso_name: str, dso_build_id: str, vmlinux: Optio=
nal[str]) -> str:
> > +    """Return the path to the DSO file."""
> > +    buildid_dir =3D os.environ.get('PERF_BUILDID_DIR')
> > +    if not buildid_dir:
> > +        buildid_dir =3D os.path.join(os.environ.get('HOME', ''), '.deb=
ug')
> > +
> > +    if dso_name in ("[kernel.kallsyms]", "vmlinux"):
> > +        if vmlinux:
> > +            return vmlinux
> > +        if dso_build_id:
> > +            for kname in (dso_name, "vmlinux", "[kernel.kallsyms]"):
> > +                candidate =3D os.path.join(buildid_dir, kname, dso_bui=
ld_id, "elf")
> > +                if os.access(candidate, os.R_OK):
> > +                    return candidate
> > +        return find_vmlinux() or dso_name
> > +
> > +    if dso_name =3D=3D "[vdso]":
> > +        append =3D "/vdso"
> > +    else:
> > +        append =3D "/elf"
> > +
> > +    dso_path =3D buildid_dir + "/" + dso_name + "/" + dso_build_id + a=
ppend
> > +    # Replace duplicate slash chars to single slash char
> > +    dso_path =3D dso_path.replace('//', '/', 1)
> > +    return dso_path
> > +
> > +def read_disam(dso_fname: str, dso_start: int, start_addr: int,
> > +               stop_addr: int, objdump: str) -> List[str]:
> > +    """Read disassembly from a DSO file using objdump."""
> > +    addr_range =3D f"{start_addr}:{stop_addr}:{dso_start}:{dso_fname}"
> > +
> > +    # Don't let the cache get too big, clear it when it hits max size
> > +    if len(DISASM_CACHE) > CACHE_SIZE:
> > +        DISASM_CACHE.clear()
> > +
> > +    if addr_range in DISASM_CACHE:
> > +        disasm_output =3D DISASM_CACHE[addr_range]
> > +    else:
> > +        start_addr =3D start_addr - dso_start
> > +        stop_addr =3D stop_addr - dso_start
> > +        disasm =3D [objdump, "-d", "-z",
> > +                  f"--start-address=3D{start_addr:#x}",
> > +                  f"--stop-address=3D{stop_addr:#x}"]
> > +        disasm +=3D [dso_fname]
> > +        try:
> > +            disasm_output =3D check_output(disasm).decode('utf-8', err=
ors=3D'replace').split('\n')
> > +        except (CalledProcessError, OSError):
> > +            return []
> > +        if len(disasm_output) <=3D 512:
> > +            DISASM_CACHE[addr_range] =3D disasm_output
> > +
> > +    return disasm_output
> > +
> > +def print_disam(dso_fname: str, dso_start: int, start_addr: int,
> > +                stop_addr: int, objdump: str) -> None:
> > +    """Print disassembly for a given address range."""
> > +    for line in read_disam(dso_fname, dso_start, start_addr, stop_addr=
, objdump):
> > +        m =3D DISASM_FUNC_RE.search(line)
> > +        if m is None:
> > +            m =3D DISASM_RE.search(line)
> > +            if m is None:
> > +                continue
> > +        print(f"\t{line}")
> > +
> > +def print_sample(sample: perf.sample_event) -> None:
> > +    """Print sample details."""
> > +    print(f"Sample =3D {{ cpu: {sample.sample_cpu:04d} addr: {sample.s=
ample_addr:016x} "
> > +          f"phys_addr: {sample.sample_phys_addr:016x} ip: {sample.samp=
le_ip:016x} "
> > +          f"pid: {sample.sample_pid} tid: {sample.sample_tid} period: =
{sample.sample_period} "
> > +          f"time: {sample.sample_time} index: {_STATE.sample_idx}}}")
> > +
> > +def common_start_str(comm: str, sample: perf.sample_event) -> str:
> > +    """Return common start string for sample output."""
> > +    sec =3D int(sample.sample_time / 1000000000)
> > +    ns =3D sample.sample_time % 1000000000
> > +    cpu =3D sample.sample_cpu
> > +    pid =3D sample.sample_pid
> > +    tid =3D sample.sample_tid
> > +    return f"{comm:>16s} {pid:5d}/{tid:<5d} [{cpu:04d}] {sec:9d}.{ns:0=
9d}  "
> > +
> > +def print_srccode(comm: str, sample: perf.sample_event, symbol: str, d=
so: str) -> None:
> > +    """Print source code and symbols for a sample."""
> > +    ip =3D sample.sample_ip
> > +    if symbol =3D=3D "[unknown]":
> > +        start_str =3D common_start_str(comm, sample) + f"{ip:x}".rjust=
(16).ljust(40)
> > +    else:
> > +        symoff =3D 0
> > +        symoff =3D getattr(sample, 'sym_offset', 0) or 0
> > +        offs =3D f"+{symoff:#x}" if symoff !=3D 0 else ""
> > +        start_str =3D common_start_str(comm, sample) + (symbol + offs)=
.ljust(40)
> > +
> > +    source_file_name, line_number, source_line =3D sample.srccode() or=
 (None, 0, None)
> > +    if source_file_name:
> > +        if _STATE.line_number =3D=3D line_number and _STATE.source_fil=
e_name =3D=3D source_file_name:
> > +            src_str =3D ""
> > +        else:
> > +            if len(source_file_name) > 40:
> > +                src_file =3D f"...{source_file_name[-37:]} "
> > +            else:
> > +                src_file =3D source_file_name.ljust(41)
> > +
> > +            if source_line is None:
> > +                src_str =3D f"{src_file}{line_number:>4d} <source not =
found>"
> > +            else:
> > +                src_str =3D f"{src_file}{line_number:>4d} {source_line=
}"
> > +        _STATE.dso =3D None
> > +    elif dso =3D=3D _STATE.dso:
> > +        src_str =3D ""
> > +    else:
> > +        src_str =3D dso
> > +        _STATE.dso =3D dso
> > +
> > +    _STATE.line_number =3D line_number
> > +    _STATE.source_file_name =3D source_file_name
> > +
> > +    print(start_str, src_str)
> > +
> > +class TraceDisasm:
> > +    """Class to handle trace disassembly."""
> > +    def __init__(self, cli_options: argparse.Namespace):
> > +        self.options =3D cli_options
> > +        self.sample_idx =3D -1
> > +        self.session: Optional[perf.session] =3D None
> > +
> > +    def process_event(self, sample: perf.sample_event) -> None:
> > +        """Process a single perf event."""
> > +        self.sample_idx +=3D 1
> > +        _STATE.sample_idx =3D self.sample_idx
> > +
> > +        if self.options.start_time is not None and sample.sample_time =
< self.options.start_time:
> > +            return
> > +        if self.options.stop_time is not None and sample.sample_time >=
 self.options.stop_time:
> > +            sys.exit(0)
> > +        if self.options.start_sample is not None and self.sample_idx <=
 self.options.start_sample:
> > +            return
> > +        if self.options.stop_sample is not None and self.sample_idx > =
self.options.stop_sample:
> > +            sys.exit(0)
> > +
> > +        ev_name =3D str(sample.evsel)
> > +        if self.options.verbose:
> > +            print(f"Event type: {ev_name}")
> > +            print_sample(sample)
> > +
> > +        dso =3D sample.dso or '[unknown]'
> > +        symbol =3D sample.symbol or '[unknown]'
> > +        dso_bid =3D (sample.dso_bid.decode('utf-8')
> > +                   if isinstance(sample.dso_bid, bytes)
> > +                   else str(sample.dso_bid or '[unknown]'))
> > +        dso_start =3D sample.map_start
> > +        dso_end =3D sample.map_end
> > +        map_pgoff =3D sample.map_pgoff or 0
> > +
> > +        comm =3D "[unknown]"
> > +        try:
> > +            if self.session:
> > +                thread_info =3D self.session.find_thread(sample.sample=
_tid)
> > +                if thread_info:
> > +                    comm =3D thread_info.comm() or "[unknown]"
> > +        except (TypeError, AttributeError):
> > +            pass
> > +
> > +        if dso =3D=3D '[unknown]':
> > +            return
> > +
> > +        if dso_start is None or dso_end is None:
> > +            print(f"Failed to find valid dso map for dso {dso}")
> > +            return
> > +
> > +        if "instructions" in ev_name:
> > +            print_srccode(comm, sample, symbol, dso)
> > +            return
> > +
> > +        if "branches" not in ev_name:
> > +            return
> > +
> > +        self._process_branch(sample, comm, symbol, dso, dso_bid, dso_s=
tart, dso_end, map_pgoff)
> > +
> > +    def _process_branch(self, sample: perf.sample_event, comm: str, sy=
mbol: str, dso: str,
> > +                        dso_bid: str, dso_start: int, dso_end: int, ma=
p_pgoff: int) -> None:
> > +        """Helper to process branch events."""
> > +        cpu =3D sample.sample_cpu
> > +        ip =3D sample.sample_ip
> > +        addr =3D sample.sample_addr
> > +
> > +        if CPU_DATA.get(str(cpu) + 'addr') is None:
> > +            CPU_DATA[str(cpu) + 'addr'] =3D addr
> > +            return
> > +
> > +        start_addr =3D CPU_DATA[str(cpu) + 'addr']
> > +        stop_addr  =3D ip + 4
> > +
> > +        # Record for previous sample packet
> > +        CPU_DATA[str(cpu) + 'addr'] =3D addr
> > +
> > +        # Filter out zero start_address. Optionally identify CS_ETM_TR=
ACE_ON packet
> > +        if start_addr =3D=3D 0:
> > +            if stop_addr =3D=3D 4 and self.options.verbose:
> > +                print(f"CPU{cpu}: CS_ETM_TRACE_ON packet is inserted")
> > +            return
> > +
> > +        if start_addr < dso_start or start_addr > dso_end:
> > +            print(f"Start address {start_addr:#x} is out of range [ {d=
so_start:#x} .. "
> > +                  f"{dso_end:#x} ] for dso {dso}")
> > +            return
> > +
> > +        if stop_addr < dso_start or stop_addr > dso_end:
> > +            print(f"Stop address {stop_addr:#x} is out of range [ {dso=
_start:#x} .. "
> > +                  f"{dso_end:#x} ] for dso {dso}")
> > +            return
> > +
> > +        if self.options.objdump is not None:
> > +            if dso =3D=3D "[kernel.kallsyms]":
> > +                dso_vm_start =3D 0
> > +                map_pgoff_local =3D 0
> > +            elif dso_start =3D=3D 0x400000:
> > +                dso_vm_start =3D 0
> > +                map_pgoff_local =3D 0
> > +            else:
> > +                dso_vm_start =3D dso_start
> > +                map_pgoff_local =3D map_pgoff
> > +
> > +            dso_fname =3D get_dso_file_path(dso, dso_bid, self.options=
.vmlinux)
> > +            if path.exists(dso_fname):
> > +                print_disam(dso_fname, dso_vm_start, start_addr + map_=
pgoff_local,
> > +                            stop_addr + map_pgoff_local, self.options.=
objdump)
> > +            else:
> > +                print(f"Failed to find dso {dso} for address range [ "
> > +                      f"{start_addr + map_pgoff_local:#x} .. {stop_add=
r + map_pgoff_local:#x} ]")
> > +
> > +        print_srccode(comm, sample, symbol, dso)
> > +
> > +    def run(self) -> None:
> > +        """Run the trace disassembly session."""
> > +        input_file =3D self.options.input or "perf.data"
> > +        if input_file !=3D "-" and not os.path.exists(input_file):
> > +            print(f"Error: {input_file} not found.", file=3Dsys.stderr=
)
> > +            sys.exit(1)
> > +
> > +        print('ARM CoreSight Trace Data Assembler Dump')
> > +        try:
> > +            self.session =3D perf.session(
> > +                perf.data(input_file),
> > +                sample=3Dself.process_event,
> > +                itrace=3Dself.options.itrace
> > +            )
> > +        except (OSError, ValueError, KeyError, RuntimeError, TypeError=
, AttributeError) as e:
> > +            print(f"Error opening session: {e}", file=3Dsys.stderr)
> > +            sys.exit(1)
> > +
> > +        try:
> > +            self.session.process_events()
> > +        finally:
> > +            self.session =3D None
> > +        print('End')
> > +
> > +if __name__ =3D=3D "__main__":
> > +    def int_arg(v: str) -> int:
> > +        """Helper for integer command line arguments."""
> > +        val =3D int(v)
> > +        if val < 0:
> > +            raise argparse.ArgumentTypeError("Argument must be a posit=
ive integer")
> > +        return val
> > +
> > +    arg_parser =3D argparse.ArgumentParser(description=3D"ARM CoreSigh=
t Trace Dump With Disassembler")
> > +    arg_parser.add_argument("-i", "--input", help=3D"input perf.data f=
ile")
> > +    arg_parser.add_argument("-k", "--vmlinux",
> > +                            help=3D"Set path to vmlinux file. Omit to =
autodetect")
> > +    arg_parser.add_argument("-d", "--objdump", nargs=3D"?", const=3Dde=
fault_objdump(),
> > +                            help=3D"Show disassembly. Can also be used=
 to change the objdump path")
> > +    arg_parser.add_argument("-v", "--verbose", action=3D"store_true", =
help=3D"Enable debugging log")
> > +    arg_parser.add_argument("--start-time", type=3Dint_arg,
> > +                            help=3D"Monotonic clock time of sample to =
start from.")
> > +    arg_parser.add_argument("--stop-time", type=3Dint_arg,
> > +                            help=3D"Monotonic clock time of sample to =
stop at.")
> > +    arg_parser.add_argument("--itrace", default=3D"b",
> > +                            help=3D"Instruction tracing options.")
> > +    arg_parser.add_argument("--start-sample", type=3Dint_arg,
> > +                            help=3D"Index of sample to start from.")
> > +    arg_parser.add_argument("--stop-sample", type=3Dint_arg,
> > +                            help=3D"Index of sample to stop at.")
> > +
> > +    parsed_options =3D arg_parser.parse_args()
> > +    if (parsed_options.start_time is not None and parsed_options.stop_=
time is not None and
> > +            parsed_options.start_time >=3D parsed_options.stop_time):
> > +        print("--start-time must less than --stop-time")
> > +        sys.exit(2)
> > +    if (parsed_options.start_sample is not None and parsed_options.sto=
p_sample is not None and
> > +            parsed_options.start_sample >=3D parsed_options.stop_sampl=
e):
> > +        print("--start-sample must less than --stop-sample")
> > +        sys.exit(2)
> > +
> > +    td =3D TraceDisasm(parsed_options)
> > +    td.run()
> > diff --git a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm=
.sh b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
> > index f3ebad596378..51bcbd78f460 100755
> > --- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
> > +++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
> > @@ -1,6 +1,6 @@
> >   #!/bin/bash
> > -# Check Arm CoreSight disassembly script completes without errors (exc=
lusive)
> >   # SPDX-License-Identifier: GPL-2.0
> > +# Check Arm CoreSight disassembly script completes without errors (exc=
lusive)
> >
> >   # The disassembly script reconstructs ranges of instructions and give=
s these to objdump to
> >   # decode. objdump doesn't like ranges that go backwards, but these ar=
e a good indication
> > @@ -22,9 +22,21 @@ glb_err=3D1
> >
> >   perfdata_dir=3D$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
> >   perfdata=3D${perfdata_dir}/perf.data
> > +perfdata2=3D${perfdata_dir}/perf2.data
> >   file=3D$(mktemp /tmp/temporary_file.XXXXX)
> >   # Relative path works whether it's installed or running from repo
> > -script_path=3D$(dirname "$0")/../../../scripts/python/arm-cs-trace-dis=
asm.py
> > +if [ -n "$PERF_EXEC_PATH" ] && [ -e "$PERF_EXEC_PATH/python/arm-cs-tra=
ce-disasm.py" ]; then
> > +     script_path=3D"$PERF_EXEC_PATH/python/arm-cs-trace-disasm.py"
> > +else
> > +     script_path=3D$(dirname "$0")/../../../python/arm-cs-trace-disasm=
.py
> > +fi
> > +
> > +# shellcheck source=3Dlib/setup_python.sh
> > +. "$(dirname "$0")"/../lib/setup_python.sh
> > +$PYTHON -c "import perf" 2>/dev/null || {
> > +     echo "Skipping test, perf python module not found"
> > +     exit 2
> > +}
> >
> >   cleanup_files()
> >   {
> > @@ -44,8 +56,8 @@ branch_search=3D'[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|p=
l|vs|vc|hi|ls|ge|lt|gt|le|al)
> >   if [ "$(id -u)" =3D=3D 0 ] && [ -e /proc/kcore ]; then
> >       echo "Testing kernel disassembly"
> >       perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- tou=
ch $file > /dev/null 2>&1
> > -     perf script -i ${perfdata} --itrace=3Db -s python:${script_path} =
-- \
> > -             -d --stop-sample=3D2 -k ${perfdata}/kcore_dir/kcore 2> /d=
ev/null > ${file}
> > +     $PYTHON ${script_path} -i ${perfdata} --itrace=3Db -d --stop-samp=
le=3D2 \
> > +             -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
> >       grep -q -E ${branch_search} ${file}
> >       echo "Found kernel branches"
> >   else
> > @@ -56,8 +68,8 @@ fi
> >   ## Test user ##
> >   echo "Testing userspace disassembly"
> >   perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /=
dev/null 2>&1
> > -perf script -i ${perfdata} --itrace=3Db -s python:${script_path} -- \
> > -     -d --stop-sample=3D2 2> /dev/null > ${file}
> > +perf inject --itrace=3Db -i ${perfdata} -o ${perfdata2}
> > +$PYTHON ${script_path} -i ${perfdata2} -d --stop-sample=3D2 2> /dev/nu=
ll > ${file}
> >   grep -q -E ${branch_search} ${file}
> >   echo "Found userspace branches"
> >
> > diff --git a/tools/perf/tests/shell/lib/setup_python.sh b/tools/perf/te=
sts/shell/lib/setup_python.sh
> > index 2173215a0517..220d9663f81a 100644
> > --- a/tools/perf/tests/shell/lib/setup_python.sh
> > +++ b/tools/perf/tests/shell/lib/setup_python.sh
> > @@ -18,6 +18,10 @@ fi
> >   # Set PYTHONPATH to find the in-tree built perf.so first, avoiding sy=
stem-wide perf.so
> >   if [ -n "$PERF_EXEC_PATH" ] && [ -d "$PERF_EXEC_PATH/python" ]; then
> >     PYTHONPATH_DIR=3D"$PERF_EXEC_PATH/python"
> > +elif [ -n "${BASH_SOURCE[0]}" ] && [ -d "$(dirname "${BASH_SOURCE[0]}"=
)/../../../python" ]; then
> > +  PYTHONPATH_DIR=3D"$(dirname "${BASH_SOURCE[0]}")/../../../python"
> > +elif [ -d "$(dirname "$0")/../../../python" ]; then
> > +  PYTHONPATH_DIR=3D"$(dirname "$0")/../../../python"
> >   elif [ -d "$(dirname "$0")/../../python" ]; then
> >     PYTHONPATH_DIR=3D"$(dirname "$0")/../../python"
> >   elif [ -d "$(dirname "$0")/../python" ]; then
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks! v3 has some Sashiko related nits cleaned up in this code, but
I'll keep the reviewed-by tag. I hope that's okay.

Thanks,
Ian

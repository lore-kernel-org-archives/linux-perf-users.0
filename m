Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4115472F7D
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303163; cv=none; b=Tx5DoFTEJj809804A/KIqS37JD/e9uyC+Rna9WrJ2JCdguA4PfOanvbu8FrccyUHXyAthBpaDc0skzT89effdg3Ye/CPeu2pbWmV8k4NBDE41rwr+vo0EfF+oA45S/vZTNnhf4Dv+/KBtA8zSm/uh1qEy7+x0desvtgviRhleQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303163; c=relaxed/simple;
	bh=2afvxsteTJHtLsZVzMM0CLYcWbZ/WUtrGsoR2g/fnkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hs7pQKahSdfouxgAjfm4IbbjbfDSzqb4M1zE0CPMHdvKgSSQFMBmt/PCMgi42/tSwR3g6gkFtkLTKSCdi26BazVoaMLSQdU9kgvfyDFnpNkn8lmZj0EIQ+rHiJtEKPdT71wfg8UieWq4Z5EP6j2qKMvhYO4GVMUhZemZmecmKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m415Srcz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m415Srcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6DC1F000E9;
	Fri, 21 Aug 2026 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787303155;
	bh=ZqU3TJ07YmZdoJy2uFTRlHn3IPhbtlSZ2XDve+0uVec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m415Srczq8L0xA6eReo60Kqh/VV79uRm4I5TswsuI+0t82b4AbclxCt01LnIbYXh7
	 VjeyB7KCa+00X9WY7IYtJMIcfBfxSoIsU9YJE9lSCLyE3qRSUQyRGCkZrKIu1OYGSN
	 0d4SrTlwcre/q0vuKSskW9JwEaEWLrvdlcNLXEsXj9LBDqjULwADz6cCFn+ghV9wnt
	 ikkBWpqtOeNxwSFselJQTu6QfsGz76/JeEGaAoHjxNIwXDHKmyer43uoFpN1mLoC8g
	 qWuqzGNfE8dTPFoDmja+8XtWS/J0l9CXEQ0WAKpMZ7aKExFCIdCmrBvfFeynr+AHF8
	 GI6ckTQvi+NIQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/1] perf scripts flamegraph: Add --asm option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tudor-Stefan Magirescu" <tudor.magirescu@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821085044.982835-2-tudor.magirescu@gmail.com>
References: <20260821085044.982835-1-tudor.magirescu@gmail.com>
 <20260821085044.982835-2-tudor.magirescu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 09:05:54 +0000
Message-Id: <20260821090555.1B6DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `--asm` option directly opens unverified `dso` paths on the =
host filesystem, bypassing perf's build-id cache.
- [Medium] The script invokes a new `objdump` process via `subprocess.run` =
for every unique sampled function, creating a severe performance bottleneck.
- [Medium] The script crashes with a raw `FileNotFoundError` if the configu=
red or default `objdump` executable is missing.
--

--- Patch [1]: [RFC PATCH 1/1] perf scripts flamegraph: Add --asm option ---
commit e7196726e4cd528492356aed32496e94223294a5
Author: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>

perf scripts flamegraph: Add --asm option

The flamegraph script reports samples at function granularity, so a wide
frame shows which function is hot but not which part of it. This patch
adds an --asm option to emit more fine-grained flame graphs by including
instruction-level information.

> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts=
/python/flamegraph.py
> index ad735990c5bec..424919e24aed7 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
[ ... ]
> @@ -67,10 +76,101 @@ class Node:
>          }
> =20
> =20
> +@dataclass
> +class Symbol:
> +    start: int
> +    size: int
> +
> +
> +class Instructions:
> +    def __init__(self):
> +        self.symbols:      dict[str, dict[str, Symbol]] =3D {}
> +        self.instructions: dict[tuple[str, str], dict[int, str]] =3D {}
> +        self.objdump_line: re.Pattern =3D re.compile(r"^\s+([0-9a-f]+):\=
s+(.*)")
> +        self.symbol_line: re.Pattern =3D re.compile(
> +            r"^([0-9a-f]+) (.{7})\s+\S+\s+([0-9a-f]+)\s+(.*)$")
> +        self.objdump:      str =3D default_objdump()
> +
> +    def load_symbols(self, dso: str) -> dict[str, Symbol]:
> +        result =3D subprocess.run(
> +            [self.objdump, "--demangle", "-t", dso],
> +            capture_output=3DTrue, text=3DTrue, check=3DFalse
> +        )

[Severity: Medium]
Does this code bypass perf's build-id cache by opening the dso path directl=
y on
the host filesystem?

The objdump command attempts to open the dso string directly on the host
filesystem.

This can fail for kernel symbols like [kernel.kallsyms] or read incorrect h=
ost
binaries when analyzing cross-platform or container perf.data files.

[Severity: Medium]
Will this crash with a raw FileNotFoundError if the objdump executable is
missing?

Without an exception handler, if the configured or default objdump executab=
le is
missing, the script will abruptly crash with a Python traceback.

It might be better to gracefully fall back to function-level nodes or displ=
ay a
helpful error.

[ ... ]
> +    def load_instructions(self, dso: str, sym: Symbol) -> dict[int, str]:
> +        result =3D subprocess.run(
> +            [
> +                self.objdump, "-d",
> +                "--no-show-raw-insn",
> +                f"--start-address=3D0x{sym.start:x}",
> +                f"--stop-address=3D0x{sym.start + sym.size:x}",
> +                dso,
> +            ],
> +            capture_output=3DTrue, text=3DTrue, check=3DFalse
> +        )

[Severity: Medium]
Will this also crash with a raw FileNotFoundError if the objdump executable=
 is
missing?

Like load_symbols(), this subprocess.run() call lacks an exception handler =
for
when objdump cannot be found on the system path.

[ ... ]
> +    def lookup_instruction(self, dso: str, func: str,
> +                           off: int) -> Optional[tuple[int, Optional[str=
]]]:
> +        if dso not in self.symbols:
> +            self.symbols[dso] =3D self.load_symbols(dso)
> +
> +        sym =3D self.symbols[dso].get(func)
> +        if sym is None:
> +            return None
> +
> +        if (dso, func) not in self.instructions:
> +            self.instructions[(dso, func)] =3D self.load_instructions(ds=
o, sym)

[Severity: Medium]
Does this create a severe performance bottleneck by invoking a new objdump
process for every unique sampled function?

Profiling an application with many unique functions causes thousands of obj=
dump
processes to be spawned sequentially, resulting in a severe performance
bottleneck and drastically increasing execution time.

[ ... ]
> @@ -119,6 +219,22 @@ class FlameGraphCLI:
>              name =3D event.get("symbol", "[unknown]")
>              libtype =3D self.get_libtype_from_dso(event.get("dso"))
>              node =3D self.find_or_create_node(node, name, libtype)
> +
> +        if self.args.asm:
> +            # use the sample IP directly rather than callchain[0], since=
 with
> +            # precise event recording (i.e. :pp) the top callchain entry=
 may
> +            # point to the next instruction rather than the sampled IP
> +            sym_name =3D event.get("symbol")
> +            sym_off  =3D event.get("symoff")
> +            dso      =3D event.get("dso")
> +
> +            if sym_name and sym_off is not None and dso:
> +                found =3D self.instructions.lookup_instruction(dso, sym_=
name, sym_off)

[Severity: Medium]
Does this pass the target's unresolved dso path directly to the instruction
lookup logic?

When analyzing perf.data files from other architectures, containers, or ker=
nel
space, using the dso string directly on the host filesystem will lead to mi=
ssing
or incorrect instruction mappings because it bypasses the build-id cache.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821085044.9828=
35-2-tudor.magirescu@gmail.com?part=3D1

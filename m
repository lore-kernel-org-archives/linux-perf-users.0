Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADE455176
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845057; cv=none; b=Nrcbwdpfu7HeX6bwPJlI7AWRIkIZRIXPq1pdiQW++wAzP4gKSoldlpy9Kk91sHguc24brM1ofUnlS3xpvEo1OL1FvT+G7flPZMam0+TrgBPmG1qnppsdsFlSUPIyR6ztGB2VfzMjzCv7QRnLfx31NEUkVoV3mbX5ckPcmT8v4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845057; c=relaxed/simple;
	bh=TTfV9nxaNb3Y7Q5WxE5Iq3/ggR+BHpFItqxiVmKzkVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rmwLWo1jiniAGvBGntRCUYAiKvbUQvK8orP6d+VpTmqkwDK9Pl9byhVJ91rC3MnQ4bFxLgd09KyGbS5h5lXk/fRyDEGHXyydQwWVp7Fn+cHt20NTUDh7F+aJwiXOtaPwfyGT6OKppzm7rWDqQzzJjLN/M4awTFW75cFZZ5CvvfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXVA45aO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXVA45aO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB001F000E9;
	Thu, 27 Aug 2026 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787845054;
	bh=iy3PC77z8jstxdukJXae5nRo3E6kVjC6c7PnpBqYry8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXVA45aOZXNel+IpsW62NhTr2o3EIJ5dskrqZDsXipWFRgXQXHJ1FIYxsKbHqA6c/
	 6gW+tTJ3Sg+3LMkKvblQyv0tzeOEJhrWB0m4wnkYzrY0Gp/vqCE1xKw+SaHnZztvcN
	 6JgPtwSXetA9patLDxAzwpBbpYVeRorcfgrRKEK6SDBoXWbRCJKFbMQu8H+a8QGS/x
	 Uz3gpWll9tplrPvZlAOYMpsznA6NUIEAjesS3gahM3f3zep/P6qsBzyzfyYvFOhseD
	 VQnHhTOy0raAJTIR5INE6Py4AIZZBZnAjp6h66ZwyD/bv+ZzcQBrjYhzY8U6p2Sldg
	 z4VOApdupXMTA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/1] perf scripts flamegraph: Add --asm option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tudor-Stefan Magirescu" <tudor.magirescu@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260827152354.1513813-2-tudor.magirescu@gmail.com>
References: <20260821090555.1B6DC1F000E9@smtp.kernel.org>
 <20260827152354.1513813-1-tudor.magirescu@gmail.com>
 <20260827152354.1513813-2-tudor.magirescu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 15:37:34 +0000
Message-Id: <20260827153734.ADB001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Failure to handle arguments in the `annotate.objdump` configurat=
ion.
- [Medium] The DSO cache relies solely on the DSO path string, ignoring the=
 build ID (`dso_bid`). This causes cache collisions and incorrect instructi=
on resolution for different binaries that share the same path.

Pre-existing issues:
- [High] Inline JSON injection in HTML output allows Cross-Site Scripting (=
XSS).
--

commit a1b6c61e23ce511b72ebb5b70907e6c0f8aea1bb
Author: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>

perf scripts flamegraph: Add --asm option

This commit adds an `--asm` option to the perf flamegraph script to generate
more fine-grained flame graphs. When enabled, instruction-level information
appears as leaves in the call stacks by disassembling the sampled addresses.

> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts=
/python/flamegraph.py
> index ad735990c5bec..60ace98e73add 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
[ ... ]
> @@ -67,10 +71,146 @@ class Node:
>          }
> =20
> =20
> +@dataclass
> +class Symbol:
> +    start: int
> +    size: int
[ ... ]
> +    @staticmethod
> +    def default_objdump() -> Optional[str]:
> +        config =3D perf_config_get("annotate.objdump")
> +        cmd =3D config if config else "objdump"
> +        try:
> +            subprocess.run([cmd, "--version"], capture_output=3DTrue, ch=
eck=3DFalse)

[Severity: Medium]
In default_objdump(), will this fail if the `annotate.objdump` configuration
contains arguments?

If `cmd` contains spaces (e.g. `objdump -M intel`), passing it as a single
string to `subprocess.run()` treats the entire string as the executable nam=
e.
This will result in a `FileNotFoundError`, crashing the script and disablin=
g the
`--asm` annotation entirely.

> +        except FileNotFoundError as err:
> +            print(f"Error running objdump: {err}; "
> +                  "instruction annotations will be skipped", file=3Dsys.=
stderr)
> +            return None
> +        return cmd
> +
> +    def load_symbols(self, resolved_dso: str) -> dict[str, Symbol]:
> +        result =3D subprocess.run(
> +            [self.objdump, "--demangle", "-t", resolved_dso],

In load_symbols(), if `self.objdump` contained spaces and bypassed the vers=
ion
check, this direct invocation without tokenizing arguments would also fail.

> +            capture_output=3DTrue, text=3DTrue, check=3DFalse
> +        )
[ ... ]
> +    def lookup_instruction(self, dso: str, dso_bid: str, func: str,
> +                           off: int) -> Optional[tuple[int, Optional[str=
]]]:
> +        if self.objdump is None:
> +            return None
> +
> +        if dso not in self.resolved_dsos:
> +            self.resolved_dsos[dso] =3D ResolvedDso(
> +                symtab_file=3Dself.resolve_dso(dso_bid, ('debug', 'elf')=
),
> +                code_file=3Dself.resolve_dso(dso_bid, ('elf', 'debug')),
> +            )

[Severity: Medium]
In lookup_instruction(), does this cache logic handle different binaries wi=
th
the same path correctly?

The cache key uses only `dso` (the path string) to store and retrieve binary
paths, ignoring the `dso_bid` (build ID) on subsequent lookups. If a `perf.=
data`
file contains events from distinct binaries that share the same path (e.g.,
different containers with `/lib/x86_64-linux-gnu/libc.so.6`), won't this ca=
use
cache collisions and resolve instructions from the wrong binary?

> +
> +        resolved_dso =3D self.resolved_dsos[dso]
> +        if resolved_dso.symtab_file is None or resolved_dso.code_file is=
 None:
> +            return None
> +
> +        if (dso, func) in self.instructions:

Similarly, the instruction cache omits `dso_bid` from its compound key, whi=
ch
could retrieve cached instructions from the wrong binary on collisions.

> +            addr =3D self.symbols[dso][func].start + off
> +            return (addr, self.instructions[(dso, func)].get(addr))
> +
> +        if dso not in self.symbols:
> +            self.symbols[dso] =3D self.load_symbols(resolved_dso.symtab_=
file)

This symbol cache also uses only `dso` as the key, loading symbols from the=
 wrong
file if collisions occur.

> +
> +        sym =3D self.symbols[dso].get(func)
> +        if sym is None:
> +            return None
> +
> +        self.instructions[(dso, func)] =3D self.load_instructions(resolv=
ed_dso.code_file, sym)
> +        addr =3D sym.start + off
> +        return (addr, self.instructions[(dso, func)].get(addr))
[ ... ]
> @@ -119,6 +259,23 @@ class FlameGraphCLI:
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
> +            dso_bid  =3D event.get("dso_bid")
> +
> +            if sym_name and sym_off is not None and dso and dso_bid:
> +                found =3D self.instructions.lookup_instruction(dso, dso_=
bid, sym_name, sym_off)
> +                if found is not None:
> +                    addr, instruction =3D found
> +                    name =3D f"{instruction} [0x{addr:x}]" if instructio=
n else f"[0x{addr:x}]"

[Severity: High]
This is a pre-existing issue, but does assigning untrusted strings to the n=
ode
name in process_event() create a Cross-Site Scripting (XSS) vulnerability?

Untrusted strings originating from binary disassembly (and previously, symb=
ol
names) are assigned here as the node's name. Later in `trace_end()`, the JS=
ON
structure is serialized via `json.dumps()` without escaping HTML control
characters.

The unescaped JSON string is then written directly into an HTML `<script>` =
block
in tools/perf/scripts/python/flamegraph.py. If an attacker provides a craft=
ed
`perf.data` trace containing `</script>` in the instruction output or symbol
name, they could break out and execute arbitrary JavaScript when the user o=
pens
the resulting HTML report.

> +                    libtype =3D self.get_libtype_from_dso(dso)
> +                    node =3D self.find_or_create_node(node, name, libtyp=
e)
>          node.value +=3D 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827152354.1513=
813-2-tudor.magirescu@gmail.com?part=3D1

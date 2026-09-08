Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7C83D75C6;
	Tue,  8 Sep 2026 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902611; cv=none; b=hAKawwpxSL1Lnf4odpbtxtFpH4HHcJ4vZE4rPJls62MIThIm6cYN+54Pxq4uqacDk8OLcSZze7LJeWHhBkuVXlZBsM+6J1X9MbFBK2f0J+KNPhwlgoOcvFxVR/p4YNQAcSDYr+xUyqih2CQbT6GvwUGGV13pgm73d7Gva7Gah9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902611; c=relaxed/simple;
	bh=UAcc8ExoQDZsPlGLCBkcKaTpgkwV9H/9l7rcUkYGRFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLu6J+IIfRCIXVSyMcAad6brlKA29/M53nXY3trbbRTjT2OL2t9+sdqeSQpIaR1gwJzoCcHO9QJAMOhXxgCp4VOcpYY8jRGJKhAcODx/nblMjnes61oZmYm3N+xQear7KsUaAUHegp0HmFm30nkJn98NNicsbAQ4BFvO12Dxtak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPqDhlf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPqDhlf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54CC1F00A3A;
	Tue,  8 Sep 2026 21:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788902609;
	bh=bAA502wOQhNS9EpM6KceQ6+GTs1bH9ItrTJFkCxKJP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gPqDhlf6crHZDsNtegodZDFeWIUPElOFpc0O5HZrVTk1aecY5226NrlyUx2Hjz+KA
	 82pkVmzRTTuXUKZtINiNakcmnUqJBQcXGV3MJoOBIcxKxbDznm1kNYN8CA4Ai+CWwT
	 vztLc8cWJM58KfB1CttHQUPes1aHilZnbTXD10orK6fSvjGc+/sWBKSGFNaxL5wC7n
	 Mj5ZUkLz0G25DOnIjhCJks536kktjICkNo70nwqI1uaS5xPrbWB7FUpg7C/rda42WE
	 0zi76QoZXqzFIo5CaD09fjyWyEKERfrjauQ/nfZMjTRpIvIw3arG2rxHeRp7jLuqE8
	 GiQWcKOCdG9Bg==
Date: Tue, 8 Sep 2026 18:23:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] perf scripts flamegraph: Add --asm option
Message-ID: <aqB8ztUiT72ywmz_@x2>
References: <20260821090555.1B6DC1F000E9@smtp.kernel.org>
 <20260827152354.1513813-1-tudor.magirescu@gmail.com>
 <20260827152354.1513813-2-tudor.magirescu@gmail.com>
 <20260827153734.ADB001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827153734.ADB001F000E9@smtp.kernel.org>

On Thu, Aug 27, 2026 at 03:37:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Failure to handle arguments in the `annotate.objdump` configuration.
> - [Medium] The DSO cache relies solely on the DSO path string, ignoring the build ID (`dso_bid`). This causes cache collisions and incorrect instruction resolution for different binaries that share the same path.

Can you take a look at this?

Thanks,

- Arnaldo
 
> Pre-existing issues:
> - [High] Inline JSON injection in HTML output allows Cross-Site Scripting (XSS).
> --
> 
> commit a1b6c61e23ce511b72ebb5b70907e6c0f8aea1bb
> Author: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>
> 
> perf scripts flamegraph: Add --asm option
> 
> This commit adds an `--asm` option to the perf flamegraph script to generate
> more fine-grained flame graphs. When enabled, instruction-level information
> appears as leaves in the call stacks by disassembling the sampled addresses.
> 
> > diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> > index ad735990c5bec..60ace98e73add 100755
> > --- a/tools/perf/scripts/python/flamegraph.py
> > +++ b/tools/perf/scripts/python/flamegraph.py
> [ ... ]
> > @@ -67,10 +71,146 @@ class Node:
> >          }
> >  
> >  
> > +@dataclass
> > +class Symbol:
> > +    start: int
> > +    size: int
> [ ... ]
> > +    @staticmethod
> > +    def default_objdump() -> Optional[str]:
> > +        config = perf_config_get("annotate.objdump")
> > +        cmd = config if config else "objdump"
> > +        try:
> > +            subprocess.run([cmd, "--version"], capture_output=True, check=False)
> 
> [Severity: Medium]
> In default_objdump(), will this fail if the `annotate.objdump` configuration
> contains arguments?
> 
> If `cmd` contains spaces (e.g. `objdump -M intel`), passing it as a single
> string to `subprocess.run()` treats the entire string as the executable name.
> This will result in a `FileNotFoundError`, crashing the script and disabling the
> `--asm` annotation entirely.
> 
> > +        except FileNotFoundError as err:
> > +            print(f"Error running objdump: {err}; "
> > +                  "instruction annotations will be skipped", file=sys.stderr)
> > +            return None
> > +        return cmd
> > +
> > +    def load_symbols(self, resolved_dso: str) -> dict[str, Symbol]:
> > +        result = subprocess.run(
> > +            [self.objdump, "--demangle", "-t", resolved_dso],
> 
> In load_symbols(), if `self.objdump` contained spaces and bypassed the version
> check, this direct invocation without tokenizing arguments would also fail.
> 
> > +            capture_output=True, text=True, check=False
> > +        )
> [ ... ]
> > +    def lookup_instruction(self, dso: str, dso_bid: str, func: str,
> > +                           off: int) -> Optional[tuple[int, Optional[str]]]:
> > +        if self.objdump is None:
> > +            return None
> > +
> > +        if dso not in self.resolved_dsos:
> > +            self.resolved_dsos[dso] = ResolvedDso(
> > +                symtab_file=self.resolve_dso(dso_bid, ('debug', 'elf')),
> > +                code_file=self.resolve_dso(dso_bid, ('elf', 'debug')),
> > +            )
> 
> [Severity: Medium]
> In lookup_instruction(), does this cache logic handle different binaries with
> the same path correctly?
> 
> The cache key uses only `dso` (the path string) to store and retrieve binary
> paths, ignoring the `dso_bid` (build ID) on subsequent lookups. If a `perf.data`
> file contains events from distinct binaries that share the same path (e.g.,
> different containers with `/lib/x86_64-linux-gnu/libc.so.6`), won't this cause
> cache collisions and resolve instructions from the wrong binary?
> 
> > +
> > +        resolved_dso = self.resolved_dsos[dso]
> > +        if resolved_dso.symtab_file is None or resolved_dso.code_file is None:
> > +            return None
> > +
> > +        if (dso, func) in self.instructions:
> 
> Similarly, the instruction cache omits `dso_bid` from its compound key, which
> could retrieve cached instructions from the wrong binary on collisions.
> 
> > +            addr = self.symbols[dso][func].start + off
> > +            return (addr, self.instructions[(dso, func)].get(addr))
> > +
> > +        if dso not in self.symbols:
> > +            self.symbols[dso] = self.load_symbols(resolved_dso.symtab_file)
> 
> This symbol cache also uses only `dso` as the key, loading symbols from the wrong
> file if collisions occur.
> 
> > +
> > +        sym = self.symbols[dso].get(func)
> > +        if sym is None:
> > +            return None
> > +
> > +        self.instructions[(dso, func)] = self.load_instructions(resolved_dso.code_file, sym)
> > +        addr = sym.start + off
> > +        return (addr, self.instructions[(dso, func)].get(addr))
> [ ... ]
> > @@ -119,6 +259,23 @@ class FlameGraphCLI:
> >              name = event.get("symbol", "[unknown]")
> >              libtype = self.get_libtype_from_dso(event.get("dso"))
> >              node = self.find_or_create_node(node, name, libtype)
> > +
> > +        if self.args.asm:
> > +            # use the sample IP directly rather than callchain[0], since with
> > +            # precise event recording (i.e. :pp) the top callchain entry may
> > +            # point to the next instruction rather than the sampled IP
> > +            sym_name = event.get("symbol")
> > +            sym_off  = event.get("symoff")
> > +            dso      = event.get("dso")
> > +            dso_bid  = event.get("dso_bid")
> > +
> > +            if sym_name and sym_off is not None and dso and dso_bid:
> > +                found = self.instructions.lookup_instruction(dso, dso_bid, sym_name, sym_off)
> > +                if found is not None:
> > +                    addr, instruction = found
> > +                    name = f"{instruction} [0x{addr:x}]" if instruction else f"[0x{addr:x}]"
> 
> [Severity: High]
> This is a pre-existing issue, but does assigning untrusted strings to the node
> name in process_event() create a Cross-Site Scripting (XSS) vulnerability?
> 
> Untrusted strings originating from binary disassembly (and previously, symbol
> names) are assigned here as the node's name. Later in `trace_end()`, the JSON
> structure is serialized via `json.dumps()` without escaping HTML control
> characters.
> 
> The unescaped JSON string is then written directly into an HTML `<script>` block
> in tools/perf/scripts/python/flamegraph.py. If an attacker provides a crafted
> `perf.data` trace containing `</script>` in the instruction output or symbol
> name, they could break out and execute arbitrary JavaScript when the user opens
> the resulting HTML report.
> 
> > +                    libtype = self.get_libtype_from_dso(dso)
> > +                    node = self.find_or_create_node(node, name, libtype)
> >          node.value += 1
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260827152354.1513813-2-tudor.magirescu@gmail.com?part=1

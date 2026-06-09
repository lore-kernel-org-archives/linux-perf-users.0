Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0B2FA0DF;
	Tue,  9 Jun 2026 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983185; cv=none; b=M6RbOzgZwoU2GdJ7srweknJq4YoPScdpzpfEfxS5mwZJi0RBgIE9IIuUOZLtN9Xg3/uUDiCCb4iWzzWRamfhZjUcDTcnEup/Ap2cMBZhajQ2JFnFi8vc4uQaFX2kv29F7u8rjr5Y1wGL4X4tfRP2WYVQ7oqikraFRj1sbXdYs4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983185; c=relaxed/simple;
	bh=icIweY8/h+o3NJHGNmOjM8ZSUzYuHjB9U/DY3PG4nz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pf79nQdEfWP6YUGeB4NLu/HnUnRUfs/bejH32aInIBySC7b3aL72795YoStdWYdyZSFcvJYpGEc4vos64YqLEZYZGT/vuHhKSwRubfMsbrPeubqysx+ABSEfj9HEabngPxRJTD/pyrLtwf5zl9XoQsfswTQHjdOgl74tB652SoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2uY17rd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2uY17rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0321F00893;
	Tue,  9 Jun 2026 05:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780983184;
	bh=M6K62JTe8hTlFlvjhepK/tA7SCLF08Bs8kT9RsZfgaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2uY17rdpy8/a586LXK1Fgt1Dj+syrfLPCZ7pxSqAFoUjPQR8mrHG55UYT9ZocZ4p
	 aAZHsxvEX9avLCK9Swa6YfwSFIPS7cQFEjCo6MC7ikCBoE+wgFotfA6ffHOLEzTc8V
	 JmrXgzxTbB9LhsRIru3BwMBqkSkaaG9R4Bz5h2JZit5zRkQdRCJBYP0vhdxnNfCGys
	 J40mm7lnXMbPZz4mdhmY4IAdSIae4RPQ4msK6Yix7wkREeLfU5ozV22vdTWd/6cJfI
	 dpby3Jo8z4bKwITV4rdBcSwtJvDRUDC+m/eqmIdmxvHdvXjEYW9yVOTUAAAb0rw3i7
	 D2Pz+dWUY+ehw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/7] perf annotate: Support BPF JIT disassembly via
 genelf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260609051759.405027-7-irogers@google.com>
References: <20260609051759.405027-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:33:03 +0000
Message-Id: <20260609053304.4A0321F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The temporary ELF file for BPF JIT disassembly hardcodes the host =
architecture, breaking cross-platform analysis of perf.data files.
- [High] The temporary ELF file generated for BPF disassembly has a hardcod=
ed Virtual Memory Address (VMA), causing objdump to output no instructions.
--

commit 13f48f3243b7525d8bdc81d7916d768a5bd50b37
Author: Ian Rogers <irogers@google.com>

perf annotate: Support BPF JIT disassembly via genelf

For in-memory BPF DSOs (DSO_BINARY_TYPE__BPF_PROG_INFO), write the
JITted instruction buffer to a temporary ELF file on disk using the
existing genelf framework (jit_write_elf). Reroute disassembly to
this temporary ELF file, allowing objdump and libasm to disassemble it
natively. Clean up the temporary file afterward.

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 42af3603fdffd..8c78ef765787f 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
[ ... ]
> @@ -1540,6 +1543,41 @@ static int symbol__disassemble_objdump(const char =
*filename, struct symbol *sym,
>  	return err;
>  }
> =20
> +#ifdef HAVE_LIBELF_SUPPORT
> +static int symbol__create_bpf_temp_elf(const char *filename, struct symb=
ol *sym,
> +				       struct annotate_args *args,
> +				       char *tmp_elf, size_t tmp_elf_sz)
> +{
> +	struct map *map =3D args->ms->map;
> +	struct dso *dso =3D map__dso(map);
> +	u8 *code_buf =3D NULL;
> +	const u8 *buf;
> +	u64 buf_len;
> +	bool is_64bit;
> +	int tmp_fd;
> +	int err =3D -1;
> +
> +	buf =3D dso__read_symbol(dso, filename, map, sym, &code_buf, &buf_len, =
&is_64bit);
> +	if (!buf)
> +		return -1;
> +
> +	snprintf(tmp_elf, tmp_elf_sz, "/tmp/perf-bpf-XXXXXX");
> +	tmp_fd =3D mkstemp(tmp_elf);
> +	if (tmp_fd >=3D 0) {
> +		if (jit_write_elf(tmp_fd, map__rip_2objdump(map, sym->start),
> +				  sym->name, buf, buf_len,
> +				  NULL, 0, NULL, 0, 0) =3D=3D 0) {
                  ^^^^^^^^^^^^^

[Severity: High]
Does this break cross-platform analysis of perf.data files?

When analyzing a perf.data file from a different architecture (e.g., record=
ed
on ARM64 but analyzed on an x86_64 host), jit_write_elf() generates the
temporary ELF file using host compile-time macros (GEN_ELF_ARCH).

Because the ELF header incorrectly claims the host's architecture instead of
the target's, disassemblers like objdump will decode the BPF JIT instructio=
ns
using the host's instruction set, producing garbage output.

[Severity: High]
Will objdump fail to output any instructions due to a mismatch in addresses?

Here, the actual symbol start address is passed to jit_write_elf() as
load_addr. However, jit_write_elf() ignores load_addr and hardcodes the
ELF .text section VMA and symbol address to GEN_ELF_TEXT_OFFSET (typically
0x40).

Later, symbol__disassemble_objdump() invokes objdump with --start-address
restricted to the actual symbol start address:

    err =3D asprintf(&command,
         "%s %s%s --start-address=3D0x%016" PRIx64
         " --stop-address=3D0x%016" PRIx64 ...
         map__rip_2objdump(map, sym->start),
         map__rip_2objdump(map, sym->end), ...)

Because the ELF file's contents reside at 0x40, objdump finds no instructio=
ns
within the requested start and stop address bounds, and fails the disassemb=
ly
process.

> +			err =3D 0;
> +		}
> +		close(tmp_fd);
> +		if (err)
> +			unlink(tmp_elf);
> +	}
> +	free(code_buf);
> +	return err;
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609051759.4050=
27-1-irogers@google.com?part=3D6

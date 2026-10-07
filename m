Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62091F16B
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331302; cv=none; b=n14a++TS8nStBibQsemfSwBdboAyLW+Lsu4sttxHvTxSCdOfqMdtILwebQU+VdlgGUNvSp17gYSlyWSnYQRUsg7wysIScdgLFmTkYNSy10syl4F0vqLSA3uSCOxU7D+GdLsb30Sxl6LST1UHTtKHbcxV843gdeCa3GA2jK/bBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331302; c=relaxed/simple;
	bh=Sbhck6UIp099WxQ1c3eJdeEp3CC0B9Y+NL5R1Dh2GDY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ctJzaq3CfnyhLM8JuBnOvK0fxoxIAkCemrv3mRkEIzdDZkFvvva/+3Yf+X1Fp32A9F+MfVabKuYgeIr4Ko5mjn3CSfPtAY8nvaSg9s2SIQK1I4LGo0p3vS9yjDf09KQqMw2Tl1HvfS4R6fmdnaIBnmz7z3wvemwzf5k3DG2S1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc3iGfuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc3iGfuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E4C1F0089B;
	Wed,  7 Oct 2026 00:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791331300;
	bh=HgPA0U7epKjd0jIvHG5vQAseIXjWHnWhxsaR68TBBTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mc3iGfuCdpxRSuPwKAgJeT6sIlRNsbrj2n6CHRGzoR7P1oH5jKT9/VI6bwFezyWC7
	 gtCX0ApB+fcAIwRrW8T8fl3CuiLKliu6wnPGvIanDB/lOy9oFWE0eKgriTKWITFxYl
	 MSahe+fu1HiSTnsvhSSctDVfi/nildr/pPhiMzNOXTex8wMBG0yzI0E2xTIR6/JUzN
	 iDeESRZXBODyjqw8y6j/I7mXHTgJoxysvTbt0EJzb+wYt+Du28R5IkfuSuZ0zSR77i
	 j4hS6zWoJb+IkciEmayyK6l+14Sf38Ts1kCEeCaOyAgtHcgRN0jTwiUQVv8pxnqWdI
	 1A1aNgfUdGxqQ==
Message-ID: <sashiko-outbox-162546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] perf annotate: Simplify symbol__disassemble()
 with dso binary_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006234315.920817-10-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-10-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 00:01:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf: string truncation in symbol__disassemble() due to sizeof(poi=
nter)
- [High] perf: NULL pointer dereference in LLVM disassembly backend for BPF
- [High] perf annotate: UAF in dso__get_filename due to missing dso__lock
--

commit b52fe9a1d630e0d03a547c6ca49efe1679043beb
Author: Namhyung Kim <namhyung@kernel.org>
Subject: perf annotate: Simplify symbol__disassemble() with dso binary_type

Now it should set the binary type of a DSO properly.  No need to figure
out a filename suitable for disassembly.

Just call dso__find_binary_type() and dso__get_filename() for that type.

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 5478c134e7e3b..07a345beb6250 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
[ ... ]
> @@ -1566,24 +1488,30 @@ int symbol__disassemble(struct symbol *sym, struc=
t annotate_args *args)
>  	struct annotation_options *options =3D args->options;
>  	struct map *map =3D args->ms->map;
>  	struct dso *dso =3D map__dso(map);
> -	char symfs_filename[PATH_MAX];
> +	char *symfs_filename;
>  	bool delete_extract =3D false;
>  	struct kcore_extract kce;
> +	enum dso_binary_type dbt;
>  	bool decomp =3D false;
> -	int err =3D dso__disassemble_filename(dso, symfs_filename, sizeof(symfs=
_filename));
> +	int err;
> =20
> -	if (err)
> -		return err;
> +	dbt =3D dso__find_binary_type(dso);
> +
> +	if (dbt =3D=3D DSO_BINARY_TYPE__KALLSYMS)
> +		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
> +
> +	symfs_filename =3D dso__get_filename(dso, "", &decomp, dbt);

[Severity: High]
Does this call to dso__get_filename() need to be protected by dso__lock()?

The previous code had an explicit mutex_lock(dso__lock(dso)) around the
access to dso__nsinfo(dso). dso__get_filename() reads and uses
dso__nsinfo(dso) via dso__filename_with_chroot(), but lacks internal
locking.

If another thread concurrently processes an MMAP event and calls
dso__set_nsinfo(), could the nsinfo pointer be freed between the check and
its use, leading to a use-after-free?

> +	if (symfs_filename =3D=3D NULL && dbt !=3D DSO_BINARY_TYPE__BPF_PROG_IN=
FO &&
> +	    dbt !=3D DSO_BINARY_TYPE__BPF_IMAGE)
> +		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;

[Severity: High]
When annotating BPF programs, this explicitly allows symfs_filename to be
NULL. However, could this NULL pointer be passed down to the LLVM
disassembly backend?

In the LLVM backend:
symbol__disassemble_llvm()
  llvm_name_for_code(..., filename, ...)

Inside llvm-c-helpers.cpp, symbolizer->symbolizeCode(dso_name, ...)
implicitly constructs an llvm::StringRef from the dso_name pointer.

If the pointer is NULL, won't this perform a strlen(NULL) and cause a
segmentation fault? Similarly, on PowerPC, could symbol__disassemble_raw()
invoke pr_debug("%s", filename) or open(filename, ...) with the NULL pointe=
r,
triggering undefined behavior?

> =20
>  	pr_debug("%s: filename=3D%s, sym=3D%s, start=3D%#" PRIx64 ", end=3D%#" =
PRIx64 "\n", __func__,
> -		 symfs_filename, sym->name, map__unmap_ip(map, sym->start),
> -		 map__unmap_ip(map, sym->end));
> +		 symfs_filename ?: dso__long_name(dso), sym->name,
> +		 map__unmap_ip(map, sym->start), map__unmap_ip(map, sym->end));
> =20
>  	pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_name(dso)=
, sym, sym->name);
> =20
> -	if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {
> -		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
> -	} else if (dso__is_kcore(dso)) {
> +	if (dso__is_kcore(dso)) {
>  		kce.addr =3D map__rip_2objdump(map, sym->start);
>  		kce.kcore_filename =3D symfs_filename;
>  		kce.len =3D sym->end - sym->start;
> @@ -1593,17 +1521,6 @@ int symbol__disassemble(struct symbol *sym, struct=
 annotate_args *args)
>  			delete_extract =3D true;
>  			strlcpy(symfs_filename, kce.extract_filename, sizeof(symfs_filename));

[Severity: High]
Since symfs_filename is now a char * pointer rather than an array of size
PATH_MAX, doesn't sizeof(symfs_filename) evaluate to 8 (on 64-bit systems)?

Will this cause strlcpy() to truncate the kcore extraction path to 7
characters, leading to ENOENT failures in the downstream disassemblers?

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006234315.9208=
17-1-namhyung@kernel.org?part=3D9

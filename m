Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1E3E51D2
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966347; cv=none; b=CWNsWeKs3DGUNIx1AK2/rlQWpwFiK6xg3y24RqOM4ldqM7aakVf99GP36cEYIfmdVJmptsH0yQggJECkdf5UE6X4XrXjtHV6S1B7AprpSdVwSu1+0AjKl4YlpqwFAuDwoxy6EA9b8VjyCMyHNrcy7hH1Y+7a2VMLY+R61XGXc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966347; c=relaxed/simple;
	bh=BwK/TEltkp4xILnzyC96vYO6IC6qU2DHdR+HAPUdEkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NiATp16/XDHO89oWME4qSLIdwkGJ4n9ya9TZsKtmYJI35Kuk5Sdu0NJETbmc8OQ68d/YbGlqdOhv3B5YTMTuzx7thZWCL03cfZqjZxOEx+JaM+wPiaYkS5s35u4F6XNRvMEQ4DxiViderI0UMhbsBn2gMmzTZ+kGL1KGx9Gx4Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN9+x2id; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN9+x2id"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531291F000E9;
	Wed,  5 Aug 2026 21:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785966345;
	bh=V/nLWJjNY+vykM9qTeF1k7hrxogsdEfIQ2HbFxoiGmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EN9+x2idV4rW2zveswwqKrKPxIsOuCxvqoxY2969mZRNILiqo2PH1TaOGz75yj9E6
	 VVkUGVP3//Zk/Daj1GUchhKaV3OTIbv1+FTwI4GvgfnVoAJq7MDaf0reHdefBNTvN5
	 RPnzAq+aja+FtED8OZB1YNlEKUAb0r1dhx65IkmglBndiguhXvDfPi7wXCbN3vDw37
	 h5zh3mMwuhQIo9qczA355Er7mMea3exxJtJ2ciFOExgUSPEnjthR5HPpawrsgg8hDC
	 P5yLraOOsawi0MNQ8pvRBqUluQkgBhsf4WKSQ1S107h4HaoYyj/bYtFXrEV5X143ye
	 5HoaFx2n6gbvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] perf jitdump: Use dirname() return value in
 jit_open()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805212704.267779-10-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
 <20260805212704.267779-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:45:44 +0000
Message-Id: <20260805214545.531291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds checking and validation of JIT_CODE_DEBUG_INFO when=
 architecture endianness matches.
- [High] Missing validation of unwinding record sizes allows heap informati=
on leaks into generated ELF files.
- [High] Missing NUL-termination check for symbol name in JIT_CODE_LOAD.
--

--- Patch [9]: [PATCH 09/12] perf jitdump: Use dirname() return value in ji=
t_open() ---
commit b82fdc2ff8228d697093005adb380338825bb2dd
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Use dirname() return value in jit_open()
   =20
jit_open() calls dirname(jd->dir) but ignores the return value.  POSIX
says dirname() may return a pointer to internal static storage =E2=80=94 gl=
ibc
does this when the path has no '/', returning "." from a static buffer
and leaving jd->dir unchanged with the original filename.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 91aa1eea8229f..d3de307532d55 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -146,6 +146,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
>  	ssize_t bs, bsz =3D 0;
>  	void *n, *buf =3D NULL;
>  	int ret, retval =3D -1;
> +	char *dname;
> =20
>  	nsinfo__mountns_enter(jd->nsi, &nsc);
>  	jd->in =3D fopen(name, "r");

[ ... ]

> @@ -241,7 +242,9 @@ jit_open(struct jit_buf_desc *jd, const char *name)
>  	 */
>  	strncpy(jd->dir, name, PATH_MAX - 1);
>  	jd->dir[PATH_MAX - 1] =3D '\0';
> -	dirname(jd->dir);
> +	dname =3D dirname(jd->dir);
> +	if (dname !=3D jd->dir)
> +		strlcpy(jd->dir, dname, sizeof(jd->dir));
>  	free(buf);
> =20
>  	return 0;

[Severity: High]
This is a pre-existing issue, but is it possible to corrupt memory when
processing JIT_CODE_DEBUG_INFO?

In tools/perf/util/jitdump.c:jit_get_next_entry(), the bounds-checking
logic is only executed if the host and file endianness differ:

    case JIT_CODE_DEBUG_INFO:
        if (jd->needs_bswap) { ... }

If they share the same endianness, this check is skipped. Then, in
tools/perf/util/genelf_debug.c:jit_process_debug_info(), the code iterates
blindly using the untrusted nr_debug_entries:

    for (i =3D 0; i < nr_debug_entries; i++) {
        ent->addr =3D ent->addr - code_addr;
        ent =3D debug_entry_next(ent);
    }

Could a maliciously crafted jitdump file with an artificially large
nr_entry cause an out-of-bounds heap write here?

[Severity: High]
This is a pre-existing issue, but does this code leak heap information
into the generated ELF files?

In tools/perf/util/jitdump.c:jit_repipe_unwinding_info(), internal
structure sizes are read without validating them against the record
payload length:

    jd->eh_frame_hdr_size =3D jr->unwinding.eh_frame_hdr_size;
    jd->unwinding_size =3D jr->unwinding.unwinding_size;

Later, in tools/perf/util/genelf.c:jit_add_eh_frame_info(), these
unvalidated sizes are used to compute offsets:

    uint64_t unwinding_table_size =3D unwinding_size - unwinding_header_siz=
e;
    ...
    d->d_buf =3D unwinding + unwinding_table_size;

If unwinding_size exceeds the payload, could this instruct libelf to read
adjacent heap memory? Furthermore, if unwinding_size is less than
unwinding_header_size, could unwinding_table_size underflow and cause
out-of-bounds pointer arithmetic?

[Severity: High]
This is a pre-existing issue, but is there a missing NUL-termination check
for the symbol name?

In tools/perf/util/jitdump.c:jit_repipe_code_load(), the string pointer is
calculated directly from the payload:

    sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));

When this is passed to tools/perf/util/genelf.c:jit_write_elf(), it
calculates the length:

    symlen =3D 2 + strlen(sym);

If the symbol name payload lacks a NUL terminator, will strlen() read past
the end of the heap allocation and crash the process?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805212704.2677=
79-1-acme@kernel.org?part=3D9

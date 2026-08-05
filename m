Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1571E387363
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940090; cv=none; b=aNm5LFeadam1IXg41wDX8kYsfAWCk3i0CWb3BIxtCFlv85AcDblVj2V/bRVGcJ5maUlQBcQnmgKOaj+BeR19F7uhc/IbTCvS3fgiXcy+Rh1/APG62+jEGuZrF+bzLgs3B5Y7WcLdVhU4clA/r17cWlIbwUEjOgL3s6mtfgStee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940090; c=relaxed/simple;
	bh=O28UxZMBaZDEurM/YbD5KPQMAqY/wLHjVtliA6q4ppY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DyvqQKsbdim3ukJ2nudi9foqtBgdqjzPVvtA2kiMSv0ZJ1Rs72Cwc+8uCJXev2nycqMiswts5tfUQqmYUNXtkSfK0DXBLinQVD37R1OUb3JkRvibwxUIyYoTcPfeoLQJAaYY62s5dK3C3uZ99XRS7uqIcgznHJ4XF5KIyVyaxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJbV2hYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJbV2hYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C063B1F000E9;
	Wed,  5 Aug 2026 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785940081;
	bh=BNOkyMkh4hFNFa/kC9XsWTtkY3TfeYn4Fi4WeXjlL2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJbV2hYbPACEjCdoGZeUQc1QC5mMfIXNsk5Jd3y9BEcEEmk3U1q6xo4UWhMiO0L4O
	 7O3BdIBgJoQ21Wi+3R1mYQd9EdH+CTG1mum808V8e2dMOC6blfDeWLzC6zrANjOv7h
	 3xcFN6TNg9uFhpyh/JMFU6yIezue4dPeT87co3aLjq6XNOz1A6Y1NduaQvuhqsrmex
	 73KHvJxygXAC4GKvDAOtaliLcGb1Q9zE0k2/KK/eBPessT0r2EeE/CxLsCS+ZPvVu0
	 RecnISDbSq4Z4RgAdbdyVEgdvepb/Jj/gTJwXg//evltggMMIeuLh593pu+bQmufkD
	 Y0JY3Mt50Othg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] perf jitdump: Bounds-check debug entry byte-swap
 loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805133013.235016-5-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:27:59 +0000
Message-Id: <20260805142800.C063B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for out-of-bounds read/write in JIT_CODE_DEBUG_INFO=
 parsing
- [High] Missing bounds validation for JIT_CODE_UNWINDING_INFO sizes leads =
to OOB heap read and information leak
- [High] Missing null-terminator validation for JIT_CODE_LOAD symbol string=
 causes OOB read and information leak
--

--- Patch [4]: [PATCH 04/12] perf jitdump: Bounds-check debug entry byte-sw=
ap loop ---
commit 2ca1b158f7ca3eafd8478fe7713f2806ce7b4fce
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf jitdump: Bounds-check debug entry byte-swap loop

This commit replaces array indexing with debug_entry_next() pointer arithme=
tic
for JIT_CODE_DEBUG_INFO records, and adds bounds-checking against the recor=
d's
total_size. This prevents out-of-bounds reads during byte-swapping of untru=
sted
jitdump input.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 787f8a03dae87..078d3304d2b7e 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -318,14 +318,32 @@ jit_get_next_entry(struct jit_buf_desc *jd)
>  	switch(id) {
>  	case JIT_CODE_DEBUG_INFO:
>  		if (jd->needs_bswap) {
> +			void *end =3D (void *)jr + jr->prefix.total_size;

[Severity: High]
This is a pre-existing issue, but does this skip validation for native-endi=
an
files?

The bounds checking and clamping are only performed when jd->needs_bswap is=
 true.
If the file is native-endian, the untrusted nr_entry is passed directly to =
the
downstream loop without validation:

tools/perf/util/genelf_debug.c:jit_process_debug_info() {
    ...
    for (i =3D 0; i < nr_debug_entries; i++) {
        ent->addr =3D ent->addr - code_addr;
        ent =3D debug_entry_next(ent);
    }
    ...
}

Could this lead to out-of-bounds heap reads and writes when processing a cr=
afted
JIT_CODE_DEBUG_INFO record with native endianness?

[ ... ]

> +			/* clamp so downstream consumers don't overrun */
> +			jr->info.nr_entry =3D n;
>  		}
>  		break;
>  	case JIT_CODE_UNWINDING_INFO:

[Severity: High]
This is a pre-existing issue, but is the unwinding_size bounded by the actu=
al
record size?

In jit_repipe_unwinding_info(), jd->unwinding_size is set directly from the
untrusted jr->unwinding.unwinding_size. Later, this unvalidated size is pas=
sed
to libelf:

tools/perf/util/genelf.c:jit_add_eh_frame_info() {
    ...
    d->d_size =3D unwinding_table_size;
    ...
}

Could this cause an out-of-bounds heap read and embed adjacent heap memory =
into
the generated ELF file?

>  		if (jd->needs_bswap) {
>  			jr->unwinding.unwinding_size =3D bswap_64(jr->unwinding.unwinding_siz=
e);
>  			jr->unwinding.eh_frame_hdr_size =3D bswap_64(jr->unwinding.eh_frame_h=
dr_size);
>  			jr->unwinding.mapped_size =3D bswap_64(jr->unwinding.mapped_size);
>  		}
>  		break;
>  	case JIT_CODE_CLOSE:
>  		break;
>  	case JIT_CODE_LOAD:

[Severity: High]
This is a pre-existing issue, but is the symbol string in JIT_CODE_LOAD che=
cked
for null-termination within the record bounds?

In jit_repipe_code_load(), the string pointer is derived from the record
without validation:

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
    sym =3D (void *)((unsigned long)jr + sizeof(jr->load));
    ...
}

This unvalidated string is later passed to strlen() and strcpy() in
jit_write_elf(), which could scan past the record into adjacent heap memory=
 and
leak data into the generated ELF string table.

>  		if (jd->needs_bswap) {
>  			jr->load.pid       =3D bswap_32(jr->load.pid);
>  			jr->load.tid       =3D bswap_32(jr->load.tid);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133013.2350=
16-1-acme@kernel.org?part=3D4

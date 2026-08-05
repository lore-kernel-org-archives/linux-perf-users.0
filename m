Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32E393DE0
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941819; cv=none; b=TrW6RWlKJFq/CSVGGH/qrb3XyjCEfMW55u+fHOgc+YLrlip/1ekAKzCEf4cvUPoY7aYUiF2cs5TDl+2kOKASJajoCgyV4zhitZszlQ2bwlusx8LxezNQaRAQ345fvCa2Rahglc+vy3mJ2JO19J02zsFOF98hGiYZG3U/ex0TSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941819; c=relaxed/simple;
	bh=UccTHHSVtnlnBBASPfAnT0ou7NQzF5ymgxA0w7jH/Tg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BqgcdxS1mTEc/d913iQfabSiXxjzQuag2ybjmPeaYEouqm2+gakwJa+9vCYuEIlU53dwlya6AsOvBHH2rTj7faskP8SdXzWcyKEPHzy2CSlDFNb9f+1U21BhCuiNnN++9J9aga5N1IUYwYSLNbjkNZl2vpXGtFJEpnXEbHw3URE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwBKoVJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwBKoVJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC201F00A3A;
	Wed,  5 Aug 2026 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785941817;
	bh=ATAo/pnIULeCDW2jCVarlkzKqPSDCSxc3gCVkqWxmaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cwBKoVJVveHgoyVVwaFR4etmj/sjfmlstT8ichWzckoFbeZawBQNDjcyygkJFYhng
	 eiFu7nxEe7qO//nKIuCKcDGSlPaTeGf7cYI44BgkeICiTVI01RTsxekOLQLE4eqbP4
	 Zw7/S037DuM6Q9YKNGQNpX0pNGPNrAhIbR+xZ9Ht0WiFuRc7sIzFFVOmtvRegEF+fj
	 Ujx3rc3COeMnO4iadDOyrv9UT+6Y3SILmkOijhgN2bzPdMtSvaEuCkf700ShGo1D9p
	 SxtpTWk6XuPzF+gy2Hw65JMtDGoh7eL/L0ujFYO1BiAGi7MGnYMENQyBUXE+wijeVy
	 TKNoWeJoa9O2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] perf jitdump: Prevent integer underflow in debug
 info size calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805133013.235016-4-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:56:56 +0000
Message-Id: <20260805145657.9EC201F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation of unwinding_size and eh_frame_hdr_size allows =
arbitrary heap memory extraction via ELF generation.
- [High] Broken byte-swapping logic for JIT_CODE_DEBUG_INFO records corrupt=
s data and writes out of bounds, bypassing length validation.
- [Low] Lingering memory leak of `jd->debug_data` and `jd->unwinding_data` =
upon processing completion.
- [Low] Conditional cleanup in `jit_repipe_code_load()` leaves buffers un-f=
reed on edge cases.
--

--- Patch [3]: [PATCH 03/12] perf jitdump: Prevent integer underflow in deb=
ug info size calculation ---
commit 4aaa391def5b9dab180e25ac7cc8112352a1ca2a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

    perf jitdump: Prevent integer underflow in debug info size calculation
   =20
    jit_repipe_debug_info() and jit_repipe_unwinding_info() compute payload
    sizes by subtracting the fixed header size from total_size:
   =20
      sz =3D jr->prefix.total_size - sizeof(jr->info);
   =20
    When total_size is smaller than the header struct (from a truncated or
    corrupted jitdump record), the subtraction underflows to a massive
    value, causing an oversized allocation followed by an OOB memcpy.
   =20
    Validate that total_size covers at least the fixed header before the
    subtraction in both functions.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 3195f94187164..787f8a03dae87 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -696,6 +700,10 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, u=
nion jr_entry *jr)
>  	if (!(jd && jr))
>  		return -1;
> =20
> +	/* total_size must cover at least the fixed header */
> +	if (jr->prefix.total_size < sizeof(jr->unwinding))
> +		return -1;
> +
>  	unwinding_data_size  =3D jr->prefix.total_size - sizeof(jr->unwinding);
>  	unwinding_data =3D malloc(unwinding_data_size);
>  	if (!unwinding_data)

[Severity: High]
This is a pre-existing issue, but is it possible for a maliciously crafted
JIT dump file to provide massive unwinding_size and eh_frame_hdr_size value=
s?

In jit_repipe_unwinding_info(), untrusted sizes are directly assigned to the
descriptor without validating that they fit within the actual allocated
payload:

tools/perf/util/jitdump.c:jit_repipe_unwinding_info() {
    ...
	jd->eh_frame_hdr_size =3D jr->unwinding.eh_frame_hdr_size;
	jd->unwinding_size =3D jr->unwinding.unwinding_size;
    ...
}

Later, in jit_add_eh_frame_info(), these unvalidated values could cause an
underflow or massive size calculation:

tools/perf/util/genelf.c:jit_add_eh_frame_info() {
    ...
	uint64_t unwinding_table_size =3D unwinding_size - unwinding_header_size;
    ...
	d->d_size =3D unwinding_table_size;
	d->d_buf =3D unwinding;
    ...
}

Could this force libelf to read massive amounts of out-of-bounds heap memory
and embed it into the output ELF file?

[Severity: High]
This isn't a bug introduced by this patch, but does the byte-swapping logic
for JIT_CODE_DEBUG_INFO records risk an out-of-bounds access before length
validation occurs?

In jit_get_next_entry(), a cross-endian file with a maliciously large nr_en=
try
could cause issues:

tools/perf/util/jitdump.c:jit_get_next_entry() {
    ...
			for (n =3D 0 ; n < jr->info.nr_entry; n++) {
				jr->info.entries[n].addr    =3D bswap_64(jr->info.entries[n].addr);
				jr->info.entries[n].lineno  =3D bswap_32(jr->info.entries[n].lineno);
				jr->info.entries[n].discrim =3D bswap_32(jr->info.entries[n].discrim);
			}
    ...
}

Since struct debug_entry contains a flexible array member (const char name[=
]),
the entries are variable-length.

Does using fixed-size array indexing (jr->info.entries[n]) read and byte-sw=
ap
memory beyond the allocated jd->buf boundaries?

[Severity: Low]
This is a pre-existing issue, but is there a conditional cleanup leak in
jit_repipe_code_load()?

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
	if (jd->debug_data && jd->nr_debug_entries) {
		zfree(&jd->debug_data);
		jd->nr_debug_entries =3D 0;
	}
    ...
}

If a JIT_CODE_DEBUG_INFO record allocates memory because total_size >
sizeof(header), but has 0 entries (jd->nr_debug_entries =3D=3D 0), does
jd->debug_data remain allocated but fail the secondary check, causing a lea=
k?

[Severity: Low]
This is a pre-existing issue, but is there a memory leak of jd->debug_data
and jd->unwinding_data upon processing completion?

In jit_process(), when the function tears down, it frees jd.buf but does not
appear to clean up jd->debug_data and jd->unwinding_data:

tools/perf/util/jitdump.c:jit_process() {
    ...
	nsinfo__put(jd.nsi);
	free(jd.buf);

	return ret;
}

Additionally, in jit_repipe_debug_info(), does the assignment to
jd->debug_data overwrite the previous pointer without properly freeing
it first?

tools/perf/util/jitdump.c:jit_repipe_debug_info() {
    ...
	jd->debug_data       =3D data;
    ...
}

Could these issues lead to lingering memory leaks on truncated or
malformed JIT dump files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133013.2350=
16-1-acme@kernel.org?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C62D0614
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021001; cv=none; b=qZzXlQgg3n4mMj8h4XlDKM/MPZYXaLLqWrtK14xZ2xs53NcG7nQuTeyZ0qklpZPP7Z5dfJvrd0pMjHqwqo+JzsZESAxB1vSSuvU6Io8c89rbAe9ugzU3++oJRsO4SsFQ2Ghiclb23WsFYJfYFEq5fejMdEQ0gYN2TZeVpKxU1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021001; c=relaxed/simple;
	bh=L6u3T7DC/QdAJ3a21yM4iG4710RvrD8cEO4DZZPx4FQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gGTcyrIWt8SEzybnkpqy5GKCgcIv4h00/6vngGwoaov/3dlrcVqlt/JFQdvVJ8P3Yh2vBjwUY/eveUcHtSK8PDehlNnL2Ua/SAmnjhO6EyIqIdzPV+OYMg9vuHQtr6O4t81H/MEVLPmFen1afn5laDk/Z3Ten3DFz1ThZO17Skc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfP+y8FO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfP+y8FO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519DD1F000E9;
	Thu,  6 Aug 2026 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021000;
	bh=IKk6IESKAbbt3j3R/mbHhmXbU7it5gv3zpaYWOCNfR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bfP+y8FOzm9DZAnbQwi9udbYhXPbCHF0Qqg+/IrH/a7yb4I2GAGbU5YyfH8FrrQBe
	 DZdR/Qv5fVeFWd1hhZ8/0LnIQrR+osak9yPSLq702E+rZHfCqBFYEV7SzXK91AP1H6
	 rII69IXr/4DnwTKlgelW+xlSR77w/xd+DGH138j/L0qN1bTlr+h1PiHA36sWmFb+LL
	 zY4g3pkeK7coSgi1vU5OEGzoP+Ve/XkdNfwB9y/Bgb7uFww62iL1aEUHMLEUBO/nAS
	 ttW0NiBzvMcgCJ3gVTx72TRIUUt6HpANuFdMM5pAokOqN9/tEJy4suiRcvpSXBHEGW
	 7PLHQkdiXo8rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] perf jitdump: Validate code_size against
 total_size in code load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-4-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:56:39 +0000
Message-Id: <20260806125640.519DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing total_size validation leads to integer underflow and m=
assive memory corruption or crashes in debug/unwinding info parsing.
- [Critical] `jit_get_next_entry` fails to bound `nr_entry` and improperly =
uses array indexing on a variable-length struct, causing heap buffer overfl=
ows.
- [Critical] Unvalidated `nr_entry` in debug info leads to out-of-bounds he=
ap accesses during ELF generation.
- [Critical] Truncation in `snprintf` without clamping causes integer under=
flow when calculating event size in `jit_repipe_code_move`, leading to out-=
of-bounds heap writes.
- [High] Missing `free(event)` causes a memory leak in `jit_repipe_code_mov=
e`.
- [High] Heap information leak into generated ELF file via unvalidated `unw=
inding_size`.
--

--- Patch [3]: [PATCH 03/12] perf jitdump: Validate code_size against total=
_size in code load ---
commit 1f1a1ff66272152cc1c578445365c0049a6fa38d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Validate code_size against total_size in code load

This commit adds bounds checking for code_size in jit_repipe_code_load()
to prevent out-of-bounds heap reads during pointer arithmetic. It ensures
that code_size fits within the jitdump record's total_size and prevents
integer wrapping when cast to a signed int.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index dcb26d9c6c8fc..14bd23c8d1963 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
[ ... ]
> @@ -452,6 +453,16 @@ static int jit_repipe_code_load(struct jit_buf_desc =
*jd, union jr_entry *jr)
>  	csize =3D jr->load.code_size;
>  	usize =3D jd->unwinding_mapped_size;
>  	addr  =3D jr->load.code_addr;
> +
> +	/* code blob lives at the end of the record, validate it fits */
> +	if (jr->load.p.total_size < sizeof(jr->load) ||
> +	    jr->load.code_size > jr->load.p.total_size - sizeof(jr->load) ||
> +	    jr->load.code_size > INT_MAX) {
> +		pr_warning("jitdump: invalid code_size %" PRIu64 " (total_size=3D%u) i=
n code_load record\n",
> +			   (uint64_t)jr->load.code_size, jr->load.p.total_size);
> +		return -1;
> +	}
> +
>  	sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));
>  	code  =3D (unsigned long)jr + jr->load.p.total_size - csize;
>  	count =3D jr->load.code_index;

[Severity: High]
This is a pre-existing issue, but I noticed a memory leak in
jit_repipe_code_move() when handling an untrusted file:

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
	out:
		perf_sample__exit(&sample);
		return ret;
}

Does this code leak the dynamically allocated event buffer on this return
path?

[Severity: Critical]
This is a pre-existing issue, but there appears to be an integer underflow
risk when calculating allocation sizes in jit_repipe_unwinding_info() and
jit_repipe_debug_info():

tools/perf/util/jitdump.c:jit_repipe_unwinding_info() {
    ...
	unwinding_data_size  =3D jr->prefix.total_size - sizeof(jr->unwinding);
	unwinding_data =3D malloc(unwinding_data_size);
    ...
}

And similarly:

tools/perf/util/jitdump.c:jit_repipe_debug_info() {
    ...
	sz  =3D jr->prefix.total_size - sizeof(jr->info);
	data =3D malloc(sz);
    ...
}

If a maliciously crafted record has a total_size smaller than the fixed hea=
der
size, could this subtraction underflow and cause a massive allocation and
subsequent out-of-bounds copy?

[Severity: Critical]
This is a pre-existing issue, but there might be a heap buffer overflow in
jit_get_next_entry() when byte-swapping entries:

tools/perf/util/jitdump.c:jit_get_next_entry() {
    ...
			for (n =3D 0 ; n < jr->info.nr_entry; n++) {
				jr->info.entries[n].addr    =3D bswap_64(jr->info.entries[n].addr);
    ...
}

Since nr_entry is not bounds-checked against total_size, and struct debug_e=
ntry
contains a flexible array member, does standard array indexing here compute
misaligned pointers and write out-of-bounds of the allocated buffer?

[Severity: Critical]
This is a pre-existing issue, but the unvalidated nr_entry from debug info
seems to cause out-of-bounds access during ELF generation:

tools/perf/util/genelf_debug.c:jit_process_debug_info() {
    ...
	for (i =3D 0; i < nr_debug_entries; i++) {
		ent->addr =3D ent->addr - code_addr;
		ent =3D debug_entry_next(ent);
	}
    ...
}

If jd->nr_debug_entries is set from an attacker-controlled nr_entry without
verification, could this loop read out-of-bounds via strlen() in
debug_entry_next() and write out-of-bounds via ent->addr?

[Severity: Critical]
This is a pre-existing issue, but I see a risk of underflow in event size
calculation in jit_repipe_code_move() due to un-clamped snprintf length:

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
	event->mmap2.header.size =3D (sizeof(event->mmap2) -
			(sizeof(event->mmap2.filename) - size) + idr_size);
    ...
	id =3D (void *)((unsigned long)event + event->mmap.header.size - idr_size);
	if (jd->sample_type & PERF_SAMPLE_TID) {
		id->pid  =3D pid;
		id->tid  =3D tid;
    ...
}

Since snprintf returns the length that would have been written, if size exc=
eeds
the filename buffer size, might the subtraction underflow and corrupt the e=
vent
header size?=20

Would this result in out-of-bounds pointer arithmetic for id and lead to
arbitrary heap writes?

[Severity: High]
This is a pre-existing issue, but there appears to be a heap information le=
ak
into generated ELF files due to an unvalidated unwinding_size:

tools/perf/util/jitdump.c:jit_repipe_unwinding_info() {
    ...
	jd->unwinding_size =3D jr->unwinding.unwinding_size;
    ...
}

tools/perf/util/genelf.c:jit_add_eh_frame_info() {
    ...
	d->d_buf =3D unwinding;
	d->d_type =3D ELF_T_BYTE;
	d->d_size =3D unwinding_table_size;
    ...
}

If jd->unwinding_size is populated directly from an untrusted payload witho=
ut
verification against the actual available size, can libelf read out-of-boun=
ds
heap memory and leak it into the generated file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D3

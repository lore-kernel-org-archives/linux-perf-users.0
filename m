Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E4357CEC
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966384; cv=none; b=pQN27sQ6vZokjUxl25ewaHHVc5vZoyrcYjlWoBJa6fWsQj7/YkKo7bjqr2VnoVPvjvxmbz9sSsqwUBn7DZBgBcqvGyYU2D/JeqIeJQuEsjK1lod53Att36Lhf9j6aYzvxrdrASTWcQ8vEevGbqeLw/W/JneRc/nrZdoI04lHZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966384; c=relaxed/simple;
	bh=ipQIWzZDC5OmvAor6vHY4lPsjwUdLMXM9c0Cv+jlmiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hn9xwjs3dl2+nAgv0zs2mqo9tmrU1z6/GElgFrG071sbRiFSqa/N8osIJSglL0viD70apYaon/6sXsJ9STUsAS8LcTqA0sJ9g6O8J/OrgdR0Rjs/I8Tz/3emak2KDEgIg3befbAiD/AebnK+Kf1pzTyIzadnsysjZd7vZTdGG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxQ/MgXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxQ/MgXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB9D1F000E9;
	Wed,  5 Aug 2026 21:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785966382;
	bh=R38Xc169LYNlrDhENPBArl7HyubDIDeuse+kTytmbGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GxQ/MgXXVVIMGBsmL2kKU8snemj7cGfgN/cutryMwKQFqlNiSNfEZsgwD8gdOeUCx
	 zOzdRGg+MnvVJuhMiMK3hmWCMZUKez5LE0fatyGCfnCLXWKNTAZ+uPiKISgSXmVFaZ
	 2/9yV31+zUZToGuZnbENtFDyjeOf4z7BdBj1bCp1phA0wXyxfDimRNi0UDxViE7DD6
	 aQqV2awG6NSDcpjpz0mNjtSuBWR1z1WF0LtolES9eJZSqmBbb9OepgXYzF2HUeDa0c
	 nkUU3K9XXIDdtB4+DDDEK61+v25nUAawEChAPagfELMOjN/zqlZPcQGWGANSRNhEj6
	 OMddKscJtL5KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] perf jitdump: Prevent integer underflow in debug
 info size calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805212704.267779-4-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
 <20260805212704.267779-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:46:21 +0000
Message-Id: <20260805214622.3FB9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Cross-endian byte-swapping in `jit_get_next_entry()` lacks bounds =
checks for specific record types and incorrectly indexes variable-sized str=
uctures, causing out-of-bounds memory corruption.
- [High] Missing size validation for `JIT_CODE_MOVE` records allows uniniti=
alized heap memory to be read and injected into synthesized perf events.
- [High] Missing validation of attacker-controlled sizes in `jit_repipe_unw=
inding_info` allows a massive out-of-bounds heap read when generating ELF f=
iles.
- [High] Missing NUL-termination check for the 'sym' string in `jit_repipe_=
code_load` allows an out-of-bounds read and heap info leak.
- [Medium] `jit_process_dump()` silently ignores parser errors and continue=
s processing, which can hide corruption and cause downstream semantic bugs.
- [Medium] Buffers `jd->debug_data` and `jd->unwinding_data` are leaked dur=
ing `jit_process` teardown and when record metadata contains zero-counts.
- [Medium] Calling `funlockfile()` on `jd->in` in the `jit_open()` error pa=
th before successfully locking it invokes undefined behavior.
--

--- Patch [3]: [PATCH 03/12] perf jitdump: Prevent integer underflow in deb=
ug info size calculation ---
commit c2cf5f4eefed4933a21b8a0b0ee0587c371dd92d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Prevent integer underflow in debug info size calculation

Prevent integer underflow by checking if total_size covers the fixed header
size in jit_repipe_debug_info and jit_repipe_unwinding_info.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 3195f94187164..787f8a03dae87 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -669,6 +669,10 @@ static int jit_repipe_debug_info(struct jit_buf_desc=
 *jd, union jr_entry *jr)
>  	if (!(jd && jr))
>  		return -1;
> =20
> +	/* total_size must cover at least the fixed header */
> +	if (jr->prefix.total_size < sizeof(jr->info))
> +		return -1;
> +
>  	sz  =3D jr->prefix.total_size - sizeof(jr->info);
>  	data =3D malloc(sz);
>  	if (!data)
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
This is a pre-existing issue, but could we also validate the unwinding sizes
extracted here?

In jit_repipe_unwinding_info():

    jd->eh_frame_hdr_size =3D jr->unwinding.eh_frame_hdr_size;
    jd->unwinding_size =3D jr->unwinding.unwinding_size;

These sizes are extracted without validation against the allocated payload =
size.

Later, in jit_add_eh_frame_info() in tools/perf/util/genelf.c:

    uint64_t unwinding_table_size =3D unwinding_size - unwinding_header_siz=
e;
    ...
    d->d_size =3D unwinding_table_size;

Could this unvalidated unwinding_size allow libelf to read out-of-bounds he=
ap
memory and embed it in the generated ELF file?


[Severity: High]
This is a pre-existing issue, but does cross-endian byte-swapping in
jit_get_next_entry() lack bounds checks for specific record types?

tools/perf/util/jitdump.c:jit_get_next_entry() {
    ...
    for (n =3D 0 ; n < jr->info.nr_entry; n++) {
        jr->info.entries[n].addr    =3D bswap_64(jr->info.entries[n].addr);
    ...
}

Because struct debug_entry contains a flexible array member (const char nam=
e[]),
doesn't standard array[n] indexing calculate the wrong offsets (skipping ex=
actly
16 bytes and ignoring the string payload)?

Could this cause bswap_64 and bswap_32 to read from and write to unintended
out-of-bounds memory locations, especially since nr_entry itself is never
validated against the payload size?


[Severity: High]
This isn't a bug introduced by this patch, but does jit_repipe_code_move()
miss size validation for JIT_CODE_MOVE records?

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
    event->mmap2.start =3D jr->move.new_code_addr;
    event->mmap2.len   =3D usize ? ALIGN_8(jr->move.code_size) + usize
                               : jr->move.code_size;
    event->mmap2.pid   =3D pid;
    ...
}

If a truncated JIT_CODE_MOVE record is processed where total_size is smaller
than sizeof(struct jr_code_move), jit_get_next_entry() only reads total_size
bytes.

Does this unconditionally access uninitialized heap memory and inject it in=
to
synthesized perf events?


[Severity: Medium]
This is a pre-existing issue, but does jit_process_dump() silently ignore
parser errors?

tools/perf/util/jitdump.c:jit_process_dump() {
    ...
    while ((jr =3D jit_get_next_entry(jd))) {
        switch(jr->prefix.id) {
        case JIT_CODE_LOAD:
            ret =3D jit_repipe_code_load(jd, jr);
    ...
}

If a handler like jit_repipe_debug_info returns -1, the return value is
assigned to ret, but the while loop does not break.

Could this continue processing subsequent records, overwriting ret, and
silently hide the corruption?


[Severity: Medium]
This isn't a bug introduced by this patch, but does jit_process() leak
jd->debug_data and jd->unwinding_data during teardown?

tools/perf/util/jitdump.c:jit_process() {
    ...
    nsinfo__put(jd.nsi);
    free(jd.buf);
    return ret;
}

These buffers are dynamically allocated during parsing. If the JIT dump tra=
ce
ends immediately after a debug or unwinding record, or if parsing aborts, t=
he
stack-allocated jd context is destroyed without freeing these buffers.

Additionally, in jit_repipe_code_load():

    if (jd->debug_data && jd->nr_debug_entries) {
        zfree(&jd->debug_data);

Is it possible to skip zfree if jd->nr_debug_entries =3D=3D 0, leaking the =
active
allocation?


[Severity: Medium]
This is a pre-existing issue, but does jit_open() invoke undefined behavior=
 on
the error path?

tools/perf/util/jitdump.c:jit_open() {
    ...
error:
    free(buf);
    funlockfile(jd->in);
    fclose(jd->in);
}

If the initial metadata buffer allocation fails, the code jumps to the error
label and calls funlockfile(jd->in).

Since the lock was never acquired with flockfile() prior to this point, doe=
sn't
unlocking a file descriptor that is not locked by the thread invoke undefin=
ed
behavior?


[Severity: High]
This isn't a bug introduced by this patch, but is there a missing
NUL-termination check for the sym string in jit_repipe_code_load()?

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
    sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));
    code  =3D (unsigned long)jr + jr->load.p.total_size - csize;
    ...
}

A JIT_CODE_LOAD record sets code_size =3D=3D total_size - sizeof(jr->load).=
 The
sym string pointer is calculated to point to the end of the struct, which
directly overlaps with the raw code blob.

Later, in jit_write_elf() in tools/perf/util/genelf.c:

    symlen =3D 2 + strlen(sym);
    strsym =3D calloc(1, symlen);
    ...
    strcpy(strsym + 1, sym);

If the string is not validated to be NUL-terminated within bounds, could
strlen(sym) read past the jd->buf allocation and copy out-of-bounds heap
memory into the ELF string table?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805212704.2677=
79-1-acme@kernel.org?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050F3E316B
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785967224; cv=none; b=aKRHfwoJWVrUtpgj4OhQE1wcRJ5z/CRBy44cRYD9PQLDGhaLXjgGS/p62az8PkPHqGqIvnzAl/fijzRMAeM33EgeiXqoiYb1BmT3bf625N3zAlEmryRRFmAmB4BY9wPayvjp5321FzPnAZCvkeoccdkRO59H2xRj1qbdRqpz5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785967224; c=relaxed/simple;
	bh=SvFiXHy+AQDksGnapRDf6uKF38MxV8BoNV3I7XnvtMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DOOf7DLLhO4IcZcj9TKiMYhD5//ZrTqDARrmQD3fxwTS0/uYLSXlSt7UOEU6yvRaEVHctU10QZmgYhx9DOcZwrfKmcNKOLBGQ/cvLb/wl58Q5AwgWKj5QxJYPCUm2NncSYUeEWWEXDrLLJ3E+/aNUxzosun4FJWXu+1MqlsuXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpsYBnF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpsYBnF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35991F00A3A;
	Wed,  5 Aug 2026 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785967222;
	bh=RRPOIU7aWlFkqNZN0Cn7dBE2zALcCx2dZpO4UNMDwQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mpsYBnF4Ca/t/95udr1EE4BcsE+sEI5aegVqaijeSVN6BnyYktRnxmcpTUFuY66sK
	 Voq8NMeEfNqTV0ALCFqfO93dQ4A7RZpT/Ro98GbgGYS+sT5iHxqA+qwmkDXege0MaO
	 +Ve/1d5XF4CBwnpdt3wfA+KNRkU8apvA7JO1RYNPAlF/49kwAgMHdS0X9e3HHB1iL/
	 iAGQaN19Evq8O8sCIa8qQlciKztvSwsCHsVScO0Pj8Pq2cPdFgY/99m3KDkOUQiJi3
	 G8zyLp8EElDZ/ipUj5BJJfihlnMUiQuQoreY8h8o0WCTqk82h9p/eudzSCyU8qciWz
	 FDQ1aPSAshySQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] perf jitdump: Validate debug entries on native
 (non-swap) path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805212704.267779-11-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
 <20260805212704.267779-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 22:00:22 +0000
Message-Id: <20260805220022.C35991F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NUL-termination validation for the symbol string in JIT_CO=
DE_LOAD records causes out-of-bounds reads via strlen().
- [High] In `jit_repipe_unwinding_info()`, missing validation of `unwinding=
_size` and `eh_frame_hdr_size` causes an integer underflow and massive out-=
of-bounds read.
- [Medium] Dereferencing fields of `struct debug_entry` causes undefined be=
havior and SIGBUS on strict-alignment architectures.
- [Medium] Failing to allocate memory in `jit_repipe_debug_info` causes the=
 next `JIT_CODE_LOAD` to inherit stale debug info.
- [Medium] In `jit_repipe_code_move()`, the synthetic MMAP2 event allocatio=
n hardcodes a +16 byte hack for the sample ID header, causing an out-of-bou=
nds heap read.
--

--- Patch [10]: [PATCH 10/12] perf jitdump: Validate debug entries on nativ=
e (non-swap) path ---
commit 6e2ff5c2d1b7c024e8a5cacbadffafaf75094372
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf jitdump: Validate debug entries on native (non-swap) path

The bounds-checking and nr_entry clamping added for the byte-swap path
only runs when jd->needs_bswap is true.  On native-endian files, nr_entry
passes through unvalidated to jit_repipe_debug_info(), which stores it
as jd->nr_debug_entries.  Downstream, jit_process_debug_info() in
genelf_debug.c iterates nr_debug_entries times via debug_entry_next(),
which calls strlen() on each entry's name field =E2=80=94 a crafted nr_entry
causes OOB reads and writes.

Add bounds-checked iteration in jit_repipe_debug_info() that validates
each debug_entry fits in the payload and its name is NUL-terminated
before calling debug_entry_next().  Clamp nr_debug_entries to the count
of valid entries.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index d3de307532d55..5a3ea2681fb37 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -694,8 +694,10 @@ static int jit_repipe_code_move(struct jit_buf_desc =
*jd, union jr_entry *jr)

[Severity: Medium]
This is a pre-existing issue, but in jit_repipe_code_move(), the synthetic
MMAP2 event allocation hardcodes a +16 byte hack for the sample ID header:

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
    event =3D calloc(1, sizeof(*event) + 16);
    ...
}

The sample ID header size (idr_size) can be up to 48 or 64 bytes depending
on the perf record configuration.

If the JIT path length is very long, the clamped size pushes
event->mmap2.header.size to exceed the allocated buffer size.

When jit_inject_event() writes the event out:

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
    ret =3D jit_inject_event(jd, event);
    ...
}

Could this read past the allocated heap block and leak uninitialized heap m=
emory
into perf.data?

> =20
>  static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry=
 *jr)
>  {
> -	void *data;
> -	size_t sz;
> +	struct debug_entry *ent;
> +	void *data, *end;
> +	size_t sz, valid;
> +	uint64_t i;
> =20
>  	if (!(jd && jr))
>  		return -1;

[Severity: Medium]
This is a pre-existing issue, but if malloc() fails in jit_repipe_debug_inf=
o():

tools/perf/util/jitdump.c:jit_repipe_debug_info() {
    ...
    data =3D malloc(sz);
    if (!data)
        return -1;
    ...
}

The function returns early without clearing the previously allocated
jd->debug_data.

Since the caller jit_process_dump() ignores this error, will the next
JIT_CODE_LOAD erroneously use the leftover stale debug_data and attach
it to the new code?

> @@ -715,10 +717,25 @@ static int jit_repipe_debug_info(struct jit_buf_des=
c *jd, union jr_entry *jr)
>  	jd->debug_data       =3D data;
> =20
>  	/*
> -	 * we must use nr_entry instead of size here because
> -	 * we cannot distinguish actual entry from padding otherwise
> +	 * Clamp nr_debug_entries to entries that actually fit in the
> +	 * payload.  The byte-swap path already does this for cross-endian
> +	 * files; validate on the native path too, since downstream
> +	 * jit_process_debug_info() iterates via debug_entry_next() which
> +	 * calls strlen() on each entry's name field.
>  	 */
> -	jd->nr_debug_entries =3D jr->info.nr_entry;
> +	end =3D data + sz;
> +	ent =3D data;
> +	valid =3D 0;
> +	for (i =3D 0; i < jr->info.nr_entry; i++) {
> +		if ((void *)ent + sizeof(*ent) > end)
> +			break;
> +		/* name must be NUL-terminated within the payload */
> +		if (!memchr(ent->name, '\0', (char *)end - ent->name))
> +			break;
> +		ent =3D debug_entry_next(ent);

[Severity: Medium]
This is a pre-existing issue, but debug_entry_next() advances the pointer
without guaranteeing 8-byte alignment.

Later, when unaligned ent pointers are dereferenced to read the uint64_t ad=
dr
field, either in the byte-swap path:

tools/perf/util/jitdump.c:jit_get_next_entry() {
    ...
    ent->addr =3D bswap_64(ent->addr);
    ...
}

or downstream during iteration:

tools/perf/util/genelf_debug.c:jit_process_debug_info() {
    ...
    ent =3D debug_entry_next(ent);
    ...
}

Will this cause undefined behavior and a SIGBUS crash on architectures that
enforce strict alignment, like SPARC?

> +		valid++;
> +	}
> +	jd->nr_debug_entries =3D valid;
> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while processing JIT_CODE_LO=
AD
records, jit_repipe_code_load() extracts the sym pointer from the payload:

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
    sym =3D (void *)((unsigned long)jr + sizeof(jr->load));
    ...
}

This extraction happens without verifying that it is NUL-terminated within =
the
bounds of the available buffer size.

Later, when jit_write_elf() computes the symbol length:

tools/perf/util/genelf.c:jit_write_elf() {
    ...
    symlen =3D 2 + strlen(sym);
    ...
}

Might this lead to an out-of-bounds read via strlen() if a malformed record
omits the NUL byte?

[Severity: High]
This is a pre-existing issue, but in jit_repipe_unwinding_info(), untrusted
size fields are copied without validation:

tools/perf/util/jitdump.c:jit_repipe_unwinding_info() {
    ...
    jd->eh_frame_hdr_size =3D jr->unwinding.eh_frame_hdr_size;
    jd->unwinding_size =3D jr->unwinding.unwinding_size;
    ...
}

If unwinding_header_size is greater than unwinding_size, will the calculati=
on
in jit_add_eh_frame_info() underflow?

tools/perf/util/genelf.c:jit_add_eh_frame_info() {
    ...
    uint64_t unwinding_table_size =3D unwinding_size - unwinding_header_siz=
e;
    ...
}

Can this underflow result in a massive out-of-bounds read when the huge size
is subsequently passed to libelf for the section buffer size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805212704.2677=
79-1-acme@kernel.org?part=3D10

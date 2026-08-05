Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDD3EC6B2
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966163; cv=none; b=IWv/z//SOv5ZP83Zz8X+RxsIloXvDwjUrQbPIqaZAeWCpjZdTm13tlOq2y4oYZWskB5uok4L9cEJfFRAPC3Nexim7o3XESQRFep2j6uB0Zr5fBquyaHgSAk6gQljkc9Iu8GFYON/rA9Nu+fN+ErBBJ5Z89HC+3aHnSaZmudjdzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966163; c=relaxed/simple;
	bh=flhkSWssRQ3cC7P6LKQ1G/Uw/tcYZ8lPFU1vOyzQWII=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PSrXY5VuBGQV6datewdVbdc1ABkywIKj0qUYr2pVV4YMYuKjhm763w/2U2jCRz0m4zbjVNv97mIY7g8UTzkRU2/1M+OCxKRMC1TUqQiA6OU6ple0XRsnNN/Z7reG2mpc6XW+aBf/wguZZqcjFnCpNErHIGuSkEv3pQxSau7mwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk7gr7UI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk7gr7UI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15EA1F000E9;
	Wed,  5 Aug 2026 21:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785966161;
	bh=1HOP3x7nUTUZFcOvKGPxiHJiM1fJT/vzOkHIQrNyaIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fk7gr7UIA7uyAk7IPWm05yC9kOYvx4mOtZoQUvFQElujXFoXMwq2jnT8BexwjJAFM
	 IQ5hDadhE6korFKIBaZ3c88N60CFsZeYvbErJHkvrcK+019YdaYV7ug+Rjz09nDo5m
	 2tveusDBdGRHecodp6q5GGjzHmgCccFhinVEt2OKGLblLfoB6cNL96OAiExkOUzApk
	 Zbsn1UoaBMJ5gRfPr5si2HyajWxl4NvoWw5EvR29F8GneNvPRDUkhyXSmRzFDCMy+r
	 vHoeWFs9oxIjbw7W1g3okwdRlOjsuX215dOsMTC+xL/M82NCxuR4m6ob86+6vvSFpC
	 HhNn8f3xRXxpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] perf jitdump: Validate code_size against
 total_size in code load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805212704.267779-3-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
 <20260805212704.267779-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:42:41 +0000
Message-Id: <20260805214241.A15EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:

New issues:
- [Medium] jd->debug_data and jd->unwinding_data are leaked on the new vali=
dation failure path.

Pre-existing issues:
- [High] Integer underflow when calculating unwinding_data_size in jit_repi=
pe_unwinding_info leads to a massive heap allocation and out-of-bounds read.
- [High] Missing snprintf truncation clamping in jit_repipe_code_move and j=
it_repipe_code_load leads to an undersized event allocation calculation and=
 out-of-bounds heap write.
- [High] jit_get_next_entry iterates over an unvalidated nr_entry array usi=
ng fixed-size indexing for a variable-length structure, leading to out-of-b=
ounds byte-swapping.
- [High] The parser lacks total_size boundary checks for JIT_CODE_MOVE, lea=
ding to uninitialized heap reads.
- [High] Lack of validation between buffer size and nr_entry leads to heap =
OOB read and write in debug info parsing.
- [Medium] The perf_event allocated via calloc is unconditionally leaked in=
 jit_repipe_code_move.
- [Medium] Multiple memory leaks of dynamically allocated buffers in the ji=
tdump parser, including missing cleanup in jit_close and overwrites in debu=
g info.
- [Medium] The ALIGN_8 macro evaluates using signed arithmetic, causing int=
eger wrap and massive length corruption for mmap2 events.
- [Medium] Truncation of 64-bit unwinding_mapped_size to 32-bit int can cor=
rupt mmap2 event length.
--

--- Patch [2]: [PATCH 02/12] perf jitdump: Validate code_size against total=
_size in code load ---
commit 97b091976e049b90397f99d555b22a4934abb49d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Validate code_size against total_size in code load

This commit introduces validation checks to ensure that the code_size
does not exceed the available size in the JIT load record. It adds bounds
checking to prevent out-of-bounds heap reads when calculating the code
blob pointer.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 4b7c7ba7cd95d..3195f94187164 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -9,6 +9,7 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <inttypes.h>
> +#include <limits.h>
>  #include <byteswap.h>
>  #include <sys/stat.h>
>  #include <sys/mman.h>
> @@ -450,6 +451,16 @@ static int jit_repipe_code_load(struct jit_buf_desc =
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

[Severity: Medium]
Does this early return skip freeing the buffered debug and unwinding data?

Later in the function, these dynamically allocated buffers are freed:

    if (jd->debug_data && jd->nr_debug_entries) {
            zfree(&jd->debug_data);
            jd->nr_debug_entries =3D 0;
    }

    if (jd->unwinding_data && jd->eh_frame_hdr_size) {
            zfree(&jd->unwinding_data);
            ...

If the code returns -1 here, do jd->debug_data and jd->unwinding_data remain
allocated, permanently leaking since jit_close() does not appear to clean t=
hem
up?

> +	}
> +
>  	sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));
>  	code  =3D (unsigned long)jr + jr->load.p.total_size - csize;
>  	count =3D jr->load.code_index;

[ ... ]

Other findings in this file:

[Severity: High]
This is a pre-existing issue, but does integer underflow occur when calcula=
ting
unwinding_data_size in jit_repipe_unwinding_info()?

tools/perf/util/jitdump.c:jit_repipe_unwinding_info() {
    ...
    unwinding_data_size  =3D jr->prefix.total_size - sizeof(jr->unwinding);
    unwinding_data =3D malloc(unwinding_data_size);
    memcpy(unwinding_data, &jr->unwinding.unwinding_data, unwinding_data_si=
ze);
    ...
}

If total_size is smaller than sizeof(jr->unwinding), does the unsigned 32-b=
it
subtraction underflow to a massive value, causing malloc to allocate too mu=
ch
memory and memcpy to perform an out-of-bounds read?


[Severity: Medium]
This is a pre-existing issue, but is the perf_event leaked in
jit_repipe_code_move()?

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
    event =3D calloc(1, sizeof(*event) + 16);
    if (!event)
        return -1;
    ...
    return ret;
}

The event pointer is allocated via calloc but is never freed on the success
or error return paths. Does this gradually exhaust memory when parsing large
dumps?


[Severity: High]
This is a pre-existing issue, but does missing snprintf truncation clamping
lead to out-of-bounds heap writes?

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
    size =3D snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so", ..=
.);
    size++; /* for \0 */
    event->mmap2.header.size =3D (sizeof(event->mmap2) - (sizeof(event->mma=
p2.filename) - size) + idr_size);
    ...
}

When generating the filename, snprintf returns the length that would have
been written. If this exceeds PATH_MAX, does the returned size wrap in the
unsigned arithmetic for header.size, underflowing it and pushing the traili=
ng
id pointer out of the allocated event buffer bounds?


[Severity: Medium]
This is a pre-existing issue, but are dynamic buffers repeatedly leaked in
jit_repipe_debug_info() and jit_close()?

tools/perf/util/jitdump.c:jit_repipe_debug_info() {
    ...
    data =3D malloc(sz);
    /* ... */
    jd->debug_data       =3D data;
    ...
}

Repeated JIT_CODE_DEBUG_INFO records will malloc a new buffer and overwrite
jd->debug_data without freeing the old one. Additionally, jit_close() frees
the jd struct resources but does not seem to clean up internal heap buffers
like debug_data and unwinding_data. Does this leave them un-freed
indefinitely?


[Severity: High]
This is a pre-existing issue, but does standard array indexing on a variable
length struct cause memory corruption during bswap?

tools/perf/util/jitdump.c:jit_get_next_entry() {
    ...
    for (n =3D 0 ; n < jr->info.nr_entry; n++) {
        jr->info.entries[n].addr    =3D bswap_64(jr->info.entries[n].addr);
    ...
}

In cross-endian mode, this iterates over an unvalidated nr_entry array using
fixed-size indexing. Since debug_entry includes a variable-length name[]
string inline, doesn't fixed-size array indexing read from and byte-swap
completely incorrect offsets?


[Severity: High]
This is a pre-existing issue, but does jit_repipe_code_move() lack boundary
checks for the JIT_CODE_MOVE total_size?

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
    event->mmap2.start =3D jr->move.new_code_addr;
    event->mmap2.len   =3D usize ? ALIGN_8(jr->move.code_size) + usize : jr=
->move.code_size;
    ...
}

Unlike the new validation added to JIT_CODE_LOAD in this patch,
jit_repipe_code_move() lacks a check confirming that total_size is greater
than or equal to sizeof(jr->move). Can malformed records cause the parser
to read uninitialized heap or stale data from jd->buf into perf.data?


[Severity: Medium]
This is a pre-existing issue, but does the ALIGN_8 macro silently overflow
into a negative value?

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
    int ret, csize, usize;
    /* ... */
    event->mmap2.len   =3D usize ? ALIGN_8(csize) + usize : csize;
    ...
}

Since csize is typed as a signed int, does calculating ALIGN_8(csize) with a
value near INT_MAX trigger signed integer overflow to a negative value, whi=
ch
is then sign-extended into a corrupted uint64_t length?


[Severity: Medium]
This is a pre-existing issue, but can the truncation of unwinding_mapped_si=
ze
corrupt the mmap2 event length?

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
    int usize;
    /* ... */
    usize =3D jd->unwinding_mapped_size;
    /* ... */
    event->mmap2.len   =3D usize ? ALIGN_8(jr->move.code_size) + usize : jr=
->move.code_size;
    ...
}

The 64-bit jd->unwinding_mapped_size is truncated to a 32-bit signed integer
(usize). Could a maliciously crafted mapped_size result in a negative or
truncated value, corrupting the final event->mmap2.len?


[Severity: High]
This is a pre-existing issue, but does the lack of validation between buffer
size and nr_entry lead to heap out-of-bounds reads and writes?

tools/perf/util/jitdump.c:jit_repipe_debug_info() {
    ...
    jd->nr_debug_entries =3D jr->info.nr_entry;
    ...
}

The parser sets jd->nr_debug_entries from the unvalidated nr_entry file fie=
ld
without confirming the allocated sz bytes can accommodate them. When
jit_process_debug_info() loops nr_entry times calling strlen on heap data,
does this result in out-of-bounds heap writes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805212704.2677=
79-1-acme@kernel.org?part=3D2

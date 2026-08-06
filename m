Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060A224234;
	Thu,  6 Aug 2026 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019430; cv=none; b=lXGOBD/f6qYvltvRLQ6RZX/HSch5FIM2rcrmfJE+r8b5pxzfTNTk0j0O9zorWOsrxkchYL1yF5pfs2goHN/KUIOvcLp9mfo8Sz5bTN2aN2Hl7HDFO56/I0o2RMWb74HDEUL2hrfVYliwtb1WQ4HkAfiJDL1qLvCoXI0RcwmeHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019430; c=relaxed/simple;
	bh=k6xV0D7BSTpA6MwV87JmXPrdu0v7DNelQ3HMIoSVXAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9Mvn9BgkhHQNaPuV5tz92J0+vV3Oux+Q16/X70mMhndRzrzGEcaWFtDEngN3XmfWJ2pSrh5JvVbbLBCN5W8/2M/N02YFCMj001xpRntc6MmoBQjfjWaS85+sobBG8Vii5cgPU60rI4nqJ8EqnJt4KR5cMErU2dq1Iy/QI1dGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNZ1r82R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNZ1r82R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3B91F000E9;
	Thu,  6 Aug 2026 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019428;
	bh=b+VdRZXz0Mlzd/Fxvme7CV96v0QV8RQACj3fa8nalDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BNZ1r82RHEVXsILv6fUNHhc2SdSUzx5KvIuczd36kHST8Zi4WaLATRIn1/5asWT//
	 puaKDLrHpXk2xqnkJtLHIEivI34aM1edlqJW/rY9bLT+Jvj07bzSHnOsR3L4lDAH3K
	 1DMXo4dn3iYeSwjMSmj1H+boA4U10xNbIFiVVU95BTN6imjndTcl3vjLCc/px5WePR
	 bYLWPNHdHs5M6Nxx1nJY+6cEinJO+q7cT+Ytm/4foh6DU6wfXt7aaGYatRKJ5tG2KS
	 RpoXUdwWmq5w2ynW/CYAf++y0Cg7uXdxDmIQ1knELMcOwzEVYgY81mE6e0w2RJJh8g
	 YoMBW1ZzD7gEw==
Date: Thu, 6 Aug 2026 09:30:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 02/12] perf jitdump: Validate code_size against
 total_size in code load
Message-ID: <anR-XwEFkI-P7UzZ@x1>
References: <20260805212704.267779-1-acme@kernel.org>
 <20260805212704.267779-3-acme@kernel.org>
 <20260805214241.A15EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805214241.A15EA1F000E9@smtp.kernel.org>

On Wed, Aug 05, 2026 at 09:42:41PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential issue(s) to consider:
> 
> New issues:
> - [Medium] jd->debug_data and jd->unwinding_data are leaked on the new validation failure path.

This is fixed in a later patch in this series, I'll reorder the series
so that this leak doesn't gets introduced to then be fixed in another
patch.

All the pre-existing issues reported are being tracked in TODO files for
upcoming series, one is already in the making.

Thanks,

- Arnaldo
 
> Pre-existing issues:
> - [High] Integer underflow when calculating unwinding_data_size in jit_repipe_unwinding_info leads to a massive heap allocation and out-of-bounds read.
> - [High] Missing snprintf truncation clamping in jit_repipe_code_move and jit_repipe_code_load leads to an undersized event allocation calculation and out-of-bounds heap write.
> - [High] jit_get_next_entry iterates over an unvalidated nr_entry array using fixed-size indexing for a variable-length structure, leading to out-of-bounds byte-swapping.
> - [High] The parser lacks total_size boundary checks for JIT_CODE_MOVE, leading to uninitialized heap reads.
> - [High] Lack of validation between buffer size and nr_entry leads to heap OOB read and write in debug info parsing.
> - [Medium] The perf_event allocated via calloc is unconditionally leaked in jit_repipe_code_move.
> - [Medium] Multiple memory leaks of dynamically allocated buffers in the jitdump parser, including missing cleanup in jit_close and overwrites in debug info.
> - [Medium] The ALIGN_8 macro evaluates using signed arithmetic, causing integer wrap and massive length corruption for mmap2 events.
> - [Medium] Truncation of 64-bit unwinding_mapped_size to 32-bit int can corrupt mmap2 event length.
> --
> 
> --- Patch [2]: [PATCH 02/12] perf jitdump: Validate code_size against total_size in code load ---
> commit 97b091976e049b90397f99d555b22a4934abb49d
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf jitdump: Validate code_size against total_size in code load
> 
> This commit introduces validation checks to ensure that the code_size
> does not exceed the available size in the JIT load record. It adds bounds
> checking to prevent out-of-bounds heap reads when calculating the code
> blob pointer.
> 
> > diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> > index 4b7c7ba7cd95d..3195f94187164 100644
> > --- a/tools/perf/util/jitdump.c
> > +++ b/tools/perf/util/jitdump.c
> > @@ -9,6 +9,7 @@
> >  #include <fcntl.h>
> >  #include <unistd.h>
> >  #include <inttypes.h>
> > +#include <limits.h>
> >  #include <byteswap.h>
> >  #include <sys/stat.h>
> >  #include <sys/mman.h>
> > @@ -450,6 +451,16 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
> >  	csize = jr->load.code_size;
> >  	usize = jd->unwinding_mapped_size;
> >  	addr  = jr->load.code_addr;
> > +
> > +	/* code blob lives at the end of the record, validate it fits */
> > +	if (jr->load.p.total_size < sizeof(jr->load) ||
> > +	    jr->load.code_size > jr->load.p.total_size - sizeof(jr->load) ||
> > +	    jr->load.code_size > INT_MAX) {
> > +		pr_warning("jitdump: invalid code_size %" PRIu64 " (total_size=%u) in code_load record\n",
> > +			   (uint64_t)jr->load.code_size, jr->load.p.total_size);
> > +		return -1;
> 
> [Severity: Medium]
> Does this early return skip freeing the buffered debug and unwinding data?
> 
> Later in the function, these dynamically allocated buffers are freed:
> 
>     if (jd->debug_data && jd->nr_debug_entries) {
>             zfree(&jd->debug_data);
>             jd->nr_debug_entries = 0;
>     }
> 
>     if (jd->unwinding_data && jd->eh_frame_hdr_size) {
>             zfree(&jd->unwinding_data);
>             ...
> 
> If the code returns -1 here, do jd->debug_data and jd->unwinding_data remain
> allocated, permanently leaking since jit_close() does not appear to clean them
> up?
> 
> > +	}
> > +
> >  	sym   = (void *)((unsigned long)jr + sizeof(jr->load));
> >  	code  = (unsigned long)jr + jr->load.p.total_size - csize;
> >  	count = jr->load.code_index;
> 
> [ ... ]
> 
> Other findings in this file:
> 
> [Severity: High]
> This is a pre-existing issue, but does integer underflow occur when calculating
> unwinding_data_size in jit_repipe_unwinding_info()?
> 
> tools/perf/util/jitdump.c:jit_repipe_unwinding_info() {
>     ...
>     unwinding_data_size  = jr->prefix.total_size - sizeof(jr->unwinding);
>     unwinding_data = malloc(unwinding_data_size);
>     memcpy(unwinding_data, &jr->unwinding.unwinding_data, unwinding_data_size);
>     ...
> }
> 
> If total_size is smaller than sizeof(jr->unwinding), does the unsigned 32-bit
> subtraction underflow to a massive value, causing malloc to allocate too much
> memory and memcpy to perform an out-of-bounds read?
> 
> 
> [Severity: Medium]
> This is a pre-existing issue, but is the perf_event leaked in
> jit_repipe_code_move()?
> 
> tools/perf/util/jitdump.c:jit_repipe_code_move() {
>     ...
>     event = calloc(1, sizeof(*event) + 16);
>     if (!event)
>         return -1;
>     ...
>     return ret;
> }
> 
> The event pointer is allocated via calloc but is never freed on the success
> or error return paths. Does this gradually exhaust memory when parsing large
> dumps?
> 
> 
> [Severity: High]
> This is a pre-existing issue, but does missing snprintf truncation clamping
> lead to out-of-bounds heap writes?
> 
> tools/perf/util/jitdump.c:jit_repipe_code_move() {
>     ...
>     size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so", ...);
>     size++; /* for \0 */
>     event->mmap2.header.size = (sizeof(event->mmap2) - (sizeof(event->mmap2.filename) - size) + idr_size);
>     ...
> }
> 
> When generating the filename, snprintf returns the length that would have
> been written. If this exceeds PATH_MAX, does the returned size wrap in the
> unsigned arithmetic for header.size, underflowing it and pushing the trailing
> id pointer out of the allocated event buffer bounds?
> 
> 
> [Severity: Medium]
> This is a pre-existing issue, but are dynamic buffers repeatedly leaked in
> jit_repipe_debug_info() and jit_close()?
> 
> tools/perf/util/jitdump.c:jit_repipe_debug_info() {
>     ...
>     data = malloc(sz);
>     /* ... */
>     jd->debug_data       = data;
>     ...
> }
> 
> Repeated JIT_CODE_DEBUG_INFO records will malloc a new buffer and overwrite
> jd->debug_data without freeing the old one. Additionally, jit_close() frees
> the jd struct resources but does not seem to clean up internal heap buffers
> like debug_data and unwinding_data. Does this leave them un-freed
> indefinitely?
> 
> 
> [Severity: High]
> This is a pre-existing issue, but does standard array indexing on a variable
> length struct cause memory corruption during bswap?
> 
> tools/perf/util/jitdump.c:jit_get_next_entry() {
>     ...
>     for (n = 0 ; n < jr->info.nr_entry; n++) {
>         jr->info.entries[n].addr    = bswap_64(jr->info.entries[n].addr);
>     ...
> }
> 
> In cross-endian mode, this iterates over an unvalidated nr_entry array using
> fixed-size indexing. Since debug_entry includes a variable-length name[]
> string inline, doesn't fixed-size array indexing read from and byte-swap
> completely incorrect offsets?
> 
> 
> [Severity: High]
> This is a pre-existing issue, but does jit_repipe_code_move() lack boundary
> checks for the JIT_CODE_MOVE total_size?
> 
> tools/perf/util/jitdump.c:jit_repipe_code_move() {
>     ...
>     event->mmap2.start = jr->move.new_code_addr;
>     event->mmap2.len   = usize ? ALIGN_8(jr->move.code_size) + usize : jr->move.code_size;
>     ...
> }
> 
> Unlike the new validation added to JIT_CODE_LOAD in this patch,
> jit_repipe_code_move() lacks a check confirming that total_size is greater
> than or equal to sizeof(jr->move). Can malformed records cause the parser
> to read uninitialized heap or stale data from jd->buf into perf.data?
> 
> 
> [Severity: Medium]
> This is a pre-existing issue, but does the ALIGN_8 macro silently overflow
> into a negative value?
> 
> tools/perf/util/jitdump.c:jit_repipe_code_load() {
>     ...
>     int ret, csize, usize;
>     /* ... */
>     event->mmap2.len   = usize ? ALIGN_8(csize) + usize : csize;
>     ...
> }
> 
> Since csize is typed as a signed int, does calculating ALIGN_8(csize) with a
> value near INT_MAX trigger signed integer overflow to a negative value, which
> is then sign-extended into a corrupted uint64_t length?
> 
> 
> [Severity: Medium]
> This is a pre-existing issue, but can the truncation of unwinding_mapped_size
> corrupt the mmap2 event length?
> 
> tools/perf/util/jitdump.c:jit_repipe_code_move() {
>     ...
>     int usize;
>     /* ... */
>     usize = jd->unwinding_mapped_size;
>     /* ... */
>     event->mmap2.len   = usize ? ALIGN_8(jr->move.code_size) + usize : jr->move.code_size;
>     ...
> }
> 
> The 64-bit jd->unwinding_mapped_size is truncated to a 32-bit signed integer
> (usize). Could a maliciously crafted mapped_size result in a negative or
> truncated value, corrupting the final event->mmap2.len?
> 
> 
> [Severity: High]
> This is a pre-existing issue, but does the lack of validation between buffer
> size and nr_entry lead to heap out-of-bounds reads and writes?
> 
> tools/perf/util/jitdump.c:jit_repipe_debug_info() {
>     ...
>     jd->nr_debug_entries = jr->info.nr_entry;
>     ...
> }
> 
> The parser sets jd->nr_debug_entries from the unvalidated nr_entry file field
> without confirming the allocated sz bytes can accommodate them. When
> jit_process_debug_info() loops nr_entry times calling strlen on heap data,
> does this result in out-of-bounds heap writes?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260805212704.267779-1-acme@kernel.org?part=2

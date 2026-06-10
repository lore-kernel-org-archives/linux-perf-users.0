Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967353BBFC1;
	Wed, 10 Jun 2026 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126132; cv=none; b=PzGSzaYLLRnZV83rP8UGKppfGK7qJWFhAaeDXgFXxMX3YVnhbxNxJ1p65iaIVEYHxRnMEbEYz3znbcYyiwTsI3D4DOKH4o95iPIeVCT7B6CiJhSn1JIPxTU7UGAvq1aP/NOzfsZFVbWIDQh5Mac6pVmU0NZvTV1SFe8TjotP/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126132; c=relaxed/simple;
	bh=uyFoOeDkztxeOhWQIOSvBUBBJ9P8DcYMVvC9TzzoksM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gONiW6fKG3PvelTT4EpJtVD5x0awkub+3oY1spU82P9fgfbRYU9yNHQEYzPmxkTRu+lFYnYr5PKE9+FEWVSIoLo1lstS+SErkOCkaDE0+Kv94RZ/+yBK87yjZVIMbBhtzMGtTCQkpxyNJSzbiBxcyZwg/TVHUvVhgj/xhc6YArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt5vc8BB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt5vc8BB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664B01F0089C;
	Wed, 10 Jun 2026 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781126130;
	bh=eZdnUgWPSfAfQ9vt+3lHMdRpdvzQnO1/6XjsRBGQ1jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xt5vc8BBqbZqXZM+hMo0xg7BD+s6UfInU0TlMREtJ5VPmOrg3dx7JqbBWqaS4hIzf
	 yf6DjMah1ttTqLzQaGytc/raJlf8e0vZ775UAeTQrTXYgEezLpv/dcyqH1DQ9Q0hfB
	 xWhy1rX0nDOJR2zo9xnTepOOfkRndi/+6It/IJQFS9D8ATCZMtSA01IH3E8OTVHQka
	 U/ozbJLAK/hoT8KX5Zdx319bOftN0i3b7UhG8r3HCwJTjR36TpB2uDE63EiUvlDT2A
	 dhKKuoWhPtCze7iidHDbRXIPQWhruoinm7Bfhm5GJeKLtltjgeMgWS5n1W4ZQWPrCC
	 s5codP+N/j1ZQ==
Date: Wed, 10 Jun 2026 18:15:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf jitdump: Fix a build error with ASAN
Message-ID: <ainT7Y11z6zTsrf-@x1>
References: <20260605064932.34316-1-namhyung@kernel.org>
 <20260605070349.E27A41F00893@smtp.kernel.org>
 <aiNaLKTyJWg9sEtb@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiNaLKTyJWg9sEtb@google.com>

On Fri, Jun 05, 2026 at 04:22:20PM -0700, Namhyung Kim wrote:
> On Fri, Jun 05, 2026 at 07:03:49AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 10 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] Unlocking an unlocked stream on the error path causes undefined behavior.
> > - [High] Incorrect logic for skipping extended jitdump headers leads to parsing failure.
> > - [High] Ignoring the return value of `dirname()` breaks directory extraction and causes ENOTDIR failures.
> > - [High] If the generated JIT ELF path exceeds PATH_MAX, snprintf truncation causes size underflow resulting in a heap buffer overflow.
> > - [High] Cross-endian byte swapping of JIT_CODE_DEBUG_INFO records corrupts data by ignoring the flexible array member.
> > - [High] Lack of validation on `code_size` enables arbitrary out-of-bounds read and memory leakage.
> > - [Medium] Memory leak of `debug_data` and `unwinding_data` pointers.
> > - [Medium] Memory leak of `event` in `jit_repipe_code_move`.
> > - [Medium] Ineffective inter-process synchronization using `flockfile`.
> > - [Medium] Integer underflow leading to massive malloc in `jit_repipe_debug_info`.
> 
> I don't plan to touch any of these issues, at least in the near future.

LOL, Sashiko... I'll ask Claude to add these in my TODOs,

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> > --
> > 
> > commit f314399f4edf9366c3ee4d529f45cb2d7e7d454d
> > Author: Namhyung Kim <namhyung@kernel.org>
> > 
> > perf jitdump: Fix a build error with ASAN
> > 
> > This patch resolves a stringop-truncation build error when compiling perf
> > with ASAN on GCC 16. It reduces the strncpy bound by one byte to avoid
> > truncation warnings.
> > 
> > > diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> > > index e0ce8b9047298..16390e7f9062d 100644
> > > --- a/tools/perf/util/jitdump.c
> > > +++ b/tools/perf/util/jitdump.c
> > > @@ -234,7 +234,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
> > >  	/*
> > >  	 * keep dirname for generating files and mmap records
> > >  	 */
> > > -	strncpy(jd->dir, name, PATH_MAX);
> > > +	strncpy(jd->dir, name, PATH_MAX - 1);
> > >  	jd->dir[PATH_MAX - 1] = '\0';
> > >  	dirname(jd->dir);
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but is it correct to ignore the
> > return value of dirname()?
> > 
> > If jd->dir contains no slashes, glibc dirname() returns a pointer to "." but
> > leaves the original string unmodified. Since the return value is discarded,
> > jd->dir retains the full filename instead of becoming ".". This could cause
> > later snprintf calls to use the target file as a directory component, leading
> > to ENOTDIR failures.
> > 
> > >  	free(buf);
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does the error handling path incorrectly
> > unlock an unlocked stream?
> > 
> > If malloc() fails early in jit_open(), it jumps to the error label:
> > 
> > tools/perf/util/jitdump.c:jit_open() {
> >     ...
> > 	buf = malloc(bsz);
> > 	if (!buf)
> > 		goto error;
> > 
> > 	/*
> > 	 * protect from writer modifying the file while we are reading it
> > 	 */
> > 	flockfile(jd->in);
> >     ...
> > error:
> > 	free(buf);
> > 	funlockfile(jd->in);
> > 	fclose(jd->in);
> > 	return retval;
> > }
> > 
> > Since flockfile() is only called after malloc() succeeds, calling funlockfile()
> > here results in undefined behavior on an unlocked stream.
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does this logic break extended header reads?
> > 
> > In jit_open(), when handling extended headers, bsz is updated to bs right
> > before calculating the read size:
> > 
> > tools/perf/util/jitdump.c:jit_open() {
> >     ...
> > 	if (bs > bsz) {
> > 		n = realloc(buf, bs);
> > 		if (!n)
> > 			goto error;
> > 		bsz = bs;
> > 		buf = n;
> > 		/* read extra we do not know about */
> > 		ret = fread(buf, bs - bsz, 1, jd->in);
> > 		if (ret != 1)
> > 			goto error;
> > 	}
> >     ...
> > }
> > 
> > Because bsz = bs, the read size bs - bsz is always 0. fread() will return 0,
> > causing the ret != 1 check to fail and unconditionally jump to the error path.
> > 
> > [Severity: High]
> > This is a pre-existing issue, but could snprintf() truncation cause an
> > out-of-bounds pointer calculation?
> > 
> > In jit_repipe_code_load(), snprintf() calculates a path:
> > 
> > tools/perf/util/jitdump.c:jit_repipe_code_load() {
> >     ...
> > 	filename = event->mmap2.filename;
> > 	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
> > 			jd->dir,
> > 			nspid,
> > 			count);
> > 
> > 	size++; /* for \0 */
> > 
> > 	size = PERF_ALIGN(size, sizeof(u64));
> >     ...
> > 	event->mmap2.header.size = (sizeof(event->mmap2) -
> > 			(sizeof(event->mmap2.filename) - size) + idr_size);
> >     ...
> > 	id = (void *)((unsigned long)event + event->mmap.header.size - idr_size);
> > 	if (jd->sample_type & PERF_SAMPLE_TID) {
> > 		id->pid  = pid;
> >     ...
> > }
> > 
> > If the string exceeds PATH_MAX, snprintf() returns the untruncated length. The
> > expression sizeof(event->mmap2.filename) - size will then underflow because size
> > is greater than PATH_MAX, resulting in a massively inflated header.size. The
> > pointer id will point outside the allocated bounds, leading to heap corruption
> > when id->pid is assigned.
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but does the byte-swapping logic
> > corrupt data by ignoring a flexible array member?
> > 
> > In jit_get_next_entry():
> > 
> > tools/perf/util/jitdump.c:jit_get_next_entry() {
> >     ...
> > 	case JIT_CODE_DEBUG_INFO:
> > 		if (jd->needs_bswap) {
> > 			uint64_t n;
> > 			jr->info.code_addr = bswap_64(jr->info.code_addr);
> > 			jr->info.nr_entry  = bswap_64(jr->info.nr_entry);
> > 			for (n = 0 ; n < jr->info.nr_entry; n++) {
> > 				jr->info.entries[n].addr    = bswap_64(jr->info.entries[n].addr);
> > 				jr->info.entries[n].lineno  = bswap_32(jr->info.entries[n].lineno);
> > 				jr->info.entries[n].discrim = bswap_32(jr->info.entries[n].discrim);
> > 			}
> > 		}
> > 		break;
> >     ...
> > }
> > 
> > struct debug_entry contains a flexible array member (const char name[]). Using
> > array indexing (jr->info.entries[n]) assumes fixed-size elements. This will
> > calculate incorrect offsets that land inside the variable-length strings of
> > earlier entries, overwriting them with byte-swapped data.
> > 
> > [Severity: Medium]
> > This is a pre-existing issue, but do jd->debug_data and jd->unwinding_data leak?
> > 
> > In jit_repipe_debug_info(), memory is allocated and assigned:
> > 
> > tools/perf/util/jitdump.c:jit_repipe_debug_info() {
> >     ...
> > 	data = malloc(sz);
> > 	if (!data)
> > 		return -1;
> > 
> > 	memcpy(data, &jr->info.entries, sz);
> > 
> > 	jd->debug_data       = data;
> >     ...
> > }
> > 
> > While these are freed during jit_repipe_code_load(), if a JIT dump terminates
> > early, lacks trailing load records, or contains consecutive debug records, the
> > previously allocated buffers are overwritten or never freed. Neither jit_close()
> > nor jit_process() cleans up jd->debug_data or jd->unwinding_data.
> > 
> > [Severity: Medium]
> > This isn't a bug introduced by this patch, but does jit_repipe_code_move() leak
> > its event allocation?
> > 
> > tools/perf/util/jitdump.c:jit_repipe_code_move() {
> >     ...
> > 	event = calloc(1, sizeof(*event) + 16);
> > 	if (!event)
> > 		return -1;
> >     ...
> > out:
> > 	perf_sample__exit(&sample);
> > 	return ret;
> > }
> > 
> > The event buffer is dynamically allocated but there is no free(event) in the
> > cleanup block, leaking the memory for every JIT_CODE_MOVE record processed.
> > 
> > [Severity: Medium]
> > This is a pre-existing issue, but is flockfile() being used incorrectly for
> > inter-process synchronization?
> > 
> > In jit_open():
> > 
> > tools/perf/util/jitdump.c:jit_open() {
> >     ...
> > 	/*
> > 	 * protect from writer modifying the file while we are reading it
> > 	 */
> > 	flockfile(jd->in);
> >     ...
> > }
> > 
> > flockfile() is a POSIX thread mutex that provides no OS-level file locking.
> > It cannot prevent an external process from modifying the file concurrently,
> > making this synchronization completely ineffective against external writers.
> > 
> > [Severity: Medium]
> > This isn't a bug introduced by this patch, but could this allocation size calculation
> > underflow?
> > 
> > In jit_repipe_debug_info():
> > 
> > tools/perf/util/jitdump.c:jit_repipe_debug_info() {
> >     ...
> > 	sz  = jr->prefix.total_size - sizeof(jr->info);
> > 	data = malloc(sz);
> >     ...
> > }
> > 
> > If total_size is smaller than sizeof(jr->info), the unsigned subtraction will
> > underflow to a massive value, leading to a guaranteed malloc() failure or
> > instability if memory is overcommitted.
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does lack of validation on code_size allow
> > out-of-bounds reads?
> > 
> > In jit_repipe_code_load():
> > 
> > tools/perf/util/jitdump.c:jit_repipe_code_load() {
> >     ...
> > 	csize = jr->load.code_size;
> >     ...
> > 	code  = (unsigned long)jr + jr->load.p.total_size - csize;
> >     ...
> > 	ret = jit_emit_elf(jd, filename, sym, addr, (const void *)uaddr, csize, ...
> >     ...
> > }
> > 
> > If an artificially large csize is parsed from the file without being bounds
> > checked against total_size, the code pointer calculation will underflow and
> > point into earlier heap memory. jit_emit_elf() will then dump csize bytes
> > from this out-of-bounds memory into the ELF file.
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260605064932.34316-1-namhyung@kernel.org?part=1

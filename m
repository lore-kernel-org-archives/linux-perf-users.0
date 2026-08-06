Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFD37F311;
	Thu,  6 Aug 2026 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029704; cv=none; b=q+ySMa9edaJAGqrUTeCZ+40i6dxmtHEhOKyo6cNnEHve/8E550jA4MW+xKRjYLof2jhAqPbHMU0pHJ05eE3uNnzK2qBdBsHaAWdatWeN6cpNMiRiH4bjSZzyNZNK1ukAhYPGgWVtBUE7vOI0zI7F6xcpYLC79oVUOh1iRK3RlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029704; c=relaxed/simple;
	bh=maxo/kbx5p9stTFxT0yiFCJH4WTgX+r2A5CiFhN064U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQZRevReTQQP8yvE8jmPC1fGBKxJwTBTeXKLViWrobUjePmc85zAFy+G0qrIJO+fqf2LZY36eXc2r1aq6qktlj4cCaxOzeGXokrrtihalBWEvAxYMOa0XXcD6wwy5YSDiAPk/Zh9n7zZVQ6q3g6AbJLRxEx3JhS1Fm+GXc2x4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzYAcZEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzYAcZEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBF71F00A3D;
	Thu,  6 Aug 2026 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786029702;
	bh=zxKDFU67qhflnyAk0PvzwaXRUUyfOd+1AKfYmTJUMKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AzYAcZEhEg9UBliHdWIt8wt2IH+3KdrvN8Z8lCYNEnwg2swrECmp6U0siTc6c/PGF
	 HY41e2tARAe8RPZR24uXG0gKXV7IxuC5FDqFl2KRddNQW0+hx+qBWTTURmSzJRDodj
	 /krH5zvFyIYO0LrQJS8k+CXBPt0rm9vVgNLmzxrVp+dwfWGAt1v7feshdNts7F2VSs
	 cbg77actXYLnzixeCyC7aOHlGUHP2wW0ByY+JJOuSlHEqmXh2pO4/nSQuHqdfi30IQ
	 3hEkOpeHODKnhCuzYWc6m2fSPbu5dthqNcFv0Ubt3nULy6p47mPjSMZenBCm48ym0b
	 l43RKjKbNLyCA==
Date: Thu, 6 Aug 2026 12:21:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 05/12] perf jitdump: Bounds-check debug entry byte-swap
 loop
Message-ID: <anSmgfNw3KdJcs_b@x1>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-6-acme@kernel.org>
 <20260806125156.ADDF61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806125156.ADDF61F00A3A@smtp.kernel.org>

On Thu, Aug 06, 2026 at 12:51:56PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Replacing array indexing with sequential pointer arithmetic (`debug_entry_next`) on unpadded, variable-length structures results in unaligned struct pointers, causing undefined behavior and SIGBUS crashes on strict-alignment architectures.

This is something bigger, the proper fix needs research, the TODO entry
#154 notes we must confirm the JDK/Mono/V8 jitdump writers actually pad
entries to 8-byte boundaries before choosing between get_unaligned and
ALIGN() — that's next-series work.

- Arnaldo
 
> Pre-existing issues:
> - [Critical] The newly added bounds checking and `nr_entry` clamping for `JIT_CODE_DEBUG_INFO` records are scoped exclusively inside the `if (jd->needs_bswap)` block, leaving native-endian files completely vulnerable to a massive heap buffer overflow.
> - [High] Missing validation of `unwinding_size` against `unwinding_data_size` in `JIT_CODE_UNWINDING_INFO` leads to an out-of-bounds read during ELF generation.
> - [Medium] The `event` buffer is leaked on all return paths in `jit_repipe_code_move()`.
> - [Medium] `jit_repipe_code_move` fails to validate that the record's `total_size` is large enough to contain the `jr_code_move` payload, leading to the processing of uninitialized memory.
> --
> 
> --- Patch [5]: [PATCH 05/12] perf jitdump: Bounds-check debug entry byte-swap loop ---
> commit 14beafbf2609e41d04f4020f064d84fdbb15c5a7
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf jitdump: Bounds-check debug entry byte-swap loop
>     
> This commit replaces array indexing with pointer arithmetic and adds bounds
> checking for JIT_CODE_DEBUG_INFO records during byte-swapping to prevent
> out-of-bounds reads.
> 
> > diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> > index f79e9420c6bd7..7efbaa07f1ba7 100644
> > --- a/tools/perf/util/jitdump.c
> > +++ b/tools/perf/util/jitdump.c
> > @@ -320,14 +320,32 @@ jit_get_next_entry(struct jit_buf_desc *jd)
> >  	switch(id) {
> >  	case JIT_CODE_DEBUG_INFO:
> >  		if (jd->needs_bswap) {
> > +			void *end = (void *)jr + jr->prefix.total_size;
> > +			struct debug_entry *ent;
> >  			uint64_t n;
> > +
> >  			jr->info.code_addr = bswap_64(jr->info.code_addr);
> >  			jr->info.nr_entry  = bswap_64(jr->info.nr_entry);
> > -			for (n = 0 ; n < jr->info.nr_entry; n++) {
> > -				jr->info.entries[n].addr    = bswap_64(jr->info.entries[n].addr);
> > -				jr->info.entries[n].lineno  = bswap_32(jr->info.entries[n].lineno);
> > -				jr->info.entries[n].discrim = bswap_32(jr->info.entries[n].discrim);
> > +
> > +			/*
> > +			 * debug_entry has a variable-length name[], so array
> > +			 * indexing would compute wrong offsets — use
> > +			 * debug_entry_next() and bounds-check each entry.
> > +			 */
> > +			ent = &jr->info.entries[0];
> > +			for (n = 0; n < jr->info.nr_entry; n++) {
> > +				if ((void *)ent + sizeof(*ent) > end)
> > +					break;
> 
> [Severity: Critical]
> This is a pre-existing issue, but by placing the bounds checking and
> nr_entry clamping exclusively inside the if (jd->needs_bswap) block,
> native-endian files bypass this validation completely.
> 
> If a maliciously crafted JIT dump file with a native endianness matching the
> host provides an arbitrarily large untrusted nr_entry count for a
> JIT_CODE_DEBUG_INFO record, this path is skipped.
> 
> Later in the processing, this unvalidated value is assigned directly:
> 
> tools/perf/util/jitdump.c:jit_repipe_debug_info()
>     jd->nr_debug_entries = jr->info.nr_entry;
> 
> And then blindly iterated over on the heap:
> 
> tools/perf/util/genelf_debug.c:jit_process_debug_info()
>     for (i = 0; i < nr_debug_entries; i++) {
>         ent->addr = ent->addr - code_addr;
>         ent = debug_entry_next(ent);
>     }
> 
> Could we move the bounds validation outside of the byte-swapping block so all
> inputs are checked?
> 
> > +				/* name must be NUL-terminated within the record */
> > +				if (!memchr(ent->name, '\0', (char *)end - ent->name))
> > +					break;
> > +				ent->addr    = bswap_64(ent->addr);
> > +				ent->lineno  = bswap_32(ent->lineno);
> > +				ent->discrim = bswap_32(ent->discrim);
> > +				ent = debug_entry_next(ent);
> 
> [Severity: Medium]
> Does this unpadded sequential pointer arithmetic lead to unaligned memory
> accesses?
> 
> struct debug_entry contains 64-bit and 32-bit fields, requiring 8-byte
> alignment, but it is not __packed. The debug_entry_next() helper calculates
> the next entry's address by adding the length of the string:
> 
> tools/perf/util/jitdump.h:debug_entry_next()
>     void *a = ent + 1;
>     size_t l = strlen(ent->name) + 1;
>     return a + l;
> 
> This leaves the pointer unaligned. When the byte-swapping loop uses
> ent = debug_entry_next(ent) and accesses ent->addr = bswap_64(ent->addr),
> the compiler generates aligned load/store instructions for an unaligned
> address, leading to SIGBUS crashes on strict-alignment architectures.
> 
> >  			}
> > +			/* clamp so downstream consumers don't overrun */
> > +			jr->info.nr_entry = n;
> >  		}
> >  		break;
> >  	case JIT_CODE_UNWINDING_INFO:
> >  		if (jd->needs_bswap) {
> >  			jr->unwinding.unwinding_size = bswap_64(jr->unwinding.unwinding_size);
> 
> [Severity: High]
> This is a pre-existing issue, but is the unwinding_size validated against the
> actual payload size?
> 
> In jit_repipe_unwinding_info(), the unwinding size is saved directly from the
> payload without validation against the allocated heap buffer size:
> 
> tools/perf/util/jitdump.c:jit_repipe_unwinding_info()
>     jd->unwinding_size = jr->unwinding.unwinding_size;
> 
> This unvalidated size is later passed to libelf:
> 
> tools/perf/util/genelf.c:jit_add_eh_frame_info()
>     d->d_size = unwinding_table_size;
> 
> A crafted record with a small total_size but a huge unwinding_size could
> cause libelf to read out-of-bounds heap memory and embed it into the output
> ELF, leading to an information leak.
> 
> >  			jr->unwinding.eh_frame_hdr_size = bswap_64(jr->unwinding.eh_frame_hdr_size);
> >  			jr->unwinding.mapped_size = bswap_64(jr->unwinding.mapped_size);
> >  		}
> >  		break;
> 
> While reviewing this patch, I also noticed a couple of pre-existing issues
> in the handling of JIT_CODE_MOVE records:
> 
> tools/perf/util/jitdump.c:jit_repipe_code_move()
> [ ... ]
> > 	nspid = jr->load.pid;
> > 	pid   = jr_entry_pid(jd, jr);
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does jit_repipe_code_move()
> validate that the record's total_size is large enough to contain the
> jr_code_move payload?
> 
> If a malformed record is provided with a truncated total_size, fread() will
> read only a partial record into jd->buf. The remaining fields will be
> uninitialized or contain leftover data, which are then used to construct
> the perf event.
> 
> [ ... ]
> > 	event = calloc(1, sizeof(*event) + 16);
> > 	if (!event)
> > 		return -1;
> [ ... ]
> > 	ret = perf_event__process_mmap2(tool, event, &sample, jd->machine);
> > 	if (ret)
> > 		goto out;
> > 
> > 	ret = jit_inject_event(jd, event);
> > 	if (!ret)
> > 		build_id__mark_dso_hit(tool, event, &sample, jd->machine);
> > out:
> > 	perf_sample__exit(&sample);
> > 	return ret;
> 
> [Severity: Medium]
> This is a pre-existing issue, but does this leak the event buffer?
> 
> The memory for event is allocated via calloc() and the function returns at
> the out: label without calling free(event). Neither of the processing
> functions take ownership of the memory, so the buffer appears to be leaked on
> every JIT_CODE_MOVE record.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260806123604.271277-1-acme@kernel.org?part=5

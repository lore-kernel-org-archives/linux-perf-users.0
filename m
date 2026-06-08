Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF293D4117
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931342; cv=pass; b=Jsjcm1xr02XG+A45s2eyo/bqVdrOhBmc48xcJNkPkjuYKeExkPpniypN4+PhWGbIwmsLLWLl+2MK4yxRhMYwxZzsuUlEHcbQRD/H5hTCtFakTgwPbT7sIfrpoCFc43/L2QCCGNYpUPJEkzXa513Hp90nP/sXtyvJjk8g3KOjuE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931342; c=relaxed/simple;
	bh=wC4MNaiA4RM8FP6lO8hD3omWtAPLGiIAwwndKX/0W6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bp+Bp04TnO5egV0RCdmoPsR2pWqkfGlTgKy/VHTihnejTIFvt71V/dP3PGSPYecJPmlpMzpi83Dc2k8Ki0AmUZ50t+Pkb3VAn/FV10UH8tsdsjifZqRhUWAeRGSy9jxNz7GcazmcOEEYJ5E8rqjk1A00xRhEyXC5LG79MHhKFtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2tXOFUQ; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2tXOFUQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0b1a48855so390945ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 08:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931340; cv=none;
        d=google.com; s=arc-20240605;
        b=EYbT4M7hDZ3fb1XQcJ0RqNy4BrYtsgbevHY66ITzpNJHxVGyETDuWExcah13fph0hw
         bip6y2JNslNPHoGBXciHApxzcBM0cRM/ZrapV3/IVJWVVxddqrCv4zy+5e28vDNVs029
         oSf6GRz/oRiYMOu13/z+av6QVf1AWA/OkTK7jtr05z3OmHuTRtowlpSqZW3oCrOVrlik
         uZPUYSDCQnTa/tDD6XG+Pc1tYpwu/tkjT/B+BHPjhwyhbHCrMjL9lSan1XLzubH/vU5u
         DYXj6pPD5aVI1R0jvw7M38NscYE55NAidpvrwphcQR5pEnW1rQnbK7/5R2u+lFY0RgGg
         cYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0RvhhCdJCCwZl4WXuF6y0VExfpYFxOfP6Y3QjEAesRU=;
        fh=Kz9uZD6t2ugiLZFYfeFqSO0yN3RKJtj4fZLdqAP9kb4=;
        b=f3EB4+vfis2joMkmfCPP8nnGhxgSLq+sJFwM0Z2ZO+nk80Yd2fxh2wU+NZ45g3siSv
         WCrhtti8EXtNiyi4QDLMkXcAAd+IwKy17eYikK75BRBXCmR/cQQEMGxxPmtVo+rc7T0p
         yzT1YD1TftbsEOlLhY+sUFL1s9KNh/QkgNzCVmbagYExv7RQCjzvG3J2uCAECfwuHZ9Z
         96mIjAX0ZIIDyr9gBOoct7ueo0AbD1XOY/W744NPZc06zwhQ4trAM46Wm5xltzjrgWJP
         ByzYYTqJz703oDgi9JjTJ/ezhU//bSzcOREZzAMyzUdtoENUoWEr8ZpuHLMBwveNUjbz
         IEZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780931340; x=1781536140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RvhhCdJCCwZl4WXuF6y0VExfpYFxOfP6Y3QjEAesRU=;
        b=N2tXOFUQSQPL/8BAm1vgP0avbXVUqOOgiZa4Q5s5USSDgzT3MFuGKBCfzR23KGIA4x
         mXMgiA4fWaJ1S1ht6x9/9zSsPATfy/BqXPgZMjgFPgQGU3n6Fn3S256n5kfsLxZMmabo
         FwA62IF5eCtdmuB0W0S+1BtQmrDXZCdXs5UuCZBZYHDaj7M1E+r5Dnu//21h2gA9yhZX
         urmIPm47J1uHyzk9o1G6rB141nknS3xPfnAXKes52pVyGj+IhAad2O3ywCyvHYyye6Eb
         5maaMctA89M+e8xPwG3yw7ErzNnFvqbwjQus68HOfVjXy+tHkQmnbiOWYpa56+c6Opk/
         BtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931340; x=1781536140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0RvhhCdJCCwZl4WXuF6y0VExfpYFxOfP6Y3QjEAesRU=;
        b=R22lDHmFkZeSURfbTPLLnqWTUTBL1DcSjH0J5ipvjyFsSheqDeKtEp4uByGvHKtl/H
         j+y9oXJNv9atrhATbXBCtazE+PlVOhRWI/DTO4W6JVjG49N4NsphtYRxVPyqNzIJ4dN3
         boj4WMhUPqCSKCN2AfRv0P5Tg0hjTQ6mLjxU0LyiwESGtZfkC7OCQcXwsNDEb/L8BzE1
         WjGdaLjVJGtOXa3Ua5d05030dDNTb8qkrzPP1ipo9u9U6/Glo3Ax5mx3TAZS6Tot1QNF
         dUKmGFyDGeKXwqRGqX51gdNiig00GZ4Ki2DFYwBYlYJ+DfSd+umRHDjF6cqGuv6Ao4tp
         JdUw==
X-Forwarded-Encrypted: i=1; AFNElJ8lm6oi02k6ct1TZtgvYTxGRYvyEN3OmpvtANMx2PKTVz/eoX2VX6jEqFxIOUvlsX+B3Xgna55O8e2TeLIIdgyK@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2VcpWXR2s2egLjr83EwsmA0em4RYoq8CqrlQNsvtLbG1m+bI
	b1iZjGaGRYsZHg8Jp4gEaQIzINBT9y4iNi24gpMIzW+IVXSj54diu8YGCaxAmhrhwhT0m2GN8Vj
	/siPNqrouYtqTjqg2YibSdYcKkAXun5fOMF2ar6g2
X-Gm-Gg: Acq92OHiTBTQn4xpmvL1GrPjKVSfCu+d0Jj6842chrZM/CU71wvRp1tGxeax2ng/O1A
	razRV8gU7n09WxRqcFMPGXrun67hteL5AHGEoAytCiuqxRn2bJchnO3dVY3SX6lMFHDWmtJyCaQ
	N2ULCM1fKvz0bnk288Pcw+K2GEvW0pnU26fQxk+68dariQqH8F/X0Mx2UGA1L16/pJl89/nitgY
	0FGGqtKPDZtxz9qxGp9CKDnz5oIPS69BAXa1ncw4gQzpDs2oWXtEEmFa1wgAG/OGtSLF6Gbz7vS
	hPUUrKuBzQENVfXlaMKDguAJ2DQD1e9cmKT9oTS8GdWld/c=
X-Received: by 2002:a17:903:1112:b0:2c1:ee6e:be22 with SMTP id
 d9443c01a7336-2c1ee6ec543mr4092775ad.32.1780931339067; Mon, 08 Jun 2026
 08:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607213700.3563842-1-irogers@google.com> <20260608054841.3856224-1-irogers@google.com>
In-Reply-To: <20260608054841.3856224-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 08:08:47 -0700
X-Gm-Features: AVVi8CcWJU9NqZxbrmSUk1rOKREiMmd9ydbR2_VCsCKww1dpHd4iRoTysvQEbiI
Message-ID: <CAP-5=fWMULL7q3PtW5ugGDpYWVmp2sK6x8W39wXM7uYBfANhqg@mail.gmail.com>
Subject: Re: [PATCH v19 0/5] perf tools: Add inject --aslr feature, early maps
 loading, and decoupling fixes
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, gmx@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 10:48=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> This patch series introduces the new 'perf inject --aslr' feature to
> remap virtual memory addresses or drop physical memory event leaks
> when profile record data is shared between machines. Bundled with this
> feature is a bug fix inside the core map tracking tool that hardens
> perf session analysis against concurrent lookup data races.

So the sashiko review is down to just 1 "high" category issue on patch 3:
"""
Will this corrupt the CPU ID on cross-endian hosts?
When the perf core reads the input file, it byte-swaps all 64-bit payload
fields into host endianness. For PERF_SAMPLE_CPU, which consists of two
32-bit fields (cpu and res), this 64-bit byte-swap incorrectly reverses the
two fields.
The code correctly unpacks and repacks PERF_SAMPLE_TID using a union to
safely recover its two 32-bit fields, but uses a blind COPY_U64() here for
PERF_SAMPLE_CPU in aslr_tool__process_sample().
When the injected output file is written natively in host endianness, this
incorrectly-swapped 64-bit value is permanently saved. Later, when the new
profile is parsed, it will read the originally empty res field into data->c=
pu,
corrupting the CPU ID.
Should PERF_SAMPLE_CPU be unpacked and repacked similarly to PERF_SAMPLE_TI=
D?
"""
So the problem is that cross-endian (perf.data is big-endian and
output is little-endian, or vice versa) is broken all over the place
is perf inject. The event swapping code doesn't unswap when writing
the data out, for example. Nearly all of the last 10 workarounds
attempted to resolve cross-endian issues, but this is a much larger
job and belongs on the TODO list.

Thanks,
Ian

> Detailed Mechanism of MMAP Mapping and ASLR virtual Address Allocation:
>
> The ASLR tool virtualizes the address space of the recorded processes by
> intercepting MMAP and MMAP2 events to build a consistent translation
> database, which is subsequently used to rewrite sample addresses.
>
> It maintains two primary lookup databases using hash maps:
> 1. 'remap_addresses': Maps an original mapping key to its new remapped
>    base address. The key uses topological invariant coordinates:
>    (machine, dso, invariant). The invariant is computed as (start - pgoff=
)
>    for DSO-backed mappings. This invariant remains constant even when
>    perf's internal overlap-resolution splits a VMA into fragmented
>    pieces, ensuring split maps resolve consistently back to the same
>    remapped base.
> 2. 'top_addresses': Tracks the allocation state per process (machine, pid=
).
>    It maintains 'remapped_max' (the highest allocated address in the
>    virtualized space).
>
> For each MMAP/MMAP2 event:
> - We look up the DSO and invariant key in 'remap_addresses'. If found, we
>   reuse the translation, preserving the offset within the mapping.
> - If not found, we allocate a new remapped address space:
>   - We use thread__find_map to look up the mapping immediately preceding
>     the new one in the original address space (at start - 1). If
>     the preceding
>     mapping was also remapped, we place the new mapping
>     contiguously after it in the remapped space. This preserves
>     contiguity of split mappings (e.g., symbols split by HugeTLB,
>     or anonymous .bss segments adjacent to initialized data).
>   - If no contiguous mapping is found, we insert a 1-page gap from
>     the highest allocated address (remapped_max) to prevent accidental
>     merging of unrelated VMAs.
> - The event's start address (and pgoff for kernel maps) is rewritten,
>   and the event is delegated to the output writer.
>
> To remain strictly conservative and guarantee security, the tool
> scrubs breakpoint addresses (bp_addr) from all synthesized stream
> headers, completely drops PERF_RECORD_TEXT_POKE events to prevent
> absolute immediate pointer operands leaks, and drops unsupported
> complex payloads (such as user register stacks, raw tracepoints, and
> hardware AUX tracing frames).
>
> Verification is reinforced with shell test ('inject_aslr.sh').
>
> Prerequisite Bug Fix (Patch 1). During development, a core map
> indexing issue was identified and resolved to prevent concurrent
> lookup data races during session analysis.
>
> Changes since v18:
> - Patch 2 & 3: Squashed the bounds checking boundary fixes into the "Stri=
p
>   sample registers" patch. The array bounds checking now correctly uses
>   'orig_sample_type' to traverse the event payload, preventing heap
>   corruption when dealing with events that have had their registers
>   stripped by the ASLR tool pipeline.
> - Patch 2 & 3: Rebased the commit series to properly isolate the sample
>   address remapping logic from the register stripping logic.
> - Patch 2 & 3: Expanded commit messages to extensively document the
>   cross-endian behavior of 'perf inject'. Because 'perf inject' effective=
ly
>   acts as an endianness converter (writing a host-endian PERF_MAGIC and
>   flushing events exactly as they sit in memory after being byte-swapped
>   by perf_event__all64_swap), all injected events must be perfectly
>   constructed in the host's native endianness. Specifically,
>   perf_event__all64_swap byte-swaps the raw 64-bit payloads, which causes
>   32-bit sequential fields like PERF_SAMPLE_TID (containing pid and tid)
>   to have their ordering reversed in memory (e.g., [BE_pid][BE_tid] becom=
es
>   [LE_tid][LE_pid]). The ASLR tool's sample construction logic was
>   expanded to explicitly unpack these fields and repack them sequentially
>   via unions to guarantee a strictly host-endian layout that resolves
>   these inversion anomalies. Similarly, branch stack flags (which are
>   modified in-place to host-endian bitfields by the parser) are copied
>   directly to the newly synthesized event, and 'needs_swap=3Dfalse' is ex=
plicitly
>   used when re-parsing the synthesized event to prevent erroneous double
>   swapping.
> - Series: Verified cross-endian robustness via the sashiko analyzer.
>
> Changes since v17:
> - Patch 2: Reordered ksymbol deletion logic to ensure
>   `perf_event__process_ksymbol` deletes the map *after* the
>   `aslr_tool__findnew_mapping` translates the unregister offsets.
> - Patch 2: Changed `aslr_tool__delete` to cleanly handle guest machine
>   deletion memory leaks.
> - Patch 2: Resolved read-only segfaults on memory-mapped perf.data
>   headers during attribute stripping by using deep copies in
>   `perf_event__repipe_attr`.
> - Patch 2: Fixed user space remap invariant logic to include
>   `(start - map__start(al.map))` preventing negative overflows on module
>   offset boundaries.
> - Patch 3: Removed duplicate `bswap_64` payload byte-swapping inside the
>   array logic, allowing the host endianness macros `COPY_U64()` to
>   handle it dynamically.
> - Patch 3: Fixed LBR branch sample starvation by explicitly reading branc=
h
>   counters instead of dropping the entire sample.
> - Patch 5: Fixed test flakiness by grepping out physical hex addresses
>   `0x[0-9a-f]{8,}` instead of matching exact address strings.
> - Patch 5: Parameterized temp reports and updated test to scale with
>   `/dev/urandom` continuous random reads.
> - Patch Series: Added Signed-off-by tags uniformly and Assisted-by tags t=
o
>   track assistance.
>
> Changes since v16:
> - Patch 2: Refactored inline ASLR stripping logic out of builtin-inject.c
>   and into dedicated helpers (aslr_tool__strip_attr_event and
>   aslr_tool__strip_evlist) in aslr.c to better separate concerns.
> - Patch 2: Fixed guest machine allocation memory leak in
>   aslr_tool__delete() where machines__exit() explicitly skipped freeing
>   the guest processes tree.
> - Patch 3: Fixed bounds-check violations during cross-endian parsing insi=
de
>   aslr_tool__process_sample() by correctly applying bswap_64() to raw
>   offsets, iteration counts, sizes, and addresses prior to logical
>   evaluation when orig_needs_swap is active.
> - Patch 4: Fixed pipe mode parser misalignment bug by safely fetching
>   needs_swap from the initialized evsel rather than blindly intercepting
>   HEADER_ATTR events prior to session parsing.
> - Patch 4: Resolved checkpatch.pl line length warnings in the bswap_64
>   endianness swapping logic.
> - Patch Series: Reordered the final two patches. "perf aslr: Strip
>   sample registers" is now Patch 4, and "perf test: Add inject ASLR
>   test" is now Patch 5. This ensures the register stripping logic
>   is fully introduced before the comprehensive shell tests validate it,
>   preventing bisectability test failures and easing merge conflicts.
> - Patch 5: Fixed "User registers stripping test" starvation when run as
>   root by explicitly using '-e cycles:u' during recording, preventing
>   the ring buffer from overflowing with kernel samples.
>
> Changes since v15:
> - Patch 2: Added bounds checking for event->header.size before writing
>   to breakpoint fields to avoid heap buffer overflow on older ABI events.
> - Patch 2: Fixed asymmetric calculation bug in aslr_tool__findnew_mapping=
()
>   where pgoff for anonymous kernel memory was not properly subtracted upo=
n
>   insertion, causing the lookup addition to overflow.
> - Patch 2: Added detailed comments documenting the symmetric lookup and
>   insertion math for unmapped and mapped memory blocks.
> - Patch 5: Add missing kprobe and uprobe scrubbing of config1 and
>   config2 during aslr_tool__strip_evlist() to strictly conform with
>   repipe constraints.
>
> Changes since v14:
> - Patch 2: Removed unnecessary vertical whitespace in builtin-inject.c.
> - Patch 2: Added comments explaining why pgoff is assigned for
>   anonymous memory maps to prevent ASLR leaks.
> - Patch 2: Removed orig_last_end tracking and refactored contiguous mappi=
ng
>   detection to use thread__find_map(..., start - 1, ...) based on Gabriel=
's
>   feedback.
> - Patch 2: Scrub kprobe/uprobe event config1 and config2 fields to preven=
t
>   address leaks.
> - Patch 2: Overwrite pgoff with the remapped start address for anonymous
>   mappings (detected via is_anon_memory and is_no_dso_memory).
> - Patch 3: Fix C90 mixed declaration error for orig_needs_swap.
> - Patch 3: Temporarily disable evsel->needs_swap during the secondary
>   evsel__parse_sample() call to prevent branch stack double-swapping bugs=
.
>
> Changes since v13:
> - Patch 2: Added a NULL check for env before calling
>   perf_env__kernel_is_64_bit(env) to prevent potential segfaults if the
>   recorded environment has no headers.
> - Patch 5: Fixed sample_size and id_pos going out of sync during
>   aslr_tool__strip_evlist() and aslr_tool__restore_evlist(). Instead of
>   using evsel__reset_sample_bit(), which was acting as a no-op due to
>   early bit clearing and corrupted sample_size, the tool now directly
>   updates sample_type and recomputes sample_size/id_pos dynamically.
>   Added orig_sample_size to aslr_evsel_priv to correctly restore the
>   state.
>
> Changes since v12:
> - Patch 2: Fixed potential NULL pointer dereference in
>   remap_addresses__hash() when handling unmapped memory events (key->dso
>   is NULL) under REFCNT_CHECKING.
> - Patch 2: Dynamically detect machine architecture bitness via
>   perf_env__kernel_is_64_bit() to select appropriate kernel_space_start
>   boundaries, avoiding 64-bit address injection on 32-bit platforms.
>
> Changes since v11:
> - Patch 1: Fixed struct dso name accessor in maps.c by using
>   dso__name() instead of ->name.
> - Patch 2: Fixed hash function in aslr.c to hash the underlying
>   dso pointer using RC_CHK_ACCESS to support reference count checking.
>
> Changes since v10:
> - Patch 1: Added explicit tracking array logic in maps__load_maps()
>   to correctly accumulate valid maps (skipping NULL entries after
>   failures) and safely return the exact populated count, resolving
>   out-of-bounds pointer iteration panics.
> - Patch 3: Fixed endianness bug during cross-endian sample parsing
>   by passing evsel->needs_swap instead of false to __evsel__parse_sample
>   in aslr.c, ensuring correct 32-bit field byte unswapping for packed
>   fields. Refactored evsel__parse_sample to take a needs_swap argument
>   via __evsel__parse_sample.
> - Patch 4: Fixed inject_aslr.sh exit code handling in trap functions
>   to capture and propagate the correct pipeline failure status code
>   instead of unconditionally returning success or failing the test.
>
> Changes since v9:
> - Patch 1: Added `-ENOMEM` error check inside
>   `maps__find_symbol_by_name()` and return `NULL` early. Added map
>   sorting state invalidation on early return in `maps__load_maps()`.
> - Patch 2: Fixed encapsulation by using `thread__maps()` and
>   `thread__pid()` accessors in `aslr_tool__findnew_mapping()`. Added
>   `pr_warning_once` warning when raw auxtrace data is dropped.
> - Patch 3: Fixed encapsulation by using `thread__maps()` and
>   `thread__pid()` accessors in `aslr_tool__remap_address()`. Wrapped
>   `evsel__parse_sample()` to temporarily disable `needs_swap` to avoid
>   branch stack endianness corruption on cross-endian files. Fixed ISO
>   C90 warning for declaration-after-statement for `orig_needs_swap`.
> - Patch 4: Fixed duplicate cleanup by explicitly removing trap
>   handlers (`trap - EXIT TERM INT`) inside the `cleanup()` function.
> - Patch 5: Fixed heap corruption by adding size bounds checking before
>   writing to `sample_regs_user` and `sample_regs_intr` fields. Added
>   missing register mask clearing logic for the `itrace` synthesis path
>   of `perf_event__repipe_attr()`.
>
> Ian Rogers (5):
>   perf maps: Add maps__mutate_mapping
>   perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking
>   perf inject/aslr: Implement sample address remapping
>   perf aslr: Strip sample registers
>   perf test: Add inject ASLR test
>
>  tools/perf/builtin-inject.c           |   81 +-
>  tools/perf/tests/shell/inject_aslr.sh |  525 +++++++++
>  tools/perf/util/Build                 |    1 +
>  tools/perf/util/aslr.c                | 1406 +++++++++++++++++++++++++
>  tools/perf/util/aslr.h                |   44 +
>  tools/perf/util/evsel.c               |    6 +-
>  tools/perf/util/evsel.h               |   10 +-
>  tools/perf/util/machine.c             |   32 +-
>  tools/perf/util/maps.c                |  149 ++-
>  tools/perf/util/maps.h                |    3 +
>  tools/perf/util/symbol-elf.c          |   41 +-
>  tools/perf/util/symbol.c              |   17 +-
>  12 files changed, 2244 insertions(+), 71 deletions(-)
>  create mode 100755 tools/perf/tests/shell/inject_aslr.sh
>  create mode 100644 tools/perf/util/aslr.c
>  create mode 100644 tools/perf/util/aslr.h
>
> --
> 2.54.0.1032.g2f8565e1d1-goog
>

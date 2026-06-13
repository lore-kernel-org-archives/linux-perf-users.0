Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E96200110;
	Sat, 13 Jun 2026 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310367; cv=none; b=dpbzgLjy+nuyT8G8hxXTmZ32H9M9AxFRei0dj2Mm6yHjlnz5T4pH0t7YWDDYG8nHRQXgS7Tmb6HiyM4FSTKXKWC05NgD0QaRmwzrq1yDAHhhesI9t5hwsfU4AqF3FtxuJi2k6Rv4bdYhjKnDCuP+xN6dSlPx2U+dzhjkx8t+Ni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310367; c=relaxed/simple;
	bh=y/2mxymT+njimflKLV67HxCY1c/CvBl3OLGq2Ns9VGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiri0LtxbDxTsMYp1Gb8M6I7V35n95VoY8zkmWy7/exS3JNlWEIIUdvH7JRl6zEbQbqsG64MhTTBFd0G5ZcTCOjOgRMtPX4kYoUGG0Klq0Y9YFrXV21DtaSoDsICkg32C6rqSDe8o+jiEeB0H7N6CJxRKr729QiJY4CNpV8cWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9SuwgM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9SuwgM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668631F000E9;
	Sat, 13 Jun 2026 00:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310365;
	bh=e4NPp2m4uPUal01cMN14hKmCOq8JyXpIz13CmUvBJ2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g9SuwgM2DgUtGhNbamDRy72yjDcCnfzY/zmGF2+LYgRbknL+RDrd5wyLMf0bdKUwn
	 0qdz1KyhE4XEtQFZuJkuOj91I9LFhQmdfxdB6nUI2I69TSjF5VUm/Telj8JnEuUjUn
	 4WGTfOybkP7aCcJYVdy99jECwjTZh2G9vAOpetKK4F5G6tz39bteoXir55CtqRsF0Y
	 MVgdDcy/I7mXPzxICahsgbMDzZPLqPqHuW43Lp+5AzWKOrqAVjfEs+2mX31kGnVBm4
	 lC/Hz+K2DicBbLPyQo6egy0RvLAy60p5qjTTHxPKWVZLq6HDl+3+yv7NNi6n0RSSeF
	 jzXaTKtbi/dlw==
Date: Fri, 12 Jun 2026 21:26:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: james.clark@linaro.org, namhyung@kernel.org, adrian.hunter@intel.com,
	gmx@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v20 0/5] perf tools: Add inject --aslr feature
Message-ID: <aiyjmah8Pnr8ObQr@x1>
References: <20260608054841.3856224-1-irogers@google.com>
 <20260611164122.3974068-1-irogers@google.com>
 <CAP-5=fW9uYdD9fB2ZbF0QVb-N=mVtn6yU8d5=+pacJ_v60OFGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW9uYdD9fB2ZbF0QVb-N=mVtn6yU8d5=+pacJ_v60OFGg@mail.gmail.com>

On Thu, Jun 11, 2026 at 11:29:02AM -0700, Ian Rogers wrote:
> On Thu, Jun 11, 2026 at 9:41 AM Ian Rogers <irogers@google.com> wrote:
> >
> > This patch series introduces the new 'perf inject --aslr' feature to
> > remap virtual memory addresses or drop physical memory event leaks
> > when profile record data is shared between machines. Bundled with this
> > feature is a bug fix inside the core map tracking tool that hardens
> > perf session analysis against concurrent lookup data races.
> >
> > Detailed Mechanism of MMAP Mapping and ASLR virtual Address Allocation:
> >
> > The ASLR tool virtualizes the address space of the recorded processes by
> > intercepting MMAP and MMAP2 events to build a consistent translation
> > database, which is subsequently used to rewrite sample addresses.
> >
> > It maintains two primary lookup databases using hash maps:
> > 1. 'remap_addresses': Maps an original mapping key to its new remapped
> >    base address. The key uses topological invariant coordinates:
> >    (machine, dso, invariant). The invariant is computed as (start - pgoff)
> >    for DSO-backed mappings. This invariant remains constant even when
> >    perf's internal overlap-resolution splits a VMA into fragmented
> >    pieces, ensuring split maps resolve consistently back to the same
> >    remapped base.
> > 2. 'top_addresses': Tracks the allocation state per process (machine, pid).
> >    It maintains 'remapped_max' (the highest allocated address in the
> >    virtualized space).
> >
> > For each MMAP/MMAP2 event:
> > - We look up the DSO and invariant key in 'remap_addresses'. If found, we
> >   reuse the translation, preserving the offset within the mapping.
> > - If not found, we allocate a new remapped address space:
> >   - We use thread__find_map to look up the mapping immediately preceding
> >     the new one in the original address space (at start - 1). If
> >     the preceding
> >     mapping was also remapped, we place the new mapping
> >     contiguously after it in the remapped space. This preserves
> >     contiguity of split mappings (e.g., symbols split by HugeTLB,
> >     or anonymous .bss segments adjacent to initialized data).
> >   - If no contiguous mapping is found, we insert a 1-page gap from
> >     the highest allocated address (remapped_max) to prevent accidental
> >     merging of unrelated VMAs.
> > - The event's start address (and pgoff for kernel maps) is rewritten,
> >   and the event is delegated to the output writer.
> >
> > To remain strictly conservative and guarantee security, the tool
> > scrubs breakpoint addresses (bp_addr) from all synthesized stream
> > headers, completely drops PERF_RECORD_TEXT_POKE events to prevent
> > absolute immediate pointer operands leaks, and drops unsupported
> > complex payloads (such as user register stacks, raw tracepoints, and
> > hardware AUX tracing frames).
> >
> > Verification is reinforced with shell test ('inject_aslr.sh').
> >
> > Prerequisite Bug Fix (Patch 1). During development, a core map
> > indexing issue was identified and resolved to prevent concurrent
> > lookup data races during session analysis.
> >
> > Changes since v19:
> > - Patch 1: Group lock and unlock operations inside maps__mutate_mapping() into
> >   a single conditional block to resolve Clang 15 -Wthread-safety-analysis
> >   compilation errors.
> > - Patch 5: Skip kernel-based ASLR test cases (test_kernel_aslr and
> >   test_kernel_report_aslr) on ARM architectures (aarch64 and arm*) to
> >   bypass high latency constraints and symbolization inconsistencies.
> >
> > Changes since v18:
> > - Patch 2 & 3: Squashed the bounds checking boundary fixes into the "Strip
> >   sample registers" patch. The array bounds checking now correctly uses
> >   'orig_sample_type' to traverse the event payload, preventing heap
> >   corruption when dealing with events that have had their registers
> >   stripped by the ASLR tool pipeline.
> > - Patch 2 & 3: Rebased the commit series to properly isolate the sample
> >   address remapping logic from the register stripping logic.
> > - Patch 2 & 3: Expanded commit messages to extensively document the
> >   cross-endian behavior of 'perf inject'. Because 'perf inject' effectively
> >   acts as an endianness converter (writing a host-endian PERF_MAGIC and
> >   flushing events exactly as they sit in memory after being byte-swapped
> >   by perf_event__all64_swap), all injected events must be perfectly
> >   constructed in the host's native endianness. Specifically,
> >   perf_event__all64_swap byte-swaps the raw 64-bit payloads, which causes
> >   32-bit sequential fields like PERF_SAMPLE_TID (containing pid and tid)
> >   to have their ordering reversed in memory (e.g., [BE_pid][BE_tid] becomes
> >   [LE_tid][LE_pid]). The ASLR tool's sample construction logic was
> >   expanded to explicitly unpack these fields and repack them sequentially
> >   via unions to guarantee a strictly host-endian layout that resolves
> >   these inversion anomalies. Similarly, branch stack flags (which are
> >   modified in-place to host-endian bitfields by the parser) are copied
> >   directly to the newly synthesized event, and 'needs_swap=false' is explicitly
> >   used when re-parsing the synthesized event to prevent erroneous double
> >   swapping.
> > - Series: Verified cross-endian robustness via the sashiko analyzer.
> >
> > Changes since v17:
> > - Patch 2: Reordered ksymbol deletion logic to ensure
> >   `perf_event__process_ksymbol` deletes the map *after* the
> >   `aslr_tool__findnew_mapping` translates the unregister offsets.
> > - Patch 2: Changed `aslr_tool__delete` to cleanly handle guest machine
> >   deletion memory leaks.
> > - Patch 2: Resolved read-only segfaults on memory-mapped perf.data
> >   headers during attribute stripping by using deep copies in
> >   `perf_event__repipe_attr`.
> > - Patch 2: Fixed user space remap invariant logic to include
> >   `(start - map__start(al.map))` preventing negative overflows on module
> >   offset boundaries.
> > - Patch 3: Removed duplicate `bswap_64` payload byte-swapping inside the
> >   array logic, allowing the host endianness macros `COPY_U64()` to
> >   handle it dynamically.
> > - Patch 3: Fixed LBR branch sample starvation by explicitly reading branch
> >   counters instead of dropping the entire sample.
> > - Patch 5: Fixed test flakiness by grepping out physical hex addresses
> >   `0x[0-9a-f]{8,}` instead of matching exact address strings.
> > - Patch 5: Parameterized temp reports and updated test to scale with
> >   `/dev/urandom` continuous random reads.
> > - Patch Series: Added Signed-off-by tags uniformly and Assisted-by tags to
> >   track assistance.
> >
> > Changes since v16:
> > - Patch 2: Refactored inline ASLR stripping logic out of builtin-inject.c
> >   and into dedicated helpers (aslr_tool__strip_attr_event and
> >   aslr_tool__strip_evlist) in aslr.c to better separate concerns.
> > - Patch 2: Fixed guest machine allocation memory leak in
> >   aslr_tool__delete() where machines__exit() explicitly skipped freeing
> >   the guest processes tree.
> > - Patch 3: Fixed bounds-check violations during cross-endian parsing inside
> >   aslr_tool__process_sample() by correctly applying bswap_64() to raw
> >   offsets, iteration counts, sizes, and addresses prior to logical
> >   evaluation when orig_needs_swap is active.
> > - Patch 4: Fixed pipe mode parser misalignment bug by safely fetching
> >   needs_swap from the initialized evsel rather than blindly intercepting
> >   HEADER_ATTR events prior to session parsing.
> > - Patch 4: Resolved checkpatch.pl line length warnings in the bswap_64
> >   endianness swapping logic.
> > - Patch Series: Reordered the final two patches. "perf aslr: Strip
> >   sample registers" is now Patch 4, and "perf test: Add inject ASLR
> >   test" is now Patch 5. This ensures the register stripping logic
> >   is fully introduced before the comprehensive shell tests validate it,
> >   preventing bisectability test failures and easing merge conflicts.
> > - Patch 5: Fixed "User registers stripping test" starvation when run as
> >   root by explicitly using '-e cycles:u' during recording, preventing
> >   the ring buffer from overflowing with kernel samples.
> >
> > Changes since v15:
> > - Patch 2: Added bounds checking for event->header.size before writing
> >   to breakpoint fields to avoid heap buffer overflow on older ABI events.
> > - Patch 2: Fixed asymmetric calculation bug in aslr_tool__findnew_mapping()
> >   where pgoff for anonymous kernel memory was not properly subtracted upon
> >   insertion, causing the lookup addition to overflow.
> > - Patch 2: Added detailed comments documenting the symmetric lookup and
> >   insertion math for unmapped and mapped memory blocks.
> > - Patch 5: Add missing kprobe and uprobe scrubbing of config1 and
> >   config2 during aslr_tool__strip_evlist() to strictly conform with
> >   repipe constraints.
> >
> > Changes since v14:
> > - Patch 2: Removed unnecessary vertical whitespace in builtin-inject.c.
> > - Patch 2: Added comments explaining why pgoff is assigned for
> >   anonymous memory maps to prevent ASLR leaks.
> > - Patch 2: Removed orig_last_end tracking and refactored contiguous mapping
> >   detection to use thread__find_map(..., start - 1, ...) based on Gabriel's
> >   feedback.
> > - Patch 2: Scrub kprobe/uprobe event config1 and config2 fields to prevent
> >   address leaks.
> > - Patch 2: Overwrite pgoff with the remapped start address for anonymous
> >   mappings (detected via is_anon_memory and is_no_dso_memory).
> > - Patch 3: Fix C90 mixed declaration error for orig_needs_swap.
> > - Patch 3: Temporarily disable evsel->needs_swap during the secondary
> >   evsel__parse_sample() call to prevent branch stack double-swapping bugs.
> >
> > Changes since v13:
> > - Patch 2: Added a NULL check for env before calling
> >   perf_env__kernel_is_64_bit(env) to prevent potential segfaults if the
> >   recorded environment has no headers.
> > - Patch 5: Fixed sample_size and id_pos going out of sync during
> >   aslr_tool__strip_evlist() and aslr_tool__restore_evlist(). Instead of
> >   using evsel__reset_sample_bit(), which was acting as a no-op due to
> >   early bit clearing and corrupted sample_size, the tool now directly
> >   updates sample_type and recomputes sample_size/id_pos dynamically.
> >   Added orig_sample_size to aslr_evsel_priv to correctly restore the
> >   state.
> >
> > Changes since v12:
> > - Patch 2: Fixed potential NULL pointer dereference in
> >   remap_addresses__hash() when handling unmapped memory events (key->dso
> >   is NULL) under REFCNT_CHECKING.
> > - Patch 2: Dynamically detect machine architecture bitness via
> >   perf_env__kernel_is_64_bit() to select appropriate kernel_space_start
> >   boundaries, avoiding 64-bit address injection on 32-bit platforms.
> >
> > Changes since v11:
> > - Patch 1: Fixed struct dso name accessor in maps.c by using
> >   dso__name() instead of ->name.
> > - Patch 2: Fixed hash function in aslr.c to hash the underlying
> >   dso pointer using RC_CHK_ACCESS to support reference count checking.
> >
> > Changes since v10:
> > - Patch 1: Added explicit tracking array logic in maps__load_maps()
> >   to correctly accumulate valid maps (skipping NULL entries after
> >   failures) and safely return the exact populated count, resolving
> >   out-of-bounds pointer iteration panics.
> > - Patch 3: Fixed endianness bug during cross-endian sample parsing
> >   by passing evsel->needs_swap instead of false to __evsel__parse_sample
> >   in aslr.c, ensuring correct 32-bit field byte unswapping for packed
> >   fields. Refactored evsel__parse_sample to take a needs_swap argument
> >   via __evsel__parse_sample.
> > - Patch 4: Fixed inject_aslr.sh exit code handling in trap functions
> >   to capture and propagate the correct pipeline failure status code
> >   instead of unconditionally returning success or failing the test.
> >
> > Changes since v9:
> > - Patch 1: Added `-ENOMEM` error check inside
> >   `maps__find_symbol_by_name()` and return `NULL` early. Added map
> >   sorting state invalidation on early return in `maps__load_maps()`.
> > - Patch 2: Fixed encapsulation by using `thread__maps()` and
> >   `thread__pid()` accessors in `aslr_tool__findnew_mapping()`. Added
> >   `pr_warning_once` warning when raw auxtrace data is dropped.
> > - Patch 3: Fixed encapsulation by using `thread__maps()` and
> >   `thread__pid()` accessors in `aslr_tool__remap_address()`. Wrapped
> >   `evsel__parse_sample()` to temporarily disable `needs_swap` to avoid
> >   branch stack endianness corruption on cross-endian files. Fixed ISO
> >   C90 warning for declaration-after-statement for `orig_needs_swap`.
> > - Patch 4: Fixed duplicate cleanup by explicitly removing trap
> >   handlers (`trap - EXIT TERM INT`) inside the `cleanup()` function.
> > - Patch 5: Fixed heap corruption by adding size bounds checking before
> >   writing to `sample_regs_user` and `sample_regs_intr` fields. Added
> >   missing register mask clearing logic for the `itrace` synthesis path
> >   of `perf_event__repipe_attr()`.
> >
> > Ian Rogers (5):
> >   perf maps: Add maps__mutate_mapping
> >   perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking
> >   perf inject/aslr: Implement sample address remapping
> >   perf aslr: Strip sample registers
> >   perf test: Add inject ASLR test
> 
> The sashiko reviews are at:
> https://sashiko.dev/#/patchset/20260611164122.3974068-1-irogers%40google.com
> 
> To summarize:
> 
> Patch 2:
>  * TOCTOU if underlying event buffer mmaps change. Not an issue as
> rewriting a perf.data file while it is being read is out of scope.
> 
> Patch 3:
>  * Mapping addresses to 0 for unknown mappings is criticized but the

Why not then have some unknown mappings hashmap that will assign a
random, unique address on a address range that doesn't overlap with any
of the other maps?

Zero has special meaning, mapping some non-zero address to it introduces
confusion when what we want is to just make sure that we don't leak
addresses?

> proposed alternative doesn't hide ASLR. This will cluster things on
> address 0 but the fix is simply to ensure no MMAPs are missing.
>  * Cross-endian issues, but as explained previously, these are out of scope.
> 
> The clang build issue reported by James and disabling the kernel
> testing for ARM are both in the v20 series. So I think the patches are
> ready for review/merging.

I reviewed one other patch in the series besides the above suggestion.

Thanks, its an useful feature!

- Arnaldo
 
> Thanks,
> Ian
> 
> >  tools/perf/builtin-inject.c           |   81 +-
> >  tools/perf/tests/shell/inject_aslr.sh |  533 ++++++++++
> >  tools/perf/util/Build                 |    1 +
> >  tools/perf/util/aslr.c                | 1406 +++++++++++++++++++++++++
> >  tools/perf/util/aslr.h                |   44 +
> >  tools/perf/util/evsel.c               |    6 +-
> >  tools/perf/util/evsel.h               |   10 +-
> >  tools/perf/util/machine.c             |   32 +-
> >  tools/perf/util/maps.c                |  148 ++-
> >  tools/perf/util/maps.h                |    3 +
> >  tools/perf/util/symbol-elf.c          |   41 +-
> >  tools/perf/util/symbol.c              |   17 +-
> >  12 files changed, 2251 insertions(+), 71 deletions(-)
> >  create mode 100755 tools/perf/tests/shell/inject_aslr.sh
> >  create mode 100644 tools/perf/util/aslr.c
> >  create mode 100644 tools/perf/util/aslr.h
> >
> > --
> > 2.54.0.1099.g489fc7bff1-goog
> >

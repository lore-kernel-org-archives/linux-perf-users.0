Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11664A8C
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780868232; cv=none; b=V5ebTPENWvDkKbmP0aNNtqwhZOhxuLJW8GIEh1o8fX4Yi+IY9ShYBRPdjBBewD0Ye31+iYyKRNbqweiRk/AtfH+zWsE79LN5MUdbfit3UlQQO5ABi5S21sGYbZumykLtvsPv4U2YT19YTa/tQm2pgFPh5BlM4u1Rmc692/QWGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780868232; c=relaxed/simple;
	bh=Q4K1X/rD4xPwTXjOW+1tCq17X2lDW9SXHPlmzIHsps8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nLF4ECcUPDE99P0xLP14inHTBCC16Ugkkom1RTzVz5zruUEQG60t3hEXTcEpXBVtNoInOlbAT0TvcGsE5QGzfAAAeGqUsVYtTlaIFpyZiZUrPeYgTbI/m0zpgFO31crHXOmnte/Un6kBT2iNBWqcGwgPPrOWmzo+ZwGCdDOb8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNlsVvv+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNlsVvv+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304dd917645so3530401eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jun 2026 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780868229; x=1781473029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPSuTHY5OeMTR1GPYZs9JcZ2Cejk5ejQxZZJ3bbDbaw=;
        b=VNlsVvv+khHtpiaIGxt526PuYq/jSD6xpDQHDnvRtcrrASHxJkAW9WX/zZ4P0Kjd/M
         U5yi/AC33bG7lJPB9HPHWv7KdekQdp0g/59Bp4kLblRfhcnN4/GyfF+3Pcw35bgy4z8l
         Nygfwlyc0mhAUF1xhWyrJzinzHTmgsTgr/z8FkDiEQi8CzSxZU0gz5s5CFf7rJ1bYhCu
         zHWeCCf5384fco94X8noL9ORg2qt55XVUTAp0JRRvAwy0OhOszfRDTbVbHekM8WxVTaR
         9zuQluIROwoY2bARi67IRi7eA/4w7jn0OTqtCXjrzeqJNeGIw7LZPujYN5GjbtHA/xjY
         qshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780868229; x=1781473029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPSuTHY5OeMTR1GPYZs9JcZ2Cejk5ejQxZZJ3bbDbaw=;
        b=c/Uf7xhcYX/oYz0LKPqNGw9o4vZdx7psRKazPC6pShxv6ouB90vvXpb0pFcvr7GyQM
         V37dDxtPX76PL/GfRV5o7ZYSnl8ZfPrnLIPLbzR/ZT2drQPOFKGSugfec7YlAwVII4Gr
         bU54rqVAs9dgDD8lnBPY4yhndSvOik9YZnXwyY0veULFAV+q6WMLNpUBXfweeHI/6nno
         O1CfOoezmPtTByKwGyBiiBV2goGPfWK9CBhE4k24Gh1XpDAXywNWKKN2+GaW/pItBmDQ
         p2z2X4wTO2Z0nLnHAzil+lvlabOVKEPnA8fL5TgIn5KHxoEtZHu6hScJiE22o3TRieQb
         WgiQ==
X-Forwarded-Encrypted: i=1; AFNElJ98Qq2owyojWu20dZPzxOHg1ax6CEV07E2i4IwokIs0jAVKcAjGDRSOaiz/HSzmbR77AfYXz4IPSMOuijBCGmEx@vger.kernel.org
X-Gm-Message-State: AOJu0YwqkytRqx/HCZyM46/WTGg2NGSZTRp7tqUxWth0dxFo+y30dQRd
	JzdLKCPeRCRUrcachivvGqSxAQmewutzJeCMAeaCjc/nIPpxcC9H+qEy2aPMwLMWOIV4VtsWtmp
	xh3lvG3rz3g==
X-Received: from dybmi6.prod.google.com ([2002:a05:7301:f86:b0:304:ee5b:e1a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:320c:b0:304:e7c9:b528
 with SMTP id 5a478bee46e88-3077b2f4881mr6308555eec.30.1780868228366; Sun, 07
 Jun 2026 14:37:08 -0700 (PDT)
Date: Sun,  7 Jun 2026 14:36:55 -0700
In-Reply-To: <20260607060933.3274263-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260607060933.3274263-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260607213700.3563842-1-irogers@google.com>
Subject: [PATCH v18 0/5] perf tools: Add inject --aslr feature, early maps
 loading, and decoupling fixes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces the new 'perf inject --aslr' feature to
remap virtual memory addresses or drop physical memory event leaks
when profile record data is shared between machines. Bundled with this
feature is a bug fix inside the core map tracking tool that hardens
perf session analysis against concurrent lookup data races.

Detailed Mechanism of MMAP Mapping and ASLR virtual Address Allocation:

The ASLR tool virtualizes the address space of the recorded processes by
intercepting MMAP and MMAP2 events to build a consistent translation
database, which is subsequently used to rewrite sample addresses.

It maintains two primary lookup databases using hash maps:
1. 'remap_addresses': Maps an original mapping key to its new remapped
   base address. The key uses topological invariant coordinates:
   (machine, dso, invariant). The invariant is computed as (start - pgoff)
   for DSO-backed mappings. This invariant remains constant even when
   perf's internal overlap-resolution splits a VMA into fragmented
   pieces, ensuring split maps resolve consistently back to the same
   remapped base.
2. 'top_addresses': Tracks the allocation state per process (machine, pid).
   It maintains 'remapped_max' (the highest allocated address in the
   virtualized space).

For each MMAP/MMAP2 event:
- We look up the DSO and invariant key in 'remap_addresses'. If found, we
  reuse the translation, preserving the offset within the mapping.
- If not found, we allocate a new remapped address space:
  - We use thread__find_map to look up the mapping immediately preceding
    the new one in the original address space (at start - 1). If
    the preceding
    mapping was also remapped, we place the new mapping
    contiguously after it in the remapped space. This preserves
    contiguity of split mappings (e.g., symbols split by HugeTLB,
    or anonymous .bss segments adjacent to initialized data).
  - If no contiguous mapping is found, we insert a 1-page gap from
    the highest allocated address (remapped_max) to prevent accidental
    merging of unrelated VMAs.
- The event's start address (and pgoff for kernel maps) is rewritten,
  and the event is delegated to the output writer.

To remain strictly conservative and guarantee security, the tool
scrubs breakpoint addresses (bp_addr) from all synthesized stream
headers, completely drops PERF_RECORD_TEXT_POKE events to prevent
absolute immediate pointer operands leaks, and drops unsupported
complex payloads (such as user register stacks, raw tracepoints, and
hardware AUX tracing frames).

Verification is reinforced with shell test ('inject_aslr.sh').

Prerequisite Bug Fix (Patch 1). During development, a core map
indexing issue was identified and resolved to prevent concurrent
lookup data races during session analysis.

Changes since v17:
- Patch 2: Reordered ksymbol deletion logic to ensure
  `perf_event__process_ksymbol` deletes the map *after* the
  `aslr_tool__findnew_mapping` translates the unregister offsets.
- Patch 2: Changed `aslr_tool__delete` to cleanly handle guest machine
  deletion memory leaks.
- Patch 2: Resolved read-only segfaults on memory-mapped perf.data
  headers during attribute stripping by using deep copies in
  `perf_event__repipe_attr`.
- Patch 2: Fixed user space remap invariant logic to include
  `(start - map__start(al.map))` preventing negative overflows on module
  offset boundaries.
- Patch 3: Removed duplicate `bswap_64` payload byte-swapping inside the
  array logic, allowing the host endianness macros `COPY_U64()` to
  handle it dynamically.
- Patch 3: Fixed LBR branch sample starvation by explicitly reading branch
  counters instead of dropping the entire sample.
- Patch 5: Fixed test flakiness by grepping out physical hex addresses
  `0x[0-9a-f]{8,}` instead of matching exact address strings.
- Patch 5: Parameterized temp reports and updated test to scale with
  `/dev/urandom` continuous random reads.
- Patch Series: Added Signed-off-by tags uniformly and Assisted-by tags to
  track assistance.

Changes since v16:
- Patch 2: Refactored inline ASLR stripping logic out of builtin-inject.c
  and into dedicated helpers (aslr_tool__strip_attr_event and
  aslr_tool__strip_evlist) in aslr.c to better separate concerns.
- Patch 2: Fixed guest machine allocation memory leak in
  aslr_tool__delete() where machines__exit() explicitly skipped freeing
  the guest processes tree.
- Patch 3: Fixed bounds-check violations during cross-endian parsing inside
  aslr_tool__process_sample() by correctly applying bswap_64() to raw
  offsets, iteration counts, sizes, and addresses prior to logical
  evaluation when orig_needs_swap is active.
- Patch 4: Fixed pipe mode parser misalignment bug by safely fetching
  needs_swap from the initialized evsel rather than blindly intercepting
  HEADER_ATTR events prior to session parsing.
- Patch 4: Resolved checkpatch.pl line length warnings in the bswap_64
  endianness swapping logic.
- Patch Series: Reordered the final two patches. "perf aslr: Strip
  sample registers" is now Patch 4, and "perf test: Add inject ASLR
  test" is now Patch 5. This ensures the register stripping logic
  is fully introduced before the comprehensive shell tests validate it,
  preventing bisectability test failures and easing merge conflicts.
- Patch 5: Fixed "User registers stripping test" starvation when run as
  root by explicitly using '-e cycles:u' during recording, preventing
  the ring buffer from overflowing with kernel samples.

Changes since v15:
- Patch 2: Added bounds checking for event->header.size before writing
  to breakpoint fields to avoid heap buffer overflow on older ABI events.
- Patch 2: Fixed asymmetric calculation bug in aslr_tool__findnew_mapping()
  where pgoff for anonymous kernel memory was not properly subtracted upon
  insertion, causing the lookup addition to overflow.
- Patch 2: Added detailed comments documenting the symmetric lookup and
  insertion math for unmapped and mapped memory blocks.
- Patch 5: Add missing kprobe and uprobe scrubbing of config1 and
  config2 during aslr_tool__strip_evlist() to strictly conform with
  repipe constraints.

Changes since v14:
- Patch 2: Removed unnecessary vertical whitespace in builtin-inject.c.
- Patch 2: Added comments explaining why pgoff is assigned for
  anonymous memory maps to prevent ASLR leaks.
- Patch 2: Removed orig_last_end tracking and refactored contiguous mapping
  detection to use thread__find_map(..., start - 1, ...) based on Gabriel's
  feedback.
- Patch 2: Scrub kprobe/uprobe event config1 and config2 fields to prevent
  address leaks.
- Patch 2: Overwrite pgoff with the remapped start address for anonymous
  mappings (detected via is_anon_memory and is_no_dso_memory).
- Patch 3: Fix C90 mixed declaration error for orig_needs_swap.
- Patch 3: Temporarily disable evsel->needs_swap during the secondary
  evsel__parse_sample() call to prevent branch stack double-swapping bugs.

Changes since v13:
- Patch 2: Added a NULL check for env before calling
  perf_env__kernel_is_64_bit(env) to prevent potential segfaults if the
  recorded environment has no headers.
- Patch 5: Fixed sample_size and id_pos going out of sync during
  aslr_tool__strip_evlist() and aslr_tool__restore_evlist(). Instead of
  using evsel__reset_sample_bit(), which was acting as a no-op due to
  early bit clearing and corrupted sample_size, the tool now directly
  updates sample_type and recomputes sample_size/id_pos dynamically.
  Added orig_sample_size to aslr_evsel_priv to correctly restore the
  state.

Changes since v12:
- Patch 2: Fixed potential NULL pointer dereference in
  remap_addresses__hash() when handling unmapped memory events (key->dso
  is NULL) under REFCNT_CHECKING.
- Patch 2: Dynamically detect machine architecture bitness via
  perf_env__kernel_is_64_bit() to select appropriate kernel_space_start
  boundaries, avoiding 64-bit address injection on 32-bit platforms.

Changes since v11:
- Patch 1: Fixed struct dso name accessor in maps.c by using
  dso__name() instead of ->name.
- Patch 2: Fixed hash function in aslr.c to hash the underlying
  dso pointer using RC_CHK_ACCESS to support reference count checking.

Changes since v10:
- Patch 1: Added explicit tracking array logic in maps__load_maps()
  to correctly accumulate valid maps (skipping NULL entries after
  failures) and safely return the exact populated count, resolving
  out-of-bounds pointer iteration panics.
- Patch 3: Fixed endianness bug during cross-endian sample parsing
  by passing evsel->needs_swap instead of false to __evsel__parse_sample
  in aslr.c, ensuring correct 32-bit field byte unswapping for packed
  fields. Refactored evsel__parse_sample to take a needs_swap argument
  via __evsel__parse_sample.
- Patch 4: Fixed inject_aslr.sh exit code handling in trap functions
  to capture and propagate the correct pipeline failure status code
  instead of unconditionally returning success or failing the test.

Changes since v9:
- Patch 1: Added `-ENOMEM` error check inside
  `maps__find_symbol_by_name()` and return `NULL` early. Added map
  sorting state invalidation on early return in `maps__load_maps()`.
- Patch 2: Fixed encapsulation by using `thread__maps()` and
  `thread__pid()` accessors in `aslr_tool__findnew_mapping()`. Added
  `pr_warning_once` warning when raw auxtrace data is dropped.
- Patch 3: Fixed encapsulation by using `thread__maps()` and
  `thread__pid()` accessors in `aslr_tool__remap_address()`. Wrapped
  `evsel__parse_sample()` to temporarily disable `needs_swap` to avoid
  branch stack endianness corruption on cross-endian files. Fixed ISO
  C90 warning for declaration-after-statement for `orig_needs_swap`.
- Patch 4: Fixed duplicate cleanup by explicitly removing trap
  handlers (`trap - EXIT TERM INT`) inside the `cleanup()` function.
- Patch 5: Fixed heap corruption by adding size bounds checking before
  writing to `sample_regs_user` and `sample_regs_intr` fields. Added
  missing register mask clearing logic for the `itrace` synthesis path
  of `perf_event__repipe_attr()`.

Ian Rogers (5):
  perf maps: Add maps__mutate_mapping
  perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking
  perf inject/aslr: Implement sample address remapping
  perf aslr: Strip sample registers
  perf test: Add inject ASLR test

 tools/perf/builtin-inject.c           |   81 +-
 tools/perf/tests/shell/inject_aslr.sh |  519 +++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1398 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   44 +
 tools/perf/util/evsel.c               |    6 +-
 tools/perf/util/evsel.h               |   10 +-
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |  149 ++-
 tools/perf/util/maps.h                |    3 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 12 files changed, 2230 insertions(+), 71 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.1032.g2f8565e1d1-goog


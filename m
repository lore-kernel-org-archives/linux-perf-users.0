Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0531E822
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688939; cv=none; b=G0nE31Cq+eI/E70Fg8ZiGVroNbP8ULxTxL11p57MHbLusJQQ8zbfTRaWJDSbl1eDpza4wfm6a9ZzJZYHPfiWrt+pvX5yXxRBYkH2y7AQi8sHMypn281map4GNPigxFfXQ7qm0fWsS+urasuKvYOKy+QtVaQo06aJxL6iaVUAOw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688939; c=relaxed/simple;
	bh=vH8JPYkmfDPirKqN4tloJSxM3xmj3Q66YGEkDTrUqWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q16NrHN96/AGHXQlf1vMSeJBA0d/4WLrL7d9uQmVaBesS9JEQH3TnQeZWEvHZ8Oix8EC/gKf3sX2sZiZ6tQjqF/qC60iBgj5Q7fQwhKplT7HOOkINg8fFLKjLLRyi9E1a7YcuCWSETz1n8yrfYrd40IbBFz96FBWUBbqhJiLoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FADnf88u; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FADnf88u"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-135916eefa0so5712281c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780688936; x=1781293736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1J/uP7fTUPdXjo06p3HYoJsYxY1PE0Uh2rOy8EhKefI=;
        b=FADnf88uezT5EyB7Oe2y4/u6gNBCxjaO8vyheagjvHTDOsv16beNoc8nYFziBdotMx
         67tE99LZqP9zB6K7MNN+ToTEYKXPisty4WKZKPJO1rL3q8KvRBYk8r5nznUXVK4dtb4n
         Hs4fek56izbhz7Z1eitzHhIJ7AKNyN5aGQbBO9WaZiY7zmsqSdPY+7Yv+xWKvR75mJuN
         sb7XIhq+Av/pgvorLAytyS3+M63Jrm64XmXc3uNwrUwpBQWLPrp5Ticrm660x/ZAZfoV
         lzWK4OE2aH3DLL5m07AHMegaFKngdnF0JRi2tBcPtm/eTTcZ/stOLSZdu3kHgADEn8Jn
         s1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780688936; x=1781293736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J/uP7fTUPdXjo06p3HYoJsYxY1PE0Uh2rOy8EhKefI=;
        b=MLV/T0NaCJrw8DvO1GrkFtSyOeN6SMTpCoyDm3F5B6P7QnWJ/DUiLdzedncWXOF70U
         DLdfGCL9gFtoO8sAA1AV+GGALU2d3o938TTveEJxdPM3rSXKiTr85P+OMglNWXzWGhAS
         t10rXITUN4gFfit7uSyZ74bHYP+gwm3B1mo0N1/d2xOUUCiOxpyObxkcOrW99Uz0QrfK
         eRDKGoFm4M5G73iZ71LotYcnIUzET+r2Jzo20PuO7cLxfRS1n+cGaBxnTqVE49xm+paa
         AVUHWPHx+26rMOA1d0JKvZykJN8cVTw9CFWowpyRBSN9w4mSjWJaf0cBfYVYkphZQotm
         31Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/GMcUCj62lFQsWwz/ZDaIQrPL5IkOMKnlzdc401vWlOxxxjmMj50T9SqlLhYgaNV4k20GJwujVlYS/RXarJUSN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9f/+8PM5EVF4oqK4hmrMY6mlhKhU7NmHhDZvVhinqBE2PrMF
	CSnR1VhQgkfmgaMwESzrMmK/WyoMgq1UCbhs4o1939EqtjazlNuF/QwwPqbMzf82qXSjEF1Akpx
	X0M25lpbTMA==
X-Received: from dlk38.prod.google.com ([2002:a05:7022:126:b0:137:fec5:89b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1e01:b0:138:22f:9a42
 with SMTP id a92af1059eb24-13806669df0mr2466276c88.9.1780688935232; Fri, 05
 Jun 2026 12:48:55 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:48:46 -0700
In-Reply-To: <20260605192425.2523260-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605192425.2523260-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605194851.2533568-1-irogers@google.com>
Subject: [PATCH v13 0/5] perf tools: Add inject --aslr feature, early maps
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
   virtualized space) and 'orig_last_end' (the end address of the last
   processed original mapping).

For each MMAP/MMAP2 event:
- We look up the DSO and invariant key in 'remap_addresses'. If found, we
  reuse the translation, preserving the offset within the mapping.
- If not found, we allocate a new remapped address space:
  - If the new mapping is contiguous to the previous one in the original
    address space (start == orig_last_end), we place it contiguously in
    the remapped space. This is critical to preserve the contiguity of
    mappings for downstream merging (e.g. symbols split by HugeTLB, or
    anonymous .bss segments adjacent to initialized data).
  - If not contiguous, we insert a 1-page gap (using page_size) from the
    previous maximum allocated address to prevent accidental merging of
    unrelated VMAs.
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
  perf test: Add inject ASLR test
  perf aslr: Strip sample registers

 tools/perf/builtin-inject.c           |   79 +-
 tools/perf/tests/shell/inject_aslr.sh |  519 ++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1268 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   41 +
 tools/perf/util/evsel.c               |    6 +-
 tools/perf/util/evsel.h               |   10 +-
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |  149 ++-
 tools/perf/util/maps.h                |    3 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 12 files changed, 2101 insertions(+), 65 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.1032.g2f8565e1d1-goog


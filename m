Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1331E822
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780693016; cv=none; b=X/QVoWOoGKFsSpDOm1v1SYYDW0sNjJTyIijRADaQGBvsMz7+ZrmF+4S/QrAzmY5U+uJqtyYuxueFuizobo6TEQxI8tegpjak8UNwC9TkfTmfPddOtncPEG4nYnaHwvLONBL7UVr1oSDALBMAmuEHHv2P6NUBg0zv5Ca1n2oL2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780693016; c=relaxed/simple;
	bh=1KDedsWeVV197VLXtsYur8byb0Vfl2zoyZ9WALO003E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LrYUm8JAc6SUu9m3WHW/Q5NFBeYkWqLkU/4v+wHZ4Q2k1YakHtDciFmlw1tMsXk5/NWYhzfn8xSpDqshRq3X+7gSU7/PrqLA/Fz2CUP2PidmRFz4A3e6Z5Lom2OKMp/Ox3OtrnSt4lgI9cZ1C2xEK2w57c/3J4FMA8VKFjcPbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3Q3Hdrz; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3Q3Hdrz"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304df51ff3eso2063747eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 13:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780693014; x=1781297814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=De2XyD9fFC10ZREZubyNAz1vn0C0LivUJsJ59i36cQI=;
        b=n3Q3Hdrz+9DaAQ6UmEN5eunozW7+rojiNfvp76xlJbsvny1TLtzKi5zzB1hcZrCM2O
         gaVV0pcRAooyhMDtr1khQV++TO7qRN60m2mJb02Pz3XyZf+tNE7Us16lU/ZGCp7+Z8Tc
         QiGr9RyS1wQxH9M4+tMi6lKuSXxChFk8o04fzOK8XzccSxR+/7aDpMcop6V9nLC406yU
         W/RekG46u8a7zcMS3jJ4D2e1lod1E4agTzQoJlBoZD7Hn5liH0ezRzAp1r+YL7q/2pyA
         P47x6O39ppNAqID/iSxFO85Sr/ABkyqFEqWRjMs08p66t7wVLgXClZ2HlbK1UKJxg5ub
         cqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780693014; x=1781297814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=De2XyD9fFC10ZREZubyNAz1vn0C0LivUJsJ59i36cQI=;
        b=rlsrQNfv51h7hjy3DiNx9+bk6Jq8X28UzIWJMW/GHX52O+xU4WQiqNoSIxet0fOuEM
         GkFyrGn3QY0w3WNG48Y275tvo8J/AXXF0KmYrUWIqd9xZ8V4GRc7oSBj55nzVMJEc0VQ
         6qiGil8H7jz+2A+MKO9J55ktVEp38DBfoocuZcQVd1T36uTAeKeNcRmHqFQ5jyBV599v
         GyF8eJSA2CWzHX9eSqMCg+9jkyluvJOZXike91xZ/NmKYS3D37q6eFzir1zxhF6nyiLK
         4DenqXU87FuMluGHE/HN6mFhhIg6Jk3Mhylj72SgFyKuDOz/qV0ScFvjk3+ay6NGEHoK
         ErnA==
X-Forwarded-Encrypted: i=1; AFNElJ/BeFL+MbDxG/yfARr8mWk/Qxd/no2x1sj7In7wtUlr6yJxNP8jvd+SmVenTt/4jC/TKVbDreu0QjEOQRcH/iUH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxok3S2YoGeW9Xi6Jo+OKznlpordkUM7Ay85Vf5BpeE9XDaqZZY
	mrrb62tUgH0n6VgKXAfjEIQRo0ZJIi0sYHqlRRfl5A87WoRT3qo7as+qRmeU+zDbGVJmSalQGWP
	TFtYTqhBcPg==
X-Received: from dlak14.prod.google.com ([2002:a05:701b:290e:b0:138:7f5:cf8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b84:b0:137:f532:e345
 with SMTP id a92af1059eb24-138067207c1mr2265865c88.26.1780693013540; Fri, 05
 Jun 2026 13:56:53 -0700 (PDT)
Date: Fri,  5 Jun 2026 13:56:44 -0700
In-Reply-To: <20260605194851.2533568-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605194851.2533568-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605205649.2566948-1-irogers@google.com>
Subject: [PATCH v14 0/5] perf tools: Add inject --aslr feature, early maps
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
  perf test: Add inject ASLR test
  perf aslr: Strip sample registers

 tools/perf/builtin-inject.c           |   79 +-
 tools/perf/tests/shell/inject_aslr.sh |  519 ++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1272 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   41 +
 tools/perf/util/evsel.c               |    6 +-
 tools/perf/util/evsel.h               |   10 +-
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |  149 ++-
 tools/perf/util/maps.h                |    3 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 12 files changed, 2105 insertions(+), 65 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.1032.g2f8565e1d1-goog


Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DF2253B0
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780730492; cv=none; b=H66BoYJvk9DGe3gpLMm7jHuvG22ITqYv2ba7euLqNbdnTt4LMMSIr5JzRN/hDktjNudctDq6q28S/9mhq43mkRY9LvqVXIE3VJdlDvnNgm24y4+N9+SeaKFvTI7hkOutvDK3/P9lp4+mf/Jhu+WZx9wKuN243Gvttf41zIW5+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780730492; c=relaxed/simple;
	bh=3qL90sxO5+8pRF+rd31S2NC+v3zhz9KwAL8KBTm2tog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Irq0rPMAL/7BXn/CnPVmnzVsSD/QGbJYPMyeEPQvgxaAnP7+rFKsIfHb2MFwVVHg87Cn5G+CkyXa8uEGPzEVjusPuQ5O8Mqlg05Ov93gM3Ws7POu7uY2pXZl8Uc3quuVzRsrWf6/sGmRbJRRYBA0rTtgPxsOdB6dzrRipCFpMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PItBN1/I; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PItBN1/I"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137f304f564so7177317c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2026 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780730489; x=1781335289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOQh91Bv0feOun3gETERa1E4EQJSTeubDaZ7yl0TIro=;
        b=PItBN1/IKv0u9k59GzeOm21LiGcoKr8uBzkHiX0qU7DuWp5ebZDuWs4SsQLFE0Z2Mf
         2iMIBB3miVY06TC5vaQ3BMOQJvQkLBNWp9USASJ0qh+NNyzVh9HMIQJip0K5/+UwxYj2
         v9EBOh6/Nyms8pL4lTPDXajJ3ZfQeFP8ykU5qC1SF1l1boLtcLFWbIZjngKkmr9jEJJa
         lSA29IqpjjK2gn9oSGN1STii6JcPjpsOm5QydczkdY6THA2zq7laYP0ZQoR9F711CIaA
         n6mF47k3uEIH9LrxVgMONNzISZ8lLRBoN4UHdew8kuAkCnZ1wzDRXd97eAAZ85gAajK7
         SgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780730489; x=1781335289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOQh91Bv0feOun3gETERa1E4EQJSTeubDaZ7yl0TIro=;
        b=lYMWAsPC+s/RniD9pAXpK8/hrNSkMHZIqAtdnorjI+K6yW4muzTnDpAOtc0UyZt5C1
         1pHxd/Rq/LeR4A87bUDxS3R4AyIb+Iv98GoaUn/wV1BTifnjDu/xtR4oT5poZKL3hzw2
         TJsSjzc069wP7nYt9r5801Nhnl34xTsgUj7QSi63hzvc1aySF5kJrwlrgwyZTN9NNGn4
         S0EAD1Q8/7vepXEpJVzwEzxYfQJCK+46dXGICLSOtdrEZHFQXet48Kyq5rjfASCMPzdy
         5XX0sAJJ1RrVGRkdFz3brBnqp/gnjQC/5FsB+d8upIuEfswnjTgBBgPi21O/JEbukC83
         P+9A==
X-Forwarded-Encrypted: i=1; AFNElJ8f7CqgZk+w5psbSWMijBKUVtff2sawsq5M6EvE0w8eoNgSwrZrLaff4gxpgIo08kO2tnfwsv/2vw/MELE5JEUB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+1uHfYXTEYPXDzP+bxH2+Whi2n22P27LnymjyNu1sl4yT4HbG
	mqZsC1awbSeEAlI+hdYOpoZOHFZwkE046i3n8IEvjTGY1UwsBV1gy4T726Zxm7Jcyh9ojMVFyiG
	n3FRGpdf1pg==
X-Received: from dly15-n2.prod.google.com ([2002:a05:701b:204f:20b0:138:7d2:f099])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1005:b0:137:eb21:eafb
 with SMTP id a92af1059eb24-138066bddb4mr3758013c88.13.1780730489192; Sat, 06
 Jun 2026 00:21:29 -0700 (PDT)
Date: Sat,  6 Jun 2026 00:21:20 -0700
In-Reply-To: <20260605205649.2566948-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605205649.2566948-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260606072125.2786845-1-irogers@google.com>
Subject: [PATCH v15 0/5] perf tools: Add inject --aslr feature, early maps
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
    the new one in the original address space (at start - 1). If the preceding
    mapping was also remapped, we place the new mapping contiguously after it in
    the remapped space. This preserves contiguity of split mappings (e.g., symbols
    split by HugeTLB, or anonymous .bss segments adjacent to initialized data).
  - If no contiguous mapping is found, we insert a 1-page gap from the
    highest allocated address (remapped_max) to prevent accidental merging of
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
  perf test: Add inject ASLR test
  perf aslr: Strip sample registers

 tools/perf/builtin-inject.c           |   96 +-
 tools/perf/tests/shell/inject_aslr.sh |  519 ++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1299 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   41 +
 tools/perf/util/evsel.c               |    6 +-
 tools/perf/util/evsel.h               |   10 +-
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |  149 ++-
 tools/perf/util/maps.h                |    3 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 12 files changed, 2149 insertions(+), 65 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.1032.g2f8565e1d1-goog


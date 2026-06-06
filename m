Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C13AFD1B
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780758904; cv=none; b=rJ5b6AVmcVnKzX/eU/vg/3C0vQe5QSttntm9wWDaL8obKp6Q3EeWK42YDv/5PM/jKqf9rBPKgdEcuRyLM0Tu/apVxNFZ0w8kaGS85Gq04qGqDDj/FEFcy4Ti0PCK/3BTPboN7dKRWgXmi9SoBltWw6ynbzuZCT8mL4S/GdWVuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780758904; c=relaxed/simple;
	bh=YhgoGHMNpnW9JpeUF9+TMv+j9gScTgFvntxsb+ynrl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u4ZH/dSw+o1FW8EXrjVN/zhen/2L1NSYTQa4BgRFiwAHgJshRhG1QPHVSOL0se6YYU0oK5oPhI66VYWF7KrT2l5FZwqfN6O7iBvoSFUCO00MFFXZ64exjoNA5+cGehJLBrMUmuMaMJdEcMBaT+DldznW47apdrkBXERbl2b6QZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NI/Ebm/M; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NI/Ebm/M"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3075fa5a407so1162189eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2026 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780758901; x=1781363701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WVncgs0Wj4cr28/YhDTFkSQ+e6UITgAvcbWCWhc7EI=;
        b=NI/Ebm/MTZ3qKhw7s+rWEpFIFYg5f2UyVFf2JV8kwopBQkFPNe5jZr2uw2C30R/lfV
         6BO1vlK3rtL/BVKIu+qFuRVjfqeZK0+lDr6bZM76KZGLies5LuOeXLVuq6cqfjljyG78
         bL4oGMzHnOZwtCCDkB0zVpOeDvfwakxlS0QuTdmdFUtVubMH72isNb587v7TRRve1hXX
         T4A+3FzZHuHiiLRBNvMnbPYPG8eqvtN3IdLdoCbiC5mVYgY6XrJv3w9YHUlo7uDx+lXW
         ly5RIwdqW4MoMsy1Eda0K+FW9J6DB8DLgRUnQmShEGGporkROFXqzGgdsGKGnmfKwyH6
         nAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780758901; x=1781363701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WVncgs0Wj4cr28/YhDTFkSQ+e6UITgAvcbWCWhc7EI=;
        b=dS1R2VJaG0yHcGuX8KEfZBLBAnjsE1uarbfhZ/lkV67D8H62HCXSy9V9VnGxIU7pUf
         +XKNX2AyJjBBlMOOS4clFzvmicc6ARb/V0yUTg2+oF9W+w6bNC1Rpatm3y6PBx9KbYJ8
         B456RQEqMhWin9RL6X6OrENOdhDoGRFJcBHHeX5e/0HPbnRwko8Kv0oKUAB8LRI8KvpN
         Jw+6QV+9251PIjw5p5ItujPtR45LpPmmZv8lnJqX6zCGYhSf4wd+FwlZNhlgWrA2cBNf
         Wmcn3wqbewD/uvSj3B4a7Lkz64jA3fgAFZVKrlV+zj1vo0lN7VIRj58KYhatZsMxL+Hm
         Ogrg==
X-Forwarded-Encrypted: i=1; AFNElJ822bwArJ4Qm8ydNVR5LAnIIjPAmzz8kPYkxApHRQcuFFJNSY6t0zPn52RMJSPFFRtBRpzMPdUDAXGqHfuNCihL@vger.kernel.org
X-Gm-Message-State: AOJu0YyfIOEdPN32AgzP6huiz/2KNKnVDBhZZvdMwQRj/bYZll/Pg20u
	mCXbOd3whEYEyz7+2tt3fyZadnX8HenI0Tt5RB4CjXBzbNiJuUmT+G9FSaEbWJyLMLSyhlxPttT
	8XUcJCxiXFA==
X-Received: from dybpl3.prod.google.com ([2002:a05:7301:4303:b0:304:d272:2198])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1e4a:b0:304:de2b:446f
 with SMTP id 5a478bee46e88-3077b7ebe91mr5032872eec.28.1780758900649; Sat, 06
 Jun 2026 08:15:00 -0700 (PDT)
Date: Sat,  6 Jun 2026 08:14:46 -0700
In-Reply-To: <20260606072125.2786845-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260606072125.2786845-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260606151451.2913860-1-irogers@google.com>
Subject: [PATCH v16 0/5] perf tools: Add inject --aslr feature, early maps
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

Changes since v15:
- Patch 2: Added bounds checking for event->header.size before writing
  to breakpoint fields to avoid heap buffer overflow on older ABI events.
- Patch 2: Fixed asymmetric calculation bug in aslr_tool__findnew_mapping()
  where pgoff for anonymous kernel memory was not properly subtracted upon
  insertion, causing the lookup addition to overflow.
- Patch 2: Added detailed comments documenting the symmetric lookup and
  insertion math for unmapped and mapped memory blocks.
- Patch 5: Add missing kprobe and uprobe scrubbing of config1 and config2
  during aslr_tool__strip_evlist() to strictly conform with repipe constraints.

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

 tools/perf/builtin-inject.c           |  104 +-
 tools/perf/tests/shell/inject_aslr.sh |  519 ++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1322 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   41 +
 tools/perf/util/evsel.c               |    6 +-
 tools/perf/util/evsel.h               |   10 +-
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |  149 ++-
 tools/perf/util/maps.h                |    3 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 12 files changed, 2180 insertions(+), 65 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.1032.g2f8565e1d1-goog


Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF94071C9
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687472; cv=none; b=EsB4tjKDmHDudT25KVEUFrLyLdgGKrSFUFVIQQUzODBKkCF3x/2Qq20wPzYPIvAdthZJrg+MQYZp/YjTbI8GvkobaTm/Z82m4ud7u6md3TZpZrB0kwrWctB+BPMBHqfvz99ZiWuW0msfJhxLFE4REyXt+h4XdAMLTw7og9zdHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687472; c=relaxed/simple;
	bh=oJtunC5FxPhziysVB0egRg9T6kbbvadjyqwXDbd71gM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2pvUFwLv0mu7libi1kVVNnZxFALVqqk6mmxxiRPArajurlKCVlQORZZXcQsVpk1V5AQdt5GAkG9gTZjXtgXcQM7Ddb4fmIj2MHlpqWpanqkydVKEPHYmOI4ZZVMMvAH+wCI13qwDqbBBE029RseVuJr0vLjbvPEfsKnteQRHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMVj2BjG; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMVj2BjG"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304dd917645so2216837eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780687469; x=1781292269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6aDBkuqaqItsJQZ1pNtDNFRDLj9xVKwqhCqIqv/Bbk=;
        b=OMVj2BjGQb+UBuyflpDOByHpf2raTY/tzJuUAOLKdP6C9BRlRoBJT9xiOk+ixwWObp
         anuiUMAbB3ad/PdmWXPcmboNIvJPBjtfxdsTnErq/Tq5w5zGKpE/LJJWuFgFgyEEnOOr
         KyB96aj2RJFs0y7M7qEqEAQWbeVrupHLL5j4YxHFYkZ7OU8ecgJG3KJZ5jTFhykM/NfS
         Em55dXckcp9k7mOpwwRaie/WVV62yYx6ewXFT6Mhgfc4irB1b9LGZAAAa4MV81l+asHn
         07Os5lnMIxJhOIz0raIGQ4DhzJa8e9i5owB8TnmbQ9fGovQtZsbhGz7bIUfBROA5jYw5
         HHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687469; x=1781292269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6aDBkuqaqItsJQZ1pNtDNFRDLj9xVKwqhCqIqv/Bbk=;
        b=SwSs5Jcxs83lj7vSeemWG7HFa/Obz8gnVhn8eZz2kKX/hGmLUzO88ijWStUAso+c0j
         XsP15lrinDhAyCt/0OTD7FTa/0EDVAYnqnQJV4KYlx/0QjA49upmJYKrxYfYuveQMZrC
         HiIf0kfBIxGmiulaFBXPDyZiyka22LeOz5ZyTgWq4GabLLXf1NtyG6UQxv4fRsUYyO5U
         a19RcwTVv+G493oTkBQiALkNgbcmtjIzIh66GgDNovwDreHyhCHKfDfFDKdWtx+SyZLP
         cryuPeTbc3m+oBcd5C0Z9SmgoslLNqYktcB87n+9q63DZH5X4Pr69KyTMVs71+Ry7XjT
         L7HA==
X-Forwarded-Encrypted: i=1; AFNElJ8trp+zlEpz2XcUsdok3BTDO7x4rk+0XVF35hQ19nmtAHWr21QrRkGx4v+YVDPi31mPpvkSdWFiLl4Dngncx5PD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaa1pmtIi58O/ogSaHCgSFPSH1BKrkW4/zw/l9q2E/PQJMiPpS
	Xry2wbNUIkmp+XXGBqKLKEVC5cnkAg9uFOx0JIdwvg/HNuKZzbWz62iDkwkEhgUbKe164RWnZUz
	ZHy8AhYR2dA==
X-Received: from dybhh11.prod.google.com ([2002:a05:7301:290b:b0:2f7:767f:edba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:748b:b0:2d0:239a:23cb
 with SMTP id 5a478bee46e88-3077b1cc7f6mr2644441eec.16.1780687468420; Fri, 05
 Jun 2026 12:24:28 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:24:20 -0700
In-Reply-To: <20260605185215.2359881-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605185215.2359881-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605192425.2523260-1-irogers@google.com>
Subject: [PATCH v12 0/5] perf tools: Add inject --aslr feature, early maps
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

Changes since v11:
- Patch 1: Fixed struct dso name accessor in maps.c by using dso__name() instead of ->name.
- Patch 2: Fixed hash function in aslr.c to hash the underlying dso pointer using RC_CHK_ACCESS to support reference count checking.

Changes since v10:
- Patch 1: Added explicit tracking array logic in maps__load_maps() to correctly
  accumulate valid maps (skipping NULL entries after failures) and safely return
  the exact populated count, resolving out-of-bounds pointer iteration panics.
- Patch 3: Fixed endianness bug during cross-endian sample parsing by passing
  evsel->needs_swap instead of false to __evsel__parse_sample in aslr.c, ensuring
  correct 32-bit field byte unswapping for packed fields. Refactored
  evsel__parse_sample to take a needs_swap argument via __evsel__parse_sample.
- Patch 4: Fixed inject_aslr.sh exit code handling in trap functions to capture
  and propagate the correct pipeline failure status code instead of unconditionally
  returning success or failing the test.

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
 tools/perf/util/aslr.c                | 1262 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   41 +
 tools/perf/util/evsel.c               |    6 +-
 tools/perf/util/evsel.h               |   10 +-
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |  149 ++-
 tools/perf/util/maps.h                |    3 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 12 files changed, 2095 insertions(+), 65 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.1032.g2f8565e1d1-goog


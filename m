Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490947;
	b=Ysl494IHfQiZSxlnK4XAQKBQ/UMIq31SGUsY6clwyDavS+FyIPnKlWO+ZQiAKaYsc67k
	 htjeA3YvejYLZ7I/9NGhTmGE07Yd02B51+c65C4VD5hIb2SEnFtHs/mUSb4BYh1gek2wR
	 qnii31Hg/KrXWqsUagkS/Hh9AbwBRJYMqaLIr9xy7NszMlzYKrj0YsqfA3E+Ge9jbBtxg
	 e7SNzGouPo6N+aFAeDbzk9Bt6matPHMTG7qIgtDjirDQPyo/bmE3QTEhwz8yNU+cpgMqU
	 ZCHRFZblX0QNqjviR0HR466Ljo9/Pd5B/MaVEsacwsww2m2Aj0sZrskgEWYlXfTDf4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=cpuKopDovXVOk9uj05vpNBdTWvqtu2b9B4Udf5NRqPQ=;
	b=eUUUUt7hxUtKECO57kwc1VEgKSLiebzSJ+kiuhzrB3pwJvw6FJnObFnPAD+B+c586DDR
	 tYqv9uivdGElJL3IP8hxQ5PCV1tf2b/fz+/OS9qmtddddKvQ9HasyzK60i0TMNihIe+kT
	 mxQIjP/Bz0nCnDGLFXFm+qEtoJ6kE6xvLjRt475KmapC8gHpRM1nm/VP+ieYdNSBiG/IW
	 jg3gHMHv0FN3hn6llfT0L0UZrUE9kM1xqKkKteHZA6ZYQhaDNympYsgpBcr0EcjutRRkW
	 36+CvTBgLNjXT5NJ9ZmIACEdU4P7IeLlQHHKE9h7M5LLOjcp2gHfK09UDAbHw3vUzcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RA6uzKdv;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2BE606A322
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F2BE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RA6uzKdv
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso3006931a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490946; x=1796095746; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cpuKopDovXVOk9uj05vpNBdTWvqtu2b9B4Udf5NRqPQ=;
        b=RA6uzKdvWblRRP8gx/O0RjDKU0lmdYzOQjYDQ5ue3DXAGxKypLu4bEz8CD0MXL7ZHd
         iOKt4w6gVe40ts78lvoB5K768WVSmhzCfahDTDzrMx+lKJxHdmaFjBKGL/XaiscCqf5/
         bJK9E/mpBoxLDjSg6cc0Qf6E0yNyGYAhT2t8cm1l+pq3EkDeWtm6FA2W4fmv5DYPsQLA
         AYYsngkXuNbX2dNUwqrHn0QIm9hCSxGTL8kZfz40VP2NgWXku+wfoF4h2iQf4MLTOU9k
         v2vVTRpFI53j6k9m9Z2xVmk32a8ieWc5dlCmuOQjpWfXZOTcA1lmYaEwvUuyK6qetYsn
         V+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490946; x=1796095746;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpuKopDovXVOk9uj05vpNBdTWvqtu2b9B4Udf5NRqPQ=;
        b=Zy+yC+IeiyL1//y3M/ZDIdaH7L2CH2q/lkMpBfVv+zV4mnOcfgEdtBAuiAbFryrnob
         lrd+ugihyTQ+XaaNQ1ILepXC3zrtMr/c0T/D779D902KqffFeQzx3rQVOzT6BYWRCGSl
         M6rV2025ZMlzjPLoit+T2rVhKc57vZ6mqDIeAifS29wOCXCPIXnmXpwLB3N0WdQ/chTQ
         tkilVEv4k5S9T5hLXAM7qBudIu1sJ6ir3U4vKzK2tTMieU7aPeVB4IbvrVW4K35tC2dR
         hrzix4ejg/ofXMc5pIl8A1K/af7/Sx8t7UqMEpN2najbfg6M4yIJYbeciZdF40w6nJKD
         V0/w==
X-Forwarded-Encrypted: i=1; AL+hErHM4xjPm9fZzwRihpM4GPprBRlp3a4vsxP8qUGcp61h2w21mGKYWFB6a7d00Zx9z2R8mZLNKCf4kAxeC7Wnwioi@vger.kernel.org
X-Gm-Message-State: APuU4Z+btltamiRAlM9wzh8iVEPhbr7F1x8JUJHULa5OqbywRNh1WkYo
	fFmTlUHXxO5swUWsXq+RtgrLMtYiLXzRG+fHKoIfxXVLvHObKhC5lwqMP02X5Ii3JYqj9USTvyR
	cR3W60h7saQ==
X-Received: from pjpx21.prod.google.com ([2002:a17:90a:a395:b0:3b1:1328:f835])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4483:b0:3ac:bc3d:6fe8
 with SMTP id 98e67ed59e1d1-3b41c92f8f9mr11623484a91.34.1795490945643; Mon, 23
 Nov 2026 19:29:05 -0800 (PST)
Date: Mon, 23 Nov 2026 19:28:51 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124032902.3859564-1-irogers@google.com>
Subject: [PATCH v9 00/11] perf symbol: Sorted array optimizations and memory shrinking
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patches 1-6 of v8 (reference counting struct dso in struct dso_symbol,
converting struct symbols from an rb_tree to a sorted pointer array,
adding rw_semaphore locking, and natural-run merge sort) were applied to
perf-tools-next.

Following Namhyung's feedback on v8 patch 7/10, this v9 series splits
the remaining four patches from v8 (patches 7/10 through 10/10) into
smaller, self-contained patches while cleaning up redundant state in
struct symbols, improving the struct symbols kernel-doc, and keeping
both sorting/insertion optimizations and session-scoped memory shrinking:

  1. Remove redundant num_by_name and sorted_by_name fields from struct
     symbols (replaced by @cnt and @symbols_by_name != NULL || @cnt == 0).
  2. Replace the @sorted boolean in struct symbols with @sorted_cnt
     prefix length tracking so post-sort appends only sort and merge the
     newly appended tail (or binary-insert in place for small appends),
     reducing 'perf bench internals symbols' append + lookup time by
     90.3% (1551.533 usec -> 150.333 usec).
  3. Add @sorted_tail_cnt tracking an optional secondary sorted run for
     out-of-order dso__insert_symbol() insertions with an amortized
     sqrt(N) merge threshold (keeping sizeof(struct symbols) unchanged
     at 88 bytes), further reducing append + lookup time by 71.4%
     (150.333 usec -> 43.000 usec; 3315.200 usec -> 294.000 usec at
     100,000 symbols).
  4. Unit tests for sorted insertion, unmerged-vs-merged two-run
     lookups, and equal-start symbol aliases.
  5. Synchronize dso_cache access under dso__lock(dso) and make
     dso->loaded atomic in preparation for concurrent shrinking.
  6. Add symbols__shrink() and symbols__try_delete_unannotated().
  7. Add dso__shrink() and dso__try_evict() to reclaim cached DSO data,
     debuginfo, unannotated symbol tables on unreferenced DSOs (reloaded
     transparently on demand), and unreferenced user DSOs without
     blocking on contended locks.
  8. Add dsos__shrink(), machine__shrink(), machines__shrink(), and
     perf_session__shrink().
  9. Unit tests for symbol and DSO shrinking, dso_symbol pinning, inline
     and srcline cleanup, and transparent DSO reload.
 10. Plumb dso__session() and add perf_session__malloc/zalloc/calloc/
     realloc/strdup() wrappers that invoke perf_session__shrink() and
     retry once on allocation failure.
 11. Unit tests for machine__session()/dso__session(), session-scoped
     allocation wrappers, and multithreaded lock contention.

Dynamic Insertion Complexity & Trade-offs (Patch 3):
  With a primary sorted run of N = sorted_cnt entries and a secondary
  sorted run buffered up to B entries before merging:
  - Shifting pointers inside the secondary run costs sum_{t=0..B-1} O(t)
    = O(B^2) over B out-of-order inserts, or O(B) per insert.
  - Merging the secondary run into the primary run costs O(N + B) once
    every B inserts, or O(N / B) per insert.
  Minimizing O(B + N / B) balances the two terms at B^2 = N (B = sqrt(N),
  checked in integer arithmetic via sorted_tail_cnt^2 >= sorted_cnt with
  a 256-entry / 2 KB L1d-sized floor), giving:
  - Ascending insert: O(1) amortized (appends and advances sorted_cnt).
  - Out-of-order dynamic insert: O(sqrt(N)) amortized, O(N) on merge.
  - Bulk symbols__insert() + first lookup: O(1) per append + O(N) on
    natural runs (or O(K log K + N) for K unsorted appends).
  - Address lookup: O(log N) across at most two sorted runs.

  Alternative flat-array structures were also considered:
  - Implicit array BST (2i + 1, 2i + 2): Zero pointer overhead, but
    unbalanced sorted inserts blow up array capacity as O(2^k), and
    in-place rotations move O(subtree) = O(N) entries.
  - Index-based balanced BST (left/right indices): O(log N) worst-case
    even on sorted inputs, but adds 8-12 bytes per symbol (giving back
    up to half of the 24-byte rb_node savings) and loses contiguous
    binary-search cache locality.
  - Bentley-Saxe logarithmic runs (<= log2(N) power-of-2 sorted runs):
    Reduces out-of-order dynamic insert to O(log N) amortized with 0
    bytes/symbol and O(1) sorted append, but degrades unmerged lookups
    from 2 binary searches to up to log2(N) binary searches (O(log^2 N)).
  - Packed Memory Array (gapped sorted array): O(log^2 N) insert and
    O(log N) lookup, but 2-4x pointer-array memory overhead, O(log^2 N)
    density rebalances even on sorted appends, and NULL-gap skipping in
    every linear pass.

  Because perf workloads are overwhelmingly lookup-heavy, bulk loads go
  through symbols__insert(), and upward-growing JIT/BPF allocations hit
  the O(1) ascending fast path (while even at N = 1,000,000 symbols an
  average sqrt(N)/2 tail shift moves 4 KB in L1d cache), two sorted runs
  keep lookups at O(log N) with zero per-symbol space overhead and
  minimal code complexity.

v9:
 - Drop patches 1-6 from v8 (merged into perf-tools-next) and rebase
   onto perf-tools-next (964e8b1c9c79).
 - Remove redundant num_by_name, sorted_by_name, and sorted booleans
   from struct symbols in favor of (cnt, sorted_cnt, sorted_tail_cnt)
   and expand the struct symbols kernel-doc.
 - Split v8 patch 7/10 into patches 2-4 (sorted prefix tracking,
   secondary sorted run for dso__insert_symbol(), and unit tests) with
   fresh -O2 'perf bench internals symbols' measurements.
 - Split v8 patch 8/10 into patches 5-8 (dso_cache locking and atomic
   dso->loaded, struct symbols shrinking, per-DSO shrinking/eviction,
   and dsos/machine/perf_session shrinking).
 - Split v8 patch 10/10 into patches 9 and 11 matching the code they
   exercise.
v8: https://lore.kernel.org/linux-perf-users/20261122050405.80335-1-irogers@google.com/
 - Rebase onto perf-tools-next (eb79d2fbc230).
 - Fix checkpatch.pl false-positive typo error in struct symbols field
   ordering and context_unsafe test helper warnings.
v7: https://lore.kernel.org/linux-perf-users/20261121071651.67118-1-irogers@google.com/
 - Rebase onto perf-tools-next (017fcfa4a4ab), adding Clang
   -Wthread-safety context analysis annotations (__guarded_by,
   __acquires, __releases, __must_hold) across struct symbols, dso,
   dsos, and session helpers.
 - Fix threads__for_each_thread() self-deadlock on shard lock and
   dso__data_open_lock vs dso__lock(dso) lock-ordering race during
   shrinking.
v6: https://lore.kernel.org/linux-perf-users/20261117185305.108003-1-irogers@google.com/
 - Split the monolithic symbols rb_tree-to-array conversion into smaller
   patches for reviewability (requested by Namhyung).
v5: https://lore.kernel.org/linux-perf-users/20261116063435.2817923-1-irogers@google.com/
 - Replace heuristic periodic shrinking with explicit perf_session__*
   allocation wrappers that shrink on allocation failure.
v4: https://lore.kernel.org/linux-perf-users/20261113171734.2188066-1-irogers@google.com/
 - Address review feedback on symbol sorting, alias handling, and
   shrinking safety.
v3: https://lore.kernel.org/linux-perf-users/20261110220803.2503416-1-irogers@google.com/
 - Add symbol table array conversion and DSO/symbol shrinking.
v2: https://lore.kernel.org/linux-perf-users/20261027231513.816148-1-irogers@google.com/
 - Reference count DSOs in dso_symbol and fix map_symbol lifecycles.
v1: https://lore.kernel.org/lkml/20260928075237.3055101-1-irogers@google.com/
 - Initial RFC.

Ian Rogers (11):
  perf symbol: Drop num_by_name and sorted_by_name from struct symbols
  perf symbol: Replace sorted boolean with sorted_cnt prefix length
  perf symbol: Add secondary sorted run for dso__insert_symbol()
  perf test symbols: Add sorted insertion and equal-start alias tests
  perf dso: Synchronize dso_cache access and make dso->loaded atomic
  perf symbol: Add symbols__shrink() and
    symbols__try_delete_unannotated()
  perf dso: Add dso__shrink() and dso__try_evict()
  perf session: Add dsos, machine, and perf_session shrinking
  perf test symbols: Add symbol and DSO shrinking tests
  perf session: Add dso__session() and session-scoped allocation
    wrappers
  perf test symbols: Add session allocation wrapper and lock contention
    tests

 tools/perf/tests/symbols.c | 791 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/dso.c      | 272 ++++++++++++-
 tools/perf/util/dso.h      |  16 +-
 tools/perf/util/dsos.c     |  51 +++
 tools/perf/util/dsos.h     |   3 +
 tools/perf/util/machine.c  |  30 ++
 tools/perf/util/machine.h  |   8 +
 tools/perf/util/session.c  |  78 ++++
 tools/perf/util/session.h  |   8 +
 tools/perf/util/symbol.c   | 332 +++++++++++++---
 tools/perf/util/symbol.h   |  58 ++-
 11 files changed, 1532 insertions(+), 115 deletions(-)


base-commit: 964e8b1c9c795982886a6778cb0cd73c901ca4ca
-- 
2.56.1.809.ga0b61035b5-goog


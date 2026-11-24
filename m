Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559474;
	b=1y+Ukyg8iB8Cj90DOZWZafhboXhf6ZcqHVj7+Nv0xU7WYU7FYICVPGuZpuwPBTRmlUb9
	 PMcEuGhLPxyOc3O+Uf8+Ht4rq3en7qB9mZnyVFORjcZQlQjbv+4cYklrgWFvaGmO8cQ6A
	 AuHLbhr9cFBkoeoyIO2PVP2+0/Ail8h9GapHlU4sowQLRWAbfhJzWaGqpBVZ5fxAmB6ZV
	 STmBD8N0n+VhClVXLMERuQt3h3JcF/N8N4yETcJBeW1V7CC6FgwLdZQLRlfos9CC8N/LX
	 DoYlL0uolEI9w53u4CXJPrZeikXu4zeyLRnTgAXBzr1y8/KX9VYw2tMCXOFYBPHpSKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eR2Yid5w58nZby8ErCVhupqRkyWBRMwZRADKAX0laNw=;
	b=UuNzJPgeFv2umIqZBJlgqp7FwHSTbTm29THDWP8UHaMiXjRedvhsosMS+Fhh00+SE794
	 ZcqWhOQrMjMQuFeeQNOWuVN/UvKwmE9xuWLkGACsC42HHjLOSpRaPIabmLQAqr9YFq9RP
	 583geYvJfgt5+hkpF5RA/iyiA2OZdL0cRIJUgnVlmiJoWtkKCDNuGQjmkFIpQSPyfSRZP
	 A253M7J0e8nBENNzthX8T0yLQlIeQLCXB9EcEZT1ox8ddCsQiZy0oOTb6b7UVvmGO/fiu
	 zqQy4P+B6Rid28Ps9khaSJtSfYwItOZnaN3FckH6GSsOUOlraHnNnYSrmYdUhTlRnRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hMLmuEHU;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF8606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEAF8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hMLmuEHU
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3ae17c536so4948015c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 14:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795559473; x=1796164273; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eR2Yid5w58nZby8ErCVhupqRkyWBRMwZRADKAX0laNw=;
        b=hMLmuEHUfV3g1QcrI51otiZdl+xrR/9/PhciQi2yQvocX9dBo+R1FG+rdTtBLkn/3x
         +f/kCIeXPMYnB/g2CER6F/VYGGhL3Q21UpO3cuKV35wQCLfeSDe8Avq8K5GFKu2+FEys
         twiaIl+8SDBVmD/Y1P9RRGbUEZbsyiMGS45TElC5rtMt+luBcLnkc9VoU5qfDQmlVjBa
         muz6LGndhb0oDggHvFqM/reVrN60Lr1R2TGhKmPrHDhtk4TFX9YTr1pepx88emf5DrWk
         sNfRJumZWaYh0TEyrgThKraiu6ByNPeQoDMe2q954oIxmvNyPBbtxqeOxpT8gqYDpxGQ
         tyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559473; x=1796164273;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eR2Yid5w58nZby8ErCVhupqRkyWBRMwZRADKAX0laNw=;
        b=C+u6bv69qq55HjDivswHsmWQwx9XPZlfqKtMKXHoDAIkW9P7bmt6g9sW49fVX68NYg
         HD6TWSdyEm3Eh0mg0LquCK4DcnBc3WiglYANfzGy3a+PUfwrGkve3Xz9AxIFDb3WjorG
         gJN33rhQB+JWu+gwOeXRunBzg9y52ZB8/VEEzcO5qZZSxi77kFiPCbGkC174y3MAKaQi
         GlftmmkVoSSy8J1cWqh40OT/W0+Un+nQPH3YUBS5xqXN9orr/lR0wse0jkJQko2ohq3F
         SVZ2CbvhyH8BSshLLO/PvJN7bHDAXwgQ0z3Do/LuU8rruUF8RKjT7WKBxl1GJLABbvz5
         sZQA==
X-Forwarded-Encrypted: i=1; AL+hErH6Nofgg9AMMKKSz+QMacrFJnIaEB4Z79P29qwqYPeQHk+nRPAxCdfaF5fkq6USNTCy3bxZ/j6rc6PSRSS5ooQV@vger.kernel.org
X-Gm-Message-State: APuU4Z+Mr431WQbLkjf2fSVdFypH7Xw7jshzcwesp6LowHsF52IARFNT
	M6RiT3p/xcEmorGj+dX0kcBBWr2wcdw7IoID2FwZm99c+08sSxc70luJuACLTn8x603axVSPk5g
	N9IrESrJE/g==
X-Received: from dlgx8-n2.prod.google.com ([2002:a05:701a:ccc8:20b0:1b2:48fb:f4d0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3f07:b0:138:30b1:4c00
 with SMTP id a92af1059eb24-1b5567b5685mr18487898c88.3.1795559472179; Tue, 24
 Nov 2026 14:31:12 -0800 (PST)
Date: Tue, 24 Nov 2026 14:30:57 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124223109.820609-1-irogers@google.com>
Subject: [PATCH v10 00/12] perf symbol: Sorted array optimizations and memory shrinking
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

This v10 series rebases onto perf-tools-next (148690b95cc4), fixes an
equal-start zero-size alias bug in symbols__fixup_end() uncovered during
v9 review, and splits the remaining work from v8 (patches 7/10 through
10/10) into small, self-contained patches:

  1. Fix symbols__fixup_end() so all symbols in an all-zero-sized
     equal-start group receive the synthesized end address rather than
     only the last entry, allowing choose_best_symbol() to reach its
     binding and name tie-breakers regardless of input order.
  2. Remove redundant num_by_name and sorted_by_name fields from struct
     symbols (replaced by @cnt and @symbols_by_name != NULL || @cnt == 0).
  3. Replace the @sorted boolean in struct symbols with @sorted_cnt
     prefix length tracking so post-sort appends only sort and merge the
     newly appended tail (or binary-insert in place for small appends),
     reducing 'perf bench internals symbols' append + lookup time by
     90.3% (1551.533 usec -> 150.333 usec).
  4. Add @sorted_tail_cnt tracking an optional secondary sorted run for
     out-of-order dso__insert_symbol() insertions with an amortized
     sqrt(N) merge threshold (keeping sizeof(struct symbols) unchanged
     at 88 bytes), further reducing append + lookup time by 71.4%
     (150.333 usec -> 43.000 usec; 3315.200 usec -> 294.000 usec at
     100,000 symbols).
  5. Unit tests for sorted insertion, unmerged-vs-merged two-run
     lookups, and equal-start symbol aliases (including both
     weak-then-global and global-then-weak kallsyms alias orderings).
  6. Synchronize dso_cache access under dso__lock(dso) and make
     dso->loaded atomic in preparation for concurrent shrinking.
  7. Add symbols__shrink() and symbols__try_delete_unannotated().
  8. Add dso__shrink() and dso__try_evict() to reclaim cached DSO data,
     debuginfo, unannotated symbol tables on unreferenced DSOs (reloaded
     transparently on demand), and unreferenced user DSOs without
     blocking on contended locks.
  9. Add dsos__shrink(), machine__shrink(), machines__shrink(), and
     perf_session__shrink().
 10. Unit tests for symbol and DSO shrinking, dso_symbol pinning, inline
     and srcline cleanup, and transparent DSO reload.
 11. Plumb dso__session() and add perf_session__malloc/zalloc/calloc/
     realloc/strdup() wrappers that invoke perf_session__shrink() and
     retry once on allocation failure.
 12. Unit tests for machine__session()/dso__session(), session-scoped
     allocation wrappers, and multithreaded lock contention.

Dynamic Insertion Complexity & Trade-offs (Patch 4):
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

v10:
 - Rebase onto perf-tools-next (148690b95cc4).
 - Add patch 1 fixing symbols__fixup_end() to update all entries in an
   all-zero-sized equal-start group so choose_best_symbol() reaches
   STB_WEAK/STB_GLOBAL tie-breakers regardless of symbol order, and test
   both weak-then-global and global-then-weak orderings in patch 5
   (reported by Sashiko on v9 patch 4).
v9: https://lore.kernel.org/linux-perf-users/20261124032902.3859564-1-irogers@google.com/
 - Drop patches 1-6 from v8 (merged into perf-tools-next) and rebase
   onto perf-tools-next (964e8b1c9c79).
 - Remove redundant num_by_name, sorted_by_name, and sorted booleans
   from struct symbols in favor of (cnt, sorted_cnt, sorted_tail_cnt)
   and expand the struct symbols kernel-doc.
 - Split v8 patch 7/10 into three patches (sorted prefix tracking,
   secondary sorted run for dso__insert_symbol(), and unit tests) with
   fresh -O2 'perf bench internals symbols' measurements.
 - Split v8 patch 8/10 into four patches (dso_cache locking and atomic
   dso->loaded, struct symbols shrinking, per-DSO shrinking/eviction,
   and dsos/machine/perf_session shrinking).
 - Split v8 patch 10/10 into two test patches matching the code they
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

Ian Rogers (12):
  perf symbol: Fix symbols__fixup_end() for equal-start zero-sized
    aliases
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

 tools/perf/tests/symbols.c | 796 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/dso.c      | 272 ++++++++++++-
 tools/perf/util/dso.h      |  16 +-
 tools/perf/util/dsos.c     |  51 +++
 tools/perf/util/dsos.h     |   3 +
 tools/perf/util/machine.c  |  30 ++
 tools/perf/util/machine.h  |   8 +
 tools/perf/util/session.c  |  78 ++++
 tools/perf/util/session.h  |   8 +
 tools/perf/util/symbol.c   | 406 ++++++++++++++-----
 tools/perf/util/symbol.h   |  58 ++-
 11 files changed, 1579 insertions(+), 147 deletions(-)


base-commit: 148690b95cc425950dbba79d73eb4f7938347fce
-- 
2.56.1.831.g720f3f5937-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606553;
	b=4Pk+CkJhMejHeBE5bKLuiu3oy/TNaQsHv4lcDgpD9MIEL259hAJoI/hdBVrHEi6Q+Sj2
	 U+rj1s2XwTiyNXv2nLet+PJE4EmeLsyiBryOmksBpwpbBdWqs9NXRlHW91kIhVpkct9M1
	 +dDSWGwL+yCxpwqbxeAow4JYabUsDweFw7ZD2zJxOUhFr2e2v5BNqjv59bowMqb6NNMTS
	 /Zc/1QyE6eZlW4mAba8kgh7OqMIm98CXitvBo/j7KOOyfo3dUZdsOlWUvwTUHGGWjgc2D
	 5eAwYdYVoaBwdx+O8FQfTcmb891xI1BcZpTI4tgDkbXalzS5VXmT6usspFbffqeq8qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ZqbUCGvNh+9oQi88+czk7wIi3tmqGv1S2SlgjQEsV1o=;
	b=u3hGT3CJWNawRyTrBVnJ/MAxoTRAEr0GjX7KiRMQvDAreCFgQcw5S7YIb/vsGGvj1iRn
	 oM+yHFDUs8oDtQ+sg1S9VWNTzlizwLD/qgj5FFWAVAu9sOFUwAYO3AuWdmwkrInKK0sWX
	 x+K9z5wW4jhfEmb4oj6KBGA47sX55NbFY3MdHOsFEZ+KXaYJ5aNDrfIinowMYnDXuI1pY
	 t1/50g2hmsZu4fOHUbX6S9QSXfj7lhSEpi3GQ5cSz81X13Wmq3MIZ0mGwVUszNCMMu16d
	 JsCsD1WZYnp6NBIkDUEMGMHNeCoNBFVb6m+ioZEbrtKHY1WJR6+2Et/2Tw1NwitTG5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Ry6/kOBR";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB3606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15DB3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ry6/kOBR
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aed1b64104so2377538a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606552; x=1795211352; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZqbUCGvNh+9oQi88+czk7wIi3tmqGv1S2SlgjQEsV1o=;
        b=Ry6/kOBRJ9zgchBdE73sFBmj8/cQ/rvqrbd5ikvPDp6y01mB1qEVCYADoDlnE3pyUB
         G1U7AyzTtifaXNWRU729wLJyZynLK8jMO8JZH7zMbwQ4cFwi15Oayjkul9aj/M1drpz2
         ZBi7lGDKtf9VqDSu0JsMksGDFk+jBi5ObNALxyYxji8KJ1avHjSYi49KQNWcJKP0/vha
         g0Cj0xcUiLG8qrrz9IgbmuCeZzwk6iZ94s8IOXOTt5hp4viBu0LixLpw6sG+Yj0zGgUj
         rwMNVirdKxwGN4yqSK0EXt5SF1hBkQEjRw6kBqHNURdsBpEUmJyL/4AW5oxmBi/i007p
         b2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606552; x=1795211352;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqbUCGvNh+9oQi88+czk7wIi3tmqGv1S2SlgjQEsV1o=;
        b=2PjtJWaN2lXm1f0eLEaENQevxLpuGSuWrV5fRNX7il8rCHGv6fBcFkextsdXXPY+Az
         4MAnxfPETfQCoXCLlzMcDqBlymPlKJUwRKFPeAl/zJPRdT0d0JJeZhSu8FAotqOHZzh+
         fQOQSGMV3w/JeqqOJ4Nxaj1bnpJiXYhKgPTcQLE7OiarvW3bELVYJpEQqjyYb6pseKpz
         jzDz5K+/pfga1cE48Hw/16bscY5lVKP8lJi8oUGa7pTNaM9XuOOEG19vfdhniemY2W5n
         hW0QW1pKeEbnnprVTlX6DGnpwCm/qk/1tRkDkz5KumxytHkNQ5qXb+mad2BdLqxi2T67
         A/Ew==
X-Forwarded-Encrypted: i=1; AL+hErEb+ccVKYYrkT0pE9Ub5ECpVjVMeVO3p8FVwRro5WKxGGQVCMbXNBSiikaoOKz2J88x1t4LmotjyCZN/vzlhftE@vger.kernel.org
X-Gm-Message-State: APuU4Z88yo0IZKqlImnMytLvGGSJvUQBdoEFiUCNi1nt8ZNMG8uzgY99
	SJYPxs9yAX6QGeLnIlkIwXSYa3Yr4m0eC3y0++MkWt8qHdRjhXWe776mo79QYyHpoJb41qqcq6r
	W48wrSAalxA==
X-Received: from pgea2.prod.google.com ([2002:a05:6a02:5382:b0:cdb:50d8:3e07])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c6:b0:3ab:884b:65b4
 with SMTP id 98e67ed59e1d1-3b1b0d4332fmr3720856a91.59.1794606552172; Fri, 13
 Nov 2026 13:49:12 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:24 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-1-irogers@google.com>
Subject: [PATCH v1 00/26] perf hashmap: Fix undefined behavior, remove
 ERR_PTR, and add type-safe generic hashmaps
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently tools/perf/util/hashmap.{c,h} is a copy of libbpf's internal
untyped struct hashmap (only compiled when libbpf is disabled or
dynamically linked, and otherwise resolved against static libbpf.a).
Using that implementation in perf has several longstanding problems:

1. Strict-aliasing undefined behavior: hashmap_cast_ptr(p) casts caller
   output pointers (such as void **, struct foo **, or long *) to long *
   and dereferences them in hashmap_insert(), hashmap_find(), and
   hashmap_delete(), violating C11 6.5/7 strict-aliasing rules [1] and
   preventing perf from dropping -fno-strict-aliasing [2].
2. Non-standard ERR_PTR() returns: hashmap__new() returns
   ERR_PTR(-ENOMEM) rather than NULL with errno, which differs from the
   rest of user-space perf and has repeatedly caused NULL vs IS_ERR()
   bugs (e.g. commits d05073adda0f, 96f202eab813, 9f3c16a430e8, and [3],
   plus missing error checks in fncache and pmu fixed here).
3. No compile-time type safety and error-prone iteration/deletion: keys
   and values are untyped long / void * unions requiring manual casts,
   sub-long types (such as bool, int, or pid_t) cannot be passed safely
   as output pointers, hashmap__for_each_entry() uses nested loops where
   'break' only exits a single bucket chain rather than the whole
   iteration, and hashmap__delete() leaves old_key/old_value untouched
   on a miss (unlike hashmap__insert()).

This series fixes three bugs in existing hashmap callers, decouples
perf's hashmap from libbpf so strict-aliasing and ERR_PTR issues can be
fixed cleanly, introduces a zero-overhead type-safe DECLARE_HASHMAP()
generic hashmap API, migrates all 17 hashmaps across tools/perf one at a
time while keeping every commit bisectable, and removes the untyped
struct hashmap API at the end:

- Standalone bug fixes in existing callers (Patches 1-3):
  - Patch 1 fixes an uninitialized pointer passed to thread__put() in
    util/threads.c when hashmap__delete() misses (Fixes: 412a2ff473ac).
  - Patch 2 fixes a sym_hist_entry memory leak in
    symbol__annotate_zero_histograms() when clearing notes->src->samples
    (Fixes: d3e7cad6f36d).
  - Patch 3 fixes a per_pkg_mask key leak in check_per_pkg() when
    hashmap__add() fails (Fixes: 034f7ee130c1).

- Decoupling from libbpf, strict-aliasing fix, and ERR_PTR removal
  (Patches 4-7):
  - Patches 4-5 drop the check-headers.sh diff check against
    tools/lib/bpf/hashmap.{c,h}, always build util/hashmap.o, and move
    the backing C functions to __hashmap__* so static libbpf.a builds do
    not collide on global hashmap* symbols (and without perf_-specific
    naming so other tools/ users can share the implementation).
  - Patch 6 fixes strict-aliasing violations by passing void * output
    parameters to __hashmap__insert(), __hashmap__find(), and
    __hashmap__delete(), accessing them via memcpy()/memset(), and
    zeroing old_key/old_value on miss in __hashmap__delete().
  - Patch 7 replaces ERR_PTR(-ENOMEM) in hashmap__new() with NULL and
    errno = ENOMEM, updating callers to standard NULL checks.

- Type-safe generic hashmap API and per-caller migrations (Patches 8-26):
  - Patch 8 introduces DECLARE_HASHMAP(name, key_type, value_type) and
    type-checked hashmap__* macros around struct __hashmap:
    * Phantom pointer members (__key, __value) in a union with struct
      __hashmap encode key and value types at zero runtime space cost
      and without altering struct size or alignment.
    * Output parameters (value_ptr, old_key, old_value) are marshaled
      through long temporaries and assigned via the declared types so
      sub-long types (bool, int, pid_t, etc.) are safe from stack
      overflows, endianness bugs, and strict-aliasing violations, while
      accepting NULL output pointers and const-qualified lookup keys.
    * Single-loop hashmap__for_each{,_safe}() and
      hashmap__for_each_key{,_safe}() iterators hide bucket cursors,
      make in-loop deletion safe, and allow 'break' to exit the entire
      iteration.
    * Adds kernel-doc comments and a 'Generic hashmap' perf test suite
      in tests/hashmap.c.
  - Patches 9-25 migrate all 17 hashmaps in tools/perf (fncache, ftrace,
    trace syscall_stats, bpf-trace-summary, bpf_lock_contention, stat
    per_pkg_mask, expr_ids, pmu aliases, hwmon_pmu, s390-sample-raw,
    threads, annotate sym_samples and type_hash, annotate-data, and
    inject --aslr maps) one hashmap per commit.
  - Patch 26 removes the transitional untyped struct hashmap wrapper and
    unused hashmap__for_each_entry* macros.

[1] https://lore.kernel.org/lkml/20260321024446.692008-1-irogers@google.com/
[2] https://lore.kernel.org/lkml/20260320224248.536449-1-irogers@google.com/
[3] https://lore.kernel.org/lkml/20250805063209.3678359-1-linmq006@gmail.com/

AI Assistance Disclosure (per Documentation/process/coding-assistants.rst
and Documentation/process/generated-content.rst):
- Tools used: Google Antigravity / Jetski coding assistant.
- Summary of prompts and assistance: Interactive design, rebasing, and
  refinement of the __hashmap__* backing separation, strict-aliasing and
  ERR_PTR fixes, caller bug fixes, DECLARE_HASHMAP() type-safe macros,
  kernel-doc comments, unit tests, and per-hashmap caller conversions.
- Testing performed: Verified all 26 commits build cleanly at every step
  under both GCC (-O2 -fstrict-aliasing -Wstrict-aliasing=3) and Clang
  (BUILD_NONDISTRO=1), plus NO_LIBBPF=1, DEBUG=1 (REFCNT_CHECKING=1),
  and build-test targets; ran perf test (including Generic hashmap,
  Simple expression parser, Sysfs/JSON PMU, Hwmon PMU, Symbols, data
  type profiling, inject --aslr, stat, ftrace, and trace suites),
  scripts/kernel-doc -Werror, and scripts/checkpatch.pl.

Ian Rogers (26):
  perf threads: Fix uninitialized pointer put when thread removal misses
  perf annotate: Fix sym_hist_entry memory leak when zeroing histograms
  perf stat: Fix per_pkg_mask key leak on hashmap__add failure
  perf build: Don't check difference of perf and libbpf hashmap
  perf hashmap: Always build perf's hashmap and avoid libbpf symbol
    conflict
  perf hashmap: Fix strict aliasing violations in hashmap
  perf hashmap: Remove errptr usage from hashmap
  perf hashmap: Introduce generic types and macros
  perf fncache: Use generic hashmap for fncache
  perf ftrace: Use generic hashmap for profile_hash
  perf trace: Use generic hashmap for syscall_stats
  perf trace: Use generic hashmap for bpf-trace-summary
  perf lock: Use generic hashmap for slab_hash
  perf stat: Use generic hashmap for per_pkg_mask
  perf expr: Use generic hashmap for expr_ids
  perf pmu: Use generic hashmap for pmu aliases
  perf hwmon_pmu: Use generic hashmap for hwmon events
  perf s390: Use generic hashmap for counter name cache
  perf threads: Use generic hashmap for thread shards
  perf annotate: Use generic hashmap for sym_samples
  perf annotate: Use generic hashmap for browser type_hash
  perf annotate-data: Use generic hashmap for type_hist samples
  perf inject: Use generic hashmap for aslr remap_addresses
  perf inject: Use generic hashmap for aslr top_addresses
  perf inject: Use generic hashmap for aslr evsel_orig_attrs
  perf hashmap: Remove untyped struct hashmap API

 tools/perf/builtin-ftrace.c           |  52 ++-
 tools/perf/builtin-trace.c            |  45 +-
 tools/perf/check-headers.sh           |   4 -
 tools/perf/tests/Build                |   1 +
 tools/perf/tests/builtin-test.c       |   1 +
 tools/perf/tests/expr.c               |   2 +-
 tools/perf/tests/hashmap.c            | 192 ++++++++
 tools/perf/tests/pmu-events.c         |  16 +-
 tools/perf/tests/tests.h              |   1 +
 tools/perf/ui/browsers/annotate.c     |  22 +-
 tools/perf/util/Build                 |   9 -
 tools/perf/util/annotate-data.c       |  10 +-
 tools/perf/util/annotate-data.h       |   5 +-
 tools/perf/util/annotate.c            |  30 +-
 tools/perf/util/annotate.h            |  13 +-
 tools/perf/util/aslr.c                |  48 +-
 tools/perf/util/bpf-trace-summary.c   |  18 +-
 tools/perf/util/bpf_lock_contention.c |  12 +-
 tools/perf/util/evsel.c               |  10 +-
 tools/perf/util/evsel.h               |   6 +-
 tools/perf/util/expr.c                | 106 ++---
 tools/perf/util/expr.h                |  18 +-
 tools/perf/util/expr.y                |   2 +-
 tools/perf/util/fncache.c             |  23 +-
 tools/perf/util/ftrace.h              |   7 +-
 tools/perf/util/hashmap.c             | 136 +++---
 tools/perf/util/hashmap.h             | 627 ++++++++++++++++++++------
 tools/perf/util/hwmon_pmu.c           |  57 ++-
 tools/perf/util/metricgroup.c         |  28 +-
 tools/perf/util/pmu.c                 |  36 +-
 tools/perf/util/pmu.h                 |   7 +-
 tools/perf/util/s390-sample-raw.c     |   9 +-
 tools/perf/util/stat.c                |  13 +-
 tools/perf/util/threads.c             |  26 +-
 tools/perf/util/threads.h             |   4 +-
 35 files changed, 1092 insertions(+), 504 deletions(-)
 create mode 100644 tools/perf/tests/hashmap.c


base-commit: 4af65363b11fc4fe65fcb497f68bbe4f3e3a4d2c
-- 
2.56.1.703.gf848ed807c-goog


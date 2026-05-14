Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8033A03F
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776462; cv=none; b=HCk0n9/AskHUUP+B/TxfIisA7sKYEhpv6FI/GzX9IrCxow35kQKo7yGulGfYegkfFrxSaOE8nT2jg6Ul1QFdrILYCMIEhcf3A6quabtjPkyhfBe9FVp+ERaV+29RQ/5u65Y0v373JLrCN8QwP+KIM4SWXb+DNs28pdej4e+9Cd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776462; c=relaxed/simple;
	bh=6O1scTpWnLKa+BmlkDjRVo+0Q9y6WGIP02q8NOYLJwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r1K02G7fx8hP7HrL35Auup2TI1mhv/IBXznpx8zI2ihSYURvvUTDvAyfGZWjQczvMk4OvtklcAHFWI83vUXhqHcyEgHdH6xf8dh+pVJnJd8y9jb1fsqFEoTIef9GfGr8NOVQ2UAS17XUVZX8rqIIr8r/qpN1ogCdQKGs2X+uaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rb2Hk9C9; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rb2Hk9C9"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so8359561eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776459; x=1779381259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb7gYFK3pQkgrvsE01oTSKK8XCM+MGmsisEXsbZlrho=;
        b=Rb2Hk9C9gJfyjUeXojaDRoUMQMbO9jVVZYD/dd0/x/OgGoU7UAN/6Ur68eYuMz13/I
         r2TF6ZZ3yW8HTOv89X9L3gSOi6SoyOrGdzTB/lh2lELoGVgyBtVlU7E4uwMUIFYfW99P
         3PbgJyQvU8tgDFc36+Sk6s9Z1bG+hOHMFLqW/Nauva7zooKah3HBbsqvCSG1JiUnY7T8
         C8SXReorh3HOawcTNDtvqFqburEqhcRc9Ydvzpe7efbfJ7gW7YT7E24FivKrNj9zebvM
         Im7970HTa6YgDmDW2ZOa/LzhhkkKELn2XG6EsEBzktZ2CYKpHleZu83m/f4ek8xRqG9e
         xW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776459; x=1779381259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb7gYFK3pQkgrvsE01oTSKK8XCM+MGmsisEXsbZlrho=;
        b=iYhzoOS+OyW5r1rxr+fUt6U9sw+FdNzNGw5J97P2Fl6eKui3SWtRkR9Lde5tx1+joY
         M7KYwNzCICRkD2EToeaoXh/hudjE/tc8aMW4ElttwnuVj3YxaNe5XQyv/oKWRiLCHjGX
         ANpc9i92eRmUtn926VfvYbdfxFxaQM46cSCS5U1AQ09Sf3FCCay5mo/SPsULHy8IwOyZ
         w9ziNMQQ+eWfsU2Iw+W2nByO0A+hUuiqPTos6YrujO3Zp/acwMv1w0heHXHW0aHLCr36
         pnRYo81GiZUpEZRZ5neSVMMvzOhlHKiYe4sHsOWAloVeHt5/rOVeMRj+nzky8Xy1wB0X
         dpig==
X-Forwarded-Encrypted: i=1; AFNElJ9tbkqx3u0IOd59Zs2H5tdA79pm9i2OUvZwgAI34CK4j+ZT31YiF2o1s9UlNUjTeKNwcfv2JBdcSHNiMEVGddnZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gSC0HNIzobO8rYlfxtB1wp/RRK/XhYafonKlpNfDyX+lqfub
	fD5uPa3vngTMxnEkmqZdApRGyfEPkye9hUw2C8QQYvhnp6gTxcriqHwBdSXJdNDl5MfAKAnua29
	+Fi9S59gJew==
X-Received: from dycoy22.prod.google.com ([2002:a05:7301:fc16:b0:2df:46bf:2390])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:608c:b0:2ed:e14:7f5f
 with SMTP id 5a478bee46e88-303986b4534mr85365eec.35.1778776459299; Thu, 14
 May 2026 09:34:19 -0700 (PDT)
Date: Thu, 14 May 2026 09:33:52 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-1-irogers@google.com>
Subject: [PATCH v3 00/17] perf build: Reduce build time by nearly half
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

This patch series refactors Kbuild internals, BPF skeleton generation,
Python AST pre-computation, and foundational tooling dependencies across
the perf tool build system. By eliminating umbrella target synchronization
barriers, decoupling static library prerequisites, parallelizing single-core
script generators, and eradicating redundant feature checks, this series
unlocks absolute theoretical peak multi-core concurrency during Kbuild startup.

On a 28-core build workstation (make -j28 all from scratch), clean build
latency improves by over 49%:

  Before:
    real    0m29.006s
    user    2m46.019s
    sys     0m30.610s

  After:
    real    0m14.782s
    user    2m39.527s
    sys     0m22.938s

Saving 14.2 full seconds time per clean build. Furthermore, nothing to
build incremental builds are improved by nearly 7x:

  Before:
    real    0m11.528s
    user    0m9.633s
    sys     0m6.965s

  After:
    real    0m1.729s
    user    0m1.600s
    sys     0m0.884s

Summary of Patches:

1-3: Foundational Tooling & Fast-Path Feature Detection
  - Exempts bpftool bootstrap from non-essential feature tests (LLVM, libbfd,
    libcap), saving 1.1s of sub-make fork overhead during Kbuild startup.
  - Integrates libdebuginfod directly into test-all.c, allowing Make to skip
    individual feature check sub-make forks during AST parsing on fully
    configured workstations. Escapes $(shell ...) macro expansion to prevent
    unconditional sub-make forks.
  - Fixes test-clang-bpf-co-re.bin feature check to correctly generate its
    target file on disk via atomic move (> $@.tmp && mv $@.tmp $@), allowing
    Kbuild to perfectly cache the detection result and avoid continuous sub-make
    re-evaluations.

4-6: Flattening Umbrella Prepare Barriers
  - builtin-trace embedded inclusions and pmu-events generation are completely
    decoupled from the sequential "prepare" umbrella target, eliminating Make
    AST double-parsing overhead and unchoking parallel compilation barriers.

7-10: Decoupling & Pre-generating BPF Skeletons
  - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel.mak.
  - Decouples bpftool bootstrap from top-level static libbpf dependencies,
    attaching bpf-skel-prepare directly to the umbrella prepare target. This
    allows Make to pre-compile bpftool and dump vmlinux.h in the background at
    build startup, removing the 7-second serialization bottleneck before BPF
    object compilation.
  - Ensures benchmark skeleton intermediate .bpf.o files are cleanly removed
    during make clean, and adds bpf-skel-prepare to .PHONY.

11-12: Foundational Linkage Optimization
  - Eliminates redundant libbpf sub-make feature checks during static builds.
  - Moves static libsymbol and libbpf library prerequisites out of the
    prepare step, ensuring libbpf headers are installed before
    compiling BPF-dependent tests.

13-14: jevents.py Concurrency & Deduplication
  - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c
    into a dedicated pmu-events-string.c compilation unit. This slices
    C compilation latency in half by compiling string and struct
    tables simultaneously across separate CPU cores while preserving
    zero dynamic ELF relocations. Adds pmu-events-string.c to
    .gitignore and uses Make 4.0 compatible dependency chaining.
  - Pre-populates jevents.py JSON ASTs and metric formulas in parallel across
    all available CPU cores using ProcessPoolExecutor (accelerating Python
    execution by 11x, from 3.3s down to ~290ms). Moves _init_worker to top-level
    scope to ensure clean pickling under spawn multiprocessing start methods.

15: Out-of-Tree Incremental Rebuild Fix
  - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to prevent
    Make from continuously re-executing script installation rules on already
    built out-of-tree builds.

16-17: AST Parsing Optimization & Shell Fork Eradication
  - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursive
    assignment (=) to simply expanded assignment (:=) and replaces
    model_name/vendor_name with pure GNU Make string functions. This
    guarantees Make executes directory probing shell forks exactly
    once during AST parsing and evaluates path macros purely in
    memory, completely eradicating over 7,800 redundant sub-processes
    during out-of-tree build evaluation.
  - Converts llvm-config shell queries in Makefile.config from
    recursive assignment (=) to simply expanded assignment (:=). This
    eliminates ~185 redundant sub-processes that were previously
    executed across object compilation dependency checks.

Changes since v2:
  - Dropped Patch 4 (tools scripts: Short-circuit CC_NO_CLANG compiler
    probe in Makefile.include) to prevent potential cross-compilation
    regressions when CC and HOSTCC use different compilers.
  - tools build (Patch 2): Escaped $(shell ...) macro expansion as
    $$(shell ...) inside define feature_check_code to safely defer
    sub-make execution until after eval parses the ifeq guard.
  - tools build (Patch 3): Refactored test-clang-bpf-co-re.bin feature
    check recipe to redirect grep output to a temporary file and
    atomically move it upon success (> $@.tmp && mv $@.tmp $@),
    preventing Kbuild from permanently caching failed detections due to
    0-byte files.
  - perf trace beauty (Patch 4): Updated commit description to accurately
    reflect the unconditional top-level recursive kbuild hook
    (perf-util-y += trace/beauty/).
  - perf build (Patch 7): Added $(OUTPUT)bench/bpf_skel/.tmp to
    bpf-skel-clean in Makefile.perf to ensure intermediate benchmark
    skeleton .bpf.o artifacts are cleanly removed during make clean.
    Removed unused bpf_skel_deps variable from bpf_skel.mak.
  - perf build (Patch 9): Added $(LIBBPF) as an explicit prerequisite to
    $(LIBPERF_TEST_IN) in Makefile.perf to guarantee libbpf headers are
    fully installed before compiling sigtrap.c or other BPF-dependent
    tests during parallel builds.
  - perf build (Patch 10): Added bpf-skel-prepare to the .PHONY target
    list in Makefile.perf to ensure Make never incorrectly skips the
    target if a file or directory named bpf-skel-prepare accidentally
    exists in the build tree.
  - perf pmu-events (Patch 13): Added pmu-events/pmu-events-string.c to
    tools/perf/.gitignore. Replaced grouped targets (&:) with Make 4.0
    compatible dependency chaining to guarantee backward compatibility
    with older Make versions (like 4.2.1) and prevent parallel builds
    from spawning multiple concurrent jevents.py processes.
  - perf pmu-events (Patch 14): Moved _init_worker from local main()
    scope to the top-level module scope in jevents.py to ensure it can be
    cleanly pickled when ProcessPoolExecutor uses the spawn
    multiprocessing start method (avoiding AttributeError crashes).

Ian Rogers (17):
  bpftool build: Restrict feature tests during bootstrap compilation
  tools build: Integrate libdebuginfod into test-all fast path
  tools build: Fix test-clang-bpf-co-re.bin to generate target file
  perf trace beauty: Make beauty generated C code standalone .o files
  perf build: Decouple pmu-events from prepare umbrella target
  perf build: Remove empty archheaders target
  perf build: Move BPF skeleton generation out of Makefile.perf
  perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
  perf build: Move static libbpf dependency out of prepare step
  perf build: Pre-generate BPF skeleton tooling during umbrella prepare
    phase
  perf build: Move libsymbol dependency out of prepare step
  perf build: Remove redundant libbpf feature check for static builds
  perf pmu-events: Split big_c_string storage into standalone
    compilation unit
  perf pmu-events: Parallelize JSON and metric pre-computation in
    jevents.py
  perf build: Prefix SCRIPTS with output directory to fix continuous
    rebuilds
  perf pmu-events: Convert recursive shell assignments and macros to
    Make built-ins
  perf build: Convert llvm-config shell queries to simply expanded
    variables

 tools/bpf/bpftool/Makefile                    |   5 +
 tools/build/Makefile.feature                  |   6 +-
 tools/build/feature/Makefile                  |   4 +-
 tools/build/feature/test-all.c                |   5 +
 tools/perf/.gitignore                         |   1 +
 tools/perf/Build                              |   2 +
 tools/perf/Makefile.config                    |  19 +-
 tools/perf/Makefile.perf                      | 431 ++----------------
 tools/perf/bench/Build                        |   6 +
 .../bpf_skel/bench_uprobe.bpf.c               |   0
 tools/perf/bench/uprobe.c                     |   2 +-
 tools/perf/bpf_skel.mak                       | 109 +++++
 tools/perf/builtin-trace.c                    |  30 +-
 tools/perf/pmu-events/Build                   |  26 +-
 tools/perf/pmu-events/jevents.py              |  56 ++-
 tools/perf/trace/beauty/Build                 | 280 ++++++++++++
 tools/perf/trace/beauty/arch_errno_names.c    |   2 +
 tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
 tools/perf/trace/beauty/beauty.h              |  60 +++
 tools/perf/trace/beauty/eventfd.c             |   6 +-
 tools/perf/trace/beauty/fsconfig.c            |   5 +
 tools/perf/trace/beauty/futex_op.c            |   6 +-
 tools/perf/trace/beauty/futex_val3.c          |   6 +-
 tools/perf/trace/beauty/mmap.c                |  24 +-
 tools/perf/trace/beauty/mode_t.c              |   6 +-
 tools/perf/trace/beauty/msg_flags.c           |   8 +-
 tools/perf/trace/beauty/open_flags.c          |   1 +
 tools/perf/trace/beauty/perf_event_open.c     |  22 +-
 tools/perf/trace/beauty/pid.c                 |   5 +-
 tools/perf/trace/beauty/sched_policy.c        |   8 +-
 tools/perf/trace/beauty/seccomp.c             |  12 +-
 tools/perf/trace/beauty/signum.c              |   6 +-
 tools/perf/trace/beauty/socket_type.c         |   6 +-
 .../perf/{util => trace/beauty}/syscalltbl.c  |   0
 .../perf/{util => trace/beauty}/syscalltbl.h  |   0
 tools/perf/trace/beauty/tracepoints/Build     |  22 +
 tools/perf/trace/beauty/waitid_options.c      |   8 +-
 tools/perf/util/Build                         |  17 +-
 tools/perf/util/bpf-trace-summary.c           |   2 +-
 tools/perf/util/env.c                         |   4 +-
 tools/perf/util/env.h                         |   1 +
 41 files changed, 717 insertions(+), 504 deletions(-)
 rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
 create mode 100644 tools/perf/bpf_skel.mak
 create mode 100644 tools/perf/trace/beauty/fsconfig.c
 rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
 rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)

-- 
2.54.0.563.g4f69b47b94-goog


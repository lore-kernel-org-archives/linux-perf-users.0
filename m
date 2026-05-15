Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F4403137
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866744; cv=none; b=uu+3c0yYAPrweRLHH5NqePAve1aGbGVSj8PLdscKp7DSX/zgFK0Xs5574jybuz02vIB6XVvZE1FvzL0RNKny3rf25Jxj9s4lBVszOCWYs7lveglDa6Ema5KPTRP163gq2YaOzhkrgXX1IQ0SAZwbOakarnfc2ofwcoqiaHb+Sn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866744; c=relaxed/simple;
	bh=SaS/rklN+WA+wh2EFUvewF2YAsQMJvORtlboexrfJ3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LPmbSUpbrY5SRebCKPoKk3K+Mf3uJxqxKgafT2KpKMLT8c6AYWoNHQj+0Pwk8n3+67xSmdiuqq0Cg9Qgt8aIXPVnmtJMhDTUOZGUA3WD4BuV4OQyIWbwRcK22eG7RSRArRHs/RvILDbB50xrZS0/irQ57hL/At/ysb8abdJmqqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=beKz+7Yb; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beKz+7Yb"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2efc342ef15so90470eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866742; x=1779471542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDLrfvvfz0RgopY/RLHWRlVOobd6sX3yuGrBcuYhINA=;
        b=beKz+7YbLrRDnCJVzD6TusoK7uQhflbEPe/zHLMDF/daeh9aNLDdP8PnSBgUW/l8BL
         Ynj95/aV9DmS0nQZoya/851tiCLedowd7dT8z3xxIJqlUnOpLTavuBZ2iuyubhvlViFY
         ez4LYcBpvGHYtvPGoKGeKqPhkSkZkF75jNC1rt/3tIOIKjauFoaCWF22QPuh+oIKr/43
         4NAiYlOOf2A7ZlUGsfzhTDc6jF1WZ/wFuPC6hfxuNhjW409DFHQNDjdnDVaI/jmQDqBH
         IE4DVjT6Kp+ygntjvtQ8sE2R02nOYZkm25MYVfrSKX4HwbEMXkTc6XxGv9PNJDDaA8D7
         mj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866742; x=1779471542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDLrfvvfz0RgopY/RLHWRlVOobd6sX3yuGrBcuYhINA=;
        b=T9jiqRemKoCXGmTvN/sfRShepiKmiykLbg9aPMoAq76lbhmxNMUTDXhYjJPmbJ7kIO
         NMtxmq3/juZpfRkxN9EM3Nq2uT93xiVjdIiJzO+fskVaQbhBvLDTo1xj4fpR2OeZEopG
         nUg+9h2HdXDree5VyrgDMdsjpuo38x7o+P3A6rgUOZCLCHO9juOSga+OoDcO3C2jGSA4
         CQ2Ndhf8hBSceDn/GWvtZiOnQmAvkl3ug/cd9gh7Ogo0GuO38/oBskqBpH2erEQ96S9S
         LrmaL0b9mR79XxfsN2GmV89l8KzT0DZnwxvILnuwiCROsUWQA2cYvZyMZGW5lSXaIfnV
         KmNg==
X-Forwarded-Encrypted: i=1; AFNElJ+pNmAtgWSK5OClB5J1vVVuL92iUCioFF4wmHvy1ST/s25kpHKAJS2ieRlWRvcQrbQdKljvjy7y1nsAcilOQL2O@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQtd5gpvmiX+7asySmMxePeAQM7D0ORI9boVyjdT1vpX9iwbi
	sfnTdNiLLaN2XV1k/eoWXMPBLatGxy2YpsyYUSd3fOveNh2pPVlv5Bhj8DgrkrvhZlp99ugYgVQ
	yVbkfBO8wrQ==
X-Received: from dycaj11.prod.google.com ([2002:a05:7300:fb8b:b0:2e6:f22b:f849])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1983:b0:2d8:b814:29af
 with SMTP id 5a478bee46e88-303982864c3mr2561595eec.3.1778866741407; Fri, 15
 May 2026 10:39:01 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:37 -0700
In-Reply-To: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-1-irogers@google.com>
Subject: [PATCH v4 00/14] perf build: Reduce build time by nearly half
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
latency improves by over 44%:

  Before:
    real    0m29.006s
    user    2m46.019s
    sys     0m30.610s

  After:
    real    0m16.091s
    user    2m40.135s
    sys     0m25.740s

Saving 12.9 full seconds time per clean build. Furthermore, nothing to
build incremental builds are improved by nearly 7x:

  Before:
    real    0m11.528s
    user    0m9.633s
    sys     0m6.965s

  After:
    real    0m1.717s
    user    0m1.682s
    sys     0m0.960s

Summary of Patches:

1: Fast-Path Feature Detection
  - Refactors test-clang-bpf-co-re.bin and test-bpftool-skeletons.bin feature
    checks to redirect grep output to .make.output and touch $@ upon success
    (> $(@:.bin=.make.output) 2>&1 && touch $@). This perfectly matches standard
    Kbuild feature check conventions and ensures the target files are touched on
    disk purely upon success, allowing Kbuild to cache positive detections and avoid
    continuous sub-make re-evaluations during incremental builds. For
    test-clang-bpf-co-re.bin, adds explicit source prerequisite test-clang-bpf-co-re.c
    and simplifies Clang recipe using $<.

2-4: Flattening Umbrella Prepare Barriers
  - builtin-trace embedded inclusions and pmu-events generation are completely
    decoupled from the sequential "prepare" umbrella target, eliminating Make
    AST double-parsing overhead and unchoking parallel compilation barriers.

5-7: Decoupling & Pre-generating BPF Skeletons
  - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel.mak.
  - Decouples bpftool bootstrap from top-level static libbpf dependencies,
    attaching bpf-skel-prepare directly to the umbrella prepare target. This
    allows Make to pre-compile bpftool and dump vmlinux.h in the background at
    build startup, removing the 7-second serialization bottleneck before BPF
    object compilation.
  - Ensures benchmark skeleton intermediate .bpf.o files are cleanly removed
    during make clean, and adds bpf-skel-prepare to .PHONY.

8-9: Foundational Linkage Optimization
  - Moves static libsymbol library prerequisites out of the prepare step.
  - Eliminates redundant libbpf sub-make feature checks during static builds.

10-11: jevents.py Concurrency & Deduplication
  - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c into a
    dedicated pmu-events-string.c compilation unit. This slices C compilation
    latency in half by compiling string and struct tables simultaneously across
    separate CPU cores while preserving zero dynamic ELF relocations. Adds
    pmu-events-string.c to .gitignore, includes pmu-events.h for global extern
    declarations, defers file closures to ensure identical timestamps, and uses
    Make 4.0 compatible dependency chaining with robust self-correction checks.
  - Pre-populates jevents.py JSON ASTs and metric formulas in parallel across
    all available CPU cores using ProcessPoolExecutor (accelerating Python
    execution by 11x, from 3.3s down to ~290ms). Moves _init_worker to top-level
    scope to ensure clean pickling under spawn multiprocessing start methods.

12: Out-of-Tree Incremental Rebuild Fix
  - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to prevent
    Make from continuously re-executing script installation rules on already
    built out-of-tree builds.

13-14: AST Parsing Optimization & Shell Fork Eradication
  - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursive assignment
    (=) to simply expanded assignment (:=) and replaces model_name/vendor_name
    with pure GNU Make string functions. This guarantees Make executes directory
    probing shell forks exactly once during AST parsing and evaluates path macros
    purely in memory, completely eradicating over 7,800 redundant sub-processes
    during out-of-tree build evaluation.
  - Converts llvm-config shell queries in Makefile.config from recursive assignment
    (=) to simply expanded assignment (:=). This eliminates ~185 redundant sub-processes
    that were previously executed across object compilation dependency checks.

Changes since v3:
  - Streamlined series to 14 patches by dropping Patches 1, 2, and 9 to focus on
    the most uncontroversial, high-impact architectural gains.
  - tools build (Patch 1): Refactored test-bpftool-skeletons.bin and
    test-clang-bpf-co-re.bin feature check recipes to match standard Kbuild
    conventions by redirecting grep output to .make.output and touching $@ upon
    success (> $(@:.bin=.make.output) 2>&1 && touch $@). Added explicit source
    file prerequisite test-clang-bpf-co-re.c and simplified Clang recipe using $<.
  - perf build (Patch 7): Fixed missing prerequisite on bpf-skel-prepare in
    bpf_skel.mak by making it depend directly on explicit $(BPFTOOL) $(VMLINUX_H)
    prerequisites, preventing it from executing as a no-op during prepare.
  - perf pmu-events (Patch 10): Added extern const char big_c_string[]; declaration
    to pmu-events.h and included it in output_string_file to satisfy Clang
    -Wmissing-variable-declarations compiler warnings. Deferred closing
    output_string_file until the absolute tail of main() to ensure identical
    timestamps with output_file, preventing redundant incremental rebuilds. Updated
    the secondary target rule in pmu-events/Build to verify the file exists on disk
    and force a rebuild if manually deleted, ensuring 100% self-correcting builds.

Ian Rogers (14):
  tools build: Fix feature checks to touch target files on success
  perf trace beauty: Make beauty generated C code standalone .o files
  perf build: Decouple pmu-events from prepare umbrella target
  perf build: Remove empty archheaders target
  perf build: Move BPF skeleton generation out of Makefile.perf
  perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
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

 tools/build/feature/Makefile                  |   8 +-
 tools/perf/.gitignore                         |   1 +
 tools/perf/Build                              |   2 +
 tools/perf/Makefile.config                    |  19 +-
 tools/perf/Makefile.perf                      | 423 ++----------------
 tools/perf/bench/Build                        |   6 +
 .../bpf_skel/bench_uprobe.bpf.c               |   0
 tools/perf/bench/uprobe.c                     |   2 +-
 tools/perf/bpf_skel.mak                       | 109 +++++
 tools/perf/builtin-trace.c                    |  32 +-
 tools/perf/pmu-events/Build                   |  26 +-
 tools/perf/pmu-events/jevents.py              |  57 ++-
 tools/perf/pmu-events/pmu-events.h            |   2 +
 tools/perf/trace/beauty/Build                 | 276 ++++++++++++
 tools/perf/trace/beauty/arch_errno_names.c    |   2 +
 tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
 tools/perf/trace/beauty/beauty.h              |  60 +++
 tools/perf/trace/beauty/eventfd.c             |   6 +-
 tools/perf/trace/beauty/fsconfig.c            |   5 +
 tools/perf/trace/beauty/futex_op.c            |   5 +-
 tools/perf/trace/beauty/futex_val3.c          |   5 +-
 tools/perf/trace/beauty/mmap.c                |  24 +-
 tools/perf/trace/beauty/mode_t.c              |   6 +-
 tools/perf/trace/beauty/msg_flags.c           |   8 +-
 tools/perf/trace/beauty/open_flags.c          |   2 +
 tools/perf/trace/beauty/perf_event_open.c     |  21 +-
 tools/perf/trace/beauty/pid.c                 |   5 +-
 tools/perf/trace/beauty/sched_policy.c        |   8 +-
 tools/perf/trace/beauty/seccomp.c             |  12 +-
 tools/perf/trace/beauty/signum.c              |   6 +-
 tools/perf/trace/beauty/socket_type.c         |   6 +-
 .../perf/{util => trace/beauty}/syscalltbl.c  |   0
 .../perf/{util => trace/beauty}/syscalltbl.h  |   0
 tools/perf/trace/beauty/tracepoints/Build     |  21 +
 tools/perf/trace/beauty/waitid_options.c      |   8 +-
 tools/perf/util/Build                         |  17 +-
 tools/perf/util/bpf-trace-summary.c           |   2 +-
 tools/perf/util/env.c                         |   4 -
 tools/perf/util/env.h                         |   1 +
 39 files changed, 685 insertions(+), 514 deletions(-)
 rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
 create mode 100644 tools/perf/bpf_skel.mak
 create mode 100644 tools/perf/trace/beauty/fsconfig.c
 rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
 rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)

-- 
2.54.0.563.g4f69b47b94-goog


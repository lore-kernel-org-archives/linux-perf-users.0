Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211E3F54D8
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119212; cv=none; b=QifO4v94pxFTjai7nj9ouHLA0iFXZA6Ji8o6WFbQ66APePaQf2nwjjXEmofkATVr+XdPkBOFOflaHApYuN7qWWV5IFqp7shSlA6JS6Ejcja9hGUe6hlPk/RSZ+bRWKWt2RpHHkz9j06Z/QfQe3BkTED+HtMzQbBjky1M5zd0rDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119212; c=relaxed/simple;
	bh=Db53ozuIYU2jWYqC+H/6Q4sArAYAthRIPepH5SRaZrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p4KMHnmWxYHHHK1cS9T3Roj50ccuXHNXyka5kYhlwRbnMiOhhDUWt3FNHLpVOYfRKCV2VOWVcVxlbzYdHD/VGpZFj9zEtSue890eUs9NJV/Gb/V/JC2Pngbdpp0Sa58suaL7T0JuEA1iPQfmHtJW3oN3k/tZ+Xapcpu9OAcSEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgQ5BhNi; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgQ5BhNi"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f2d983d109so9363341eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119206; x=1779724006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0O8IiV3AS3OwENAaDlhLnBdniYTPVs8/Amp+IfSXKbI=;
        b=ZgQ5BhNiKxyvNP3vryZNXN2oM3I4x8lhxUdUz1tvgkQYBsMHJo84dGPT119RDm8go/
         TVgb062/tayA9hmjyuIncDSECabJh6MBqhfjxE/ZrgzBH0vbPaiOY32bPw4bkEl0JHWs
         Kad7zLqgl60AFrda8+hX2QZYl83761dLYRzLFwZQaQmxBZkOfhRU5S7+deoZmdtURlPW
         +z61BI+qDK7yCEnyBNMmYcA5CG1igxoGJglKCpC785FpC1OONaui7TSI0hdHYwmINwx3
         nDgjxrRv1FdL2qtTPs7uG0W4iOr4sXlFWG52ZURB3d1txVORRiJcDDKDhT594WUYdAIU
         A5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119206; x=1779724006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0O8IiV3AS3OwENAaDlhLnBdniYTPVs8/Amp+IfSXKbI=;
        b=Yaot+WlAp+nWz/GgsD0BRCzlrbWmMWYMnWuBMHvfyUqdc+7KULLmhcJ51Zn/KtXO88
         i3iw2P99b4rfToy8Ud14OtbNdDNUzjOmVz8YTxgQyRkj1VfzTsCHqbkewWsdRxcgZLqt
         fA0+ulFNpilNXWaI4aRO7xBuaLan2SShISYPlR9hpwPvvbVX8lqDft2eDW2CG7tDplZD
         DX0g3yvp7rA5cjnr4SIJO5kXtrMAqcaMh/HxrrmrsydyUGY/8/P60xlNJYB+3uo6ccf5
         OQvyx31Pa8m1DciREFB/OaO9cz4Szro7KKR9iw7+rNIOc2BX4F3iBM4QdtM3RhOLqG1P
         FnIg==
X-Forwarded-Encrypted: i=1; AFNElJ9PoQ3nHG82x5+iJwE4TpHvIRyCrHtzwqONQDN4A77nEOQ7YrOB0aZAcLAUBXBQ7EB529wpNErwnL0HFXhn4YrO@vger.kernel.org
X-Gm-Message-State: AOJu0YzryvTMp7yBfCyPHwMzIgzLJ9AJ3ASJF2xanNUkoFcSl03wPiPv
	CvpaRbu0k6XxHoel9CivFyMPe3EXq+cT+ebSXbdexhMf5DCmAPea3wjkQHVg/L1aNWuG4n/8oYo
	o1fSDdPVpeQ==
X-Received: from dycju15.prod.google.com ([2002:a05:7301:fa0f:b0:2df:af:8fde])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6c05:b0:2f2:32bc:788a
 with SMTP id 5a478bee46e88-30398652e89mr7336987eec.25.1779119205679; Mon, 18
 May 2026 08:46:45 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:24 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-1-irogers@google.com>
Subject: [PATCH v7 00/14] perf build: Reduce build time by nearly half
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
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
    checks to group shell pipelines within curly braces and redirect both stdout
    and stderr to .make.output before touching $@ purely upon success
    (> $(@:.bin=.make.output) 2>&1 && touch $@). Grouping the pipeline ({ cmd1 | cmd2; })
    ensures that compiler stderr is successfully captured in .make.output rather
    than escaping to the parent shell. This perfectly matches standard Kbuild
    feature check conventions and ensures the target files are touched on disk
    purely upon success, allowing Kbuild to cache positive detections and avoid
    continuous sub-make re-evaluations during incremental builds. Adds
    test-bpftool-skeletons.bin to the clean FILES list and explicit source
    prerequisite test-clang-bpf-co-re.c.

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
    pmu-events-string.c to .gitignore, declares extern const char big_c_string[];
    locally inside output_string_file and output_file when split to prevent linkage
    conflicts with empty-pmu-events.c, defers file closures to ensure identical
    timestamps, and uses canonical Make 4.0 @: dependency chaining.
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

Changes since v6:
  - Rebase/resend as last series failed to apply by Sashiko.

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

 tools/build/feature/Makefile                  |  13 +-
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
 tools/perf/pmu-events/jevents.py              |  59 ++-
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
 38 files changed, 688 insertions(+), 516 deletions(-)
 rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
 create mode 100644 tools/perf/bpf_skel.mak
 create mode 100644 tools/perf/trace/beauty/fsconfig.c
 rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
 rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)

-- 
2.54.0.563.g4f69b47b94-goog


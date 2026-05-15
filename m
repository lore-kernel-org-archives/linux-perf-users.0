Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6F35E1DC
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873612; cv=none; b=ep/Ah6BhXURym1Bdc8WVsdYeUsUMJyO90SrS6FKg2ltY0Ryr+k2wLM4Ed3pzCWIY9YWkeLPhC181KuehUPa5REFtzMRWLLKpuH77JSl7I6cRyWzODT4gnuBJ+H1NcDaLz/zFfZclL3kcrhwWt3FDtfdRrVI5jnsC5iWMs0zG28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873612; c=relaxed/simple;
	bh=YZAGtK+pp675PR2oOJzho5O0XmxEZLYQeC96+LzNv3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZcYRoXW9qGVYk8dic3ADN316vfrUmjyt07PI9GyQP0ju94FqnpLqX18udMi5NCTkCXjHlJZcCTetyRn708UJsn0aQ7H0aR+T3vADYp/l5ezKWUnhzEnbsVOSwZ3pp17mcCopLGv/YfTZOm7FAX8K7jLkxtcBkWhmgqGwR5CcD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMEBsOCP; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMEBsOCP"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fded513994so818052eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873608; x=1779478408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WfSkh1xTsv+sLnytybRXhluML+siQfJFIwIfnqUw+1Y=;
        b=PMEBsOCPEsTUnsko2V3x7OQJbZfBCZCiGs0Jqkr/CbCrIoQSGY8v4gidQ01PusLykW
         5tKoVlBlPld4s48WD8nb/KEbk8qkT8wKvPnUo9JVfcdJkE0YVsWkEV5Xc5adU7yRC2gZ
         XEBuCxpHhr8IjVnOwXx9kO7fQ/ZyVuj4CAY2VRv4Z/fQWEoSB/52oPzV3vqIvia5hWAx
         Z4D25LBv0ChDR/Z8Qz8i7/8LamWctFp+5YTstBsz4ukDNgOu5gm89553BFLr6Czb2n8T
         CkJruTUrjJlwlw/c2/30jtyzhVdKFnB1mbJjst3qL090FMp4NNYw9/NGcofdfVTw30dX
         ni6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873608; x=1779478408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfSkh1xTsv+sLnytybRXhluML+siQfJFIwIfnqUw+1Y=;
        b=A4G+XoVHXOVIF/j2qcfnM7xZFVvY81YPLZk1lE2Jx8B1bkr3zncscskXQUv5YO+Pze
         Dd3WS/QjJl8IYGR9gGP8iiT54x/v3KMacAvpeUjT3BSiqgfOLAJnz3zFRvohOEtpqosX
         QiKaf1ksJx1w9h1Vy4glLOBj27wE9LDXpsJUsJq+U50gh3yNXTIER74bxoMDEd6KzuRj
         yTs/W7Vb6QVkW2GDE1krSUQSihv1vjyPkWJRdTa7NLOuIVoHlA+1JW9b2KgLHVz9nVQ2
         vdoLwRzuNvIB/zYEHpX12voeJc1ZB0xp3FvHyhHDkiwtIbnlj0odNO4kNUDvD1RX3QHB
         rSIA==
X-Forwarded-Encrypted: i=1; AFNElJ/9k41NAZ0as4PE9bsadlOt7ywLN3b/BReyvJr89f5VvhWgRnrL/9lfv6gwfSa9tqYvDTJkW86YWxVbTrcpjjxt@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRy0heG4OP2Dsx3UmkOhmrH+TlT5CB4TLdLxQekE+9rzxymRp
	3zS9+D77N7C+6X2i+e6V9twb83H6UFpGu3VjfCDxEsXUOLtW2z56SQBXj29ZhJoyibqVmnlXsqE
	cZixJGZcUQQ==
X-Received: from dybgz3.prod.google.com ([2002:a05:7301:2603:b0:2cc:a1bf:2dd9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:570e:b0:2c8:6361:ab2e
 with SMTP id 5a478bee46e88-303982ac579mr2964486eec.8.1778873608214; Fri, 15
 May 2026 12:33:28 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:00 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-1-irogers@google.com>
Subject: [PATCH v5 00/14] perf build: Reduce build time by nearly half
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
unlocks greater concurrency during Kbuild startup.

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

Changes since v4:
  - tools build (Patch 1): Refactored test-bpftool-skeletons.bin and
    test-clang-bpf-co-re.bin feature check recipes to group the shell pipeline
    within curly braces ({ cmd1 | cmd2; }) so that compiler stderr is successfully
    captured in .make.output rather than escaping to the parent shell. Added
    test-bpftool-skeletons.bin to the clean FILES list in feature/Makefile so
    that make clean correctly purges the generated binary and prevents permanent
    feature cache poisoning.
  - perf pmu-events (Patch 10): Reverted secondary target rule in pmu-events/Build
    back to the canonical Make 4.0 @: dependency chaining pattern to prevent
    concurrency race conditions during parallel compilation. Removed global
    extern const char big_c_string[]; declaration from pmu-events.h and instead
    emitted the extern declaration locally inside output_string_file and
    output_file when split, preventing type and linkage conflicts with
    empty-pmu-events.c when building with NO_JEVENTS=1.

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
 tools/perf/pmu-events/jevents.py              |  58 ++-
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
 38 files changed, 687 insertions(+), 516 deletions(-)
 rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
 create mode 100644 tools/perf/bpf_skel.mak
 create mode 100644 tools/perf/trace/beauty/fsconfig.c
 rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
 rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)

-- 
2.54.0.563.g4f69b47b94-goog


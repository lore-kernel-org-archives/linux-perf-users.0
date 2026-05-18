Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940EE346ACC
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079676; cv=none; b=h4o0KUvitkhraHSr2nq+t82cZ07iIlmeAPhYNNGC+9hTB8nW1cM5te1zuM7wKe5T/FuRwnf8Wh7JWpVqdcUHXDdpFt3aqzLlYltyHy1M9E+Y6sfmqBBjgqciC9ouf66okh//v8M5bPLNFWm1bY7XxMA1kgViUA1lRQu3NEKeP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079676; c=relaxed/simple;
	bh=qoozwfBDiN7ZsI8K4OD5U/OY10bC2BZpXnY6TRkFg24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rN914EeExcQbQHVINloM6z3+kk+56cxnpYNxidkQDI2eGQV4SV5fwCpi+cx+3vL9u7RT3wBa563gLv230Im/DDJm4Tu6r8hN5RfKEytpICZA2d8OAFOrEiNsCMqgHKgSzkEAqxafk0NhTJzsUAmjpBONbSq15ot5ScVjCIGfeOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spduw99S; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spduw99S"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-130aab78a09so1473136c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079673; x=1779684473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7BIH49ZbGVpqWGyC/PF2U37BJu1GatOcjrU2HEGUrA=;
        b=spduw99S6VUh/PLP33RlqEBid+Klzpru683Zv9QaBChBNBhhaUhX/j4hIrOWMJMRoh
         CMCRXclOjOXz/pG1Qm2RUuarZLZXi+9q41Lb6a1q2sIGuj26m0d9qRYi+hg/uT/HwdiL
         UGXK5F351uidB45LqFppEUT/BYAqzwygh4mKlMcZ+a5p4PeRUMO7bZtLvVyX9aWCZWMc
         UZ20ehVdFxN2wfo+tu1jkuMdo+VHDeW4t9MJhY9g131QAMj40uD0PiqnxH7Ug71pLga7
         bTTJhu9yl94aL/Tde+9prxGNQkMFxyPVlCdMOMKyGPuwjW8drpS8PU8n5gQ2mmEjYuBE
         HkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079673; x=1779684473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7BIH49ZbGVpqWGyC/PF2U37BJu1GatOcjrU2HEGUrA=;
        b=SCEUOOsjlGE3rlxNCLMAFfqrXxHRdhwzyMZ2Y+t4uvup9WhJLU5grwGswhC6dVuLxp
         SVDaC/WAdpMppnCx9HPW7TTJlYksqDCsLk7FrMrii40PRrSNrINlAqyUfqYwkc3df7fc
         h/qjuJCwTQyBhk4d1y3TV+djYK/y3uwcxYySL2Kmd04UhPEi5TjK63Xi4AyTIp/XB7je
         k6GQNQjds5tcE+AStXpC/HGbVvUqSvsA+nwmZMyMh/6z6eLS2qavdoIfoZQruFx6t0to
         myIJaa0HRmevZUyW6chrzaLe48qTIpoI+N4N2QA1nD2krs3UAtLW4BoznQbpue08LThm
         EqWg==
X-Forwarded-Encrypted: i=1; AFNElJ8lPb+GXg88qTjO257M4rnZQl49T5iE9vAMumoVBV16RUFkW20zcxg85DyIr5We6zsblvgY8FfxnrQOwzSV4q+H@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXAA9wU+CBZAuxHj7KSTVxtHGrlf5uV9jJLFc7Iaze5wlEfWt
	sjpPwn9yNcF0W7db4K2tStzo2FyjS1nnz9Zn1v+iawcQDLzSdECzr+iOamn8IWdH3ipbo1jBxK8
	QrCqPWJ3fNA==
X-Received: from dlae15.prod.google.com ([2002:a05:701b:230f:b0:135:2b50:3913])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4193:b0:12d:ca31:f1b4
 with SMTP id a92af1059eb24-135047447camr5873896c88.24.1779079672430; Sun, 17
 May 2026 21:47:52 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:26 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-1-irogers@google.com>
Subject: [PATCH v6 00/14] perf build: Reduce build time by nearly half
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

Changes since v5:
  - perf pmu-events (Patch 10): Refactored jevents.py to explicitly close output_file
    first and output_string_file second at the absolute tail of main(), guaranteeing
    that pmu-events-string.c receives a filesystem modification timestamp strictly
    greater than or equal to pmu-events.c. This completely eliminates any nanosecond
    timestamp discrepancy during Python teardown, ensuring Make's canonical @:
    dependency chaining rule correctly sees pmu-events-string.c as fully up to
    date and preventing redundant recompilations during incremental builds without
    requiring manual touch commands in the Makefile.

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


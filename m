Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3663B2FD8
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564156; cv=none; b=RH8XthztmjNxICNJYYNjxZTsYpjY+7nBzGijgcZ/iuUYe+w8rvDCG8aAUUdcDlECTmNAGguW3Lv5kvD3VZyHWA8nIxy49BWsOddnCfwZN/7/OyGJilZMAoEicpawrtgP9S0fnCDza9uI0Ug3RFlXzvaG4eNK03SoFWNBn3x9SrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564156; c=relaxed/simple;
	bh=prhUEXNy700MP/6RYR7a1fmxZ4ZM6XmgWI1WEJahGws=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S4+3WcaY4Y3dLQkoa9iHfiSQU0IlLepgPSXUfxWijKI+2HKCewDH0vF88KunxFb01V+XG0WhBOUisVcOwTKG1yWLUbijmIsbb12MHDGPsC5PeAFI/kcP+Kw4EjD0IMtTsbCHB/9dIq5iL7NV7uuz3Ewknru4nDyViPRzYc5zl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRiwUeTI; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRiwUeTI"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312be8a31so6428599c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564151; x=1779168951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pNhqTiBRGI2NE+albQbZMGfXtOIXIbZHu6e7et5R7l4=;
        b=CRiwUeTIqCWa768o0foVB6U7h1ZcwmWGTUTr44ST6CkJom7bK/+bz3EdO2r7vUES7M
         5fjnWNQNvfKeVX8Mvt927/lJ47nOduVWCuT4P/ZpSLEHEGg3MSXzeEtVSDr8byNbPOTM
         EwDmqX+BMXAmXniyKDDrVwUKcAuVFtnj5Zc2HDVNyi+0wl1rgIiP1BVTUxbRXqKlXPgf
         jSG60h12fXjH3Nlqt99kxnVWcTleSOF4HCSlNYpthDtoeFrRN6UiW8tjiLGUsog3Xwiz
         grM14wUmCv3O3plaaAJbrITUCfBCgaYdcW2A1PPMqyNkVH30wehTV8M3E0dcmbveoByZ
         g7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564151; x=1779168951;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNhqTiBRGI2NE+albQbZMGfXtOIXIbZHu6e7et5R7l4=;
        b=ThtVb4cI+3EATI8qTDrN+EaoqZhpycQcc0H4+vAdckTE8tx5RxhqaGEVdY+5QvUXIY
         m4f9aJI0tf435WnhbowwCqASUPiXI7OhJV3tKsZoQh83zxXVheb2hO1nVMpDWlNqAONi
         n29sKVkFTmlWbXvqwJp8wVUR0oDcv2zyWXOzUKRierYJAMdMKyqAWjt7ZOqZLTMQfLuz
         gJRspNb2oy7W+8mFoCmXIHiQYbWuVPy9LAWNdltXSTxInaKNBWKcyZoFbm6rc96lIZUQ
         +Ad3cwZ++X4fTtwy5tnKBkxZkvtlo+PZDO1ZzxuLvZrPuEX0J5LKMeDn+85vPsl8LGBD
         aiMA==
X-Forwarded-Encrypted: i=1; AFNElJ+6k/6PWUkUt6vIc8j+vsGPc3hu27paHxVsSbz1XerFdQcuAgZdQdXcsSfrzlvF1eRX5hVzLNfSmrs9wIzD7OXy@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/K/zq2+7a2aI/J4QXfy7KFoLFE4Cve7O7+DMcE4hO2nuo12m
	I/sR/acYcn2FKV1Meia4hxEH0UTozo2HH3ltujDHZ1TQOh8mdSNcp30xMjUuiFMv1l+D0/pZoQs
	sIEJChzzePA==
X-Received: from dlah16.prod.google.com ([2002:a05:701b:2610:b0:130:ca6f:6c3e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2509:b0:130:9bce:c60f
 with SMTP id a92af1059eb24-13271377e33mr9926157c88.14.1778564151203; Mon, 11
 May 2026 22:35:51 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:25 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-1-irogers@google.com>
Subject: [PATCH v1 00/14] perf build: Reduce build time by one third
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Markus Mayer <mmayer@broadcom.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series refactors many aspects of the perf build aiming to
better encapsulate BPF code generation, remove serial build code and
gain build parallelism. The prepare step that blocks the parallel
build is reduced to a core 6 smaller dependencies. BPF skeletons are
made regular dependencies on the targets that use them. Feature tests
and dependencies are reorgnized. The jevents.py script processes json
files in parallel and allows the big_c_string to be compiled
separately.

On a 28-core build workstation (make -j28 all from scratch), clean build
latency improves by over 36%:

  Before:
    real    0m29.006s
    user    2m46.019s
    sys     0m30.610s

  After:
    real    0m18.498s
    user    2m32.922s
    sys     0m27.623s

Summary of Patches:

1: bpftool Bootstrap Optimization
  - Exempts bpftool bootstrap from non-essential feature tests (LLVM, libbfd,
    libcap), saving 1.1s of sub-make fork overhead during Kbuild startup.

2-4: Flattening Umbrella Prepare Barriers
  - builtin-trace embedded inclusions and pmu-events generation are completely
    decoupled from the sequential "prepare" umbrella target, eliminating Make
    AST double-parsing overhead and unchoking parallel compilation barriers.

5-8: Decoupling & Pre-generating BPF Skeletons
  - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel.mak.
  - Decouples bpftool bootstrap from top-level static libbpf dependencies,
    attaching bpf-skel-prepare directly to the umbrella prepare target. This
    allows Make to pre-compile bpftool and dump vmlinux.h in the background at
    build startup, removing the 7-second serialization bottleneck before BPF
    object compilation.

9-11: Foundational Linkage & Fast-Path Feature Detection
  - Eliminates redundant libbpf sub-make feature checks during static builds.
  - Integrates libdebuginfod directly into test-all.c, allowing Make to skip
    individual feature check sub-make forks during AST parsing on fully
    configured workstations.

12-13: jevents.py Concurrency & Deduplication
  - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c into a
    dedicated pmu-events-string.c compilation unit. This slices C compilation
    latency in half by compiling string and struct tables simultaneously across
    separate CPU cores while preserving zero dynamic ELF relocations.
  - Pre-populates jevents.py JSON ASTs and metric formulas in parallel across
    all available CPU cores using ProcessPoolExecutor (accelerating Python
    execution by 11x, from 3.3s down to ~290ms).

14: Out-of-Tree Incremental Rebuild Fix
  - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to prevent
    Make from continuously re-executing script installation rules on already
    built out-of-tree builds.

Ian Rogers (14):
  bpftool build: Restrict feature tests during bootstrap compilation
  perf trace beauty: Make beauty generated C code standalone .o files
  perf build: Decouple pmu-events from prepare umbrella target
  perf build: Remove empty archheaders target
  perf build: Move BPF skeleton generation out of Makefile.perf
  perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
  perf build: Move static libbpf dependency out of prepare step
  perf build: Pre-generate BPF skeletons during umbrella prepare phase
  perf build: Move libsymbol dependency out of prepare step
  perf build: Remove redundant libbpf feature check for static builds
  tools build: Integrate libdebuginfod into test-all fast path
  perf pmu-events: Split big_c_string storage into standalone
    compilation unit
  perf pmu-events: Parallelize JSON and metric pre-computation in
    jevents.py
  perf build: Prefix SCRIPTS with output directory to fix continuous
    rebuilds

 tools/bpf/bpftool/Makefile                    |   5 +
 tools/build/Makefile.feature                  |   6 +-
 tools/build/feature/Makefile                  |   2 +-
 tools/build/feature/test-all.c                |   5 +
 tools/perf/Build                              |   2 +
 tools/perf/Makefile.config                    |   6 +-
 tools/perf/Makefile.perf                      | 427 +-----------------
 tools/perf/bench/Build                        |   6 +
 .../bpf_skel/bench_uprobe.bpf.c               |   0
 tools/perf/bench/uprobe.c                     |   2 +-
 tools/perf/bpf_skel.mak                       | 110 +++++
 tools/perf/builtin-trace.c                    |  30 +-
 tools/perf/pmu-events/Build                   |  15 +-
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
 40 files changed, 700 insertions(+), 491 deletions(-)
 rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
 create mode 100644 tools/perf/bpf_skel.mak
 create mode 100644 tools/perf/trace/beauty/fsconfig.c
 rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
 rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)

-- 
2.54.0.563.g4f69b47b94-goog


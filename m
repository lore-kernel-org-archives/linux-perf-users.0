Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8438333A;
	Thu, 14 May 2026 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778796388; cv=none; b=Flxk5HBOs2sLDE4Dx6/UIS6Q58rbsyIM/aqzfwJuLnQFqj94G9hpQ5pC3RVDkSMzCLUPRYeq84hiXtlhY9RoN9uN0boMGDWi2Poj9WOAf2Y4SQxHWpI0eHDdZ5j2lq6kpGYFUriXh5L/Z8gSPLlog0v/P4A2AUtreALfrcOiSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778796388; c=relaxed/simple;
	bh=wsH6B/968EiUIP4+LlVmje2L/S/VXxqyIz+PY4OIB40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLMjWhzDnNLUt+dcIuwYzaMoJ7WN7qn598hTaRO8fTxFkOCsJMY+XWGNq/yBsHezcNbpvsg7Qxt73LCtumNj0IpyX8sC6DLxqFaP+1WjafEw4u137ejoNqh9Gp66bCqrEv7VHFbgVXMbRvYfcjl2QQN/qvp4AzPdJf0lMifOtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmqUAOYH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmqUAOYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8752C2BCB3;
	Thu, 14 May 2026 22:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778796387;
	bh=wsH6B/968EiUIP4+LlVmje2L/S/VXxqyIz+PY4OIB40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmqUAOYH50kTCntKMeeRaAHK+6eJs3O7qfPuAP1ZGL2o4ofBDwguOSiFPivybg7aL
	 StFPmn5Y+niJQxzfhVgUU+sn0cmPMPKpC9Gp6D8qAJSxqoNXhGPL9T9ookQj90wcCY
	 adIV+OEXUqb7dyjAmD/a8N3aDDMPOx5bzt5eWD9KY1bsQgVU1BZGZ1TLl9q4EiEmhs
	 CUBdAquEYo692PyuAirxeI+ltE6p4gpNd073SK3dmBjzvbRY1GEtf9MpllfjCB+Btb
	 qrGKBRGyBnGopeI8BOBvpFoXbARnghPspAJ9qVDZMcDw0V7V7cyZ6eV2ufLkVmGuEE
	 8RnJd8MvAkc6A==
Date: Thu, 14 May 2026 15:06:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, james.clark@linaro.org, 9erthalion6@gmail.com,
	adrian.hunter@intel.com, alex@ghiti.fr,
	alexandre.chartre@oracle.com, andrii@kernel.org,
	ankur.a.arora@oracle.com, aou@eecs.berkeley.edu,
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com,
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com,
	eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org,
	leo.yan@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev,
	memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com,
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org,
	pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me,
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com,
	tglozar@redhat.com, thomas.falcon@intel.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v3 00/17] perf build: Reduce build time by nearly half
Message-ID: <agZHYSFneOSIo8d5@google.com>
References: <20260512174638.120445-1-irogers@google.com>
 <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514163409.927816-1-irogers@google.com>

On Thu, May 14, 2026 at 09:33:52AM -0700, Ian Rogers wrote:
> This patch series refactors Kbuild internals, BPF skeleton generation,
> Python AST pre-computation, and foundational tooling dependencies across
> the perf tool build system. By eliminating umbrella target synchronization
> barriers, decoupling static library prerequisites, parallelizing single-core
> script generators, and eradicating redundant feature checks, this series
> unlocks absolute theoretical peak multi-core concurrency during Kbuild startup.
> 
> On a 28-core build workstation (make -j28 all from scratch), clean build
> latency improves by over 49%:
> 
>   Before:
>     real    0m29.006s
>     user    2m46.019s
>     sys     0m30.610s
> 
>   After:
>     real    0m14.782s
>     user    2m39.527s
>     sys     0m22.938s
> 
> Saving 14.2 full seconds time per clean build. Furthermore, nothing to
> build incremental builds are improved by nearly 7x:
> 
>   Before:
>     real    0m11.528s
>     user    0m9.633s
>     sys     0m6.965s
> 
>   After:
>     real    0m1.729s
>     user    0m1.600s
>     sys     0m0.884s

I've quickly checked it with latency profiling like below:

  $ perf record --latency -- make -C tools/perf

  $ perf report --latency -s comm

The result looks like this.

Before:
  #
  # Samples: 715K of event 'cpu/cycles/Pu'
  # Event count (approx.): 422452811481
  #
  #  Latency  Overhead  Command        
  # ........  ........  ...............
  #
      45.28%    71.33%  cc1            
      34.48%    16.92%  python3        
      11.15%     2.21%  ld             
       2.58%     1.51%  x86_64-linux-gn
       2.22%     0.99%  cc1plus        
       0.71%     0.63%  sh             
       0.69%     0.14%  llvm-config    
       0.62%     0.56%  clang          
       0.57%     4.40%  shellcheck     
       0.44%     0.12%  perl           

After:
  #
  # Samples: 709K of event 'cpu/cycles/Pu'
  # Event count (approx.): 416654798495
  #
  #  Latency  Overhead  Command        
  # ........  ........  ...............
  #
      64.99%    71.16%  cc1            
      15.07%     1.81%  ld             
       7.14%    17.59%  python3        
       3.66%     1.53%  x86_64-linux-gn
       3.48%     0.75%  cc1plus        
       1.11%     4.43%  shellcheck     
       1.09%     0.74%  sh             
       0.86%     0.59%  clang          
       0.77%     0.12%  perl           
       0.45%     0.23%  make           

Now I see a big drop in the latency from python.  And the llvm-config
doesn't show up in the top 10.

Thanks,
Namhyung

> 
> Summary of Patches:
> 
> 1-3: Foundational Tooling & Fast-Path Feature Detection
>   - Exempts bpftool bootstrap from non-essential feature tests (LLVM, libbfd,
>     libcap), saving 1.1s of sub-make fork overhead during Kbuild startup.
>   - Integrates libdebuginfod directly into test-all.c, allowing Make to skip
>     individual feature check sub-make forks during AST parsing on fully
>     configured workstations. Escapes $(shell ...) macro expansion to prevent
>     unconditional sub-make forks.
>   - Fixes test-clang-bpf-co-re.bin feature check to correctly generate its
>     target file on disk via atomic move (> $@.tmp && mv $@.tmp $@), allowing
>     Kbuild to perfectly cache the detection result and avoid continuous sub-make
>     re-evaluations.
> 
> 4-6: Flattening Umbrella Prepare Barriers
>   - builtin-trace embedded inclusions and pmu-events generation are completely
>     decoupled from the sequential "prepare" umbrella target, eliminating Make
>     AST double-parsing overhead and unchoking parallel compilation barriers.
> 
> 7-10: Decoupling & Pre-generating BPF Skeletons
>   - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel.mak.
>   - Decouples bpftool bootstrap from top-level static libbpf dependencies,
>     attaching bpf-skel-prepare directly to the umbrella prepare target. This
>     allows Make to pre-compile bpftool and dump vmlinux.h in the background at
>     build startup, removing the 7-second serialization bottleneck before BPF
>     object compilation.
>   - Ensures benchmark skeleton intermediate .bpf.o files are cleanly removed
>     during make clean, and adds bpf-skel-prepare to .PHONY.
> 
> 11-12: Foundational Linkage Optimization
>   - Eliminates redundant libbpf sub-make feature checks during static builds.
>   - Moves static libsymbol and libbpf library prerequisites out of the
>     prepare step, ensuring libbpf headers are installed before
>     compiling BPF-dependent tests.
> 
> 13-14: jevents.py Concurrency & Deduplication
>   - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c
>     into a dedicated pmu-events-string.c compilation unit. This slices
>     C compilation latency in half by compiling string and struct
>     tables simultaneously across separate CPU cores while preserving
>     zero dynamic ELF relocations. Adds pmu-events-string.c to
>     .gitignore and uses Make 4.0 compatible dependency chaining.
>   - Pre-populates jevents.py JSON ASTs and metric formulas in parallel across
>     all available CPU cores using ProcessPoolExecutor (accelerating Python
>     execution by 11x, from 3.3s down to ~290ms). Moves _init_worker to top-level
>     scope to ensure clean pickling under spawn multiprocessing start methods.
> 
> 15: Out-of-Tree Incremental Rebuild Fix
>   - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to prevent
>     Make from continuously re-executing script installation rules on already
>     built out-of-tree builds.
> 
> 16-17: AST Parsing Optimization & Shell Fork Eradication
>   - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursive
>     assignment (=) to simply expanded assignment (:=) and replaces
>     model_name/vendor_name with pure GNU Make string functions. This
>     guarantees Make executes directory probing shell forks exactly
>     once during AST parsing and evaluates path macros purely in
>     memory, completely eradicating over 7,800 redundant sub-processes
>     during out-of-tree build evaluation.
>   - Converts llvm-config shell queries in Makefile.config from
>     recursive assignment (=) to simply expanded assignment (:=). This
>     eliminates ~185 redundant sub-processes that were previously
>     executed across object compilation dependency checks.
> 
> Changes since v2:
>   - Dropped Patch 4 (tools scripts: Short-circuit CC_NO_CLANG compiler
>     probe in Makefile.include) to prevent potential cross-compilation
>     regressions when CC and HOSTCC use different compilers.
>   - tools build (Patch 2): Escaped $(shell ...) macro expansion as
>     $$(shell ...) inside define feature_check_code to safely defer
>     sub-make execution until after eval parses the ifeq guard.
>   - tools build (Patch 3): Refactored test-clang-bpf-co-re.bin feature
>     check recipe to redirect grep output to a temporary file and
>     atomically move it upon success (> $@.tmp && mv $@.tmp $@),
>     preventing Kbuild from permanently caching failed detections due to
>     0-byte files.
>   - perf trace beauty (Patch 4): Updated commit description to accurately
>     reflect the unconditional top-level recursive kbuild hook
>     (perf-util-y += trace/beauty/).
>   - perf build (Patch 7): Added $(OUTPUT)bench/bpf_skel/.tmp to
>     bpf-skel-clean in Makefile.perf to ensure intermediate benchmark
>     skeleton .bpf.o artifacts are cleanly removed during make clean.
>     Removed unused bpf_skel_deps variable from bpf_skel.mak.
>   - perf build (Patch 9): Added $(LIBBPF) as an explicit prerequisite to
>     $(LIBPERF_TEST_IN) in Makefile.perf to guarantee libbpf headers are
>     fully installed before compiling sigtrap.c or other BPF-dependent
>     tests during parallel builds.
>   - perf build (Patch 10): Added bpf-skel-prepare to the .PHONY target
>     list in Makefile.perf to ensure Make never incorrectly skips the
>     target if a file or directory named bpf-skel-prepare accidentally
>     exists in the build tree.
>   - perf pmu-events (Patch 13): Added pmu-events/pmu-events-string.c to
>     tools/perf/.gitignore. Replaced grouped targets (&:) with Make 4.0
>     compatible dependency chaining to guarantee backward compatibility
>     with older Make versions (like 4.2.1) and prevent parallel builds
>     from spawning multiple concurrent jevents.py processes.
>   - perf pmu-events (Patch 14): Moved _init_worker from local main()
>     scope to the top-level module scope in jevents.py to ensure it can be
>     cleanly pickled when ProcessPoolExecutor uses the spawn
>     multiprocessing start method (avoiding AttributeError crashes).
> 
> Ian Rogers (17):
>   bpftool build: Restrict feature tests during bootstrap compilation
>   tools build: Integrate libdebuginfod into test-all fast path
>   tools build: Fix test-clang-bpf-co-re.bin to generate target file
>   perf trace beauty: Make beauty generated C code standalone .o files
>   perf build: Decouple pmu-events from prepare umbrella target
>   perf build: Remove empty archheaders target
>   perf build: Move BPF skeleton generation out of Makefile.perf
>   perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
>   perf build: Move static libbpf dependency out of prepare step
>   perf build: Pre-generate BPF skeleton tooling during umbrella prepare
>     phase
>   perf build: Move libsymbol dependency out of prepare step
>   perf build: Remove redundant libbpf feature check for static builds
>   perf pmu-events: Split big_c_string storage into standalone
>     compilation unit
>   perf pmu-events: Parallelize JSON and metric pre-computation in
>     jevents.py
>   perf build: Prefix SCRIPTS with output directory to fix continuous
>     rebuilds
>   perf pmu-events: Convert recursive shell assignments and macros to
>     Make built-ins
>   perf build: Convert llvm-config shell queries to simply expanded
>     variables
> 
>  tools/bpf/bpftool/Makefile                    |   5 +
>  tools/build/Makefile.feature                  |   6 +-
>  tools/build/feature/Makefile                  |   4 +-
>  tools/build/feature/test-all.c                |   5 +
>  tools/perf/.gitignore                         |   1 +
>  tools/perf/Build                              |   2 +
>  tools/perf/Makefile.config                    |  19 +-
>  tools/perf/Makefile.perf                      | 431 ++----------------
>  tools/perf/bench/Build                        |   6 +
>  .../bpf_skel/bench_uprobe.bpf.c               |   0
>  tools/perf/bench/uprobe.c                     |   2 +-
>  tools/perf/bpf_skel.mak                       | 109 +++++
>  tools/perf/builtin-trace.c                    |  30 +-
>  tools/perf/pmu-events/Build                   |  26 +-
>  tools/perf/pmu-events/jevents.py              |  56 ++-
>  tools/perf/trace/beauty/Build                 | 280 ++++++++++++
>  tools/perf/trace/beauty/arch_errno_names.c    |   2 +
>  tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
>  tools/perf/trace/beauty/beauty.h              |  60 +++
>  tools/perf/trace/beauty/eventfd.c             |   6 +-
>  tools/perf/trace/beauty/fsconfig.c            |   5 +
>  tools/perf/trace/beauty/futex_op.c            |   6 +-
>  tools/perf/trace/beauty/futex_val3.c          |   6 +-
>  tools/perf/trace/beauty/mmap.c                |  24 +-
>  tools/perf/trace/beauty/mode_t.c              |   6 +-
>  tools/perf/trace/beauty/msg_flags.c           |   8 +-
>  tools/perf/trace/beauty/open_flags.c          |   1 +
>  tools/perf/trace/beauty/perf_event_open.c     |  22 +-
>  tools/perf/trace/beauty/pid.c                 |   5 +-
>  tools/perf/trace/beauty/sched_policy.c        |   8 +-
>  tools/perf/trace/beauty/seccomp.c             |  12 +-
>  tools/perf/trace/beauty/signum.c              |   6 +-
>  tools/perf/trace/beauty/socket_type.c         |   6 +-
>  .../perf/{util => trace/beauty}/syscalltbl.c  |   0
>  .../perf/{util => trace/beauty}/syscalltbl.h  |   0
>  tools/perf/trace/beauty/tracepoints/Build     |  22 +
>  tools/perf/trace/beauty/waitid_options.c      |   8 +-
>  tools/perf/util/Build                         |  17 +-
>  tools/perf/util/bpf-trace-summary.c           |   2 +-
>  tools/perf/util/env.c                         |   4 +-
>  tools/perf/util/env.h                         |   1 +
>  41 files changed, 717 insertions(+), 504 deletions(-)
>  rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
>  create mode 100644 tools/perf/bpf_skel.mak
>  create mode 100644 tools/perf/trace/beauty/fsconfig.c
>  rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
>  rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)
> 
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F428145B3E;
	Sun, 25 May 2025 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748165561; cv=none; b=vACya+aXR3WaDGB7mXpN2+Rl162LYZ/TWMofG6iwXfhPQie7FW+sC4r+R7qoeAj3tiwFUfQAhOLN3GfeSzYNY+CybdzOPMX9fxGyjGF68anExXV7NGk30JlUv5Ub32XR5CdfiCBEIfyNzX5M2w6dcyZ33ann9ZdfQ44/1aS5oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748165561; c=relaxed/simple;
	bh=kl24Ua0UelZhR/nAFsC2xKWJof/FjZSiqCRD9U6PU50=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EF5tB4fITqku7byXDxbl6PcB79NPNrkePVK3/F46H0mhXV8412y8RYnqVG9VMJy/z/FxL/ekpEwfr/0BOU10Dd7JXKoW4vU6ainXOvkqkKR57ED5xLQsJSa0/l9kWMVeu7gPg4eUDN5N+XOsLfmm10hqv4caLQdcKqn4Q3blrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0XTeH17; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0XTeH17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC7CC4CEEA;
	Sun, 25 May 2025 09:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748165560;
	bh=kl24Ua0UelZhR/nAFsC2xKWJof/FjZSiqCRD9U6PU50=;
	h=Date:From:To:Cc:Subject:From;
	b=p0XTeH17AiwultY3X+mQDAj7Dql55yDdALkzHAN7YSCoX7tIXgXhbmu4UI4KnB/+7
	 zAqFkLgTDKFqXxNpTqjEtGDNWQ1ScU/vkwRsz3R65T3+Qfrd7BzkLztzw1GjKKIKea
	 VUJ7qd7+u3UpO4Q0XoVHhszANEtRQdUS8/bDQCqzKEoSsk1SoaoR89VtZ8DR7KVeZQ
	 o5O8dFUWk70IM6YT29yy109aPi3FZ6NUBxdXLw7TaQV0B9EeLiKohicvXkF59CWEQw
	 BTl3KZzEPXRroxblacUJpU90N1wdRyDUMWoCnp0vHxzktwg9srjnjK5posm1qOxk2h
	 n7MXB+2kTPAiw==
Date: Sun, 25 May 2025 11:32:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events updates for v6.16
Message-ID: <aDLjswBHxzKz1gx2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-05-25

   # HEAD: e7d952cc39fca34386ec9f15f68cb2eaac01b5ae perf/headers: Clean up <linux/perf_event.h> a bit

Performance events updates for v6.16:

Core & generic-arch updates:

 - Add support for dynamic constraints and propagate it to
   the Intel driver (Kan Liang)

 - Fix & enhance driver-specific throttling support (Kan Liang)

 - Record sample last_period before updating on the
   x86 and PowerPC platforms (Mark Barnett)

 - Make perf_pmu_unregister() usable (Peter Zijlstra)

 - Unify perf_event_free_task() / perf_event_exit_task_context()
   (Peter Zijlstra)

 - Simplify perf_event_release_kernel() and perf_event_free_task()
   (Peter Zijlstra)

 - Allocate non-contiguous AUX pages by default (Yabin Cui)

Uprobes updates:

 - Add support to emulate NOP instructions (Jiri Olsa)

 - selftests/bpf: Add 5-byte NOP uprobe trigger benchmark (Jiri Olsa)

x86 Intel PMU enhancements:

 - Support Intel Auto Counter Reload [ACR] (Kan Liang)

 - Add PMU support for Clearwater Forest (Dapeng Mi)

 - Arch-PEBS preparatory changes: (Dapeng Mi)

   - Parse CPUID archPerfmonExt leaves for non-hybrid CPUs
   - Decouple BTS initialization from PEBS initialization
   - Introduce pairs of PEBS static calls

x86 AMD PMU enhancements:

 - Use hrtimer for handling overflows in the AMD uncore driver
   (Sandipan Das)

 - Prevent UMC counters from saturating (Sandipan Das)

Fixes and cleanups:

 - Fix put_ctx() ordering (Frederic Weisbecker)

 - Fix irq work dereferencing garbage (Frederic Weisbecker)

 - Misc fixes and cleanups (Changbin Du, Frederic Weisbecker,
   Ian Rogers, Ingo Molnar, Kan Liang, Peter Zijlstra, Qing Wang,
   Sandipan Das, Thorsten Blum)

 Thanks,

	Ingo

------------------>
Changbin Du (1):
      perf/x86/intel/ds: Remove redundant assignments to sample.period

Dapeng Mi (5):
      perf/x86/intel: Add PMU support for Clearwater Forest
      perf/x86/intel: Parse CPUID archPerfmonExt leaves for non-hybrid CPUs
      perf/x86/intel: Decouple BTS initialization from PEBS initialization
      perf/x86/intel: Rename x86_pmu.pebs to x86_pmu.ds_pebs
      perf/x86/intel: Introduce pairs of PEBS static calls

Frederic Weisbecker (5):
      perf/core: Fix put_ctx() ordering
      perf: Fix failing inherit_event() doing extra refcount decrement on parent
      perf: Fix irq work dereferencing garbage
      perf: Remove too early and redundant CPU hotplug handling
      perf: Fix confusing aux iteration

Ian Rogers (1):
      perf/uapi: Fix PERF_RECORD_SAMPLE comments in <uapi/linux/perf_event.h>

Ingo Molnar (2):
      perf/uapi: Clean up <uapi/linux/perf_event.h> a bit
      perf/headers: Clean up <linux/perf_event.h> a bit

Jiri Olsa (2):
      uprobes/x86: Add support to emulate NOP instructions
      selftests/bpf: Add 5-byte NOP uprobe trigger benchmark

Kan Liang (24):
      perf/x86: Add dynamic constraint
      perf/x86/intel: Track the num of events needs late setup
      perf: Extend the bit width of the arch-specific flag
      perf/x86/intel: Add CPUID enumeration for the auto counter reload
      perf/x86/intel: Support auto counter reload
      perf/x86/intel: Check the X86 leader for ACR group
      perf/x86: Optimize the is_x86_event
      perf/core: Add the is_event_in_freq_mode() helper to simplify the code
      perf: Fix the throttle logic for a group
      perf: Only dump the throttle log for the leader
      perf/x86/intel: Remove driver-specific throttle support
      perf/x86/amd: Remove driver-specific throttle support
      perf/x86/zhaoxin: Remove driver-specific throttle support
      powerpc/perf: Remove driver-specific throttle support
      s390/perf: Remove driver-specific throttle support
      perf/arm: Remove driver-specific throttle support
      perf/apple_m1: Remove driver-specific throttle support
      alpha/perf: Remove driver-specific throttle support
      arc/perf: Remove driver-specific throttle support
      csky/perf: Remove driver-specific throttle support
      loongarch/perf: Remove driver-specific throttle support
      sparc/perf: Remove driver-specific throttle support
      xtensa/perf: Remove driver-specific throttle support
      mips/perf: Remove driver-specific throttle support

Mark Barnett (1):
      perf/arch: Record sample last_period before updating on the x86 and PowerPC platforms

Peter Zijlstra (10):
      perf: Ensure bpf_perf_link path is properly serialized
      perf: Simplify child event tear-down
      perf: Simplify perf_event_free_task() wait
      perf: Simplify perf_event_release_kernel()
      perf: Unify perf_event_free_task() / perf_event_exit_task_context()
      perf: Rename perf_event_exit_task(.child)
      perf: Make perf_pmu_unregister() useable
      perf/core: Fix perf-stat / read()
      perf/core: Fix event->parent life-time issue
      perf/core: Fix event timekeeping merge

Qing Wang (1):
      perf/core: Fix broken throttling when max_samples_per_tick=1

Sandipan Das (5):
      perf/x86/amd/uncore: Remove unused 'struct amd_uncore_ctx::node' member
      perf/x86/intel/uncore: Use HRTIMER_MODE_HARD for detecting overflows
      perf/x86/amd/uncore: Use hrtimer for handling overflows
      perf/x86/amd/uncore: Add parameter to configure hrtimer
      perf/x86/amd/uncore: Prevent UMC counters from saturating

Thorsten Blum (2):
      perf/x86/intel/bts: Rename local bts_buffer variables for clarity
      perf/x86/intel/bts: Replace offsetof() with struct_size()

Yabin Cui (1):
      perf/aux: Allocate non-contiguous AUX pages by default


 arch/alpha/kernel/perf_event.c                     |  11 +-
 arch/arc/kernel/perf_event.c                       |   6 +-
 arch/csky/kernel/perf_event.c                      |   3 +-
 arch/loongarch/kernel/perf_event.c                 |   3 +-
 arch/mips/kernel/perf_event_mipsxx.c               |   3 +-
 arch/powerpc/perf/core-book3s.c                    |   9 +-
 arch/powerpc/perf/core-fsl-emb.c                   |   6 +-
 arch/s390/kernel/perf_cpum_cf.c                    |   2 -
 arch/s390/kernel/perf_cpum_sf.c                    |   5 +-
 arch/sparc/kernel/perf_event.c                     |   3 +-
 arch/x86/events/amd/core.c                         |   3 +-
 arch/x86/events/amd/ibs.c                          |   4 +-
 arch/x86/events/amd/uncore.c                       | 103 +++-
 arch/x86/events/core.c                             |  37 +-
 arch/x86/events/intel/bts.c                        | 150 ++---
 arch/x86/events/intel/core.c                       | 345 ++++++++++-
 arch/x86/events/intel/ds.c                         |  55 +-
 arch/x86/events/intel/knc.c                        |   7 +-
 arch/x86/events/intel/lbr.c                        |   2 +-
 arch/x86/events/intel/p4.c                         |   3 +-
 arch/x86/events/intel/pt.c                         |   2 +
 arch/x86/events/intel/uncore.c                     |  12 +-
 arch/x86/events/perf_event.h                       |  45 +-
 arch/x86/events/perf_event_flags.h                 |  41 +-
 arch/x86/events/zhaoxin/core.c                     |   3 +-
 arch/x86/include/asm/msr-index.h                   |   4 +
 arch/x86/include/asm/perf_event.h                  |   1 +
 arch/x86/kernel/uprobes.c                          |   5 +
 arch/xtensa/kernel/perf_event.c                    |   3 +-
 drivers/perf/apple_m1_cpu_pmu.c                    |   3 +-
 drivers/perf/arm_pmuv3.c                           |   3 +-
 drivers/perf/arm_v6_pmu.c                          |   3 +-
 drivers/perf/arm_v7_pmu.c                          |   3 +-
 drivers/perf/arm_xscale_pmu.c                      |   6 +-
 include/linux/cpuhotplug.h                         |   1 -
 include/linux/perf_event.h                         | 298 ++++++----
 include/uapi/linux/perf_event.h                    | 657 +++++++++++----------
 kernel/cpu.c                                       |   5 -
 kernel/events/core.c                               | 609 +++++++++++++------
 kernel/events/ring_buffer.c                        |  29 +-
 tools/include/uapi/linux/perf_event.h              | 657 +++++++++++----------
 tools/testing/selftests/bpf/bench.c                |  12 +
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  42 ++
 .../selftests/bpf/benchs/run_bench_uprobes.sh      |   2 +-
 44 files changed, 1996 insertions(+), 1210 deletions(-)

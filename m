Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75D3DDB16;
	Mon, 17 Aug 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959067; cv=none; b=fNgsPKai7Sk+xWWMJTpEP7xImjz/tLaBpPf44lvT8QkEm/+ZN7T3StmKXzgFzh63ZZUzV+E5vorxAR5COWFXz+/NvCobZSdd4Se1dFhRArK/rlTp4XeK09RiqTaUj23dZTfuz7owCnJ5F7MJx35CDMMkmYZnDcuzqdKqVI6tVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959067; c=relaxed/simple;
	bh=RMnsqCHktk7wcaUgIpNQg0CfoCI/JLlauJyK5cBpi4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qTktEihyA8DFX/plFmYzHbY1+rOrgTpcZNgcX1hPwEpt7xyj2L6jNZDsc2HENPPxGSo75gEfLYpcsCDWFpiJQstiMmeVPkN84Ohac5uc1V6DXYjH2hbdEvCb/kQlQkta70zRiQXO2Cj5HhhxqFLiFpeZLmSmcy/+F3PnAoKs7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0UJGHpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0UJGHpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135AC1F000E9;
	Mon, 17 Aug 2026 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786959054;
	bh=80BTs3ye8PrOejDXtDgu4EdbAu0Lz9ltWmciptTKxBg=;
	h=Date:From:To:Cc:Subject;
	b=H0UJGHpq1iQggz3gXRY7mPvJJDqBGRaWAIx/3E5BjXD/IcWQHdr9XfEkAOvvV/pCo
	 DsU/760sxnZyVLBoDmhal8Sy00qpllaaJU+x9UOamWhe7V8HFX05O9xAVwWaYAZED0
	 psO4dTsyqYF302cxyJpKu1D+Og/HmtYVtWQuOvHPAqtIip7CkeqVj4HfR2jPE4Zxg5
	 1sWx7IhtV12MVpQvI3KvHz+kJNN+yk+w5bhAgqageEgguPFEIlEIY/x7jllelGMccd
	 c4Bogr9cKydp64u7AtVh6Pwr1HSVtBMCpYo6N1el0LtmbKOW62JVQpLtsBRU9SpvlR
	 qbelKlU2LO9YA==
Date: Mon, 17 Aug 2026 11:30:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [GIT PULL] Performance events updates for v7.3
Message-ID: <aoLUyf6R-TBxOgjT@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-08-17

for you to fetch changes up to 917d558b151cad5b05991e5eaee22efab33525ca:

Performance events updates for v7.3:

uprobes updates:

 - Patch series to fix a category of bugs with optimized uprobes that
   can clobber the redzone area with call instruction storing return
   address on stack where user code may keep temporary data without
   adjusting RSP. Fix this by moving the optimized uprobes on top of
   10-bytes NOP instruction, so we can squeeze another instruction to
   escape the redzone area before doing the call.
   (Jiri Olsa, Andrii Nakryiko)

 - Switch uretprobes_srcu to SRCU-fast-updown, to improve performance
   (Puranjay Mohan)

Intel CPU PMU driver updates:

 - Optimize ACR handling in match_prev_assignment() (Dapeng Mi)
 - Patch series to fix various PMU driver bugs and data leaks (Dapeng Mi)
 - Fix Intel PT stop/start with no update (Adrian Hunter)

Intel uncore PMU driver updates:

 - Series to fix various uncore PMU setup robustness bugs (Zide Chen)

AMD uncore PMU driver updates:

 - Add group validation (Sandipan Das)

Misc fixes and updates by Dapeng Mi, Randy Dunlap and Zide Chen.

 Thanks,

	Ingo

------------------>
Adrian Hunter (3):
      perf/x86/intel/pt: Factor out pt_config_enable()
      perf/x86/intel/pt: Use bitwise access for PERF_HES_STOPPED
      perf/x86/intel/pt: Fix stop/start with no update

Andrii Nakryiko (1):
      selftests/bpf: Add tests for uprobe nop10 red zone clobbering

Dapeng Mi (15):
      perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
      perf/x86/intel: Keep cap_user_rdpmc in sync with RDPMC user-disable state
      perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
      perf/x86/intel: Fix kernel address leakages in LBR stack
      perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()
      perf/x86/intel: Drop fixed-counter PEBS constraints for baseline PEBS
      perf/core: Fix kernel register info leak via hardware skid
      perf/core: Check kernel access when kernel callchains are requested
      perf/x86: Unregister PMI handler on PMU init failure
      perf/x86: Free hybrid state on PMU init failure
      perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts
      perf/x86/intel: Unwind cpuc state if PEBS buffer setup fails
      perf/x86: Remove stale fixed counter helper and fix hybrid PMU access
      perf/x86/intel: Fix intel_cap handling on hybrid PMUs
      perf/x86: Optimize ACR handling in match_prev_assignment()

Jiri Olsa (11):
      uprobes/x86: Remove struct uprobe_trampoline object
      uprobes/x86: Do not leak trampoline vma mapping on optimization failure
      uprobes/x86: Allow to copy uprobe trampolines on fork
      uprobes/x86: Move optimized uprobe from nop5 to nop10
      libbpf: Change has_nop_combo to work on top of nop10
      libbpf: Detect uprobe syscall with new error
      selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
      selftests/bpf: Change uprobe syscall tests to use nop10
      selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
      selftests/bpf: Add reattach tests for uprobe syscall
      selftests/bpf: Add tests for forked/cloned optimized uprobes

Puranjay Mohan (2):
      srcu: Add lock guard for srcu_fast_updown flavor
      uprobes: Switch uretprobes_srcu to SRCU-fast-updown

Randy Dunlap (1):
      perf/x86/intel/pt: Drop kernel-doc for deleted struct members

Sandipan Das (1):
      perf/x86/amd/uncore: Add group validation

Zide Chen (8):
      perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure
      perf/x86/intel/uncore: Fix refcnt and other cleanups
      perf/x86/intel/uncore: Let init_box() callback report failures
      perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails
      perf/x86/intel/uncore: Factor out box setup code
      perf/x86/intel/uncore: Introduce PMU flags and broken state
      perf/x86/intel/uncore: Fix uncore_box ref/unref ordering
      perf/x86/intel/uncore: Implement lazy setup for MSR/MMIO PMUs


 arch/x86/events/amd/uncore.c                       |  31 ++
 arch/x86/events/core.c                             |  48 ++-
 arch/x86/events/intel/core.c                       | 120 +++---
 arch/x86/events/intel/ds.c                         |  13 -
 arch/x86/events/intel/lbr.c                        |  14 +-
 arch/x86/events/intel/pt.c                         |  96 +++--
 arch/x86/events/intel/pt.h                         |   2 -
 arch/x86/events/intel/uncore.c                     | 225 ++++++------
 arch/x86/events/intel/uncore.h                     |  39 +-
 arch/x86/events/intel/uncore_discovery.c           |  21 +-
 arch/x86/events/intel/uncore_discovery.h           |   6 +-
 arch/x86/events/intel/uncore_nhmex.c               |   3 +-
 arch/x86/events/intel/uncore_snb.c                 |  82 +++--
 arch/x86/events/intel/uncore_snbep.c               |  77 ++--
 arch/x86/events/perf_event.h                       |  16 +-
 arch/x86/kernel/uprobes.c                          | 404 +++++++++++++--------
 include/linux/srcu.h                               |   7 +
 include/linux/uprobes.h                            |  10 +-
 kernel/events/core.c                               |  41 ++-
 kernel/events/uprobes.c                            |  39 +-
 kernel/fork.c                                      |   1 -
 tools/lib/bpf/features.c                           |   4 +-
 tools/lib/bpf/usdt.c                               |  16 +-
 tools/testing/selftests/bpf/bench.c                |  20 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  38 +-
 .../selftests/bpf/benchs/run_bench_uprobes.sh      |   2 +-
 .../selftests/bpf/prog_tests/uprobe_syscall.c      | 325 +++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/usdt.c      |  74 +++-
 tools/testing/selftests/bpf/progs/test_usdt.c      |  25 ++
 tools/testing/selftests/bpf/usdt.h                 |   2 +-
 tools/testing/selftests/bpf/usdt_2.c               |  15 +-
 31 files changed, 1232 insertions(+), 584 deletions(-)


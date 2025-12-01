Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF799305E37;
	Mon,  1 Dec 2025 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585953; cv=none; b=MmyTTllGfSR7vAwLjArq5NaYZ4/Km2JADEGgNZt93Ax5LUZj9F75uez5hbQMTErgYRMJwDXQVYw+gPfi6DCqXvnIG9mAsMRuwk9Z8N32vdSqA7ZevlInNQ9Yc63eB5gXnrzAPHyQmYF92E/xzPIBMvkFngK76LOfpf/JYznA1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585953; c=relaxed/simple;
	bh=25PnXB4BGECn7d5Y9NRERFkV7b7GjsCJ1CXKn3X5iKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OGwhPL4bxfHv+OHnkV7ZYAzxYZinnT1J0yoRHyOdgaiaYfyrxMEWU8kvwTLoVgd+ce/WlVaL5Iqtk25Zz2VqUkvtYuMdKiwL2LxPSVAFPigbrFDwNsjaKPe+IQ/isyFAQMpsKT1VBiyl8eeYTCPwiHDVvaz5yytRJfYDBcyxN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8va5Smi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8va5Smi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB4BC19425;
	Mon,  1 Dec 2025 10:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764585952;
	bh=25PnXB4BGECn7d5Y9NRERFkV7b7GjsCJ1CXKn3X5iKg=;
	h=Date:From:To:Cc:Subject:From;
	b=i8va5SmiAbx7WRVurtujiMrwVQNlNyhXJbfAtHujC65xyBYMotkKmozoZC9CuICFf
	 arxJE6jK7koOtDOQFxrvhqyHg0HQBmWaTMTtX+4ujAzHIJRF54vyjDeLHfDBBry7Pl
	 TYNzESGOJ5mpiliW/IMx83tCPsxAS6SVB8ay90ly+Hiho5wg3uYAFndHnmXBIpf8cK
	 ajRXj5y/BOwl8X0AGHWVGmaxHbeV/x2C4lhNJzhBm8fZ1vhm/RNzdiPD3VQMoYmbdn
	 cOF5PybTP3oyWy3awsrfaayhlGRTEjjkmsuHoMRr8MakRxkQKdbsUWSfdjHR4jXK6+
	 VXe1RIlNkDYaw==
Date: Mon, 1 Dec 2025 11:45:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events changes for v6.19
Message-ID: <aS1x278mfIu6gIcd@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-12-01

   # HEAD: 9929dffce5ed7e2988e0274f4db98035508b16d9 perf/x86/intel: Fix and clean up intel_pmu_drain_arch_pebs() type use

Performance events changes for v6.19:

Callchain support:

 - Add support for deferred user-space stack unwinding for
   perf, enabled on x86. (Peter Zijlstra, Steven Rostedt)

 - unwind_user/x86: Enable frame pointer unwinding on x86
   (Josh Poimboeuf)

x86 PMU support and infrastructure:

 - x86/insn: Simplify for_each_insn_prefix() (Peter Zijlstra)

 - x86/insn,uprobes,alternative: Unify insn_is_nop()
   (Peter Zijlstra)

Intel PMU driver:

 - Large series to prepare for and implement architectural PEBS
   support for Intel platforms such as Clearwater Forest (CWF)
   and Panther Lake (PTL). (Dapeng Mi, Kan Liang)

 - Check dynamic constraints (Kan Liang)

 - Optimize PEBS extended config (Peter Zijlstra)

 - cstates: Remove PC3 support from LunarLake (Zhang Rui)

 - cstates: Add Pantherlake support (Zhang Rui)

 - cstates: Clearwater Forest support (Zide Chen)

AMD PMU driver:

 - x86/amd: Check event before enable to avoid GPF (George Kennedy)

Fixes and cleanups:

 - task_work: Fix NMI race condition (Peter Zijlstra)

 - perf/x86: Fix NULL event access and potential PEBS record loss
   (Dapeng Mi)

 - Misc other fixes and cleanups.
   (Dapeng Mi, Ingo Molnar, Peter Zijlstra)

 Thanks,

	Ingo

------------------>
Dapeng Mi (12):
      perf/x86: Remove redundant is_x86_event() prototype
      perf/x86: Fix NULL event access and potential PEBS record loss
      perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
      perf/x86/intel: Correct large PEBS flag check
      perf/x86/intel: Initialize architectural PEBS
      perf/x86/intel/ds: Factor out PEBS record processing code to functions
      perf/x86/intel/ds: Factor out PEBS group processing code to functions
      perf/x86/intel: Process arch-PEBS records or record fragments
      perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
      perf/x86/intel: Update dyn_constraint base on PEBS event precise level
      perf/x86/intel: Setup PEBS data configuration and enable legacy groups
      perf/x86/intel: Add counter group support for arch-PEBS

George Kennedy (1):
      perf/x86/amd: Check event before enable to avoid GPF

Ingo Molnar (1):
      perf/x86/intel: Fix and clean up intel_pmu_drain_arch_pebs() type use

Josh Poimboeuf (1):
      unwind_user/x86: Enable frame pointer unwinding on x86

Kan Liang (1):
      perf/x86/intel: Add a check for dynamic constraints

Peter Zijlstra (19):
      x86/insn,uprobes,alternative: Unify insn_is_nop()
      x86/insn: Simplify for_each_insn_prefix()
      task_work: Fix NMI race condition
      unwind: Shorten lines
      unwind: Add required include files
      unwind: Simplify unwind_reset_info()
      unwind: Add comment to unwind_deferred_task_exit()
      unwind: Fix unwind_deferred_request() vs NMI
      unwind: Clarify calling context
      unwind: Simplify unwind_user_faultable()
      unwind: Make unwind_task_info::unwind_mask consistent
      unwind: Simplify unwind_user_next_fp() alignment check
      unwind: Implement compat fp unwind
      unwind_user/x86: Teach FP unwind about start of function
      perf: Support deferred user unwind
      unwind_user/x86: Fix arch=um build
      entry,unwind/deferred: Fix unwind_reset_info() placement
      perf/x86/intel: Check PEBS dyn_constraints
      perf/x86/intel: Optimize PEBS extended config

Zhang Rui (2):
      perf/x86/intel/cstate: Remove PC3 support from LunarLake
      perf/x86/intel/cstate: Add Pantherlake support

Zide Chen (1):
      perf/x86/intel/cstate: Add Clearwater Forest support


 arch/x86/Kconfig                         |   1 +
 arch/x86/boot/compressed/sev-handle-vc.c |   3 +-
 arch/x86/events/amd/core.c               |   7 +-
 arch/x86/events/core.c                   |  66 +---
 arch/x86/events/intel/core.c             | 444 +++++++++++++++++++++--
 arch/x86/events/intel/cstate.c           |  18 +-
 arch/x86/events/intel/ds.c               | 601 +++++++++++++++++++++++++------
 arch/x86/events/perf_event.h             |  41 ++-
 arch/x86/include/asm/insn-eval.h         |   2 +
 arch/x86/include/asm/insn.h              |   5 +-
 arch/x86/include/asm/intel_ds.h          |  10 +-
 arch/x86/include/asm/msr-index.h         |  20 +
 arch/x86/include/asm/perf_event.h        | 116 +++++-
 arch/x86/include/asm/unwind_user.h       |  41 +++
 arch/x86/include/asm/uprobes.h           |   9 +
 arch/x86/kernel/alternative.c            |  20 +-
 arch/x86/kernel/kprobes/core.c           |   3 +-
 arch/x86/kernel/uprobes.c                |  70 ++--
 arch/x86/lib/insn-eval.c                 | 151 +++++++-
 include/linux/irq-entry-common.h         |   2 +-
 include/linux/perf_event.h               |   2 +-
 include/linux/unwind_deferred.h          |  52 ++-
 include/linux/unwind_deferred_types.h    |  18 +-
 include/linux/unwind_user_types.h        |   2 +
 include/uapi/linux/perf_event.h          |  21 +-
 kernel/bpf/stackmap.c                    |   4 +-
 kernel/events/callchain.c                |  14 +-
 kernel/events/core.c                     |  78 +++-
 kernel/exit.c                            |   7 +-
 kernel/task_work.c                       |   8 +-
 kernel/unwind/deferred.c                 |  44 ++-
 kernel/unwind/user.c                     |  59 ++-
 tools/arch/x86/include/asm/insn.h        |   5 +-
 tools/include/uapi/linux/perf_event.h    |  21 +-
 34 files changed, 1627 insertions(+), 338 deletions(-)
 create mode 100644 arch/x86/include/asm/unwind_user.h

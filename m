Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BDD1C1F14;
	Mon, 18 Nov 2024 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951003; cv=none; b=nzXMq3xi525lXwR4/meRgl1eS/+wF7rH2HpxYNaU1Gduiozf3eeJa08vlbQZIhHwpCSIXTCE84k9CQYSHD7K0INUNCmyWSMQQv9rOyTiHcymbRLNJ6WJ2++getcRac6QobggMfCDguk/FFRw/TLGMLbAlSPCwV8Ai0k+s38gDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951003; c=relaxed/simple;
	bh=AAOwy+5Dxmw1BsBJE62bzHW+0ABCsWiqj+yUUpz71cs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V0un6KEeSk6pf+PPYQ0DLCsjz5m3zH8uWJFklXhVG+IJ2fULFWWsd8bx4+FWcowXBXBZDVxIEx1JIFw5rIrFNY8XtfGBz9WgyK/JmreBvZ/R2NxR3hk0WgGU55MBOamvNYxiEuA1W02pof788ktk5sXe4+Mv612qeEWh9N+FHDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnV0rmH0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnV0rmH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2DAC4CECC;
	Mon, 18 Nov 2024 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731951002;
	bh=AAOwy+5Dxmw1BsBJE62bzHW+0ABCsWiqj+yUUpz71cs=;
	h=Date:From:To:Cc:Subject:From;
	b=nnV0rmH0kWgH9s7PawZS1vOlsLqs9gcgtYKSh1V06ZapPSX69z5YJDIH9hRbK9cp6
	 RY8D1mktBYfXWC2Qf7zPHdw2WXp1ICFFWGHp16aMba1RPlyxnsWSb80T9ruS+bQ0Br
	 EaWAs9ooDGCAerPVU5Lt3fuT8C+n5MonfVgG+WpSv9F+GGhtuKr0utfUOPP1XcprDj
	 R570nFvO+hQtgXKfGzfXH/FOyTf+/wEbhbM00mV1wMKnjNXIEA/aMEKv1LcmuJm/AO
	 i2P8Mkt53YVekKzpFHv8gsLRs7b7tm+hm0HPAq63nb3fmPVD+gg15BVx0waIGv7x9y
	 fxl3sO7MDpSQg==
Date: Mon, 18 Nov 2024 18:29:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events changes for v6.13
Message-ID: <Zzt5lYZGF8IOrgpB@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-11-18

   # HEAD: 2c47e7a74f445426d156278e339b7abb259e50de perf/core: Correct perf sampling with guest VMs

Performance events changes for v6.13:

 - Uprobes:
    - Add BPF session support (Jiri Olsa)
    - Switch to RCU Tasks Trace flavor for better performance (Andrii Nakryiko)
    - Massively increase uretprobe SMP scalability by SRCU-protecting
      the uretprobe lifetime (Andrii Nakryiko)
    - Kill xol_area->slot_count (Oleg Nesterov)

 - Core facilities:
    - Implement targeted high-frequency profiling by adding the ability
      for an event to "pause" or "resume" AUX area tracing (Adrian Hunter)

 - VM profiling/sampling:
    - Correct perf sampling with guest VMs (Colton Lewis)

 - New hardware support:
    - x86/intel: Add PMU support for Intel ArrowLake-H CPUs (Dapeng Mi)

 - Misc fixes and enhancements:
    - x86/intel/pt: Fix buffer full but size is 0 case (Adrian Hunter)
    - x86/amd: Warn only on new bits set (Breno Leitao)
    - x86/amd/uncore: Avoid a false positive warning about snprintf
                      truncation in amd_uncore_umc_ctx_init (Jean Delvare)
    - uprobes: Re-order struct uprobe_task to save some space (Christophe JAILLET)
    - x86/rapl: Move the pmu allocation out of CPU hotplug (Kan Liang)
    - x86/rapl: Clean up cpumask and hotplug (Kan Liang)
    - uprobes: Deuglify xol_get_insn_slot/xol_free_insn_slot paths (Oleg Nesterov)

 Thanks,

	Ingo

------------------>
Adrian Hunter (4):
      perf/x86/intel/pt: Fix buffer full but size is 0 case
      perf/core: Add aux_pause, aux_resume, aux_start_paused
      perf/x86/intel/pt: Add support for pause / resume
      perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling

Andrii Nakryiko (3):
      uprobes: switch to RCU Tasks Trace flavor for better performance
      uprobes: allow put_uprobe() from non-sleepable softirq context
      uprobes: SRCU-protect uretprobe lifetime (with timeout)

Breno Leitao (1):
      perf/x86/amd: Warn only on new bits set

Christophe JAILLET (1):
      uprobes: Re-order struct uprobe_task to save some space

Colton Lewis (5):
      perf/arm: Drop unused functions
      perf/core: Hoist perf_instruction_pointer() and perf_misc_flags()
      perf/powerpc: Use perf_arch_instruction_pointer()
      perf/x86: Refactor misc flag assignments
      perf/core: Correct perf sampling with guest VMs

Dapeng Mi (4):
      perf/x86: Refine hybrid_pmu_type defination
      x86/cpu/intel: Define helper to get CPU core native ID
      perf/x86/intel: Support hybrid PMU with multiple atom uarchs
      perf/x86/intel: Add PMU support for ArrowLake-H

Jean Delvare (1):
      perf/x86/amd/uncore: Avoid a false positive warning about snprintf truncation in amd_uncore_umc_ctx_init

Jiri Olsa (2):
      uprobe: Add data pointer to consumer handlers
      uprobe: Add support for session consumer

Kan Liang (2):
      perf/x86/rapl: Move the pmu allocation out of CPU hotplug
      perf/x86/rapl: Clean up cpumask and hotplug

Oleg Nesterov (9):
      uprobes: don't abuse get_utask() in pre_ssout() and prepare_uretprobe()
      uprobes: sanitiize xol_free_insn_slot()
      uprobes: kill the unnecessary put_uprobe/xol_free_insn_slot in uprobe_free_utask()
      uprobes: simplify xol_take_insn_slot() and its caller
      uprobes: move the initialization of utask->xol_vaddr from pre_ssout() to xol_get_insn_slot()
      uprobes: pass utask to xol_get_insn_slot() and xol_free_insn_slot()
      uprobes: deny mremap(xol_vma)
      uprobes: kill xol_area->slot_count
      uprobes: fold xol_take_insn_slot() into xol_get_insn_slot()


 arch/Kconfig                                       |   1 +
 arch/arm/include/asm/perf_event.h                  |   7 -
 arch/arm/kernel/perf_callchain.c                   |  17 -
 arch/arm64/include/asm/perf_event.h                |   4 -
 arch/arm64/kernel/perf_callchain.c                 |  28 -
 arch/powerpc/include/asm/perf_event_server.h       |   6 +-
 arch/powerpc/perf/callchain.c                      |   2 +-
 arch/powerpc/perf/callchain_32.c                   |   2 +-
 arch/powerpc/perf/callchain_64.c                   |   2 +-
 arch/powerpc/perf/core-book3s.c                    |   4 +-
 arch/s390/include/asm/perf_event.h                 |   6 +-
 arch/s390/kernel/perf_event.c                      |   4 +-
 arch/x86/events/amd/core.c                         |  10 +-
 arch/x86/events/amd/uncore.c                       |   5 +-
 arch/x86/events/core.c                             |  64 ++-
 arch/x86/events/intel/core.c                       | 137 ++++-
 arch/x86/events/intel/ds.c                         |  21 +
 arch/x86/events/intel/pt.c                         |  84 ++-
 arch/x86/events/intel/pt.h                         |   6 +
 arch/x86/events/perf_event.h                       |  34 +-
 arch/x86/events/rapl.c                             | 130 ++---
 arch/x86/include/asm/cpu.h                         |   6 +
 arch/x86/include/asm/perf_event.h                  |  12 +-
 arch/x86/kernel/cpu/intel.c                        |  15 +
 include/linux/cpuhotplug.h                         |   1 -
 include/linux/perf_event.h                         |  54 +-
 include/linux/uprobes.h                            |  83 ++-
 include/uapi/linux/perf_event.h                    |  11 +-
 kernel/events/core.c                               | 102 +++-
 kernel/events/internal.h                           |   1 +
 kernel/events/uprobes.c                            | 608 +++++++++++++++------
 kernel/trace/bpf_trace.c                           |   6 +-
 kernel/trace/trace_uprobe.c                        |  12 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   2 +-
 34 files changed, 1069 insertions(+), 418 deletions(-)

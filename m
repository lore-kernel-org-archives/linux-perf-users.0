Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ECA1EFF83;
	Sat, 22 Mar 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742636475; cv=none; b=hEj0Jh7haRMvt8vD3iX95ooB0RjgFcl4Z2czoxVD/MAb6Tzy/nk1p0fr+5MpBXoCbmrBd4tht9/gmktmIkRVgUH6vKMghzBpL3V0TEV3TRDf/UhCpK02G0HSU4KhRkGNstVz3CcHLALk79BPZGLHHABtgzg/QslHE31pX6MQRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742636475; c=relaxed/simple;
	bh=iXMIPygKJ25u2KdQtxqoiIo/7MwxxyAmIz4/PNK1aFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hC/rpGO5Wt1+z/tMpB7lyCmwWHYWA2HQh47dJWanLfS54/TSxmGshl/sIk4AHCwONx8m16uk/RnAqZr2iqNVQUv546/pMskW5+TxQPNv3e88n4GGBy0NukPdpBnBHAQ1P8CShdYlbLOiwINoQxiFdt52kTMpvGgZQ0WrAhI4wfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqJuaZl2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqJuaZl2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C0FC4CEDD;
	Sat, 22 Mar 2025 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742636475;
	bh=iXMIPygKJ25u2KdQtxqoiIo/7MwxxyAmIz4/PNK1aFs=;
	h=Date:From:To:Cc:Subject:From;
	b=eqJuaZl2bGlaJWlIvvsvIS8OBgMj+8m4enhwnYjS1/ItV8hjNoF5dIKLdegFfgXfE
	 ZKhDQVlN6vCyx50TMgPkIkoexpoi/eG4Ya00URrBOeCF786whaHX1A0DqSlbYCm6xy
	 uVJVI1oYHLe4mZmTAMDwtXGZ10RbalgHQU7CY2kjwC6Bgr2Ohc2iUyHGcy0+JJk/oA
	 axs0hxp48ij3tbEuNOXmPWFWPm05iAzxCkH6ByVcEtGNCd0diHTnpKel0erG5Ivfot
	 e7kk8zMVQNBsdsdQsH0tVs1sJJN1RF1IvXqpps4VYsmGiSb2m3YhVM0Yh3bun+cw5o
	 BJNPL5hrbFI6Q==
Date: Sat, 22 Mar 2025 10:41:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events updates for v6.15
Message-ID: <Z96FtpuyGXHbvKKS@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-03-22

   # HEAD: 12e766d16814808b6a581597cef6ce9fc029e917 perf: Fix __percpu annotation

Performance events updates for v6.15:

Core:

  - Move perf_event sysctls into kernel/events/ (Joel Granados)
  - Use POLLHUP for pinned events in error (Namhyung Kim)
  - Avoid the read if the count is already updated (Peter Zijlstra)
  - Allow the EPOLLRDNORM flag for poll (Tao Chen)

  - locking/percpu-rwsem: Add guard support (Peter Zijlstra)
    [ NOTE: this got (mis-)merged into the perf tree due to related work. ]

perf_pmu_unregister() related improvements: (Peter Zijlstra)

  - Simplify the perf_event_alloc() error path
  - Simplify the perf_pmu_register() error path
  - Simplify perf_pmu_register()
  - Simplify perf_init_event()
  - Simplify perf_event_alloc()
  - Merge struct pmu::pmu_disable_count into struct perf_cpu_pmu_context::pmu_disable_count
  - Add this_cpc() helper
  - Introduce perf_free_addr_filters()
  - Robustify perf_event_free_bpf_prog()
  - Simplify the perf_mmap() control flow
  - Further simplify perf_mmap()
  - Remove retry loop from perf_mmap()
  - Lift event->mmap_mutex in perf_mmap()
  - Detach 'struct perf_cpu_pmu_context' and 'struct pmu' lifetimes
  - Fix perf_mmap() failure path

Uprobes:

  - Harden x86 uretprobe syscall trampoline check (Jiri Olsa)
  - Remove redundant spinlock in uprobe_deny_signal() (Liao Chang)
  - Remove the spinlock within handle_singlestep() (Liao Chang)

x86 Intel PMU enhancements:

  - Support PEBS counters snapshotting (Kan Liang)
  - Fix intel_pmu_read_event() (Kan Liang)
  - Extend per event callchain limit to branch stack (Kan Liang)
  - Fix system-wide LBR profiling (Kan Liang)
  - Allocate bts_ctx only if necessary (Li RongQing)
  - Apply static call for drain_pebs (Peter Zijlstra)

x86 AMD PMU enhancements: (Ravi Bangoria)

  - Remove pointless sample period check
  - Fix ->config to sample period calculation for OP PMU
  - Fix perf_ibs_op.cnt_mask for CurCnt
  - Don't allow freq mode event creation through ->config interface
  - Add PMU specific minimum period
  - Add ->check_period() callback
  - Ceil sample_period to min_period
  - Add support for OP Load Latency Filtering
  - Update DTLB/PageSize decode logic

Hardware breakpoints:

  - Return EOPNOTSUPP for unsupported breakpoint type (Saket Kumar Bhaskar)

Hardlockup detector improvements: (Li Huafei)

  - perf_event memory leak
  - Warn if watchdog_ev is leaked

Fixes and cleanups:

  - Misc fixes and cleanups (Andy Shevchenko, Kan Liang, Peter Zijlstra,
    Ravi Bangoria, Thorsten Blum, XieLudan)

 Thanks,

	Ingo

------------------>
Andy Shevchenko (1):
      x86/events/amd/iommu: Increase IOMMU_NAME_SIZE

Jiri Olsa (1):
      uprobes/x86: Harden uretprobe syscall trampoline check

Joel Granados (1):
      perf/core: Move perf_event sysctls into kernel/events

Kan Liang (9):
      perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read
      perf/x86/intel: Support PEBS counters snapshotting
      perf: Extend per event callchain limit to branch stack
      perf: Save PMU specific data in task_struct
      perf: attach/detach PMU specific data
      perf: Supply task information to sched_task()
      perf/x86/lbr: Fix shorter LBRs call stacks for the system-wide mode
      perf/x86: Remove swap_task_ctx()
      perf: Clean up pmu specific data

Li Huafei (2):
      watchdog/hardlockup/perf: Fix perf_event memory leak
      watchdog/hardlockup/perf: Warn if watchdog_ev is leaked

Li RongQing (2):
      perf/x86/intel/bts: Allocate bts_ctx only if necessary
      perf/x86/intel/bts: Check if bts_ctx is allocated when calling BTS functions

Liao Chang (2):
      uprobes: Remove redundant spinlock in uprobe_deny_signal()
      uprobes: Remove the spinlock within handle_singlestep()

Namhyung Kim (1):
      perf/core: Use POLLHUP for pinned events in error

Peter Zijlstra (17):
      perf/core: Simplify the perf_event_alloc() error path
      perf/core: Simplify the perf_pmu_register() error path
      perf/core: Simplify perf_pmu_register()
      perf/core: Simplify perf_init_event()
      perf/core: Simplify perf_event_alloc()
      perf/core: Merge struct pmu::pmu_disable_count into struct perf_cpu_pmu_context::pmu_disable_count
      perf/core: Add this_cpc() helper
      perf/core: Introduce perf_free_addr_filters()
      perf/bpf: Robustify perf_event_free_bpf_prog()
      perf/core: Simplify the perf_mmap() control flow
      perf/core: Further simplify perf_mmap()
      perf/core: Remove retry loop from perf_mmap()
      perf/core: Lift event->mmap_mutex in perf_mmap()
      perf/core: Detach 'struct perf_cpu_pmu_context' and 'struct pmu' lifetimes
      perf/core: Fix perf_mmap() failure path
      perf/core: Clean up perf_try_init_event()
      perf: Fix __percpu annotation

Peter Zijlstra (Intel) (3):
      perf/x86/intel: Apply static call for drain_pebs
      perf: Avoid the read if the count is already updated
      locking/percpu-rwsem: Add guard support

Ravi Bangoria (11):
      perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
      perf/amd/ibs: Remove pointless sample period check
      perf/amd/ibs: Fix ->config to sample period calculation for OP PMU
      perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
      perf/amd/ibs: Don't allow freq mode event creation through ->config interface
      perf/amd/ibs: Add PMU specific minimum period
      perf/amd/ibs: Add ->check_period() callback
      perf/amd/ibs: Ceil sample_period to min_period
      perf/amd/ibs: Add support for OP Load Latency Filtering
      perf/amd/ibs: Update DTLB/PageSize decode logic
      perf amd ibs: Sync arch/x86/include/asm/amd-ibs.h header with the kernel

Saket Kumar Bhaskar (1):
      perf/hw_breakpoint: Return EOPNOTSUPP for unsupported breakpoint type

Tao Chen (1):
      perf/ring_buffer: Allow the EPOLLRDNORM flag for poll

Thorsten Blum (2):
      perf/x86: Annotate struct bts_buffer::buf with __counted_by()
      perf/core: Remove optional 'size' arguments from strscpy() calls

XieLudan (1):
      perf/core: Use sysfs_emit() instead of scnprintf()


 arch/powerpc/perf/core-book3s.c      |    8 +-
 arch/s390/kernel/perf_pai_crypto.c   |    3 +-
 arch/s390/kernel/perf_pai_ext.c      |    3 +-
 arch/x86/events/amd/brs.c            |    3 +-
 arch/x86/events/amd/ibs.c            |  206 ++++++-
 arch/x86/events/amd/iommu.c          |    2 +-
 arch/x86/events/amd/lbr.c            |    3 +-
 arch/x86/events/core.c               |   27 +-
 arch/x86/events/intel/bts.c          |   43 +-
 arch/x86/events/intel/core.c         |  123 ++--
 arch/x86/events/intel/ds.c           |  204 ++++++-
 arch/x86/events/intel/lbr.c          |   73 ++-
 arch/x86/events/perf_event.h         |   42 +-
 arch/x86/events/perf_event_flags.h   |    2 +-
 arch/x86/include/asm/amd-ibs.h       |    3 +-
 arch/x86/include/asm/perf_event.h    |   20 +
 arch/x86/kernel/uprobes.c            |   14 +-
 include/linux/idr.h                  |   17 +
 include/linux/nmi.h                  |    4 -
 include/linux/percpu-rwsem.h         |    8 +
 include/linux/perf_event.h           |   92 +--
 include/linux/sched.h                |    2 +
 include/linux/uprobes.h              |    3 +
 include/uapi/linux/perf_event.h      |    2 +
 kernel/cpu.c                         |    5 -
 kernel/events/callchain.c            |   38 +-
 kernel/events/core.c                 | 1062 ++++++++++++++++++++++------------
 kernel/events/hw_breakpoint.c        |    5 +-
 kernel/events/ring_buffer.c          |    3 +-
 kernel/events/uprobes.c              |   12 +-
 kernel/sysctl.c                      |   64 --
 kernel/watchdog.c                    |   25 -
 kernel/watchdog_perf.c               |   29 +-
 tools/arch/x86/include/asm/amd-ibs.h |    3 +-
 34 files changed, 1416 insertions(+), 737 deletions(-)

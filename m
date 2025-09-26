Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B551F1505;
	Fri, 26 Sep 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897369; cv=none; b=Y2QecSG4cvbZcocMp3/C0FaxEjJ7suqMuYLA1jILNHey5GjE5d8kGauXYRndwmZqJMAk8MLI1vdwub/HHHB2miQSpy2xhP2PkazCf/Go6RIR0VVXMx7QvyP3j0bWUg/N7tjjqUbhXqbsbFgXcDG5aTFSiqzYeKRWd7rK4uMxyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897369; c=relaxed/simple;
	bh=cZ1XFmRawCazDXi8Ki6dJTBWPaqO33zYZFaUz0RtjW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EZAuRF8r/PyPoz0wlgruXzK44uBFhKWuMQuS7wAVq3R0jTOOfCqHML6csW44uvyK+IzWJJH4/Wm048udTemNaRHETMH/zpePUJT2Os3BDzsxyE9iKjdJs+wCXsDImShzEFa1+kejOZqUP/q1H6ij7rxaNS2UqS81e0FsELbqPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG/WVriW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG/WVriW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C51C113CF;
	Fri, 26 Sep 2025 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758897367;
	bh=cZ1XFmRawCazDXi8Ki6dJTBWPaqO33zYZFaUz0RtjW0=;
	h=Date:From:To:Cc:Subject:From;
	b=RG/WVriWYqdp8egYDAkLACaTSB3TFAcZ+HJGD7P8MXQPQh/kQ36KCD3JSob4ZTXCC
	 iVCV78d1ryUwe2zgHup6DcWXr4+zyDRsXfm0LZqGM+ffS8Kr14RdxNhh492s6Wvr2i
	 p6wrxw8MXR+MUdmFAwPn+BTlB3rzRUpKNEQ5Ldz5WHcBfaKBsXJrlU5dVSrR0TkJSu
	 dRRi4Nb2EzVMy3Fmk2cDZtoOfnX6QCRWipfsCT4jode9WWcROeIki+WryzAT8wnJwO
	 A6e5zO/bKZurINyA3r0gYT74OxduWsz64rIwGMtt15k2W12coLg+lufWhebcWboxqu
	 RwwQGDrXcJsVQ==
Date: Fri, 26 Sep 2025 16:36:02 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events updates for v6.18
Message-ID: <aNak0jUWA0JvVEMX@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-09-26

   # HEAD: 6d48436560e91be858158e227f21aab71698814e selftests/bpf: Fix uprobe_sigill test for uprobe syscall error value

Performance events updates for v6.18:

Core perf code updates:

 - Convert mmap() related reference counts to refcount_t. This
   is in reaction to the recently fixed refcount bugs, which
   could have been detected earlier and could have mitigated
   the bug somewhat. (Thomas Gleixner, Peter Zijlstra)

 - Clean up and simplify the callchain code, in preparation
   for sframes. (Steven Rostedt, Josh Poimboeuf)

Uprobes updates:

 - Add support to optimize usdt probes on x86-64, which
   gives a substantial speedup. (Jiri Olsa)

 - Cleanups and fixes on x86 (Peter Zijlstra)

PMU driver updates:

 - Various optimizations and fixes to the Intel PMU driver
   (Dapeng Mi)

Misc cleanups and fixes:

 - Remove redundant __GFP_NOWARN (Qianfeng Rong)

 Thanks,

	Ingo

------------------>
Dapeng Mi (6):
      perf/x86/intel: Use early_initcall() to hook bts_init()
      perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
      perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
      perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to BIT_ULL(48)
      perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into INTEL_FIXED_BITS_MASK
      perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap()

Jiri Olsa (24):
      uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
      uprobes: Rename arch_uretprobe_trampoline function
      uprobes: Make copy_from_page global
      uprobes: Add uprobe_write function
      uprobes: Add nbytes argument to uprobe_write
      uprobes: Add is_register argument to uprobe_write and uprobe_write_opcode
      uprobes: Add do_ref_ctr argument to uprobe_write function
      uprobes/x86: Add mapping for optimized uprobe trampolines
      uprobes/x86: Add uprobe syscall to speed up uprobe
      uprobes/x86: Add support to optimize uprobes
      selftests/bpf: Import usdt.h from libbpf/usdt project
      selftests/bpf: Reorg the uprobe_syscall test function
      selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
      selftests/bpf: Add uprobe/usdt syscall tests
      selftests/bpf: Add hit/attach/detach race optimized uprobe test
      selftests/bpf: Add uprobe syscall sigill signal test
      selftests/bpf: Add optimized usdt variant for basic usdt test
      selftests/bpf: Add uprobe_regs_equal test
      selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe
      selftests/bpf: Fix uprobe syscall shadow stack test
      seccomp: passthrough uprobe systemcall without filtering
      selftests/seccomp: validate uprobe syscall passes through seccomp
      uprobes/x86: Return error from uprobe syscall when not called from trampoline
      selftests/bpf: Fix uprobe_sigill test for uprobe syscall error value

Josh Poimboeuf (4):
      perf: Remove get_perf_callchain() init_nr argument
      perf: Have get_perf_callchain() return NULL if crosstask and user are set
      perf: Simplify get_perf_callchain() user logic
      perf: Skip user unwind if the task is a kernel thread

Peter Zijlstra (17):
      perf: Move perf_mmap_calc_limits() into both rb and aux branches
      perf: Merge consecutive conditionals in perf_mmap()
      perf: Move common code into both rb and aux branches
      perf: Remove redundant aux_unlock label
      perf: Use guard() for aux_mutex in perf_mmap()
      perf: Reflow to get rid of aux_success label
      perf: Split out the AUX buffer allocation
      perf: Make RB allocation branch self sufficient
      perf: Split out the RB allocation
      perf: Use scoped_guard() for mmap_mutex in perf_mmap()
      perf: Identify the 0->1 transition for event::mmap_count
      uprobes/x86: Add struct uretprobe_syscall_args
      uprobes/x86: Optimize is_optimize()
      uprobes/x86: Accept more NOP forms
      uprobes/x86: Fix uprobe syscall vs shadow stack
      uprobes/x86: Make asm style consistent
      uprobes/x86: Add SLS mitigation to the trampolines

Qianfeng Rong (1):
      uprobes: Remove redundant __GFP_NOWARN

Steven Rostedt (1):
      perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL

Thomas Gleixner (4):
      perf: Remove redundant condition for AUX buffer size
      perf: Split out mlock limit handling
      perf: Split out VM accounting
      perf: Convert mmap() refcounts to refcount_t


 arch/arm/probes/uprobes/core.c                     |   2 +-
 arch/x86/entry/syscalls/syscall_64.tbl             |   1 +
 arch/x86/events/core.c                             |  16 +-
 arch/x86/events/intel/bts.c                        |   2 +-
 arch/x86/events/intel/core.c                       |  21 +-
 arch/x86/include/asm/msr-index.h                   |  14 +-
 arch/x86/include/asm/perf_event.h                  |   8 +-
 arch/x86/include/asm/shstk.h                       |   4 +
 arch/x86/include/asm/uprobes.h                     |   7 +
 arch/x86/kernel/shstk.c                            |  40 ++
 arch/x86/kernel/uprobes.c                          | 635 ++++++++++++++++++++-
 arch/x86/kvm/pmu.h                                 |   2 +-
 include/linux/perf_event.h                         |   4 +-
 include/linux/syscalls.h                           |   2 +
 include/linux/uprobes.h                            |  20 +-
 kernel/bpf/stackmap.c                              |   4 +-
 kernel/events/callchain.c                          |  40 +-
 kernel/events/core.c                               | 369 ++++++------
 kernel/events/internal.h                           |   4 +-
 kernel/events/ring_buffer.c                        |   2 +-
 kernel/events/uprobes.c                            | 102 +++-
 kernel/fork.c                                      |   1 +
 kernel/seccomp.c                                   |  32 +-
 kernel/sys_ni.c                                    |   1 +
 tools/arch/x86/include/asm/msr-index.h             |  14 +-
 .../selftests/bpf/prog_tests/uprobe_syscall.c      | 484 ++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/usdt.c      |  38 +-
 tools/testing/selftests/bpf/progs/uprobe_syscall.c |   4 +-
 .../selftests/bpf/progs/uprobe_syscall_executed.c  |  60 +-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  11 +-
 tools/testing/selftests/bpf/usdt.h                 | 545 ++++++++++++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c      | 107 +++-
 32 files changed, 2221 insertions(+), 375 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/usdt.h

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9E193409;
	Mon, 20 Jan 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737369212; cv=none; b=L1H3Ymdy6fKzZEDi5jyQHBXVahwP+KpLImOkdwAYHYP92DC9/hYrP9T2uhjB088uA1Gal5677L3F7S6ZuxuTUCwf35DCRpxOYX0eod24iJL/nkU+Hp/RgfXSOSwVtEf8QvEbtug3H+Q8aGu/1Kg0HTl9ZaFPBLLBL6NuMv9FLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737369212; c=relaxed/simple;
	bh=hgwrBvP+RQvVHRK5Kd9pyPfl13HpwNjxJB9BQ6ZMlXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I9z68IGiRhsSG2yqhPNmtOtav+lrUVRn8svu76M+pH+NekXXFtV38SEXD3WGwUw+pnmA5TK6q2oJqzgo5W2FTcHvg/12f+fo0p/fnOvxEE99LItnCYY6wuTZo5g4e2LNrpi9Me9SCq2ewuieX47JCPkWCZRh/GADvh5pkHMXsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqRCjgov; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqRCjgov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDE4C4CEDD;
	Mon, 20 Jan 2025 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737369212;
	bh=hgwrBvP+RQvVHRK5Kd9pyPfl13HpwNjxJB9BQ6ZMlXk=;
	h=Date:From:To:Cc:Subject:From;
	b=LqRCjgovix/PiXWK0Q6cYbqFkkyl80WDn2LJJzp77oaTfGT1NAAzK3GGpuETy+UE0
	 0p9BWAp5tsT9vUZqfg3I6Uk11+VVmtVRXXTGd0r+Vpp4HeRT54xT6Q+O+Q9DpR9wp3
	 mFiJRgz5FpN3GkAkLcOw208v3d6v0VqAEcygjTpOp0puVLN6Fn9HfFAENOP8rpe1V5
	 hG0OwxnPqyj6C/nCMVY9PbptbGBKg/z3zpXG7QkjnZWCciCEH9DOCftW+wFo5Pw7M9
	 4MRsPLtClQKyKtsrSx+t3/SfevU/T8JzcTrv44ON/ZkLGiSWrgwRlNYXPTaUmTLrEd
	 Mp671n9/5SJeg==
Date: Mon, 20 Jan 2025 11:33:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events changes for v6.14
Message-ID: <Z44md4du6C1un3FB@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2025-01-20

   # HEAD: b709eb872e19a19607bbb6d2975bc264d59735cf perf: map pages in advance

Performance events changes for v6.14:

 - Seqlock optimizations that arose in a perf context and were
   merged into the perf tree:

   - seqlock: Add raw_seqcount_try_begin (Suren Baghdasaryan)
   - mm: Convert mm_lock_seq to a proper seqcount ((Suren Baghdasaryan)
   - mm: Introduce mmap_lock_speculate_{try_begin|retry} (Suren Baghdasaryan)
   - mm/gup: Use raw_seqcount_try_begin() (Peter Zijlstra)

 - Core perf enhancements:

   - Reduce 'struct page' footprint of perf by mapping pages
     in advance (Lorenzo Stoakes)
   - Save raw sample data conditionally based on sample type (Yabin Cui)
   - Reduce sampling overhead by checking sample_type in
     perf_sample_save_callchain() and perf_sample_save_brstack() (Yabin Cui)
   - Export perf_exclude_event() (Namhyung Kim)

 - Uprobes scalability enhancements: (Andrii Nakryiko)

   - Simplify find_active_uprobe_rcu() VMA checks
   - Add speculative lockless VMA-to-inode-to-uprobe resolution
   - Simplify session consumer tracking
   - Decouple return_instance list traversal and freeing
   - Ensure return_instance is detached from the list before freeing
   - Reuse return_instances between multiple uretprobes within task
   - Guard against kmemdup() failing in dup_return_instance()

 - AMD core PMU driver enhancements:

   - Relax privilege filter restriction on AMD IBS (Namhyung Kim)

 - AMD RAPL energy counters support: (Dhananjay Ugwekar)

   - Introduce topology_logical_core_id() (K Prateek Nayak)

   - Remove the unused get_rapl_pmu_cpumask() function
   - Remove the cpu_to_rapl_pmu() function
   - Rename rapl_pmu variables
   - Make rapl_model struct global
   - Add arguments to the init and cleanup functions
   - Modify the generic variable names to *_pkg*
   - Remove the global variable rapl_msrs
   - Move the cntr_mask to rapl_pmus struct
   - Add core energy counter support for AMD CPUs

 - Intel core PMU driver enhancements:

   - Support RDPMC 'metrics clear mode' feature (Kan Liang)
   - Clarify adaptive PEBS processing (Kan Liang)
   - Factor out functions for PEBS records processing (Kan Liang)
   - Simplify the PEBS records processing for adaptive PEBS (Kan Liang)

 - Intel uncore driver enhancements: (Kan Liang)

   - Convert buggy pmu->func_id use to pmu->registered
   - Support more units on Granite Rapids

 Thanks,

	Ingo

------------------>
Andrii Nakryiko (7):
      uprobes: simplify find_active_uprobe_rcu() VMA checks
      uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
      uprobes: Simplify session consumer tracking
      uprobes: Decouple return_instance list traversal and freeing
      uprobes: Ensure return_instance is detached from the list before freeing
      uprobes: Reuse return_instances between multiple uretprobes within task
      uprobes: Guard against kmemdup() failing in dup_return_instance()

Dhananjay Ugwekar (9):
      perf/x86/rapl: Remove the unused get_rapl_pmu_cpumask() function
      perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
      perf/x86/rapl: Rename rapl_pmu variables
      perf/x86/rapl: Make rapl_model struct global
      perf/x86/rapl: Add arguments to the init and cleanup functions
      perf/x86/rapl: Modify the generic variable names to *_pkg*
      perf/x86/rapl: Remove the global variable rapl_msrs
      perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
      perf/x86/rapl: Add core energy counter support for AMD CPUs

K Prateek Nayak (1):
      x86/topology: Introduce topology_logical_core_id()

Kan Liang (6):
      perf/x86/intel/ds: Clarify adaptive PEBS processing
      perf/x86/intel/ds: Factor out functions for PEBS records processing
      perf/x86/intel/ds: Simplify the PEBS records processing for adaptive PEBS
      perf/x86/intel: Support RDPMC metrics clear mode
      perf/x86/intel/uncore: Clean up func_id
      perf/x86/intel/uncore: Support more units on Granite Rapids

Lorenzo Stoakes (1):
      perf: map pages in advance

Namhyung Kim (2):
      perf/core: Export perf_exclude_event()
      perf/x86: Relax privilege filter restriction on AMD IBS

Peter Zijlstra (1):
      mm/gup: Use raw_seqcount_try_begin()

Suren Baghdasaryan (3):
      seqlock: add raw_seqcount_try_begin
      mm: convert mm_lock_seq to a proper seqcount
      mm: introduce mmap_lock_speculate_{try_begin|retry}

Yabin Cui (3):
      perf/core: Save raw sample data conditionally based on sample type
      perf/core: Check sample_type in perf_sample_save_callchain
      perf/core: Check sample_type in perf_sample_save_brstack


 Documentation/arch/x86/topology.rst   |   4 +
 arch/s390/kernel/perf_cpum_cf.c       |   2 +-
 arch/s390/kernel/perf_cpum_sf.c       |   6 +-
 arch/s390/kernel/perf_pai_crypto.c    |   2 +-
 arch/s390/kernel/perf_pai_ext.c       |   2 +-
 arch/x86/events/amd/core.c            |   3 +-
 arch/x86/events/amd/ibs.c             |  64 ++++--
 arch/x86/events/core.c                |   3 +-
 arch/x86/events/intel/core.c          |  20 +-
 arch/x86/events/intel/ds.c            | 198 +++++++++-------
 arch/x86/events/intel/uncore.c        |  20 +-
 arch/x86/events/intel/uncore.h        |   1 -
 arch/x86/events/intel/uncore_snb.c    |   2 +-
 arch/x86/events/intel/uncore_snbep.c  |  48 ++--
 arch/x86/events/perf_event.h          |   1 +
 arch/x86/events/rapl.c                | 415 ++++++++++++++++++++++------------
 arch/x86/include/asm/perf_event.h     |  20 +-
 arch/x86/include/asm/processor.h      |   1 +
 arch/x86/include/asm/topology.h       |   1 +
 arch/x86/kernel/cpu/debugfs.c         |   1 +
 arch/x86/kernel/cpu/topology_common.c |   1 +
 include/linux/mm.h                    |  12 +-
 include/linux/mm_types.h              |   7 +-
 include/linux/mmap_lock.h             |  84 +++++--
 include/linux/perf_event.h            |  32 ++-
 include/linux/seqlock.h               |  22 ++
 include/linux/uprobes.h               |  16 +-
 kernel/events/core.c                  | 156 ++++++++-----
 kernel/events/ring_buffer.c           |  19 +-
 kernel/events/uprobes.c               | 225 +++++++++++++-----
 kernel/fork.c                         |   5 +-
 kernel/trace/bpf_trace.c              |  11 +-
 mm/gup.c                              |   3 +-
 mm/init-mm.c                          |   2 +-
 tools/testing/vma/vma.c               |   4 +-
 tools/testing/vma/vma_internal.h      |   4 +-
 36 files changed, 938 insertions(+), 479 deletions(-)

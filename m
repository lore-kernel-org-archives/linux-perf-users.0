Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0837239E7E;
	Mon,  9 Feb 2026 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770620415; cv=none; b=d+s8LBa6/3q0hnjNdvPHGDfSUev80lF4egKif3xIFC2GjuCFpcOI6BJyYiHqRnsr18sbgYh11kSw1CGq6aGSZYfQ9ERV89AMp5P088aQ8bKKMt9ld7i4Ej0jJqNNtonRemOGm4YmDXrAK9wE/x5OpvqkNx6sOzHtMQSZnsOguIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770620415; c=relaxed/simple;
	bh=tud5DGY0P05k5aajHiH4BXHJpQhMzliLpxPD+tZVvmg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JRyr1TNewdRgtXJxstDZtQHEivW0Dl6wbmOHRmRDmh0GyR4G8tytGmLkkIShUwmfGSv2geo1dXUU72K7XJ4+qB6siNik4IuaQhWVCBnUbOB38z2zSSeLZhHq+bHDDOROWFfCi1j8dZLmecy1C9UMj6LNHE0plOLY7YnN460xHuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7GyyAEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7GyyAEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180B7C116C6;
	Mon,  9 Feb 2026 07:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770620414;
	bh=tud5DGY0P05k5aajHiH4BXHJpQhMzliLpxPD+tZVvmg=;
	h=Date:From:To:Cc:Subject:From;
	b=W7GyyAEftz+WN3BYd/2PDhO04vEgVRrp9FdUycrBdD86/4RdhWt3ONpqUpIrn1LOC
	 YR960Yr83aZvs9RF03Hg6kQ1MGpUlrGnUhGGNMC/nOzScf4wDHC+DzoWFw51vT2iHO
	 URazgU40DwpIkwsS5JFle7Vptp2g4i7adjGWz68E1TAigfzivYoR0urcw2ulGHLdPg
	 mwIfVgo7+AvVxor2/yBkK2IILOD0Wz3oUHMbwJMf5tjWv6Y8LWfs/Du4GjPuL5m9Jq
	 4sLZ4K5mZ5cg8rLiMeAe+Y8bTrOEK4NiujBeQP9ADyLKnIZP640xrWdomPyJAT/QEQ
	 lvB2hFcJqvIGw==
Date: Mon, 9 Feb 2026 08:00:09 +0100
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
Subject: [GIT PULL] Performance events changes for v7.0
Message-ID: <aYmF-cST9h4MhX3I@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull the latest perf/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2026-02-09

for you to fetch changes up to 7db06e329af30dcb170a6782c1714217ad65033d:

Performance events changes for v7.0:

x86 PMU driver updates:

 - Add support for the core PMU for Intel Diamond Rapids (DMR) CPUs.
   Compared to previous iterations of the Intel PMU code, there's
   been a lot of changes, which center around three main areas:

    - Introduce the OFF-MODULE RESPONSE (OMR) facility to
      replace the Off-Core Response (OCR) facility

    - New PEBS data source encoding layout

    - Support the new "RDPMC user disable" feature

   (Dapeng Mi)

 - Likewise, a large series adds uncore PMU support for
   Intel Diamond Rapids (DMR) CPUs, which center around these
   four main areas:

    - DMR may have two Integrated I/O and Memory Hub (IMH) dies,
      separate from the compute tile (CBB) dies.  Each CBB and
      each IMH die has its own discovery domain.

    - Unlike prior CPUs that retrieve the global discovery table
      portal exclusively via PCI or MSR, DMR uses PCI for IMH PMON
      discovery and MSR for CBB PMON discovery.

    - DMR introduces several new PMON types: SCA, HAMVF, D2D_ULA,
      UBR, PCIE4, CRS, CPC, ITC, OTC, CMS, and PCIE6.

    - IIO free-running counters in DMR are MMIO-based, unlike SPR.

   (Zide Chen)

 - Also add support for Add missing PMON units for Intel Panther Lake,
   and support Nova Lake (NVL), which largely maps to Panther Lake.
   (Zide Chen)

 - KVM integration: Add support for mediated vPMUs (by Kan Liang
   and Sean Christopherson, with fixes and cleanups by Peter Zijlstra,
   Sandipan Das and Mingwei Zhang)

 - Add Intel cstate driver to support for Wildcat Lake (WCL)
   CPUs, which are a low-power variant of Panther Lake.
   (Zide Chen)

 - Add core, cstate and MSR PMU support for the Airmont NP Intel CPU
   (aka MaxLinear Lightning Mountain), which maps to the existing
   Airmont code. (Martin Schiller)

Performance enhancements:

 - core: Speed up kexec shutdown by avoiding unnecessary
   cross CPU calls. (Jan H. Schönherr)

 - core: Fix slow perf_event_task_exit() with LBR callstacks
   (Namhyung Kim)

User-space stack unwinding support:

 - Various cleanups and refactorings in preparation to generalize
   the unwinding code for other architectures. (Jens Remus)

Uprobes updates:

 - Transition from kmap_atomic to kmap_local_page (Keke Ming)

 - Fix incorrect lockdep condition in filter_chain() (Breno Leitao)

 - Fix XOL allocation failure for 32-bit tasks (Oleg Nesterov)

Misc fixes and cleanups:

 - s390: Remove kvm_types.h from Kbuild (Randy Dunlap)

 - x86/intel/uncore: Convert comma to semicolon (Chen Ni)

 - x86/uncore: Clean up const mismatch (Greg Kroah-Hartman)

 - x86/ibs: Fix typo in dc_l2tlb_miss comment (Xiang-Bin Shi)

 Thanks,

	Ingo

------------------>
Breno Leitao (1):
      uprobes: Fix incorrect lockdep condition in filter_chain()

Chen Ni (1):
      perf/x86/intel/uncore: Convert comma to semicolon

Dapeng Mi (7):
      perf/x86/intel: Support the 4 new OMR MSRs introduced in DMR and NVL
      perf/x86/intel: Add support for PEBS memory auxiliary info field in DMR
      perf/x86/intel: Add core PMU support for DMR
      perf/x86/intel: Add support for PEBS memory auxiliary info field in NVL
      perf/x86/intel: Add core PMU support for Novalake
      perf/x86: Use macros to replace magic numbers in attr_rdpmc
      perf/x86/intel: Add support for rdpmc user disable feature

Greg Kroah-Hartman (1):
      perf/x86/uncore: clean up const mismatch

Jan H. Schönherr (1):
      perf/core: Speed up kexec shutdown by avoiding unnecessary cross CPU calls

Jens Remus (4):
      unwind_user: Enhance comments on get CFA, FP, and RA
      unwind_user/fp: Use dummies instead of ifdef
      x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER
      x86/unwind_user: Simplify unwind_user_word_size()

Kan Liang (7):
      perf: Skip pmu_ctx based on event_type
      perf: Add generic exclude_guest support
      perf: Add APIs to create/release mediated guest vPMUs
      perf: Clean up perf ctx time
      perf: Add a EVENT_GUEST flag
      perf: Add APIs to load/put guest mediated PMU context
      perf/x86/intel: Support PERF_PMU_CAP_MEDIATED_VPMU

Keke Ming (5):
      riscv/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
      arm64/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
      mips/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
      arm/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
      uprobes: use kmap_local_page() for temporary page mappings

Martin Schiller (3):
      perf/x86/msr: Add Airmont NP
      perf/x86/intel: Add Airmont NP
      perf/x86/cstate: Add Airmont NP

Mingwei Zhang (1):
      perf/x86/core: Plumb mediated PMU capability from x86_pmu to x86_pmu_cap

Namhyung Kim (1):
      perf/core: Fix slow perf_event_task_exit() with LBR callstacks

Oleg Nesterov (1):
      x86/uprobes: Fix XOL allocation failure for 32-bit tasks

Peter Zijlstra (2):
      perf: Clean up mediated vPMU accounting
      perf: Use EXPORT_SYMBOL_FOR_KVM() for the mediated APIs

Randy Dunlap (1):
      s390: remove kvm_types.h from Kbuild

Sandipan Das (2):
      perf/x86/core: Do not set bit width for unavailable counters
      perf/x86/amd: Support PERF_PMU_CAP_MEDIATED_VPMU for AMD host

Sean Christopherson (3):
      perf: Move security_perf_event_free() call to __free_event()
      perf/x86/core: Register a new vector for handling mediated guest PMIs
      perf/x86/core: Add APIs to switch to/from mediated PMI vector (for KVM)

Xiang-Bin Shi (1):
      x86/ibs: Fix typo in dc_l2tlb_miss comment

Zide Chen (16):
      perf/x86/intel/cstate: Add Wildcat Lake support
      perf/x86/intel/cstate: Add Nova Lake support
      perf/x86/intel/cstate: Add Diamond Rapids support
      perf/x86/intel/uncore: Move uncore discovery init struct to header
      perf/x86/intel/uncore: Support per-platform discovery base devices
      perf/x86/intel/uncore: Remove has_generic_discovery_table()
      perf/x86/intel/uncore: Add IMH PMON support for Diamond Rapids
      perf/x86/intel/uncore: Add CBB PMON support for Diamond Rapids
      perf/x86/intel/uncore: Add domain global init callback
      perf/x86/intel/uncore: Add freerunning event descriptor helper macro
      perf/x86/intel/uncore: Support IIO free-running counters on DMR
      perf/x86/intel/uncore: Support uncore constraint ranges
      perf/x86/intel/uncore: Update DMR uncore constraints preliminarily
      perf pmu: Relax uncore wildcard matching to allow numeric suffix
      perf/x86/intel/uncore: Add missing PMON units for Panther Lake
      perf/x86/intel/uncore: Add Nova Lake support


 .../testing/sysfs-bus-event_source-devices-rdpmc   |  44 ++
 arch/arm/probes/uprobes/core.c                     |   4 +-
 arch/arm64/kernel/probes/uprobes.c                 |   4 +-
 arch/mips/kernel/uprobes.c                         |   4 +-
 arch/riscv/kernel/probes/uprobes.c                 |   4 +-
 arch/s390/include/asm/Kbuild                       |   1 -
 arch/x86/entry/entry_fred.c                        |   1 +
 arch/x86/events/amd/core.c                         |   2 +
 arch/x86/events/core.c                             |  66 +-
 arch/x86/events/intel/core.c                       | 370 ++++++++++-
 arch/x86/events/intel/cstate.c                     |  33 +-
 arch/x86/events/intel/ds.c                         | 261 ++++++++
 arch/x86/events/intel/p6.c                         |   2 +-
 arch/x86/events/intel/uncore.c                     | 139 +++--
 arch/x86/events/intel/uncore.h                     |  26 +
 arch/x86/events/intel/uncore_discovery.c           |  84 ++-
 arch/x86/events/intel/uncore_discovery.h           |   8 +-
 arch/x86/events/intel/uncore_snb.c                 |  85 +++
 arch/x86/events/intel/uncore_snbep.c               | 690 ++++++++++++++-------
 arch/x86/events/msr.c                              |   1 +
 arch/x86/events/perf_event.h                       |  26 +
 arch/x86/include/asm/amd/ibs.h                     |   2 +-
 arch/x86/include/asm/hardirq.h                     |   3 +
 arch/x86/include/asm/idtentry.h                    |   6 +
 arch/x86/include/asm/irq_vectors.h                 |   4 +-
 arch/x86/include/asm/msr-index.h                   |   5 +
 arch/x86/include/asm/perf_event.h                  |  14 +-
 arch/x86/include/asm/unwind_user.h                 |  27 +-
 arch/x86/kernel/idt.c                              |   3 +
 arch/x86/kernel/irq.c                              |  19 +
 arch/x86/kernel/uprobes.c                          |  24 +
 arch/x86/kvm/Kconfig                               |   1 +
 include/asm-generic/Kbuild                         |   1 +
 include/linux/perf_event.h                         |  35 +-
 include/linux/unwind_user.h                        |  18 +-
 include/linux/uprobes.h                            |   1 +
 include/uapi/linux/perf_event.h                    |  27 +-
 init/Kconfig                                       |   4 +
 kernel/events/core.c                               | 544 ++++++++++++----
 kernel/events/uprobes.c                            |  24 +-
 kernel/unwind/user.c                               |  12 +-
 tools/include/uapi/linux/perf_event.h              |  27 +-
 .../beauty/arch/x86/include/asm/irq_vectors.h      |   3 +-
 tools/perf/util/pmu.c                              |  14 +-
 virt/kvm/kvm_main.c                                |   3 +
 45 files changed, 2154 insertions(+), 522 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9628E60C;
	Tue, 15 Apr 2025 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705458; cv=none; b=FkvomuuRxgm+IJrLHAs7FOIYKDVzqaPbcaSbjGaEiNOiomSCbdcQxKTkKQoU9Dl53eBpTsLGSZSDK3LeMRYeAZn+0ee5hjjJ7NTqTNxbNQqBdzwCID35MsJx+/72jj3yLRx/l8hSRxhgT0wG9cUSNRzmaM/NNKUYxly+vUEguf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705458; c=relaxed/simple;
	bh=pBhWXc8rqfT0+Y6kdjF2rQr8y5smxBwEr7Z92OjWLag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rLTbbGmMDUFuqGN+ktqQpJ91ARg5DbwQwVmUp5Oz32EI1LifcK1CewYcWff/D1vbOOQgDxVm2eZxDM3rkCVgLVoGLUQW0VBe4fGNWdh7kcWIYApbiZcSlWSDm1xVMESZ7qFHigs/gmz+FP/kAA/fRYlgcIQ6Hosw771M/mrrdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNVx8cBM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNVx8cBM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705457; x=1776241457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pBhWXc8rqfT0+Y6kdjF2rQr8y5smxBwEr7Z92OjWLag=;
  b=LNVx8cBMrCXq/vOxesJWl4YHYSKMPTLe2mP/D9zbgIhv+5hEe+/lP13X
   I3hmzPv178NlFQd82vM7zi7VDCRn46FYaq9Ayn6Eo9v4Es/ss76CKBBnc
   1qZw1G2KWq23CpUKgxuxCZ3d73FvScdzVp5QnA9t8P6pPH7QOaD7WfHN1
   xqTejQYIkTh/yWIjwZgd44Dzh0uvDpJQhXGGhg74Thx3XtxbQ919dGcGb
   hQ8tguUAITE5Q7ztO//m7vyGQWGAY0LKhSiFoWFEIc9mctzz598BX2Rtt
   Nj+kPhKjS8s4nVdqjZwr2Zxblk3umKo74ObhWdqqjhRK7fKsd36M4dxH/
   A==;
X-CSE-ConnectionGUID: xwMp30B5TtWQl7yuW1CDfA==
X-CSE-MsgGUID: ho6iOBqATSSWrP6/uC3uLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46115821"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46115821"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:23:10 -0700
X-CSE-ConnectionGUID: VvLQcEqCRbexOhsQ4Jx9zg==
X-CSE-MsgGUID: xjuiu0dLTX+lnVkAShbqPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055379"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:23:05 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 00/22] Arch-PEBS and PMU supports for Clearwater Forest and Panther Lake
Date: Tue, 15 Apr 2025 11:44:06 +0000
Message-Id: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v3 patch serires is based on latest perf/core tree "5c3627b6f059
 perf/x86/intel/bts: Replace offsetof() with struct_size()" plus extra 2
patches in patchset "perf/x86/intel: Don't clear perf metrics overflow
 bit unconditionally"[1].

Changes:
  v2 -> v3:
  * Rebase patches to 6.15-rc1 code base.
  * Refactor arch-PEBS buffer allocation/release code, decouple with
    legacy PEBS buffer allocation/release code.
  * Support to capture SSP/XMM/YMM/ZMM registers for user space registers
    sampling (--user-regs options) with PEBS events.
  * Fix incorrect sampling frequency issue in frequency sampling mode.
  * Misc changes to address other v2 comments.

Tests:
  Run below tests on Clearwater Forest and Pantherlake, no issue is
  found.
  
  1. Basic perf counting case.
    perf stat -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles}' sleep 1

  2. Basic PMI based perf sampling case.
    perf record -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles}' sleep 1

  3. Basic PEBS based perf sampling case.
    perf record -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles}:p' sleep 1

  4. PEBS sampling case with basic, GPRs, vector-registers and LBR groups
    perf record -e branches:p -Iax,bx,ip,ssp,xmm0,ymm0 -b -c 10000 sleep 1

  5. User space PEBS sampling case with basic, GPRs, vector-registers and LBR groups
    perf record -e branches:pu --user-regs=ax,bx,ip,ssp,xmm0,ymm0 -b -c 10000 sleep 1

  6 PEBS sampling case with auxiliary (memory info) group
    perf mem record sleep 1

  7. PEBS sampling case with counter group
    perf record -e '{branches:p,branches,cycles}:S' -c 10000 sleep 1

  8. Perf stat and record test
    perf test 92; perf test 120

  9. perf-fuzzer test


History:
  v2: https://lore.kernel.org/all/20250218152818.158614-1-dapeng1.mi@linux.intel.com/
  v1: https://lore.kernel.org/all/20250123140721.2496639-1-dapeng1.mi@linux.intel.com/

Ref:
  [1]: https://lore.kernel.org/all/20250415104135.318169-1-dapeng1.mi@linux.intel.com/


Dapeng Mi (21):
  perf/x86/intel: Add PMU support for Clearwater Forest
  perf/x86/intel: Parse CPUID archPerfmonExt leaves for non-hybrid CPUs
  perf/x86/intel: Decouple BTS initialization from PEBS initialization
  perf/x86/intel: Rename x86_pmu.pebs to x86_pmu.ds_pebs
  perf/x86/intel: Introduce pairs of PEBS static calls
  perf/x86/intel: Initialize architectural PEBS
  perf/x86/intel/ds: Factor out PEBS record processing code to functions
  perf/x86/intel/ds: Factor out PEBS group processing code to functions
  perf/x86/intel: Process arch-PEBS records or record fragments
  perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
  perf/x86/intel: Update dyn_constranit base on PEBS event precise level
  perf/x86/intel: Setup PEBS data configuration and enable legacy groups
  perf/x86/intel: Add counter group support for arch-PEBS
  perf/x86/intel: Support SSP register capturing for arch-PEBS
  perf/core: Support to capture higher width vector registers
  perf/x86/intel: Support arch-PEBS vector registers group capturing
  perf tools: Support to show SSP register
  perf tools: Enhance arch__intr/user_reg_mask() helpers
  perf tools: Enhance sample_regs_user/intr to capture more registers
  perf tools: Support to capture more vector registers (x86/Intel)
  perf tools/tests: Add vector registers PEBS sampling test

Kan Liang (1):
  perf/x86/intel: Add Panther Lake support

 arch/arm/kernel/perf_regs.c                   |   6 +
 arch/arm64/kernel/perf_regs.c                 |   6 +
 arch/csky/kernel/perf_regs.c                  |   5 +
 arch/loongarch/kernel/perf_regs.c             |   5 +
 arch/mips/kernel/perf_regs.c                  |   5 +
 arch/powerpc/perf/perf_regs.c                 |   5 +
 arch/riscv/kernel/perf_regs.c                 |   5 +
 arch/s390/kernel/perf_regs.c                  |   5 +
 arch/x86/events/core.c                        | 136 +++-
 arch/x86/events/intel/bts.c                   |   6 +-
 arch/x86/events/intel/core.c                  | 329 +++++++-
 arch/x86/events/intel/ds.c                    | 714 ++++++++++++++----
 arch/x86/events/perf_event.h                  |  60 +-
 arch/x86/include/asm/intel_ds.h               |  10 +-
 arch/x86/include/asm/msr-index.h              |  26 +
 arch/x86/include/asm/perf_event.h             | 145 +++-
 arch/x86/include/uapi/asm/perf_regs.h         |  83 +-
 arch/x86/kernel/perf_regs.c                   |  71 +-
 include/linux/perf_event.h                    |   4 +
 include/linux/perf_regs.h                     |  10 +
 include/uapi/linux/perf_event.h               |  11 +
 kernel/events/core.c                          |  98 ++-
 tools/arch/x86/include/uapi/asm/perf_regs.h   |  86 ++-
 tools/include/uapi/linux/perf_event.h         |  14 +
 tools/perf/arch/arm/util/perf_regs.c          |   8 +-
 tools/perf/arch/arm64/util/perf_regs.c        |  11 +-
 tools/perf/arch/csky/util/perf_regs.c         |   8 +-
 tools/perf/arch/loongarch/util/perf_regs.c    |   8 +-
 tools/perf/arch/mips/util/perf_regs.c         |   8 +-
 tools/perf/arch/powerpc/util/perf_regs.c      |  17 +-
 tools/perf/arch/riscv/util/perf_regs.c        |   8 +-
 tools/perf/arch/s390/util/perf_regs.c         |   8 +-
 tools/perf/arch/x86/util/perf_regs.c          | 138 +++-
 tools/perf/builtin-script.c                   |  23 +-
 tools/perf/tests/shell/record.sh              |  55 ++
 tools/perf/util/evsel.c                       |  36 +-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/parse-regs-options.c          |  23 +-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  84 +++
 tools/perf/util/perf_regs.c                   |   8 +-
 tools/perf/util/perf_regs.h                   |  20 +-
 tools/perf/util/record.h                      |   4 +-
 tools/perf/util/sample.h                      |   6 +-
 tools/perf/util/session.c                     |  29 +-
 tools/perf/util/synthetic-events.c            |  12 +-
 45 files changed, 2075 insertions(+), 286 deletions(-)


base-commit: 538f1f04b5bfeaff4cd681b2567a0fde2335be38
-- 
2.40.1


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3222B5A6;
	Tue, 18 Feb 2025 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866425; cv=none; b=B8YxLpC5rUlrDgFdSkGXwu9LqGuyAuZMk0r0zJUnMaq8fB5FNlWj0NT4SmBxHhwqxlQBF6FmnDOgSh4fuIlzxGpehphsOretBT+FejSh/GP5hmR6f2OKcN9rP5MaOUD+mAdKvMzQh1imaKW8xWcYF54DVimSno5OC1tLwPWJlBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866425; c=relaxed/simple;
	bh=xu0GUm83JyShHEqFmSwpkaZGPFW88VwKlL9uutQEx3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n3vXsL2Dg2x+kapWTVRWM45p62M/ayQr3I8+XBwilAfS1qlvmWkncisoaa6uVLz6sx/VR3yXr+XX63Rk/HTtWwclExGq5YR+uCXwJkGesiDYDz1YhnVOiDD0boADFwpUmDCxvrZVLB5qkUBscECKC/8MfETowY1/l2iCcPA5d/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRwy/V4g; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRwy/V4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866424; x=1771402424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xu0GUm83JyShHEqFmSwpkaZGPFW88VwKlL9uutQEx3w=;
  b=iRwy/V4gJt0IO2bH1oToYqGViF1XrQbVpeuTVQeiCVc6p2/rGXoQCXvr
   o3bYvOzL2rILiUufp5XxAVu54UyPEujxak+QAhViF8CGUT0iRWYb3XYPH
   LCa8sS44CtkWOJCKc6bTawnY1CF7NKhChZGrKr9Y0UEW1XorFypa681fe
   zIVFcFkhzl5Vz/HlPOEhLnq4kZAYURKFsX6H3uXeRRjB/Znlm6LqjLmjP
   H4P+MW+2gQ9UWjmTlm52LjQDJCMjfXDRsgeivPZLKX5rKabpTMxLqb2BD
   FWQ2YzSU5n4ZkHzwjDCBb/Uliulv/Ce+KacWVUod0eb5XuJF5+eS9KkZG
   A==;
X-CSE-ConnectionGUID: dJ7q2oqkT2Kp3LVTeqrd5w==
X-CSE-MsgGUID: Lk7yldyXQxSmDqcN/gKvAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200667"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200667"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:13:44 -0800
X-CSE-ConnectionGUID: fXcKE2DmSdSc2Qy3bIAJjw==
X-CSE-MsgGUID: KQp3vMk7S32t+ZQ3GULzgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166061"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:13:40 -0800
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
Subject: [Patch v2 00/24] Arch-PEBS and PMU supports for Clearwater Forest and Panther Lake
Date: Tue, 18 Feb 2025 15:27:54 +0000
Message-Id: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v2 patch series is based on latest perf/core tree "1623ced247f7
(x86/events/amd/iommu: Increase IOMMU_NAME_SIZE)" + extra first two
patches of patch set "Cleanup for Intel PMU initialization"[1].

Changes:

  v1 -> v2:
    * Add Panther Lake PMU support (patch 02/24)
    * Add PEBS static calls to avoid introducing too much
      x86_pmu.arch_pebs checks (patch 07~08/24)
    * Optimize PEBS constraints base on Kan's dynamic constranit patch
      (patch 13/24)
    * Split perf tools patch of supporting more vector registers to
      several small patches (patch 20~22/24)

Tests:

  * Run below tests on Clearwater Forest and no issue is found. Please
    notice nmi_watchdog is disabled when running the tests.

  a. Basic perf counting case.
    perf stat -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles,topdown-bad-spec,topdown-fe-bound,topdown-retiring}' sleep 1

  b. Basic PMI based perf sampling case.
    perf record -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles,topdown-bad-spec,topdown-fe-bound,topdown-retiring}' sleep 1

  c. Basic PEBS based perf sampling case.
    perf record -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles,topdown-bad-spec,topdown-fe-bound,topdown-retiring}:p' sleep 1

  d. PEBS sampling case with basic, GPRs, vector-registers and LBR groups
    perf record -e branches:p -Iax,bx,ip,ssp,xmm0,ymmh0 -b -c 10000 sleep 1

  e. PEBS sampling case with auxiliary (memory info) group
    perf mem record sleep 1

  f. PEBS sampling case with counter group
    perf record -e '{branches:p,branches,cycles}:S' -c 10000 sleep 1

  g. Perf stat and record test
    perf test 95; perf test 119

  h. perf-fuzzer test


  * Run similar tests on Panther Lake P-cores and E-cores and no issue
    is found. CPU 0 is P-core and CPU 9 is E-core. nmi_watchdog is
    disabled as well.

  P-core:

  a. Basic perf counting case.
    perf stat -e '{cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/cycles/,cpu_core/instructions/,cpu_core/ref-cycles/,cpu_core/slots/}' taskset -c 0 sleep 1

  b. Basic PMI based perf sampling case.
    perf record -e '{cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/cycles/,cpu_core/instructions/,cpu_core/ref-cycles/,cpu_core/slots/}' taskset -c 0 sleep 1

  c. Basic PEBS based perf sampling case.
    perf record -e '{cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/branches/,cpu_core/cycles/,cpu_core/instructions/,cpu_core/ref-cycles/,cpu_core/slots/}:p' taskset -c 0 sleep 1

  d. PEBS sampling case with basic, GPRs, vector-registers and LBR groups
    perf record -e branches:p -Iax,bx,ip,ssp,xmm0,ymmh0 -b -c 10000 taskset -c 0 sleep 1

  e. PEBS sampling case for user space registers
    perf record -e branches:p --user-regs=ax,bx,ip -b -c 10000 taskset -c 0 sleep 1

  f. PEBS sampling case with auxiliary (memory info) group
    perf mem record taskset -c 0 sleep 1

  g. PEBS sampling case with counter group
    perf record -e '{branches:p,branches,cycles}:S' -c 10000 taskset -c 0 sleep 1

  h. Perf stat and record test
    perf test 95; perf test 119

  E-core:

  a. Basic perf counting case.
    perf stat -e '{cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/cycles/,cpu_atom/instructions/,cpu_atom/ref-cycles/,cpu_atom/topdown-bad-spec/,cpu_atom/topdown-fe-bound/,cpu_atom/topdown-retiring/}' taskset -c 9 sleep 1

  b. Basic PMI based perf sampling case.
    perf record -e '{cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/cycles/,cpu_atom/instructions/,cpu_atom/ref-cycles/,cpu_atom/topdown-bad-spec/,cpu_atom/topdown-fe-bound/,cpu_atom/topdown-retiring/}' taskset -c 9 sleep 1
  c. Basic PEBS based perf sampling case.
    perf record -e '{cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/branches/,cpu_atom/cycles/,cpu_atom/instructions/,cpu_atom/ref-cycles/,cpu_atom/topdown-bad-spec/,cpu_atom/topdown-fe-bound/,cpu_atom/topdown-retiring/}:p' taskset -c 9 sleep 1

  d. PEBS sampling case with basic, GPRs, vector-registers and LBR groups
    perf record -e branches:p -Iax,bx,ip,ssp,xmm0,ymmh0 -b -c 10000 taskset -c  sleep 1

  e. PEBS sampling case for user space registers
    perf record -e branches:p --user-regs=ax,bx,ip -b -c 10000 taskset -c 9 sleep 1

  f. PEBS sampling case with auxiliary (memory info) group
    perf mem record taskset -c 9 sleep 1

  g. PEBS sampling case with counter group
    perf record -e '{branches:p,branches,cycles}:S' -c 10000 taskset -c 9 sleep 1

History:
  v1: https://lore.kernel.org/all/20250123140721.2496639-1-dapeng1.mi@linux.intel.com/

Ref:
  [1]: https://lore.kernel.org/all/20250129154820.3755948-1-kan.liang@linux.intel.com/


Dapeng Mi (22):
  perf/x86/intel: Add PMU support for Clearwater Forest
  perf/x86/intel: Parse CPUID archPerfmonExt leaves for non-hybrid CPUs
  perf/x86/intel: Decouple BTS initialization from PEBS initialization
  perf/x86/intel: Rename x86_pmu.pebs to x86_pmu.ds_pebs
  perf/x86/intel: Introduce pairs of PEBS static calls
  perf/x86/intel: Initialize architectural PEBS
  perf/x86/intel/ds: Factor out common PEBS processing code to functions
  perf/x86/intel: Process arch-PEBS records or record fragments
  perf/x86/intel: Factor out common functions to process PEBS groups
  perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
  perf/x86/intel: Update dyn_constranit base on PEBS event precise level
  perf/x86/intel: Setup PEBS data configuration and enable legacy groups
  perf/x86/intel: Add SSP register support for arch-PEBS
  perf/x86/intel: Add counter group support for arch-PEBS
  perf/core: Support to capture higher width vector registers
  perf/x86/intel: Support arch-PEBS vector registers group capturing
  perf tools: Support to show SSP register
  perf tools: Enhance arch__intr/user_reg_mask() helpers
  perf tools: Enhance sample_regs_user/intr to capture more registers
  perf tools: Support to capture more vector registers (x86/Intel)
  perf tools/tests: Add vector registers PEBS sampling test
  perf tools: Fix incorrect --user-regs comments

Kan Liang (2):
  perf/x86: Add dynamic constraint
  perf/x86/intel: Add Panther Lake support

 arch/arm/kernel/perf_regs.c                   |   6 +
 arch/arm64/kernel/perf_regs.c                 |   6 +
 arch/csky/kernel/perf_regs.c                  |   5 +
 arch/loongarch/kernel/perf_regs.c             |   5 +
 arch/mips/kernel/perf_regs.c                  |   5 +
 arch/powerpc/perf/perf_regs.c                 |   5 +
 arch/riscv/kernel/perf_regs.c                 |   5 +
 arch/s390/kernel/perf_regs.c                  |   5 +
 arch/x86/events/core.c                        | 105 ++-
 arch/x86/events/intel/bts.c                   |   6 +-
 arch/x86/events/intel/core.c                  | 330 +++++++-
 arch/x86/events/intel/ds.c                    | 722 ++++++++++++++----
 arch/x86/events/intel/lbr.c                   |   2 +-
 arch/x86/events/perf_event.h                  |  69 +-
 arch/x86/include/asm/intel_ds.h               |  10 +-
 arch/x86/include/asm/msr-index.h              |  28 +
 arch/x86/include/asm/perf_event.h             | 145 +++-
 arch/x86/include/uapi/asm/perf_regs.h         |  87 ++-
 arch/x86/kernel/perf_regs.c                   |  55 +-
 include/linux/perf_event.h                    |   3 +
 include/linux/perf_regs.h                     |  10 +
 include/uapi/linux/perf_event.h               |  11 +
 kernel/events/core.c                          |  53 +-
 tools/arch/x86/include/uapi/asm/perf_regs.h   |  90 ++-
 tools/include/uapi/linux/perf_event.h         |  14 +
 tools/perf/arch/arm/util/perf_regs.c          |   8 +-
 tools/perf/arch/arm64/util/perf_regs.c        |  11 +-
 tools/perf/arch/csky/util/perf_regs.c         |   8 +-
 tools/perf/arch/loongarch/util/perf_regs.c    |   8 +-
 tools/perf/arch/mips/util/perf_regs.c         |   8 +-
 tools/perf/arch/powerpc/util/perf_regs.c      |  17 +-
 tools/perf/arch/riscv/util/perf_regs.c        |   8 +-
 tools/perf/arch/s390/util/perf_regs.c         |   8 +-
 tools/perf/arch/x86/util/perf_regs.c          | 112 ++-
 tools/perf/builtin-record.c                   |   2 +-
 tools/perf/builtin-script.c                   |  23 +-
 tools/perf/tests/shell/record.sh              |  55 ++
 tools/perf/util/evsel.c                       |  36 +-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/parse-regs-options.c          |  23 +-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  90 +++
 tools/perf/util/perf_regs.c                   |   8 +-
 tools/perf/util/perf_regs.h                   |  20 +-
 tools/perf/util/record.h                      |   4 +-
 tools/perf/util/sample.h                      |   6 +-
 tools/perf/util/session.c                     |  29 +-
 tools/perf/util/synthetic-events.c            |   6 +-
 47 files changed, 1966 insertions(+), 308 deletions(-)

-- 
2.40.1


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94134FF75;
	Wed, 29 Oct 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733459; cv=none; b=DaKNavmseAiHRs6Ryyo7Lr7pPJ2wx+osZBWn+UrmnKyirURGJgPALVPb14YR3/F4MguhGOfZCa6juReHTeQ2V9JagagI3rWd1RK5dxaycIb5Av2LaP1hzIQL2zaZ5nCylSn4UdihQ71F3mR4205As+QmOxLxO6X010E3Pg0oNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733459; c=relaxed/simple;
	bh=rt36afLKcSf44M1wdYZ2pw2LDvGIIg+6397dpuOnAFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHbvK7rrbDhOD6n44pPbaslugcNKAE38zhXKDTFbowGsnTcSRZG5HZC2lgqKLK2b3WN/zZ+B2Nika22GuFpsh2/9zf94F+5zbzQNvbmbC6Mm5ll/1RO004xx21eIPp8Son34w6qsf++JqX5iAsL+mgH3bxD9S6c2lJRXtoByffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ct29ZDSR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ct29ZDSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761733458; x=1793269458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rt36afLKcSf44M1wdYZ2pw2LDvGIIg+6397dpuOnAFw=;
  b=Ct29ZDSRfpv2iM6rdnZlBroTvkDdQhBXdstC5iQPiG745ly028mQOfD+
   V6uPq0JJ19xqUQGn+1kOY4qxNFPAwW8V1Lsx+CW32VO847hNfKcw15zSt
   K/3Vonxa9KydzfFMMbQRySnYEW3frijVfSbFl47JByVSvQIpvCRdVOlHe
   kh5vhhsPZNRmVn3YvDCx6RdOn3/p+63EVHRs3HXRPYscnlWRYdShJ3+d1
   +GaUx1305bTE9dXeg7LI+z0IDofwZQbqgB8X+xI6sLmgyPbmLOORBjeUk
   HGuVQ/airwZE8M4ymJtNGcuM3i2KD9Vn+UghlBxgWtEiOXNbkMwcPQia6
   w==;
X-CSE-ConnectionGUID: tn+92W+PTzW1FgqcAhB8xA==
X-CSE-MsgGUID: 6aS7HdVVTXqKMNDXSmjfKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63757960"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63757960"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 03:24:16 -0700
X-CSE-ConnectionGUID: D3STHpy9Qcyv5B0cqt+55Q==
X-CSE-MsgGUID: DvHmFuzRQAOajZcYrz6w+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185963325"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2025 03:24:12 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v9 00/12] arch-PEBS enabling for Intel platforms
Date: Wed, 29 Oct 2025 18:21:24 +0800
Message-Id: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
v8 -> v9:
  * Move cpuc->events[] clearing from x86_pmu_stop() to x86_pmu_del() to
    fix the NULL event access issue as events throttling (Patch 02/12)
  * Add macro counter_mask() to simplify the counter mask generation
    code (Patch 05/12)
  * Use "__always_inline" to replace "inline" attribute to ensure the
    setup_fn callback won't be called as indirect call (Patch 06/12)
  * Code style refine (Patch 06/12) 

v7 -> v8:
  * Fix the warning reported by Kernel test robot (Patch 02/12)
  * Rebase code to 6.18-rc1.

v6 -> v7:
  * Rebase code to last tip perf/core tree.
  * Opportunistically remove the redundant is_x86_event() prototype.
    (Patch 01/12)
  * Fix PEBS handler NULL event access and record loss issue.
    (Patch 02/12)
  * Reset MSR_IA32_PEBS_INDEX at the head of_drain_arch_pebs() instead
    of end. It avoids the processed PEBS records are processed again in
    some corner cases like event throttling. (Patch 08/12)

v5 -> v6:
  * Rebase code to last tip perf/core tree + "x86 perf bug fixes and
    optimization" patchset
 
v4 -> v5:
  * Rebase code to 6.16-rc3
  * Allocate/free arch-PEBS buffer in callbacks *prepare_cpu/*dead_cpu
    (patch 07/10, Peter)
  * Code and comments refine (patch 09/10, Peter)


This patchset introduces architectural PEBS support for Intel platforms
like Clearwater Forest (CWF) and Panther Lake (PTL). The detailed
information about arch-PEBS can be found in chapter 11
"architectural PEBS" of "Intel Architecture Instruction Set Extensions
and Future Features".

This patch set doesn't include the SSP and SIMD regs (OPMASK/YMM/ZMM)
sampling support for arch-PEBS to avoid the dependency for the basic
SIMD regs sampling support patch series[1]. Once the basic SIMD regs
sampling is supported, the arch-PEBS based SSP and SIMD regs
(OPMASK/YMM/ZMM) sampling would be supported in a later patch set.

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
    perf record -e branches:p -Iax,bx,ip,xmm0 -b -c 10000 sleep 1

  5. User space PEBS sampling case with basic, GPRs and LBR groups
    perf record -e branches:p --user-regs=ax,bx,ip -b -c 10000 sleep 1

  6. PEBS sampling case with auxiliary (memory info) group
    perf mem record sleep 1

  7. PEBS sampling case with counter group
    perf record -e '{branches:p,branches,cycles}:S' -c 10000 sleep 1

  8. Perf stat and record test
    perf test 100; perf test 131


History:
  v8: https://lore.kernel.org/all/20251015064422.47437-1-dapeng1.mi@linux.intel.com/
  v7: https://lore.kernel.org/all/20250828013435.1528459-1-dapeng1.mi@linux.intel.com/
  v6: https://lore.kernel.org/all/20250821035805.159494-1-dapeng1.mi@linux.intel.com/ 
  v5: https://lore.kernel.org/all/20250623223546.112465-1-dapeng1.mi@linux.intel.com/
  v4: https://lore.kernel.org/all/20250620103909.1586595-1-dapeng1.mi@linux.intel.com/
  v3: https://lore.kernel.org/all/20250415114428.341182-1-dapeng1.mi@linux.intel.com/
  v2: https://lore.kernel.org/all/20250218152818.158614-1-dapeng1.mi@linux.intel.com/
  v1: https://lore.kernel.org/all/20250123140721.2496639-1-dapeng1.mi@linux.intel.com/

Ref:
  [1]: https://lore.kernel.org/all/20250925061213.178796-1-dapeng1.mi@linux.intel.com/


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
  perf/x86/intel: Update dyn_constranit base on PEBS event precise level
  perf/x86/intel: Setup PEBS data configuration and enable legacy groups
  perf/x86/intel: Add counter group support for arch-PEBS

 arch/x86/events/core.c            |  26 +-
 arch/x86/events/intel/core.c      | 273 ++++++++++++--
 arch/x86/events/intel/ds.c        | 602 ++++++++++++++++++++++++------
 arch/x86/events/perf_event.h      |  41 +-
 arch/x86/include/asm/intel_ds.h   |  10 +-
 arch/x86/include/asm/msr-index.h  |  20 +
 arch/x86/include/asm/perf_event.h | 116 +++++-
 7 files changed, 943 insertions(+), 145 deletions(-)


base-commit: 45e1dccc0653c50e377dae57ef086a8d0f71061d
-- 
2.34.1


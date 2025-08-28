Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFC1EC018;
	Thu, 28 Aug 2025 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344956; cv=none; b=rT/zBmF4elGF4YlCqpo9Al/bEJEvgVjK0PhQd/qnrOlh94W3dM5UdU7Qt+cHKraXqlb33d78jf/L6dL+S7QA4IYPR/8eeHGLcX19HDN2TM6xjA1jcU2+Mbip7Av6VmXslQR3Nkvctvf2C8h2jzJG2LnExSTWaxOKdGNv/KQlf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344956; c=relaxed/simple;
	bh=oojjLrW6CwnCT9ReXbW828plbeeF0xTAXIq9LkpaiZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DY7I1IwuZEqxxqmJnomiX4tkWCsUObbbsz957p8KtA7zrfXn1uVEII9yZXts0S4TNddAM8L+hAeUippqKEzTRSZmb0oK5E3s1+qc7AnAFU14QgXYA7LcyzVcMXnjuXG/Zkcg/agqsd/6qrLYZMcIw/uSaI/VzdxMrYqMD6GcsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTDlhDXK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTDlhDXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756344954; x=1787880954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oojjLrW6CwnCT9ReXbW828plbeeF0xTAXIq9LkpaiZ8=;
  b=fTDlhDXKd08O1NB6Qo6G/S5FNBhh12MlfS6X+0F+IFMgQAnHfIqF7VgE
   pmQqogEzjw9lb6A3QUFbomH+8cOhFejaz+RePoktz33gBKVN70RfaZa58
   CLyv3s+eXS323YEJIBBa3/Oh7eTw4C9IZ5JMMT7tGCozVK0JKxtX5NxqE
   QjuW/gfs7JeWytyrtmZegoWhkix7/LgHX3Yy5SIO6A9FesBJXHwx/rA5C
   TYCsx5I0FKKwBGD14PhNE4UPmkO8sQaYbZNKdnVuXDJFWkZuCmvV9jtUB
   VWqKJES0N5EO1sPigv6IM+lNh55ntAI+0Ia3egNOJwq/BddQq6KLiiJbA
   Q==;
X-CSE-ConnectionGUID: Nkwa7YKgT5KOFx26siAP6w==
X-CSE-MsgGUID: U8gtYDVdTkKCGQcwu8jkYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61240811"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61240811"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 18:35:53 -0700
X-CSE-ConnectionGUID: 7sD5n1hhTlSc5vLefz/tlA==
X-CSE-MsgGUID: h8/qbmReQu+1/o7dQk/psA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170372430"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2025 18:35:50 -0700
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
Subject: [Patch v7 00/12] arch-PEBS enabling for Intel platforms
Date: Thu, 28 Aug 2025 09:34:23 +0800
Message-Id: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
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
  v6: https://lore.kernel.org/all/20250821035805.159494-1-dapeng1.mi@linux.intel.com/ 
  v5: https://lore.kernel.org/all/20250623223546.112465-1-dapeng1.mi@linux.intel.com/
  v4: https://lore.kernel.org/all/20250620103909.1586595-1-dapeng1.mi@linux.intel.com/
  v3: https://lore.kernel.org/all/20250415114428.341182-1-dapeng1.mi@linux.intel.com/
  v2: https://lore.kernel.org/all/20250218152818.158614-1-dapeng1.mi@linux.intel.com/
  v1: https://lore.kernel.org/all/20250123140721.2496639-1-dapeng1.mi@linux.intel.com/

Ref:
  [1]: https://lore.kernel.org/all/20250815213435.1702022-1-kan.liang@linux.intel.com/

Dapeng Mi (12):
  perf/x86: Remove redundant is_x86_event() prototype
  perf/x86/intel: Fix NULL event access and potential PEBS record loss
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

 arch/x86/events/core.c            |  21 +-
 arch/x86/events/intel/core.c      | 268 ++++++++++++-
 arch/x86/events/intel/ds.c        | 621 +++++++++++++++++++++++++-----
 arch/x86/events/perf_event.h      |  41 +-
 arch/x86/include/asm/intel_ds.h   |  10 +-
 arch/x86/include/asm/msr-index.h  |  20 +
 arch/x86/include/asm/perf_event.h | 116 +++++-
 7 files changed, 955 insertions(+), 142 deletions(-)


base-commit: f49e1be19542487921e82b29004908966cb99d7c
-- 
2.34.1


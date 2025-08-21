Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1449217F24;
	Thu, 21 Aug 2025 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748763; cv=none; b=ElnCB1jU6y/Jfbjc7Rkmcfn7gf+2TixGiYXeoAdtD/dv1zXhHghLpfrY42vp0TWXvGcu5pg+VvGcUtbqdfV/ZK+CBFNQsz0oXOFhgaY/Ok3oAS7f+l14pG41D3Eok89oeU7YWeWYqPr/kZo3ea43Ez7oA5wXER+Kt4+RYjXXHFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748763; c=relaxed/simple;
	bh=PjEpKSGkFX2AcsB5hdqQvR+5Y4sYsFLp6sTNJua2DgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uU6mlfDRaHLRNyqJxFpkEsVtt4RLXJG87PKHT72DGGEWCE7Bjaj7zj7eGqsZivwYiq/9ev7BhrtiCr+RYuQZqskkxUJReUvP316Mn5CbbGD5M/3RTR+QG0VPV8nwCZkP3Fs1JPbQ4999gTu20qhIW7uPirjO8HTVpGIJQk1q3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsHkRYFh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsHkRYFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755748762; x=1787284762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PjEpKSGkFX2AcsB5hdqQvR+5Y4sYsFLp6sTNJua2DgM=;
  b=JsHkRYFhRUWhonMF55kIMiARu0kKF/o4FTKzUIL6AfjzI92ZydR6nC96
   pG6acb5RjbVcLeNkojKCdwHUXXVZy+oagEgCs5LV5Kyfdkpu1SDpRlsY2
   EBjdH80GVqhrLRHDAJEWAwOTwHw1PgTxOWyZpAVCuy6wbuAJqXYiSA4IE
   ayhl1eIfdmn6pxL/7fYCjw8cJ0nNzEfu/LL8f1CUpKsjWLutjsWy59wkJ
   GVWjNADXxyCF0ckAYjiWnmsVFP/CdKhwrOjdgWDW6l+mhPdmuAH6qCV9b
   5qPoZsNDlTeuMw8ZGVC8EQ0n3arzcAeNo8TV+Cit3s49ck7yDtgaY4gSv
   w==;
X-CSE-ConnectionGUID: 8uXJD18DTP+uxT+jSWPL2A==
X-CSE-MsgGUID: 5zloBmS8T+6iag8eqfzbPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68731943"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68731943"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 20:59:21 -0700
X-CSE-ConnectionGUID: L3mc8fVeSAmCFjdpEvnNog==
X-CSE-MsgGUID: NWPWkd84TTGzCVTai5HDsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168712985"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 20 Aug 2025 20:59:18 -0700
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
Subject: [Patch v6 00/10] arch-PEBS enabling for Intel platforms
Date: Thu, 21 Aug 2025 11:57:55 +0800
Message-Id: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
v5 -> v6:
  * Rebase code to last tip perf/core tree + "x86 perf bug fixes and
    optimization" patchset
 
v4 -> v5:
  * Rebase code to 6.16-rc3
  * Allocate/free arch-PEBS buffer in callbacks *prepare_cpu/*dead_cpu
    (patch 07/10, Peter)
  * Code and comments refine (patch 09/10, Peter)

Please notice this patch set is based on tip perf/core tree (448f97fba901)
+ the patch series "x86 perf bug fixes and optimization"[1].

This patchset introduces architectural PEBS support for Intel platforms
like Clearwater Forest (CWF) and Panther Lake (PTL). The detailed
information about arch-PEBS can be found in chapter 11
"architectural PEBS" of "Intel Architecture Instruction Set Extensions
and Future Features".

This patch set doesn't include the SSP and SIMD regs (OPMASK/YMM/ZMM)
sampling support for arch-PEBS to avoid the dependency for the basic
SIMD regs sampling support patch series[2]. Once the basic SIMD regs
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

  6 PEBS sampling case with auxiliary (memory info) group
    perf mem record sleep 1

  7. PEBS sampling case with counter group
    perf record -e '{branches:p,branches,cycles}:S' -c 10000 sleep 1

  8. Perf stat and record test
    perf test 96; perf test 125


History:
  v4: https://lore.kernel.org/all/20250620103909.1586595-1-dapeng1.mi@linux.intel.com/
  v3: https://lore.kernel.org/all/20250415114428.341182-1-dapeng1.mi@linux.intel.com/
  v2: https://lore.kernel.org/all/20250218152818.158614-1-dapeng1.mi@linux.intel.com/
  v1: https://lore.kernel.org/all/20250123140721.2496639-1-dapeng1.mi@linux.intel.com/

Ref:
  [1]: https://lore.kernel.org/all/20250820023032.17128-1-dapeng1.mi@linux.intel.com/
  [2]: https://lore.kernel.org/all/20250815213435.1702022-1-kan.liang@linux.intel.com/

Dapeng Mi (10):
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
 arch/x86/events/intel/ds.c        | 615 ++++++++++++++++++++++++------
 arch/x86/events/perf_event.h      |  40 +-
 arch/x86/include/asm/intel_ds.h   |  10 +-
 arch/x86/include/asm/msr-index.h  |  20 +
 arch/x86/include/asm/perf_event.h | 116 +++++-
 7 files changed, 940 insertions(+), 150 deletions(-)

-- 
2.34.1


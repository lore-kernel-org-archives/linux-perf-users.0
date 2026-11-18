Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972201;
	b=CpQcZDElPkhxVW8iVm7BaPkBxMykOfZLSgJ6pPdkgdRK04GJVv9d+lzN78DyPogDTMFc
	 WewbYpCu9Utkvzd2ycL++bOELlJW/5X3/NPquCscHjiVE5xnbJomaVyN31sylhrM3r1X8
	 7q4awnz/xnTcY4GdDc4L6u4QBr4M3gM3XavL9Kyw2RZe7f778IboPlZwgc4oAGAvZciIL
	 P4yl0BYgWXqKF/MtUdqClr1N9eu8a93XaPKV0HWWreKxjnBvB+OSR5lKOPLg6OdJQMgGB
	 78aRcqJnsFP5sNxolkM+n0OGJ/yeBY3KwBBPSd+2nYy3gGab76TzaPzUsp35b0M0sMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972201;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dXN85PjsGniPmRyPYKjIV8ttbUwh+UW8pxhSD79YaCU=;
	b=wiK4TohT16N7cruk8tFkOUj7VI4CPeVkj+/eS23G6lk4N/tsPHabApkZ6pIN77zqHjiw
	 MOBDEE40pwGKtBahystenrUEcF0d5EzTdp2pHiHE/tHTFHS1MNDrzlRtTKBN4rgtTYoHH
	 3EhRsquXVN5q/YlK8tncGFM+7a8l2cXc2SkDCHOsvB8YmpkhKIrUAvZYlOSKJHJbrfasu
	 leiujmVO+UcuobSwl0n/9CKRtvPxAGAmRZJVEJru29hiwx4irwWU61iUDjin3SbAcrCJO
	 qFSqMyI0R0M6gqlwAo3KO4/JwIEnnIP1S3rvXJyMdHvuNjFAnh8kujc2hZt7+koav/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Wk/5SJPt";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B29606A325;
	Wed, 18 Nov 2026 03:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1B29606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wk/5SJPt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972201; x=1826508201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MGRvSZt4YRGD+iMrhSwt93tu6gga2dCK9frepgpE8Y8=;
  b=Wk/5SJPt886lYRf2/U2q6b8BOFC1RfceRsq2em7TmUqFVzWaFthNPRXI
   //6h7IM5XLmYRmEEWeq0ZFOUd9wtHKISJpzDUBUp/jI6UoCuDVM3f8TmV
   /CL7WCG+b5MWCxqMtVHmbT9geWhohr3msGqo19oLBLBlLjdbQO1cM5C56
   /K8RBjDSOjDKMdkqLtDKrAZKp+v5XCI07xXqaj4u/kEKOqVgI1H0joouU
   G3OmcDSb2IqO5/8q9GGJwZppj4F6QntVNo0Rgtc7QbyH++aoOAFEZm/yf
   Gszy/9nbEZFNKwMwx431ESqBpEUzk5vlSDuKbyBEECrrWd12DK627Tw6V
   w==;
X-CSE-ConnectionGUID: WXX65n6aSy2KYlCTp+54Sg==
X-CSE-MsgGUID: gwvcp/8DRHeMD2m5XPSamA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629796"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629796"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:22:50 -0800
X-CSE-ConnectionGUID: 5uTxgxthSbu92h25LLb9gg==
X-CSE-MsgGUID: PJzA6f+8SDC4poaBBrQd0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894046"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:22:46 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 00/24] perf/x86: Fix multiple LBR sampling issues
Date: Wed, 18 Nov 2026 11:14:29 +0800
Message-Id: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes several x86 LBR sampling issues discovered during
review and debugging. Most of them are related to BPF LBR snapshotting
support.

The series originally targeted the BPF stack out-of-bounds access issue,
but additional problems were found during debugging and code review,
including:
- PMU and LBR being re-enabled unconditionally at BPF snapshotting exit,
  even when they had already been disabled before BPF snapshotting on both
  AMD and Intel.
- LBR not being fully frozen in the PMI handler on Intel, which allows
  branches in the PMI path to pollute the BPF LBR snapshot.
- BPF snapshotting overwriting the cached LBR stack of PEBS LBR events on
  Intel.
- PEBS LBR events overwriting the LBR stack of non-PEBS LBR events on
  Intel when both overflow in the same PMI.
- LBR counter events reporting zero counters on Intel when multiple
  LBR counter events overflow in the same PMI.


Patch layout:
- Patch 01: Add a sanity check to ensure the LBR stack depth never
  exceeds MAX_LBR_ENTRIES.
- Patch 02: Validate that hardware has actually written LBR data into
  the XSAVE area before parsing it.
- Patch 03-04: Fix a potential LBR stack out-of-bounds access on AMD
  and Intel, respectively.
- Patch 05-08: Fix incorrect PMU and LBR re-enabling in
  perf_snapshot_branch_stack() on AMD and Intel, respectively.
- Patch 09: Keep the LBR frozen throughout PMI processing so that all
  LBR events observe a consistent LBR stack in the PMI handler.
- Patch 10: Add bounds tracking for the number of entries counted in
  struct perf_branch_stack.
- Patch 11-12: Add a dedicated LBR stack for BPF LBR snapshots to avoid
  clobbering the default LBR stack used by other LBR events.
- Patch 13: Make perf_snapshot_branch_stack() snapshot the live
  hardware LBR data instead of the cached PEBS LBR stack.
- Patch 14-16: Account lbr_users/lbr_pebs_users for arch-PEBS and pure
  branch counter events.
- Patch 17-19: Prevent the PEBS LBR stack from overwriting the non-PEBS
  LBR stack in several corner cases.
- Patch 20-21: Ensure LBR counters are not lost when multiple LBR
  counter events overflow in the same PMI.
- Patch 22: Clamp the parsed PEBS LBR stack depth to x86_pmu.lbr_nr to
  avoid an LBR stack out-of-bounds access.
- Patch 23: Fix the shared LBR stack depth truncation issue.
- Patch 24: Fix incorrect clearing of the PERF_METRICS overflow bit.


Changes in v7:
- Patch 06/08: Set/clear the cpuc->enabled flag to track the PMU enabling
  state in the *_snapshot_branch_stack() helpers. (Sashiko)
- Patch 10: Rename __lbr_stack[] to __bhrb_stack[] and the related
  helpers accordingly, to stay consistent with the original powerpc code.
- Patch 14-16: New patches. Fix lbr_users/lbr_pebs_users not being
  accounted correctly in several corner cases. (Sashiko)
- Patch 17-19: New patches. Fix the non-PEBS LBR stack being overwritten
  by the PEBS LBR stack in two corner cases. (Sashiko)
- Patch 24: New patch. Fix the PERF_METRICS overflow bit not being
  cleared correctly.

Changes in v6:
- Patch 01: Move LBR stack depth validation into common
  init_hw_perf_events(). (Peter)
- Patch 10: New patch, add __counted_by() tracking for flexible array
  entries[] of perf_branch_stack{}. (Peter)
- Patch 14: Refresh LBR stack only when LBR users are active for AMD.
  (Peter)
- Patch 15: Refactor code to ensure no duplicated LBR stack reading.
  (Peter)
- Patch 16: New patch, remove dead lbr_pebs_users.

Changes in v5:
- Patch 02: Clear xsave->header.xfeatures before calling the xsaves
  instructuion to read LBR states.
- Patch 05-18: New patches to fix newly discovered issues described above.

Changes in v4:
- Patch 01: Disable LBR if parsed x86_pmu.lbr_nr exceeds
  MAX_LBR_ENTRIES (Sashiko).
- Patch 05: New patch, which always snapshots live hardware LBR stack
  for BPF path (Sashiko).

Changes in v3:
- Patch 01: A new patch to ensure x86_pmu.lbr_nr not to exclude
  MAX_LBR_ENTRIES (Internal Sashiko).
- Patch 03: Clean cached LBR stack when reseting hardware LBR registers,
  which prevents stale LBR stack leakage.
- Patch 04: Don't reset cached LBR stack if all LBR events are PEBS
  events. This ensures PEBS captured LBR stack isn't cleared (Sashiko).

Changes in v2:
- Include a fix for Intel LBR.
- Add Tested-by from Dapeng to the Intel fix.
  https://lore.kernel.org/all/eb6c7bda-0dcf-4fac-ad69-9f5b24abc21b@linux.intel.com/

History:
v6: https://lore.kernel.org/all/20261106043257.842864-1-dapeng1.mi@linux.intel.com/ 
v5: https://lore.kernel.org/all/20261029043914.1395147-1-dapeng1.mi@linux.intel.com/
v4: https://lore.kernel.org/all/20261021050711.4043703-1-dapeng1.mi@linux.intel.com/
v3: https://lore.kernel.org/all/20261019070836.2972403-1-dapeng1.mi@linux.intel.com/
v2: https://lore.kernel.org/all/cover.1792064123.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/20261007181002.4005262-1-sandipan.das@amd.com/ 


Dapeng Mi (23):
  perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES
  perf/x86/intel: Validate LBR XSAVE state before updating LBR stack
  perf/x86/intel: Limit branch snapshots to valid entries
  perf/x86: Add lbr_enabled to track LBR state
  perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled
  perf/x86/intel: Add helper to enable PMU without LBR
  perf/x86/intel: Avoid re-enabling PMU and LBR for BPF when disabled
  perf/x86/intel: Keep LBR frozen throughout PMI handling
  perf: Add counted-bounds tracking for perf_branch_stack
  perf/x86/intel: Allow LBR read helpers to operate on explicit stacks
  perf/x86/intel: Use a dedicated LBR stack for BPF snapshotting
  perf/x86/intel: Always snapshot live hardware LBR state for BPF
  perf/x86/intel: Account lbr_pebs_users for arch-PEBS events
  perf/x86/intel: Set PERF_EV_CAP_SIBLING for pure branch counter events
  perf/x86/intel: Account LBR user counts for pure branch counter events
  perf/x86/intel: Refresh LBR stack for non-PEBS LBR events when needed
  perf/x86/intel: Fix draining of un-overflowed PEBS buffer in PMI
    handler
  perf/x86/intel: Drain PEBS buffer for branch events with PEBS LBR
    users
  perf/x86/intel: Clear raw LBR counters in the LBR stack
  perf/x86/intel: Refresh LBR stack for LBR counter events in PMI
    handler
  perf/x86/intel: Pass LBR stack size into intel_pmu_store_lbr()
  perf/core: Don't mutate shared branch stack depth
  perf/x86/intel: Fix incorrect PERF_METRICS overflow bit clearing

Sandipan Das (1):
  perf/x86/amd/lbr: Limit branch snapshots to valid entries

 arch/powerpc/perf/core-book3s.c   |  47 ++++--
 arch/x86/events/amd/brs.c         |   7 +-
 arch/x86/events/amd/core.c        |  25 +++-
 arch/x86/events/amd/lbr.c         |  48 ++++---
 arch/x86/events/core.c            |   8 +-
 arch/x86/events/intel/core.c      | 231 +++++++++++++++++++++++++-----
 arch/x86/events/intel/ds.c        |  31 ++--
 arch/x86/events/intel/lbr.c       | 169 +++++++++++++---------
 arch/x86/events/perf_event.h      |  52 ++++++-
 arch/x86/include/asm/perf_event.h |   1 +
 drivers/perf/arm_brbe.c           |   5 +
 include/linux/perf_event.h        |  15 +-
 kernel/events/core.c              |   8 +-
 kernel/trace/bpf_trace.c          |   6 +-
 14 files changed, 477 insertions(+), 176 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1


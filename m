Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940042;
	b=rC5sbdbfBdypHTRn8QOINd/MX5wVhqqo4VsfQr/N/51Yq5+pBWpf/cHhE/TSEidQf+3Q
	 3Jo7abQ6nVb7SuQzjgBKmDycIdYS7aS+GjL9ofKgeB7AfPFPOv3onWlhAWCwFSqcovO+t
	 +CR/DO2jNnO2Raqb9VNLn4yoEFGN76jfpRbcPRDNY4a87ndMAK/wbYUwpB5vMVdK6CEoe
	 lnF68bcIfConvVT/c74Tyv5X9XRHhOEQcZ3PhygxkCLClUjocDn3wXpGlLIufbzshBm1E
	 NcBkpEP/SewPaIJ8WjSrkfYrOnrDtA7KaevKmet2FC8JFRpHAfCF3bwysGKEo7DEd8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940042;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=38xsRjUVpTk5MTWYXOKfHxRiYMYC1FW8wR80sH53ays=;
	b=0/gmp0nrj4ZEhWPjhNYVrM80KBKpZoN1RsJ1mbt0GHsbZGfZRQj65qh42FD5M/Uq33M7
	 NWn6Gxx5jY0b5XKzmKmZ2yvMhjhSuTLiMydzjL9sAAPCRXiaHWsYTcygaVtmOOY9hJbQc
	 zQXKzL+cixfpFA0CcyAFsLzwGjicH7/Ze3Tx2zfsYQCGtRj2Gp1saY/jVL14ViCk0D0Yh
	 wflhzqp0K5KsZDbzYD/K4xo+4FLlaSEsi4xmMY0DyFHpflq5v1Gncpw+xzkpcQ4OeuqlT
	 XPgbPk2q1pE9kOqwJ1iKf8BNM4qul/9aMKiq94sUoQsDaJ1GZk+20a6wUxP11eXg/3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N4dZLN5c;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADCF606A31B;
	Fri,  6 Nov 2026 04:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ADCF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N4dZLN5c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940042; x=1825476042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yUmvJS23SZ9gjuUYLE7qxDR+CEmbJJZlZ9g9vdHfK98=;
  b=N4dZLN5c2qAS7h+27beC7KLl55u4mwGJZCu5haUHDQu/dST0gfnuBV1V
   s45evkjnobfJlDkawNlYokfaiYE5lkCpgouMkFsigcOqle/Ilvgen4Iuf
   2OMmEe/1JpNfvh6ysd9jYfFK7VjqsCCi1e4WcpcuF+owzdVflR1kzLvvM
   Vk3U97Dx6CKfJu37lxZ45yki7Qs9+5QYw5CyvrZWr/mNNq6g+usc1UTbU
   s0a+nfJPHm3S3+TeP59DRQ922iuHwSO7o4NEPO3UIFNCgkf0vjuT+4RSv
   lZ2myoFqfYopF+Qnx/cgRXf/llL/vOpiPEYRn6HGMDHzvF+0mlBF7yN4T
   Q==;
X-CSE-ConnectionGUID: h24fZhCORvmjEoCjHkH9Sw==
X-CSE-MsgGUID: njBbnrPeTCOO2+raDhT8ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780731"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780731"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:40:40 -0800
X-CSE-ConnectionGUID: cXotcSjCRTeRS3FAMHIR+g==
X-CSE-MsgGUID: j+tgGIM3Rg+sR+YqBbu63A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222801"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:40:35 -0800
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
Subject: [Patch v6 00/20] perf/x86: Fix multiple LBR sampling issues 
Date: Fri,  6 Nov 2026 12:32:37 +0800
Message-Id: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
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
- Patch 01: Add a sanity check to ensure the LBR stack does not exceed
  MAX_LBR_ENTRIES.
- Patch 02: Validate that hardware LBR data has actually been stored in
  the XSAVE area before parsing it.
- Patch 03-04: Fix the potential LBR stack out-of-bounds access issue on
  AMD and Intel separately.
- Patch 05-08: Fix the incorrect PMU and LBR re-enabling issue
  in perf_snapshot_branch_stack() for AMD and Intel separately.
- Patch 09: Freeze LBR throughout the PMI processing period and ensure
  all LBR events observe a consistent LBR stack in the PMI handler.
- Patch 10: Add counted bounds tracking for perf_branch_stack{}.
- Patch 11-12: Add a dedicated LBR stack for BPF LBR snapshotting to avoid
  overwriting the default LBR stack of other LBR events.
- Patch 13: Ensure perf_snapshot_branch_stack() snapshots the live
  hardware LBR data instead of the cached PEBS LBR stack.
- Patch 14: Refresh LBR stack in PMI only when LBR users are active for
  AMD.
- Patch 15: Prevent PEBS LBR data from overwriting non-PEBS LBR data when
  both overflow in the same PMI.
- Patch 16: Remove dead lbr_pebs_users and relative code.
- Patch 17-18: Ensure LBR counters are not dropped when multiple LBR
  counter events overflow in the same PMI.
- Patch 19: Clamp the parsed PEBS LBR stack depth to x86_pmu.lbr_nr to
  avoid LBR stack out-of-bounds access.
- Patch 20: Fix the shared LBR stack depth truncation issue.


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
v5: https://lore.kernel.org/all/20261029043914.1395147-1-dapeng1.mi@linux.intel.com/
v4: https://lore.kernel.org/all/20261021050711.4043703-1-dapeng1.mi@linux.intel.com/
v3: https://lore.kernel.org/all/20261019070836.2972403-1-dapeng1.mi@linux.intel.com/
v2: https://lore.kernel.org/all/cover.1792064123.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/20261007181002.4005262-1-sandipan.das@amd.com/

Dapeng Mi (19):
  perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES
  perf/x86/intel: Validate LBR XSAVE state before updating LBR stack
  perf/x86/intel/lbr: Limit branch snapshots to valid entries
  perf/x86: Add lbr_enabled to track LBR state
  perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled
  perf/x86/intel: Add helper to enable PMU without LBR
  perf/x86/intel: Avoid re-enabling PMU and LBR for BPF when disabled
  perf/x86/intel: Keep LBR frozen throughout PMI handling
  perf: Add counted-bounds tracking for perf_branch_stack
  perf/x86/intel: Allow LBR read helpers to operate on explicit stacks
  perf/x86/intel: Use a dedicated LBR stack for BPF snapshotting
  perf/x86/intel: Always snapshot live hardware LBR state for BPF
  perf/x86/amd: Refresh LBR stack in PMI only when LBR users are active
  perf/x86/intel: Refresh LBR stack for non-PEBS LBR events when needed
  perf/x86/intel: Remove dead lbr_pebs_users
  perf/x86/intel: Clear raw LBR counters in the LBR stack
  perf/x86/intel: Refill LBR stack for LBR counter events in PMI handler
  perf/x86/intel: Pass LBR stack size into store_lbr()
  perf/core: Don't overwrite shared LBR stack depth

Sandipan Das (1):
  perf/x86/amd/lbr: Limit branch snapshots to valid entries

 arch/powerpc/perf/core-book3s.c |  43 +++++---
 arch/x86/events/amd/brs.c       |   7 +-
 arch/x86/events/amd/core.c      |  21 ++--
 arch/x86/events/amd/lbr.c       |  48 +++++----
 arch/x86/events/core.c          |   8 +-
 arch/x86/events/intel/core.c    | 130 ++++++++++++++++++++----
 arch/x86/events/intel/ds.c      |  20 ++--
 arch/x86/events/intel/lbr.c     | 170 +++++++++++++++++++-------------
 arch/x86/events/perf_event.h    |  45 +++++++--
 drivers/perf/arm_brbe.c         |   5 +
 include/linux/perf_event.h      |  15 ++-
 kernel/events/core.c            |   8 +-
 12 files changed, 365 insertions(+), 155 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1


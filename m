Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249202;
	b=qqC8cE3ue5dRPd22IHZYgMDuAcskxjsMe4Gs6ayvF+bTjm/NRYbX4BRsq7O9X4xoYGwV
	 zDcw5f+YfhOiCONLLDa3riLehQBS6Q8VIk8IBX47BBAe7IZA5UnTImuKvUe2QT1LYkEOx
	 dlAksMohYV/g5ZOqBwmF/dp2KJ/IzsC5QngVFhCEX7b6sYLzhMdtK9ds5rn0PBjAfB0+k
	 GLqmKJW1kkI7NAMZdMFAoS4mfKQFSq+diu/YIJMPypLv9jjqe0KSw/A5rhzpe9/+2m8td
	 lp7vfyduCxMd7MYbClZETv3j+COYulndphVq9QGpm/5tuCprWvYTRsMXCMMA7qqd88g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249202;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Y2o198E26FAlfTkjFfsC0iQmZ98M3KTdQdNft0/pmoc=;
	b=RqLIrXeUqAaUYskfXpf2MgaSdCIlV4/hNo++dQOBSzveBeMg1gzbZm8P71d7znLh5Zdw
	 KDDZ4/9eE16HUGtOL4xRq54konJ+Jdmo45hN6fiGMemLeJ57vMJzvRhzsThBIEZhGGTFV
	 qps54QGtgUOqJR4pKQgIU8NF8G1piUmW4KlkTYyr3Sj4w3PXyx2ATE8o9DAcAcMKZAaJa
	 e5Wq/3AqeMsSXx2BA2nPztIBKSrEJyEjMdjshSoOu2KkiOlQZ89zF48MkihLX/sFCyNhg
	 PRIB/Gf5KqbSljrFV65Il+qI2IM8bMbXFEPjrzcWcPds6MT2Ptpjy1SPTZaLlJFTC6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZLdNaYCO;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091D1606A320;
	Thu, 29 Oct 2026 04:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 091D1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZLdNaYCO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249201; x=1824785201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kio+VRP8n7+59UZeI7uSw5XTIRYDrOcpqAyJgN4Qixs=;
  b=ZLdNaYCO6vrdlGC4swWsCfzdUkdC/5GlmEdURiYXa+QwzxvI9oF8GGDh
   CPG65/ep7J3+d2Sml4Pb3l/AdGXhEWPvlejCXYjM66z4s7cPt8Yrhf27S
   OIUw3QN1zArAb0PIeHM5Vlrv4odz1fGNcJIHE77dKiq9j8RFnkDiIKE9I
   erGJJjWao6zrW/VhiQrnGHo5BOL6IQJnq8D99fpf7DM1diBKtD8oSGXvn
   0Gk/0DRicfNSlJyAWgyXTocLvz3iezCrCImbnsFjalKdjWpI3GRMC8Cpx
   cKJux3y71Ib2+0HfSL202BeLd9T4lNdysAtNxVim/sxSFo11DUCsLZWiT
   A==;
X-CSE-ConnectionGUID: m3BUEqpsS3qcx2Eun7NxxQ==
X-CSE-MsgGUID: ttRoNxk7R/KY3kvlST2rEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986235"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:46:41 -0700
X-CSE-ConnectionGUID: 3nBG2jZeREqlVeoclZCnCg==
X-CSE-MsgGUID: tPiFwaPjSFqcYfXKKHQomw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420259"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:46:36 -0700
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
Subject: [Patch v5 00/18] perf/x86: Fix multiple LBR sampling issues
Date: Thu, 29 Oct 2026 12:38:56 +0800
Message-Id: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
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
- Patch 10-11: Add a dedicated LBR stack for BPF LBR snapshotting to avoid
  overwriting the default LBR stack of other LBR events.
- Patch 12: Ensure perf_snapshot_branch_stack() snapshots the live
  hardware LBR data instead of the cached PEBS LBR stack.
- Patch 13: Prevent PEBS LBR data from overwriting non-PEBS LBR data when
  both overflow in the same PMI.
- Patch 14: Add the missing lbr_pebs_users accounting for arch-PEBS.
- Patch 15-16: Ensure LBR counters are not dropped when multiple LBR
  counter events overflow in the same PMI.
- Patch 17: Clamp the parsed PEBS LBR stack depth to x86_pmu.lbr_nr to
  avoid LBR stack out-of-bounds access.
- Patch 18: Fix the shared LBR stack depth truncation issue.


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
v4: https://lore.kernel.org/all/20261021050711.4043703-1-dapeng1.mi@linux.intel.com/
v3: https://lore.kernel.org/all/20261019070836.2972403-1-dapeng1.mi@linux.intel.com/
v2: https://lore.kernel.org/all/cover.1792064123.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/20261007181002.4005262-1-sandipan.das@amd.com/

Dapeng Mi (17):
  perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES
  perf/x86/intel: Validate LBR XSAVE state before updating LBR stack
  perf/x86/intel/lbr: Limit branch snapshots to valid entries
  perf/x86: Add lbr_enabled to track LBR state
  perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled
  perf/x86/intel: Add helper to enable PMU without LBR
  perf/x86/intel: Avoid re-enabling PMU and LBR for BPF when disabled
  perf/x86/intel: Keep LBR frozen throughout PMI handling
  perf/x86/intel: Allow LBR read helpers to operate on explicit stacks
  perf/x86/intel: Use a dedicated LBR stack for BPF snapshotting
  perf/x86/intel: Always snapshot live hardware LBR state for BPF
  perf/x86/intel: Refresh LBR stack for non-PEBS LBR events if needed
  perf/x86/intel: Account arch-PEBS in lbr_pebs_users
  perf/x86/intel: Clear raw LBR counters in the LBR stack
  perf/x86/intel: Refill LBR stack for LBR counter events in PMI handler
  perf/x86/intel: Pass LBR stack size into store_lbr()
  perf/core: Don't overwrite shared LBR stack depth

Sandipan Das (1):
  perf/x86/amd/lbr: Limit branch snapshots to valid entries

 arch/x86/events/amd/core.c   |  14 +++-
 arch/x86/events/amd/lbr.c    |  14 +++-
 arch/x86/events/intel/core.c | 135 ++++++++++++++++++++++++++-----
 arch/x86/events/intel/ds.c   |   8 +-
 arch/x86/events/intel/lbr.c  | 153 ++++++++++++++++++++++-------------
 arch/x86/events/perf_event.h |  37 +++++++--
 include/linux/perf_event.h   |  13 ++-
 kernel/events/core.c         |   8 +-
 8 files changed, 285 insertions(+), 97 deletions(-)


base-commit: f5a78ecccd98a04c47cea1cd63c2a2fdce8a4b48
-- 
2.34.1


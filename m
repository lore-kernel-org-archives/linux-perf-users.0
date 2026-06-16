Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE571448E0;
	Tue, 16 Jun 2026 04:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585547; cv=none; b=ukf4j3FttGAkCCcPUqv4GFcsYRzXS3ASpb8RxpNmGNDgYkYM+vI/XhU7Jd33QvPHTGCLkRwSqKEF71ZPcNl/v/HygAjDuPzYNx39wUHCNWu8M1UHV4OC9oNNsuYmusrvckr1bas1Ul4zGuFTWXxnLX4C/Yfh4juERUhSICHj0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585547; c=relaxed/simple;
	bh=+/ZA1GRuyDQ/Y9+X7EtGScjkMnHeS6JaSAmm9hQyDuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fU6DfNOtyHjMDkzM/HZ0Xc38q5P8a4ZiIMEYPxjV14bidB6uVl8t0S0Bmb+BR+G/UagoqDsiUbs44DUIamL2Pm04cOfSr5Tx08ISgaGYdntBHtU77AOYknAp9jdw5wYkAJ0BN4rFzeaF9rdg6KFTAYfSGE2/04O76p+QmpnIQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFUaLGRL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFUaLGRL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781585546; x=1813121546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+/ZA1GRuyDQ/Y9+X7EtGScjkMnHeS6JaSAmm9hQyDuo=;
  b=UFUaLGRL37S9HDVdXbb7cTp9iz5b00bNfTcIbki4KVCyOjTlFwvm/vml
   rb0QIZzUkjc1yZMEM6XWhDmBKBBG1YQkp+8e6XXsoPCWFehK6s7K/MS8g
   PieCfO61f1EzImMAiq5CB3M6fA68DngFbhUvCEKEkB32uniugYcxFm8vQ
   CvX5huSYr5y7xdYLoS5R/d5UEbhTrusoXzJPt4X77VP2r8DozMI4VpD5I
   cOI1ZBOMmPaC8gslztYCTDX4xYvx3aYTipVTpgNnTAEAqIdVpkJPUd4pn
   fwoGQ5x3S86bE1+kb/7vVUPY3ZEjHh/IAyEAEnbjftAczirrqO7YBr8T1
   Q==;
X-CSE-ConnectionGUID: CEeLD6PIQeyAOXdDHS143g==
X-CSE-MsgGUID: 6chlIN28SHGW6HVFh3IWLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82445359"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82445359"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 21:52:25 -0700
X-CSE-ConnectionGUID: 4IwaJmlmQ4y9VTTKNyRPxA==
X-CSE-MsgGUID: VspHv4DNSR6GPR8DkcTj7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271726187"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jun 2026 21:52:21 -0700
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
Subject: [Patch v4 0/8] perf/x86: Miscellaneous PMU bug fixes
Date: Tue, 16 Jun 2026 12:46:46 +0800
Message-Id: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series groups several independent PMU fixes to simplify review and
backporting.

Changes:
v3 -> v4:
- Patch 5/8: Move intel_pmu_arch_lbr_init() before
  intel_pmu_check_event_constraints_all() which depends on
  PMU_FL_BR_CNTR flag which is initialized in intel_pmu_arch_lbr_init()
  (Sashiko).
- Refine change log, remove markdown format (Peter).

v2 -> v3:
- Patch 2/8: Directly update PERF_EVENT_FLAG_USER_READ_CNT according to
  rdpmc user disable state (Peter).
- Patch 3/8: Only keep x86_lbr_type check for the detection of hardware
  branch type decoding (Peter).
- Patch 4/8: Switch from_plm and to_plm variables order and refine
  comments (Peter).
- Patch 5/8: Move intel_pmu_arch_lbr_init() after model-specfic PMU
  initialization to avoid extra kmem cache destroy (Peter).
- Patch 6/8: Improve change log to add more details (Peter).

v1 -> v2:
- Fallback to software branch type decoding if hardware decoding is not
  suppprted (Sashiko patch 4/9).
- Drop kernel IP for PERF_SAMPLE_IP if exclude_kernel attribute is
  required (Sashiko, patch 8/9).
- Add kernel access check when kernel callchains are requested
  (Sashiko, patch 9/9)
- Address Zide and Thomas's comments.
- Collect Reviewed-bys.

Patch layout:
- Patch 1/8: Fix anythread_deprecated being overwritten issue. 
- Patch 2/8: Fix the issue that cap_user_rdpmc is not updated correctly.
- Patch 3/8: Fallback to software branch type decoding if no hardware
  decoding.
- Patch 4/8: Fix the kernel address leakage issue in LBR stack.
- Patch 5/8: Fix the issue that the return value of
  intel_pmu_init_hybrid() is not valiated correctly.
- Patch 6/8: Fix a "unchecked MSR access error" on PEBS_ENABLE MSR.
- Patch 7/8: Prevent a theoretical kernel register data leak in sampling.
- Patch 8/8: Add kernel access check when kernel callchains are
  requested. 

History:
v3: https://lore.kernel.org/all/20260612090114.3188886-1-dapeng1.mi@linux.intel.com/
v2: https://lore.kernel.org/all/20260609050222.2458129-1-dapeng1.mi@linux.intel.com/
v1: https://lore.kernel.org/all/20260605011136.2043393-1-dapeng1.mi@linux.intel.com/


Dapeng Mi (8):
  perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
  perf/x86/intel: Keep cap_user_rdpmc in sync with RDPMC user-disable
    state
  perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
  perf/x86/intel: Fix kernel address leakages in LBR stack
  perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()
  perf/x86/intel: Drop fixed-counter PEBS constraints for baseline PEBS
  perf/core: Fix kernel register info leak via hardware skid
  perf/core: Check kernel access when kernel callchains are requested

 arch/x86/events/core.c       |  3 +-
 arch/x86/events/intel/core.c | 60 +++++++++++++++++++++---------------
 arch/x86/events/intel/ds.c   | 13 --------
 arch/x86/events/intel/lbr.c  | 14 ++++++---
 arch/x86/events/perf_event.h |  4 +--
 kernel/events/core.c         | 41 +++++++++++++++++++-----
 6 files changed, 83 insertions(+), 52 deletions(-)


base-commit: 67d27727854def4a7e2b386429941f5c4741ccc4
-- 
2.34.1


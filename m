Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FE38238D;
	Fri, 12 Jun 2026 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255193; cv=none; b=Vj7wCPYhu2GcLMTmYeMVJucZV6gAGj4nQ9lZaUR6EDnt3m23OqJCm8XkxPxa+UE881U162S1UZCgEkVKGw1+zNgM5pIsPczejnzYAQQHWarod/SposozLqZ9g5ScUW9Ek47oXzLa856XeGmxG8RhOI1PrGrus6SX2/NFdih38MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255193; c=relaxed/simple;
	bh=NS2sEonnMSr3hZ09JbV3khvKmENt4dvdQ+R+ou1FK44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ThW4GEBhG4zwo6RT/m5/HHcjjmt1U4wsmO+RvV+20k1TiGjjEjRJnfZXL+wUZHOacJL80drr8SYAt9e4mFCOqYGQjpAxCos/bRu2UU5DMVpzyBZPq/AGlgwArlvtVroK1BwVptRC9Ih8vXRMerXrfkDSRJVI2/LMY0CZ6qIHFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fsg5Jp33; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fsg5Jp33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781255191; x=1812791191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NS2sEonnMSr3hZ09JbV3khvKmENt4dvdQ+R+ou1FK44=;
  b=Fsg5Jp33XuHZ39JUDN/f634UqGRJXHnXK+Idr3VoH+Z7e0pxrT8FubL5
   G63CqCRd5JKboftSx9ruKUsaJybHJxIJBnG1hq6RJqGx18hmANUshP5Fk
   yxaJWvyv/G9LJLjOeD1iYHDXrz8Awldjr2lXVNT6gWKHoH4DU8iM/o/4g
   i191ol7h9qleWNSqN+Jy7ieJGN4TfINlWWmV1A8hpIuMMDXqFIQ1/eT6q
   A87lN3mOfGB3oQky1ARk6wvZqckqv0R+t6KV3SDvtCuk5EHuVJNZ4lAxI
   Vkn5Hw7K9r1QtmkpGEVvxGpFnFejoQe82La2OAUmyA2zWxk+3AvX3JfYn
   g==;
X-CSE-ConnectionGUID: sKIyqVT0QJizVfL/VK5gCQ==
X-CSE-MsgGUID: 2oZHNyqkQcWa2DNaUO0Q6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85714423"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="85714423"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:06:30 -0700
X-CSE-ConnectionGUID: 1UPE168ZTpW9no3QXBVQCg==
X-CSE-MsgGUID: 2HHYZPW3Ty2vqMCpGe0UvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246838615"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 12 Jun 2026 02:06:26 -0700
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
Subject: [Patch v3 0/8] perf/x86: Miscellaneous PMU bug fixes
Date: Fri, 12 Jun 2026 17:01:06 +0800
Message-Id: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
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


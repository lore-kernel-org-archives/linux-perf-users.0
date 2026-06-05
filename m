Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754F376A04;
	Fri,  5 Jun 2026 01:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622213; cv=none; b=n4TkgDy+anxiomrNEpfWzV7pXgRPLKKsFHIr4/MUbTat7z8e4GTYaDpfdE4ifK8xlKKqgchYxC6g1sU4O4njKYfkRwD85nqvu2Ep2HIeLWKcu8zz0l2wR/7+mT77J4+272fUpDBjKVT6s4H3hVI6tsOvHq+9hjZ1OIFwj3ZCbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622213; c=relaxed/simple;
	bh=0+r7LrysQDHz4PHCLCsBiSXlUYCC8JOmOxu8BwaQ3Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jk1IvLDB4gJ7qfaN2/8ASJpFx48g0q4jqK7qzxIdJIf2UvF3mM3n7Sdf4Mugeiv01iw6oSNFWN7aDof7ll6OvFc5A2IiazPUyQG/V2LY2Suush8bBn9Fs+QWMcKsu4luYDCMWIESgTrtJBqFUh7rCrq1XW1yntd3vG/OQDXmSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAmAPiHA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAmAPiHA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780622208; x=1812158208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0+r7LrysQDHz4PHCLCsBiSXlUYCC8JOmOxu8BwaQ3Y8=;
  b=ZAmAPiHALtI8OtBNBolltoRuKVJ+NPbFPF2PODpcmrl6WVmOwHfv7RCo
   CORKqWJ7As+WESww76SGx0/fjW8eGLnbvl0IOjffMad7w5hsoKylTuCc5
   0f6YhPvGF4FKlImdwkI1542Gfv16CFuzQjoZ1pwyeFGyzE9UJNUNFODlI
   b0GmixPnzNlmvNVqTl/UVnVmur3WM7Xn68wbxgmQKYNgbAnK+ZiPcJAyH
   gb31SaBrS1cnkEKKc5Is8NqnknVpL76nF4OU/bcLHL2rAeedsT8WR02hz
   fmkEQPgz9y77y0FEGMw//q3mBKLZiZFCTVUufW83TZXD7byaoPon1Dlhl
   w==;
X-CSE-ConnectionGUID: JZz+t+8CSQS6+u2mx98Vfg==
X-CSE-MsgGUID: vFf5XoO1TjO2zFzmkoOV4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91772170"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="91772170"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 18:16:47 -0700
X-CSE-ConnectionGUID: chE/qzbAS1qOOk4Zrtr+jw==
X-CSE-MsgGUID: qY4SvTL3QACc0Gy1TyXgGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244817103"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 04 Jun 2026 18:16:45 -0700
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
Subject: [PATCH 0/8] perf/x86: Miscellaneous PMU bug fixes
Date: Fri,  5 Jun 2026 09:11:28 +0800
Message-Id: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
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

Patch layout:
- Patch 1/8: Fix anythread_deprecated being overwritten issue. 
- Patches 2-3/8: Fix the issue that cap_user_rdpmc is not updated
  correctly.
- Patches 4-5/8: Fix a kernel address leakage issue in LBR stack.
- Patch 6/8: Fix the issue that the return value of
  intel_pmu_init_hybrid() is not valiated correctly.
- Patch 7/8: Fix a "unchecked MSR access error" on PEBS_ENABLE MSR.
- Patch 8/8: Prevent a theoretical kernel register data leak in sampling.


Dapeng Mi (7):
  perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
  perf/x86: Update cap_user_rdpmc base on rdpmc user disable state
  perf/x86/intel: Fix redundant branch type check in
    intel_pmu_lbr_filter()
  perf/x86/intel: Fix kernel address leakages in LBR stack
  perf/x86/intel: Validate return value of intel_pmu_init_hybrid()
  perf/x86/intel: Drop fixed-counter PEBS constraints for baseline PEBS
  perf/core: Fix kernel register info leak via hardware skid

Ian Rogers (1):
  perf/x86: Introduce is_x86_pmu() helper

 arch/x86/events/core.c       | 19 +++-------------
 arch/x86/events/intel/core.c | 43 ++++++++++++++++++++++++------------
 arch/x86/events/intel/ds.c   | 13 -----------
 arch/x86/events/intel/lbr.c  | 13 ++++++++---
 arch/x86/events/perf_event.h | 25 +++++++++++++++++----
 kernel/events/core.c         | 20 +++++++++++++----
 6 files changed, 79 insertions(+), 54 deletions(-)


base-commit: 66cc29745f2f5815482587bb9fbc1e8a3e6fcf00
-- 
2.34.1


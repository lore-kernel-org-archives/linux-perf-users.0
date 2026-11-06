Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940076;
	b=x8BVYQ3O4F4fxEqdxs4KtPCp7kNJK13L8f35LCEu9jHdGrOa9YOkZ463YlkmVaIsAv7Z
	 zSNd38Z6XH0/P5MZtRjc5yejQrCGvNjfVPYrJ5oPvsosZWwjOSIszC2rvnKySzhugK8xc
	 YLl8hs1uK2qfekG+kfMTUgnvWzVFaFUcQnn/tTfd57x8bZpsnRQcnbwOhHagWZOuk0fP4
	 5V/jPsqMvYEIc0nccSCw52tfFbQ4RQ3r1UDSaHM0+AexsZEoAEucp4VIBpIj6ixGI+frf
	 dw1UN7K7yckiMP+cyvELcs4dBocO5oAhZ+ohoX7F+/JTEVLik3RfUFJdLAYZw+aUJBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940076;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9+yC9rQMX+LaPyTPb7UmOWb3faqRuSDuRnFBorCkXd4=;
	b=s4M6jBecMvSYpvTSDviQ5t+MF5/eS4/QTzAiu4L5BylD+chbXzPulO3SlnP7h5pJNh/1
	 EUXV1yulodtROsBLVZjLA5xHLOimk5r4tABLs9EzDC52qXPx+IxQreVNbr+Ad7jtXSejG
	 VtYnNLjFLNZVVPyZWmTZ9aMwsg1sNektOmOV4sCf5fm6SwxgGfyBxhI+/QRAHA693EvlO
	 G2hNik2YBnlhrexnf1jtANBmR8rX22lk8Zxw56xPnhL96ukVxhZJk4RmoWDGqrcgYpqqE
	 GhYWc0AzuexiJuxrSybByXfgVV5vTaPKVj6kNW2NO5iUbMYv4qJyMi9OWz4voDA5SMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gHGUY04i;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1B606A33A;
	Fri,  6 Nov 2026 04:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D1B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gHGUY04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940076; x=1825476076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUq0X+Oajj00m0wZ/A9pWX24JHnFo9sl2iHA1XHB9xc=;
  b=gHGUY04iCUrHAK0fnzQbTqt8KKz0EVOqFroGlt8/Ns1NJ6YM4XlqLwoU
   Yw/d5RlcsZwsq8a1Jh2d9UQlhPcD+cOUVXuiNuySPHsHi/sDc1vVDlXkW
   qA1WqlcDSs50C0phDau1LaOPDiCIARsXsDo4XcosBzvtMCyyvLIfiMFtk
   WGrhHIjNm1h5D6QTccaktTkWu7+nlJ/fsjcZXqWepReiEbX5KwMrppcdf
   dgAUEVMuOzzEfEKwSCPqZDYgPlGD/VozJ6XyyK5KAG4ZUduQKWNwldnX7
   gGm6/NdwPYmXJKks2Uy9Bo1VePk+MwJ7TOwgEGbOlBLhPR2iZ/1CNrLWk
   g==;
X-CSE-ConnectionGUID: YHaN9x8LSzikFmcf6m1m0g==
X-CSE-MsgGUID: KPP9tv9TRVGpYxSPpKo2GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780813"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780813"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:16 -0800
X-CSE-ConnectionGUID: brL67LLVQd+KMGNUY7mETA==
X-CSE-MsgGUID: 6FNLuesPQ6mylfv4kxl8xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222919"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:11 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v6 08/20] perf/x86/intel: Avoid re-enabling PMU and LBR for BPF when disabled
Date: Fri,  6 Nov 2026 12:32:45 +0800
Message-Id: <20261106043257.842864-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
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

__intel_pmu_snapshot_branch_stack() currently re-enables the PMU and LBR
unconditionally even when they were already disabled in PMI context.
This can cause events such as cycles and instructions to be counted
while the PMI handler is running, which is not intended.

Only restore the PMU and LBR on the BPF path if they were originally
enabled.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 38 ++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9d8398da1989..739c454827ac 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2821,7 +2821,8 @@ static void intel_pmu_enable_all(int added)
 
 static noinline int
 __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
-				  unsigned int cnt, unsigned long flags)
+				  unsigned int cnt, unsigned long flags,
+				  int pmu_enabled, int lbr_enabled)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
@@ -2829,7 +2830,22 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
 
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
-	intel_pmu_enable_all(0);
+
+	/*
+	 * Do not blindly call intel_pmu_enable_all() to re-enable LBR.
+	 * This path may be entered from the PMI handler through
+	 * bpf_overflow_handler().
+	 *
+	 * If PMU version < 4, LBR is disabled by the LBR freeze mechanism,
+	 * LBR can't be re-enabled here.
+	 * If PMU version >= 4, LBR is only frozen instead of disabled,
+	 * LBR should be re-enabled here.
+	 */
+	if (lbr_enabled)
+		intel_pmu_lbr_enable_all(false);
+	if (pmu_enabled)
+		___intel_pmu_enable_all();
+
 	local_irq_restore(flags);
 	return cnt;
 }
@@ -2837,27 +2853,41 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 static int
 intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
 {
+	struct cpu_hw_events *cpuc;
 	unsigned long flags;
+	int pmu_enabled;
+	int lbr_enabled;
 
 	/* must not have branches... */
 	local_irq_save(flags);
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+	pmu_enabled = cpuc->enabled;
+	lbr_enabled = cpuc->lbr_enabled;
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
 	__intel_pmu_lbr_disable();
 	/*            ... until here */
-	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
+	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags,
+						 pmu_enabled, lbr_enabled);
 }
 
 static int
 intel_pmu_snapshot_arch_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
 {
+	struct cpu_hw_events *cpuc;
 	unsigned long flags;
+	int pmu_enabled;
+	int lbr_enabled;
 
 	/* must not have branches... */
 	local_irq_save(flags);
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+	pmu_enabled = cpuc->enabled;
+	lbr_enabled = cpuc->lbr_enabled;
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
 	__intel_pmu_arch_lbr_disable();
 	/*            ... until here */
-	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
+	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags,
+						 pmu_enabled, lbr_enabled);
 }
 
 /*
-- 
2.34.1


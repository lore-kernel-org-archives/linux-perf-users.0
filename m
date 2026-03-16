Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5C1D514E;
	Mon, 16 Mar 2026 05:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773637969; cv=none; b=XCtKroXRUJi+GRL+hHzlwoXy+/yThNtysM3cLaQ4S8MtlZhv11Nf/vLiI2YZviEHdUd7VJDKGJGEsWh/dSLOZfpRMrR7h1PIBteluhzp82HrpbL8UHTX01L9QzgWBVsX047fbO9HDlS6y8UcjYNu5GqBUdEfoicmKcVfhcY/Tjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773637969; c=relaxed/simple;
	bh=47W9jyoxMSCiMVjvrYCtQ3AB54hMaUsgMFHIcI78p0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UY8h4w8Sk7BdpgPtu09W8Z1/EtsLsH4DiLMof6fOtJ6Oi9A8TfnJ+7fl+4gxT73T5s0ka+5cEha+3R2Sl8/K7DlysmRnFkgUq8Gr6w/hBNIAon7r7047YSfiuaM2Xzeebf78xL564T1F9bHMBMInpDh3yC1sBOzlHvMKKe7YUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlfR1eGz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlfR1eGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773637968; x=1805173968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=47W9jyoxMSCiMVjvrYCtQ3AB54hMaUsgMFHIcI78p0o=;
  b=HlfR1eGzi+2WQDi0lE/pEnqLYfefdX8zPkDCTNxO5zjJvyfwWukeQBwY
   V19iBEzYZnrvaUMbFVCJbKdKPBhpiTIMz+zgwDzdxiB5UTBbci/L9RL3v
   BWsPMcjwYeybR4xGop0Au6FlqkZu1T7wnQejtIsIOEbYDfId18NuXkn1a
   rlsnqo44GFi3Qunpwc8hukUc7oLt/qJxYgo2DkP1trliX4caXvnrfIx3o
   QOMKpLBmDP52VdU58g+sD136CxQlEG9OM/biPH0lkndXyVXYnwiN4Un0g
   RgvLqVwl9UoNOyFx+taxqHYuv3JaESA5RRw5K1C67F1kbsTEczQ5J9IQC
   A==;
X-CSE-ConnectionGUID: Dk21ZtlZSketbNLr7b7czw==
X-CSE-MsgGUID: PuvI//xMSBe9dqTs0P9eZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="86003459"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="86003459"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 22:12:46 -0700
X-CSE-ConnectionGUID: dawh2oPVSI6jDx+mVYEJjA==
X-CSE-MsgGUID: MzLbFFAwRr+q/3C4kaW7LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226262452"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 15 Mar 2026 22:12:43 -0700
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
Subject: [Patch v2 1/2] perf/x86: Introduce is_x86_pmu() helper
Date: Mon, 16 Mar 2026 13:08:37 +0800
Message-Id: <20260316050838.3624051-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

To facilitate the detection of x86 PMU structures in upcoming patches,
the is_x86_pmu() helper is introduced. Additionally, the is_x86_event()
helper has been refactored to utilize is_x86_pmu().

No function changes intended.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

v2: new patch.

 arch/x86/events/core.c       | 16 ----------------
 arch/x86/events/perf_event.h | 18 +++++++++++++++++-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 810ab21ffd99..66b1a873c395 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -774,22 +774,6 @@ void x86_pmu_enable_all(int added)
 	}
 }
 
-int is_x86_event(struct perf_event *event)
-{
-	/*
-	 * For a non-hybrid platforms, the type of X86 pmu is
-	 * always PERF_TYPE_RAW.
-	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
-	 * is a unique capability for the X86 PMU.
-	 * Use them to detect a X86 event.
-	 */
-	if (event->pmu->type == PERF_TYPE_RAW ||
-	    event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)
-		return true;
-
-	return false;
-}
-
 struct pmu *x86_get_pmu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..025f67726ecc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -115,7 +115,23 @@ static inline bool is_topdown_event(struct perf_event *event)
 	return is_metric_event(event) || is_slots_event(event);
 }
 
-int is_x86_event(struct perf_event *event);
+static inline bool is_x86_pmu(struct pmu *pmu)
+{
+	/*
+	 * For a non-hybrid platforms, the type of X86 pmu is
+	 * always PERF_TYPE_RAW.
+	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
+	 * is a unique capability for the X86 PMU.
+	 * Use them to detect a X86 event.
+	 */
+	return pmu->type == PERF_TYPE_RAW ||
+	       pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE;
+}
+
+static inline bool is_x86_event(struct perf_event *event)
+{
+	return is_x86_pmu(event->pmu);
+}
 
 static inline bool check_leader_group(struct perf_event *leader, int flags)
 {

base-commit: becb26c89be3a6448dcd92522894427544d5b091
-- 
2.34.1


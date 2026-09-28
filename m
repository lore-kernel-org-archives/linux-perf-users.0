Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEA4455603;
	Mon, 28 Sep 2026 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581845; cv=none; b=MKwatjdrAD3ycUuxqOhPwIKa3aUPI6NhEYlMLyvPgYORjlxhP9uSvMLfWScCNuryK7rC6EaPTh1i6RdyAQ+JR4gjMVyumo8CRMeFL4+yqZidlnXHn2xqfB+a9y+5yIp8G8K3eFJ12jvke++GuU1ABgHzlXjmr1U8HA3Z1aV49sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581845; c=relaxed/simple;
	bh=iNVH0lkGYO4fWgQD8peOI7RQ/f2nQs7XOgOzUY7wwnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkDo9zDRGcGLyF8PWeHVNorAVfr0LYqLWOP4Obt0KpYjvkruaxHPfDxR9rQp8kyiV0kB2gDHUZsP+kHCZAaXJ7LN7wGiZyjBzITj7aIAj/kqu170s7REEPj7N7MZNg7pdaF9/MEeOp9S8+n70US5wwAh6pKQHdQpzh3f+ezpzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnWaHrtA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnWaHrtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581844; x=1822117844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iNVH0lkGYO4fWgQD8peOI7RQ/f2nQs7XOgOzUY7wwnE=;
  b=fnWaHrtATUNajrgA93dww6Ouk1Mgcqj9Mp/sEQCCMLxE5GqgNh/Bwr9y
   skYTK+5ik0134Q+ZmorPnoF3MV3au52X15YvB0HOrUe8I+K/psaYnfaa4
   rV/8o0/yZFm5+kgK+Oa8t6c7zHPtW74kjkx1kFCwJ31zdmJ9+pbOHpLEF
   +BqAx+VYY9dn8cXXNvjx0ZSJYw4RB0QhUEtDv7CXMB+cQCTJdxi7t+yBp
   +SYYW6UMuLN+PofXazGMR1PbSXZNA6cAaG17MpIu7N1TQnz5W18basgkD
   MZOy2VvV1Xd2HcTiKV0lUQAzKGs0oXUEoZIZ3jt7+z0+kup2r4KZSYIWV
   A==;
X-CSE-ConnectionGUID: Irx3wrrRRIWVtX2AVPYUHA==
X-CSE-MsgGUID: BwwTuknURa6iqBARUeSCVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141399"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141399"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:50:44 -0700
X-CSE-ConnectionGUID: Ze4M+DY1R56g/e4Cmco9/w==
X-CSE-MsgGUID: xRgKMO9AQUm1qOg5nWhbXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024887"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:50:41 -0700
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
Subject: [PATCH 03/15] perf/x86/intel: Reset active_pebs_data_cfg on CPU teardown
Date: Mon, 28 Sep 2026 15:42:57 +0800
Message-Id: <20260928074309.898043-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuc->active_pebs_data_cfg tracks the PEBS data configuration currently
programmed into MSR_PEBS_DATA_CFG, and reprogramming is skipped when the
new value matches the cached one.

After a CPU offline/online cycle, MSR_PEBS_DATA_CFG may return to its
reset state, but active_pebs_data_cfg may still hold the pre-offline
value. If the next computed PEBS data configuration matches that stale
cache entry, the MSR update is incorrectly skipped, leaving
MSR_PEBS_DATA_CFG uninitialized for PEBS sampling and resulting in
incorrect PEBS records.

Clear active_pebs_data_cfg and MSR_PEBS_DATA_CFG during CPU teardown so
MSR_PEBS_DATA_CFG is always reprogrammed when the CPU comes back online.

Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b8dd7b73c31a..2f3eaf96daf5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6607,9 +6607,26 @@ static void fini_fixed_cntrs_on_cpu(int cpu)
 	wrmsrq_on_cpu(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
 }
 
+static void fini_adaptive_pebs_on_cpu(int cpu)
+{
+	struct cpu_hw_events *cpuc;
+
+	if (!x86_pmu.ds_pebs || !x86_pmu.intel_cap.pebs_baseline)
+		return;
+
+	/*
+	 * Clear active_pebs_data_cfg so MSR_PEBS_DATA_CFG can
+	 * be reprogrammed after CPU online.
+	 */
+	cpuc = &per_cpu(cpu_hw_events, cpu);
+	cpuc->active_pebs_data_cfg = 0;
+	wrmsrq_on_cpu(cpu, MSR_PEBS_DATA_CFG, 0);
+}
+
 static void intel_pmu_cpu_dying(int cpu)
 {
 	fini_fixed_cntrs_on_cpu(cpu);
+	fini_adaptive_pebs_on_cpu(cpu);
 	fini_debug_store_on_cpu(cpu);
 	fini_arch_pebs_on_cpu(cpu);
 }
-- 
2.34.1


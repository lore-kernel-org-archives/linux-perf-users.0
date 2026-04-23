Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D53822B4;
	Thu, 23 Apr 2026 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776922679; cv=none; b=Tg+/hZu+w61jdcxxnAF2JSlyCtsEdKHrm57ZTM1Ci7HDEyzJDQCv5DpvNVBe1cronN8WZO5Zxj2qOf8UofIcGeM21QVYhkIDN/erMTJxE7JtEYCttbB9kWH6ta7MAbUjV3J/KAEa6SmnXimDfyfW3YZrLRbpkc6xCiCYcfTI4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776922679; c=relaxed/simple;
	bh=IanSBZnzXQTn/o4tGwZn5ZMNo5dJokDyOqRzwr8+Qxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=crKUS8gU2bYuBnWmGT71jj/Sg++WB7LVqF7yLcPZY/CM8TCzqUbrn3mZbGKfMwikT9P7Ngds7IEJADcAVQ4wo+xTK87RSmvtEhQMmXchinF6DBj5WRU5hINd8LUB0PFIg4i7T4bkSH4/mfRULSIo3p+iiZUApFdz0oKdoL3DHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDWzTc2q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDWzTc2q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776922678; x=1808458678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IanSBZnzXQTn/o4tGwZn5ZMNo5dJokDyOqRzwr8+Qxk=;
  b=mDWzTc2qDrJMXXnj/JIiWFtMBl4fkXM7iuj75acdTEz7PRP29QBkIUXp
   Ql19tC6ilgROb2iCfGdHKSVL043W6iehrDX/uLk5wrsgIdruWdOAYlDwO
   CtRZMK3+aLV0AVk4CB/nVIoun6HU5a6zVr4DKXp+SzfaipJbU3x1Ewkmv
   BtIEyzPY4J3R3TUl/ZGlLI3fVXnasdXKlDMoQuAWsIu48u1Y2YINsJ2uT
   vEvZEkoefV4ulqfjvV3aVScq5NI/oZNfekO6TyersHFTfYH4aqEsM4Z5E
   JiTetsmlsotcBc70mP/jNveaJc4XCZIRsL+wt9N3PF3bsCjHn8WBMhzqt
   A==;
X-CSE-ConnectionGUID: QfcwcuZuRp2IjqaJMLwAvg==
X-CSE-MsgGUID: +feKwGIhTDWZ0aIpVg13fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77799258"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77799258"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 22:37:57 -0700
X-CSE-ConnectionGUID: ztRr1Jt4TN2ryjHeP/8YFw==
X-CSE-MsgGUID: tvCCPdPUS8yF+Nu8oSI3rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="226041648"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 22 Apr 2026 22:37:52 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	stable@vger.kernel.org
Subject: [Patch v2] perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
Date: Thu, 23 Apr 2026 13:33:06 +0800
Message-Id: <20260423053306.3033331-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
represent "anythread deprecation" in perf_capabilities. It leads to the
anythread_deprecated bit could be overwritten by the real value of
PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.

```
if (!intel_pmu_broken_perf_cap()) {
	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
}
```

It leads to the anythread_deprecated bit is cleared to 0 and the "any"
attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
these support Perfmon v6 platforms, like Clearwater Forest.

```
$grep . /sys/devices/cpu/format/*
/sys/devices/cpu/format/acr_mask:config2:0-63
/sys/devices/cpu/format/any:config:21
/sys/devices/cpu/format/cmask:config:24-31
```

So remove the anythread_deprecated bit from perf_capabilities structure
and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
deprecated.

Cc: stable@vger.kernel.org
Reported-by: Namhyung Kim <namhyung@kernel.org>
Fixes: cadbaa039b99 ("perf/x86/intel: Make anythread filter support conditional")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V2: Address Namhyung and Zide's comments.

V1: https://lore.kernel.org/all/20260415021010.1248083-1-dapeng1.mi@linux.intel.com/

 arch/x86/events/intel/core.c | 10 +++-------
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 793335c3ce78..f57a2903e4d6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7612,12 +7612,6 @@ __init int intel_pmu_init(void)
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
-	if (version >= 5) {
-		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
-		if (x86_pmu.intel_cap.anythread_deprecated)
-			pr_cont(" AnyThread deprecated, ");
-	}
-
 	/* The perf side of core PMU is ready to support the mediated vPMU. */
 	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
 
@@ -8467,8 +8461,10 @@ __init int intel_pmu_init(void)
 				      &x86_pmu.intel_ctrl);
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
-	if (x86_pmu.intel_cap.anythread_deprecated)
+	if (version >= 5 && edx.split.anythread_deprecated) {
 		x86_pmu.format_attrs = intel_arch_formats_attr;
+		pr_cont("AnyThread deprecated, ");
+	}
 
 	intel_pmu_check_event_constraints_all(NULL);
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..01217c663dff 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -660,7 +660,7 @@ union perf_capabilities {
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
 		u64	pebs_timing_info:1;
-		u64	anythread_deprecated:1;
+		u64	__reserved:1;
 		u64	rdpmc_metrics_clear:1;
 	};
 	u64	capabilities;
-- 
2.34.1


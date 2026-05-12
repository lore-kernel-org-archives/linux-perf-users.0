Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCD38E8CB;
	Tue, 12 May 2026 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629184; cv=none; b=Sf2/ZIt+usnWzFDeN7GXp1QrzAd4Z7k9XuZ0N0THDFRZpHPnKt+cMw7SRc0BMlzqhQCV7vcIBIuymtnZF/EhwRBpNkmZQ8TwYusU76P62IFJaw8MzboG7kX3xF7WrEGTmEDxJshNooVR/PjLtAOjo524xOM0HJ0tyl+qB02jesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629184; c=relaxed/simple;
	bh=Wrj4/Nz6WfxvO299iNfdWXRKgQVCRcPBBGu+tBRCMkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/jk63dTb0IMdzB94bSSzslZl7ZRueSymBg66MB1Oqoz9ONadqxO9y0k8HvB2lHJF1Q0ny8aK7XttWKZJdWGCAyyok92hGEr+4uaBQZ27lRflb2ALsKisKjs2cXwlhgBjmfO3x/ga/IdWxIe5kq9VPRkqaHdAlH2tN+5XAlod8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiKS2+Hc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiKS2+Hc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778629182; x=1810165182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wrj4/Nz6WfxvO299iNfdWXRKgQVCRcPBBGu+tBRCMkA=;
  b=DiKS2+HcBc9JjOT30BOKmSuyhkDiWvMSdNzcoGGM5Z2KGWJlGgRI6Vn+
   L0zTY64oE2KF3EAfRhQwnuLYgYfC9j6KdbTE6nUOqyqkdwfuWBcvqqmqH
   oD3Iq266c86qAUON4sBI8g0A2rUs28lco9a046hekj2px9qc3VPK5crV4
   N22ftfIaL26vpkYcZOAp2n/+Pr/poWxC8zK7leSwAdhp/6uT3r/fBigow
   hAL2/FWi9nEfRKcrz+UBhtR7aC6yG1fPNBjE0ZopslQ+hd08NxMGwogl7
   2DQj4VCORXgVy76ypqpF5tS0hT8mHGKZNvtqowaBuFZB7FqyGHATA2uzw
   g==;
X-CSE-ConnectionGUID: xqoB4GT1Q7W6Fe1hhx8YIg==
X-CSE-MsgGUID: jK5vvyKMRtG1Hofq8QVmhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105008896"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="105008896"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:37 -0700
X-CSE-ConnectionGUID: h0UCHhMIS12jvtIbYs+3rg==
X-CSE-MsgGUID: Jm0/VuiPRuuFuDvHzzJ9uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242271302"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:37 -0700
From: Zide Chen <zide.chen@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH 6/7] perf/x86/intel/uncore: Fix uncore_box ref/unref ordering on CPU hotplug
Date: Tue, 12 May 2026 16:30:47 -0700
Message-ID: <20260512233048.9577-7-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512233048.9577-1-zide.chen@intel.com>
References: <20260512233048.9577-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uncore_event_cpu_online(), uncore_box_ref() was called before
uncore_change_context().  uncore_box_ref() gates on box->cpu >= 0,
but box->cpu is still -1 at that point because uncore_change_context()
has not run yet.  As a result, the box is never initialized on the
first CPU to come online in a die, leaving it permanently
uninitialized in the single-CPU-per-die case.

Thus, cpu_refcnt is one count below the true value, and in the CPU
offline path, the box will be torn down on the second-to-last CPU.

In uncore_event_cpu_offline(), uncore_box_unref() was called after
uncore_change_context(), so box->cpu is already -1 when the collector
CPU goes offline, which prevents it from tearing down the box.

Fix by swapping the call order in both paths so that
uncore_box_{ref,unref}() runs at the point where box->cpu reflects
the correct context.

Fixes: c74443d92f68 ("perf/x86/uncore: Support per PMU cpumask")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c | 56 ++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 922ba299533e..399f434e1a7d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1574,9 +1574,15 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 {
 	int die, target;
 
+	/* Clear the references */
+	die = topology_logical_die_id(cpu);
+	uncore_box_unref(uncore_msr_uncores, die);
+	uncore_box_unref(uncore_mmio_uncores, die);
+
 	/* Check if exiting cpu is used for collecting uncore events */
 	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
-		goto unref;
+		return 0;
+
 	/* Find a new cpu to collect uncore events */
 	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
 
@@ -1589,20 +1595,14 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 	uncore_change_context(uncore_msr_uncores, cpu, target);
 	uncore_change_context(uncore_mmio_uncores, cpu, target);
 	uncore_change_context(uncore_pci_uncores, cpu, target);
-
-unref:
-	/* Clear the references */
-	die = topology_logical_die_id(cpu);
-	uncore_box_unref(uncore_msr_uncores, die);
-	uncore_box_unref(uncore_mmio_uncores, die);
 	return 0;
 }
 
-static int allocate_boxes(struct intel_uncore_type **types,
+static void allocate_boxes(struct intel_uncore_type **types,
 			 unsigned int die, unsigned int cpu)
 {
 	struct intel_uncore_box *box, *tmp;
-	struct intel_uncore_type *type;
+	struct intel_uncore_type *type, **start = types;
 	struct intel_uncore_pmu *pmu;
 	LIST_HEAD(allocated);
 	int i;
@@ -1627,14 +1627,21 @@ static int allocate_boxes(struct intel_uncore_type **types,
 		list_del_init(&box->active_list);
 		box->pmu->boxes[die] = box;
 	}
-	return 0;
+	return;
 
 cleanup:
 	list_for_each_entry_safe(box, tmp, &allocated, active_list) {
 		list_del_init(&box->active_list);
 		kfree(box);
 	}
-	return -ENOMEM;
+
+	/* mark the PMU broken to prevent future ussage. */
+	for (; *start; start++) {
+		type = *start;
+		pmu = type->pmus;
+		for (i = 0; i < type->num_boxes; i++, pmu++)
+			uncore_pmu_set_broken(pmu);
+	}
 }
 
 static int uncore_box_ref(struct intel_uncore_type **types,
@@ -1643,11 +1650,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, ret;
-
-	ret = allocate_boxes(types, die, cpu);
-	if (ret)
-		return ret;
+	int i;
 
 	for (; *types; types++) {
 		type = *types;
@@ -1664,27 +1667,26 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 
 static int uncore_event_cpu_online(unsigned int cpu)
 {
-	int die, target, msr_ret, mmio_ret;
+	int die, target;
 
 	die = topology_logical_die_id(cpu);
-	msr_ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
-	mmio_ret = uncore_box_ref(uncore_mmio_uncores, die, cpu);
+	allocate_boxes(uncore_msr_uncores, die, cpu);
+	allocate_boxes(uncore_mmio_uncores, die, cpu);
 
 	/*
 	 * Check if there is an online cpu in the package
 	 * which collects uncore events already.
 	 */
 	target = cpumask_any_and(&uncore_cpu_mask, topology_die_cpumask(cpu));
-	if (target < nr_cpu_ids)
-		return 0;
-
-	cpumask_set_cpu(cpu, &uncore_cpu_mask);
-
-	if (!msr_ret)
+	if (target >= nr_cpu_ids) {
+		cpumask_set_cpu(cpu, &uncore_cpu_mask);
 		uncore_change_context(uncore_msr_uncores, -1, cpu);
-	if (!mmio_ret)
 		uncore_change_context(uncore_mmio_uncores, -1, cpu);
-	uncore_change_context(uncore_pci_uncores, -1, cpu);
+		uncore_change_context(uncore_pci_uncores, -1, cpu);
+	}
+
+	uncore_box_ref(uncore_msr_uncores, die, cpu);
+	uncore_box_ref(uncore_mmio_uncores, die, cpu);
 	return 0;
 }
 
-- 
2.54.0


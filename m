Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5C3E0234;
	Mon,  1 Jun 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333816; cv=none; b=DcUVfj0AWhGO5o0T7+U2r2FchkdDkhKx6nfOOeffBgVMFiq/ciTsp5L0NBtzcd7L2AYAOWYyYf2KlL5KqIBJTDG2js3FWWUT4uC8mBXXialng/8SuPfCiifdd2lrvc3NFuAuCfExnu98bpJtzLMI5JvjPXT/DInMcnZvHd1AGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333816; c=relaxed/simple;
	bh=I/BUfPUkHjGblVOmS74aFkShR8jlGuIoRVH4geV3Wwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMHUr6cnmNvN5ZZK/QTHZMktB0oow1vOHkIrgYIP3lThR1c8o099mstFKGFQLxnAVT0PLCybO89dTNzCP9r1jEGSZ1iv5UFC6ScMb20yPO/EvYCrzschl0NB97zijkjaUD6tAWKmqDkubeGdRMWowv/gIswcGF8KxUEwY5QEQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoI70BFw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoI70BFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780333813; x=1811869813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/BUfPUkHjGblVOmS74aFkShR8jlGuIoRVH4geV3Wwk=;
  b=SoI70BFwg2wT4sxxevINX5OaiEcu15qdU7F3R9Y4bOf6UY4ffDtXiVzf
   nLo+0C9RiaErn361jcNklJK2lxzy2yLqhCKZl1FahkDGjNkH8/bTiSCpO
   1W908Vu50tN1X99AcB1CsXNc5gaoBwmJuUeyd0Jqzfr7dXW3CfbsRyTQ3
   kY4ThvA70/JMi90lVSVdUzsbNgLsmGrxwgWbIxXpCvyoG1MDg4Xlmw1Wk
   G2n+ZyoAWCrBGhYNp4KDwlfGzePlldjx0s9rEbS7Go8CqLzUTCaBwtViI
   FjHpW15kOL6YHsyxjr1gQrpFvaMgcaM63c7yY7kRLR3CqyZHL0I0V2S6e
   Q==;
X-CSE-ConnectionGUID: QbaJovO+T4CykkvyQ3oycw==
X-CSE-MsgGUID: bCFm3mN8S6OG4TJjxBpxWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98517009"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98517009"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:07 -0700
X-CSE-ConnectionGUID: T/sL32kLSsiSWaGmhcPehQ==
X-CSE-MsgGUID: AVEEGvB+RqObJ9JXKax7Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242585015"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:05 -0700
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
Subject: [PATCH V2 7/8] perf/x86/intel/uncore: Fix uncore_box ref/unref ordering on CPU hotplug
Date: Mon,  1 Jun 2026 10:01:13 -0700
Message-ID: <20260601170114.173359-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601170114.173359-1-zide.chen@intel.com>
References: <20260601170114.173359-1-zide.chen@intel.com>
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

Thus, box->refcnt is one count below the true value, and in the CPU
offline path, the box will be torn down on the second-to-last CPU.

In uncore_event_cpu_offline(), uncore_box_unref() was called after
uncore_change_context(), so box->cpu is already -1 when the collector
CPU goes offline, which prevents it from tearing down the box.

Fix by swapping the call order in both paths so that
uncore_box_{ref,unref}() runs at the point where box->cpu reflects
the correct context.

Fixes: c74443d92f68 ("perf/x86/uncore: Support per PMU cpumask")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c | 50 ++++++++++++++++------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index f2cb3fde2dda..6d710aef52ac 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1577,9 +1577,15 @@ static int uncore_event_cpu_offline(unsigned int cpu)
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
 
@@ -1592,16 +1598,10 @@ static int uncore_event_cpu_offline(unsigned int cpu)
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
@@ -1618,8 +1618,10 @@ static int allocate_boxes(struct intel_uncore_type **types,
 			if (pmu->boxes[die] || uncore_pmu_broken(pmu))
 				continue;
 			box = uncore_alloc_box(type, cpu_to_node(cpu));
-			if (!box)
+			if (!box) {
+				uncore_pmu_set_broken(pmu);
 				goto cleanup;
+			}
 			box->pmu = pmu;
 			box->dieid = die;
 			list_add(&box->active_list, &allocated);
@@ -1630,14 +1632,13 @@ static int allocate_boxes(struct intel_uncore_type **types,
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
 }
 
 static int uncore_box_ref(struct intel_uncore_type **types,
@@ -1646,11 +1647,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
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
@@ -1666,27 +1663,26 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 
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


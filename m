Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAB41C31B;
	Thu, 11 Jun 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194181; cv=none; b=koaDFhukjZgouln+yXdmix+rtG9vjrXYq/cFXRdrHwK2+Lf56M0fqgjio2KfpGbF+XiLvevYCuN2J4k4UQN1rVTuZdGvjudNNJgpPmX1/1WsPUwd1kGv0XcA61mwudLy0vnLWM5Uj924Se5tslPRPM6pRLgq54R9c/Mp46+gWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194181; c=relaxed/simple;
	bh=Ac7HRRaCcSRDfUA09JCE47zhryZQRN3wwZja6lBcgY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPM63pl8DXbwDwx8IZ5Vhp/vX+lk64Eb85ALcwzxi2wCGfswFMI/BP8HEU6DBfC9t7FnmMfZ0Peahf7PR1vh54xUv9CY1PfS336frCDFTOTcB407nTPEEXneDQ0NcCpg/1yOyWN3oq1XzXefcqx0LM1WvNaSEVx4FDphgDRK5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSuzMA72; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSuzMA72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781194180; x=1812730180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ac7HRRaCcSRDfUA09JCE47zhryZQRN3wwZja6lBcgY4=;
  b=DSuzMA72S7te9qHUS8Ul7oGkWaMVjjfVyaLVPNJIihk6AGpMWEC2XRE0
   1TJlOaFHfEBL3SewSWAdh3AT3AY8AphOReLdToWpV82UfLQao8ByctNtv
   VrK+LALwhQ650W+EuMesxBpqcZE6550kfUnigxCXZ2jXiT/talFKpD2q6
   gVUwjV2nKeAsxC8IxSiLWVx/Tp0+jW4RD7WCvCw+n4l8CjDP5w+14HrYF
   Qma/a5hQZ9n7TNLDIa0CWFyruqvIyLN+i7wWMJ/p3rWTHhtPSuCUAGMxm
   P84Lp5jiRRELMpmS8wrVL6H+Dt1Q8Iewrd8T1zO5CbdFG6iYWCvBb9ZJq
   g==;
X-CSE-ConnectionGUID: h7wKITDSRQKF7tdTtMjdWw==
X-CSE-MsgGUID: Yx0DlOfTQKyVroIxbYCvkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81994989"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81994989"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:37 -0700
X-CSE-ConnectionGUID: 4csqgOyyTKqoR4k2uBg+3g==
X-CSE-MsgGUID: ehkBi1IaT0aZG0XYqUTWZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246403604"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:36 -0700
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
Subject: [PATCH V3 6/8] perf/x86/intel/uncore: Introduce PMU flags and broken state
Date: Thu, 11 Jun 2026 09:00:31 -0700
Message-ID: <20260611160033.66760-7-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611160033.66760-1-zide.chen@intel.com>
References: <20260611160033.66760-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the boolean 'registered' field in intel_uncore_pmu with an
unsigned long 'flags' field, and add a PMU_BROKEN flag to track box
setup failures. The broken flag is sticky, meaning it is cleared only
by a module reload or system reboot.

Broken PMUs are skipped in the CPU hotplug and box allocation paths.

When any box fails to initialize, the PMU is marked broken.  Broken
PMUs reject new event assignments and skip future box setup attempts.
If the PMU was already registered, it remains so to avoid disrupting
in-flight events on other boxes.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Fix typo stick->sticky and other cosmetic fixes in code comment.
v2:
- Make the broken flag sticky by using clear_bit() in
  uncore_pmu_unregister() rather than zeroing out pmu->flags.
- In uncore_change_type_ctx(), don't stop CPU migration on broken PMU
  for in-flight events. (Sashiko).
- Use box->cpu == -1 to identify inactive boxes that don't need
  migration, no need to check uncore_die_has_box(), which is incomplete.
---
 arch/x86/events/intel/uncore.c     | 44 ++++++++++++++++++++++--------
 arch/x86/events/intel/uncore.h     | 13 ++++++++-
 arch/x86/events/intel/uncore_snb.c |  2 +-
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 06ef89f6ccc2..feb8c3b0076b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -757,7 +757,7 @@ static int uncore_pmu_event_init(struct perf_event *event)
 
 	pmu = uncore_event_to_pmu(event);
 	/* no device found for this pmu */
-	if (!pmu->registered)
+	if (!uncore_pmu_available(pmu))
 		return -ENOENT;
 
 	/* Sampling not supported yet */
@@ -953,16 +953,18 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 
 	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
 	if (!ret)
-		pmu->registered = true;
+		uncore_pmu_set_registered(pmu);
 	return ret;
 }
 
 static void uncore_pmu_unregister(struct intel_uncore_pmu *pmu)
 {
-	if (!pmu->registered)
+	if (!uncore_pmu_registered(pmu))
 		return;
 	perf_pmu_unregister(&pmu->pmu);
-	pmu->registered = false;
+
+	/* Keep PMU_BROKEN_BIT sticky. */
+	uncore_pmu_clear_registered(pmu);
 }
 
 static void uncore_free_boxes(struct intel_uncore_pmu *pmu)
@@ -1153,7 +1155,12 @@ static int uncore_box_setup(struct intel_uncore_pmu *pmu,
 {
 	int ret;
 
-	uncore_box_init(box);
+	if (uncore_pmu_broken(pmu))
+		return -ENODEV;
+
+	ret = uncore_box_init(box);
+	if (ret)
+		goto err;
 
 	/* First active box registers the pmu. */
 	if (atomic_inc_return(&pmu->activeboxes) > 1)
@@ -1167,6 +1174,16 @@ static int uncore_box_setup(struct intel_uncore_pmu *pmu,
 
 	return 0;
 err:
+	/*
+	 * If any box fails, mark the per-package PMU as broken regardless of
+	 * whether it was registered or not.
+	 *
+	 * Don't decrement refcnt to avoid other in-die CPUs from trying to set
+	 * up the PMU box again.
+	 *
+	 * Don't kfree box; MSR and MMIO boxes are freed at module exit only.
+	 */
+	uncore_pmu_set_broken(pmu);
 	uncore_box_exit(box);
 	return ret;
 }
@@ -1190,8 +1207,10 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 		return -EINVAL;
 
 	box = uncore_alloc_box(type, NUMA_NO_NODE);
-	if (!box)
+	if (!box) {
+		uncore_pmu_set_broken(pmu);
 		return -ENOMEM;
+	}
 
 	atomic_inc(&box->refcnt);
 	box->dieid = die;
@@ -1507,7 +1526,8 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 
 		if (old_cpu < 0) {
 			WARN_ON_ONCE(box->cpu != -1);
-			if (uncore_die_has_box(type, die, pmu->pmu_idx)) {
+			if (uncore_die_has_box(type, die, pmu->pmu_idx) &&
+			    !uncore_pmu_broken(pmu)) {
 				box->cpu = new_cpu;
 				cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
 			}
@@ -1515,12 +1535,14 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 		}
 
 		WARN_ON_ONCE(box->cpu != -1 && box->cpu != old_cpu);
-		box->cpu = -1;
 		cpumask_clear_cpu(old_cpu, &pmu->cpu_mask);
-		if (new_cpu < 0)
+		if (new_cpu < 0) {
+			box->cpu = -1;
 			continue;
+		}
 
-		if (!uncore_die_has_box(type, die, pmu->pmu_idx))
+		/* An inactive box doesn't need migration. */
+		if (box->cpu == -1)
 			continue;
 		uncore_pmu_cancel_hrtimer(box);
 		perf_pmu_migrate_context(&pmu->pmu, old_cpu, new_cpu);
@@ -1596,7 +1618,7 @@ static int allocate_boxes(struct intel_uncore_type **types,
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			if (pmu->boxes[die])
+			if (pmu->boxes[die] || uncore_pmu_broken(pmu))
 				continue;
 			box = uncore_alloc_box(type, cpu_to_node(cpu));
 			if (!box)
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index d732b87be0a9..0adb477d9708 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -146,13 +146,24 @@ struct intel_uncore_pmu {
 	struct pmu			pmu;
 	char				name[UNCORE_PMU_NAME_LEN];
 	int				pmu_idx;
-	bool				registered;
+	unsigned long			flags;
 	atomic_t			activeboxes;
 	cpumask_t			cpu_mask;
 	struct intel_uncore_type	*type;
 	struct intel_uncore_box		**boxes;
 };
 
+#define PMU_REGISTERED_BIT	0
+#define PMU_BROKEN_BIT		1
+
+#define uncore_pmu_registered(pmu)	test_bit(PMU_REGISTERED_BIT, &(pmu)->flags)
+#define uncore_pmu_broken(pmu)		test_bit(PMU_BROKEN_BIT, &(pmu)->flags)
+#define uncore_pmu_available(pmu)	(uncore_pmu_registered(pmu) &&  \
+					 !uncore_pmu_broken(pmu))
+#define uncore_pmu_set_registered(pmu)	set_bit(PMU_REGISTERED_BIT, &(pmu)->flags)
+#define uncore_pmu_set_broken(pmu)	set_bit(PMU_BROKEN_BIT, &(pmu)->flags)
+#define uncore_pmu_clear_registered(pmu) clear_bit(PMU_REGISTERED_BIT, &(pmu)->flags)
+
 struct intel_uncore_extra_reg {
 	raw_spinlock_t lock;
 	u64 config, config1, config2;
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index c5347920541c..055131c508ff 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -940,7 +940,7 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 
 	pmu = uncore_event_to_pmu(event);
 	/* no device found for this pmu */
-	if (!pmu->registered)
+	if (!uncore_pmu_available(pmu))
 		return -ENOENT;
 
 	/* Sampling not supported yet */
-- 
2.54.0


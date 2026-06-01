Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE53DDDD8;
	Mon,  1 Jun 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333812; cv=none; b=aItyHiYDhLPXxChJ9GPgrF/nO2VaOeUzchpjq/AFvgo3ez8jmJr7nr7LgAvyWtF/X/dEQJ/E04ZxOoe2v4r8ad2AOonwGCJoO+6cz3TCwehaGjw/ELRknaAsaTclQkfbyqAmeTgH7nTNjINCETtCwIJU1HKUp78lchLD+avqb5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333812; c=relaxed/simple;
	bh=/UZsoBN1JUWsQpLy3nhbX+hfN/L6xun0htPS7PYqEP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgFRDPmXnbBX4VJhTOnRa3ZmLjhWEma1ckplY/OvETq2icyw2qxf7KQFKO8tQujsKSzH7jMdJdmt5VRTthlxmwpU28V3E8M5vHMAjmQWvjwrmSObf8K6xipseaY0C34gpOCWe6G91p7pGRiV0gpcj6RjR7muqckGMrrkYSZIZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RehG+9un; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RehG+9un"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780333811; x=1811869811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UZsoBN1JUWsQpLy3nhbX+hfN/L6xun0htPS7PYqEP8=;
  b=RehG+9unpZ6yY9Lc0V9GkeFV/9DHFstNuYw6qssnx5lmAS8beTeVVy9J
   7kmTdbYyWrE6KSwEpFh0iHri02l4De9tOSfko+f4Dh9zc4crlTxTnADV2
   /LuHeuqxt6jovOA55x0hrJIJEUDQFTorQpJjH0Fvgm0Pxsuzy5omLSSqK
   Z/z7Rx4SFGu1GRDaj+Wsybqn+TQBLKpuc2j+2WlvjI48xsF7XARnflSDH
   2TTsWe0UlOhT4/8Vp2TtYIh8yIlD9vv2LQzONNIGFWkB4OXsem8ywF9Rq
   44XOKktOz7iJ6rR8BXkCzwVtRWqOh61V/bb1s57RbLn9lFDOGH4ChfSBq
   Q==;
X-CSE-ConnectionGUID: ZGxulLOHTVKR/8StTJKtyQ==
X-CSE-MsgGUID: 5sgo1cocTzqOIAp03KqLJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98517004"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98517004"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:07 -0700
X-CSE-ConnectionGUID: vdzbDmdvSOiI+1kL+RrlYw==
X-CSE-MsgGUID: /p309kXwT/6AMQWagPQUwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242585012"
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
Subject: [PATCH V2 6/8] perf/x86/intel/uncore: Introduce PMU flags and broken state
Date: Mon,  1 Jun 2026 10:01:12 -0700
Message-ID: <20260601170114.173359-7-zide.chen@intel.com>
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

Replace the boolean 'registered' field in intel_uncore_pmu with an
unsigned long 'flags' field, and add a PMU_BROKEN flag to track box
setup failures. Broken flag is sticky, means it won't be cleared
unless module reload or system reboot.

Broken PMUs are skipped in the CPU hotplug and box allocation paths.

When any box fails to initialize, the PMU is marked broken.  Broken
PMUs reject new event assignments and skip future box setup attempts.
If the PMU was already registered, it remains so to avoid disrupting
in-flight events on other boxes.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2:
- Make the broken flag sticky by clear_bit() in uncore_pmu_unregister()
other than zeroing out pmu->flag.
- In uncore_change_type_ctx(), don't stop CPU migration on broken PMU
  for in-flight events.  (Sashiko).
- Use box->cpu == -1 to identify inactive boxes that don't need
  migration, no need to check uncore_die_has_box(), which is incomplete.
---
 arch/x86/events/intel/uncore.c     | 44 ++++++++++++++++++++++--------
 arch/x86/events/intel/uncore.h     | 13 ++++++++-
 arch/x86/events/intel/uncore_snb.c |  2 +-
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 283e41933ba7..f2cb3fde2dda 100644
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
+	/* Keep PMU_BROKEN_BIT stick. */
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
+	 * On failure on any box, mark the per-package PMU as broken regardless
+	 * of whether it was registered or not.
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
 
 	box->dieid = die;
 	box->pci_dev = pdev;
@@ -1504,7 +1523,8 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 
 		if (old_cpu < 0) {
 			WARN_ON_ONCE(box->cpu != -1);
-			if (uncore_die_has_box(type, die, pmu->pmu_idx)) {
+			if (uncore_die_has_box(type, die, pmu->pmu_idx) &&
+			    !uncore_pmu_broken(pmu)) {
 				box->cpu = new_cpu;
 				cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
 			}
@@ -1512,12 +1532,14 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
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
+		/* non-active box doesn't need migration. */
+		if (box->cpu == -1)
 			continue;
 		uncore_pmu_cancel_hrtimer(box);
 		perf_pmu_migrate_context(&pmu->pmu, old_cpu, new_cpu);
@@ -1593,7 +1615,7 @@ static int allocate_boxes(struct intel_uncore_type **types,
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


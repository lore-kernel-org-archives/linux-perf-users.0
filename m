Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1438E8DC;
	Tue, 12 May 2026 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629183; cv=none; b=PBxI4MdZnIfONXrqg8b+PBqpq77O7iBK2ARBHPUOQF/eBAxFEP8vNsnadpXq8Q2NzCMoaDGvAdtZZneG49dO+gUajxpli16rYq4c9pNcyHqSL/TnB9NeoYSAtBfMhiFEc2I5JZg6ZUE+w7RcvTKm1EeiinAR4XrvZYNhyyJ0pAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629183; c=relaxed/simple;
	bh=4+HLKoLb+Mcw5MSx1liGsJoSfaB84xrQIRYboMpvAKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPJBLTlPlUXWHHRzls7mR9c4sQNUZnLeRhqwNsmGBgxSzWWAtmDe3pmDP43hF02KPfv2krH8XRzeo5w9qVKhWxfK5ry5EwZkpCFBA2k1S/Ezi+NjUZhDkQa1xviOimY4/d9vZNrCRQyNyYMZZ4cvQDdhZtZpkqgQbUU1Ca6SPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msCSzg1B; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msCSzg1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778629181; x=1810165181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4+HLKoLb+Mcw5MSx1liGsJoSfaB84xrQIRYboMpvAKw=;
  b=msCSzg1BsSk4oTpifLcyUBEZGpQ7AnSYVCy1gnCKiEqbatd8+tvjFl2O
   Mff2JfhpEly/01Sx6AXY+AU5besK/uQMRQSm2WaPP06fNiQh9pOGDLDh0
   tte4fddZiKGWbsv/bSczR9vf4VAZ9L9fiV6yzIQwv/zmAiLsXct6Fjx1s
   ee4FMdMaZihW3+Mbm+L2zd1/Oi/Z0pW1RXMLVlqKIzDO6N760tOG73EAJ
   ziFEUkhIZ6BR6b2q3ldpFBpmAkBCQthg4/q3eRHXj2a06x2oXJ+aqPZoG
   lXAUrHmDGi50uLgkpCqg1iX3RXgKdFvUnzji2KUfZEbmhbhAxoVmmli0u
   A==;
X-CSE-ConnectionGUID: jWHWomn4T0qJkp0uDtIxaw==
X-CSE-MsgGUID: WguKv2NYSra+auH0KerELw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105008891"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="105008891"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:37 -0700
X-CSE-ConnectionGUID: Dpdh5w92SNeyfaFb0Qeaew==
X-CSE-MsgGUID: fZwNyR3jQrW7tk/8WFHXWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242271298"
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
Subject: [PATCH 5/7] perf/x86/intel/uncore: Introduce PMU flags and broken state
Date: Tue, 12 May 2026 16:30:46 -0700
Message-ID: <20260512233048.9577-6-zide.chen@intel.com>
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

Replace the boolean 'registered' field in intel_uncore_pmu with an
unsigned long 'flags' field, and add a PMU_BROKEN flag to track box
setup failures.

When any box fails to initialize, the PMU is marked broken.  Broken
PMUs reject new event assignments and skip future box setup attempts.
If the PMU was already registered, it remains so to avoid disrupting
in-flight events on other boxes.

To prevent retry loops, die_refcnt and cpu_refcnt are not decremented
on failure, and broken PMUs are skipped in the CPU hotplug and box
allocation paths.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c     | 36 +++++++++++++++++++++++-------
 arch/x86/events/intel/uncore.h     | 12 +++++++++-
 arch/x86/events/intel/uncore_snb.c |  2 +-
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 00ed4e5047ac..922ba299533e 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -757,7 +757,7 @@ static int uncore_pmu_event_init(struct perf_event *event)
 
 	pmu = uncore_event_to_pmu(event);
 	/* no device found for this pmu */
-	if (!pmu->registered)
+	if (!uncore_pmu_available(pmu))
 		return -ENOENT;
 
 	/* Sampling not supported yet */
@@ -953,16 +953,16 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 
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
+	WRITE_ONCE(pmu->flags, 0);
 }
 
 static void uncore_free_boxes(struct intel_uncore_pmu *pmu)
@@ -1155,7 +1155,13 @@ static int uncore_box_setup(struct intel_uncore_pmu *pmu,
 
 	/* die_refcnt tracks online dies, not only functioning boxes. */
 	dies = atomic_inc_return(&pmu->die_refcnt);
-	uncore_box_init(box);
+
+	if (uncore_pmu_broken(pmu))
+		return -ENODEV;
+
+	ret = uncore_box_init(box);
+	if (ret)
+		goto err;
 
 	/* First active box registers the pmu. */
 	if (dies > 1)
@@ -1167,6 +1173,19 @@ static int uncore_box_setup(struct intel_uncore_pmu *pmu,
 
 	return 0;
 err:
+	/*
+	 * On failure on any box, mark the per-package PMU as broken regardless
+	 * of whether it was registered or not.
+	 *
+	 * Don't decrement die_refcnt to prevent any future CPU online
+	 * event or PCI probe, from retrying the failed PMU registration.
+	 *
+	 * Don't decrement cpu_refcnt to avoid other in-die CPUs from
+	 * trying to set up the PMU box again.
+	 *
+	 * Don't kfree box; MSR and MMIO boxes are freed at module exit only.
+	 */
+	uncore_pmu_set_broken(pmu);
 	uncore_box_exit(box);
 	return ret;
 }
@@ -1502,7 +1521,8 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 
 		if (old_cpu < 0) {
 			WARN_ON_ONCE(box->cpu != -1);
-			if (uncore_die_has_box(type, die, pmu->pmu_idx)) {
+			if (uncore_die_has_box(type, die, pmu->pmu_idx) &&
+			    !uncore_pmu_broken(pmu)) {
 				box->cpu = new_cpu;
 				cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
 			}
@@ -1512,7 +1532,7 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 		WARN_ON_ONCE(box->cpu != -1 && box->cpu != old_cpu);
 		box->cpu = -1;
 		cpumask_clear_cpu(old_cpu, &pmu->cpu_mask);
-		if (new_cpu < 0)
+		if (new_cpu < 0 || uncore_pmu_broken(pmu))
 			continue;
 
 		if (!uncore_die_has_box(type, die, pmu->pmu_idx))
@@ -1592,7 +1612,7 @@ static int allocate_boxes(struct intel_uncore_type **types,
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			if (pmu->boxes[die])
+			if (pmu->boxes[die] || uncore_pmu_broken(pmu))
 				continue;
 			box = uncore_alloc_box(type, cpu_to_node(cpu));
 			if (!box)
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 5ee05545116a..4d3a99bf1455 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -146,13 +146,23 @@ struct intel_uncore_pmu {
 	struct pmu			pmu;
 	char				name[UNCORE_PMU_NAME_LEN];
 	int				pmu_idx;
-	bool				registered;
+	unsigned long			flags;
 	atomic_t			die_refcnt;
 	cpumask_t			cpu_mask;
 	struct intel_uncore_type	*type;
 	struct intel_uncore_box		**boxes;
 };
 
+#define PMU_REGISTERED_BIT	0
+#define PMU_BROKEN_BIT		1
+
+#define uncore_pmu_registered(pmu)	test_bit(PMU_REGISTERED_BIT, &(pmu)->flags)
+#define uncore_pmu_broken(pmu)		test_bit(PMU_BROKEN_BIT, &(pmu)->flags)
+#define uncore_pmu_available(pmu)	(uncore_pmu_registered(pmu) &&	\
+					 !uncore_pmu_broken(pmu))
+#define uncore_pmu_set_registered(pmu)	set_bit(PMU_REGISTERED_BIT, &(pmu)->flags)
+#define uncore_pmu_set_broken(pmu)	set_bit(PMU_BROKEN_BIT, &(pmu)->flags)
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


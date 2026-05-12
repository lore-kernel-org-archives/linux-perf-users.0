Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166D385D9D;
	Tue, 12 May 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629181; cv=none; b=DeFRowkyS3bYqBB5tkLMDp5RPhrEmKMT4mzWUR0V2daK5Wd23MRkpt2uFAJFiYht3pOsKqb6ZjrdAHvzdTD4uUU8aMyy5pEufoR8LvkWIZjqQJ3zvtAkzqtDMkMOP8KzyejjEaA6XW7VGZTTIyiFaoDOtoc8KvKgT0m3fejgNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629181; c=relaxed/simple;
	bh=J0RYKoFp+SLR0pcnLuX+1Dd7Wnm7qJ8VvmA8u0JNsKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPJYB4nXWkZGFA+giVwTTP6GHWIDZ8qRUfjfKGF3kzvb7sUCmQyCVSS3NwAO3877maME5u8zfE7iKN7T5swKWUeNBZHB5elcM5Bj09K391sc0T8VxeAuCBYfDpCKMUgKpb0jwfeUiFaF87qKprd6934EmTEo+k+VI/Xog4eAKMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amapJbAQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amapJbAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778629179; x=1810165179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J0RYKoFp+SLR0pcnLuX+1Dd7Wnm7qJ8VvmA8u0JNsKI=;
  b=amapJbAQRANTZb1ZB0U/NMQd8N8NQHuFoQH/m+7oy60r5qPv7lkYhVO4
   KS7AXhj6Mxq4yZTm0mGJFOleSkZ4zuMSal2s2Z9/0bQSBvxGR9cbpBSM1
   /l5AfyVCThh6ZXckvrMVinZRCqZi70evELe5HGUvsGTW/AB4R4V8WG9gR
   V5ioLeETEeLJq2sa1RwrAkDFh6uWkUlnLRlKMIBrmMfEH886GK0IzdLdI
   W5lbWHs+ZOzULe+aZ0UafHTLNksU6CRTz1k+0MuHCFTXRoZdYtNVHB8TJ
   aDvtr3tYH0YRdqbBdiKe9aY5ATI1IoEMnor5nFqMAc7fEUpROWH3vfOoO
   Q==;
X-CSE-ConnectionGUID: CHA0X2SvQFe/sGV7p2qzcg==
X-CSE-MsgGUID: 3IU9no6ZT+a38l5+GnKw7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105008872"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="105008872"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:36 -0700
X-CSE-ConnectionGUID: jYTJNvnqRl6Myhf93FLMBw==
X-CSE-MsgGUID: FZlkvUeSSV6vtbccwv4FkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242271284"
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
Subject: [PATCH 1/7] perf/x86/intel/uncore: Rename refcount fields and other cleanups
Date: Tue, 12 May 2026 16:30:42 -0700
Message-ID: <20260512233048.9577-2-zide.chen@intel.com>
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

Fix typo UNCORE_BOX_FLAG_INITIATED to UNCORE_BOX_FLAG_INITIALIZED.

Rename the 'id' parameter in uncore_box_{ref,unref}() to 'die' to
reflect its actual meaning and be consistent with other functions.

pmu->activeboxes is misleading because it does not decrement when the
PMU fails to register.  Rename it to die_refcnt, reflecting that it
counts the number of dies with a box present, regardless of whether
the PMU is functioning.

Rename box->refcnt to box->cpu_refcnt to clarify that it tracks the
number of CPUs on the die with a corresponding PMU box present.

Remove the incorrect atomic_inc(&box->refcnt) from
uncore_pci_pmu_register(): PCI boxes are not tracked by cpu_refcnt,
and this call incorrectly increments it on a per-die basis.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c | 21 +++++++++++----------
 arch/x86/events/intel/uncore.h | 10 +++++-----
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a7780c5cd419..012a7e081014 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1170,14 +1170,13 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 	if (!box)
 		return -ENOMEM;
 
-	atomic_inc(&box->refcnt);
 	box->dieid = die;
 	box->pci_dev = pdev;
 	box->pmu = pmu;
 	uncore_box_init(box);
 
 	pmu->boxes[die] = box;
-	if (atomic_inc_return(&pmu->activeboxes) > 1)
+	if (atomic_inc_return(&pmu->die_refcnt) > 1)
 		return 0;
 
 	/* First active box registers the pmu */
@@ -1249,7 +1248,7 @@ static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu, int die)
 	struct intel_uncore_box *box = pmu->boxes[die];
 
 	pmu->boxes[die] = NULL;
-	if (atomic_dec_return(&pmu->activeboxes) == 0)
+	if (atomic_dec_return(&pmu->die_refcnt) == 0)
 		uncore_pmu_unregister(pmu);
 	uncore_box_exit(box);
 	kfree(box);
@@ -1515,7 +1514,7 @@ static void uncore_change_context(struct intel_uncore_type **uncores,
 		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
 }
 
-static void uncore_box_unref(struct intel_uncore_type **types, int id)
+static void uncore_box_unref(struct intel_uncore_type **types, int die)
 {
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
@@ -1526,8 +1525,9 @@ static void uncore_box_unref(struct intel_uncore_type **types, int id)
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[id];
-			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
+			box = pmu->boxes[die];
+			if (box && box->cpu >= 0 &&
+			    atomic_dec_return(&box->cpu_refcnt) == 0)
 				uncore_box_exit(box);
 		}
 	}
@@ -1601,14 +1601,14 @@ static int allocate_boxes(struct intel_uncore_type **types,
 }
 
 static int uncore_box_ref(struct intel_uncore_type **types,
-			  int id, unsigned int cpu)
+			  int die, unsigned int cpu)
 {
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
 	int i, ret;
 
-	ret = allocate_boxes(types, id, cpu);
+	ret = allocate_boxes(types, die, cpu);
 	if (ret)
 		return ret;
 
@@ -1616,8 +1616,9 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[id];
-			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
+			box = pmu->boxes[die];
+			if (box && box->cpu >= 0 &&
+			    atomic_inc_return(&box->cpu_refcnt) == 1)
 				uncore_box_init(box);
 		}
 	}
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c2e5ccb1d72c..7d4ef869d193 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -147,7 +147,7 @@ struct intel_uncore_pmu {
 	char				name[UNCORE_PMU_NAME_LEN];
 	int				pmu_idx;
 	bool				registered;
-	atomic_t			activeboxes;
+	atomic_t			die_refcnt;
 	cpumask_t			cpu_mask;
 	struct intel_uncore_type	*type;
 	struct intel_uncore_box		**boxes;
@@ -165,7 +165,7 @@ struct intel_uncore_box {
 	int n_events;
 	int cpu;	/* cpu to collect events */
 	unsigned long flags;
-	atomic_t refcnt;
+	atomic_t cpu_refcnt; /* Number of CPUs that have this box online */
 	struct perf_event *events[UNCORE_PMC_IDX_MAX];
 	struct perf_event *event_list[UNCORE_PMC_IDX_MAX];
 	struct event_constraint *event_constraint[UNCORE_PMC_IDX_MAX];
@@ -185,7 +185,7 @@ struct intel_uncore_box {
 #define CFL_UNC_CBO_7_PERFEVTSEL0		0xf70
 #define CFL_UNC_CBO_7_PER_CTR0			0xf76
 
-#define UNCORE_BOX_FLAG_INITIATED		0
+#define UNCORE_BOX_FLAG_INITIALIZED		0
 /* event config registers are 8-byte apart */
 #define UNCORE_BOX_FLAG_CTL_OFFS8		1
 /* CFL 8th CBOX has different MSR space */
@@ -559,7 +559,7 @@ static inline u64 uncore_read_counter(struct intel_uncore_box *box,
 
 static inline void uncore_box_init(struct intel_uncore_box *box)
 {
-	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
+	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
 		if (box->pmu->type->ops->init_box)
 			box->pmu->type->ops->init_box(box);
 	}
@@ -567,7 +567,7 @@ static inline void uncore_box_init(struct intel_uncore_box *box)
 
 static inline void uncore_box_exit(struct intel_uncore_box *box)
 {
-	if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
+	if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
 		if (box->pmu->type->ops->exit_box)
 			box->pmu->type->ops->exit_box(box);
 	}
-- 
2.54.0


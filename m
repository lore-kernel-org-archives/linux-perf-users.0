Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272D403126;
	Thu, 11 Jun 2026 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194179; cv=none; b=PYQpc1cd/iDCkEvUMXGH5Xy38rd+6PefH1SRprFdQe0zQGOsrRN7W+n/V7TWMBeQQNQAlCPFcyayS2LELeefNDy4f5Od2LisE5kCW3OgQHFcAcjVVdryyTET4SvBwxU5OEKtr+2atcc4qv8kw0Sb6U6lPnHAdDleulni/v/ABHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194179; c=relaxed/simple;
	bh=MV1EkIxxvXZf8rXD2E5tvqg4tr9V/ORdqtb5Drq2BYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFtbfANjvm6QRUj6gA35kgey9hznppcZmyZTVrNIHAslY1wZalFOB0EomJR1C0YtbgUeLcg34Ia+JE7uoVXkL1xyo/ziYvZ919i0Gigc38VDXY1BCMnsvu9GS1gXJ18DlKb2rzX4WeOxdEYPmaB6/xIXIVEkUjRv6QyZTPerZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goNsqC1h; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goNsqC1h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781194179; x=1812730179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MV1EkIxxvXZf8rXD2E5tvqg4tr9V/ORdqtb5Drq2BYQ=;
  b=goNsqC1h8EKdFCIcJR4CEX4HD3olPh94uTChM05K8AOxi/U5oXkSs8HZ
   MjWmYR6kDjmlwNdBJRVifparnSsuBzFoQI6k+ziefHOy/zoN4vZ6fNVMZ
   m8o7FJELO+vnZfDiDp2sZ9SAcpXnqejDPYIEOjiVHWDtOih5/ha7DvNNt
   2o1zi+0+sSzLeEMPOI242zQlOFh/QeqD6B29jqd6yk4DmV1Xdkju/pt0j
   S0N1C3l3fkVJo+yjhee7hRyrvPBct4vfe2SqcI3CAAtNJCO0/jNV1JPsq
   a5hRb+1ayBZkzAiY2gUNLD/GvTknZ+dSA2ockhTTP6QQh33j8qvQN6pQC
   Q==;
X-CSE-ConnectionGUID: vWVsxwJjQd6swjs3j2yHBw==
X-CSE-MsgGUID: irjzo87uTSeMdAF6yqNoGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81994969"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81994969"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:36 -0700
X-CSE-ConnectionGUID: kM3lZYNyRZSoY1x1mw/aKg==
X-CSE-MsgGUID: 62zP+JeDSpuOC31P1aJisg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246403591"
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
Subject: [PATCH V3 2/8] perf/x86/intel/uncore: Fix refcnt and other cleanups
Date: Thu, 11 Jun 2026 09:00:27 -0700
Message-ID: <20260611160033.66760-3-zide.chen@intel.com>
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

Fix typo UNCORE_BOX_FLAG_INITIATED to UNCORE_BOX_FLAG_INITIALIZED.

Rename the 'id' parameter in uncore_box_{ref,unref}() to 'die' to
reflect its actual meaning and be consistent with other functions.

box->refcnt is incremented in the PCI PMU register path but has never
been checked or decremented. Although for PCI PMUs box->refcnt
effectively tracks only a single user, add atomic_dec_return() in the
PCI PMU unregister path to make the reference counting complete and
consistent.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Instead of removing atomic_inc(&box->refcnt) in PMU register, add
  the corresponding atomic_dec_return(&box->refcnt) in PMU unregister.
  (Dapeng)
v2:
- Don't rename pmu->activeboxes and keep its semantics because in
  uncore_pci_remove() path, uncore_pci_pmu_unregister() won't be
  called for non-active boxes.
- Since pmu->activeboxes keeps its name, don't need to rename
  box->refcnt to box->cpu_refcnt.
---
 arch/x86/events/intel/uncore.c | 16 +++++++++-------
 arch/x86/events/intel/uncore.h |  6 +++---
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index b69b6a21d46b..21c8ed1628cb 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1255,8 +1255,10 @@ static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu, int die)
 	pmu->boxes[die] = NULL;
 	if (atomic_dec_return(&pmu->activeboxes) == 0)
 		uncore_pmu_unregister(pmu);
-	uncore_box_exit(box);
-	kfree(box);
+	if (atomic_dec_return(&box->refcnt) == 0) {
+		uncore_box_exit(box);
+		kfree(box);
+	}
 }
 
 static void uncore_pci_remove(struct pci_dev *pdev)
@@ -1518,7 +1520,7 @@ static void uncore_change_context(struct intel_uncore_type **uncores,
 		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
 }
 
-static void uncore_box_unref(struct intel_uncore_type **types, int id)
+static void uncore_box_unref(struct intel_uncore_type **types, int die)
 {
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
@@ -1529,7 +1531,7 @@ static void uncore_box_unref(struct intel_uncore_type **types, int id)
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[id];
+			box = pmu->boxes[die];
 			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
 				uncore_box_exit(box);
 		}
@@ -1604,14 +1606,14 @@ static int allocate_boxes(struct intel_uncore_type **types,
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
 
@@ -1619,7 +1621,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[id];
+			box = pmu->boxes[die];
 			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
 				uncore_box_init(box);
 		}
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c2e5ccb1d72c..bad5d8dec8e0 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
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


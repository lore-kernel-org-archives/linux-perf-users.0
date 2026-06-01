Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D93DCD8B;
	Mon,  1 Jun 2026 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333809; cv=none; b=lAcXYNI7FTDKOSlMmPk5k+YLqhvz5lpr+c2pE5cBLYE+ZzWi6jqbol/YpRQdJ4R57VnoTWiYRwU+Pis5LCWQyU8PkNVv82b93RMLoCYV3I6DIfIZIN5NWeo8Zlz3c1KDEh68ph0sL8VkAe7i6sdw9KfzYOYwB2ANDjDIrUb0MEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333809; c=relaxed/simple;
	bh=PY5SsiG8cUYZq6FTZ/7P0k8ypckh4FD+AdX/WHRh+wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmVRX927zgM4Y4b49uQSZpBpIP4UhL6t7da2TiMLmGlOBlbxuV6zuYElsMPZgLzbyIMA1S897/eIis8XOPm4q4FDv+WMZgQX9Rm7btJx2nDCgAZ+5PektmKLHB3mw+AEeDrLDxb5nzq6I3+vLhXchQu+4GSqQxiXDTGnG44LuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrwZ5Rm/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrwZ5Rm/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780333808; x=1811869808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PY5SsiG8cUYZq6FTZ/7P0k8ypckh4FD+AdX/WHRh+wk=;
  b=YrwZ5Rm/3Kk0t/tCiYWLgFgTa9gdPQz94WqK/wBi2xbZfAGeDORX4/4U
   keFG3yZdiUfEkIv46Nni5hUTKn0NMdgKN7sldi9y7VKThWrx5PczsJEBB
   PFF0IHN3OxduhBrOn/yBfhd9rHwewo1zahVHxEKakuOEyKJfio/FiI/CA
   k/YH/UkcoR4+krveZUFdXM5b6YMPpTCK/peVgArrRNF/n9eIa5fOd42zs
   OBsO1DWUIp/ymh/v9M1psI/u483Anjk0ti06cI19nxdUpcv/Jkf/mP4ti
   OrMDDhaf6Jj935L4bbLaFE9ztZLgLI0HLO6LngmRt8jyCTzqQ+0D5Pfvn
   g==;
X-CSE-ConnectionGUID: iAKK6BjSRByegvt6HZBHoQ==
X-CSE-MsgGUID: 1il34hL4SK+Pa7ALabo1WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98516980"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98516980"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:06 -0700
X-CSE-ConnectionGUID: URitPKX+R9qvfjPu4H45EA==
X-CSE-MsgGUID: s2NRHLCITbeLn+AvBu5lGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242585001"
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
Subject: [PATCH V2 2/8] perf/x86/intel/uncore: Fix refcnt and other cleanups
Date: Mon,  1 Jun 2026 10:01:08 -0700
Message-ID: <20260601170114.173359-3-zide.chen@intel.com>
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

Fix typo UNCORE_BOX_FLAG_INITIATED to UNCORE_BOX_FLAG_INITIALIZED.

Rename the 'id' parameter in uncore_box_{ref,unref}() to 'die' to
reflect its actual meaning and be consistent with other functions.

Remove the incorrect atomic_inc(&box->refcnt) from
uncore_pci_pmu_register(): PCI boxes are not tracked by refcnt,
and this call incorrectly increments it on a per-die basis.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2:
- Don't rename pmu->activeboxes and keep its semantics because in
  uncore_pci_remove() path, uncore_pci_pmu_unregister() won't be
  called for non-active boxes.
- Since pmu->activeboxes keeps it's name, don't need to rename
  box->refcnt to box->cpu_refcnt.
---
 arch/x86/events/intel/uncore.c | 11 +++++------
 arch/x86/events/intel/uncore.h |  6 +++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index b69b6a21d46b..d759888476c3 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1170,7 +1170,6 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 	if (!box)
 		return -ENOMEM;
 
-	atomic_inc(&box->refcnt);
 	box->dieid = die;
 	box->pci_dev = pdev;
 	box->pmu = pmu;
@@ -1518,7 +1517,7 @@ static void uncore_change_context(struct intel_uncore_type **uncores,
 		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
 }
 
-static void uncore_box_unref(struct intel_uncore_type **types, int id)
+static void uncore_box_unref(struct intel_uncore_type **types, int die)
 {
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
@@ -1529,7 +1528,7 @@ static void uncore_box_unref(struct intel_uncore_type **types, int id)
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[id];
+			box = pmu->boxes[die];
 			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
 				uncore_box_exit(box);
 		}
@@ -1604,14 +1603,14 @@ static int allocate_boxes(struct intel_uncore_type **types,
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
 
@@ -1619,7 +1618,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
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


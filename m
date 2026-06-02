Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96A364E9A;
	Tue,  2 Jun 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412279; cv=none; b=piE0c0jpA6ie6EOmUUyx4pmiM4yvOlYWE5kg4J/hbOdz7kusqPkldfD2h88vq/I4pkCdscVKuMkQD0Lhgueaqy3Z5tKnksnwMxisk32OlQJEDeZKZMvOrT9NbzBlV0pGOXmCZZRyiegbTJ+lcXA621knMdbzsuDztcYMuvsJvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412279; c=relaxed/simple;
	bh=lYcsPORKnxuunMCgSU5k6nxHhMkq2G0Rqn+l+mBnbPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InFrxL8e6K61+8A3F5GOpwtV36VkQRHEUNmHjquyl+kSHViYvDsMIL7+ZGKyKUsMUcYnRQO77s5rhNwRedRItiYEG84zdnS5owmp2WPf8zCsnNplOMdzkPAg95mR7y3369vZ0TGVckoweF5aqjkY6dDNAMC30ojfMsto0b2omEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6mxZc6N; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6mxZc6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780412279; x=1811948279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lYcsPORKnxuunMCgSU5k6nxHhMkq2G0Rqn+l+mBnbPU=;
  b=A6mxZc6NZe0c41od09HXBlC2x8EM8kGLyMwL1i/VOYWOn+Q2k/0rpzBu
   VEETD7EHJJooo4NpexBIIJX+KM3ZOoG1/3BF8NZn6kgMKLtoAcc+em8Jl
   Vu+vYsi5j44UWfW+QrOdGfVCgoZeB1nttMF4NOR2+IrlCGCUAuhC2Iaq7
   QNbnFmhmwTft8YuF/Z0+GQ9LpU93tDCfkM4fegyoyk/ANkJFgg4wvyg8p
   rnLjEqbJC1DDgADJIdpHloK6gLMvIsqxN3uk80hmTeTs5OM4Avl7EdWaW
   aZKWWGQhF8B2zdXh3oBMC/vPQ2cgO4gvf8w6FRwlNVzbbPfpXGA9r8kle
   g==;
X-CSE-ConnectionGUID: KxkT3UhQRc6Yy54RNpVE+Q==
X-CSE-MsgGUID: BuJn3hDvQVCYr56bpFPgng==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="103859986"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="103859986"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:55 -0700
X-CSE-ConnectionGUID: xVgZT30YQ3m+M8OoKw+XbQ==
X-CSE-MsgGUID: gnu0XselQa2A9Nuc6b5HCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243095621"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:57:54 -0700
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
Subject: [PATCH V3 2/7] perf/x86/intel/uncore: Guard against invalid box control address
Date: Tue,  2 Jun 2026 07:49:03 -0700
Message-ID: <20260602144908.263680-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602144908.263680-1-zide.chen@intel.com>
References: <20260602144908.263680-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Theoretically, intel_uncore_find_discovery_unit() could return NULL,
e.g., when a CPU die is offline during uncore enumeration and its PMU
units are not added to the discovery RB-tree.

Guard against a NULL return value and the resulting invalid box control
address (0) before accessing hardware.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- New patch.
- Address pre-existing invalid box control address issue (Sashiko).
---
 arch/x86/events/intel/uncore_discovery.c | 33 +++++++++++++++++-------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 60e1200c4691..af7e80fee81f 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -490,17 +490,28 @@ static u64 intel_generic_uncore_box_ctl(struct intel_uncore_box *box)
 
 void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
 {
-	wrmsrq(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
+	u64 box_ctl = intel_generic_uncore_box_ctl(box);
+
+	if (!box_ctl)
+		return;
+
+	wrmsrq(box_ctl, GENERIC_PMON_BOX_CTL_INT);
 }
 
 void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
 {
-	wrmsrq(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
+	u64 box_ctl = intel_generic_uncore_box_ctl(box);
+
+	if (box_ctl)
+		wrmsrq(box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
 }
 
 void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
-	wrmsrq(intel_generic_uncore_box_ctl(box), 0);
+	u64 box_ctl = intel_generic_uncore_box_ctl(box);
+
+	if (box_ctl)
+		wrmsrq(box_ctl, 0);
 }
 
 static void intel_generic_uncore_msr_enable_event(struct intel_uncore_box *box,
@@ -549,6 +560,7 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 
 	if (box->pci_dev) {
 		box_ctl = UNCORE_DISCOVERY_PCI_BOX_CTRL(box_ctl);
+
 		hwc->config_base = box_ctl + uncore_pci_event_ctl(box, hwc->idx);
 		hwc->event_base  = box_ctl + uncore_pci_perf_ctr(box, hwc->idx);
 		return true;
@@ -567,27 +579,30 @@ static inline int intel_pci_uncore_box_ctl(struct intel_uncore_box *box)
 
 void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 {
-	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = intel_pci_uncore_box_ctl(box);
 
+	if (!box_ctl)
+		return;
+
 	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
-	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
+	pci_write_config_dword(box->pci_dev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
 }
 
 void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 {
-	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = intel_pci_uncore_box_ctl(box);
 
-	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
+	if (box_ctl)
+		pci_write_config_dword(box->pci_dev, box_ctl,
+				       GENERIC_PMON_BOX_CTL_FRZ);
 }
 
 void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
 {
-	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = intel_pci_uncore_box_ctl(box);
 
-	pci_write_config_dword(pdev, box_ctl, 0);
+	if (box_ctl)
+		pci_write_config_dword(box->pci_dev, box_ctl, 0);
 }
 
 static void intel_generic_uncore_pci_enable_event(struct intel_uncore_box *box,
-- 
2.54.0


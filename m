Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59739150A;
	Wed, 27 May 2026 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895234; cv=none; b=P4LyGfdDCCDZXvlCGGanwbrEcvGubTEb1CBO6XUzV+1KhI+nsywuod3Sg62Js81jYt5eFRrEcvn4CVRxZUgGJwzKyLDgs1czhqXIYBYamhpd6PFbLv+acnpTVjQrxSS5P7k0cBgRvDvxTb+rb07O+PsKKyikhQxZOFRQpSKJq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895234; c=relaxed/simple;
	bh=YCnjyhI8LHaCXQGeCVM8JQC7MxkXLy6xTEBr3TNFRuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hm0OFr6DbL7BT0pwCNR8Z9H5y8lLKYUiBchnFg/2yJNVwimvVbNSNCQELO2su0cLJtfrK4cDi9YEbqdLTqVF5kjjzVb4EZo3zZvvQCeevr/U5hTm0IxI1rYGBF6Qpxlx8O0D+Rcj4yzva3Hbojplt6VIE8duDW02zn3c/AYZOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHvTO03u; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHvTO03u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779895233; x=1811431233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YCnjyhI8LHaCXQGeCVM8JQC7MxkXLy6xTEBr3TNFRuU=;
  b=hHvTO03uxk6aS+fMSyK99FsLsFMS7KYMrXxk0gAIwZ0AHc8liK5A4iLn
   UlPvMeeISIZbp7Fi1qOvJKIRE8r4D6eMdFEmOBIXOLTW7SOOUCRNK/TU3
   tE1d1WY2UR2qGmXOwNeN0HAAowG1YiQhbYMgd8aid4Yq4rYtshhMgeNhW
   q7HQ/RrCxYJZwbkR7UJrP01qY6f200N/dTR4Zb7rrFAr5fH2qHhw3QCUJ
   KA4JclI+3NvN3AybDLsrpQZs3ER86GD3rE966+ROoiihwmW/pKn6jwxSi
   E8i7xSMoYraTO3Ho3AHywwqsSslmHeCg6Cwlx6EkufrIInn0kbfyEoIJj
   Q==;
X-CSE-ConnectionGUID: PYgeCp7qQqmrzr4UCeKZzg==
X-CSE-MsgGUID: SoQ23MKoQjGIf+zcBXEEBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="98149309"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="98149309"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:31 -0700
X-CSE-ConnectionGUID: 4c/GjJmIQR+LmgeLboh5fA==
X-CSE-MsgGUID: DUJhBM4aSZakm7XLKrueKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241231394"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:20:31 -0700
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
Subject: [PATCH V2 2/7] perf/x86/intel/uncore: Guard against invalid box control address
Date: Wed, 27 May 2026 08:11:49 -0700
Message-ID: <20260527151154.130505-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527151154.130505-1-zide.chen@intel.com>
References: <20260527151154.130505-1-zide.chen@intel.com>
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

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- New patch.
- Address pre-existing invalid box control address issue (Sashiko).
---
 arch/x86/events/intel/uncore_discovery.c | 36 ++++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 60e1200c4691..af2217b44a81 100644
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
@@ -549,6 +560,10 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 
 	if (box->pci_dev) {
 		box_ctl = UNCORE_DISCOVERY_PCI_BOX_CTRL(box_ctl);
+
+		if (!box_ctl)
+			return false;
+
 		hwc->config_base = box_ctl + uncore_pci_event_ctl(box, hwc->idx);
 		hwc->event_base  = box_ctl + uncore_pci_perf_ctr(box, hwc->idx);
 		return true;
@@ -567,27 +582,30 @@ static inline int intel_pci_uncore_box_ctl(struct intel_uncore_box *box)
 
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


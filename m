Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA493A3E67;
	Mon, 30 Mar 2026 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906389; cv=none; b=r6kXye+9xvHSW9hCpMpdyWDqoztpgHGSgv061ZGmyFz9mLAJHOAkzHY88S6axoJSNJN16pfC6uJBECKcdMNQQ29rY5wRyDy64jbkey2djsXcZr3OEEbIggPg4Yxe5SmaprfviAp4DxP77mWWlpnJ3fGPCyQ6H7xvG0+Z8kG1Q3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906389; c=relaxed/simple;
	bh=s9AYQcY7BMrLW8mIR2aeHyxZbtPFcbCalGfICe0htbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPej04Y1C+0GJmGZE/UD3zgbtYrihozQe+CZKwTO7jsCllJ3DGzEsn7TKQDs7rt+y8CcMV3jZMH+WlMXECG5sSHyL0Ykl++7ZxQXJy7rZvv6eLdZHcjp5E1oPdHUxFYsF7NKVmFtahfP5YC8ERG/94hfe8suBaAldgiYR37SKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUPScYrG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUPScYrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774906388; x=1806442388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s9AYQcY7BMrLW8mIR2aeHyxZbtPFcbCalGfICe0htbM=;
  b=nUPScYrGMzfzAvtU2PV8toovuyBwLwR5agipq8iNyq1HfsEDqoYpEHrG
   E9vQqWFuFADnXYMxdI9Lee+cO5G+rRnz3cgICEhpj1vVwj4B4sjhNRD4u
   7XS9DYk83cajaNuQfeeZPK9qbcOHp784JGMTcKpeFpd5xjtYw76yaas3R
   OGgySV6MaVdSD9Rr0MrH472E4YG2XaOjKqpXRsOVPftXCVnLMxhcOT87B
   cW9OBF5Gy4jn5Nzg5WlaUR5xBbsqnEtgCZdbc96DmHuXuH6XPaE+QrBJs
   AQFhuVs0fwLPgqgJCKwfTG7ptIM2TM6mhpi5DSm3MFvBTrwV3ZramdPTb
   g==;
X-CSE-ConnectionGUID: UlgZd6dVRYG0b1pikv5VmQ==
X-CSE-MsgGUID: EWn2gZA/TXuXNedKOD1anA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="101366832"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="101366832"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:33:08 -0700
X-CSE-ConnectionGUID: yb/AzzijQACslFfCe8/t/g==
X-CSE-MsgGUID: ti4QAWreTZSRuoRvxty9pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="227779543"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:33:07 -0700
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
	Zide Chen <zide.chen@intel.com>,
	Steve Wahl <steve.wahl@hpe.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH V6 4/5] perf/x86/intel/uncore: Fix PMON enumeration with NUMA disabled
Date: Mon, 30 Mar 2026 14:24:43 -0700
Message-ID: <20260330212444.117325-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330212444.117325-1-zide.chen@intel.com>
References: <20260330212444.117325-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When NUMA is disabled on a NUMA-capable platform, UPI and M3UPI PMON
units are not enumerated.

In this case, pcibus_to_node() always returns NUMA_NO_NODE, causing
uncore_device_to_die() to return -1 for all PCI devices. As a result,
the corresponding PMON units are not added to the RB tree.

These PMON units are per-die resources, and their utility when NUMA is
disabled is limited.  The driver does not prohibit their use, and the
enumeration should still work correctly.

Fix this by using uncore_pcibus_to_dieid(), which works regardless of
whether NUMA is enabled.  This requires calling
snbep_pci2phy_map_init() in spr_uncore_pci_init().

Since pci_init() is called before mmio_init(), remove the redundant
snbep_pci2phy_map_init() call from spr_uncore_mmio_init().  If
snbep_pci2phy_map_init() fails, uncore driver should be bailed out,
so the fallback path in spr_uncore_mmio_init() can be removed.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V6:
- Split from patch v5 3/4.
- Remove the redundant call in spr_uncore_mmio_init().
- Update commit messages.
---
 arch/x86/events/intel/uncore.c       |  1 +
 arch/x86/events/intel/uncore_snbep.c | 26 +++++++++++---------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 786bd51a0d89..e9cc1ba921c5 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -67,6 +67,7 @@ int uncore_die_to_segment(int die)
 	return bus ? pci_domain_nr(bus) : -EINVAL;
 }
 
+/* Note: This API can only be used when NUMA information is available. */
 int uncore_device_to_die(struct pci_dev *dev)
 {
 	int node = pcibus_to_node(dev->bus);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 8ee06d4659bb..73da1e88e286 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6415,7 +6415,7 @@ static void spr_update_device_location(int type_id)
 
 	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
 
-		die = uncore_device_to_die(dev);
+		die = uncore_pcibus_to_dieid(dev->bus);
 		if (die < 0)
 			continue;
 
@@ -6439,6 +6439,10 @@ static void spr_update_device_location(int type_id)
 
 int spr_uncore_pci_init(void)
 {
+	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
+	if (ret)
+		return ret;
+
 	/*
 	 * The discovery table of UPI on some SPR variant is broken,
 	 * which impacts the detection of both UPI and M3UPI uncore PMON.
@@ -6460,21 +6464,13 @@ int spr_uncore_pci_init(void)
 
 void spr_uncore_mmio_init(void)
 {
-	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
+						 UNCORE_SPR_MMIO_EXTRA_UNCORES,
+						 spr_mmio_uncores,
+						 UNCORE_SPR_NUM_UNCORE_TYPES,
+						 spr_uncores);
 
-	if (ret) {
-		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
-							 UNCORE_SPR_NUM_UNCORE_TYPES,
-							 spr_uncores);
-	} else {
-		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
-							 UNCORE_SPR_MMIO_EXTRA_UNCORES,
-							 spr_mmio_uncores,
-							 UNCORE_SPR_NUM_UNCORE_TYPES,
-							 spr_uncores);
-
-		spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;
-	}
+	spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;
 }
 
 /* end of SPR uncore support */
-- 
2.53.0


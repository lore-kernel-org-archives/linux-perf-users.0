Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C215B998;
	Wed, 31 Dec 2025 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221382; cv=none; b=hEfw32Hp466Uwij7f/abx7irLwviT60pXaYapqMVD8zGikVuFxJHoVkDa7CWvPpNF2qcKawhnqYr9YqHM1GFbSWcWJr10AZetMbprZkXXZ/LUDzbHJptBvw+TnXXcXe+jqhs2TwQHbm77LcSu3V0xC+/82QJ7+B+q00nIIyyugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221382; c=relaxed/simple;
	bh=+B9k2LapldhEnhYpbP7FbCC2iA89rokPv+/1k44Le5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXuvDOKXopDdigqgk44MVP60Vk/v2aXEGmVEvp5UUhqpARF+76WUuV45zWh6PgIW/3BZvyrwhvV6otx8CoJfd31nfGtRRmniZZengybKizP3id5kmb+rri2Ot2Y4Pxcc9crJRThzdX1ZRQ2VaW2xqkbpRNNVmOFXZPnT25yXUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MisbDMzt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MisbDMzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221381; x=1798757381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+B9k2LapldhEnhYpbP7FbCC2iA89rokPv+/1k44Le5c=;
  b=MisbDMztjaRrLDvi/HcHU7s2xdB/zbfR2JhDEVq5/LJSSU8O8F+3ojej
   gnquxSzaDXVU7RkgB97Y/Xy3ylOGff0wXER7Fwh0EKjJp5Zt39gtFwy0J
   BCfgmmnOsJiI2rTsV2g5hsyg4KvUhqk/BA8doMisC+6iT/H2R8HbMl91r
   WY4sOlv3/YO0X9SJQnNK5XAb3HKXWdMV+dt+8G28w1re0N3LiBL6NuvWz
   tlf5YSgkbTT3mAoFRcbgVIwkcr8u0Y5dd4kipFu/u7AlCcFbpSQVftW2U
   ED7xtUBNpFtD9ZU0BKteU0uXMbv485LdmuPEcraVHNns7KmwnAP5hYwqN
   w==;
X-CSE-ConnectionGUID: GZEoyy7oT7GxQKDWTESd+g==
X-CSE-MsgGUID: 1+fen45ZQYqMhfCI8pDUjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816603"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816603"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:39 -0800
X-CSE-ConnectionGUID: 3xG7iYO9QMGihn0h40zxpw==
X-CSE-MsgGUID: mUycKkQuQtGKmD+Orxqr1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611004"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:39 -0800
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
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: [PATCH V2 01/13] perf/x86/intel/uncore: Move uncore discovery init struct to header
Date: Wed, 31 Dec 2025 14:42:18 -0800
Message-ID: <20251231224233.113839-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251231224233.113839-1-zide.chen@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The discovery base MSR or PCI device is platform-specific and must be
defined statically in the per-platform init table and passed to the
discovery code.

Move the definition of struct intel_uncore_init_fun to uncore.h so it
can be accessed by discovery code, and rename it to reflect that it
now carries more than just init callbacks.

Shorten intel_uncore_has_discovery_tables[_pci/msr] to
uncore_discovery[_pci/msr] for improved readability and alignment.

Drop the `intel_` prefix from new names since the code is under the
intel directory and long identifiers make alignment harder.  Further
cleanups will continue removing `intel_` prefixes.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2: New patch

 arch/x86/events/intel/uncore.c           | 72 ++++++++++--------------
 arch/x86/events/intel/uncore.h           | 10 ++++
 arch/x86/events/intel/uncore_discovery.c | 12 ++--
 arch/x86/events/intel/uncore_discovery.h |  2 +-
 4 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e228e564b15e..cd561290be8c 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1697,133 +1697,123 @@ static int __init uncore_mmio_init(void)
 	return ret;
 }
 
-struct intel_uncore_init_fun {
-	void	(*cpu_init)(void);
-	int	(*pci_init)(void);
-	void	(*mmio_init)(void);
-	/* Discovery table is required */
-	bool	use_discovery;
-	/* The units in the discovery table should be ignored. */
-	int	*uncore_units_ignore;
-};
-
-static const struct intel_uncore_init_fun nhm_uncore_init __initconst = {
+static const struct uncore_plat_init nhm_uncore_init __initconst = {
 	.cpu_init = nhm_uncore_cpu_init,
 };
 
-static const struct intel_uncore_init_fun snb_uncore_init __initconst = {
+static const struct uncore_plat_init snb_uncore_init __initconst = {
 	.cpu_init = snb_uncore_cpu_init,
 	.pci_init = snb_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun ivb_uncore_init __initconst = {
+static const struct uncore_plat_init ivb_uncore_init __initconst = {
 	.cpu_init = snb_uncore_cpu_init,
 	.pci_init = ivb_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun hsw_uncore_init __initconst = {
+static const struct uncore_plat_init hsw_uncore_init __initconst = {
 	.cpu_init = snb_uncore_cpu_init,
 	.pci_init = hsw_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun bdw_uncore_init __initconst = {
+static const struct uncore_plat_init bdw_uncore_init __initconst = {
 	.cpu_init = snb_uncore_cpu_init,
 	.pci_init = bdw_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun snbep_uncore_init __initconst = {
+static const struct uncore_plat_init snbep_uncore_init __initconst = {
 	.cpu_init = snbep_uncore_cpu_init,
 	.pci_init = snbep_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun nhmex_uncore_init __initconst = {
+static const struct uncore_plat_init nhmex_uncore_init __initconst = {
 	.cpu_init = nhmex_uncore_cpu_init,
 };
 
-static const struct intel_uncore_init_fun ivbep_uncore_init __initconst = {
+static const struct uncore_plat_init ivbep_uncore_init __initconst = {
 	.cpu_init = ivbep_uncore_cpu_init,
 	.pci_init = ivbep_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun hswep_uncore_init __initconst = {
+static const struct uncore_plat_init hswep_uncore_init __initconst = {
 	.cpu_init = hswep_uncore_cpu_init,
 	.pci_init = hswep_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun bdx_uncore_init __initconst = {
+static const struct uncore_plat_init bdx_uncore_init __initconst = {
 	.cpu_init = bdx_uncore_cpu_init,
 	.pci_init = bdx_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun knl_uncore_init __initconst = {
+static const struct uncore_plat_init knl_uncore_init __initconst = {
 	.cpu_init = knl_uncore_cpu_init,
 	.pci_init = knl_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun skl_uncore_init __initconst = {
+static const struct uncore_plat_init skl_uncore_init __initconst = {
 	.cpu_init = skl_uncore_cpu_init,
 	.pci_init = skl_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun skx_uncore_init __initconst = {
+static const struct uncore_plat_init skx_uncore_init __initconst = {
 	.cpu_init = skx_uncore_cpu_init,
 	.pci_init = skx_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun icl_uncore_init __initconst = {
+static const struct uncore_plat_init icl_uncore_init __initconst = {
 	.cpu_init = icl_uncore_cpu_init,
 	.pci_init = skl_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun tgl_uncore_init __initconst = {
+static const struct uncore_plat_init tgl_uncore_init __initconst = {
 	.cpu_init = tgl_uncore_cpu_init,
 	.mmio_init = tgl_uncore_mmio_init,
 };
 
-static const struct intel_uncore_init_fun tgl_l_uncore_init __initconst = {
+static const struct uncore_plat_init tgl_l_uncore_init __initconst = {
 	.cpu_init = tgl_uncore_cpu_init,
 	.mmio_init = tgl_l_uncore_mmio_init,
 };
 
-static const struct intel_uncore_init_fun rkl_uncore_init __initconst = {
+static const struct uncore_plat_init rkl_uncore_init __initconst = {
 	.cpu_init = tgl_uncore_cpu_init,
 	.pci_init = skl_uncore_pci_init,
 };
 
-static const struct intel_uncore_init_fun adl_uncore_init __initconst = {
+static const struct uncore_plat_init adl_uncore_init __initconst = {
 	.cpu_init = adl_uncore_cpu_init,
 	.mmio_init = adl_uncore_mmio_init,
 };
 
-static const struct intel_uncore_init_fun mtl_uncore_init __initconst = {
+static const struct uncore_plat_init mtl_uncore_init __initconst = {
 	.cpu_init = mtl_uncore_cpu_init,
 	.mmio_init = adl_uncore_mmio_init,
 };
 
-static const struct intel_uncore_init_fun lnl_uncore_init __initconst = {
+static const struct uncore_plat_init lnl_uncore_init __initconst = {
 	.cpu_init = lnl_uncore_cpu_init,
 	.mmio_init = lnl_uncore_mmio_init,
 };
 
-static const struct intel_uncore_init_fun ptl_uncore_init __initconst = {
+static const struct uncore_plat_init ptl_uncore_init __initconst = {
 	.cpu_init = ptl_uncore_cpu_init,
 	.mmio_init = ptl_uncore_mmio_init,
 	.use_discovery = true,
 };
 
-static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
+static const struct uncore_plat_init icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
 	.mmio_init = icx_uncore_mmio_init,
 };
 
-static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
+static const struct uncore_plat_init snr_uncore_init __initconst = {
 	.cpu_init = snr_uncore_cpu_init,
 	.pci_init = snr_uncore_pci_init,
 	.mmio_init = snr_uncore_mmio_init,
 };
 
-static const struct intel_uncore_init_fun spr_uncore_init __initconst = {
+static const struct uncore_plat_init spr_uncore_init __initconst = {
 	.cpu_init = spr_uncore_cpu_init,
 	.pci_init = spr_uncore_pci_init,
 	.mmio_init = spr_uncore_mmio_init,
@@ -1831,7 +1821,7 @@ static const struct intel_uncore_init_fun spr_uncore_init __initconst = {
 	.uncore_units_ignore = spr_uncore_units_ignore,
 };
 
-static const struct intel_uncore_init_fun gnr_uncore_init __initconst = {
+static const struct uncore_plat_init gnr_uncore_init __initconst = {
 	.cpu_init = gnr_uncore_cpu_init,
 	.pci_init = gnr_uncore_pci_init,
 	.mmio_init = gnr_uncore_mmio_init,
@@ -1839,7 +1829,7 @@ static const struct intel_uncore_init_fun gnr_uncore_init __initconst = {
 	.uncore_units_ignore = gnr_uncore_units_ignore,
 };
 
-static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
+static const struct uncore_plat_init generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 	.pci_init = intel_uncore_generic_uncore_pci_init,
 	.mmio_init = intel_uncore_generic_uncore_mmio_init,
@@ -1910,7 +1900,7 @@ MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
 static int __init intel_uncore_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct intel_uncore_init_fun *uncore_init;
+	struct uncore_plat_init *uncore_init;
 	int pret = 0, cret = 0, mret = 0, ret;
 
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
@@ -1921,16 +1911,16 @@ static int __init intel_uncore_init(void)
 
 	id = x86_match_cpu(intel_uncore_match);
 	if (!id) {
-		if (!uncore_no_discover && intel_uncore_has_discovery_tables(NULL))
-			uncore_init = (struct intel_uncore_init_fun *)&generic_uncore_init;
+		if (!uncore_no_discover && uncore_discovery(NULL))
+			uncore_init = (struct uncore_plat_init *)&generic_uncore_init;
 		else
 			return -ENODEV;
 	} else {
-		uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
+		uncore_init = (struct uncore_plat_init *)id->driver_data;
 		if (uncore_no_discover && uncore_init->use_discovery)
 			return -ENODEV;
 		if (uncore_init->use_discovery &&
-		    !intel_uncore_has_discovery_tables(uncore_init->uncore_units_ignore))
+		    !uncore_discovery(uncore_init))
 			return -ENODEV;
 	}
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index d8815fff7588..568536ef28ee 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -47,6 +47,16 @@ struct uncore_event_desc;
 struct freerunning_counters;
 struct intel_uncore_topology;
 
+struct uncore_plat_init {
+	void	(*cpu_init)(void);
+	int	(*pci_init)(void);
+	void	(*mmio_init)(void);
+	/* Discovery table is required */
+	bool	use_discovery;
+	/* The units in the discovery table should be ignored. */
+	int	*uncore_units_ignore;
+};
+
 struct intel_uncore_type {
 	const char *name;
 	int num_counters;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 7d57ce706feb..d39f6a0b8cc3 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -350,7 +350,7 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 	return __parse_discovery_table(addr, die, parsed, ignore);
 }
 
-static bool intel_uncore_has_discovery_tables_pci(int *ignore)
+static bool uncore_discovery_pci(int *ignore)
 {
 	u32 device, val, entry_id, bar_offset;
 	int die, dvsec = 0, ret = true;
@@ -399,7 +399,7 @@ static bool intel_uncore_has_discovery_tables_pci(int *ignore)
 	return ret;
 }
 
-static bool intel_uncore_has_discovery_tables_msr(int *ignore)
+static bool uncore_discovery_msr(int *ignore)
 {
 	unsigned long *die_mask;
 	bool parsed = false;
@@ -432,10 +432,12 @@ static bool intel_uncore_has_discovery_tables_msr(int *ignore)
 	return parsed;
 }
 
-bool intel_uncore_has_discovery_tables(int *ignore)
+bool uncore_discovery(struct uncore_plat_init *init)
 {
-	return intel_uncore_has_discovery_tables_msr(ignore) ||
-	       intel_uncore_has_discovery_tables_pci(ignore);
+	int *ignore = init ? init->uncore_units_ignore : NULL;
+
+	return uncore_discovery_msr(ignore) ||
+	       uncore_discovery_pci(ignore);
 }
 
 void intel_uncore_clear_discovery_tables(void)
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index dff75c98e22f..dfc237a2b6df 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -136,7 +136,7 @@ struct intel_uncore_discovery_type {
 	u16		num_units;	/* number of units */
 };
 
-bool intel_uncore_has_discovery_tables(int *ignore);
+bool uncore_discovery(struct uncore_plat_init *init);
 void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
-- 
2.52.0


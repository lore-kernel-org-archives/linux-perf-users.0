Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373C2DC33D;
	Fri, 12 Dec 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573642; cv=none; b=YqibE6gKZZUGYUxP4aZjDmIxjteoaGStsnrRW8MRnaIEcmJe7TPugOdjMQ1B6rHiXajP0qW1ohlUqbjwP9/fC/Fl4jejmj5i8UWw/KI1pOIWpEEEElHnS6KQq+aOI+dJjpbQv6wBQDhrH4PPLrOlj0Vb+NI14mrJay4i1gQRv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573642; c=relaxed/simple;
	bh=9qMZQJxNrEF5uygRqXEpjt5PKtGUbE6Qh0BgeE9WFTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM3ubTON1LAOxYLdrK1F3lNUD6tAE3QO8kdS3d40aSulCr2xkbEC4p6G0iQushLD24y5aqFNLK0ueVKbcqz1+Wdcffk3uUoJZbRQ3eq0SQqLkLcqrIodfKg0GJB0J8rzFbMc6Mybd+EmA1wt/qAVAwIXbbZSzByvujeEL+ZShh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lys+6xof; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lys+6xof"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765573641; x=1797109641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9qMZQJxNrEF5uygRqXEpjt5PKtGUbE6Qh0BgeE9WFTc=;
  b=Lys+6xof8yWVqPGYv4y0PYCweImDkJDFMeDkHeQSn/B2KXUqSKxaN15e
   Y75hCu9yzpf/K6vR0KOpEUoBMXzBZeXxPLW5+jb1BPIUHhMIl9XTI9CMf
   SEKlRY8DFrx47jcnPNk6Y1jKVQVRm1J+JDjOlGL7Y9Tv82xUojL7Lq/C4
   Hc0MPLPe1JPn5p5sc3du2LgXRJ8K74SOTQrs1EDPobBwqDhPfkZjiRHY/
   mSkd/q6oWAmO0gxus/+YsDlICOH5nX9wK4Espk9GBQfBtiTU32gw1qRVH
   7yc9lZuG1YHrtDvjUUB//WACJAe+ZemaIcLbB1cZA2fhDN0QWO1xWTIlk
   Q==;
X-CSE-ConnectionGUID: L0bq9EhDRoqATlKTHDRK9A==
X-CSE-MsgGUID: MtZryYq0Ri6zxMqA+f3eMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="67333569"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="67333569"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:17 -0800
X-CSE-ConnectionGUID: 4Lz4UcscRJiIzKQs0hYohQ==
X-CSE-MsgGUID: 9Cld0gp6T3eC4qCONQVCGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="202269519"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:16 -0800
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
Subject: [PATCH 1/7] perf/x86/intel/uncore: Add dual PCI/MSR discovery support
Date: Fri, 12 Dec 2025 13:00:01 -0800
Message-ID: <20251212210007.13986-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212210007.13986-1-zide.chen@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On DMR platforms, IMH discovery tables are enumerated via a PCI device,
while CBB tables are enumerated via an MSR.  This differs from prior
CPUs, which relied exclusively on either PCI or MSR.

Extend intel_uncore_has_discovery_tables() to support platforms that
require discovery through both PCI and MSR.

DMR CBB uncore uses MSR 0x710 for discovery instead of MSR 0x201e.
Introduce a discovery_msr field to store platform-specific MSR values.

Similarly, add a discovery_pci field so that DMR can enumerate through
PCI device 0x9a1 rather than 0x9a7.

In the !x86_match_cpu() fallback path, has_generic_discovery_table()
is removed because it does not consider multiple possible PCI devices
and its performance is not important here.  Only probe MSR 0x201e to
keep the code simple.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c           | 30 ++++++++++++-----
 arch/x86/events/intel/uncore_discovery.c | 42 +++++++-----------------
 arch/x86/events/intel/uncore_discovery.h |  2 +-
 3 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a762f7f5b161..ecf500470f8e 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1703,8 +1703,10 @@ struct intel_uncore_init_fun {
 	void	(*cpu_init)(void);
 	int	(*pci_init)(void);
 	void	(*mmio_init)(void);
-	/* Discovery table is required */
-	bool	use_discovery;
+	/* MSR carries the Discovery table base address */
+	u32	discovery_msr;
+	/* PCI device carries the Discovery table base address */
+	u32	discovery_pci;
 	/* The units in the discovery table should be ignored. */
 	int	*uncore_units_ignore;
 };
@@ -1810,7 +1812,7 @@ static const struct intel_uncore_init_fun lnl_uncore_init __initconst = {
 static const struct intel_uncore_init_fun ptl_uncore_init __initconst = {
 	.cpu_init = ptl_uncore_cpu_init,
 	.mmio_init = ptl_uncore_mmio_init,
-	.use_discovery = true,
+	.discovery_msr = UNCORE_DISCOVERY_MSR,
 };
 
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
@@ -1829,7 +1831,7 @@ static const struct intel_uncore_init_fun spr_uncore_init __initconst = {
 	.cpu_init = spr_uncore_cpu_init,
 	.pci_init = spr_uncore_pci_init,
 	.mmio_init = spr_uncore_mmio_init,
-	.use_discovery = true,
+	.discovery_pci = UNCORE_DISCOVERY_TABLE_DEVICE,
 	.uncore_units_ignore = spr_uncore_units_ignore,
 };
 
@@ -1837,7 +1839,7 @@ static const struct intel_uncore_init_fun gnr_uncore_init __initconst = {
 	.cpu_init = gnr_uncore_cpu_init,
 	.pci_init = gnr_uncore_pci_init,
 	.mmio_init = gnr_uncore_mmio_init,
-	.use_discovery = true,
+	.discovery_pci = UNCORE_DISCOVERY_TABLE_DEVICE,
 	.uncore_units_ignore = gnr_uncore_units_ignore,
 };
 
@@ -1908,6 +1910,11 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
 
+static bool ucore_use_discovery(struct intel_uncore_init_fun *uncore_init)
+{
+	return (uncore_init->discovery_pci || uncore_init->discovery_msr);
+}
+
 static int __init intel_uncore_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -1922,16 +1929,21 @@ static int __init intel_uncore_init(void)
 
 	id = x86_match_cpu(intel_uncore_match);
 	if (!id) {
-		if (!uncore_no_discover && intel_uncore_has_discovery_tables(NULL))
+		if (!uncore_no_discover &&
+		    intel_uncore_has_discovery_tables(NULL,
+				UNCORE_DISCOVERY_MSR, PCI_ANY_ID))
 			uncore_init = (struct intel_uncore_init_fun *)&generic_uncore_init;
 		else
 			return -ENODEV;
 	} else {
 		uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
-		if (uncore_no_discover && uncore_init->use_discovery)
+		if (uncore_no_discover && ucore_use_discovery(uncore_init))
 			return -ENODEV;
-		if (uncore_init->use_discovery &&
-		    !intel_uncore_has_discovery_tables(uncore_init->uncore_units_ignore))
+		if (ucore_use_discovery(uncore_init) &&
+		    !intel_uncore_has_discovery_tables(
+			uncore_init->uncore_units_ignore,
+			uncore_init->discovery_msr,
+			uncore_init->discovery_pci))
 			return -ENODEV;
 	}
 
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 7d57ce706feb..86373b00e966 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -12,24 +12,6 @@
 static struct rb_root discovery_tables = RB_ROOT;
 static int num_discovered_types[UNCORE_ACCESS_MAX];
 
-static bool has_generic_discovery_table(void)
-{
-	struct pci_dev *dev;
-	int dvsec;
-
-	dev = pci_get_device(PCI_VENDOR_ID_INTEL, UNCORE_DISCOVERY_TABLE_DEVICE, NULL);
-	if (!dev)
-		return false;
-
-	/* A discovery table device has the unique capability ID. */
-	dvsec = pci_find_next_ext_capability(dev, 0, UNCORE_EXT_CAP_ID_DISCOVERY);
-	pci_dev_put(dev);
-	if (dvsec)
-		return true;
-
-	return false;
-}
-
 static int logical_die_id;
 
 static int get_device_die_id(struct pci_dev *dev)
@@ -350,18 +332,13 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 	return __parse_discovery_table(addr, die, parsed, ignore);
 }
 
-static bool intel_uncore_has_discovery_tables_pci(int *ignore)
+static bool intel_uncore_has_discovery_tables_pci(int *ignore, u32 device)
 {
-	u32 device, val, entry_id, bar_offset;
+	u32 val, entry_id, bar_offset;
 	int die, dvsec = 0, ret = true;
 	struct pci_dev *dev = NULL;
 	bool parsed = false;
 
-	if (has_generic_discovery_table())
-		device = UNCORE_DISCOVERY_TABLE_DEVICE;
-	else
-		device = PCI_ANY_ID;
-
 	/*
 	 * Start a new search and iterates through the list of
 	 * the discovery table devices.
@@ -399,7 +376,7 @@ static bool intel_uncore_has_discovery_tables_pci(int *ignore)
 	return ret;
 }
 
-static bool intel_uncore_has_discovery_tables_msr(int *ignore)
+static bool intel_uncore_has_discovery_tables_msr(int *ignore, u32 msr)
 {
 	unsigned long *die_mask;
 	bool parsed = false;
@@ -417,7 +394,7 @@ static bool intel_uncore_has_discovery_tables_msr(int *ignore)
 		if (__test_and_set_bit(die, die_mask))
 			continue;
 
-		if (rdmsrq_safe_on_cpu(cpu, UNCORE_DISCOVERY_MSR, &base))
+		if (rdmsrq_safe_on_cpu(cpu, msr, &base))
 			continue;
 
 		if (!base)
@@ -432,10 +409,15 @@ static bool intel_uncore_has_discovery_tables_msr(int *ignore)
 	return parsed;
 }
 
-bool intel_uncore_has_discovery_tables(int *ignore)
+bool intel_uncore_has_discovery_tables(int *ignore, u32 msr, u32 device)
 {
-	return intel_uncore_has_discovery_tables_msr(ignore) ||
-	       intel_uncore_has_discovery_tables_pci(ignore);
+	bool ret = false;
+
+	if (msr)
+		ret = intel_uncore_has_discovery_tables_msr(ignore, msr);
+	if (device)
+		ret |= intel_uncore_has_discovery_tables_pci(ignore, device);
+	return ret;
 }
 
 void intel_uncore_clear_discovery_tables(void)
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index dff75c98e22f..a919b1ac88fe 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -136,7 +136,7 @@ struct intel_uncore_discovery_type {
 	u16		num_units;	/* number of units */
 };
 
-bool intel_uncore_has_discovery_tables(int *ignore);
+bool intel_uncore_has_discovery_tables(int *ignore, u32 msr, u32 device);
 void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
-- 
2.52.0


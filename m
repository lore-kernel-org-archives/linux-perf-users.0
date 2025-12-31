Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546E28CF52;
	Wed, 31 Dec 2025 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221383; cv=none; b=mffOYe0AJ0nzCbmnxbUeTYuM/myIVR+gAC58NbD1ayma0D5Z9YacRq1gul4zxzviaCSdzaGy1npYPXaIqhP0jSqzuNonO4XtIvV5OKK9EvsQsNUwgzKIYP3QnhQvIawdv+a6SsG/zVkAII0QWqGPgyHrQaXOqLkq4GapNCrN4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221383; c=relaxed/simple;
	bh=0ZOMGXiFWL+wuSWPyRpc35r3raSL34O0zV1ac2PqGoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bupOx528XI3pf/3VnkGcLNCPAfh8aK4jZVMsp2smyHLxbcpEsWFm5K4tUE/4icnYDcfUVrpTK2OnGJ89lrbLj8VQ5GxqtlnxnIzAuTy1q/KDxtdhvG3G0Cl0rBvXBIfhvYRYTAxW22gm/MYdVEpoCR5Z9a1ApubpYRC/M3WPUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnkUYQY1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnkUYQY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221382; x=1798757382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ZOMGXiFWL+wuSWPyRpc35r3raSL34O0zV1ac2PqGoM=;
  b=LnkUYQY1dxwXmiOP2oB+7dKg8yIiRSdm4Jrw3GNwMo3T14YBdvEoFaNx
   KIw1muBcFiEnYpkFXwKCulu+jvvjp1nbtQfJOyxYapOosoj2CGVf/swaM
   LI9/11o1Pt/DudJHm0kcSDgGuzU0lvhnxjVsVGD1PmeB0+9FOsGIz7hDq
   edBZuKZe+Ou2sJHkrSG41YgpZ9RrDGLWHjqPcf5ceRY9L+YIQIEkZrtKN
   lnweeVJm++1TTpmNaunNXKG/Os3HQhSGUOoDEidIjGiBNdWo+l6pE/xo4
   UR6ejnyZK8ZW5X128MZr1jyc53IALDTAFVe+wr01/eG6KKceVKROXAD6u
   Q==;
X-CSE-ConnectionGUID: SJwOdC92SBaoKLk2/jTbzw==
X-CSE-MsgGUID: IM3pZ3ziRBOD/wdbnFQCCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816608"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816608"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:40 -0800
X-CSE-ConnectionGUID: VazQpf8OTWau7+eASf6GnA==
X-CSE-MsgGUID: fEcHY+l4RraRw4EIhWJWMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611007"
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
Subject: [PATCH V2 02/13] perf/x86/intel/uncore: Support per-platform discovery base devices
Date: Wed, 31 Dec 2025 14:42:19 -0800
Message-ID: <20251231224233.113839-3-zide.chen@intel.com>
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

On DMR platforms, IMH discovery tables are enumerated via PCI, while
CBB domains use MSRs, unlike earlier platforms which relied on either
PCI or MSR exclusively.

DMR also uses different MSRs and PCI devices, requiring support for
multiple, platform-specific discovery bases.

Introduce struct uncore_discovery_domain to hold the discovery base and
other domain-specific configuration.

Move uncore_units_ignore into uncore_discovery_domain so a single
structure can be passed to uncore_discovery_[pci/msr].

No functional change intended.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2:
- Introduce uncore_discovery_domain[] to support possible any
  combination of MSR or PCI discovery base.
- Move has_generic_discovery_table() related code to a separate patch
  for easier review.
- Update commit messages.

 arch/x86/events/intel/uncore.c           | 32 ++++++++-----
 arch/x86/events/intel/uncore.h           | 15 +++++--
 arch/x86/events/intel/uncore_discovery.c | 57 +++++++++++++++---------
 3 files changed, 69 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index cd561290be8c..844030ef87c4 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1798,7 +1798,7 @@ static const struct uncore_plat_init lnl_uncore_init __initconst = {
 static const struct uncore_plat_init ptl_uncore_init __initconst = {
 	.cpu_init = ptl_uncore_cpu_init,
 	.mmio_init = ptl_uncore_mmio_init,
-	.use_discovery = true,
+	.domain[0].discovery_base = UNCORE_DISCOVERY_MSR,
 };
 
 static const struct uncore_plat_init icx_uncore_init __initconst = {
@@ -1817,16 +1817,18 @@ static const struct uncore_plat_init spr_uncore_init __initconst = {
 	.cpu_init = spr_uncore_cpu_init,
 	.pci_init = spr_uncore_pci_init,
 	.mmio_init = spr_uncore_mmio_init,
-	.use_discovery = true,
-	.uncore_units_ignore = spr_uncore_units_ignore,
+	.domain[0].base_is_pci = true,
+	.domain[0].discovery_base = UNCORE_DISCOVERY_TABLE_DEVICE,
+	.domain[0].units_ignore = spr_uncore_units_ignore,
 };
 
 static const struct uncore_plat_init gnr_uncore_init __initconst = {
 	.cpu_init = gnr_uncore_cpu_init,
 	.pci_init = gnr_uncore_pci_init,
 	.mmio_init = gnr_uncore_mmio_init,
-	.use_discovery = true,
-	.uncore_units_ignore = gnr_uncore_units_ignore,
+	.domain[0].base_is_pci = true,
+	.domain[0].discovery_base = UNCORE_DISCOVERY_TABLE_DEVICE,
+	.domain[0].units_ignore = gnr_uncore_units_ignore,
 };
 
 static const struct uncore_plat_init generic_uncore_init __initconst = {
@@ -1897,6 +1899,17 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
 
+static bool ucore_use_discovery(struct uncore_plat_init *config)
+{
+	int i;
+
+	for (i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++)
+		if (config->domain[i].discovery_base)
+			return true;
+
+	return false;
+}
+
 static int __init intel_uncore_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -1911,15 +1924,14 @@ static int __init intel_uncore_init(void)
 
 	id = x86_match_cpu(intel_uncore_match);
 	if (!id) {
-		if (!uncore_no_discover && uncore_discovery(NULL))
-			uncore_init = (struct uncore_plat_init *)&generic_uncore_init;
-		else
+		uncore_init = (struct uncore_plat_init *)&generic_uncore_init;
+		if (uncore_no_discover || !uncore_discovery(uncore_init))
 			return -ENODEV;
 	} else {
 		uncore_init = (struct uncore_plat_init *)id->driver_data;
-		if (uncore_no_discover && uncore_init->use_discovery)
+		if (uncore_no_discover && ucore_use_discovery(uncore_init))
 			return -ENODEV;
-		if (uncore_init->use_discovery &&
+		if (ucore_use_discovery(uncore_init) &&
 		    !uncore_discovery(uncore_init))
 			return -ENODEV;
 	}
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 568536ef28ee..1574ffc7ee05 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -47,14 +47,21 @@ struct uncore_event_desc;
 struct freerunning_counters;
 struct intel_uncore_topology;
 
+struct uncore_discovery_domain {
+	/* MSR address or PCI device used as the discovery base */
+	u32	discovery_base;
+	bool	base_is_pci;
+	/* The units in the discovery table should be ignored. */
+	int	*units_ignore;
+};
+
+#define UNCORE_DISCOVERY_DOMAINS	2
 struct uncore_plat_init {
 	void	(*cpu_init)(void);
 	int	(*pci_init)(void);
 	void	(*mmio_init)(void);
-	/* Discovery table is required */
-	bool	use_discovery;
-	/* The units in the discovery table should be ignored. */
-	int	*uncore_units_ignore;
+
+	struct uncore_discovery_domain domain[UNCORE_DISCOVERY_DOMAINS];
 };
 
 struct intel_uncore_type {
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index d39f6a0b8cc3..3bcbf974d3a8 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -259,23 +259,24 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 }
 
 static bool
-uncore_ignore_unit(struct uncore_unit_discovery *unit, int *ignore)
+uncore_ignore_unit(struct uncore_unit_discovery *unit,
+		   struct uncore_discovery_domain *domain)
 {
 	int i;
 
-	if (!ignore)
+	if (!domain || !domain->units_ignore)
 		return false;
 
-	for (i = 0; ignore[i] != UNCORE_IGNORE_END ; i++) {
-		if (unit->box_type == ignore[i])
+	for (i = 0; domain->units_ignore[i] != UNCORE_IGNORE_END ; i++) {
+		if (unit->box_type == domain->units_ignore[i])
 			return true;
 	}
 
 	return false;
 }
 
-static int __parse_discovery_table(resource_size_t addr, int die,
-				   bool *parsed, int *ignore)
+static int __parse_discovery_table(struct uncore_discovery_domain *domain,
+				   resource_size_t addr, int die, bool *parsed)
 {
 	struct uncore_global_discovery global;
 	struct uncore_unit_discovery unit;
@@ -314,7 +315,7 @@ static int __parse_discovery_table(resource_size_t addr, int die,
 		if (unit.access_type >= UNCORE_ACCESS_MAX)
 			continue;
 
-		if (uncore_ignore_unit(&unit, ignore))
+		if (uncore_ignore_unit(&unit, domain))
 			continue;
 
 		uncore_insert_box_info(&unit, die);
@@ -325,9 +326,9 @@ static int __parse_discovery_table(resource_size_t addr, int die,
 	return 0;
 }
 
-static int parse_discovery_table(struct pci_dev *dev, int die,
-				 u32 bar_offset, bool *parsed,
-				 int *ignore)
+static int parse_discovery_table(struct uncore_discovery_domain *domain,
+				 struct pci_dev *dev, int die,
+				 u32 bar_offset, bool *parsed)
 {
 	resource_size_t addr;
 	u32 val;
@@ -347,17 +348,19 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 	}
 #endif
 
-	return __parse_discovery_table(addr, die, parsed, ignore);
+	return __parse_discovery_table(domain, addr, die, parsed);
 }
 
-static bool uncore_discovery_pci(int *ignore)
+static bool uncore_discovery_pci(struct uncore_discovery_domain *domain)
 {
 	u32 device, val, entry_id, bar_offset;
 	int die, dvsec = 0, ret = true;
 	struct pci_dev *dev = NULL;
 	bool parsed = false;
 
-	if (has_generic_discovery_table())
+	if (domain->discovery_base)
+		device = domain->discovery_base;
+	else if (has_generic_discovery_table())
 		device = UNCORE_DISCOVERY_TABLE_DEVICE;
 	else
 		device = PCI_ANY_ID;
@@ -386,7 +389,7 @@ static bool uncore_discovery_pci(int *ignore)
 			if (die < 0)
 				continue;
 
-			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);
+			parse_discovery_table(domain, dev, die, bar_offset, &parsed);
 		}
 	}
 
@@ -399,11 +402,11 @@ static bool uncore_discovery_pci(int *ignore)
 	return ret;
 }
 
-static bool uncore_discovery_msr(int *ignore)
+static bool uncore_discovery_msr(struct uncore_discovery_domain *domain)
 {
 	unsigned long *die_mask;
 	bool parsed = false;
-	int cpu, die;
+	int cpu, die, msr;
 	u64 base;
 
 	die_mask = kcalloc(BITS_TO_LONGS(uncore_max_dies()),
@@ -411,19 +414,22 @@ static bool uncore_discovery_msr(int *ignore)
 	if (!die_mask)
 		return false;
 
+	msr = domain->discovery_base ?
+	      domain->discovery_base : UNCORE_DISCOVERY_MSR;
+
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		die = topology_logical_die_id(cpu);
 		if (__test_and_set_bit(die, die_mask))
 			continue;
 
-		if (rdmsrq_safe_on_cpu(cpu, UNCORE_DISCOVERY_MSR, &base))
+		if (rdmsrq_safe_on_cpu(cpu, msr, &base))
 			continue;
 
 		if (!base)
 			continue;
 
-		__parse_discovery_table(base, die, &parsed, ignore);
+		__parse_discovery_table(domain, base, die, &parsed);
 	}
 
 	cpus_read_unlock();
@@ -434,10 +440,19 @@ static bool uncore_discovery_msr(int *ignore)
 
 bool uncore_discovery(struct uncore_plat_init *init)
 {
-	int *ignore = init ? init->uncore_units_ignore : NULL;
+	struct uncore_discovery_domain *domain;
+	bool ret = false;
+	int i;
 
-	return uncore_discovery_msr(ignore) ||
-	       uncore_discovery_pci(ignore);
+	for (i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++) {
+		domain = &init->domain[i];
+		if (!domain->base_is_pci)
+			ret |= uncore_discovery_msr(domain);
+		else
+			ret |= uncore_discovery_pci(domain);
+	}
+
+	return ret;
 }
 
 void intel_uncore_clear_discovery_tables(void)
-- 
2.52.0


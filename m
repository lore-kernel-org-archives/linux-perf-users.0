Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38538887E;
	Tue, 12 May 2026 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629181; cv=none; b=tkbbS1HXzlvksufGv4CPQ8XZZSA94dqZByaxHkW+O6CYJSAivKy018nic3s30o4B6m0iRDaV9fotaJiPIDwPVgeBtgr8UBtex8S+ekKbFuwEbOqczg4BNU8scgfO1JkPhWazpg5V23Mfv8c3TssGNIq6yGxVbWa7XZgwxkIEf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629181; c=relaxed/simple;
	bh=HtHol7g2i9wDZYVdwNkVPj69XE++loTjnKZNDVecvUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaWm0/4FDh9TLO7Z7eO5Ed48Qsv31aMgfuIAlEJFfEHaUx3QHeuMRcEdDks+uv3zsXeejHU9m5CsUN4CZLF9imjpHj3D3446lGnWlHuY6dvu5FiFAgpdJr98QXQzJytMdqeWYrX3etBDxW++NNzIvJKgwhJQnQixUKgGzreBhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUZvS0nI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUZvS0nI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778629179; x=1810165179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HtHol7g2i9wDZYVdwNkVPj69XE++loTjnKZNDVecvUQ=;
  b=AUZvS0nIHfBxDUMp7+TiIwJWcj2swff3qCHcAZvCH8jRpf8F+rZzKGCA
   skIv06Ey2vEGmi0gmO2zgZCcdYJoZyF8Z7yFjAU6DMgg0GzYQyuH1SZrb
   0nf+NfbtlS/AqPrCqnZjBte8SC4msWdbfSeRSdU4Vz89/93dm2a/VxzIP
   jJgs7nFqAa8zq47GM+d2qwQFJCpOAwKrNJn0vBk7hzd5jwrf108UnJ/7J
   ALOwC6R7Y6OxlqnyjNFbL18ZQ96iY1PilApOOquZcUWW8iKxICZ2NKzw/
   fEyG2E6HWQjegawLrIuKLCyPZ5Ub2MyuMM1Vb49jP/ej4mb7l/SN66lwv
   g==;
X-CSE-ConnectionGUID: QVJigNIjS0egv95TFt5i9g==
X-CSE-MsgGUID: xa3QKW2gQ5uNW3aN0QTMuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105008877"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="105008877"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:36 -0700
X-CSE-ConnectionGUID: VLzTM2HFSUiK9QP6OxzHEw==
X-CSE-MsgGUID: oaxeZvnqRAG6J43fo4HWFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242271288"
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
Subject: [PATCH 2/7] perf/x86/intel/uncore: Let init_box() callback report failures
Date: Tue, 12 May 2026 16:30:43 -0700
Message-ID: <20260512233048.9577-3-zide.chen@intel.com>
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

The init_box() callback currently returns void, so initialization
failures are silently ignored and the box is still marked initialized.

Change the callback to return int so platform code can report errors
back to the common uncore layer.

Update uncore_box_init() to set the initialized flag only when
init_box() succeeds.  Because box->cpu_refcnt guarantees that at most
one CPU calls uncore_box_init() for a given box at a time, plain
__set_bit() is safe for the initialized flag without atomic overhead.

Convert all init_box() implementations to return 0 on success or a
negative error code on failure.  This is a prerequisite for propagating
initialization errors to the caller so they can be handled properly.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.h           | 16 +++--
 arch/x86/events/intel/uncore_discovery.c | 15 +++--
 arch/x86/events/intel/uncore_discovery.h |  6 +-
 arch/x86/events/intel/uncore_nhmex.c     |  3 +-
 arch/x86/events/intel/uncore_snb.c       | 80 +++++++++++++++---------
 arch/x86/events/intel/uncore_snbep.c     | 69 ++++++++++++--------
 6 files changed, 120 insertions(+), 69 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 7d4ef869d193..5ee05545116a 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -129,7 +129,7 @@ struct intel_uncore_type {
 #define events_group attr_groups[2]
 
 struct intel_uncore_ops {
-	void (*init_box)(struct intel_uncore_box *);
+	int (*init_box)(struct intel_uncore_box *);
 	void (*exit_box)(struct intel_uncore_box *);
 	void (*disable_box)(struct intel_uncore_box *);
 	void (*enable_box)(struct intel_uncore_box *);
@@ -557,12 +557,18 @@ static inline u64 uncore_read_counter(struct intel_uncore_box *box,
 	return box->pmu->type->ops->read_counter(box, event);
 }
 
-static inline void uncore_box_init(struct intel_uncore_box *box)
+static inline int uncore_box_init(struct intel_uncore_box *box)
 {
-	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
-		if (box->pmu->type->ops->init_box)
-			box->pmu->type->ops->init_box(box);
+	int ret = 0;
+
+	if (!test_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags) &&
+	    box->pmu->type->ops->init_box) {
+		ret = box->pmu->type->ops->init_box(box);
+		if (!ret)
+			__set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags);
 	}
+
+	return ret;
 }
 
 static inline void uncore_box_exit(struct intel_uncore_box *box)
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 49183d607a34..f1156ad03523 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -488,9 +488,10 @@ static u64 intel_generic_uncore_box_ctl(struct intel_uncore_box *box)
 	return unit->addr;
 }
 
-void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
+int intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	wrmsrq(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
+	return 0;
 }
 
 void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
@@ -565,13 +566,14 @@ static inline int intel_pci_uncore_box_ctl(struct intel_uncore_box *box)
 	return UNCORE_DISCOVERY_PCI_BOX_CTRL(intel_generic_uncore_box_ctl(box));
 }
 
-void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
+int intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = intel_pci_uncore_box_ctl(box);
 
 	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
+	return 0;
 }
 
 void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
@@ -632,7 +634,7 @@ static struct intel_uncore_ops generic_uncore_pci_ops = {
 
 #define UNCORE_GENERIC_MMIO_SIZE		0x4000
 
-void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
+int intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
 	static struct intel_uncore_discovery_unit *unit;
 	struct intel_uncore_type *type = box->pmu->type;
@@ -642,13 +644,13 @@ void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 	if (!unit) {
 		pr_warn("Uncore type %d id %d: Cannot find box control address.\n",
 			type->type_id, box->pmu->pmu_idx);
-		return;
+		return -ENODEV;
 	}
 
 	if (!unit->addr) {
 		pr_warn("Uncore type %d box %d: Invalid box control address.\n",
 			type->type_id, unit->id);
-		return;
+		return -ENODEV;
 	}
 
 	addr = unit->addr;
@@ -656,10 +658,11 @@ void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 	if (!box->io_addr) {
 		pr_warn("Uncore type %d box %d: ioremap error for 0x%llx.\n",
 			type->type_id, unit->id, (unsigned long long)addr);
-		return;
+		return -ENOMEM;
 	}
 
 	writel(GENERIC_PMON_BOX_CTL_INT, box->io_addr);
+	return 0;
 }
 
 void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index e1330342b92e..142e1b56cfc2 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -148,11 +148,11 @@ void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
 void intel_uncore_generic_uncore_mmio_init(void);
 
-void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
+int intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
 void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box);
 
-void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box);
+int intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box);
 void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
@@ -160,7 +160,7 @@ void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
 void intel_generic_uncore_mmio_enable_event(struct intel_uncore_box *box,
 					    struct perf_event *event);
 
-void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box);
+int intel_generic_uncore_pci_init_box(struct intel_uncore_box *box);
 void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index 8962e7cb21e3..7a6855281102 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -199,9 +199,10 @@ DEFINE_UNCORE_FORMAT_ATTR(counter, counter, "config:6-7");
 DEFINE_UNCORE_FORMAT_ATTR(match, match, "config1:0-63");
 DEFINE_UNCORE_FORMAT_ATTR(mask, mask, "config2:0-63");
 
-static void nhmex_uncore_msr_init_box(struct intel_uncore_box *box)
+static int nhmex_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	wrmsrq(NHMEX_U_MSR_PMON_GLOBAL_CTL, NHMEX_U_PMON_GLOBAL_EN_ALL);
+	return 0;
 }
 
 static void nhmex_uncore_msr_exit_box(struct intel_uncore_box *box)
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index edddd4f9ab5f..c5347920541c 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -295,12 +295,14 @@ static void snb_uncore_msr_disable_event(struct intel_uncore_box *box, struct pe
 	wrmsrq(event->hw.config_base, 0);
 }
 
-static void snb_uncore_msr_init_box(struct intel_uncore_box *box)
+static int snb_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0) {
 		wrmsrq(SNB_UNC_PERF_GLOBAL_CTL,
 			SNB_UNC_GLOBAL_CTL_EN | SNB_UNC_GLOBAL_CTL_CORE_ALL);
 	}
+
+	return 0;
 }
 
 static void snb_uncore_msr_enable_box(struct intel_uncore_box *box)
@@ -394,7 +396,7 @@ void snb_uncore_cpu_init(void)
 		snb_uncore_cbox.num_boxes = topology_num_cores_per_package();
 }
 
-static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
+static int skl_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0) {
 		wrmsrq(SKL_UNC_PERF_GLOBAL_CTL,
@@ -404,6 +406,8 @@ static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
 	/* The 8th CBOX has different MSR space */
 	if (box->pmu->pmu_idx == 7)
 		__set_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags);
+
+	return 0;
 }
 
 static void skl_uncore_msr_enable_box(struct intel_uncore_box *box)
@@ -547,10 +551,12 @@ static struct intel_uncore_type *tgl_msr_uncores[] = {
 	NULL,
 };
 
-static void rkl_uncore_msr_init_box(struct intel_uncore_box *box)
+static int rkl_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0)
 		wrmsrq(SKL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+
+	return 0;
 }
 
 void tgl_uncore_cpu_init(void)
@@ -707,9 +713,10 @@ static struct intel_uncore_type mtl_uncore_hac_cbox = {
 	.format_group	= &adl_uncore_format_group,
 };
 
-static void mtl_uncore_msr_init_box(struct intel_uncore_box *box)
+static int mtl_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	wrmsrq(uncore_msr_box_ctl(box), SNB_UNC_GLOBAL_CTL_EN);
+	return 0;
 }
 
 static struct intel_uncore_ops mtl_uncore_msr_ops = {
@@ -773,10 +780,12 @@ static struct intel_uncore_type *lnl_msr_uncores[] = {
 
 #define LNL_UNC_MSR_GLOBAL_CTL			0x240e
 
-static void lnl_uncore_msr_init_box(struct intel_uncore_box *box)
+static int lnl_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->pmu_idx == 0)
 		wrmsrq(LNL_UNC_MSR_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+
+	return 0;
 }
 
 static struct intel_uncore_ops lnl_uncore_msr_ops = {
@@ -874,7 +883,7 @@ static const struct attribute_group snb_uncore_imc_format_group = {
 	.attrs = snb_uncore_imc_formats_attr,
 };
 
-static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
+static int snb_uncore_imc_init_box(struct intel_uncore_box *box)
 {
 	struct intel_uncore_type *type = box->pmu->type;
 	struct pci_dev *pdev = box->pci_dev;
@@ -893,10 +902,13 @@ static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
 	addr &= ~(PAGE_SIZE - 1);
 
 	box->io_addr = ioremap(addr, type->mmio_map_size);
-	if (!box->io_addr)
+	if (!box->io_addr) {
 		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
+		return -ENOMEM;
+	}
 
 	box->hrtimer_duration = UNCORE_SNB_IMC_HRTIMER_INTERVAL;
+	return 0;
 }
 
 static void snb_uncore_imc_enable_box(struct intel_uncore_box *box)
@@ -1532,7 +1544,7 @@ static struct pci_dev *tgl_uncore_get_mc_dev(void)
 #define TGL_UNCORE_MMIO_IMC_MEM_OFFSET		0x10000
 #define TGL_UNCORE_PCI_IMC_MAP_SIZE		0xe000
 
-static void
+static int
 uncore_get_box_mmio_addr(struct intel_uncore_box *box,
 			 unsigned int base_offset,
 			 int bar_offset, int step)
@@ -1541,19 +1553,20 @@ uncore_get_box_mmio_addr(struct intel_uncore_box *box,
 	struct intel_uncore_pmu *pmu = box->pmu;
 	struct intel_uncore_type *type = pmu->type;
 	resource_size_t addr;
+	int ret = 0;
 	u32 bar;
 
 	if (!pdev) {
 		pr_warn("perf uncore: Cannot find matched IMC device.\n");
-		return;
+		return -ENODEV;
 	}
 
 	pci_read_config_dword(pdev, bar_offset, &bar);
 	if (!(bar & BIT(0))) {
 		pr_warn("perf uncore: BAR 0x%x is disabled. Failed to map %s counters.\n",
 			bar_offset, type->name);
-		pci_dev_put(pdev);
-		return;
+		ret = -ENODEV;
+		goto out;
 	}
 	bar &= ~BIT(0);
 	addr = (resource_size_t)(bar + step * pmu->pmu_idx);
@@ -1565,23 +1578,26 @@ uncore_get_box_mmio_addr(struct intel_uncore_box *box,
 
 	addr += base_offset;
 	box->io_addr = ioremap(addr, type->mmio_map_size);
-	if (!box->io_addr)
+	if (!box->io_addr) {
+		ret = -ENOMEM;
 		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
-
+	}
+out:
 	pci_dev_put(pdev);
+	return ret;
 }
 
-static void __uncore_imc_init_box(struct intel_uncore_box *box,
+static int __uncore_imc_init_box(struct intel_uncore_box *box,
 				  unsigned int base_offset)
 {
-	uncore_get_box_mmio_addr(box, base_offset,
+	return uncore_get_box_mmio_addr(box, base_offset,
 				 SNB_UNCORE_PCI_IMC_BAR_OFFSET,
 				 TGL_UNCORE_MMIO_IMC_MEM_OFFSET);
 }
 
-static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+static int tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
-	__uncore_imc_init_box(box, 0);
+	return __uncore_imc_init_box(box, 0);
 }
 
 static struct intel_uncore_ops tgl_uncore_imc_freerunning_ops = {
@@ -1648,13 +1664,15 @@ void tgl_uncore_mmio_init(void)
 #define ADL_UNCORE_IMC_CTL_INT			(ADL_UNCORE_IMC_CTL_RST_CTRL | \
 						ADL_UNCORE_IMC_CTL_RST_CTRS)
 
-static void adl_uncore_imc_init_box(struct intel_uncore_box *box)
+static int adl_uncore_imc_init_box(struct intel_uncore_box *box)
 {
-	__uncore_imc_init_box(box, ADL_UNCORE_IMC_BASE);
+	int ret = __uncore_imc_init_box(box, ADL_UNCORE_IMC_BASE);
 
 	/* The global control in MC1 can control both MCs. */
-	if (box->io_addr && (box->pmu->pmu_idx == 1))
+	if (!ret && (box->pmu->pmu_idx == 1))
 		writel(ADL_UNCORE_IMC_CTL_INT, box->io_addr + ADL_UNCORE_IMC_GLOBAL_CTL);
+
+	return ret;
 }
 
 static void adl_uncore_mmio_disable_box(struct intel_uncore_box *box)
@@ -1731,9 +1749,9 @@ static struct freerunning_counters adl_uncore_imc_freerunning[] = {
 	[ADL_MMIO_UNCORE_IMC_DATA_WRITE]	= { 0xA0, 0x0, 0x0, 1, 64 },
 };
 
-static void adl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+static int adl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
-	__uncore_imc_init_box(box, ADL_UNCORE_IMC_FREERUNNING_BASE);
+	return __uncore_imc_init_box(box, ADL_UNCORE_IMC_FREERUNNING_BASE);
 }
 
 static struct intel_uncore_ops adl_uncore_imc_freerunning_ops = {
@@ -1803,9 +1821,9 @@ static const struct attribute_group lnl_uncore_format_group = {
 	.attrs		= lnl_uncore_formats_attr,
 };
 
-static void lnl_uncore_hbo_init_box(struct intel_uncore_box *box)
+static int lnl_uncore_hbo_init_box(struct intel_uncore_box *box)
 {
-	uncore_get_box_mmio_addr(box, LNL_UNCORE_HBO_BASE,
+	return uncore_get_box_mmio_addr(box, LNL_UNCORE_HBO_BASE,
 				 LNL_UNCORE_PCI_SAFBAR_OFFSET,
 				 LNL_UNCORE_HBO_OFFSET);
 }
@@ -1829,14 +1847,16 @@ static struct intel_uncore_type lnl_uncore_hbo = {
 	.format_group	= &lnl_uncore_format_group,
 };
 
-static void lnl_uncore_sncu_init_box(struct intel_uncore_box *box)
+static int lnl_uncore_sncu_init_box(struct intel_uncore_box *box)
 {
-	uncore_get_box_mmio_addr(box, LNL_UNCORE_SNCU_BASE,
+	int ret = uncore_get_box_mmio_addr(box, LNL_UNCORE_SNCU_BASE,
 				 LNL_UNCORE_PCI_SAFBAR_OFFSET,
 				 0);
 
-	if (box->io_addr)
+	if (!ret)
 		writel(ADL_UNCORE_IMC_CTL_INT, box->io_addr + LNL_UNCORE_GLOBAL_CTL);
+
+	return ret;
 }
 
 static struct intel_uncore_ops lnl_uncore_sncu_ops = {
@@ -1887,13 +1907,15 @@ static struct intel_uncore_type ptl_uncore_imc = {
 	.mmio_map_size		= 0xf00,
 };
 
-static void ptl_uncore_sncu_init_box(struct intel_uncore_box *box)
+static int ptl_uncore_sncu_init_box(struct intel_uncore_box *box)
 {
-	intel_generic_uncore_mmio_init_box(box);
+	int ret = intel_generic_uncore_mmio_init_box(box);
 
 	/* Clear the global freeze bit */
 	if (box->io_addr)
 		writel(0, box->io_addr + PTL_UNCORE_GLOBAL_CTL_OFFSET);
+
+	return ret;
 }
 
 static struct intel_uncore_ops ptl_uncore_sncu_ops = {
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 251c7bdbe30b..fbc51fa1b705 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -627,12 +627,13 @@ static u64 snbep_uncore_pci_read_counter(struct intel_uncore_box *box, struct pe
 	return count;
 }
 
-static void snbep_uncore_pci_init_box(struct intel_uncore_box *box)
+static int snbep_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
 
 	pci_write_config_dword(pdev, box_ctl, SNBEP_PMON_BOX_CTL_INT);
+	return 0;
 }
 
 static void snbep_uncore_msr_disable_box(struct intel_uncore_box *box)
@@ -680,12 +681,14 @@ static void snbep_uncore_msr_disable_event(struct intel_uncore_box *box,
 	wrmsrq(hwc->config_base, hwc->config);
 }
 
-static void snbep_uncore_msr_init_box(struct intel_uncore_box *box)
+static int snbep_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	unsigned msr = uncore_msr_box_ctl(box);
 
 	if (msr)
 		wrmsrq(msr, SNBEP_PMON_BOX_CTL_INT);
+
+	return 0;
 }
 
 static struct attribute *snbep_uncore_formats_attr[] = {
@@ -1507,18 +1510,21 @@ int snbep_uncore_pci_init(void)
 /* end of Sandy Bridge-EP uncore support */
 
 /* IvyTown uncore support */
-static void ivbep_uncore_msr_init_box(struct intel_uncore_box *box)
+static int ivbep_uncore_msr_init_box(struct intel_uncore_box *box)
 {
 	unsigned msr = uncore_msr_box_ctl(box);
 	if (msr)
 		wrmsrq(msr, IVBEP_PMON_BOX_CTL_INT);
+
+	return 0;
 }
 
-static void ivbep_uncore_pci_init_box(struct intel_uncore_box *box)
+static int ivbep_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 
 	pci_write_config_dword(pdev, SNBEP_PCI_PMON_BOX_CTL, IVBEP_PMON_BOX_CTL_INT);
+	return 0;
 }
 
 #define IVBEP_UNCORE_MSR_OPS_COMMON_INIT()			\
@@ -2784,7 +2790,7 @@ static struct intel_uncore_type hswep_uncore_cbox = {
 /*
  * Write SBOX Initialization register bit by bit to avoid spurious #GPs
  */
-static void hswep_uncore_sbox_msr_init_box(struct intel_uncore_box *box)
+static int hswep_uncore_sbox_msr_init_box(struct intel_uncore_box *box)
 {
 	unsigned msr = uncore_msr_box_ctl(box);
 
@@ -2798,6 +2804,8 @@ static void hswep_uncore_sbox_msr_init_box(struct intel_uncore_box *box)
 			wrmsrq(msr, flags);
 		}
 	}
+
+	return 0;
 }
 
 static struct intel_uncore_ops hswep_uncore_sbox_msr_ops = {
@@ -4160,12 +4168,13 @@ static const struct attribute_group skx_upi_uncore_format_group = {
 	.attrs = skx_upi_uncore_formats_attr,
 };
 
-static void skx_upi_uncore_pci_init_box(struct intel_uncore_box *box)
+static int skx_upi_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 
 	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
 	pci_write_config_dword(pdev, SKX_UPI_PCI_PMON_BOX_CTL, IVBEP_PMON_BOX_CTL_INT);
+	return 0;
 }
 
 static struct intel_uncore_ops skx_upi_uncore_pci_ops = {
@@ -4321,12 +4330,13 @@ static struct intel_uncore_type skx_uncore_upi = {
 	.cleanup_mapping = skx_upi_cleanup_mapping,
 };
 
-static void skx_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
+static int skx_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 
 	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
 	pci_write_config_dword(pdev, SKX_M2M_PCI_PMON_BOX_CTL, IVBEP_PMON_BOX_CTL_INT);
+	return 0;
 }
 
 static struct intel_uncore_ops skx_m2m_uncore_pci_ops = {
@@ -4829,13 +4839,14 @@ void snr_uncore_cpu_init(void)
 	uncore_msr_uncores = snr_msr_uncores;
 }
 
-static void snr_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
+static int snr_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
 
 	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
 	pci_write_config_dword(pdev, box_ctl, IVBEP_PMON_BOX_CTL_INT);
+	return 0;
 }
 
 static struct intel_uncore_ops snr_m2m_uncore_pci_ops = {
@@ -5008,17 +5019,22 @@ static int snr_uncore_mmio_map(struct intel_uncore_box *box,
 	return 0;
 }
 
-static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
+static int __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
 				       unsigned int box_ctl, int mem_offset,
 				       unsigned int device)
 {
-	if (!snr_uncore_mmio_map(box, box_ctl, mem_offset, device))
+	int ret;
+
+	ret = snr_uncore_mmio_map(box, box_ctl, mem_offset, device);
+	if (!ret)
 		writel(IVBEP_PMON_BOX_CTL_INT, box->io_addr);
+
+	return ret;
 }
 
-static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
+static int snr_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
-	__snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box),
+	return __snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box),
 				   SNR_IMC_MMIO_MEM0_OFFSET,
 				   SNR_MC_DEVICE_ID);
 }
@@ -5635,14 +5651,14 @@ int icx_uncore_pci_init(void)
 	return 0;
 }
 
-static void icx_uncore_imc_init_box(struct intel_uncore_box *box)
+static int icx_uncore_imc_init_box(struct intel_uncore_box *box)
 {
 	unsigned int box_ctl = box->pmu->type->box_ctl +
 			       box->pmu->type->mmio_offset * (box->pmu->pmu_idx % ICX_NUMBER_IMC_CHN);
 	int mem_offset = (box->pmu->pmu_idx / ICX_NUMBER_IMC_CHN) * ICX_IMC_MEM_STRIDE +
 			 SNR_IMC_MMIO_MEM0_OFFSET;
 
-	__snr_uncore_mmio_init_box(box, box_ctl, mem_offset,
+	return __snr_uncore_mmio_init_box(box, box_ctl, mem_offset,
 				   SNR_MC_DEVICE_ID);
 }
 
@@ -5699,12 +5715,12 @@ static struct uncore_event_desc icx_uncore_imc_freerunning_events[] = {
 	{ /* end: all zeroes */ },
 };
 
-static void icx_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+static int icx_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
 	int mem_offset = box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE +
 			 SNR_IMC_MMIO_MEM0_OFFSET;
 
-	snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
+	return snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
 			    mem_offset, SNR_MC_DEVICE_ID);
 }
 
@@ -6001,10 +6017,10 @@ static struct intel_uncore_type spr_uncore_mdf = {
 	.name			= "mdf",
 };
 
-static void spr_uncore_mmio_offs8_init_box(struct intel_uncore_box *box)
+static int spr_uncore_mmio_offs8_init_box(struct intel_uncore_box *box)
 {
 	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
-	intel_generic_uncore_mmio_init_box(box);
+	return intel_generic_uncore_mmio_init_box(box);
 }
 
 static struct intel_uncore_ops spr_uncore_mmio_offs8_ops = {
@@ -6185,12 +6201,11 @@ static struct uncore_event_desc spr_uncore_imc_freerunning_events[] = {
 
 #define SPR_MC_DEVICE_ID	0x3251
 
-static void spr_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+static int spr_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
 	int mem_offset = box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE + SNR_IMC_MMIO_MEM0_OFFSET;
-
-	snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
-			    mem_offset, SPR_MC_DEVICE_ID);
+	return snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
+				   mem_offset, SPR_MC_DEVICE_ID);
 }
 
 static struct intel_uncore_ops spr_uncore_imc_freerunning_ops = {
@@ -6879,20 +6894,24 @@ static unsigned int dmr_iio_freerunning_box_offsets[] = {
 	0x0, 0x8000, 0x18000, 0x20000
 };
 
-static void dmr_uncore_freerunning_init_box(struct intel_uncore_box *box)
+static int dmr_uncore_freerunning_init_box(struct intel_uncore_box *box)
 {
 	struct intel_uncore_type *type = box->pmu->type;
 	u64 mmio_base;
 
 	if (box->pmu->pmu_idx >= type->num_boxes)
-		return;
+		return -ENODEV;
 
 	mmio_base = DMR_IMH1_HIOP_MMIO_BASE;
 	mmio_base += dmr_iio_freerunning_box_offsets[box->pmu->pmu_idx];
 
 	box->io_addr = ioremap(mmio_base, type->mmio_map_size);
-	if (!box->io_addr)
+	if (!box->io_addr) {
 		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 static struct intel_uncore_ops dmr_uncore_freerunning_ops = {
-- 
2.54.0


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269ED25A2DE;
	Thu,  3 Jul 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561825; cv=none; b=gDP8xP+Xoyn8CIwUX9sTsD8Qb3ZlAl2/okfw05VDb6g89I86LFlqjOzcMmORJ7Ffb3Lhfv6M9EdULZ7L3OVnNTy24LltVPnhvZZxvQ2uc5iKdCq1BDyPNobbvMfdWw0zwr7IiQtXOFu0gr7BR1SYsW/4qSbkf49N1QzSyLpJwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561825; c=relaxed/simple;
	bh=HmSWFEnyVZcq3dmbFhdSejbsJWSd1jjqG2e39rMp8qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKUdrPOobzP8iknq/yWdjUW2UR9s9q85qtmZl5iCPf+/fPiBp/13cDe6+R3hAV16fjALbJpfeyzqHcYc5h6frB/4EDg9mOwwR5Tcw04YUGCnU719+0mCWtR2zb1kNDmDCQo09+dXcbqC86yC+vyqIudKmf/jEKs38bQmfJCUcJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jd6h1E5T; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jd6h1E5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751561822; x=1783097822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HmSWFEnyVZcq3dmbFhdSejbsJWSd1jjqG2e39rMp8qk=;
  b=jd6h1E5TZtA7QYvcsXFaneKguLnQ/DBpML54MP6CP4Z247PHpvuopYjV
   cRfknW3mx6BN3UL+gX+cs6iyAXuZe53jnD95GJA1k3d9kHEhJihXBZj2a
   utCWgxhIJmcKGNBMu8C3tVDygeHkld/sUsk969JfwCdupV4wswjHQPgWj
   kggBm1eXBHbub5fMgl2xyUHtXMKnA3sxBWR+hymoB9bvjp19ElDUAJclw
   r80c4cfRuqy5fRzGiOnjoqbNNjNaOKWhhhaAtlyFra1QqXQNe7VmGBQAc
   hfvFVY+XslEau86rcxkdt6vLdKhYttrrwG33hK50LHqy6h1+6D2Q1k06b
   A==;
X-CSE-ConnectionGUID: IG0KY+2zQnqeb8DKE2Ui5g==
X-CSE-MsgGUID: og6aPH9YRkavg/3LMrsO8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53992523"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53992523"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 09:56:54 -0700
X-CSE-ConnectionGUID: Ks57F0zwSwaKnt7LnIevWA==
X-CSE-MsgGUID: OyiNlkpyQYuzzJbSau/VWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154554263"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 03 Jul 2025 09:56:53 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 3/4] perf/x86/intel/uncore: Add Panther Lake support
Date: Thu,  3 Jul 2025 09:56:13 -0700
Message-Id: <20250703165614.606446-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250703165614.606446-1-kan.liang@linux.intel.com>
References: <20250703165614.606446-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The Panther Lake supports CBOX, MC, sNCU, and HBO uncore PMON.

The CBOX is similar to Lunar Lake. The only difference is the number of
CBOX.

The other three uncore PMON can be retrieved from the discovery table.
The global control register resides in the sNCU. The global freeze bit
is set by default. It must be cleared before monitoring any uncore
counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           |  7 +++
 arch/x86/events/intel/uncore.h           |  2 +
 arch/x86/events/intel/uncore_discovery.h |  4 ++
 arch/x86/events/intel/uncore_snb.c       | 71 ++++++++++++++++++++++++
 arch/x86/events/intel/uncore_snbep.c     |  2 +-
 5 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 5811e172f721..8a4f5a86e18d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1806,6 +1806,12 @@ static const struct intel_uncore_init_fun lnl_uncore_init __initconst = {
 	.mmio_init = lnl_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun ptl_uncore_init __initconst = {
+	.cpu_init = ptl_uncore_cpu_init,
+	.mmio_init = ptl_uncore_mmio_init,
+	.use_discovery = true,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1887,6 +1893,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&ptl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 3dcb88c0ecfa..d8815fff7588 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -612,10 +612,12 @@ void tgl_uncore_cpu_init(void);
 void adl_uncore_cpu_init(void);
 void lnl_uncore_cpu_init(void);
 void mtl_uncore_cpu_init(void);
+void ptl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
 void adl_uncore_mmio_init(void);
 void lnl_uncore_mmio_init(void);
+void ptl_uncore_mmio_init(void);
 int snb_pci2phy_map_init(int devid);
 
 /* uncore_snbep.c */
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 690f737e6837..dff75c98e22f 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -171,3 +171,7 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 					  struct intel_uncore_box *box);
 void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
 			  struct rb_root *root, u16 *num_units);
+struct intel_uncore_type **
+uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
+		   struct intel_uncore_type **extra, int max_num_types,
+		   struct intel_uncore_type **uncores);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index edb7fd50efe0..817dddc1454d 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1854,3 +1854,74 @@ void lnl_uncore_mmio_init(void)
 }
 
 /* end of Lunar Lake MMIO uncore support */
+
+/* Panther Lake uncore support */
+
+#define UNCORE_PTL_MAX_NUM_UNCORE_TYPES		42
+#define UNCORE_PTL_TYPE_IMC			6
+#define UNCORE_PTL_TYPE_SNCU			34
+#define UNCORE_PTL_TYPE_HBO			41
+
+#define PTL_UNCORE_GLOBAL_CTL_OFFSET		0x380
+
+static struct intel_uncore_type ptl_uncore_imc = {
+	.name			= "imc",
+	.mmio_map_size		= 0xf00,
+};
+
+static void ptl_uncore_sncu_init_box(struct intel_uncore_box *box)
+{
+	intel_generic_uncore_mmio_init_box(box);
+
+	/* Clear the global freeze bit */
+	if (box->io_addr)
+		writel(0, box->io_addr + PTL_UNCORE_GLOBAL_CTL_OFFSET);
+}
+
+static struct intel_uncore_ops ptl_uncore_sncu_ops = {
+	.init_box		= ptl_uncore_sncu_init_box,
+	.exit_box		= uncore_mmio_exit_box,
+	.disable_box		= intel_generic_uncore_mmio_disable_box,
+	.enable_box		= intel_generic_uncore_mmio_enable_box,
+	.disable_event		= intel_generic_uncore_mmio_disable_event,
+	.enable_event		= intel_generic_uncore_mmio_enable_event,
+	.read_counter		= uncore_mmio_read_counter,
+};
+
+static struct intel_uncore_type ptl_uncore_sncu = {
+	.name			= "sncu",
+	.ops			= &ptl_uncore_sncu_ops,
+	.mmio_map_size		= 0xf00,
+};
+
+static struct intel_uncore_type ptl_uncore_hbo = {
+	.name			= "hbo",
+	.mmio_map_size		= 0xf00,
+};
+
+static struct intel_uncore_type *ptl_uncores[UNCORE_PTL_MAX_NUM_UNCORE_TYPES] = {
+	[UNCORE_PTL_TYPE_IMC] = &ptl_uncore_imc,
+	[UNCORE_PTL_TYPE_SNCU] = &ptl_uncore_sncu,
+	[UNCORE_PTL_TYPE_HBO] = &ptl_uncore_hbo,
+};
+
+void ptl_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+						 UNCORE_PTL_MAX_NUM_UNCORE_TYPES,
+						 ptl_uncores);
+}
+
+static struct intel_uncore_type *ptl_msr_uncores[] = {
+	&mtl_uncore_cbox,
+	NULL
+};
+
+void ptl_uncore_cpu_init(void)
+{
+	mtl_uncore_cbox.num_boxes = 6;
+	mtl_uncore_cbox.ops = &lnl_uncore_msr_ops;
+	uncore_msr_uncores = ptl_msr_uncores;
+}
+
+/* end of Panther Lake uncore support */
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2f5c2eb1ce0c..b19c262d47f5 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6412,7 +6412,7 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 		to_type->mmio_map_size = from_type->mmio_map_size;
 }
 
-static struct intel_uncore_type **
+struct intel_uncore_type **
 uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
 		   struct intel_uncore_type **extra, int max_num_types,
 		   struct intel_uncore_type **uncores)
-- 
2.38.1


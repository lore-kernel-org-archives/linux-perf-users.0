Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9F30F547;
	Wed, 31 Dec 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221384; cv=none; b=M8KVT1N5YPi2gx4s8uVO3PqEQBtpG543SYfA9QMTaOPnKOye8n2dxE/d9uJE5g1WfPvd52VrUTmXtDEZiD1YEM2QJFofRi7d6YNwYu5JHXS414vrtgx8uXpY5ud148I1kgzvl6zX/LBeYPuAd1G05JftyhSPnCCimI8R1xQFQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221384; c=relaxed/simple;
	bh=Od1Yd/y21jhWaYzdlpgSI2bfhLnlJUGIZvnOOUXIMgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGbOye/oaoxHEM7QEmyzRawCxhMCFs9RmNN7AE5c5GntWyVP69J0AedBKGCX81TJM4jGbZbYH86Zu60uQdl22v6s+WD4wpY6Qqtr5Js4IkOwC92MUpLmHnN6EIfXvKT4Y6BCtAGBJPCO4laju86n3CF8rXuuW5pMVxVwmriuDns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCVuDW+j; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCVuDW+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221383; x=1798757383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Od1Yd/y21jhWaYzdlpgSI2bfhLnlJUGIZvnOOUXIMgI=;
  b=cCVuDW+jwK6kSd1F/gI+s9dfRh1sjZgpwf2/umLrKC+B6ddE+w+pCyrM
   AezAOJSsoNbEEnyGl+HoQ2La6ih8eKq/Ls7ZKCmwDKEpTJZR0VIt2oWNQ
   iMRoYH6wqlX1kB63JzMlfeFmaybm9LkrKom9ZT0L4XERGX0t/7+8p4PbZ
   1UONQcMDs6E2RkWR8w1NfaGLSfbImYAzLW5b2TTBI26bMwLuN6KweUpwN
   /iwpW6S6DTF78lWVOEjfTw3gwRTb4w1+Od8hgfj7inQ8pf6egbao93sVa
   aLRDr854YZX+sdKSNv2uHQTmOmruIVxKnD8zwrn+YDK08/QOBlkqR6HCq
   Q==;
X-CSE-ConnectionGUID: kAamWp7xTcqffE/E/1y7hw==
X-CSE-MsgGUID: e7TT7EI6RCWgMI6OUd566g==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816618"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816618"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:40 -0800
X-CSE-ConnectionGUID: Arnu8WyOROGPcQFdViIHuQ==
X-CSE-MsgGUID: oMUhpP2vQHObR2ZDRhLSlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611013"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:40 -0800
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
Subject: [PATCH V2 04/13] perf/x86/intel/uncore: Add IMH PMON support for Diamond Rapids
Date: Wed, 31 Dec 2025 14:42:21 -0800
Message-ID: <20251231224233.113839-5-zide.chen@intel.com>
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

DMR supports IMH PMON units for PCU, UBox, iMC, and CXL:
- PCU and UBox are same with SPR.
- iMC is similar to SPR but uses different offsets for fixed registers.
- CXL introduces a new port_enable field and changes the position of
  the threshold field.

DMR also introduces additional PMON units: SCA, HAMVF, D2D_ULA, UBR,
PCIE4, CRS, CPC, ITC, OTC, CMS, and PCIE6.  Among these, PCIE4 and
PCIE6 use different unit types, but share the same config register
layout, and the generic PCIe PMON events apply to both.

Additionally, ignore the broken MSE unit.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Add missing format_attr_umask in dmr_imc_uncore_formats_attr[].
- Separate dmr_uncore_imh_units_ignore[] from dmr_uncore_units_ignore[].

 arch/x86/events/intel/uncore.c           |   9 +
 arch/x86/events/intel/uncore.h           |   3 +
 arch/x86/events/intel/uncore_discovery.h |   2 +
 arch/x86/events/intel/uncore_snbep.c     | 229 +++++++++++++++++++++++
 4 files changed, 243 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 2a1c6dce8a35..dc2b2b272bc8 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1831,6 +1831,14 @@ static const struct uncore_plat_init gnr_uncore_init __initconst = {
 	.domain[0].units_ignore = gnr_uncore_units_ignore,
 };
 
+static const struct uncore_plat_init dmr_uncore_init __initconst = {
+	.pci_init = dmr_uncore_pci_init,
+	.mmio_init = dmr_uncore_mmio_init,
+	.domain[0].base_is_pci = true,
+	.domain[0].discovery_base = DMR_UNCORE_DISCOVERY_TABLE_DEVICE,
+	.domain[0].units_ignore = dmr_uncore_imh_units_ignore,
+};
+
 static const struct uncore_plat_init generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 	.pci_init = intel_uncore_generic_uncore_pci_init,
@@ -1898,6 +1906,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&gnr_uncore_init),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&gnr_uncore_init),
 	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&gnr_uncore_init),
+	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X,	&dmr_uncore_init),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 1574ffc7ee05..1e4b3a22403c 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -614,6 +614,7 @@ extern struct pci_extra_dev *uncore_extra_pci_dev;
 extern struct event_constraint uncore_constraint_empty;
 extern int spr_uncore_units_ignore[];
 extern int gnr_uncore_units_ignore[];
+extern int dmr_uncore_imh_units_ignore[];
 
 /* uncore_snb.c */
 int snb_uncore_pci_init(void);
@@ -662,6 +663,8 @@ void spr_uncore_mmio_init(void);
 int gnr_uncore_pci_init(void);
 void gnr_uncore_cpu_init(void);
 void gnr_uncore_mmio_init(void);
+int dmr_uncore_pci_init(void);
+void dmr_uncore_mmio_init(void);
 
 /* uncore_nhmex.c */
 void nhmex_uncore_cpu_init(void);
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index dfc237a2b6df..618788c30ac6 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -5,6 +5,8 @@
 
 /* Generic device ID of a discovery table device */
 #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
+/* Device ID used on DMR */
+#define DMR_UNCORE_DISCOVERY_TABLE_DEVICE	0x09a1
 /* Capability ID for a discovery table device */
 #define UNCORE_EXT_CAP_ID_DISCOVERY		0x23
 /* First DVSEC offset */
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index e1f370b8d065..4b72560dc13f 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -471,6 +471,14 @@
 
 #define SPR_C0_MSR_PMON_BOX_FILTER0		0x200e
 
+/* DMR */
+#define DMR_CXLCM_EVENT_MASK_EXT		0xf
+#define DMR_HAMVF_EVENT_MASK_EXT		0xffffffff
+#define DMR_PCIE4_EVENT_MASK_EXT		0xffffff
+
+#define DMR_IMC_PMON_FIXED_CTR			0x18
+#define DMR_IMC_PMON_FIXED_CTL			0x10
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(event2, event, "config:0-6");
 DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
@@ -486,6 +494,10 @@ DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en2, tid_en, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
+DEFINE_UNCORE_FORMAT_ATTR(inv2, inv, "config:21");
+DEFINE_UNCORE_FORMAT_ATTR(thresh_ext, thresh_ext, "config:32-35");
+DEFINE_UNCORE_FORMAT_ATTR(thresh10, thresh, "config:23-32");
+DEFINE_UNCORE_FORMAT_ATTR(thresh9_2, thresh, "config:23-31");
 DEFINE_UNCORE_FORMAT_ATTR(thresh9, thresh, "config:24-35");
 DEFINE_UNCORE_FORMAT_ATTR(thresh8, thresh, "config:24-31");
 DEFINE_UNCORE_FORMAT_ATTR(thresh6, thresh, "config:24-29");
@@ -494,6 +506,13 @@ DEFINE_UNCORE_FORMAT_ATTR(occ_sel, occ_sel, "config:14-15");
 DEFINE_UNCORE_FORMAT_ATTR(occ_invert, occ_invert, "config:30");
 DEFINE_UNCORE_FORMAT_ATTR(occ_edge, occ_edge, "config:14-51");
 DEFINE_UNCORE_FORMAT_ATTR(occ_edge_det, occ_edge_det, "config:31");
+DEFINE_UNCORE_FORMAT_ATTR(port_en, port_en, "config:32-35");
+DEFINE_UNCORE_FORMAT_ATTR(rs3_sel, rs3_sel, "config:36");
+DEFINE_UNCORE_FORMAT_ATTR(rx_sel, rx_sel, "config:37");
+DEFINE_UNCORE_FORMAT_ATTR(tx_sel, tx_sel, "config:38");
+DEFINE_UNCORE_FORMAT_ATTR(iep_sel, iep_sel, "config:39");
+DEFINE_UNCORE_FORMAT_ATTR(vc_sel, vc_sel, "config:40-47");
+DEFINE_UNCORE_FORMAT_ATTR(port_sel, port_sel, "config:48-55");
 DEFINE_UNCORE_FORMAT_ATTR(ch_mask, ch_mask, "config:36-43");
 DEFINE_UNCORE_FORMAT_ATTR(ch_mask2, ch_mask, "config:36-47");
 DEFINE_UNCORE_FORMAT_ATTR(fc_mask, fc_mask, "config:44-46");
@@ -6709,3 +6728,213 @@ void gnr_uncore_mmio_init(void)
 }
 
 /* end of GNR uncore support */
+
+/* DMR uncore support */
+#define UNCORE_DMR_NUM_UNCORE_TYPES	52
+
+static struct attribute *dmr_imc_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh10.attr,
+	NULL,
+};
+
+static const struct attribute_group dmr_imc_uncore_format_group = {
+	.name = "format",
+	.attrs = dmr_imc_uncore_formats_attr,
+};
+
+static struct intel_uncore_type dmr_uncore_imc = {
+	.name			= "imc",
+	.fixed_ctr_bits		= 48,
+	.fixed_ctr		= DMR_IMC_PMON_FIXED_CTR,
+	.fixed_ctl		= DMR_IMC_PMON_FIXED_CTL,
+	.ops			= &spr_uncore_mmio_ops,
+	.format_group		= &dmr_imc_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct attribute *dmr_sca_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask_ext5.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	NULL,
+};
+
+static const struct attribute_group dmr_sca_uncore_format_group = {
+	.name = "format",
+	.attrs = dmr_sca_uncore_formats_attr,
+};
+
+static struct intel_uncore_type dmr_uncore_sca = {
+	.name			= "sca",
+	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		= &dmr_sca_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct attribute *dmr_cxlcm_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv2.attr,
+	&format_attr_thresh9_2.attr,
+	&format_attr_port_en.attr,
+	NULL,
+};
+
+static const struct attribute_group dmr_cxlcm_uncore_format_group = {
+	.name = "format",
+	.attrs = dmr_cxlcm_uncore_formats_attr,
+};
+
+static struct intel_uncore_type dmr_uncore_cxlcm = {
+	.name			= "cxlcm",
+	.event_mask		= GENERIC_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= DMR_CXLCM_EVENT_MASK_EXT,
+	.format_group		= &dmr_cxlcm_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_hamvf = {
+	.name			= "hamvf",
+	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		= &dmr_sca_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_ula = {
+	.name			= "ula",
+	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		= &dmr_sca_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_ubr = {
+	.name			= "ubr",
+	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		= &dmr_sca_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct attribute *dmr_pcie4_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	&format_attr_thresh_ext.attr,
+	&format_attr_rs3_sel.attr,
+	&format_attr_rx_sel.attr,
+	&format_attr_tx_sel.attr,
+	&format_attr_iep_sel.attr,
+	&format_attr_vc_sel.attr,
+	&format_attr_port_sel.attr,
+	NULL,
+};
+
+static const struct attribute_group dmr_pcie4_uncore_format_group = {
+	.name = "format",
+	.attrs = dmr_pcie4_uncore_formats_attr,
+};
+
+static struct intel_uncore_type dmr_uncore_pcie4 = {
+	.name			= "pcie4",
+	.event_mask_ext		= DMR_PCIE4_EVENT_MASK_EXT,
+	.format_group		= &dmr_pcie4_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_crs = {
+	.name			= "crs",
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_cpc = {
+	.name			= "cpc",
+	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		= &dmr_sca_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_itc = {
+	.name			= "itc",
+	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		= &dmr_sca_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_otc = {
+	.name			= "otc",
+	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
+	.format_group		= &dmr_sca_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_cms = {
+	.name			= "cms",
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type dmr_uncore_pcie6 = {
+	.name			= "pcie6",
+	.event_mask_ext		= DMR_PCIE4_EVENT_MASK_EXT,
+	.format_group		= &dmr_pcie4_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type *dmr_uncores[UNCORE_DMR_NUM_UNCORE_TYPES] = {
+	NULL, NULL, NULL, NULL,
+	&spr_uncore_pcu,
+	&gnr_uncore_ubox,
+	&dmr_uncore_imc,
+	NULL,
+	NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL,
+	&dmr_uncore_sca,
+	&dmr_uncore_cxlcm,
+	NULL, NULL, NULL,
+	NULL, NULL,
+	&dmr_uncore_hamvf,
+	NULL,
+	NULL, NULL, NULL,
+	&dmr_uncore_ula,
+	NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL,
+	&dmr_uncore_ubr,
+	NULL,
+	&dmr_uncore_pcie4,
+	&dmr_uncore_crs,
+	&dmr_uncore_cpc,
+	&dmr_uncore_itc,
+	&dmr_uncore_otc,
+	&dmr_uncore_cms,
+	&dmr_uncore_pcie6,
+};
+
+int dmr_uncore_imh_units_ignore[] = {
+	0x13,		/* MSE */
+	UNCORE_IGNORE_END
+};
+
+int dmr_uncore_pci_init(void)
+{
+	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL,
+						UNCORE_DMR_NUM_UNCORE_TYPES,
+						dmr_uncores);
+	return 0;
+}
+void dmr_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+						 UNCORE_DMR_NUM_UNCORE_TYPES,
+						 dmr_uncores);
+}
+
+/* end of DMR uncore support */
-- 
2.52.0


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8931079B;
	Wed, 31 Dec 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221390; cv=none; b=hoaf87YuoBCT9nG0178d9sX70HPGDlYNi/1sOf9znRrm3PqVjd42N/xjsUQ7d2nK71PwgiI7PTJmkkxAY3aUiYFlqqnCw3D5x92DzZfbrArZ1V3Ft3eXvI0aogHFM5Y8upukEgxFfh9o402ZI/2O1Fo1lAyXit1vt60EOKBY2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221390; c=relaxed/simple;
	bh=RoWplf06jXQBnnmkPN3OWDe98vx4jUQn06npWWp1OnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgWI7AVWjSKU1FBGfTLMHm/XmwDGLtUNFS6IyEFrdGh123oX1vHeyx51hovBT5v7oqco4IwsQsb94IjIKEeqEE1ogP4FxlNZEIKHIo4AYZZgW+4M0bxT5n55GWSV0iMzplwHv24vgPDfc1ebynO6ngHoy7MeG5TqSPijUtSkZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ro0HP4is; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ro0HP4is"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221388; x=1798757388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RoWplf06jXQBnnmkPN3OWDe98vx4jUQn06npWWp1OnI=;
  b=Ro0HP4is2ZjN9r8WjDTohQJalL9mj8GwtOl0evhU6GWeJ8tUmAbb2SJN
   bSx4xTg76D6GdIdSTKb1hsoXV0AGmvIoGHjsGrKOhEeQfR1QF2653YvPO
   TZNwB5L+XKFJtD3jy5ob2hDhlJYDjub6xmDeVQIO1meRXZyII2u1F4cwH
   DiymV1PW1F6evDHd4UxgE7z8lyk6f65vLHMjVawKlrXVenqLHL6ny3z2a
   dpeVNkKh8RY4duJGJCSJGqZpNB4YaLpuIyc0IY31dZkKXYlxeIlz3r291
   FzYMU/vKxUA48BW2uabOKwcV7tDxtFabmSx3Jy4+1gG1jNjUu/rwV/Y1n
   w==;
X-CSE-ConnectionGUID: D1zXJ+PvTmekfDCR9FV8fQ==
X-CSE-MsgGUID: AFjAkCx0Tr2FeuiR//1K0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816659"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816659"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:42 -0800
X-CSE-ConnectionGUID: 5ZREydr2RuaL9e4NV62B3w==
X-CSE-MsgGUID: M5ZV9at3SeSPPXMav2xZGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611037"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:42 -0800
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
Subject: [PATCH V2 12/13] perf/x86/intel/uncore: Add missing PMON units for Panther Lake
Date: Wed, 31 Dec 2025 14:42:29 -0800
Message-ID: <20251231224233.113839-13-zide.chen@intel.com>
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

Besides CBOX, Panther Lake includes several legacy uncore PMON units
not enumerated via discovery tables, including cNCU, SANTA, and
ia_core_bridge.

The cNCU PMON is similar to Meteor Lake but has two boxes with two
counters each. SANTA and IA Core Bridge PMON units follow the legacy
model used on Lunar Lake, Meteor Lake, and others.

Panther Lake implements the Global Control Register; the freeze_all bit
must be cleared before programming counters.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2: new patch

 arch/x86/events/intel/uncore.c     |  1 +
 arch/x86/events/intel/uncore_snb.c | 45 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 54b3c1e3af32..07a9a2826398 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1814,6 +1814,7 @@ static const struct uncore_plat_init ptl_uncore_init __initconst = {
 	.cpu_init = ptl_uncore_cpu_init,
 	.mmio_init = ptl_uncore_mmio_init,
 	.domain[0].discovery_base = UNCORE_DISCOVERY_MSR,
+	.domain[0].global_init = uncore_mmio_global_init,
 };
 
 static const struct uncore_plat_init icx_uncore_init __initconst = {
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 807e582b8f17..c663b00b68fe 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -245,6 +245,17 @@
 #define MTL_UNC_HBO_CTR				0x2048
 #define MTL_UNC_HBO_CTRL			0x2042
 
+/* PTL Low Power Bridge register */
+#define PTL_UNC_IA_CORE_BRIDGE_PER_CTR0		0x2028
+#define PTL_UNC_IA_CORE_BRIDGE_PERFEVTSEL0	0x2022
+
+/* PTL Santa register */
+#define PTL_UNC_SANTA_CTR0			0x2418
+#define PTL_UNC_SANTA_CTRL0			0x2412
+
+/* PTL cNCU register */
+#define PTL_UNC_CNCU_MSR_OFFSET			0x140
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(chmask, chmask, "config:8-11");
@@ -1921,8 +1932,36 @@ void ptl_uncore_mmio_init(void)
 						 ptl_uncores);
 }
 
+static struct intel_uncore_type ptl_uncore_ia_core_bridge = {
+	.name		= "ia_core_bridge",
+	.num_counters   = 2,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= PTL_UNC_IA_CORE_BRIDGE_PER_CTR0,
+	.event_ctl	= PTL_UNC_IA_CORE_BRIDGE_PERFEVTSEL0,
+	.event_mask	= ADL_UNC_RAW_EVENT_MASK,
+	.ops		= &icl_uncore_msr_ops,
+	.format_group	= &adl_uncore_format_group,
+};
+
+static struct intel_uncore_type ptl_uncore_santa = {
+	.name		= "santa",
+	.num_counters   = 2,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= PTL_UNC_SANTA_CTR0,
+	.event_ctl	= PTL_UNC_SANTA_CTRL0,
+	.event_mask	= ADL_UNC_RAW_EVENT_MASK,
+	.msr_offset	= SNB_UNC_CBO_MSR_OFFSET,
+	.ops		= &icl_uncore_msr_ops,
+	.format_group	= &adl_uncore_format_group,
+};
+
 static struct intel_uncore_type *ptl_msr_uncores[] = {
 	&mtl_uncore_cbox,
+	&ptl_uncore_ia_core_bridge,
+	&ptl_uncore_santa,
+	&mtl_uncore_cncu,
 	NULL
 };
 
@@ -1930,6 +1969,12 @@ void ptl_uncore_cpu_init(void)
 {
 	mtl_uncore_cbox.num_boxes = 6;
 	mtl_uncore_cbox.ops = &lnl_uncore_msr_ops;
+
+	mtl_uncore_cncu.num_counters = 2;
+	mtl_uncore_cncu.num_boxes = 2;
+	mtl_uncore_cncu.msr_offset = PTL_UNC_CNCU_MSR_OFFSET;
+	mtl_uncore_cncu.single_fixed = 0;
+
 	uncore_msr_uncores = ptl_msr_uncores;
 }
 
-- 
2.52.0


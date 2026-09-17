Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20D388E58;
	Thu, 17 Sep 2026 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610425; cv=none; b=Ym4hd9vNYGuh5QsazBZLHP8ti+R9kkuwprquXvYCgw2dM7GVZgSCFazSHZCnCuq3LuyNxNKMo6x7uJ2P2ZPQ9sHBe89Dznb2FjyA9tXsnDnTpxYr5hyLmvAgXD2afi6VL/SotxjZSDpxYamMIwBMTTgVDlniMXLOWyOHPlI5gvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610425; c=relaxed/simple;
	bh=1gqZ9X8Fpfrq4Uj4081kzgRSFWTLEmTnjaYZoqMNYLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQ84p0Eeb89WZuBn+n2QhFEUFBgpKdghzacQ9bx0m44RLL/Vj21REINxQCba0wadrJqroLTprJMVn5aJHyDfn1IfcCp0rKzU8gOCVvLtbYcHg/HwXYGfDMSKxkYHwbCKOrZY5PAjxK4IrC2D1Av0rsaRhA/fmrvHBBui9ztVLZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VclEbDTG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VclEbDTG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610424; x=1821146424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1gqZ9X8Fpfrq4Uj4081kzgRSFWTLEmTnjaYZoqMNYLg=;
  b=VclEbDTGaYvyN791CrUntert4YmsGNXveitH4l1oGOTJdTSBpfWhHk1k
   wZCxu7irx+tMgh8H/1s+h8BQ1oCQUvHJGdj7JGc4YdoQ8fOIkRnLmlvkF
   xTfuARbk3zBaWm2BpwxMmBCtBw+e6jHyA7ievbDveMri6IuhlMXXMvHAY
   8DxCrP5VSz8zWWS5afjJd7NM4JWpZa2dn7t5iGzUIRd32qbeC6xWDvsvD
   8OTjkeiF/WDCVMsv4g007AAcxJLMfYAy4YuHlzpRMsYiqfmwoK8ABM48o
   8T5Py6evfu0pJeFfASVF4zmbRYwxZvze8/DMGBoy0wbxo8irmHQJVtn7u
   A==;
X-CSE-ConnectionGUID: rEoNzAdlRneN639RvGILJw==
X-CSE-MsgGUID: nCIeHbgERG+OCYC5DC93BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498658"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498658"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 19:00:24 -0700
X-CSE-ConnectionGUID: 6pX2qfC9QYirmS9SZIvj1Q==
X-CSE-MsgGUID: cwFCYn5GQRiWg6FVbcKd9w==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 19:00:20 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 11/12] perf/x86/intel: Rename DMR offcore_rsp attribute to offmodule_rsp
Date: Thu, 17 Sep 2026 09:52:33 +0800
Message-Id: <20260917015234.981153-12-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMR introduces Offmodule Response events in place of the legacy
Offcore Response events, but it still exposes the inherited
offcore_rsp PMU attribute for programming the corresponding MSR data.

Rename the DMR PMU attribute to offmodule_rsp so the sysfs interface
matches the underlying event name and avoids user confusion.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 276a54416d5c..963d391af2ee 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6620,6 +6620,8 @@ static void intel_pmu_filter(struct pmu *pmu, int cpu, bool *ret)
 
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
+PMU_FORMAT_ATTR(offmodule_rsp, "config1:0-63");
+
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
 
 PMU_FORMAT_ATTR(frontend, "config1:0-23");
@@ -6668,6 +6670,20 @@ static struct attribute *skl_format_attr[] = {
 	NULL,
 };
 
+static struct attribute *pnc_format_attr_rtm[] = {
+	&format_attr_in_tx.attr,
+	&format_attr_in_tx_cp.attr,
+	&format_attr_offmodule_rsp.attr,
+	&format_attr_ldlat.attr,
+	NULL
+};
+
+static struct attribute *pnc_format_attr[] = {
+	&format_attr_offmodule_rsp.attr,
+	&format_attr_ldlat.attr,
+	NULL
+};
+
 static __initconst const struct x86_pmu core_pmu = {
 	.name			= "core",
 	.handle_irq		= x86_pmu_handle_irq,
@@ -8608,6 +8624,8 @@ __init int intel_pmu_init(void)
 	case INTEL_DIAMONDRAPIDS_X:
 		intel_pmu_init_pnc(NULL);
 		x86_pmu.pebs_latency_data = pnc_latency_data;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			     pnc_format_attr_rtm : pnc_format_attr;
 
 		pr_cont("Panthercove events, ");
 		name = "panthercove";
@@ -8616,13 +8634,12 @@ __init int intel_pmu_init(void)
 	glc_common:
 		intel_pmu_init_glc(NULL);
 		intel_pmu_pebs_data_source_skl(true);
-
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			hsw_format_attr : nhm_format_attr;
 	glc_base:
 		x86_pmu.pebs_ept = 1;
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = glc_get_event_constraints;
-		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
-			hsw_format_attr : nhm_format_attr;
 		extra_skl_attr = skl_format_attr;
 		mem_attr = glc_events_attrs;
 		td_attr = glc_td_events_attrs;
-- 
2.34.1


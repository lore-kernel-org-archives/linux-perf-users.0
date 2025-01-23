Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5AB1CD1EA;
	Thu, 23 Jan 2025 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613227; cv=none; b=oJ8lFMvo9ZlVjP4Wpbuzda+4Fv4e1aAdQ0pvAM8ZiI9xGsEGW7Z46NT09fHiYZZo31YkUWVDkqRxU3DGw0UIGSyHh78qtKDIaMwR9HX10XakOLf47LbjYSJhRb2f10utPOFHh5/xF4WmcMywgUg6Gxnv7PWKcyImdt2pDgnqesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613227; c=relaxed/simple;
	bh=km79UngpPkrZIJwtiWyAjaZipv2uHIAEmkV3BKaTUDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fti2q1uyzZb89wiStwx09y8PS25GL2ohmVjKL43j4/EmUxTLvKLqYJRpeKJzjQsIH/ySp8xVaYoURzuODie20GG5wNV5GRgZ6rlzvI1nIaqo+jdN/yFqXYpWzmojN6K4lkOexTDdtr1tpHfY23Nn9OXPVgcKIhJdctZa0osnNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HANysIDb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HANysIDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613227; x=1769149227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=km79UngpPkrZIJwtiWyAjaZipv2uHIAEmkV3BKaTUDA=;
  b=HANysIDbIZ+8nlGoK/1ZhHa6BcRNJLvADOLLRkxbocnxRjq1UrnDpS3P
   Ctj4fuuskjBYtceXNs1Z48Xqz57JYmPW8+rhiAq4C0rGI4QBIECUo3gBX
   96rBPUxGJA4OBuykdedspZb47h4gkIUV7sOU+0a3ihIfdmlxLeEUjNwcP
   6/xxlOD1+RIq+eWZscuC1fbpBfztGqvGPs/J6kx0oTG8Djem4D71wYJY0
   fq0aTDuCkkcMjunfQhe4AsbbnPFrf/R/rvnv0hWQ7IFqL0BGzD10EC4Pf
   OrcJC5dwkaETm2Nbr1WHtnNCy/dwWmw49zFhNG1/M70uoCu0rKVuFe+gv
   A==;
X-CSE-ConnectionGUID: gD6usK2BS9uE/jA+zos8Ag==
X-CSE-MsgGUID: Ex8BCGdbQZKwPvyEnAbJXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513069"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513069"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:27 -0800
X-CSE-ConnectionGUID: beuVxB+5Q+KuYYe1J7YqgQ==
X-CSE-MsgGUID: b1sJz8ckREeKTF2XvOvVbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334498"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:22 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 05/20] perf/x86/intel: Rename x86_pmu.pebs to x86_pmu.ds_pebs
Date: Thu, 23 Jan 2025 14:07:06 +0000
Message-Id: <20250123140721.2496639-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since architectural PEBS would be introduced in subsequent patches,
rename x86_pmu.pebs to x86_pmu.ds_pebs for distinguishing with the
upcoming architectural PEBS.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c |  6 +++---
 arch/x86/events/intel/ds.c   | 20 ++++++++++----------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 91afba51038f..0063afa0ddac 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4268,7 +4268,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		.guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
 	};
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		return arr;
 
 	/*
@@ -5447,7 +5447,7 @@ static __init void intel_clovertown_quirk(void)
 	 * these chips.
 	 */
 	pr_warn("PEBS disabled due to CPU errata\n");
-	x86_pmu.pebs = 0;
+	x86_pmu.ds_pebs = 0;
 	x86_pmu.pebs_constraints = NULL;
 }
 
@@ -5945,7 +5945,7 @@ tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 static umode_t
 pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	return x86_pmu.pebs ? attr->mode : 0;
+	return x86_pmu.ds_pebs ? attr->mode : 0;
 }
 
 static umode_t
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 86fa6d8c45cf..e8a06c8486af 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -624,7 +624,7 @@ static int alloc_pebs_buffer(int cpu)
 	int max, node = cpu_to_node(cpu);
 	void *buffer, *insn_buff, *cea;
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		return 0;
 
 	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
@@ -659,7 +659,7 @@ static void release_pebs_buffer(int cpu)
 	struct cpu_hw_events *hwev = per_cpu_ptr(&cpu_hw_events, cpu);
 	void *cea;
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		return;
 
 	kfree(per_cpu(insn_buffer, cpu));
@@ -734,7 +734,7 @@ void release_ds_buffers(void)
 {
 	int cpu;
 
-	if (!x86_pmu.bts && !x86_pmu.pebs)
+	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
 		return;
 
 	for_each_possible_cpu(cpu)
@@ -763,13 +763,13 @@ void reserve_ds_buffers(void)
 	x86_pmu.bts_active = 0;
 	x86_pmu.pebs_active = 0;
 
-	if (!x86_pmu.bts && !x86_pmu.pebs)
+	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
 		return;
 
 	if (!x86_pmu.bts)
 		bts_err = 1;
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		pebs_err = 1;
 
 	for_each_possible_cpu(cpu) {
@@ -805,7 +805,7 @@ void reserve_ds_buffers(void)
 		if (x86_pmu.bts && !bts_err)
 			x86_pmu.bts_active = 1;
 
-		if (x86_pmu.pebs && !pebs_err)
+		if (x86_pmu.ds_pebs && !pebs_err)
 			x86_pmu.pebs_active = 1;
 
 		for_each_possible_cpu(cpu) {
@@ -2661,12 +2661,12 @@ void __init intel_pebs_init(void)
 	if (!boot_cpu_has(X86_FEATURE_DTES64))
 		return;
 
-	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
+	x86_pmu.ds_pebs = boot_cpu_has(X86_FEATURE_PEBS);
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	if (x86_pmu.version <= 4)
 		x86_pmu.pebs_no_isolation = 1;
 
-	if (x86_pmu.pebs) {
+	if (x86_pmu.ds_pebs) {
 		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';
 		char *pebs_qual = "";
 		int format = x86_pmu.intel_cap.pebs_format;
@@ -2750,7 +2750,7 @@ void __init intel_pebs_init(void)
 
 		default:
 			pr_cont("no PEBS fmt%d%c, ", format, pebs_type);
-			x86_pmu.pebs = 0;
+			x86_pmu.ds_pebs = 0;
 		}
 	}
 }
@@ -2759,7 +2759,7 @@ void perf_restore_debug_store(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
 
-	if (!x86_pmu.bts && !x86_pmu.pebs)
+	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
 		return;
 
 	wrmsrl(MSR_IA32_DS_AREA, (unsigned long)ds);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e15c2d0dbb27..d5b7f5605e1e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -888,7 +888,7 @@ struct x86_pmu {
 	 */
 	unsigned int	bts			:1,
 			bts_active		:1,
-			pebs			:1,
+			ds_pebs			:1,
 			pebs_active		:1,
 			pebs_broken		:1,
 			pebs_prec_dist		:1,
-- 
2.40.1


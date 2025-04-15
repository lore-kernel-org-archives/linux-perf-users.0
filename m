Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40171F460E;
	Tue, 15 Apr 2025 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705409; cv=none; b=UNF5L998vvgF9PoqrZW7mAJSk1SnCJUCypJG+vHlZoxZ+yNWYZXoJl3mW+mwETVsqE9u0LiptLGLCHSPypjNHlktqKSxEysuOo6yr7/QDzF0109/3lkBJsFiLeGO4ZquMB8oNUNETkiEVm48itWK+YbDacHHNMeMO9S2cJpQJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705409; c=relaxed/simple;
	bh=THPWTcNrmMqrZSGJ5ztCISz7v65l37PxQ6MERtG7qnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CeG4kPOP8Pd8qeJq4Dz1U91Wt+E72f+eALhILEoe6/1uyImDqiHMlt9sNQ5xI305/J5FOEycT6vB0ldLeN84AnH+j4JCqjOyPBz+YTR/pU8qkO1TxtIIpzSoDgLISJXnHreJNTdloUvbRR19fTeb40KWVt875ZmoSOxxWHS+6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFPJlCZR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFPJlCZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705408; x=1776241408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=THPWTcNrmMqrZSGJ5ztCISz7v65l37PxQ6MERtG7qnA=;
  b=BFPJlCZRyH5at2QFlBDZ9cUhlx9QJ2Er+gn4T4EoTBv8QPNMYTS6myfP
   patAcMZeAS/uLZZOmrsVbQUVHIyChLFQxQ60yoKFmRgjIEno/VvpK7IHI
   VjvMLvS+gqOcDTunsXQnPvcpPy7mItdgOu24Q8jW8n2utgLmA7tefuNWN
   zkODHHt3cCErbovHgKGaM/6LQTxAWcPIO9GDCTI2+AfE8XYZov5lyxemm
   nSnIvKuJ2iS1rx1eaGZrCCT3fZtxdl5Mjs4yBEY7F+gPKSfOJ8h9FD9wD
   XmAKwflScssdXsNTMjRW546k+El9UNShsbgK/aDBFxUDKJNEWfIKoG+h0
   A==;
X-CSE-ConnectionGUID: P8RmYE6uThe0hOHQuZcAEg==
X-CSE-MsgGUID: Pakhtqd/RzyiPIKKyEEsjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46115887"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46115887"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:23:28 -0700
X-CSE-ConnectionGUID: 79kwlrdORlSUgmKv+Rel7Q==
X-CSE-MsgGUID: REX9lZgRRPqeZoKtDBkMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055502"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:23:24 -0700
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
Subject: [Patch v3 05/22] perf/x86/intel: Rename x86_pmu.pebs to x86_pmu.ds_pebs
Date: Tue, 15 Apr 2025 11:44:11 +0000
Message-Id: <20250415114428.341182-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
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

Besides restrict reserve_ds_buffers() helper to work only for the
legacy DS based PEBS and avoid it to corrupt the pebs_active flag and
release PEBS buffer incorrectly for arch-PEBS since the later patch
would reuse these flags and alloc/release_pebs_buffer() helpers for
arch-PEBS.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c |  6 +++---
 arch/x86/events/intel/ds.c   | 32 ++++++++++++++++++--------------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 16049ba63135..7bbc7a740242 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4584,7 +4584,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		.guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
 	};
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		return arr;
 
 	/*
@@ -5764,7 +5764,7 @@ static __init void intel_clovertown_quirk(void)
 	 * these chips.
 	 */
 	pr_warn("PEBS disabled due to CPU errata\n");
-	x86_pmu.pebs = 0;
+	x86_pmu.ds_pebs = 0;
 	x86_pmu.pebs_constraints = NULL;
 }
 
@@ -6252,7 +6252,7 @@ tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 static umode_t
 pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	return x86_pmu.pebs ? attr->mode : 0;
+	return x86_pmu.ds_pebs ? attr->mode : 0;
 }
 
 static umode_t
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index d894cf3f631e..1d6b3fa6a8eb 100644
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
@@ -750,7 +750,8 @@ void release_ds_buffers(void)
 	}
 
 	for_each_possible_cpu(cpu) {
-		release_pebs_buffer(cpu);
+		if (x86_pmu.ds_pebs)
+			release_pebs_buffer(cpu);
 		release_bts_buffer(cpu);
 	}
 }
@@ -761,15 +762,17 @@ void reserve_ds_buffers(void)
 	int cpu;
 
 	x86_pmu.bts_active = 0;
-	x86_pmu.pebs_active = 0;
 
-	if (!x86_pmu.bts && !x86_pmu.pebs)
+	if (x86_pmu.ds_pebs)
+		x86_pmu.pebs_active = 0;
+
+	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
 		return;
 
 	if (!x86_pmu.bts)
 		bts_err = 1;
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		pebs_err = 1;
 
 	for_each_possible_cpu(cpu) {
@@ -781,7 +784,8 @@ void reserve_ds_buffers(void)
 		if (!bts_err && alloc_bts_buffer(cpu))
 			bts_err = 1;
 
-		if (!pebs_err && alloc_pebs_buffer(cpu))
+		if (x86_pmu.ds_pebs && !pebs_err &&
+		    alloc_pebs_buffer(cpu))
 			pebs_err = 1;
 
 		if (bts_err && pebs_err)
@@ -793,7 +797,7 @@ void reserve_ds_buffers(void)
 			release_bts_buffer(cpu);
 	}
 
-	if (pebs_err) {
+	if (x86_pmu.ds_pebs && pebs_err) {
 		for_each_possible_cpu(cpu)
 			release_pebs_buffer(cpu);
 	}
@@ -805,7 +809,7 @@ void reserve_ds_buffers(void)
 		if (x86_pmu.bts && !bts_err)
 			x86_pmu.bts_active = 1;
 
-		if (x86_pmu.pebs && !pebs_err)
+		if (x86_pmu.ds_pebs && !pebs_err)
 			x86_pmu.pebs_active = 1;
 
 		for_each_possible_cpu(cpu) {
@@ -2662,12 +2666,12 @@ void __init intel_pebs_init(void)
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
@@ -2759,7 +2763,7 @@ void __init intel_pebs_init(void)
 
 		default:
 			pr_cont("no PEBS fmt%d%c, ", format, pebs_type);
-			x86_pmu.pebs = 0;
+			x86_pmu.ds_pebs = 0;
 		}
 	}
 }
@@ -2768,7 +2772,7 @@ void perf_restore_debug_store(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
 
-	if (!x86_pmu.bts && !x86_pmu.pebs)
+	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
 		return;
 
 	wrmsrl(MSR_IA32_DS_AREA, (unsigned long)ds);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ac6743e392ad..2ef407d0a7e2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -898,7 +898,7 @@ struct x86_pmu {
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


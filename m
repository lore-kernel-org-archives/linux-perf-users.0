Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6B22ACE4;
	Tue, 18 Feb 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866454; cv=none; b=ZIkaXdCLi39k7fKjh+ZWtlHncl/adIJRsPEZjOdDv5RdqO06zTXzG/xGHlTRZ38wL+itaVYHPseV8D9DVLYc0O9sl3HObD9yNsdFHaYmLZt4igjme7Z7Qibj3yipVmh4gu0RYrwoPjgsPC9LNRXE+ELNLzFDBf8YbOLvwqbPwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866454; c=relaxed/simple;
	bh=LkAkZZj7J2kYejlOews8Y7GNR2FQyWsbjUFeggnHz50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lz1j7mo2StcRtBg1WzDpVens5Fje1AIvtQmeqDaqLYX6GpNsdT7Wn4beVqNrMgqVRulwO0GRbTI+bA4zPzVRj0up2klcbrx6lH+HjElC/UPXsJ0MZ6S4/8x6wkjpeGEfXm1i38Xll8nkfL2UavG01VYjx87ZqFtI1GTGZxqVfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iahgi0iB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iahgi0iB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866454; x=1771402454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LkAkZZj7J2kYejlOews8Y7GNR2FQyWsbjUFeggnHz50=;
  b=Iahgi0iB2lZk3375LzOGFpXo7Nh9/xg25HX6fWyIvHaA3dFzQfh3kf4h
   p9yhb0dZ/SXg6eTQ07D++ULRq406J7p2+X8XouFrRE4yf7gWqn37HSp7n
   LblgA13VCq3fFGH/6C4W7Pi0oQKddlp0annQmzubhB48BTmhukVa6wg1D
   FaJjA1iuXw6O8CG9NpbIUHMiQ73n5r8rhlObK+j9fiehy7FMXNx0lNLND
   RNXju4LtcDR8cwrFpyNhifR7gOifO3NlySYopDv8bZEwDDyOdMzPr6S0g
   JLLhHlLkFlxZEWDxk4nvgkI3/DvwmryxPK1LMA71GqvSEmnzbpk1rNN5g
   Q==;
X-CSE-ConnectionGUID: uMgCxlO7T86AhRfjUKMvtw==
X-CSE-MsgGUID: Oh8yZ7IsSiS9/Ft450E7vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200763"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200763"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:11 -0800
X-CSE-ConnectionGUID: F5j/8fIyRe6Iwnr2+PP5gQ==
X-CSE-MsgGUID: G4l70+FvQbiPjweoLlgFiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166165"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:01 -0800
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
Subject: [Patch v2 06/24] perf/x86/intel: Rename x86_pmu.pebs to x86_pmu.ds_pebs
Date: Tue, 18 Feb 2025 15:28:00 +0000
Message-Id: <20250218152818.158614-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
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
index a977d4d631fe..f45296f30ec2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4281,7 +4281,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		.guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
 	};
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		return arr;
 
 	/*
@@ -5454,7 +5454,7 @@ static __init void intel_clovertown_quirk(void)
 	 * these chips.
 	 */
 	pr_warn("PEBS disabled due to CPU errata\n");
-	x86_pmu.pebs = 0;
+	x86_pmu.ds_pebs = 0;
 	x86_pmu.pebs_constraints = NULL;
 }
 
@@ -5942,7 +5942,7 @@ tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 static umode_t
 pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	return x86_pmu.pebs ? attr->mode : 0;
+	return x86_pmu.ds_pebs ? attr->mode : 0;
 }
 
 static umode_t
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 9c8947d3413f..2a4dc0bbc4f7 100644
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
@@ -2758,7 +2758,7 @@ void __init intel_pebs_init(void)
 
 		default:
 			pr_cont("no PEBS fmt%d%c, ", format, pebs_type);
-			x86_pmu.pebs = 0;
+			x86_pmu.ds_pebs = 0;
 		}
 	}
 }
@@ -2767,7 +2767,7 @@ void perf_restore_debug_store(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
 
-	if (!x86_pmu.bts && !x86_pmu.pebs)
+	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
 		return;
 
 	wrmsrl(MSR_IA32_DS_AREA, (unsigned long)ds);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 0a259c98056a..1e7884fdd990 100644
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


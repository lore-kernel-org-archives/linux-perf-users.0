Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BC232368;
	Tue, 18 Feb 2025 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866471; cv=none; b=Cnos725VB3n/cUoTKax5uf+un3ezvMARfiRcyEIvpvC1bxLRadsIRaU2ufanEhyXOip9+cD62eThtEVX3RbcfVdrQ3OwxyighGHaU84WJ067D2Abl9CZfJaxx5whLySoMlxAInSg2lVAmkpSBw2FVwuvTQz9F6sFd2Eb6esEKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866471; c=relaxed/simple;
	bh=O8T9OEgFj5f0+ULCh01SzqxtqeP8QMx+s1ejU6AHjQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3Xo89enRd/4z0B5N3NOkyh+7sEGqmzJoxsVZ/csCjlX9TAxw5VtC+BI/Rr6kcYC4DV7Z/4NzKkcT6JNZhi/zKV4AsZarONynT0xUD0S0carM+FZj1vCrQ+wTjD8F5+pmTAtS4ozkylMRcMYxfA6jDMUTmqKHGKBIIg+HdA0IzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f83RROT4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f83RROT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866471; x=1771402471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O8T9OEgFj5f0+ULCh01SzqxtqeP8QMx+s1ejU6AHjQI=;
  b=f83RROT4Ly4fuz6rRbqSGhuX856QMKP9bkeEV6FRuN4Kf8if6On+s+BI
   3uBRjM718EgWEk3bsy3bjU9BIzSOuKLJ1hqY7ivEZ+EvKEG7daWdVb2NC
   XemDs5IiATQ/NSXajfBpDprrci7ZvImFXjxdrKTOSoN4+TSQAFs4efkyv
   4Bnvr8tl/3cWUPYrQuWyWq5Jv3zCjji42S+3aBpV5xSfX1qpopN0eV4H0
   HKAs7N2BXdVLcBBZhYT6v9qsP7M9HUsW9a+Z6B22mBKjGT9BIQIz9TEa+
   4LgC3MZrXJyhSe8qhB3SNF5PKb+HAr85EoydsHAxNgvHKLOdiQZP6NwLk
   A==;
X-CSE-ConnectionGUID: oI+dbdyFQ/K30sujDcXa9A==
X-CSE-MsgGUID: relAQ9iZT32B2a4C4ABcbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200809"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200809"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:31 -0800
X-CSE-ConnectionGUID: 6Wy6vubZT4+e+5J9ZhZ/Tw==
X-CSE-MsgGUID: JFU+Eoi4SbeiEo5YwyBdHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166247"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:26 -0800
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
Subject: [Patch v2 12/24] perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
Date: Tue, 18 Feb 2025 15:28:06 +0000
Message-Id: <20250218152818.158614-13-dapeng1.mi@linux.intel.com>
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

Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
buffer physical address. This patch allocates arch-PEBS buffer and then
initialize IA32_PEBS_BASE MSR with the buffer physical address.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c          |   4 +-
 arch/x86/events/intel/core.c    |   4 +-
 arch/x86/events/intel/ds.c      | 112 ++++++++++++++++++++------------
 arch/x86/events/perf_event.h    |  16 ++---
 arch/x86/include/asm/intel_ds.h |   3 +-
 5 files changed, 84 insertions(+), 55 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 24ae1159d6b9..4eaafabf033e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -416,7 +416,7 @@ int x86_reserve_hardware(void)
 			if (!reserve_pmc_hardware()) {
 				err = -EBUSY;
 			} else {
-				reserve_ds_buffers();
+				reserve_bts_pebs_buffers();
 				reserve_lbr_buffers();
 			}
 		}
@@ -432,7 +432,7 @@ void x86_release_hardware(void)
 {
 	if (atomic_dec_and_mutex_lock(&pmc_refcount, &pmc_reserve_mutex)) {
 		release_pmc_hardware();
-		release_ds_buffers();
+		release_bts_pebs_buffers();
 		release_lbr_buffers();
 		mutex_unlock(&pmc_reserve_mutex);
 	}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 184f69afde08..472366c3db22 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5129,7 +5129,7 @@ static void intel_pmu_cpu_starting(int cpu)
 	if (is_hybrid() && !init_hybrid_pmu(cpu))
 		return;
 
-	init_debug_store_on_cpu(cpu);
+	init_pebs_buf_on_cpu(cpu);
 	/*
 	 * Deal with CPUs that don't clear their LBRs on power-up.
 	 */
@@ -5223,7 +5223,7 @@ static void free_excl_cntrs(struct cpu_hw_events *cpuc)
 
 static void intel_pmu_cpu_dying(int cpu)
 {
-	fini_debug_store_on_cpu(cpu);
+	fini_pebs_buf_on_cpu(cpu);
 }
 
 void intel_cpuc_finish(struct cpu_hw_events *cpuc)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 65eaba3aa48d..519767fc9180 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -545,26 +545,6 @@ struct pebs_record_skl {
 	u64 tsc;
 };
 
-void init_debug_store_on_cpu(int cpu)
-{
-	struct debug_store *ds = per_cpu(cpu_hw_events, cpu).ds;
-
-	if (!ds)
-		return;
-
-	wrmsr_on_cpu(cpu, MSR_IA32_DS_AREA,
-		     (u32)((u64)(unsigned long)ds),
-		     (u32)((u64)(unsigned long)ds >> 32));
-}
-
-void fini_debug_store_on_cpu(int cpu)
-{
-	if (!per_cpu(cpu_hw_events, cpu).ds)
-		return;
-
-	wrmsr_on_cpu(cpu, MSR_IA32_DS_AREA, 0, 0);
-}
-
 static DEFINE_PER_CPU(void *, insn_buffer);
 
 static void ds_update_cea(void *cea, void *addr, size_t size, pgprot_t prot)
@@ -624,13 +604,18 @@ static int alloc_pebs_buffer(int cpu)
 	int max, node = cpu_to_node(cpu);
 	void *buffer, *insn_buff, *cea;
 
-	if (!x86_pmu.ds_pebs)
+	if (!intel_pmu_has_pebs())
 		return 0;
 
-	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
+	buffer = dsalloc_pages(bsiz, preemptible() ? GFP_KERNEL : GFP_ATOMIC, cpu);
 	if (unlikely(!buffer))
 		return -ENOMEM;
 
+	if (x86_pmu.arch_pebs) {
+		hwev->pebs_vaddr = buffer;
+		return 0;
+	}
+
 	/*
 	 * HSW+ already provides us the eventing ip; no need to allocate this
 	 * buffer then.
@@ -643,7 +628,7 @@ static int alloc_pebs_buffer(int cpu)
 		}
 		per_cpu(insn_buffer, cpu) = insn_buff;
 	}
-	hwev->ds_pebs_vaddr = buffer;
+	hwev->pebs_vaddr = buffer;
 	/* Update the cpu entry area mapping */
 	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
 	ds->pebs_buffer_base = (unsigned long) cea;
@@ -659,17 +644,20 @@ static void release_pebs_buffer(int cpu)
 	struct cpu_hw_events *hwev = per_cpu_ptr(&cpu_hw_events, cpu);
 	void *cea;
 
-	if (!x86_pmu.ds_pebs)
+	if (!intel_pmu_has_pebs())
 		return;
 
-	kfree(per_cpu(insn_buffer, cpu));
-	per_cpu(insn_buffer, cpu) = NULL;
+	if (x86_pmu.ds_pebs) {
+		kfree(per_cpu(insn_buffer, cpu));
+		per_cpu(insn_buffer, cpu) = NULL;
 
-	/* Clear the fixmap */
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
-	ds_clear_cea(cea, x86_pmu.pebs_buffer_size);
-	dsfree_pages(hwev->ds_pebs_vaddr, x86_pmu.pebs_buffer_size);
-	hwev->ds_pebs_vaddr = NULL;
+		/* Clear the fixmap */
+		cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
+		ds_clear_cea(cea, x86_pmu.pebs_buffer_size);
+	}
+
+	dsfree_pages(hwev->pebs_vaddr, x86_pmu.pebs_buffer_size);
+	hwev->pebs_vaddr = NULL;
 }
 
 static int alloc_bts_buffer(int cpu)
@@ -730,11 +718,11 @@ static void release_ds_buffer(int cpu)
 	per_cpu(cpu_hw_events, cpu).ds = NULL;
 }
 
-void release_ds_buffers(void)
+void release_bts_pebs_buffers(void)
 {
 	int cpu;
 
-	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
+	if (!x86_pmu.bts && !intel_pmu_has_pebs())
 		return;
 
 	for_each_possible_cpu(cpu)
@@ -746,7 +734,7 @@ void release_ds_buffers(void)
 		 * observe cpu_hw_events.ds and not program the DS_AREA when
 		 * they come up.
 		 */
-		fini_debug_store_on_cpu(cpu);
+		fini_pebs_buf_on_cpu(cpu);
 	}
 
 	for_each_possible_cpu(cpu) {
@@ -755,7 +743,7 @@ void release_ds_buffers(void)
 	}
 }
 
-void reserve_ds_buffers(void)
+void reserve_bts_pebs_buffers(void)
 {
 	int bts_err = 0, pebs_err = 0;
 	int cpu;
@@ -763,19 +751,20 @@ void reserve_ds_buffers(void)
 	x86_pmu.bts_active = 0;
 	x86_pmu.pebs_active = 0;
 
-	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
+	if (!x86_pmu.bts && !intel_pmu_has_pebs())
 		return;
 
 	if (!x86_pmu.bts)
 		bts_err = 1;
 
-	if (!x86_pmu.ds_pebs)
+	if (!intel_pmu_has_pebs())
 		pebs_err = 1;
 
 	for_each_possible_cpu(cpu) {
 		if (alloc_ds_buffer(cpu)) {
 			bts_err = 1;
-			pebs_err = 1;
+			if (x86_pmu.ds_pebs)
+				pebs_err = 1;
 		}
 
 		if (!bts_err && alloc_bts_buffer(cpu))
@@ -805,7 +794,7 @@ void reserve_ds_buffers(void)
 		if (x86_pmu.bts && !bts_err)
 			x86_pmu.bts_active = 1;
 
-		if (x86_pmu.ds_pebs && !pebs_err)
+		if (intel_pmu_has_pebs() && !pebs_err)
 			x86_pmu.pebs_active = 1;
 
 		for_each_possible_cpu(cpu) {
@@ -813,11 +802,50 @@ void reserve_ds_buffers(void)
 			 * Ignores wrmsr_on_cpu() errors for offline CPUs they
 			 * will get this call through intel_pmu_cpu_starting().
 			 */
-			init_debug_store_on_cpu(cpu);
+			init_pebs_buf_on_cpu(cpu);
 		}
 	}
 }
 
+void init_pebs_buf_on_cpu(int cpu)
+{
+	struct cpu_hw_events *cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+
+	if (x86_pmu.arch_pebs) {
+		u64 arch_pebs_base;
+
+		if (!cpuc->pebs_vaddr)
+			return;
+
+		/*
+		 * 4KB-aligned pointer of the output buffer
+		 * (__alloc_pages_node() return page aligned address)
+		 * Buffer Size = 4KB * 2^SIZE
+		 * contiguous physical buffer (__alloc_pages_node() with order)
+		 */
+		arch_pebs_base = virt_to_phys(cpuc->pebs_vaddr) | PEBS_BUFFER_SHIFT;
+
+		wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE,
+			    (u32)arch_pebs_base,
+			    (u32)(arch_pebs_base >> 32));
+	} else if (cpuc->ds) {
+		/* legacy PEBS */
+		wrmsr_on_cpu(cpu, MSR_IA32_DS_AREA,
+		     (u32)((u64)(unsigned long)cpuc->ds),
+		     (u32)((u64)(unsigned long)cpuc->ds >> 32));
+	}
+}
+
+void fini_pebs_buf_on_cpu(int cpu)
+{
+	struct cpu_hw_events *cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+
+	if (x86_pmu.arch_pebs)
+		wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0, 0);
+	else if (cpuc->ds)
+		wrmsr_on_cpu(cpu, MSR_IA32_DS_AREA, 0, 0);
+}
+
 /*
  * BTS
  */
@@ -2857,8 +2885,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 		return;
 	}
 
-	base = cpuc->ds_pebs_vaddr;
-	top = (void *)((u64)cpuc->ds_pebs_vaddr +
+	base = cpuc->pebs_vaddr;
+	top = (void *)((u64)cpuc->pebs_vaddr +
 		       (index.split.wr << ARCH_PEBS_INDEX_WR_SHIFT));
 
 	mask = hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_enabled;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 265d76a321dd..1f20892f4040 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -266,11 +266,11 @@ struct cpu_hw_events {
 	int			is_fake;
 
 	/*
-	 * Intel DebugStore bits
+	 * Intel DebugStore/PEBS bits
 	 */
 	struct debug_store	*ds;
-	void			*ds_pebs_vaddr;
 	void			*ds_bts_vaddr;
+	void			*pebs_vaddr;
 	u64			pebs_enabled;
 	int			n_pebs;
 	int			n_large_pebs;
@@ -1603,13 +1603,13 @@ extern void intel_cpuc_finish(struct cpu_hw_events *cpuc);
 
 int intel_pmu_init(void);
 
-void init_debug_store_on_cpu(int cpu);
+void init_pebs_buf_on_cpu(int cpu);
 
-void fini_debug_store_on_cpu(int cpu);
+void fini_pebs_buf_on_cpu(int cpu);
 
-void release_ds_buffers(void);
+void release_bts_pebs_buffers(void);
 
-void reserve_ds_buffers(void);
+void reserve_bts_pebs_buffers(void);
 
 void release_lbr_buffers(void);
 
@@ -1796,11 +1796,11 @@ static inline bool intel_pmu_has_pebs(void)
 
 #else /* CONFIG_CPU_SUP_INTEL */
 
-static inline void reserve_ds_buffers(void)
+static inline void reserve_bts_pebs_buffers(void)
 {
 }
 
-static inline void release_ds_buffers(void)
+static inline void release_bts_pebs_buffers(void)
 {
 }
 
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 5dbeac48a5b9..023c2883f9f3 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -4,7 +4,8 @@
 #include <linux/percpu-defs.h>
 
 #define BTS_BUFFER_SIZE		(PAGE_SIZE << 4)
-#define PEBS_BUFFER_SIZE	(PAGE_SIZE << 4)
+#define PEBS_BUFFER_SHIFT	4
+#define PEBS_BUFFER_SIZE	(PAGE_SIZE << PEBS_BUFFER_SHIFT)
 
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS_FMT4	8
-- 
2.40.1


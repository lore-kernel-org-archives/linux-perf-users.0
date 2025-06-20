Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20781228CBE;
	Fri, 20 Jun 2025 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404574; cv=none; b=EWK3qd4dPPLdzNUOq6iiGgJHkpLtiUHFZIGNJWduhiMz0dqF2zkXAAJ8Bs/SOFNq8Y0gOod/G7MJrNg4m5/gbJYTnmgSBu0XTbG/etMBD2uZkRd8AITyg7olsNcjOgVdQDURlMisafC5snx8pKCLpGuH2Gh5yXnCY5L42TWYSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404574; c=relaxed/simple;
	bh=Bn7I4ijfObfwLsbZ5vl8m3VAhJx6IDyhwXBll6CFl1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8nydq8ty8TXJX5Z3MB4IVCfDHvKv/ckLnblyfYfPhV9Fm9QtMGwzqGH+ahJ/6zw08QRP5xYvAToupvhi9+ML/Ci1UIlaQC+0OzkBO5Kb0i7Y/58oFvtZEeZm9KVr4H8d0QMWO66BiKSDydKVaZNZTPVueQlubixXj4cqftxE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7Sh8Hhc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7Sh8Hhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404573; x=1781940573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bn7I4ijfObfwLsbZ5vl8m3VAhJx6IDyhwXBll6CFl1o=;
  b=F7Sh8HhcW868pFMuoMVGnnuUTxLDdUs0n8WvbeyvS9AnjnTCO/zevjZE
   XhKdtUWFww9cyqh8c/zdFNc3b76fjK3dm8lYewKhsruBqwe/uNnVfpwSq
   zhBX3t6OtGtnGb9/KqUMzf0tRxNdtcD3t2OsPVW6B2xfddkI+A3mNwclK
   Ce0/6dyw5H5epWPI5ehKyZtJPaftbWtG7rihxSzzPDg3/h3A0sfOH6iri
   aLKMicdLiDFCitcK8O1+QdtHGc8pWj6SrNoi3bTkf0wc1MxvwL/kcl33Q
   2ucitd1ceDG5Nt5QfwWQbKq1x2IlN+UCoDvG7Patk3z7HNaSEzb6bAf1r
   w==;
X-CSE-ConnectionGUID: U97RoZ70RGyQvixmDgw+4w==
X-CSE-MsgGUID: kRv4nzBoQR2TtiNLlq3AHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887765"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887765"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:32 -0700
X-CSE-ConnectionGUID: 8cmhzUYoQZaN5SpQvhyBZw==
X-CSE-MsgGUID: Yt98FONGSHuAzLFZJ0257Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156651036"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:29 -0700
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
Subject: [Patch v4 07/13] perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
Date: Fri, 20 Jun 2025 10:39:03 +0000
Message-ID: <20250620103909.1586595-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
buffer physical address. This patch allocates arch-PEBS buffer and then
initializeis IA32_PEBS_BASE MSR with the allocated PEBS buffer physical
address.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c    |  2 +
 arch/x86/events/intel/ds.c      | 73 +++++++++++++++++++++++++++------
 arch/x86/events/perf_event.h    |  7 +++-
 arch/x86/include/asm/intel_ds.h |  3 +-
 4 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4025ea7934ac..5e6ef9f3a077 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5460,6 +5460,7 @@ static void intel_pmu_cpu_starting(int cpu)
 		return;
 
 	init_debug_store_on_cpu(cpu);
+	init_arch_pebs_buf_on_cpu(cpu);
 	/*
 	 * Deal with CPUs that don't clear their LBRs on power-up, and that may
 	 * even boot with LBRs enabled.
@@ -5557,6 +5558,7 @@ static void free_excl_cntrs(struct cpu_hw_events *cpuc)
 static void intel_pmu_cpu_dying(int cpu)
 {
 	fini_debug_store_on_cpu(cpu);
+	fini_arch_pebs_buf_on_cpu(cpu);
 }
 
 void intel_cpuc_finish(struct cpu_hw_events *cpuc)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b6eface4dccd..72b925b8c482 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -625,13 +625,22 @@ static int alloc_pebs_buffer(int cpu)
 	int max, node = cpu_to_node(cpu);
 	void *buffer, *insn_buff, *cea;
 
-	if (!x86_pmu.ds_pebs)
+	if (!intel_pmu_has_pebs())
 		return 0;
 
-	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
+	/*
+	 * alloc_pebs_buffer() could be called by init_arch_pebs_buf_on_cpu()
+	 * which is in atomic context.
+	 */
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
@@ -644,7 +653,7 @@ static int alloc_pebs_buffer(int cpu)
 		}
 		per_cpu(insn_buffer, cpu) = insn_buff;
 	}
-	hwev->ds_pebs_vaddr = buffer;
+	hwev->pebs_vaddr = buffer;
 	/* Update the cpu entry area mapping */
 	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
 	ds->pebs_buffer_base = (unsigned long) cea;
@@ -660,17 +669,20 @@ static void release_pebs_buffer(int cpu)
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
@@ -823,6 +835,41 @@ void reserve_ds_buffers(void)
 	}
 }
 
+void init_arch_pebs_buf_on_cpu(int cpu)
+{
+	struct cpu_hw_events *cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+	u64 arch_pebs_base;
+
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	if (alloc_pebs_buffer(cpu) < 0 || !cpuc->pebs_vaddr) {
+		WARN(1, "Fail to allocate PEBS buffer on CPU %d\n", cpu);
+		x86_pmu.pebs_active = 0;
+		return;
+	}
+
+	/*
+	 * 4KB-aligned pointer of the output buffer
+	 * (__alloc_pages_node() return page aligned address)
+	 * Buffer Size = 4KB * 2^SIZE
+	 * contiguous physical buffer (__alloc_pages_node() with order)
+	 */
+	arch_pebs_base = virt_to_phys(cpuc->pebs_vaddr) | PEBS_BUFFER_SHIFT;
+	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, (u32)arch_pebs_base,
+		     (u32)(arch_pebs_base >> 32));
+	x86_pmu.pebs_active = 1;
+}
+
+void fini_arch_pebs_buf_on_cpu(int cpu)
+{
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0, 0);
+	release_pebs_buffer(cpu);
+}
+
 /*
  * BTS
  */
@@ -2877,8 +2924,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 		return;
 	}
 
-	base = cpuc->ds_pebs_vaddr;
-	top = (void *)((u64)cpuc->ds_pebs_vaddr +
+	base = cpuc->pebs_vaddr;
+	top = (void *)((u64)cpuc->pebs_vaddr +
 		       (index.split.wr << ARCH_PEBS_INDEX_WR_SHIFT));
 
 	mask = hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_enabled;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a5145e8f1ddb..82e8c20611b9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -283,8 +283,9 @@ struct cpu_hw_events {
 	 * Intel DebugStore bits
 	 */
 	struct debug_store	*ds;
-	void			*ds_pebs_vaddr;
 	void			*ds_bts_vaddr;
+	/* DS based PEBS or arch-PEBS buffer address */
+	void			*pebs_vaddr;
 	u64			pebs_enabled;
 	int			n_pebs;
 	int			n_large_pebs;
@@ -1618,6 +1619,10 @@ extern void intel_cpuc_finish(struct cpu_hw_events *cpuc);
 
 int intel_pmu_init(void);
 
+void init_arch_pebs_buf_on_cpu(int cpu);
+
+void fini_arch_pebs_buf_on_cpu(int cpu);
+
 void init_debug_store_on_cpu(int cpu);
 
 void fini_debug_store_on_cpu(int cpu);
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
2.43.0


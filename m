Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6F21B9FC;
	Thu, 26 Jun 2025 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909394; cv=none; b=XqU+vyO5flypXoNdYOxmXTn0l+Ug0/XtXV0mDARLPVszSgw+oECPwl0JCVHKyWquyeuQirdGGtwztGfx5r95g6x3eTlMw8Yf+izcsf8fuy4VAB745u4hfGkPSeWaoOmcb1nx1fJi3ql9IZX7St/R03uPYwYPB2FlvVAoJOe4y4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909394; c=relaxed/simple;
	bh=2HhECmMtrwTMyjOHvk5mqGMHBvMDdbP4HEjq5etcJP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDi1FL6pZJXtqziW2tSi4iZDYbQUzHcczsyhOSYkjgultY7WS+TQqciwfqihn0r8Eo/EwWmgq7vWDvwOG1KKZDMQHIb8x+BgOO1N7JbnMDqxdgp/xgJiRZYjmTA3TMfK+wkKUFRtwRzJhWIrTO4QWzQcJYBCh0s0SQJ8QalMj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fo91O34R; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fo91O34R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750909393; x=1782445393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2HhECmMtrwTMyjOHvk5mqGMHBvMDdbP4HEjq5etcJP0=;
  b=Fo91O34Ry3PiV1NUN8qbx/mtCBAD7wo/9/MbaRvlplQb46mBW3/KxUOm
   5K1uy8TlTiWx4AB/JhhIaiiOro9NPr6HtOAEESsVbKtutV468r8fIiqtP
   KtmQZ3VWhGp2PkYECL/QcT04jj7XjdSpZvB4QUautkzoMmZHaRUMjNYsH
   wAvLm4cLQCVXpLPbS/uBHCiFs05XWUhdatvMfhdBLrmUcFqeuxJ8RoHNE
   zvahSjSiC61ZeK1csIoUypZhO9Q0iZzJNEl6pEaEduczaQDZ6+DCuPR0B
   vfAPy+MNUW71g1keShK8kMxjgM6ROWOhjrksX3WZEl2OYDzvebWN6UPF7
   Q==;
X-CSE-ConnectionGUID: vtnxt0MRTtyoJ0iAQNUWKA==
X-CSE-MsgGUID: 9WW/PvUAQDe6JOQghYLgag==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55820685"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="55820685"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 20:43:13 -0700
X-CSE-ConnectionGUID: gkUYpLMgTPq+EbL8MlwXAQ==
X-CSE-MsgGUID: P1idzuEBT8qc3o/EAsrKpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="157895005"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 20:43:10 -0700
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
Subject: [Patch v5 07/10] perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
Date: Mon, 23 Jun 2025 22:35:42 +0000
Message-ID: <20250623223546.112465-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
References: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/core.c    | 11 ++++-
 arch/x86/events/intel/ds.c      | 82 ++++++++++++++++++++++++++++-----
 arch/x86/events/perf_event.h    | 11 ++++-
 arch/x86/include/asm/intel_ds.h |  3 +-
 4 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cfded13034ed..da6efd08149f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5230,7 +5230,13 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 
 static int intel_pmu_cpu_prepare(int cpu)
 {
-	return intel_cpuc_prepare(&per_cpu(cpu_hw_events, cpu), cpu);
+	int ret;
+
+	ret = intel_cpuc_prepare(&per_cpu(cpu_hw_events, cpu), cpu);
+	if (ret)
+		return ret;
+
+	return alloc_arch_pebs_buf_on_cpu(cpu);
 }
 
 static void flip_smm_bit(void *data)
@@ -5460,6 +5466,7 @@ static void intel_pmu_cpu_starting(int cpu)
 		return;
 
 	init_debug_store_on_cpu(cpu);
+	init_arch_pebs_on_cpu(cpu);
 	/*
 	 * Deal with CPUs that don't clear their LBRs on power-up, and that may
 	 * even boot with LBRs enabled.
@@ -5557,6 +5564,7 @@ static void free_excl_cntrs(struct cpu_hw_events *cpuc)
 static void intel_pmu_cpu_dying(int cpu)
 {
 	fini_debug_store_on_cpu(cpu);
+	fini_arch_pebs_on_cpu(cpu);
 }
 
 void intel_cpuc_finish(struct cpu_hw_events *cpuc)
@@ -5577,6 +5585,7 @@ static void intel_pmu_cpu_dead(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 
+	release_arch_pebs_buf_on_cpu(cpu);
 	intel_cpuc_finish(cpuc);
 
 	if (is_hybrid() && cpuc->pmu)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 5c123787f636..5ec42025d272 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -625,13 +625,18 @@ static int alloc_pebs_buffer(int cpu)
 	int max, node = cpu_to_node(cpu);
 	void *buffer, *insn_buff, *cea;
 
-	if (!x86_pmu.ds_pebs)
+	if (!intel_pmu_has_pebs())
 		return 0;
 
 	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
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
@@ -644,7 +649,7 @@ static int alloc_pebs_buffer(int cpu)
 		}
 		per_cpu(insn_buffer, cpu) = insn_buff;
 	}
-	hwev->ds_pebs_vaddr = buffer;
+	hwev->pebs_vaddr = buffer;
 	/* Update the cpu entry area mapping */
 	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
 	ds->pebs_buffer_base = (unsigned long) cea;
@@ -660,17 +665,20 @@ static void release_pebs_buffer(int cpu)
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
@@ -823,6 +831,56 @@ void reserve_ds_buffers(void)
 	}
 }
 
+inline int alloc_arch_pebs_buf_on_cpu(int cpu)
+{
+	if (!x86_pmu.arch_pebs)
+		return 0;
+
+	return alloc_pebs_buffer(cpu);
+}
+
+inline void release_arch_pebs_buf_on_cpu(int cpu)
+{
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	release_pebs_buffer(cpu);
+}
+
+void init_arch_pebs_on_cpu(int cpu)
+{
+	struct cpu_hw_events *cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+	u64 arch_pebs_base;
+
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	if (!cpuc->pebs_vaddr) {
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
+inline void fini_arch_pebs_on_cpu(int cpu)
+{
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0, 0);
+}
+
 /*
  * BTS
  */
@@ -2877,8 +2935,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 		return;
 	}
 
-	base = cpuc->ds_pebs_vaddr;
-	top = (void *)((u64)cpuc->ds_pebs_vaddr +
+	base = cpuc->pebs_vaddr;
+	top = (void *)((u64)cpuc->pebs_vaddr +
 		       (index.wr << ARCH_PEBS_INDEX_WR_SHIFT));
 
 	mask = hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_enabled;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a5145e8f1ddb..0153d9a89e1a 100644
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
@@ -1618,6 +1619,14 @@ extern void intel_cpuc_finish(struct cpu_hw_events *cpuc);
 
 int intel_pmu_init(void);
 
+int alloc_arch_pebs_buf_on_cpu(int cpu);
+
+void release_arch_pebs_buf_on_cpu(int cpu);
+
+void init_arch_pebs_on_cpu(int cpu);
+
+void fini_arch_pebs_on_cpu(int cpu);
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


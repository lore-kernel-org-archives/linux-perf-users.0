Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940087;
	b=ENkanKtat3Pll7/F9GDNYwA2RZigBW2/1k53FMU1C26yJW/8S+oRHE0zvqiAho0lhfam
	 gWn/4Q7gDy56WSAu0cIqyL/Vu87W5HwXWXiEzSNvVfxxfdhgkaaeorOa3WFG5pnkXgt8H
	 o9uaEvVoAw6fVeb+PIwvFvAtBdFWwE0MObF+Gz3PybDYCnt3dD4cr/ovIQz0GMSFR+bt0
	 i9g11sG2/wVvq/NBADDjrJJrk6Ci9yYnTAe4z7rJ4NI8AAK4NUQL2Pe89i06bieHNZvd3
	 u+fIJGmvkimH0uVCui+NB44xQv3ckqof7XiK9fgcT2QaVFaAGnzIrJGqRxbw4awG9Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940087;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qmcuRBLiAyNgSVLtIYw1GgJ3cjV3fwZQqxLTNTIh8Kc=;
	b=GL3h4zsfdvVQHnp7Jdf3neKTfiQzhig3WNzUU6EwBl6huTVfLh/QrVl/h1hzMtXrmaFx
	 mjCoZzHrmqe4ICCaeX740q6O/SsHjgBgxUantvZjelQX2VuptCplqTZ+PsdGjTjTlgUZq
	 MzbhancQPcf33Q3QG0BgtEieG49LdWtXX81l4AVJUFI3Kq9dVUZii6KvPbpDDAS/u8uwz
	 NPUSkPArB+AExPyI/SnZbG3zryirA2KBwdkJFjppHUquF8mMbWOWKdtkpBiEDD9iZuFrb
	 uQARrbebjf94QFaZIOwt0M+zMNBebJI16+/Bc/0swhdbFZv2fxw6iUj1pozb9N81DJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fi23+okB;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98432606A328;
	Fri,  6 Nov 2026 04:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98432606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fi23+okB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940087; x=1825476087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aADptgFLBWroTjldMhD+ilqQMCAFWkd4FpKQgXTALW4=;
  b=Fi23+okB+igYKQRQtmoMbmqK6qCWuZUaLHIS78mpcDU2sInsHsxWBCjp
   UaPuPYSUSwsZVFJ2xbAKvXN2eWunwS+YqaNsUBWvzgT8dmgXyhF9wtHkd
   THJQRCTwMlwbxLPD9KEoPmgC8StmJO/gq+DDAGG8hVioD7ZZjWuvbR7Qe
   4aZxXthYp5UXYOZRUteeO8vEgFCmBzmJ0vpRfJeeLRbkG4UGrnp9go7Ag
   Uo1QvofF76H/pmlIvWoOvQfL7JV7izDC0zlg4Lopc1OsNmYXrQ3jDOAb6
   KqEMsrDqpQvS6qPboSVwGQ/QNRMV9fYdCQa+dMu2Srv3KyCceYtJQyq+V
   w==;
X-CSE-ConnectionGUID: Hu0o8Sk4TDCurMUkjCR8AA==
X-CSE-MsgGUID: nR6QeiVtR02N9FurcBp9sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780834"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:27 -0800
X-CSE-ConnectionGUID: j2n/NbwpTkmJoKr7k1/+Sw==
X-CSE-MsgGUID: 6fzgl00VSm+7qJq/s4gU8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222956"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:20 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [Patch v6 10/20] perf: Add counted-bounds tracking for perf_branch_stack
Date: Fri,  6 Nov 2026 12:32:47 +0800
Message-Id: <20261106043257.842864-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct perf_branch_stack uses a trailing flexible array member,
entries[], whose valid length is tracked by nr. When this structure
is embedded as a value member in cpu_hw_events, the compiler can treat
the trailing flexible array as having a fixed zero-length layout under
-fstrict-flex-arrays=3 and UBSan, which can lead to strict array-bounds
diagnostics when entries[] is indexed.

Annotate entries[] with __counted_by(nr) so the compiler and sanitizer
track the array length from the nr field. Because a structure containing
a counted flexible array cannot be embedded as a value member, switch
the per-CPU LBR stack backing storage to a complete __lbr_stack[] array
and add a helper cpu_lbr_stack() to recover the struct perf_branch_stack*
view for x86 and powerpc.

Also initialize the branch-stack count before populating entries[] to
avoid false-positive bounds checks while the stack is being filled.

No functional change intended.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/powerpc/perf/core-book3s.c | 43 +++++++++++-----
 arch/x86/events/amd/brs.c       |  7 +--
 arch/x86/events/amd/core.c      |  6 +--
 arch/x86/events/amd/lbr.c       | 44 +++++++++-------
 arch/x86/events/core.c          |  2 +-
 arch/x86/events/intel/core.c    |  5 +-
 arch/x86/events/intel/ds.c      | 12 +++--
 arch/x86/events/intel/lbr.c     | 89 +++++++++++++++++----------------
 arch/x86/events/perf_event.h    | 19 ++++++-
 drivers/perf/arm_brbe.c         |  5 ++
 include/linux/perf_event.h      |  2 +-
 11 files changed, 144 insertions(+), 90 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 10ded865583c..978fd39b586b 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -30,6 +30,8 @@
 #define BHRB_PREDICTION		0x0000000000000001
 #define BHRB_EA			0xFFFFFFFFFFFFFFFCUL
 
+#define LBR_STACK_SIZE		struct_size_t(struct perf_branch_stack, entries, BHRB_MAX_ENTRIES)
+
 struct cpu_hw_events {
 	int n_events;
 	int n_percpu;
@@ -54,8 +56,7 @@ struct cpu_hw_events {
 	u64				bhrb_filter;	/* BHRB HW branch filter */
 	unsigned int			bhrb_users;
 	void				*bhrb_context;
-	struct	perf_branch_stack	bhrb_stack;
-	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];
+	u64				__lbr_stack[LBR_STACK_SIZE / sizeof(u64)];
 	u64				ic_init;
 
 	/* Store the PMC values */
@@ -177,6 +178,20 @@ static bool regs_use_siar(struct pt_regs *regs)
 	return ((TRAP(regs) == INTERRUPT_PERFMON) && regs->result);
 }
 
+static __always_inline struct perf_branch_stack *cpu_lbr_stack(struct cpu_hw_events *cpuc)
+{
+	return (struct perf_branch_stack *)cpuc->__lbr_stack;
+}
+
+static __always_inline void cpu_init_lbr_stack(struct cpu_hw_events *cpuc, int nr)
+{
+	/*
+	 * Initialize the branch-stack count before populating entries[]
+	 * to avoid UBSAN complaints from the __counted_by(nr) flexible array.
+	 */
+	cpu_lbr_stack(cpuc)->nr = nr;
+}
+
 /*
  * Things that are specific to 64-bit implementations.
  */
@@ -493,6 +508,8 @@ static void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *
 
 	r_index = 0;
 	u_index = 0;
+
+	cpu_init_lbr_stack(cpuhw, ppmu->bhrb_nr);
 	while (r_index < ppmu->bhrb_nr) {
 		/* Assembly read function */
 		val = read_bhrb(r_index++);
@@ -541,9 +558,9 @@ static void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *
 				/* Target branches use two entries
 				 * (ie. computed gotos/XL form)
 				 */
-				cpuhw->bhrb_entries[u_index].to = addr;
-				cpuhw->bhrb_entries[u_index].mispred = pred;
-				cpuhw->bhrb_entries[u_index].predicted = ~pred;
+				cpu_lbr_stack(cpuhw)->entries[u_index].to = addr;
+				cpu_lbr_stack(cpuhw)->entries[u_index].mispred = pred;
+				cpu_lbr_stack(cpuhw)->entries[u_index].predicted = ~pred;
 
 				/* Get from address in next entry */
 				val = read_bhrb(r_index++);
@@ -554,22 +571,22 @@ static void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *
 					r_index--;
 					addr = 0;
 				}
-				cpuhw->bhrb_entries[u_index].from = addr;
+				cpu_lbr_stack(cpuhw)->entries[u_index].from = addr;
 			} else {
 				/* Branches to immediate field 
 				   (ie I or B form) */
-				cpuhw->bhrb_entries[u_index].from = addr;
-				cpuhw->bhrb_entries[u_index].to =
+				cpu_lbr_stack(cpuhw)->entries[u_index].from = addr;
+				cpu_lbr_stack(cpuhw)->entries[u_index].to =
 					power_pmu_bhrb_to(addr);
-				cpuhw->bhrb_entries[u_index].mispred = pred;
-				cpuhw->bhrb_entries[u_index].predicted = ~pred;
+				cpu_lbr_stack(cpuhw)->entries[u_index].mispred = pred;
+				cpu_lbr_stack(cpuhw)->entries[u_index].predicted = ~pred;
 			}
 			u_index++;
 
 		}
 	}
-	cpuhw->bhrb_stack.nr = u_index;
-	cpuhw->bhrb_stack.hw_idx = -1ULL;
+	cpu_lbr_stack(cpuhw)->nr = u_index;
+	cpu_lbr_stack(cpuhw)->hw_idx = -1ULL;
 	return;
 }
 
@@ -2332,7 +2349,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			struct cpu_hw_events *cpuhw;
 			cpuhw = this_cpu_ptr(&cpu_hw_events);
 			power_pmu_bhrb_read(event, cpuhw);
-			perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack, NULL);
+			perf_sample_save_brstack(&data, event, cpu_lbr_stack(cpuhw), NULL);
 		}
 
 		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 54b13faba116..1906d1257646 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -282,7 +282,6 @@ void amd_brs_drain(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *event = cpuc->events[0];
-	struct perf_branch_entry *br = cpuc->lbr_entries;
 	union amd_debug_extn_cfg cfg;
 	u32 i, nr = 0, num, tos, start;
 	u32 shift = 64 - boot_cpu_data.x86_virt_bits;
@@ -317,6 +316,8 @@ void amd_brs_drain(void)
 
 	num = tos - start + 1;
 
+	cpu_init_lbr_stack(cpuc, num);
+
 	/*
 	 * BRS is only one pass (saturation) from MSROFF to depth-1
 	 * MSROFF wraps to zero when buffer is full
@@ -343,7 +344,7 @@ void amd_brs_drain(void)
 		if (!amd_brs_match_plm(event, from, to))
 			continue;
 
-		br[nr] = (struct perf_branch_entry){
+		cpu_lbr_stack(cpuc)->entries[nr] = (struct perf_branch_entry){
 			.from	= from,
 			.to	= to,
 		};
@@ -351,7 +352,7 @@ void amd_brs_drain(void)
 	}
 empty:
 	/* Record number of sampled branches */
-	cpuc->lbr_stack.nr = nr;
+	cpu_lbr_stack(cpuc)->nr = nr;
 }
 
 /*
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 851d8a938f52..160102a46b18 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -947,8 +947,8 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 	__amd_pmu_lbr_disable();
 
 	amd_pmu_lbr_read();
-	cnt = min(cnt, cpuc->lbr_stack.nr);
-	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
+	cnt = min(cnt, cpu_lbr_stack(cpuc)->nr);
+	memcpy(entries, cpu_lbr_stack(cpuc)->entries, sizeof(struct perf_branch_entry) * cnt);
 
 	if (lbr_enabled)
 		amd_pmu_lbr_enable_all();
@@ -1020,7 +1020,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, cpu_lbr_stack(cpuc), NULL);
 
 		perf_event_overflow(event, &data, regs);
 	}
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 400c94ecded0..3e4e5e984649 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -104,15 +104,18 @@ static void amd_pmu_lbr_filter(void)
 	bool compress = false;
 	bool fused_only = false;
 	u64 from, to;
+	int lbr_nr;
 
 	/* If sampling all branches, there is nothing to filter */
 	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
 	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		fused_only = true;
 
-	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
-		from = cpuc->lbr_entries[i].from;
-		to = cpuc->lbr_entries[i].to;
+	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
+		struct perf_branch_entry *be = &cpu_lbr_stack(cpuc)->entries[i];
+
+		from = be->from;
+		to = be->to;
 		type = branch_type_fused(from, to, 0, &offset);
 
 		/*
@@ -121,37 +124,41 @@ static void amd_pmu_lbr_filter(void)
 		 * actual branch
 		 */
 		if (offset) {
-			cpuc->lbr_entries[i].from += offset;
+			be->from += offset;
 			if (fused_only)
 				continue;
 		}
 
 		/* If type does not correspond, then discard */
 		if (type == X86_BR_NONE || (br_sel & type) != type ||
-		    (!(br_sel & X86_BR_KERNEL) && kernel_ip(cpuc->lbr_entries[i].from))) {
-			cpuc->lbr_entries[i].from = 0;	/* mark invalid */
+		    (!(br_sel & X86_BR_KERNEL) && kernel_ip(be->from))) {
+			be->from = 0;	/* mark invalid */
 			compress = true;
 		}
 
 		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
-			cpuc->lbr_entries[i].type = common_branch_type(type);
+			be->type = common_branch_type(type);
 	}
 
 	if (!compress)
 		return;
 
 	/* Remove all invalid entries */
-	for (i = 0; i < cpuc->lbr_stack.nr; ) {
-		if (!cpuc->lbr_entries[i].from) {
+	lbr_nr = cpu_lbr_stack(cpuc)->nr;
+	for (i = 0; i < lbr_nr; ) {
+		if (!cpu_lbr_stack(cpuc)->entries[i].from) {
 			j = i;
-			while (++j < cpuc->lbr_stack.nr)
-				cpuc->lbr_entries[j - 1] = cpuc->lbr_entries[j];
-			cpuc->lbr_stack.nr--;
-			if (!cpuc->lbr_entries[i].from)
+			while (++j < lbr_nr) {
+				cpu_lbr_stack(cpuc)->entries[j - 1] =
+					cpu_lbr_stack(cpuc)->entries[j];
+			}
+			lbr_nr--;
+			if (!cpu_lbr_stack(cpuc)->entries[i].from)
 				continue;
 		}
 		i++;
 	}
+	cpu_lbr_stack(cpuc)->nr = lbr_nr;
 }
 
 static const int lbr_spec_map[PERF_BR_SPEC_MAX] = {
@@ -164,15 +171,16 @@ static const int lbr_spec_map[PERF_BR_SPEC_MAX] = {
 void amd_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct perf_branch_entry *br = cpuc->lbr_entries;
 	struct branch_entry entry;
 	int out = 0, idx, i;
 
 	if (!cpuc->lbr_users) {
-		cpuc->lbr_stack.nr = 0;
+		cpu_lbr_stack(cpuc)->nr = 0;
 		return;
 	}
 
+	cpu_init_lbr_stack(cpuc, x86_pmu.lbr_nr);
+
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		entry.from.full	= amd_pmu_lbr_get_from(i);
 		entry.to.full	= amd_pmu_lbr_get_to(i);
@@ -204,7 +212,7 @@ void amd_pmu_lbr_read(void)
 		 */
 		idx = (entry.to.split.valid << 1) | entry.to.split.spec;
 
-		br[out] = (struct perf_branch_entry){
+		cpu_lbr_stack(cpuc)->entries[out] = (struct perf_branch_entry){
 			.from		= sign_ext_branch_ip(entry.from.split.ip),
 			.to		= sign_ext_branch_ip(entry.to.split.ip),
 			.mispred	= entry.from.split.mispredict,
@@ -214,13 +222,13 @@ void amd_pmu_lbr_read(void)
 		out++;
 	}
 
-	cpuc->lbr_stack.nr = out;
+	cpu_lbr_stack(cpuc)->nr = out;
 
 	/*
 	 * Internal register renaming always ensures that LBR From[0] and
 	 * LBR To[0] always represent the TOS
 	 */
-	cpuc->lbr_stack.hw_idx = 0;
+	cpu_lbr_stack(cpuc)->hw_idx = 0;
 
 	/* Perform further software filtering */
 	amd_pmu_lbr_filter();
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 82d9b0e5ad1c..a7bdc6f370ec 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2197,7 +2197,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, cpu_lbr_stack(cpuc), NULL);
 
 		perf_event_overflow(event, &data, regs);
 	}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ab6261ab54b6..42d4d525a729 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2827,9 +2827,10 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	intel_pmu_lbr_read();
-	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
+	cnt = min_t(unsigned int, cnt, cpu_lbr_stack(cpuc)->nr);
 
-	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
+	memcpy(entries, cpu_lbr_stack(cpuc)->entries,
+	       sizeof(struct perf_branch_entry) * cnt);
 
 	/*
 	 * Do not blindly call intel_pmu_enable_all() to re-enable LBR.
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8444670cee4a..332754e1da4f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2010,8 +2010,7 @@ void intel_pmu_pebs_disable_all(void)
 static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	unsigned long from = cpuc->lbr_entries[0].from;
-	unsigned long old_to, to = cpuc->lbr_entries[0].to;
+	unsigned long from, old_to, to;
 	unsigned long ip = regs->ip;
 	int is_64bit = 0;
 	void *kaddr;
@@ -2026,7 +2025,12 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 	/*
 	 * No LBR entry, no basic block, no rewinding
 	 */
-	if (!cpuc->lbr_stack.nr || !from || !to)
+	if (!cpu_lbr_stack(cpuc)->nr)
+		return 0;
+
+	from = cpu_lbr_stack(cpuc)->entries[0].from;
+	to = cpu_lbr_stack(cpuc)->entries[0].to;
+	if (!from || !to)
 		return 0;
 
 	/*
@@ -2318,7 +2322,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	if (x86_pmu.intel_cap.pebs_format >= 3)
 		setup_pebs_time(event, data, pebs->tsc);
 
-	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+	perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index ee724b28d90c..62f2f4b9cfde 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -195,7 +195,7 @@ void intel_pmu_lbr_reset(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	cpuc->lbr_stack.nr = 0;
+	cpu_lbr_stack(cpuc)->nr = 0;
 
 	if (!x86_pmu.lbr_nr)
 		return;
@@ -744,10 +744,10 @@ void intel_pmu_lbr_disable_all(void)
 void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 {
 	unsigned long mask = x86_pmu.lbr_nr - 1;
-	struct perf_branch_entry *br = cpuc->lbr_entries;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 
+	cpu_init_lbr_stack(cpuc, x86_pmu.lbr_nr);
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		unsigned long lbr_idx = (tos - i) & mask;
 		union {
@@ -760,14 +760,13 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
 		rdmsrq(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
-		*br = (struct perf_branch_entry){
+		cpu_lbr_stack(cpuc)->entries[i] = (struct perf_branch_entry){
 			.from	= msr_lastbranch.from,
 			.to	= msr_lastbranch.to,
 		};
-		br++;
 	}
-	cpuc->lbr_stack.nr = i;
-	cpuc->lbr_stack.hw_idx = tos;
+	cpu_lbr_stack(cpuc)->nr = i;
+	cpu_lbr_stack(cpuc)->hw_idx = tos;
 }
 
 /*
@@ -779,7 +778,6 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
-	struct perf_branch_entry *br = cpuc->lbr_entries;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 	int out = 0;
@@ -791,6 +789,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 			call_stack = true;
 	}
 
+	cpu_init_lbr_stack(cpuc, num);
 	for (i = 0; i < num; i++) {
 		unsigned long lbr_idx = (tos - i) & mask;
 		u64 from, to, mis = 0, pred = 0, in_tx = 0, abort = 0;
@@ -851,7 +850,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
-		br[out] = (struct perf_branch_entry){
+		cpu_lbr_stack(cpuc)->entries[out] = (struct perf_branch_entry){
 			.from		= from,
 			.to		= to,
 			.mispred	= mis,
@@ -862,8 +861,8 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		};
 		out++;
 	}
-	cpuc->lbr_stack.nr = out;
-	cpuc->lbr_stack.hw_idx = tos;
+	cpu_lbr_stack(cpuc)->nr = out;
+	cpu_lbr_stack(cpuc)->hw_idx = tos;
 }
 
 static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
@@ -907,15 +906,14 @@ static_assert((64 - PERF_BRANCH_ENTRY_INFO_BITS_MAX) > LBR_INFO_BR_CNTR_NUM * LB
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 				struct lbr_entry *entries)
 {
-	struct perf_branch_entry *e;
 	struct lbr_entry *lbr;
 	u64 from, to, info;
 	bool mispred;
 	int i;
 
+	cpu_init_lbr_stack(cpuc, x86_pmu.lbr_nr);
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		lbr = entries ? &entries[i] : NULL;
-		e = &cpuc->lbr_entries[i];
 
 		from = rdlbr_from(i, lbr);
 		/*
@@ -929,7 +927,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 
 		mispred = get_lbr_mispred(info);
 
-		*e = (struct perf_branch_entry){
+		cpu_lbr_stack(cpuc)->entries[i] = (struct perf_branch_entry){
 			.from		= from,
 			.to		= to,
 			.mispred	= mispred,
@@ -939,18 +937,18 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 			.cycles		= get_lbr_cycles(info),
 			.type		= get_lbr_br_type(info),
 			/*
-			 * Leverage the reserved field of
-			 * cpuc->lbr_entries[i] to temporarily store the
-			 * branch counters information. The later code will
-			 * decide what content can be disclosed to the perf
-			 * tool. Pleae see intel_pmu_lbr_counters_reorder().
+			 * Leverage the reserved field of LBR entries to
+			 * temporarily store the branch counters information.
+			 * The later code will decide what content can be
+			 * disclosed to the perf tool.
+			 * Pleae see intel_pmu_lbr_counters_reorder().
 			 */
 			.reserved	= (info >> LBR_INFO_BR_CNTR_OFFSET) &
 					  LBR_INFO_BR_CNTR_FULL_MASK,
 		};
 	}
 
-	cpuc->lbr_stack.nr = i;
+	cpu_lbr_stack(cpuc)->nr = i;
 }
 
 /*
@@ -976,15 +974,15 @@ static void intel_pmu_lbr_counters_reorder(struct cpu_hw_events *cpuc,
 
 	WARN_ON_ONCE(!pos);
 
-	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
-		src = cpuc->lbr_entries[i].reserved;
+	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
+		src = cpu_lbr_stack(cpuc)->entries[i].reserved;
 		dst = 0;
 		for (j = 0; j < pos; j++) {
 			cnt = (src >> (order[j] * LBR_INFO_BR_CNTR_BITS)) & LBR_INFO_BR_CNTR_MASK;
 			dst |= cnt << j * LBR_INFO_BR_CNTR_BITS;
 		}
 		cpuc->lbr_counters[i] = dst;
-		cpuc->lbr_entries[i].reserved = 0;
+		cpu_lbr_stack(cpuc)->entries[i].reserved = 0;
 	}
 }
 
@@ -994,11 +992,11 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 {
 	if (is_branch_counters_group(event)) {
 		intel_pmu_lbr_counters_reorder(cpuc, event);
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, cpuc->lbr_counters);
+		perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), cpuc->lbr_counters);
 		return;
 	}
 
-	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+	perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
 }
 
 static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
@@ -1021,7 +1019,7 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
 		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
 	} else {
 		/* Clear the LBR stack to avoid leaking stale entries. */
-		cpuc->lbr_stack.nr = 0;
+		cpu_lbr_stack(cpuc)->nr = 0;
 	}
 }
 
@@ -1031,7 +1029,7 @@ void intel_pmu_lbr_read(void)
 
 	if (!cpuc->lbr_users || vlbr_exclude_host()) {
 		/* Reset lbr_stack.nr to prevent stale data leakage. */
-		cpuc->lbr_stack.nr = 0;
+		cpu_lbr_stack(cpuc)->nr = 0;
 		return;
 	}
 
@@ -1231,21 +1229,23 @@ static const int arch_lbr_br_type_map[ARCH_LBR_BR_TYPE_MAP_MAX] = {
 static void
 intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 {
-	u64 from, to;
 	int br_sel = cpuc->br_sel;
 	int i, j, type, from_plm, to_plm;
 	bool compress = false;
+	u64 from, to;
+	int lbr_nr;
 
 	/* if sampling all branches, then nothing to filter */
 	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
 	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		return;
 
-	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
+	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
+		struct perf_branch_entry *be = &cpu_lbr_stack(cpuc)->entries[i];
 
-		from = cpuc->lbr_entries[i].from;
-		to = cpuc->lbr_entries[i].to;
-		type = cpuc->lbr_entries[i].type;
+		from = be->from;
+		to = be->to;
+		type = be->type;
 
 		/*
 		 * Parse the branch type recorded in LBR_x_INFO MSR.
@@ -1257,9 +1257,9 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
 			type = arch_lbr_br_type_map[type] | to_plm;
 		} else
-			type = branch_type(from, to, cpuc->lbr_entries[i].abort);
+			type = branch_type(from, to, be->abort);
 		if (type != X86_BR_NONE && (br_sel & X86_BR_ANYTX)) {
-			if (cpuc->lbr_entries[i].in_tx)
+			if (be->in_tx)
 				type |= X86_BR_IN_TX;
 			else
 				type |= X86_BR_NO_TX;
@@ -1273,31 +1273,34 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 		 */
 		if (type == X86_BR_NONE || (br_sel & type) != type ||
 		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {
-			cpuc->lbr_entries[i].from = 0;
+			be->from = 0;
 			compress = true;
 		}
 
 		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
-			cpuc->lbr_entries[i].type = common_branch_type(type);
+			be->type = common_branch_type(type);
 	}
 
 	if (!compress)
 		return;
 
 	/* remove all entries with from=0 */
-	for (i = 0; i < cpuc->lbr_stack.nr; ) {
-		if (!cpuc->lbr_entries[i].from) {
+	lbr_nr = cpu_lbr_stack(cpuc)->nr;
+	for (i = 0; i < lbr_nr; ) {
+		if (!cpu_lbr_stack(cpuc)->entries[i].from) {
 			j = i;
-			while (++j < cpuc->lbr_stack.nr) {
-				cpuc->lbr_entries[j-1] = cpuc->lbr_entries[j];
+			while (++j < lbr_nr) {
+				cpu_lbr_stack(cpuc)->entries[j-1] =
+					cpu_lbr_stack(cpuc)->entries[j];
 				cpuc->lbr_counters[j-1] = cpuc->lbr_counters[j];
 			}
-			cpuc->lbr_stack.nr--;
-			if (!cpuc->lbr_entries[i].from)
+			lbr_nr--;
+			if (!cpu_lbr_stack(cpuc)->entries[i].from)
 				continue;
 		}
 		i++;
 	}
+	cpu_lbr_stack(cpuc)->nr = lbr_nr;
 }
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
@@ -1307,9 +1310,9 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	/* Cannot get TOS for large PEBS and Arch LBR */
 	if (cpu_feature_enabled(X86_FEATURE_ARCH_LBR) ||
 	    (cpuc->n_pebs == cpuc->n_large_pebs))
-		cpuc->lbr_stack.hw_idx = -1ULL;
+		cpu_lbr_stack(cpuc)->hw_idx = -1ULL;
 	else
-		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
+		cpu_lbr_stack(cpuc)->hw_idx = intel_pmu_lbr_tos();
 
 	intel_pmu_store_lbr(cpuc, lbr);
 	intel_pmu_lbr_filter(cpuc);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a4aab8130e92..e3d625a6d7eb 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -447,6 +447,8 @@ struct intel_excl_cntrs {
 struct x86_perf_task_context;
 #define MAX_LBR_ENTRIES		32
 
+#define LBR_STACK_SIZE		struct_size_t(struct perf_branch_stack, entries, MAX_LBR_ENTRIES)
+
 enum {
 	LBR_FORMAT_32		= 0x00,
 	LBR_FORMAT_LIP		= 0x01,
@@ -525,8 +527,7 @@ struct cpu_hw_events {
 	 */
 	int				lbr_users;
 	int				lbr_pebs_users;
-	struct perf_branch_stack	lbr_stack;
-	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
+	u64				__lbr_stack[LBR_STACK_SIZE / sizeof(u64)];
 	u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
 	union {
 		struct er_account		*lbr_sel;
@@ -588,6 +589,20 @@ struct cpu_hw_events {
 	struct pmu			*pmu;
 };
 
+static __always_inline struct perf_branch_stack *cpu_lbr_stack(struct cpu_hw_events *cpuc)
+{
+	return (struct perf_branch_stack *)cpuc->__lbr_stack;
+}
+
+static __always_inline void cpu_init_lbr_stack(struct cpu_hw_events *cpuc, int nr)
+{
+	/*
+	 * Initialize the branch-stack count before populating entries[]
+	 * to avoid UBSAN complaints from the __counted_by(nr) flexible array.
+	 */
+	cpu_lbr_stack(cpuc)->nr = nr;
+}
+
 #define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
 	{ .idxmsk64 = (n) },		\
 	.code = (c),			\
diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index 073d14584741..e2b32b239de1 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -763,6 +763,11 @@ void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
 
 	prepare_event_branch_type_mask(branch_sample_type, event_type_mask);
 
+	/*
+	 * Initialize the branch_stack->nr before populating entries[]
+	 * to avoid UBSAN complaints from the __counted_by(nr) flexible array.
+	 */
+	branch_stack->nr = nr_hw;
 	for (int bank = 0; bank < nr_banks; bank++) {
 		int nr_remaining = nr_hw - (bank * BRBE_BANK_MAX_ENTRIES);
 		int nr_this_bank = min(nr_remaining, BRBE_BANK_MAX_ENTRIES);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index eb3f7bab498c..19de3f1cbd6e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -115,7 +115,7 @@ static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
 struct perf_branch_stack {
 	u64				nr;
 	u64				hw_idx;
-	struct perf_branch_entry	entries[];
+	struct perf_branch_entry	entries[] __counted_by(nr);
 };
 
 struct task_struct;
-- 
2.34.1


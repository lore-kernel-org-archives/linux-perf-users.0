Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972225;
	b=4HHUa2X42xyNB+ZMiJSRKMWcBSScGo/ZeJHn2WbcLh6kW9m0nCW8fSOa8XbD2Rp3jKZo
	 A3a3ESEq/MQz+JdAmAJhiNpvuT7Cy3G1pncbTGMpUPhmS8SeBjCSLRyGuvbmdCKzJXYgw
	 5hQyIOU0bqBjm2fhaOsHRASM3SxE9H0rpD3xGkUu8v/qCpHK6cFRQjyi5st1k3SzIUFZi
	 FYF7UYyJJMWGeqVD8ByIL2py5ukddN9DwYqol9ZdFzI6NaxrZYm8up4WyxfX3vEEgolfr
	 BaaH9uJCgWyNSqdAzO0LSCJ9OfPFpLpcPdoSb62d780LcjsTuOyX0t6XOzqJ78USNtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972225;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Sqmggw9IODcRkclZKFcM3M9UNmQE6ksFcmD8WaCzPQ4=;
	b=Gsqn/QtnKR6vOuV9HZIq0K8sJQHTPEMlzjiUB1tD2yl+IP2zxFAN2SYvmXGb54a5FUTW
	 NjvtjSkECYqxl9rezQoUc99NttPflrjuXfNH2vgP4QWTobZlUZGTESu73FlAO2uMceSTm
	 +z30jnHb+jth7eLQXZ3vGdmU2qnRiMASlO5wV3ZfSr0EDcbT/Z9NGSzlrxqJFENYRdpJl
	 vIYbB73zKwkeEOUv14pNfbfrZXEWBibKRuvV5ya6PMLQ80JPkXAhe+mWvSFnVpfCCmiC3
	 esw5DV7huONY+FXTka4dNF+sh8dOlQvk+7ccmk2b2ujzaMMUoGWoeOXltf0lH+TcrbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="P/TMX2Ft";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683760A2637;
	Wed, 18 Nov 2026 03:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C683760A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P/TMX2Ft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972225; x=1826508225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yog3HB56pQrugkBwFFxdoTza93+nYLVt5tNNxl0cqfE=;
  b=P/TMX2FttXFIeNJA7/bDSBBbsHOceAIrF8lv/DSez37eGXa0PnuBQwpt
   lrhty90zG3YizBJxL6oGU64xwVYOz/vx3iMybDLOjV8SHjZCfF4A3Y5Mp
   1oml5slQf3/E+/j5rowFDVSgMkreaRHM2sb/OT3Ef2Ey5trCcY4Z58O3t
   /5+Z25z1igR87+5B0VlC0rqGcB4TGbYaS0z+3vRjWlc0EWGRy1YHW/x0M
   LAEgBfgvIt/U/rAmdXym7flFdoI+/lfWvEEDr2PlxapMWCHySnBNPAHZP
   Byn3wlDPbO6cM4jFu0J1K/DQQwxPql35P5l2hbOx7ZMXQKfnk2RXGmo01
   Q==;
X-CSE-ConnectionGUID: h094zrWQTWC+ytfWTal2LQ==
X-CSE-MsgGUID: RbdCv3FRQBm9z+GNptGllw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629911"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629911"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:38 -0800
X-CSE-ConnectionGUID: nQulPRhZTlChN5/lKEjREA==
X-CSE-MsgGUID: kTKBBCKzRPO52GpYlo8UuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894233"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:32 -0800
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
Subject: [Patch v7 10/24] perf: Add counted-bounds tracking for perf_branch_stack
Date: Wed, 18 Nov 2026 11:14:39 +0800
Message-Id: <20261118031453.1353625-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
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
the per-CPU LBR/BHRB stacks to raw backing arrays and add accessors that
return the struct perf_branch_stack view.

Also initialize the branch-stack count before populating entries[] to
avoid false-positive bounds checks while the stack is being filled.

No functional change intended.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/powerpc/perf/core-book3s.c | 47 +++++++++++------
 arch/x86/events/amd/brs.c       |  7 +--
 arch/x86/events/amd/core.c      | 10 ++--
 arch/x86/events/amd/lbr.c       | 44 +++++++++-------
 arch/x86/events/core.c          |  2 +-
 arch/x86/events/intel/core.c    |  5 +-
 arch/x86/events/intel/ds.c      | 12 +++--
 arch/x86/events/intel/lbr.c     | 89 +++++++++++++++++----------------
 arch/x86/events/perf_event.h    | 19 ++++++-
 drivers/perf/arm_brbe.c         |  5 ++
 include/linux/perf_event.h      |  2 +-
 11 files changed, 149 insertions(+), 93 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 10ded865583c..07e54f634c6d 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -30,6 +30,8 @@
 #define BHRB_PREDICTION		0x0000000000000001
 #define BHRB_EA			0xFFFFFFFFFFFFFFFCUL
 
+#define BHRB_STACK_SIZE		struct_size_t(struct perf_branch_stack, entries, BHRB_MAX_ENTRIES)
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
+	u64				__bhrb_stack[BHRB_STACK_SIZE / sizeof(u64)];
 	u64				ic_init;
 
 	/* Store the PMC values */
@@ -177,6 +178,20 @@ static bool regs_use_siar(struct pt_regs *regs)
 	return ((TRAP(regs) == INTERRUPT_PERFMON) && regs->result);
 }
 
+static __always_inline struct perf_branch_stack *cpu_bhrb_stack(struct cpu_hw_events *cpuc)
+{
+	return (struct perf_branch_stack *)cpuc->__bhrb_stack;
+}
+
+static __always_inline void cpu_init_bhrb_stack(struct cpu_hw_events *cpuc, int nr)
+{
+	/*
+	 * Initialize the branch-stack count before populating entries[]
+	 * to avoid UBSAN complaints from the __counted_by(nr) flexible array.
+	 */
+	cpu_bhrb_stack(cpuc)->nr = nr;
+}
+
 /*
  * Things that are specific to 64-bit implementations.
  */
@@ -487,12 +502,15 @@ static __u64 power_pmu_bhrb_to(u64 addr)
 /* Processing BHRB entries */
 static void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *cpuhw)
 {
+	struct perf_branch_stack *bhrb = cpu_bhrb_stack(cpuhw);
+	int r_index, u_index, pred;
 	u64 val;
 	u64 addr;
-	int r_index, u_index, pred;
 
 	r_index = 0;
 	u_index = 0;
+
+	cpu_init_bhrb_stack(cpuhw, ppmu->bhrb_nr);
 	while (r_index < ppmu->bhrb_nr) {
 		/* Assembly read function */
 		val = read_bhrb(r_index++);
@@ -541,9 +559,9 @@ static void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *
 				/* Target branches use two entries
 				 * (ie. computed gotos/XL form)
 				 */
-				cpuhw->bhrb_entries[u_index].to = addr;
-				cpuhw->bhrb_entries[u_index].mispred = pred;
-				cpuhw->bhrb_entries[u_index].predicted = ~pred;
+				bhrb->entries[u_index].to = addr;
+				bhrb->entries[u_index].mispred = pred;
+				bhrb->entries[u_index].predicted = ~pred;
 
 				/* Get from address in next entry */
 				val = read_bhrb(r_index++);
@@ -554,22 +572,21 @@ static void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *
 					r_index--;
 					addr = 0;
 				}
-				cpuhw->bhrb_entries[u_index].from = addr;
+				bhrb->entries[u_index].from = addr;
 			} else {
 				/* Branches to immediate field 
 				   (ie I or B form) */
-				cpuhw->bhrb_entries[u_index].from = addr;
-				cpuhw->bhrb_entries[u_index].to =
-					power_pmu_bhrb_to(addr);
-				cpuhw->bhrb_entries[u_index].mispred = pred;
-				cpuhw->bhrb_entries[u_index].predicted = ~pred;
+				bhrb->entries[u_index].from = addr;
+				bhrb->entries[u_index].to = power_pmu_bhrb_to(addr);
+				bhrb->entries[u_index].mispred = pred;
+				bhrb->entries[u_index].predicted = ~pred;
 			}
 			u_index++;
 
 		}
 	}
-	cpuhw->bhrb_stack.nr = u_index;
-	cpuhw->bhrb_stack.hw_idx = -1ULL;
+	bhrb->nr = u_index;
+	bhrb->hw_idx = -1ULL;
 	return;
 }
 
@@ -2332,7 +2349,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			struct cpu_hw_events *cpuhw;
 			cpuhw = this_cpu_ptr(&cpu_hw_events);
 			power_pmu_bhrb_read(event, cpuhw);
-			perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack, NULL);
+			perf_sample_save_brstack(&data, event, cpu_bhrb_stack(cpuhw), NULL);
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
index dd0e24f26c6b..7c6a9135eb22 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -928,7 +928,8 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
  * details. It's up to caller to provide enough space in *entries* to fit all
  * LBR records, otherwise returned result will be truncated to *cnt* entries.
  */
-static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
+static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries,
+					    unsigned int cnt)
 {
 	struct cpu_hw_events *cpuc;
 	unsigned long flags;
@@ -948,8 +949,9 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 	__amd_pmu_lbr_disable();
 
 	amd_pmu_lbr_read();
-	cnt = min(cnt, cpuc->lbr_stack.nr);
-	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
+	cnt = min(cnt, cpu_lbr_stack(cpuc)->nr);
+	memcpy(entries, cpu_lbr_stack(cpuc)->entries,
+	       sizeof(struct perf_branch_entry) * cnt);
 
 	if (pmu_enabled) {
 		cpuc->enabled = 1;
@@ -1023,7 +1025,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
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
index df3470c2f9cc..0c94b5fd8a16 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2197,7 +2197,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, cpu_lbr_stack(cpuc), NULL);
 
 		perf_event_overflow(event, &data, regs);
 	}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2e9e2127e34e..6547555192cf 100644
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
 	 * This path may be entered from the PMI handler through
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
index fe8b303839d3..15d779f92553 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -200,7 +200,7 @@ void intel_pmu_lbr_reset(void)
 
 	x86_pmu.lbr_reset();
 
-	cpuc->lbr_stack.nr = 0;
+	cpu_lbr_stack(cpuc)->nr = 0;
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) && cpuc->lbr_select)
@@ -743,10 +743,10 @@ void intel_pmu_lbr_disable_all(void)
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
@@ -759,14 +759,13 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
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
@@ -778,7 +777,6 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
-	struct perf_branch_entry *br = cpuc->lbr_entries;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 	int out = 0;
@@ -790,6 +788,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 			call_stack = true;
 	}
 
+	cpu_init_lbr_stack(cpuc, num);
 	for (i = 0; i < num; i++) {
 		unsigned long lbr_idx = (tos - i) & mask;
 		u64 from, to, mis = 0, pred = 0, in_tx = 0, abort = 0;
@@ -850,7 +849,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
-		br[out] = (struct perf_branch_entry){
+		cpu_lbr_stack(cpuc)->entries[out] = (struct perf_branch_entry){
 			.from		= from,
 			.to		= to,
 			.mispred	= mis,
@@ -861,8 +860,8 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		};
 		out++;
 	}
-	cpuc->lbr_stack.nr = out;
-	cpuc->lbr_stack.hw_idx = tos;
+	cpu_lbr_stack(cpuc)->nr = out;
+	cpu_lbr_stack(cpuc)->hw_idx = tos;
 }
 
 static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
@@ -906,15 +905,14 @@ static_assert((64 - PERF_BRANCH_ENTRY_INFO_BITS_MAX) > LBR_INFO_BR_CNTR_NUM * LB
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
@@ -928,7 +926,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 
 		mispred = get_lbr_mispred(info);
 
-		*e = (struct perf_branch_entry){
+		cpu_lbr_stack(cpuc)->entries[i] = (struct perf_branch_entry){
 			.from		= from,
 			.to		= to,
 			.mispred	= mispred,
@@ -938,18 +936,18 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
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
+			 * Please see intel_pmu_lbr_counters_reorder().
 			 */
 			.reserved	= (info >> LBR_INFO_BR_CNTR_OFFSET) &
 					  LBR_INFO_BR_CNTR_FULL_MASK,
 		};
 	}
 
-	cpuc->lbr_stack.nr = i;
+	cpu_lbr_stack(cpuc)->nr = i;
 }
 
 /*
@@ -975,15 +973,15 @@ static void intel_pmu_lbr_counters_reorder(struct cpu_hw_events *cpuc,
 
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
 
@@ -993,11 +991,11 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
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
@@ -1020,7 +1018,7 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
 		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
 	} else {
 		/* Clear the LBR stack to avoid leaking stale entries. */
-		cpuc->lbr_stack.nr = 0;
+		cpu_lbr_stack(cpuc)->nr = 0;
 	}
 }
 
@@ -1030,7 +1028,7 @@ void intel_pmu_lbr_read(void)
 
 	if (!cpuc->lbr_users || vlbr_exclude_host()) {
 		/* Reset lbr_stack.nr to prevent stale data leakage. */
-		cpuc->lbr_stack.nr = 0;
+		cpu_lbr_stack(cpuc)->nr = 0;
 		return;
 	}
 
@@ -1230,21 +1228,23 @@ static const int arch_lbr_br_type_map[ARCH_LBR_BR_TYPE_MAP_MAX] = {
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
@@ -1256,9 +1256,9 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
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
@@ -1272,31 +1272,34 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
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
@@ -1306,9 +1309,9 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
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


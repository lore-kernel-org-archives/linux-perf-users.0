Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9138C41C;
	Mon, 13 Apr 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106715; cv=none; b=iMmarsoHIvY6HqMRLZLjw+J3rMqnAEefumhF3sS8Yqq9a2/MYVCnnN04wnelfapiHUWY6QSuSfa+2HOSVz6aOZ8s5xeozQTWGfJH9xumtk+k/VLzn5EJC0kQSPje38YzeLK6MRBM/dBAstKysujJW/5ebGeIh12zQYSTFUUki30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106715; c=relaxed/simple;
	bh=Yrewm25QxKHuHPPzUpCt1jWW9y9z0Bjv30JM4nYw3i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T81iBrJ0PDAevnNwIzuiJicBb/zMV+U3svZqqyEExsEMEcf6hOuWTQJyQVSZiIaOQL2D66xkos1Y8Acp2jlD1AyIoQCo1n2AdvVQnFPtWtj4d8Dhby5N2bZAnMxUFex9p+jiO1VLceso4lD9Cl6lftcXydbWXkr5+AZI4+olj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlVLgq3j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlVLgq3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF387C2BCAF;
	Mon, 13 Apr 2026 18:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776106714;
	bh=Yrewm25QxKHuHPPzUpCt1jWW9y9z0Bjv30JM4nYw3i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TlVLgq3jkQwGeq5pwIiimn5mrTXRa1XaBnCit/Mgsml5QJRx1n9bZyYhcdsCjEPOZ
	 1ud0SXebtGO464Oi/6ATqgDgkUy0lQ4AlqyLudFQPGsXphRNWglJOIW6wQ4pcH8lgH
	 i1ayhKLXPIS4UGT2Me7I4srB4V0VrkRZtGHNbxSzqdfIa06qYfXa1V+VzffGbXQKXd
	 6ya2Ry0UDgbck7xO+Nsc6jfD0YOF5ZvnVNlTnftHdXl4lwCUdQP3IxrZlbv9i82GIW
	 UO/qwrFRG8FhPRpIlIGJ4qJ05L5DswnIOSerbrDiOnE7/6/gXlHLyNf/RBcSgqKtp3
	 PH7s4UNLsfE/A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 3/4] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
Date: Mon, 13 Apr 2026 11:57:22 -0700
Message-ID: <20260413185740.3286146-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413185740.3286146-1-puranjay@kernel.org>
References: <20260413185740.3286146-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable bpf_get_branch_snapshot() on ARM64 by implementing the
perf_snapshot_branch_stack static call for BRBE.

BRBE is paused before masking exceptions to avoid branch buffer
pollution from trace_hardirqs_off(). Exceptions are then masked with
local_daif_save() to prevent PMU overflow pseudo-NMIs from interfering.
If an overflow between pause and DAIF save re-enables BRBE, the snapshot
detects this via BRBFCR_EL1.PAUSED and bails out.

Branch records are read using perf_entry_from_brbe_regset() with a NULL
event pointer to bypass event-specific filtering. The buffer is
invalidated after reading.

Introduce a for_each_brbe_entry() iterator to deduplicate bank
iteration between brbe_read_filtered_entries() and the snapshot.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 drivers/perf/arm_brbe.c  | 107 ++++++++++++++++++++++++++++++++-------
 drivers/perf/arm_brbe.h  |   9 ++++
 drivers/perf/arm_pmuv3.c |   5 +-
 3 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index ba554e0c846c..fd62019ddc83 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/bitmap.h>
 #include <linux/perf/arm_pmu.h>
+#include <asm/daifflags.h>
 #include "arm_brbe.h"
 
 #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
@@ -271,6 +272,20 @@ static void select_brbe_bank(int bank)
 	isb();
 }
 
+static inline void __brbe_advance(int *bank, int *idx, int nr_hw)
+{
+	if (++(*idx) >= BRBE_BANK_MAX_ENTRIES &&
+	    *bank * BRBE_BANK_MAX_ENTRIES + *idx < nr_hw) {
+		*idx = 0;
+		select_brbe_bank(++(*bank));
+	}
+}
+
+#define for_each_brbe_entry(idx, nr_hw)					\
+	for (int __bank = (select_brbe_bank(0), 0), idx = 0;		\
+	     __bank * BRBE_BANK_MAX_ENTRIES + idx < (nr_hw);		\
+	     __brbe_advance(&__bank, &idx, (nr_hw)))
+
 static bool __read_brbe_regset(struct brbe_regset *entry, int idx)
 {
 	entry->brbinf = get_brbinf_reg(idx);
@@ -618,10 +633,10 @@ static bool perf_entry_from_brbe_regset(int index, struct perf_branch_entry *ent
 
 	brbe_set_perf_entry_type(entry, brbinf);
 
-	if (!branch_sample_no_cycles(event))
+	if (!event || !branch_sample_no_cycles(event))
 		entry->cycles = brbinf_get_cycles(brbinf);
 
-	if (!branch_sample_no_flags(event)) {
+	if (!event || !branch_sample_no_flags(event)) {
 		/* Mispredict info is available for source only and complete branch records. */
 		if (!brbe_record_is_target_only(brbinf)) {
 			entry->mispred = brbinf_get_mispredict(brbinf);
@@ -774,32 +789,90 @@ void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	int nr_hw = brbe_num_branch_records(cpu_pmu);
-	int nr_banks = DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
 	int nr_filtered = 0;
 	u64 branch_sample_type = event->attr.branch_sample_type;
 	DECLARE_BITMAP(event_type_mask, PERF_BR_ARM64_MAX);
 
 	prepare_event_branch_type_mask(branch_sample_type, event_type_mask);
 
-	for (int bank = 0; bank < nr_banks; bank++) {
-		int nr_remaining = nr_hw - (bank * BRBE_BANK_MAX_ENTRIES);
-		int nr_this_bank = min(nr_remaining, BRBE_BANK_MAX_ENTRIES);
+	for_each_brbe_entry(i, nr_hw) {
+		struct perf_branch_entry *pbe = &branch_stack->entries[nr_filtered];
 
-		select_brbe_bank(bank);
+		if (!perf_entry_from_brbe_regset(i, pbe, event))
+			break;
 
-		for (int i = 0; i < nr_this_bank; i++) {
-			struct perf_branch_entry *pbe = &branch_stack->entries[nr_filtered];
+		if (!filter_branch_record(pbe, branch_sample_type, event_type_mask))
+			continue;
 
-			if (!perf_entry_from_brbe_regset(i, pbe, event))
-				goto done;
+		nr_filtered++;
+	}
 
-			if (!filter_branch_record(pbe, branch_sample_type, event_type_mask))
-				continue;
+	branch_stack->nr = nr_filtered;
+}
 
-			nr_filtered++;
-		}
+/*
+ * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
+ * self-recording and return 0 if the snapshot state appears disturbed.
+ */
+int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
+{
+	unsigned long flags;
+	int nr_hw, nr_copied = 0;
+	u64 brbfcr, brbcr;
+
+	if (!cnt)
+		return 0;
+
+	/*
+	 * Pause BRBE first to avoid recording our own branches. The
+	 * sysreg read/write and ISB are branchless, so pausing before
+	 * checking BRBCR avoids polluting the buffer with our own
+	 * conditional branches.
+	 */
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+
+	/* Bail out if BRBE is not enabled (BRBCR_EL1 == 0). */
+	if (!brbcr) {
+		write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+		return 0;
 	}
 
-done:
-	branch_stack->nr = nr_filtered;
+	/* Block local exception delivery while reading the buffer. */
+	flags = local_daif_save();
+
+	/*
+	 * A PMU overflow before local_daif_save() could have re-enabled
+	 * BRBE, clearing the PAUSED bit. The overflow handler already
+	 * restored BRBE to its correct state, so just bail out.
+	 */
+	if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {
+		local_daif_restore(flags);
+		return 0;
+	}
+
+	nr_hw = FIELD_GET(BRBIDR0_EL1_NUMREC_MASK,
+			  read_sysreg_s(SYS_BRBIDR0_EL1));
+
+	for_each_brbe_entry(i, nr_hw) {
+		if (nr_copied >= cnt)
+			break;
+
+		if (!perf_entry_from_brbe_regset(i, &entries[nr_copied], NULL))
+			break;
+
+		nr_copied++;
+	}
+
+	brbe_invalidate();
+
+	/* Restore BRBCR before unpausing via BRBFCR, matching brbe_enable(). */
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	isb();
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	local_daif_restore(flags);
+
+	return nr_copied;
 }
diff --git a/drivers/perf/arm_brbe.h b/drivers/perf/arm_brbe.h
index b7c7d8796c86..c2a1824437fb 100644
--- a/drivers/perf/arm_brbe.h
+++ b/drivers/perf/arm_brbe.h
@@ -10,6 +10,7 @@
 struct arm_pmu;
 struct perf_branch_stack;
 struct perf_event;
+struct perf_branch_entry;
 
 #ifdef CONFIG_ARM64_BRBE
 void brbe_probe(struct arm_pmu *arm_pmu);
@@ -22,6 +23,8 @@ void brbe_disable(void);
 bool brbe_branch_attr_valid(struct perf_event *event);
 void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
 				const struct perf_event *event);
+int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries,
+				   unsigned int cnt);
 #else
 static inline void brbe_probe(struct arm_pmu *arm_pmu) { }
 static inline unsigned int brbe_num_branch_records(const struct arm_pmu *armpmu)
@@ -44,4 +47,10 @@ static void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
 				       const struct perf_event *event)
 {
 }
+
+static inline int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries,
+						 unsigned int cnt)
+{
+	return 0;
+}
 #endif
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 8014ff766cff..1a9f129a0f94 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1449,8 +1449,11 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
-	if (brbe_num_branch_records(cpu_pmu))
+	if (brbe_num_branch_records(cpu_pmu)) {
 		cpu_pmu->pmu.sched_task		= armv8pmu_sched_task;
+		static_call_update(perf_snapshot_branch_stack,
+				   arm_brbe_snapshot_branch_stack);
+	}
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
-- 
2.52.0


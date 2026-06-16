Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C52466B69;
	Tue, 16 Jun 2026 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625463; cv=none; b=Gucv9MTDDQFnR0lMHmf3Nk5JAKgazMz4Npx26v9vnFdS4odENBKdeDRdFMwpMs5HaHo1byR93bbuxlvXNyuVP8dVgPvihqMGbAOPJ+yaSzGZhqGOfgB9C6YSf/W4NhpBf9uJ4JGTnYMC07uDTT5D9Oj5VFSfo4l95S0W5+3+CuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625463; c=relaxed/simple;
	bh=aes1XEmYBDl2RmYRB/wQuLLgjq8XkF/pQwwZsWdtxr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B692jS387+PtI3mmCa6LBaJyYqbhwVBu0ZrhZY81UyrQtvml/kG8Jn1vKeq9cOk1Uv5b9bS8bvnnmmlnWqWORAgqv53FnvTJx6vJ3XMPiwoZqTN+0KWrUB670C5KDWIBpINYNcGT9lCbnaarsZR/ZQLKe/IbG9tDHK1/bY/dDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSczpPvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSczpPvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9B21F00A3A;
	Tue, 16 Jun 2026 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625461;
	bh=8sgGW/qEFwPxZcovDLzHGJGJ+O9xnnJBPViL03Al5ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XSczpPvtXcnnisWlEMeu/A6NHYYOUbsDG0MP/BqBk4r/YpnvF8KmEAFtYN3XuvEd+
	 HN5nSo3HjZo5i2YdUnlpMY4WRIa59jsg4O/WZVyleuOEoXRdNfGFOwJK1dQf83XZy6
	 wxje0P88CYhbylHt5sSGJ+wKHVszHfmHNTAzz7B8RPKAS9Yo4h5w5ZVLLIFYe7y/jE
	 sOcsRWiO0xewKhH8W5Luf+sUzNj4sZyfH0m1728/3PdAlkk1fjv5XaTS8Qih87c+zD
	 2a90ne1lczfTgobg7WYqkznhZxpFCsplxIOsZ3pbWQCAN8OzaZXZkp6YVqT1f5Outz
	 yCqVe2fkpoyQQ==
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
Subject: [PATCH v5 3/4] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
Date: Tue, 16 Jun 2026 08:57:08 -0700
Message-ID: <20260616155716.2631508-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616155716.2631508-1-puranjay@kernel.org>
References: <20260616155716.2631508-1-puranjay@kernel.org>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/perf/arm_brbe.c  | 128 ++++++++++++++++++++++++++++++++-------
 drivers/perf/arm_brbe.h  |   9 +++
 drivers/perf/arm_pmuv3.c |   5 +-
 3 files changed, 120 insertions(+), 22 deletions(-)

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index effbdeacfcbb..a141ad7abcf2 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/bitmap.h>
 #include <linux/perf/arm_pmu.h>
+#include <asm/daifflags.h>
 #include "arm_brbe.h"
 
 #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
@@ -256,6 +257,14 @@ static bool valid_brbe_version(int brbe_version)
 	       brbe_version == ID_AA64DFR0_EL1_BRBE_BRBE_V1P1;
 }
 
+static __always_inline bool cpu_has_brbe(void)
+{
+	u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
+	int brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
+
+	return valid_brbe_version(brbe);
+}
+
 static void select_brbe_bank(int bank)
 {
 	u64 brbfcr;
@@ -271,6 +280,20 @@ static void select_brbe_bank(int bank)
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
@@ -474,11 +497,9 @@ unsigned int brbe_num_branch_records(const struct arm_pmu *armpmu)
 
 void brbe_probe(struct arm_pmu *armpmu)
 {
-	u64 brbidr, aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
-	u32 brbe;
+	u64 brbidr;
 
-	brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
-	if (!valid_brbe_version(brbe))
+	if (!cpu_has_brbe())
 		return;
 
 	brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
@@ -618,10 +639,10 @@ static bool perf_entry_from_brbe_regset(int index, struct perf_branch_entry *ent
 
 	brbe_set_perf_entry_type(entry, brbinf);
 
-	if (!branch_sample_no_cycles(event))
+	if (!event || !branch_sample_no_cycles(event))
 		entry->cycles = brbinf_get_cycles(brbinf);
 
-	if (!branch_sample_no_flags(event)) {
+	if (!event || !branch_sample_no_flags(event)) {
 		/* Mispredict info is available for source only and complete branch records. */
 		if (!brbe_record_is_target_only(brbinf)) {
 			entry->mispred = brbinf_get_mispredict(brbinf);
@@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
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
+	/* Guard against running on a CPU without BRBE (e.g. big.LITTLE). */
+	if (!cpu_has_brbe())
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
+		isb();
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
+	/* Ensure BRBE is unpaused before returning to the caller. */
+	isb();
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
2.53.0-Meta


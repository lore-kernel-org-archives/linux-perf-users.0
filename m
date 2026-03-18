Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D4263C8C;
	Wed, 18 Mar 2026 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854258; cv=none; b=SNuke7VtFVpUVvjv+erfFWV+C1GIUw1FUDUmN1YX2kWzODngwMfoocvX40kSvux+8QlEHCpyT8wbR7kKTfNDvg6a7d9JL9xM4shLzU/3gNN4lIA6hpxBc1w8H2nUxiLPAjIRVCWi6jRqhTHvxVrbjXTg8g5fgKadr/NI/TJ928s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854258; c=relaxed/simple;
	bh=0aAh1WOnGYN7hHkdEv67pI2CDBIGK75Lbvt15+b6X14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuXOFXueqD9pIlYNsU03v5hxp2uktuFqxtay23AxS0Mn0pLeOroc5uinmWy+gX5NxVew/HlnxyxyNOLzH+kqijrCruUv36Jmc6SYfWZD0FrgmDsnEDY09yrki5SYfDaRXPVcSxGm+CVJyaU78jqV41MOub+tQ6I+JwGXuqNtJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHnSbxHu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHnSbxHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D39C19421;
	Wed, 18 Mar 2026 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773854258;
	bh=0aAh1WOnGYN7hHkdEv67pI2CDBIGK75Lbvt15+b6X14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHnSbxHulO7WUJtsx42KZ2vLKYqlBwWoAxGc5cCgq/dxwIZ1kfZxvtDplfIuU4K7w
	 cnLB4nmjpNpJIScxrPYkNEC7bes5oitxhVcUuHlIwRc1maGMXe88C9gdwh15RQhs35
	 RIZqsmN/ixtbbgEEabJ3hh9K2ug6zPullUd8JrY8ffub2tJo36ipj0sJ+DF24lfVD8
	 no4efguGt1LqZPbN+3RXHb73oTTz5LldAkaV5Bj32cpLURi9HZUys2etq0w0Ngyf94
	 L7iy9bDAQ8Xk/dLUuOIeIRvcugZgt3NdQYWMQkZM1W8tssRb8vjXIXcv16lDI7RDE3
	 6bGrmnGYaGvog==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 3/4] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
Date: Wed, 18 Mar 2026 10:16:57 -0700
Message-ID: <20260318171706.2840512-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318171706.2840512-1-puranjay@kernel.org>
References: <20260318171706.2840512-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the bpf_get_branch_snapshot() BPF helper on ARM64 by implementing
the perf_snapshot_branch_stack static call for ARM's Branch Record Buffer
Extension (BRBE).

The BPF helper bpf_get_branch_snapshot() allows BPF programs to capture
hardware branch records on-demand. This was previously only available on
x86 (Intel LBR) but not on ARM64 despite BRBE being available since
ARMv9.

BRBE is paused before disabling interrupts because local_irq_save() can
trigger trace_hardirqs_off() which performs stack walking and pollutes
the branch buffer. The sysreg read/write and ISB used to pause BRBE are
branchless, so pausing first avoids this pollution.

All exceptions are masked after pausing BRBE using local_daif_save() to
prevent pseudo-NMI from PMU counter overflow from interfering with the
snapshot read. A PMU overflow arriving between the pause and
local_daif_save() can re-enable BRBE via the interrupt handler; the
snapshot detects this by re-checking BRBFCR_EL1.PAUSED and bailing out.

Branch records are read using the existing perf_entry_from_brbe_regset()
helper with a NULL event pointer, which bypasses event-specific filtering
and captures all recorded branches. The BPF program is responsible for
filtering entries based on its own criteria. The BRBE buffer is
invalidated after reading to maintain contiguity for other consumers.

On heterogeneous big.LITTLE systems, only some CPUs may implement
FEAT_BRBE. The perf_snapshot_branch_stack static call is system-wide, so
a per-CPU brbe_active flag is used to prevent BRBE sysreg access on CPUs
that do not implement FEAT_BRBE, where such access would be UNDEFINED.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 drivers/perf/arm_brbe.c  | 79 +++++++++++++++++++++++++++++++++++++++-
 drivers/perf/arm_brbe.h  |  9 +++++
 drivers/perf/arm_pmuv3.c |  5 ++-
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index ba554e0c846c..527c2d5ebba6 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -8,9 +8,13 @@
  */
 #include <linux/types.h>
 #include <linux/bitmap.h>
+#include <linux/percpu.h>
 #include <linux/perf/arm_pmu.h>
+#include <asm/daifflags.h>
 #include "arm_brbe.h"
 
+static DEFINE_PER_CPU(bool, brbe_active);
+
 #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
 				   BRBFCR_EL1_INDIRECT | \
 				   BRBFCR_EL1_RTN      | \
@@ -533,6 +537,8 @@ void brbe_enable(const struct arm_pmu *arm_pmu)
 	/* Finally write SYS_BRBFCR_EL to unpause BRBE */
 	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
 	/* Synchronization in PMCR write ensures ordering WRT PMU enabling */
+
+	this_cpu_write(brbe_active, true);
 }
 
 void brbe_disable(void)
@@ -544,6 +550,7 @@ void brbe_disable(void)
 	 */
 	write_sysreg_s(BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
 	write_sysreg_s(0, SYS_BRBCR_EL1);
+	this_cpu_write(brbe_active, false);
 }
 
 static const int brbe_type_to_perf_type_map[BRBINFx_EL1_TYPE_DEBUG_EXIT + 1][2] = {
@@ -618,10 +625,10 @@ static bool perf_entry_from_brbe_regset(int index, struct perf_branch_entry *ent
 
 	brbe_set_perf_entry_type(entry, brbinf);
 
-	if (!branch_sample_no_cycles(event))
+	if (!event || !branch_sample_no_cycles(event))
 		entry->cycles = brbinf_get_cycles(brbinf);
 
-	if (!branch_sample_no_flags(event)) {
+	if (!event || !branch_sample_no_flags(event)) {
 		/* Mispredict info is available for source only and complete branch records. */
 		if (!brbe_record_is_target_only(brbinf)) {
 			entry->mispred = brbinf_get_mispredict(brbinf);
@@ -803,3 +810,71 @@ void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
 done:
 	branch_stack->nr = nr_filtered;
 }
+
+/*
+ * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
+ * self-recording and return 0 if the snapshot state appears disturbed.
+ */
+int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
+{
+	unsigned long flags;
+	int nr_hw, nr_banks, nr_copied = 0;
+	u64 brbidr, brbfcr, brbcr;
+
+	if (!cnt || !__this_cpu_read(brbe_active))
+		return 0;
+
+	/* Pause BRBE first to avoid recording our own branches. */
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+
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
+	brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
+	if (!valid_brbidr(brbidr))
+		goto out;
+
+	nr_hw = FIELD_GET(BRBIDR0_EL1_NUMREC_MASK, brbidr);
+	nr_banks = DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
+
+	for (int bank = 0; bank < nr_banks; bank++) {
+		int nr_remaining = nr_hw - (bank * BRBE_BANK_MAX_ENTRIES);
+		int nr_this_bank = min(nr_remaining, BRBE_BANK_MAX_ENTRIES);
+
+		select_brbe_bank(bank);
+
+		for (int i = 0; i < nr_this_bank; i++) {
+			if (nr_copied >= cnt)
+				goto done;
+
+			if (!perf_entry_from_brbe_regset(i, &entries[nr_copied], NULL))
+				goto done;
+
+			nr_copied++;
+		}
+	}
+
+done:
+	brbe_invalidate();
+out:
+	/* Restore BRBCR before unpausing via BRBFCR, matching brbe_enable(). */
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	isb();
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	local_daif_restore(flags);
+
+	return nr_copied;
+}
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
index 2d097fad9c10..e00c7c47a98d 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1456,8 +1456,11 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
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


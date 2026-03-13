Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AE3CAE7E;
	Fri, 13 Mar 2026 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425062; cv=none; b=QfugGKmMPBu7i1le9lfxiJNQunPPyV7hOBdLZGGL+HNh8RDtoyGVIkL+q16tobLmk4LTsmg8Bzw2M337/mFMIiyk+MXD52OtN/bjA6a1Y0PK56n5HkdwTeGmVztamm5rntsPnQzZ21J8qk+46EULAOXwleT/75SIB8rtrlEGJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425062; c=relaxed/simple;
	bh=/HnPmS0oECmN+To85fBPKp9K3yedceow81brUm+DMg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbri9MQNT+rpS+zkZ5XkT2L0K0xtEaxCgLmGj3IdDRpEnpWVmNgjoxqdpIdPBPRtkifDuXIW2UdY6NC/Re30+3xfn5pZ491feBDrqbbv0ufpDeNyc/BQWOzYhTFwUyQz21Pn4BjzGOrfxoKaJDTPqjbseCGBsAbaHrLUAXXHHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH/pAqVQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH/pAqVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3159EC19421;
	Fri, 13 Mar 2026 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773425062;
	bh=/HnPmS0oECmN+To85fBPKp9K3yedceow81brUm+DMg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BH/pAqVQR3IBEctFflnIZhHWflS9hevIlfM+pU1LoCNfmov+gBkJrhDbb72M9aCYn
	 obJb8cwntfgJGJOdx5twy0suLuWtudv380XFro7g0JK6aCE2NhfWcaSSjfLH+bY++m
	 ftXPQyXJ6jeHfTosPhpW90oX6uNrih364ctv/Wwo/NE9qup202hfe4UBbvK2u2g9O+
	 O5hXXbPen5fNtWpI0lnBKT78AdM+z/NwOpvMxGQmbcf9qDSsVLCtF6frju+jC1ZhBp
	 lvUXsIYugjfV0cC0fiLqVZ1FvchPHcDlIDmv+6F10rQh2Wg/MVNYbIipLD6Bw+Ydnb
	 nPmVaJXKsjx7g==
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
Subject: [PATCH bpf 2/3] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
Date: Fri, 13 Mar 2026 11:03:33 -0700
Message-ID: <20260313180352.3800358-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313180352.3800358-1-puranjay@kernel.org>
References: <20260313180352.3800358-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the perf_snapshot_branch_stack static call for ARM's Branch
Record Buffer Extension (BRBE), enabling the bpf_get_branch_snapshot()
BPF helper on ARM64.

This is a best-effort snapshot helper intended for tracing and debugging
use. It favors non-invasive snapshotting over strong serialization, and
returns 0 whenever a clean snapshot cannot be obtained. Nested
invocations are not serialized; callers may observe a 0-length result
when a clean snapshot cannot be preserved.

BRBE is paused before the helper does any other work to avoid recording
its own branches. The sysreg writes used to pause are branchless.
local_daif_save() blocks local exception delivery while reading the
buffer. If a PMU overflow raced before that point and re-enabled BRBE,
the helper detects the cleared PAUSED state and returns 0.

Branch records are read using perf_entry_from_brbe_regset() without
event-specific filtering. The BPF program is responsible for applying
its own filter criteria. The BRBE buffer is invalidated after reading
to maintain contiguity for other consumers.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 drivers/perf/arm_brbe.c  | 70 ++++++++++++++++++++++++++++++++++++++--
 drivers/perf/arm_brbe.h  |  9 ++++++
 drivers/perf/arm_pmuv3.c |  5 ++-
 3 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index ba554e0c846c..db5e000b2575 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/bitmap.h>
 #include <linux/perf/arm_pmu.h>
+#include <asm/daifflags.h>
 #include "arm_brbe.h"
 
 #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
@@ -618,10 +619,10 @@ static bool perf_entry_from_brbe_regset(int index, struct perf_branch_entry *ent
 
 	brbe_set_perf_entry_type(entry, brbinf);
 
-	if (!branch_sample_no_cycles(event))
+	if (!event || !branch_sample_no_cycles(event))
 		entry->cycles = brbinf_get_cycles(brbinf);
 
-	if (!branch_sample_no_flags(event)) {
+	if (!event || !branch_sample_no_flags(event)) {
 		/* Mispredict info is available for source only and complete branch records. */
 		if (!brbe_record_is_target_only(brbinf)) {
 			entry->mispred = brbinf_get_mispredict(brbinf);
@@ -803,3 +804,68 @@ void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
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
+	if (!cnt)
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
+	 * BRBE, clearing the PAUSED bit. Bail out.
+	 */
+	if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED))
+		goto out;
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


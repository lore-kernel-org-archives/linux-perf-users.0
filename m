Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7460E33C18B;
	Fri, 28 Aug 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926901; cv=none; b=I4G4CJPFhd4a/Pl5N5qadIDFD+yPWxvKkTrwHw7mnHiTC+mDYiwQIXOzEXNwZExattG/gYsArepfbE3eENDDBqmIK72L75m0JUFJjKY7a7bOy71kuaOIezoRiltP9Es6Tr4MvTWGy7/n//JbJN65ed7CfZY/XjMkaUnpWmKM+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926901; c=relaxed/simple;
	bh=z++vUbY2MyH5iwR7w6wcJ/ofMQ5wB8AMRbGt2ZN62ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2G/A376Rn/WTdikbMGy6rOqRZ5iFe9fZR5CP3CIlcOYkvI8Mpb+vNK7mYjUmsRTJVQwCJQ9530LVuah7OTPHBrGsD5UqjoAAxS8ZlB1yTObxO0PFx6k/3tbpyhllQ10KR5/g2DUK36RcjVcikF42xtTjzWCRwp6uNKJNzFbWjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAD3zfFhmZFqhFnABg--.44541S2;
	Fri, 28 Aug 2026 22:21:22 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Atish Patra <atish.patra@linux.dev>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: riscv: fix PMU overflow counter restart state
Date: Fri, 28 Aug 2026 22:21:18 +0800
Message-ID: <20260828142120.12616-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3zfFhmZFqhFnABg--.44541S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWDuF1fGw17XrWruFW8Crg_yoWrJr43pr
	W0kFW5trs5Xw4Ivas5Ja1kGa45Gws3JFZxKF1qkr1vkFy3tF15X3WkKr1ftr15JrWrWryj
	vF4Y9FWruF4jv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The PMU overflow handler keeps a 64-bit mask for all logical counters,
while SBI start calls consume an XLEN-sized mask relative to a counter
base.

On RV32, pmu_sbi_start_ovf_ctrs_sbi() applies the low overflow-mask word
to every used-counter word. Counters 32 through 63 can therefore be
classified using overflow bits 0 through 31.

The snapshot path and overflow handler also test and construct 64-bit
masks with XLEN-sized BIT(). In addition, snapshot restart uses the
completed inner-loop index instead of the outer word index to form
counter_idx_base. The latter selects an invalid counter base on both RV32
and RV64: for_each_set_bit() finishes with idx equal to BITS_PER_LONG, so
the current expression passes BITS_PER_LONG squared instead of the
expected i times BITS_PER_LONG.

Select the overflow word matching each SBI mask, use 64-bit bit operations
for global counter indices, and derive the snapshot start base from the
outer word index.

Fixes: b994cdfcdf7b ("drivers/perf: riscv: Fix counter mask iteration for RV32")
Fixes: a8625217a054 ("drivers/perf: riscv: Implement SBI PMU snapshot function")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/perf/riscv_pmu_sbi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 50220f7b46d9..6cfb1fc0ec6e 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -962,7 +962,9 @@ static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
 	u64 init_val = 0;
 
 	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
-		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
+		unsigned long word_ovf_mask =
+			ctr_ovf_mask >> (i * BITS_PER_LONG);
+		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~word_ovf_mask;
 		/* Start all the counters that did not overflow in a single shot */
 		if (ctr_start_mask) {
 			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG,
@@ -1002,7 +1004,7 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_
 	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 
 	for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
-		if (ctr_ovf_mask & BIT(idx)) {
+		if (ctr_ovf_mask & BIT_ULL(idx)) {
 			event = cpu_hw_evt->events[idx];
 			hwc = &event->hw;
 			max_period = riscv_pmu_ctr_get_width_mask(event);
@@ -1021,7 +1023,7 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_
 			sdata->ctr_values[idx] =
 					cpu_hw_evt->snapshot_cval_shcopy[idx + i * BITS_PER_LONG];
 		/* Start all the counters in a single shot */
-		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS_PER_LONG,
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG,
 			  cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
 	}
 }
@@ -1109,14 +1111,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 			hidx = info->csr - CSR_CYCLE;
 
 		/* check if the corresponding bit is set in scountovf or overflow mask in shmem */
-		if (!(overflow & BIT(hidx)))
+		if (!(overflow & BIT_ULL(hidx)))
 			continue;
 
 		/*
 		 * Keep a track of overflowed counters so that they can be started
 		 * with updated initial value.
 		 */
-		overflowed_ctrs |= BIT(lidx);
+		overflowed_ctrs |= BIT_ULL(lidx);
 		hw_evt = &event->hw;
 		/* Update the event states here so that we know the state while reading */
 		hw_evt->state |= PERF_HES_STOPPED;

base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.43.0


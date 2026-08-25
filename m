Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90C2F3C10;
	Tue, 25 Aug 2026 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644076; cv=none; b=lIqw927EYmcgmqPBbcqXoZcYIYXkp7AZqKjvz6XWWok2iJSJQqpMk3Rwn3706G+5JWYdw/u9snbcKTOsymQufutlqVvZsXzWPGBzgxdkshfxQqFjYGFczepPLl2ZZjLVjv95LhxVlkLsNocvKaALkxAMcA0KJ4BTwEMCw2NdxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644076; c=relaxed/simple;
	bh=o0Jf6n4/Kt37plO406A+Ck9pVTMClm7T50iwinPbZ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GmkVmWKXYWhx1o3+p8aWcL/KO2Y60LuYD0PgDndDald0OA5A8/JDPgjspiMfiaQlejqVpZqyZnTCzVmSBCAABRgYYRv93iUoc0Z9HUQLmr2wG0eWoh/FqLXO5fsmPy36h7cZkh8Ti4+jD9HOvCmDT/yX00g0xKPTWH6eRahA1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowABXWzmWSI1q0uM4Bg--.20181S2;
	Tue, 25 Aug 2026 15:47:34 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Atish Patra <atish.patra@linux.dev>,
	Yu Chien Peter Lin <peterlin@andestech.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charles Ci-Jyun Wu <dminus@andestech.com>,
	Leo Yu-Chi Liang <ycliang@andestech.com>,
	Locus Wei-Han Chen <locus84@andestech.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Clement Leger <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: riscv: Clear PMU pending interrupt through vendor helper
Date: Tue, 25 Aug 2026 15:34:33 +0800
Message-ID: <20260825151001.2-andes-pmu-clear-caplitmus-rv@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXWzmWSI1q0uM4Bg--.20181S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyxKr1kXr4xWryxKry8Xwb_yoW8JFy5pr
	Z09FW8ArnYqF4jva45A3W8uF1rua45u3yYk3yqk39rZa13Jry5XFn8JryfArnYvFW8G347
	urWxWrW5AFnYkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRiSdgUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

When no hardware counters are in use, the PMU overflow handler clears the
pending interrupt directly in CSR_SIP with BIT(riscv_pmu_irq_num).

For Andes PMU, riscv_pmu_irq_num is 274 and the pending bit lives in the
vendor SLIP CSR. The direct clear therefore uses an out-of-width shift and
the wrong CSR, unlike the other exits from the same handler.

Use ALT_SBI_PMU_OVF_CLEAR_PENDING() on this early return as well.

Fixes: bc969d6cc96a ("perf: RISC-V: Introduce Andes PMU to support perf event sampling")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 50220f7b46d9..ff95f5f13603 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1058,6 +1058,6 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	/* Firmware counter don't support overflow yet */
 	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
 	if (fidx == RISCV_MAX_COUNTERS) {
-		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 		return IRQ_NONE;
 	}


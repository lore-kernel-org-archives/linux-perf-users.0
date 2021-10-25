Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B0BC4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 20:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BBE760E09
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 20:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbhJYUCV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:02:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9214 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbhJYUAS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 16:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635191876; x=1666727876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5eCkQBSoOonAgl0sljci20qzRudmi2nGeiTOpU2ck8k=;
  b=iG/X2J8cQnQV6q1vFl3xl2AjhEFYgOuK5htjj0+j2amHYXEEs8mQP9LP
   PTjix6Dp4pkikGo8ijfepes13bfzPUm/E24GQ3ebORTICoqs0yrxrfxug
   8jZUkpYyIPrSEceVN9iqpSokbm6OiZdkZnyC94kRP7bas8icyZ9WkzzYz
   QJ+elYx5j++c199GrCZPEzMZgRQ+svEsS3tTFPnFsIhCCTO+XKi5jn65T
   5vdmlSCKIPfkNw8ZJPkhN1IqMUGqAsiurXA0MyJ5Xid5yFUrln4a5Odnm
   ZB1VMMvttbZ4s4aOEuWXz/548tvu06ic6Qd2X2d3ViLfZoAvnEm/PqqDM
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,181,1631548800"; 
   d="scan'208";a="295545860"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2021 03:53:58 +0800
IronPort-SDR: IeN04PlRtYCxU+SwXfouAIodWKSxnI3i0BucTNqXLKnjfEhd8xV43u3qC6qz3cC9lTmG2r6xlq
 XlnYx56L77RAClZX9BEylcSmaxKPCyIT8jgB4XNqaK1VkXq/ezHi7DfA4cbH/q7vUssMjnbOtG
 t8g0zDvt/qN6krws7ewofSKDCmehQ+Ak/yymk/RkwBIhLBvTBB+/RQ7oWvtoUdGlsqCC+najnl
 czT6UF1XOMFWkP5EmNwDKRbrPsgd7rncPB1OmZtgVFJ9o+c1qQ8l24fD2D8NRv86Oq626dza27
 EwtU7EHPWfsOpTdZhiwM4vqf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:27:56 -0700
IronPort-SDR: sgL6fH3SqTj1Vc7DndHcQ5eU4S9K9WuQ2yC1lDxThHigOPtotZ7xN/qmhg/XvZ6KmTW1VUA+Nz
 FmjYEGjvv3oovr1nI+T6aYwearWeq2KbLCT3u972drnP8GevgZHq8d7bx9MaOiBHsIehq0jQyg
 jYKzfzcvBmELoDmbRWM/4yLXRsdyyrz86VmYwGhjUHkVm1WSW0ecnCavfnASMlwNefO/8FOyBY
 BmLaFgF/Ke0diHNqWCfXRw8KvVWslxgifRMPKqzcEgZzoPMoqQgdWq/Fy32usMFWBTAxLjPkVx
 v0Q=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.27])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2021 12:53:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [v4 08/11] RISC-V: Add interrupt support for perf
Date:   Mon, 25 Oct 2021 12:53:47 -0700
Message-Id: <20211025195350.242914-9-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025195350.242914-1-atish.patra@wdc.com>
References: <20211025195350.242914-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The Sscof extension allows counter overflow and filtering for programmable
counters. Enable the perf driver to handle the overflow interrupt.
Even though the perf overflow interrupt is a local one, it is parsed from
DT for simplification. Thus, the DT node with interrupt-extended property
is mandatory for any platform that wants event sampling.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/csr.h   |   8 +-
 drivers/perf/riscv_pmu_sbi.c   | 209 ++++++++++++++++++++++++++++++---
 include/linux/perf/riscv_pmu.h |   4 +-
 3 files changed, 204 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index e4d369830af4..8518eb0014bc 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -63,6 +63,7 @@
 #define IRQ_M_TIMER		7
 #define IRQ_S_EXT		9
 #define IRQ_M_EXT		11
+#define IRQ_PMU_OVF		13
 
 /* Exception causes */
 #define EXC_INST_MISALIGNED	0
@@ -151,6 +152,8 @@
 #define CSR_HPMCOUNTER30H	0xc9e
 #define CSR_HPMCOUNTER31H	0xc9f
 
+#define CSR_SSCOUNTOVF		0xda0
+
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
 #define CSR_STVEC		0x105
@@ -212,7 +215,10 @@
 # define RV_IRQ_SOFT		IRQ_S_SOFT
 # define RV_IRQ_TIMER	IRQ_S_TIMER
 # define RV_IRQ_EXT		IRQ_S_EXT
-#endif /* CONFIG_RISCV_M_MODE */
+# define RV_IRQ_PMU	IRQ_PMU_OVF
+# define SIP_LCOFIP     (_AC(0x1, UL) << IRQ_PMU_OVF)
+
+#endif /* !CONFIG_RISCV_M_MODE */
 
 /* IE/IP (Supervisor/Machine Interrupt Enable/Pending) flags */
 #define IE_SIE		(_AC(0x1, UL) << RV_IRQ_SOFT)
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 7a274aeff51e..46380ac22e08 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -11,6 +11,9 @@
 #include <linux/mod_devicetable.h>
 #include <linux/perf/riscv_pmu.h>
 #include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
 
 #include <asm/sbi.h>
 
@@ -445,33 +448,203 @@ static int pmu_sbi_get_ctrinfo(int nctr)
 	return 0;
 }
 
+static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
+{
+	/**
+	 * No need to check the error because we are disabling all the counters
+	 * which may include counters that are not enabled yet.
+	 */
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+		  0, GENMASK_ULL(pmu->num_counters - 1, 0), 0, 0, 0, 0);
+}
+
+static inline void pmu_sbi_start_all(struct riscv_pmu *pmu)
+{
+	int lidx;
+	struct cpu_hw_events *hwc = this_cpu_ptr(pmu->hw_events);
+	unsigned long flag = ~SBI_PMU_START_FLAG_SET_INIT_VALUE;
+
+	/* Start all the enabled counters without reinitilizing it */
+	for_each_set_bit(lidx, hwc->used_event_ctrs, RISCV_MAX_COUNTERS)
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, lidx, 1, flag,
+			  0, 0, 0);
+}
+
+static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
+{
+	struct perf_sample_data data;
+	struct pt_regs *regs;
+	struct hw_perf_event *hw_evt;
+	union sbi_pmu_ctr_info *info;
+	int lidx, hidx, fidx;
+	struct riscv_pmu *pmu;
+	struct perf_event *event;
+	struct cpu_hw_events *hwc = dev;
+	unsigned long overflow;
+
+	fidx = find_first_bit(hwc->used_event_ctrs, RISCV_MAX_COUNTERS);
+	event = hwc->events[fidx];
+	if (!event) {
+		csr_clear(CSR_SIP, SIP_LCOFIP);
+		return IRQ_NONE;
+	}
+
+	pmu = to_riscv_pmu(event->pmu);
+	pmu_sbi_stop_all(pmu);
+
+	/* Overflow status register should only be read after counter are stopped */
+	overflow = csr_read(CSR_SSCOUNTOVF);
+
+	/**
+	 * Overflow interrupt pending bit should only be cleared after stopping
+	 * all the counters to avoid any race condition.
+	 */
+	csr_clear(CSR_SIP, SIP_LCOFIP);
+
+	/* No overflow bit is set */
+	if (!overflow)
+		return IRQ_NONE;
+
+	regs = get_irq_regs();
+
+	for_each_set_bit(lidx, hwc->used_event_ctrs, RISCV_MAX_COUNTERS) {
+		struct perf_event *event = hwc->events[lidx];
+
+		/* Skip if invalid event or user did not request a sampling */
+		if (!event || !is_sampling_event(event))
+			continue;
+
+		info = &pmu_ctr_list[lidx];
+		/* Firmware counter don't support overflow yet */
+		if (!info || info->type == SBI_PMU_CTR_TYPE_FW)
+			continue;
+
+		/* compute hardware counter index */
+		hidx = info->csr - CSR_CYCLE;
+		/* check if the corresponding bit is set in sscountovf */
+		if (!(overflow & (1 << hidx)))
+			continue;
+
+		hw_evt = &event->hw;
+		riscv_pmu_event_update(event);
+		perf_sample_data_init(&data, 0, hw_evt->last_period);
+		/*
+		 * Perf event overflow will queue the processing of the event as
+		 * an irq_work which will be taken care of in the handling of
+		 * IPI_IRQ_WORK.
+		 */
+		if (perf_event_overflow(event, &data, regs))
+			pmu_sbi_ctr_stop(event, 0);
+	}
+	pmu_sbi_start_all(pmu);
+
+	return IRQ_HANDLED;
+}
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
+	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
+	int pmu_irq;
 
 	/* Enable the access for TIME csr only from the user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x2);
 
 	/* Stop all the counters so that they can be enabled from perf */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, GENMASK_ULL(pmu->num_counters - 1, 0), 0, 0, 0, 0);
-
+	pmu_sbi_stop_all(pmu);
+	pmu_irq = per_cpu(hw_events->irq, cpu);
+	if (pmu_irq) {
+		csr_clear(CSR_IP, BIT(RV_IRQ_PMU));
+		csr_set(CSR_IE, BIT(RV_IRQ_PMU));
+		enable_percpu_irq(pmu_irq, IRQ_TYPE_NONE);
+	}
 	return 0;
 }
 
 static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 {
+	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
+	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
+	int pmu_irq;
+
+	pmu_irq = per_cpu(hw_events->irq, cpu);
+	if (pmu_irq) {
+		disable_percpu_irq(pmu_irq);
+		csr_clear(CSR_IE, BIT(RV_IRQ_PMU));
+	}
 	/* Disable all counters access for user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x0);
 
 	return 0;
 }
 
+static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pdev)
+{
+	int i = 0, num_irqs, ret;
+	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	num_irqs = of_irq_count(node);
+
+	if (num_irqs <= 0) {
+		dev_warn(dev, "no irqs for PMU, sampling events not supported\n");
+		return -EPERM;
+	}
+
+	for (i = 0; i < num_irqs; i++) {
+		struct of_phandle_args parent;
+		irq_hw_number_t pmu_irq = 0;
+		int cpu, hartid;
+
+		if (of_irq_parse_one(node, i, &parent)) {
+			pr_err("%pOFP: failed to parse parent for irq %d.\n", node, i);
+			continue;
+		}
+
+		if (parent.args[0] != RV_IRQ_PMU) {
+			pr_err("%pOFP: invalid irq %d for hwirq %d.\n", node, i, parent.args[0]);
+			continue;
+		}
+
+		hartid = riscv_of_parent_hartid(parent.np);
+		if (hartid < 0) {
+			pr_warn("failed to parse hart ID for irq %d.\n", i);
+			continue;
+		}
+
+		cpu = riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			pr_warn("Invalid cpuid for irq %d\n", i);
+			continue;
+		}
+		if (!pmu_irq && irq_find_host(parent.np)) {
+			pmu_irq = irq_of_parse_and_map(node, i);
+			pr_err("%s: found irq %lu\n", __func__, pmu_irq);
+			if (pmu_irq)
+				ret = request_percpu_irq(pmu_irq, pmu_sbi_ovf_handler,
+							 "riscv-pmu", hw_events);
+			if (ret) {
+				pr_err("registering percpu irq failed [%d]\n", ret);
+				return ret;
+			}
+			if (per_cpu(hw_events->irq, cpu)) {
+				pr_warn("PMU irq already set!!");
+				return -EINVAL;
+			}
+			per_cpu(hw_events->irq, cpu) = pmu_irq;
+			per_cpu(hw_events->sscof_ext_present, cpu) = true;
+		}
+	}
+
+	return 0;
+}
+
 static int pmu_sbi_device_probe(struct platform_device *pdev)
 {
 	struct riscv_pmu *pmu = NULL;
 	int num_counters;
-	int ret;
+	int ret = -ENODEV;
 
 	pr_info("SBI PMU extension is available\n");
 	/* Notify legacy implementation that SBI pmu is available*/
@@ -483,13 +656,19 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	num_counters = pmu_sbi_find_num_ctrs();
 	if (num_counters < 0) {
 		pr_err("SBI PMU extension doesn't provide any counters\n");
-		return -ENODEV;
+		goto out_free;
 	}
 
 	/* cache all the information about counters now */
 	if (pmu_sbi_get_ctrinfo(num_counters))
-		return -ENODEV;
+		goto out_free;
 
+	ret = pmu_sbi_setup_irqs(pmu, pdev);
+	if (ret < 0) {
+		pr_info("Perf sampling/filtering is not supported as sscof extension is not available\n");
+		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
+	}
 	pmu->num_counters = num_counters;
 	pmu->ctr_start = pmu_sbi_ctr_start;
 	pmu->ctr_stop = pmu_sbi_ctr_stop;
@@ -510,19 +689,27 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+out_free:
+	kfree(pmu);
+	return ret;
 }
 
+static const struct of_device_id riscv_pmu_of_device_ids[] = {
+	{.compatible = "riscv,pmu", .data = NULL},
+};
+
 static struct platform_driver pmu_sbi_driver = {
 	.probe		= pmu_sbi_device_probe,
 	.driver		= {
 		.name	= RISCV_PMU_PDEV_NAME,
+		.of_match_table = riscv_pmu_of_device_ids,
 	},
 };
 
 static int __init pmu_sbi_devinit(void)
 {
 	int ret;
-	struct platform_device *pdev;
 
 	if (((sbi_major_version() == 0) && (sbi_minor_version() < 3)) ||
 		sbi_probe_extension(SBI_EXT_PMU) <= 0) {
@@ -539,14 +726,6 @@ static int __init pmu_sbi_devinit(void)
 	}
 
 	ret = platform_driver_register(&pmu_sbi_driver);
-	if (ret)
-		return ret;
-
-	pdev = platform_device_register_simple(RISCV_PMU_PDEV_NAME, -1, NULL, 0);
-	if (IS_ERR(pdev)) {
-		platform_driver_unregister(&pmu_sbi_driver);
-		return PTR_ERR(pdev);
-	}
 
 	return ret;
 }
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index f3bce79d8998..afd93840754b 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -29,10 +29,13 @@
 struct cpu_hw_events {
 	/* currently enabled events */
 	int			n_events;
+	/* Counter overflow interrupt */
+	int		irq;
 	/* currently enabled events */
 	struct perf_event	*events[RISCV_MAX_COUNTERS];
 	/* currently enabled counters */
 	DECLARE_BITMAP(used_event_ctrs, RISCV_MAX_COUNTERS);
+	bool sscof_ext_present;
 };
 
 struct riscv_pmu {
@@ -40,7 +43,6 @@ struct riscv_pmu {
 	char		*name;
 
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
-	int		irq;
 
 	int		num_counters;
 	u64		(*ctr_read)(struct perf_event *event);
-- 
2.31.1


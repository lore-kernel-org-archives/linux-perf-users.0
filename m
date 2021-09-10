Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020B0C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D660C611EE
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhIJT3r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:29:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29548 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhIJT3g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 15:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631302104; x=1662838104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2I5oDONdJ84kh/3WsvACp0zYYiSPpZJuvszHDMM+VM=;
  b=hNG8o7k4dba3pMfgqeSWMMlxLeI0MUamjGm0LESgKa5JbDBGFRu4T7du
   NyTxWyCGF2w6KLyoUxVgGvIHwp5Yjd61j4aescJxgOB+NGPdlEn/zKWZu
   3ngaZB9lDNg/LC4jG9jCB2HIfVr1rGMJjN5DCCN2tBq/Qk3S9a7M+3+ur
   eD2lDp5GARijzb+qoJKnAN8S8kqw3KWOg1uNNkD0qW5KdcdRYpf33qQju
   gvZ0RE7nWvXgf9UfTtfv/l1FYM+6n8qy2pVPXexQSNJ5OWcXsBqY6bax9
   h16Ojvjd6sDJuHHgK1iwNVMwtL1Ot/4TS8/YEKOcUqnE1s6bCps1N1jCd
   A==;
X-IronPort-AV: E=Sophos;i="5.85,283,1624291200"; 
   d="scan'208";a="179706177"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2021 03:28:23 +0800
IronPort-SDR: jP3goi2AouG7g/no4cRhsminpEZwvkclpQnrC8c3nDFZHNBUGN3nHqUAYv1uv+OYC2LZKGybel
 b3W/8409csu1nyNveOorIDCHtWhof8bXGCLo67avVdJWkN9f9VTNYdq/A3SQV5oVdo1DrkvOpR
 EEnOdVo22stGYslRbDqAjdzu2UD+/IL77hw52dkmRUP7NpIvD/2N7EYe2c9kc5t8t8x2nXQanm
 nCTboAcCNkDc+DcQRl5jH4kO4MhBZH/pzwt1ni+vhexxOZfUd3Q20Ny7zUAn3zb9XlfxjpLUQ4
 f5/1rmbz8xqw9NKPM4YD8D0Z
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 12:03:18 -0700
IronPort-SDR: mCmcOac4UznBlGTBCl5RgoBpF7TF1ZEJcKcxpLqOgpR9QdRPjoDmBaxYm88FlbWRYgFJxbqZ5W
 hwsBxzioVBLD7lcUKXJCAQawyYVDcgZ4jbtHJQ/rq7sXxRdHi/22qmG44yloJLMGFpDM2Yx5PT
 3lFMnOEzWUe2LW3SNh/SQxO+X8h9aNlnihMvUhkutIRT3wCXP7/zIhKTgZHTLwEwHgCISS/EIJ
 5yY9r4NaydcOomHvmf8z45/0/NaTW7R5iJnql3sjJwGqYVaG5yYRc3dSIDxhfDYGyku3rjJpos
 kg8=
WDCIronportException: Internal
Received: from unknown (HELO hulk.wdc.com) ([10.225.167.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2021 12:28:24 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, devicetree@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [v3 08/10] RISC-V: Add interrupt support for perf
Date:   Fri, 10 Sep 2021 12:27:55 -0700
Message-Id: <20210910192757.2309100-9-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210910192757.2309100-1-atish.patra@wdc.com>
References: <20210910192757.2309100-1-atish.patra@wdc.com>
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
index e4d369830af4..8b2ac554ce9c 100644
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
 
+#define CSR_SSCOUNTOVF		0xd33
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
index addbdd932150..0bec9926e6ef 100644
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
 
@@ -444,33 +447,203 @@ static int pmu_sbi_get_ctrinfo(int nctr)
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
+static inline void pmu_sbi_start_all(struct riscv_pmu *pmu, uint64_t *ival)
+{
+	int lidx;
+	struct cpu_hw_events *hwc = this_cpu_ptr(pmu->hw_events);
+
+	/* Start all the enabled counters */
+	for_each_set_bit(lidx, hwc->used_event_ctrs, RISCV_MAX_COUNTERS)
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, lidx, 1, 1,
+			  ival[lidx], ival[lidx] >> 32, 0);
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
+	unsigned long overflow = csr_read(CSR_SSCOUNTOVF);
+	uint64_t ival[RISCV_MAX_COUNTERS] = {0};
+
+	/* No overflow bit is set */
+	if (!overflow) {
+		csr_clear(CSR_SIP, SIP_LCOFIP);
+		return IRQ_NONE;
+	}
+
+	fidx = find_first_bit(hwc->used_event_ctrs, RISCV_MAX_COUNTERS);
+	event = hwc->events[fidx];
+	if (!event) {
+		csr_clear(CSR_SIP, SIP_LCOFIP);
+		pr_warn("None of the counters are enabled\n");
+		return IRQ_NONE;
+	}
+
+	pmu = to_riscv_pmu(event->pmu);
+	pmu_sbi_stop_all(pmu);
+
+	/**
+	 * Overflow interrupt pending bit should only be cleared after stopping
+	 * all the counters to avoid any race condition.
+	 */
+	regs = get_irq_regs();
+	csr_clear(CSR_SIP, SIP_LCOFIP);
+
+	for_each_set_bit(lidx, hwc->used_event_ctrs, RISCV_MAX_COUNTERS) {
+		struct perf_event *event = hwc->events[lidx];
+
+		if (!event)
+			continue;
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
+		if (!riscv_pmu_event_set_period(event, &ival[lidx]))
+			continue;
+
+		/*
+		 * Perf event overflow will queue the processing of the event as
+		 * an irq_work which will be taken care of in the handling of
+		 * IPI_IRQ_WORK.
+		 */
+		if (perf_event_overflow(event, &data, regs))
+			pmu_sbi_ctr_stop(event, 0);
+	}
+	pmu_sbi_start_all(pmu, ival);
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
@@ -482,13 +655,19 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
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
@@ -509,19 +688,27 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
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
@@ -538,14 +725,6 @@ static int __init pmu_sbi_devinit(void)
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


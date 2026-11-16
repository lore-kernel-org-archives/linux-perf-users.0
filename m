Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853362;
	b=DvcmnkhQ/GYiK9XoUa5e/jPQMN0pjmaGangBgGjmFTjB07D7cz82W5easKTgrMxLBoD8
	 JcYSykb+mZ355HHFrqgkLjynhVNU+v9joH+kOpyD+jlehC3ba6DCM/ZVmIjub/b5hUcc+
	 cNq0pjJHEgisdtHHA25ZW60AfsO1huttNVDyOtxxsNDFInhpZB7Ra5spEcCl7vaItt4JM
	 GUksqbnH1eDhxhlJsMchEjPPC2udZPVekEPLhaFX+GTAtOqNkq7HipqEhpr4vKCxCheFQ
	 gNE6apBTzIvjI8sru0jK6mwEqxzQjIrHTyRxqBoXuLNSavWqS/jklVQqX+Y6fGTg5mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853362;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=MX516asZLotbLhllB8W9jB+EmEboHMXF1gW4MK6gyTM=;
	b=AP6IQp8DSaT2Ns/ms1eZqH6iH0jX3BddbackEATAB0nfcV7rp62RYZFsb2XfkJCXm8sg
	 inipkexGDLZhA42RCaaAgM7fT9ewCKuIi6547xhtXnpXBOnYvy0NgWQVxiD87XCWN9Igv
	 J3DL3hMMn4l0sVYfgfrHhFnMB7ixUu4sEY0+cQcKZxi2Zt//wrNd7P6wsspexE7Y4xoUR
	 PnH3y1UdamWgrsq4yVvbECHiAG3eb9cqftOzladrZZUY81UWX94TcoxKNmZohCNYfViZH
	 NmhdWOqixzmBTeFNXpM/HRaraRRDEig0iU0Yw+iKjC3F5WaGEGBv7XX9x3bCIknzaFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IehhGFFR;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E44606A33E;
	Mon, 16 Nov 2026 18:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53E44606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IehhGFFR
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6DE81684;
	Mon, 16 Nov 2026 10:22:38 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB0F03F632;
	Mon, 16 Nov 2026 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794853361; bh=gUpqEz9OvDKZWLPWRmE1Gxn/RE/2b19+TI+H5Oxsn84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IehhGFFRluRP7ZVSSFLLDk5CJYgdk7sdEcD50M1AtdfL0Tn94XPx+7Y95SNgSnw1l
	 iK/GQg9628FUyq2gSzjKMFtsOISmVl43pxHKoKBZxRXIkr7tzMXO05YRYAP53CkQr1
	 ktG/VHtZnpymQL7x8bgHiCgwSxyR3goXN2EpthzE=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 16 Nov 2026 18:21:34 +0000
Subject: [PATCH 7/8] perf/arm_pmu: Use ACPI CPU affinity in IRQ handling
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-acpi_arm_pmu_registration_hmp-v1-7-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, Will Deacon <will@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, Jeremy Linton <jeremy.linton@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, Rob Herring <robh@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, Al Grant <al.grant@arm.com>, 
 "Johnny.Fan" <johnny.fan@cixtech.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794853327; l=4351;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=gUpqEz9OvDKZWLPWRmE1Gxn/RE/2b19+TI+H5Oxsn84=;
 b=MyzTW48CaRwFfJwrqEnPzGWLcEA7lX8Ew4HGvMsd+Cotu+EbxMKFa4lJeFLba6A7DQgElfBcO
 mGkTS6M91YEDUyEzCJaRWLbFoRtrPOnF79lOzGRfbBF5quYfqpcY/pX
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Read each IRQ resource's CPU mask through platform_get_irq_affinity().
For ACPI SPIs, select the CPU from that resource's singleton mask.

Add pmu_get_irq_affinity() for counting-only PMUs, which have no IRQ
resource to query. Fall back to cpu_possible_mask when firmware provides
no affinity mask.

Select DT handling from the device's OF node. Preserve the DT SPI
interrupt-affinity phandle order and the single-PPI path.

The common platform probe initializes the per-CPU PMU pointers and
supported CPU mask before requesting interrupts. Use that mask in
armpmu_request_irq() and remove the cpu_possible_mask fallback needed
by the former ACPI pre-probe IRQ setup.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_pmu.c          |  3 +--
 drivers/perf/arm_pmu_platform.c | 29 ++++++++++++++++++++---------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 11506956538925fbc72e1d114d511eb3b76f8687..67d1791ab49fe7714983fe30e4ea351dc2ea9ac5 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -631,8 +631,7 @@ int armpmu_request_irq(struct arm_pmu * __percpu *pcpu_armpmu, int irq, int cpu)
 {
 	int err = 0;
 	struct arm_pmu **armpmu = per_cpu_ptr(pcpu_armpmu, cpu);
-	const struct cpumask *affinity = *armpmu ? &(*armpmu)->supported_cpus :
-						   cpu_possible_mask; /* ACPI */
+	const struct cpumask *affinity = &(*armpmu)->supported_cpus;
 	const irq_handler_t handler = armpmu_dispatch_irq;
 	const struct pmu_irq_ops *irq_ops;
 
diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 397fdb148dc9b6be083e654e091ecc6a95c4905b..5ca211798b60ae3e0b9459aba2170f9c84d8f9c7 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -20,6 +20,7 @@
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/string.h>
@@ -63,11 +64,24 @@ static bool pmu_has_irq_affinity(struct device_node *node)
 	return of_property_present(node, "interrupt-affinity");
 }
 
-static int pmu_parse_irq_affinity(struct device *dev, int i)
+static const struct cpumask *pmu_get_irq_affinity(struct device *dev)
+{
+	const struct cpumask *affinity;
+
+	affinity = fwnode_irq_get_affinity(dev_fwnode(dev), 0);
+	return affinity ?: cpu_possible_mask;
+}
+
+static int pmu_parse_irq_affinity(struct device *dev, int i,
+				  const struct cpumask *affinity)
 {
 	struct device_node *dn;
 	int cpu;
 
+	/* ACPI software nodes provide a singleton CPU mask for each SPI */
+	if (!dev->of_node)
+		return cpumask_first(affinity);
+
 	/*
 	 * If we don't have an interrupt-affinity property, we guess irq
 	 * affinity matches our logical CPU order, as we used to assume.
@@ -104,14 +118,10 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 	if (num_irqs < 0)
 		return dev_err_probe(dev, num_irqs, "unable to count PMU IRQs\n");
 
-	/*
-	 * In this case we have no idea which CPUs are covered by the PMU.
-	 * To match our prior behaviour, we assume all CPUs in this case.
-	 */
 	if (num_irqs == 0) {
 		dev_warn(dev, "no irqs for PMU, sampling events not supported\n");
 		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
-		cpumask_setall(&pmu->supported_cpus);
+		cpumask_copy(&pmu->supported_cpus, pmu_get_irq_affinity(dev));
 		return 0;
 	}
 
@@ -124,13 +134,14 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 			return pmu_parse_percpu_irq(pmu, irq, affinity);
 	}
 
-	if (nr_cpu_ids != 1 && !pmu_has_irq_affinity(dev->of_node))
+	if (dev->of_node && nr_cpu_ids != 1 && !pmu_has_irq_affinity(dev->of_node))
 		dev_warn(dev, "no interrupt-affinity property, guessing.\n");
 
 	for (i = 0; i < num_irqs; i++) {
+		const struct cpumask *affinity;
 		int cpu, irq;
 
-		irq = platform_get_irq(pdev, i);
+		irq = platform_get_irq_affinity(pdev, i, &affinity);
 		if (WARN_ON(irq <= 0))
 			continue;
 
@@ -139,7 +150,7 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 			return -EINVAL;
 		}
 
-		cpu = pmu_parse_irq_affinity(dev, i);
+		cpu = pmu_parse_irq_affinity(dev, i, affinity);
 		if (cpu < 0)
 			return cpu;
 		if (cpu >= nr_cpu_ids)

-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853349;
	b=pedsrUgD/4j9F8tgRQsEpsE9KuzHjut9XsiCTFrOCOjg4p+6eBikS3EZZ1tTWiYmlVOm
	 5TvGmnXhW4t3OtbD39hLds0IUV8vFSoHHmGEm4sNzQqXif1ldNpNENRJgIhGp9fdopwYq
	 tmTLb91xgfDDOEbQ0aVMU4oTCyYo212SvotWShWRGbheD0RnSOAOodJoMbGBhcvd9ziQM
	 ur/xghpyLvhbVUn4vCLC/Q261NhTmTP7qEPXMpGFzbeJsIQrnr9UaBITBd+SFq1dxZ6LU
	 dWgiwtfuhVvFyDrFJC8ZC8Bac9UsJR/rgKnN1FP7guTbCo2tSpdy+3/j00Cp7R8ug8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853349;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=V9fQ7V+HnC3+mZIkVBup/DL7T9dCFIK15XRUFub1Lqw=;
	b=1oHupWv0SmjdFKvbJXcq26DPi8TOWbVRA3P3hvVFk3tvx8GWINw7KnsRw2p1QZbEEooc
	 hO03JQ69Tq1O4qagOD8QSLbqgJZh7mp+4OJSNzww7LMln3oB9119M/59YwZyyacnFYZre
	 lmXujTF1ONLWgT5tXC+VtUsaFwebMNSLgtLSCExzUOufm1jPnW6ZL6sXm47LmKGgBJ4cA
	 8L11h63TxeBTpYylaPbekIpS73IwYzsEHLpGMvHStwq1Xx/9SZX79NDuheWpc7EYyXI6m
	 bEoGdH1FV9Ykw56IdNsHSbF9+lpruL/nObLcGfD8Qoi1Kgpx6JBR35ybRfJ7Kpuq7Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ft4tiibX;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43416606A322;
	Mon, 16 Nov 2026 18:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43416606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ft4tiibX
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFDE81A25;
	Mon, 16 Nov 2026 10:22:25 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C38EF3F632;
	Mon, 16 Nov 2026 10:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794853348; bh=S8CtYSrSSXMBTx69eeGqeydEJ6als+cClSEg+DhFsW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ft4tiibXYJqtmYg04qPoR27PIg/NV2mU5uMiLQaxae4LxwdRVGDClZTMCdgnWTilp
	 agSHCQ2E/WNtIfRc516klVJtSId+QJAKQpfzJt0hRHY3ZVRVaZLsAGtg6sWk22NI9U
	 Fp3V2wMcAleD6hUQn7oqdnXDwKD2D8HI2h/QeP44=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 16 Nov 2026 18:21:31 +0000
Subject: [PATCH 4/8] perf/arm_pmu: Prepare ACPI registration for per-CPU
 interrupts
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
Message-Id: <20261116-acpi_arm_pmu_registration_hmp-v1-4-0371d4eca626@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794853327; l=3464;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=S8CtYSrSSXMBTx69eeGqeydEJ6als+cClSEg+DhFsW4=;
 b=PllKyyNoIOh6QzJ591v24YxRwvR//bSIPCuq5ofsE32NiW5U2NddFKqe6GVtK9iwI9jcvs/MG
 uKpcsFLYGFoDiLA7E8H8yMt+Lt5/eyabPuK65vp+6V6+3lzdK2cpFAx
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

CPU PMUs may use a separate SPI for each CPU. Extend the existing IRQ
compatibility check to allow different SPIs in a group while retaining
the same-PPI requirement.

Extend arm_acpi_register_sw_node_irq_affinity() to publish a singleton
CPU mask for each SPI resource, using the CPU recorded in its mapping
entry. Keep the full group mask at index zero for a shared PPI or a
counting-only device with no IRQ resources.

Retain zero-GSI CPU PMU entries for counting-only devices. Trust
firmware to provide GICC interrupt descriptions as specified by ACPI.
SPE and TRBE remain the common registration interface's callers in this
commit.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_pmu_acpi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 7ae291acb04526d820bdfb9640aaa8352449be54..6a7fa8d01f42b1b58e28541a374f005e1955598f 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -158,7 +159,8 @@ arm_acpi_alloc_pmu_groups(const struct arm_pmu_acpi_device_info *info,
 			goto out_free;
 		}
 		gsi = info->parse_gsi(gicc);
-		if (!gsi)
+		/* CPU PMUs can count without an overflow interrupt */
+		if (!gsi && strcmp(info->name, ARMV8_PMU_PDEV_NAME))
 			continue;
 
 		group = arm_acpi_alloc_pmu_group(groups, &nr_groups, cpu);
@@ -201,7 +203,8 @@ static void arm_acpi_unregister_irq_resource(struct arm_pmu_acpi_group *group)
 
 static bool arm_acpi_pmu_irq_matches(unsigned int irq, unsigned int other_irq)
 {
-	return irq == other_irq;
+	return irq == other_irq ||
+		(!irq_is_percpu_devid(irq) && !irq_is_percpu_devid(other_irq));
 }
 
 static int arm_acpi_map_gsi_irq(u32 gsi, int *irq)
@@ -253,7 +256,7 @@ static int arm_acpi_register_irq_resource(struct platform_device *pdev,
 		if (ret < 0)
 			goto out_free;
 
-		/* A group must use the same PPI */
+		/* A group must use the same PPI or only SPIs */
 		if (group->nr_irqs && !arm_acpi_pmu_irq_matches(irq, res[0].start)) {
 			pr_warn("ACPI: %s: CPU%d has inconsistent PPI in group, ignoring CPU\n",
 				pdev->name, map.cpu);
@@ -279,15 +282,28 @@ static int arm_acpi_register_irq_resource(struct platform_device *pdev,
 static int arm_acpi_register_sw_node_irq_affinity(struct platform_device *pdev,
 						 struct arm_pmu_acpi_group *group)
 {
-	int ret;
+	struct fwnode_handle *fwnode;
+	struct resource *res;
+	int i, ret;
 
 	/* A MIDR group may span several processor containers */
 	ret = device_create_managed_software_node(&pdev->dev, NULL, NULL);
 	if (ret)
 		return ret;
+	fwnode = dev_fwnode(&pdev->dev);
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res || irq_is_percpu_devid(res->start))
+		return software_node_add_irq_affinity(fwnode, 0, &group->cpus);
+
+	for (i = 0; i < group->nr_irqs; i++) {
+		ret = software_node_add_irq_affinity(fwnode, i,
+						     cpumask_of(group->irq_maps[i].cpu));
+		if (ret)
+			return ret;
+	}
 
-	return software_node_add_irq_affinity(dev_fwnode(&pdev->dev), 0,
-					      &group->cpus);
+	return 0;
 }
 
 static int arm_acpi_register_pmu_device(struct arm_pmu_acpi_group *group,

-- 
2.34.1


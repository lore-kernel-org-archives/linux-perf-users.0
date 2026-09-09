Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967C63403F1
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970989; cv=none; b=NzbkVlDGeektg2f2FySxOYmQPIadD6KMRQp2UKs/Q/pUGCyCcL8flgJgP8ZCpTy6YXfpHXwTnDKXstWZqa7ALeHskOgs4xsbvR+flupNAQQ/WxVQDX8+wdvcHJpYuEh4e93IzvBuj5SlkgqCtbh8lB5DaybaQJexnBdORNMQpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970989; c=relaxed/simple;
	bh=Lu6PqQ98ZIcVokP8zCJPl+McNFYlpvai7wV1clZrQ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzQ0y+YlyWV11GAxY9mRga5Z+/0dvQe8q72o6lnj8PeI9RiSJM0sK3H6hbG6RDWPkHt/+E6WHdSyczxPGTvOGbCHmflpHuEaKRG7Tppx4xGGxpIDhVhHQydyXWKiykgJGtdrvJCtgkQMQf3DKnEFqT1W2vqxQkC1WET/OYi/TX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mvEyKiaI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mvEyKiaI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5A441570;
	Wed,  9 Sep 2026 09:23:01 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA0613F7B4;
	Wed,  9 Sep 2026 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788970985; bh=Lu6PqQ98ZIcVokP8zCJPl+McNFYlpvai7wV1clZrQ6s=;
	h=From:To:Cc:Subject:Date:From;
	b=mvEyKiaIe8AagPR0cTpqCEXuig/9ATEtebclddS/6kbds0a4oGrXryXVKG1vTsnuK
	 hPQRM7Zd9IuH8+fWsHJziT3kfUOudFOQzHWxPMf13xsyjB1yPFkiCuPgRUPM9OT+My
	 2z5zngyq1GMrxake/l4RyoJlTC2C9jE+7gyYU5/o=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf/arm_cspmu: Add Arm system PMU
Date: Wed,  9 Sep 2026 17:23:00 +0100
Message-ID: <84a65061841c8870375ee6b0621dd3f61651763d.1788970980.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm's latest Compute Subsystems and SoCs are using a common PMU block
in various places which can mostly just be driven as a generic 64-bit
CoreSight PMU, but does have an IMP-DEF register for additional
filtering. The details of event and filter encodings depend on the
particular PMU instance, so are left to the higher level Arm Telemetry
Solution tooling.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_cspmu/Kconfig      |  7 +++
 drivers/perf/arm_cspmu/Makefile     |  1 +
 drivers/perf/arm_cspmu/arm_cspmu.c  |  7 +++
 drivers/perf/arm_cspmu/arm_cspmu.h  |  1 +
 drivers/perf/arm_cspmu/arm_syspmu.c | 67 +++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+)
 create mode 100644 drivers/perf/arm_cspmu/arm_syspmu.c

diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index 004c1c2ee2ad..d44916312c77 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -28,6 +28,13 @@ config AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 	  In the first phase, the driver enables support on MCU PMU used in
 	  AmpereOne SoC family.
 
+config ARM_SYSTEM_PMU
+	tristate "Arm System PMU"
+	depends on ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
+	help
+	  Support additional event filtering attributes for the CoreSight-based
+	  PMU blocks found in various parts of Arm Compute Subsystems and SoCs.
+
 config ARM_BMU
 	tristate "ARM Bus Monitor Unit"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index 0bb4d510fc49..c9c42227a3ad 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -8,6 +8,7 @@ arm_cspmu_module-y := arm_cspmu.o
 
 obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
 obj-$(CONFIG_AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += ampere_cspmu.o
+obj-$(CONFIG_ARM_SYSTEM_PMU) += arm_syspmu.o
 
 obj-$(CONFIG_ARM_BMU) += arm-bmu.o
 obj-$(CONFIG_ARM_DMC750) += arm-dmc750.o
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 912f03ce3ef5..9f298ea1a974 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -358,6 +358,13 @@ static struct arm_cspmu_impl_match impl_match[] = {
 		.module		= NULL,
 		.impl_init_ops	= NULL,
 	},
+	{
+		.module_name	= "arm_syspmu",
+		.pmiidr_val	= ARM_CSPMU_IMPL_ID_ARM,
+		.pmiidr_mask	= PMIIDR_IMPLEMENTER,
+		.module		= NULL,
+		.impl_init_ops	= NULL,
+	},
 	{
 		.module_name	= "ampere_cspmu",
 		.pmiidr_val	= ARM_CSPMU_IMPL_ID_AMPERE,
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index c4058d602477..03e34692a965 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -149,6 +149,7 @@
 
 /* JEDEC-assigned JEP106 identification code */
 #define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
+#define ARM_CSPMU_IMPL_ID_ARM		0x43B
 #define ARM_CSPMU_IMPL_ID_AMPERE	0xA16
 
 /* PMDEVARCH */
diff --git a/drivers/perf/arm_cspmu/arm_syspmu.c b/drivers/perf/arm_cspmu/arm_syspmu.c
new file mode 100644
index 000000000000..ac234768a2f8
--- /dev/null
+++ b/drivers/perf/arm_cspmu/arm_syspmu.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/io.h>
+#include <linux/module.h>
+
+#include "arm_cspmu.h"
+
+#define PMEVFILT3R	0x200
+
+static struct attribute *arm_syspmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_FILTER_ATTR,
+	ARM_CSPMU_FORMAT_FILTER2_ATTR,
+	ARM_CSPMU_FORMAT_ATTR(filter3, "config3:0-63"),
+	NULL,
+};
+
+static struct attribute **arm_syspmu_get_format_attrs(const struct arm_cspmu *cspmu)
+{
+	return devm_kmemdup(cspmu->dev, arm_syspmu_format_attrs,
+			    sizeof(arm_syspmu_format_attrs), GFP_KERNEL);
+}
+
+static void arm_syspmu_set_ev_filter(struct arm_cspmu *cspmu,
+				     const struct perf_event *event)
+{
+	u32 offset = 8 * event->hw.idx;
+
+	writeq(event->attr.config1, cspmu->base0 + PMEVFILTR + offset);
+	writeq(event->attr.config2, cspmu->base0 + PMEVFILT2R + offset);
+	writeq(event->attr.config3, cspmu->base0 + PMEVFILT3R + offset);
+}
+
+static int arm_syspmu_init_ops(struct arm_cspmu *cspmu)
+{
+	switch (FIELD_GET(PMIIDR_PRODUCTID, cspmu->impl.pmiidr)) {
+	case 0x9c3:
+		cspmu->impl.ops.set_ev_filter = arm_syspmu_set_ev_filter;
+		cspmu->impl.ops.get_format_attrs = arm_syspmu_get_format_attrs;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct arm_cspmu_impl_match arm_syspmu_param = {
+	.pmiidr_val	= ARM_CSPMU_IMPL_ID_ARM,
+	.module		= THIS_MODULE,
+	.impl_init_ops	= arm_syspmu_init_ops
+};
+
+static int __init arm_syspmu_init(void)
+{
+	return arm_cspmu_impl_register(&arm_syspmu_param);
+}
+
+static void __exit arm_syspmu_exit(void)
+{
+	arm_cspmu_impl_unregister(&arm_syspmu_param);
+}
+
+module_init(arm_syspmu_init);
+module_exit(arm_syspmu_exit);
+
+MODULE_DESCRIPTION("Arm System PMU Driver");
+MODULE_LICENSE("GPL");
-- 
2.54.0.dirty


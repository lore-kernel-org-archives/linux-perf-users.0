Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFFC4A013A
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209658; cv=none; b=mtYdYNt4fBkI+cUS+1goHcUTQa2NpyRNyoPpyqFxLk6yK+0dLLs5836bZV9w7ASBeE0agbCNPMolW2cUlO+vpUzUzzwtqNd3dee1CImwXr9y7p13Bg6p48VBEIb2KNJV97L07sd4BybZhwcz3MYQ9s9xvi6kASevHof3RjDGCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209658; c=relaxed/simple;
	bh=HU2NB+KNDLZNYYCTRaaiO8C0EY9/i/5AxUl5Hd2/odY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElSQjd09JQC5tEPgmhq5ilOF4r+DYARLNmmhFwPWCCb5N1IgL9Nvmb3v+xs0G+Z9eCSer5ArGaHuySHTtIXzRXL6vR/+wwO+cvw7OoBCB98IL7d3wuPiHztKqZSFq7uf6aw/gquUkYsm1dzp0daIKHZE9EhjiQInTJL8zsjPkEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lVekYft/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lVekYft/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6021152B;
	Mon,  5 Oct 2026 07:13:58 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 860A23F66F;
	Mon,  5 Oct 2026 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791209642; bh=HU2NB+KNDLZNYYCTRaaiO8C0EY9/i/5AxUl5Hd2/odY=;
	h=From:To:Cc:Subject:Date:From;
	b=lVekYft/MDIpu55mLXXLVD3cT63pbv6cRL1IBRkh4fUupBUrzkNbrNjQHo1RrsD6a
	 +V/8/N/U4a0zhKajN66oV/A9+zfzv9s3bYpDiNpBzFVejcRGCwTc+K0K+xLyBtLsnz
	 nsKfd1abSUWUW9VdiovJB118sGcki2Ks4z+K+Dco=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] perf/arm_cspmu: Add Arm system PMU
Date: Mon,  5 Oct 2026 15:11:00 +0100
Message-ID: <222d98feab5ca2836fdef69fee9113f6f860167d.1791209460.git.robin.murphy@arm.com>
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

v3: Fix 32-bit COMPILE_TEST to match arm_cspmu.c

 drivers/perf/arm_cspmu/Kconfig      |  7 +++
 drivers/perf/arm_cspmu/Makefile     |  1 +
 drivers/perf/arm_cspmu/arm_cspmu.c  |  7 +++
 drivers/perf/arm_cspmu/arm_cspmu.h  |  1 +
 drivers/perf/arm_cspmu/arm_syspmu.c | 67 +++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+)
 create mode 100644 drivers/perf/arm_cspmu/arm_syspmu.c

diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index 6f4e28fc84a2..25bd55f036a4 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -27,3 +27,10 @@ config AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 
 	  In the first phase, the driver enables support on MCU PMU used in
 	  AmpereOne SoC family.
+
+config ARM_SYSTEM_PMU
+	tristate "Arm System PMU"
+	depends on ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
+	help
+	  Support additional event filtering attributes for the CoreSight-based
+	  PMU blocks found in various parts of Arm Compute Subsystems and SoCs.
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index 220a734efd54..90c3cd710157 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -8,3 +8,4 @@ arm_cspmu_module-y := arm_cspmu.o
 
 obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
 obj-$(CONFIG_AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += ampere_cspmu.o
+obj-$(CONFIG_ARM_SYSTEM_PMU) += arm_syspmu.o
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
index 000000000000..2f5ceda5c4d1
--- /dev/null
+++ b/drivers/perf/arm_cspmu/arm_syspmu.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/io-64-nonatomic-lo-hi.h>
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


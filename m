Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988482;
	b=p5FbtUWiiWQBcUrBm6XvOtAr8s8p6j1GJl1YWyb2B6AFvXyeDQuqdbwrFA6fHB9BAqqY
	 IpacHhGJvhLQ6Z3M73HjVKRcSClmzvkH2SEHoezTS8xdthtP1fiyIcbSOKa/EUq/1biu6
	 x8RHJWRcmKVdtJ4sM8c7rYTRr1b7CWsnALGxawpDileQtDYeBE6fbEVw+vGLHnHbLkygV
	 SMcBzO6PH3sB8qhZuuxZmuCI8ldMOt0Qnoq21YwD5TIv7F8y9Uy6yEKNiHcbN2GaE/U7O
	 6z3Ix0RIf/Rgf3RxYEOGxJVzHnsgAoG8SkKaGe+NFNaaxUb6LkmoauE3bv9DmRl9MTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988482;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NwKf0FG7r9/T3kREOAJFh9Rxc6KmqyiPUXfCnd/wOUs=;
	b=tfJrIGO9VITzddRVohn0/GKaAybpL602wNUTJbX7aYWexKo6Au75zM9+j3ObdllKR0fe
	 qACpainyYWfE/9jH3WBVXcOks7FocpyHG6uRTbp+x3ACQbfsxPxLDGbYidES/0b4prPwR
	 lUQgjKNDHxkb2rNfGvKVHNmCNsA602UAw3BWuajeqZp27Mte/h0SgwGyd1c/jrdyVdHPR
	 t+8f3i4777xjmHHEtr3JfjogztrDpOI2HFhLrq7oX7u9IBE+b585qxqXFCr/dZ9utFBPm
	 PEuKrZbRU3o6b7Tqpidju4VnPGnd+Tm9aWjrSa/pfyg+TI7ZvVgoynsIpqB1YZ0gXvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="YT/bjRPw";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9B6082BD6
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1F9B6082BD6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YT/bjRPw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BEC81682;
	Fri,  6 Nov 2026 10:07:57 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 588CD3F673;
	Fri,  6 Nov 2026 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793988480; bh=cp6Pv7IzX/SCbrjW2GiosTAcEEM0Ge+G3sZ6/m8WK8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YT/bjRPw0jVCJHZhtkqoMFnegra/O3RgPCID3a8ggxwxAM9kLEdhGPsVu37YfwdOZ
	 83X7tilYnE7QNSK93o1/qYrWfYtmuKeGFrtFwQ2s3okHHpLSaoxZMGVw1tvt2RKDqB
	 q/NqXKETLjtK1ldyV76Qa4f2jnBK3IVciXujm5YI=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v4 1/4] perf/arm_cspmu: Add Arm system PMU
Date: Fri,  6 Nov 2026 18:07:43 +0000
Message-ID: <2cf79599d522539440a53adb4221dfc5a4d7b9e6.1793986672.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1793986672.git.robin.murphy@arm.com>
References: <cover.1793986672.git.robin.murphy@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm's latest Compute Subsystems and SoCs are using a common PMU block
in various places which can mostly just be driven as a generic 64-bit
CoreSight PMU, but does have an IMP-DEF register for additional
filtering. The details of event and filter encodings depend on the
particular PMU instance, so are left to the higher level Arm Telemetry
Solution tooling.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
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
index 93d5b062de8b..86b62c236a4b 100644
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


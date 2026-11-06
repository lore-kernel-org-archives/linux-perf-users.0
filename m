Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988484;
	b=N61KNdF96M/jRj4qAc5BVj1xRj7RYjNLJgCq/SDvikQx9TzsXG95XGJk7IvXB/7X0tIV
	 AkSNu9Zuum32WKjUfM8GTpasZKlaDQTSkzih5m8rR7UGJycyNXQ6WzWL8hv5EKK2ssxl4
	 JHX3FuMfHA6Liy3hBjucr9m0AcPccYySHIcfDx25JmEu3K9uPr8lOasAWx+9E6Sd/JY7F
	 JZ2iDaDCEcA3D28GY4VIJhewKrl4yxhcbWSs0WohouGk8dsIK57IKjDREnD1Lapc3fIe0
	 t+SRuwcuUEX4KqGuijScRulqxvlzf5bYx6a5W0X/Cy4JxR5fBjaz+hZNhjTQX4dNO3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988484;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vt9Kamb5mjCKUOITfYlUppbcMdonIvPB5a8sUjW+bWQ=;
	b=hd2CnGxO7a3M+mruaLfoZL2ZgrC27r0rlpDXhoqbJuQ2e5VBmpsX1E5afA2gOZpTFhMH
	 XNzQOAtmJH51X9Iwi73hDgiTg9m+FCE9kzOKQ2e+YX/ZoCb6duFCr1K6INtTL2sUmhtCM
	 YQaHnUO3yarUJ2ea4zm+eGxzrBYKGy3Sc7dASJ5XzPS8K6q0ZoMZb4Bw460FublemaJaP
	 RfoszlADXDNztgrIvOxP5GXfP9CAv+h7mdjLpxAy3D+UbJtIa6v1csZtjVDJOQkf06Le7
	 GeX4RISzfdnScAcSpS0GW4SNA3SvOXf8VlEyVGtoDBj/y8ocSJvJblu7Xz7ZBkHhUpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XqNhcFlq;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715966083601
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 715966083601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XqNhcFlq
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D63D41692;
	Fri,  6 Nov 2026 10:08:00 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E6D03F673;
	Fri,  6 Nov 2026 10:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793988483; bh=FiLcr2bqRGNHwPqNhuLmcaRcjFrBKNMOb6axv3mSzXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XqNhcFlqN0WCr6S7XhwkmUcBKgS3pU0Mk+Wax5ne0Lh4QfeHp/lNsB3OBA7j3kY9Q
	 RVFBNClELXOTcVvHhwXIyQFepk2oNHmZFe+ht5Y7+6yYq458ruFsbJ+mj17Iodwh+7
	 9BaVTQYOB8hEJIYBt0zZNIiWxNMIyrECIRv/htYo=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/4] perf/arm-bmu: Add Devicetree support
Date: Fri,  6 Nov 2026 18:07:46 +0000
Message-ID: <80f15ad90b1d1f447f072f6d9d82630f847379bf.1793986672.git.robin.murphy@arm.com>
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

Initial production BMU users will be ACPI-based, but DT consumers
will almost certainly come along sooner or later.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_cspmu/Kconfig   |  2 +-
 drivers/perf/arm_cspmu/arm-bmu.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index 48c2a3ac7fab..8ce05bbe6b9a 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -37,6 +37,6 @@ config ARM_SYSTEM_PMU
 
 config ARM_BMU
 	tristate "ARM Bus Monitor Unit"
-	depends on (ARM64 && ACPI) || COMPILE_TEST
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support perf event counting on Arm Bus Monitor Unit devices.
diff --git a/drivers/perf/arm_cspmu/arm-bmu.c b/drivers/perf/arm_cspmu/arm-bmu.c
index fe25954ac836..aa4ccbdae7a2 100644
--- a/drivers/perf/arm_cspmu/arm-bmu.c
+++ b/drivers/perf/arm_cspmu/arm-bmu.c
@@ -6,6 +6,7 @@
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -409,7 +410,10 @@ static int arm_bmu_probe(struct platform_device *pdev)
 		.read = arm_bmu_event_read,
 	};
 
-	name = acpi_device_uid(ACPI_COMPANION(dev));
+	if (has_acpi_companion(dev))
+		name = acpi_device_uid(ACPI_COMPANION(dev));
+	else
+		device_property_read_string(dev, "label", &name);
 
 	if (name)
 		name = devm_kasprintf(dev, GFP_KERNEL, "arm_bmu_%s", name);
@@ -440,6 +444,14 @@ static void arm_bmu_remove(struct platform_device *pdev)
 	cpuhp_state_remove_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpuhp_node);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id arm_bmu_of_match[] = {
+	{ .compatible = "arm,bus-monitor-unit" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, arm_bmu_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id arm_bmu_acpi_match[] = {
 	{ "ARMHB001" },
@@ -451,6 +463,7 @@ MODULE_DEVICE_TABLE(acpi, arm_bmu_acpi_match);
 static struct platform_driver arm_bmu_driver = {
 	.driver = {
 		.name = "arm-bmu",
+		.of_match_table = of_match_ptr(arm_bmu_of_match),
 		.acpi_match_table = ACPI_PTR(arm_bmu_acpi_match),
 		.suppress_bind_attrs = true,
 	},
-- 
2.54.0.dirty


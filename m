Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D0B42378E;
	Thu, 16 Jul 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214775; cv=none; b=KdxLxw5y9Z9NacxboSFEENHdNfP6DOsh2irh+MLlm/e237bi1ePgJiKEuhgLlxHPcl62btb/AXKOyvMT2er2SM/hdXj0nWKGH4UKmU2stiIbtxYk/k1SqLAtvH3j47LokDnhS8KabKdp7ar2s7KWMIK6ADP8n84Rwg7vTiFbLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214775; c=relaxed/simple;
	bh=75IJt8xi0ft2PtVtFIiaRDwCiHpcnI2pdT3cfH0WwMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tm0x+nwCYD48RCg4QRm1wD14bJJCHh8HR/78diImJasinREBmjTsknInkxFoVqm6ZxtWQBrA4NvJHnKLvMgUjohLbzKUAdaILwXZh6/+bpF1gNQqG0Rx1o+ol8zh5pGe9pPQ3dC5PuabSc8XlMbFmu9Wbeb7mf/d0qrklxUSc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mY1E+ecL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mY1E+ecL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD3C71691;
	Thu, 16 Jul 2026 08:12:46 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 204883F66F;
	Thu, 16 Jul 2026 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784214771; bh=75IJt8xi0ft2PtVtFIiaRDwCiHpcnI2pdT3cfH0WwMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mY1E+ecLK+EhIqTiLGD1Yt/XzW1X3G4V7nNVonQ1XBZEJawUbjHxTKsKWRcf7osgF
	 /YVlolAqR8+aXKQF/gXXs5wwwTwv4Y6PYrJd7nSKGEOxwX0xfBmG2mErFZblh4VqUm
	 37IDdrOIVcFesI00n4m35wg92ERD47IXl1+3CDX0=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] perf/arm-bmu: Add Devicetree support
Date: Thu, 16 Jul 2026 16:12:41 +0100
Message-ID: <c797080aaa2f51273267a24e256cab083e64b156.1784214112.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1784214112.git.robin.murphy@arm.com>
References: <cover.1784214112.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initial production BMU users will be ACPI-based, but DT consumers
will almost certainly come along sooner or later.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---
v2: Separate patch as it's not a critical dependency right now
---
 drivers/perf/arm_cspmu/Kconfig   |  2 +-
 drivers/perf/arm_cspmu/arm-bmu.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index 0cb369f91023..8a7e2082b850 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -30,6 +30,6 @@ config AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 
 config ARM_BMU
 	tristate "ARM Bus Monitor Unit"
-	depends on (ARM64 && ACPI) || COMPILE_TEST
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support perf event counting on Arm Bus Monitor Unit devices.
diff --git a/drivers/perf/arm_cspmu/arm-bmu.c b/drivers/perf/arm_cspmu/arm-bmu.c
index c829a0728e9b..0c2442392f7b 100644
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
@@ -406,7 +407,10 @@ static int arm_bmu_probe(struct platform_device *pdev)
 		.read = arm_bmu_event_read,
 	};
 
-	name = acpi_device_uid(ACPI_COMPANION(dev));
+	if (has_acpi_companion(dev))
+		name = acpi_device_uid(ACPI_COMPANION(dev));
+	else
+		device_property_read_string(dev, "label", &name);
 
 	if (name)
 		name = devm_kasprintf(dev, GFP_KERNEL, "arm_bmu_%s", name);
@@ -437,6 +441,14 @@ static void arm_bmu_remove(struct platform_device *pdev)
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
@@ -448,6 +460,7 @@ MODULE_DEVICE_TABLE(acpi, arm_bmu_acpi_match);
 static struct platform_driver arm_bmu_driver = {
 	.driver = {
 		.name = "arm-bmu",
+		.of_match_table = of_match_ptr(arm_bmu_of_match),
 		.acpi_match_table = ACPI_PTR(arm_bmu_acpi_match),
 		.suppress_bind_attrs = true,
 	},
-- 
2.54.0.dirty


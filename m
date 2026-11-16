Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853358;
	b=r8ytkTrUPd9HUd+UP+gwp8WKDjwPu14PNNWem1x7sS93nl1jXLOrXraR9CEcXxKFchFC
	 jlTj5csIZZ28s9OhFiGqqSFpbA+tJj/eOta6Uz8uRX5QdrglGdvrG5fV6Exs7ZDy2dc5g
	 9/52Cs3tdSHvMUfeYimnRuj7ojPZBjlEk4wZhNLp5Bckdt1sIUsamG0/5gz6ixEraVQ78
	 7PUHGTYBd+Jr+O/BwKSXrcWhAhhFs703FnF1JYZ72uEaUMV3SOSjKGJO9ndj1qDCMwSxZ
	 nLvGHzntIg9g+FveKR/rGtQ/FXFXuld7oi4IHMG6EhLhBnJqMF88IMlbwfDsz8HywGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853358;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=2bZRBD0wre9l5Uxa72CBRjeS+PAIZqErv0ZXJe2eO5U=;
	b=RM+U7bozyH37EuZjzC4pcYMDfql6U5Qntiv/vznVdxU6nHLrk4k3uS2kGG/bVMtzbiEI
	 Xq3Hs3uhU2epFoUpJ4fhhcD19IKhRxksCBoKvarQNiFPL8BxIv5QAoGz2OpPOV6CdLa8S
	 dT//Z2M0ofLNk1Ed5wga4WzQXNDdRMwluM/cjTjIGVtCyxGMyINZCoYz4QRHEz5bKVx4b
	 Ovbfvz9L+3h7mUv/0cxywiTCc8Tnezkx3fR7HVUIPS4qJCfyTIm0k/633OWj3PwWnBdYS
	 CrXYBA+V92FASfvG2gRPyef9Q3EA6JMvabsvT1pLuduR/X6I5V8lnwqj2Nnta/aLCqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cus0c2qa;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC38606A884;
	Mon, 16 Nov 2026 18:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC38606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cus0c2qa
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D9261BB0;
	Mon, 16 Nov 2026 10:22:34 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61EDC3F632;
	Mon, 16 Nov 2026 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794853357; bh=Aq1hd5G15aLQCabTVDHrfLBjHUdHyPvPeCgENM9JxZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cus0c2qa2Ecxo+mz3w6U9I3zCheFuro12aVZ+5uKULdZQZpeKWWHXwMRXUg20kErT
	 FDbxvOLB12TXFVUrOs1kqBYIeHR9eeu/vQYt2mzI8xZbwShRbyJDyRBbqI0bozrr81
	 ugiu0+kQCoP0rvkUTME3+2QTomCc3WLuKAb3T+Qw=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 16 Nov 2026 18:21:33 +0000
Subject: [PATCH 6/8] perf/arm_pmu: Support ACPI devices in the platform
 probe
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
Message-Id: <20261116-acpi_arm_pmu_registration_hmp-v1-6-0371d4eca626@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794853327; l=2895;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Aq1hd5G15aLQCabTVDHrfLBjHUdHyPvPeCgENM9JxZw=;
 b=0Reaa4MK3RHMtWJ2Gcdtr4xhMwqc5ow3o5yOZzpav///I6ftHy1L2DMc0fSWDt296egC0/1Ga
 puiB9wFPJIcCHOXnBQhVp1Cf/as+M4OzW2q5EBhITjIv+bGUjDZqFBk
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add pmu_get_match_data() to select the initialization callback for DT
and ACPI devices. Use OF match data for devices with a DT node, and
match the platform device name against the existing compatible table
otherwise. This also handles devices described by software nodes.

Return -ENODEV when no initializer or fallback probe table is available.
Append the platform device ID to numbered PMU names, leaving unnumbered
DT device names unchanged.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_pmu_platform.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 1c9e50a13201528edf4cfbdc2504d305b49d4913..397fdb148dc9b6be083e654e091ecc6a95c4905b 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -20,7 +20,9 @@
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/slab.h>
 #include <linux/smp.h>
+#include <linux/string.h>
 
 static int probe_current_pmu(struct arm_pmu *pmu,
 			     const struct pmu_probe_info *info)
@@ -185,6 +187,23 @@ static void armpmu_free_irqs(struct arm_pmu *armpmu)
 	}
 }
 
+static const void *pmu_get_match_data(struct platform_device *pdev,
+				      const struct of_device_id *of_table)
+{
+	const struct of_device_id *match;
+
+	if (pdev->dev.of_node)
+		return of_device_get_match_data(&pdev->dev);
+
+	/* ACPI platform devices use a compatible string as their name */
+	for (match = of_table; match && match->compatible[0]; match++) {
+		if (!strcmp(pdev->name, match->compatible))
+			return match->data;
+	}
+
+	return NULL;
+}
+
 int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table)
@@ -205,7 +224,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	if (ret)
 		goto out_free;
 
-	init_fn = of_device_get_match_data(dev);
+	init_fn = pmu_get_match_data(pdev, of_table);
 	if (init_fn) {
 		pmu->secure_access = of_property_read_bool(dev->of_node,
 							   "secure-reg-access");
@@ -220,6 +239,8 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	} else if (probe_table) {
 		cpumask_setall(&pmu->supported_cpus);
 		ret = probe_current_pmu(pmu, probe_table);
+	} else {
+		ret = -ENODEV;
 	}
 
 	if (ret) {
@@ -227,6 +248,16 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		goto out_free;
 	}
 
+	/* Append instance suffix (for only ACPI devices) */
+	if (pdev->id >= 0) {
+		pmu->name = devm_kasprintf(dev, GFP_KERNEL, "%s_%d",
+					   pmu->name, pdev->id);
+		if (!pmu->name) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+	}
+
 	ret = armpmu_request_irqs(pmu);
 	if (ret)
 		goto out_free_irqs;

-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792548210;
	b=bQt1NqJHiGZ1+4HhYjMrX7hn3Z0EvQiXR+ZR301oPsQZzdnfkGBZ3/Tgtbvee8v+tagW
	 tcCBW91X+aC6GudW440/xYAiyK9XxNXgdur+hYFSjXt8Dh+AkeD2u/l8o8KYzv5F9Rb51
	 TKRCb4UOVXlqX+d4UcAufXL0vQw7QjCRLAW3rtFAgXNAFKuiU8NiB9KC0LmXZFymyMjg1
	 l3ric4PhXPUY0bLpe2fZIYmYMIfx8cQ4O/VQJSc7GccUsohC4dFexqvWErXHtFrZLiQwQ
	 8cH+fpyEjIMzv5guJ2eaF/710CcQ1LQNwEGCnmSj8YIuE0sW/y+XpbbxoEySDEoxbDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548210;
	h=DMARC-Filter:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=63deBN37HyGnBdz2VbLL7TIdfIKQaXzHMle1MyqgFYw=;
	b=pdrURLs0Dg+wshguYYSBj5r4xJce659F/08Ij8N1WpM+UlR9mkgHA08ZNMZSSSWrpw9u
	 cNIR7x2uR5i32W5f098AMIbhJ6uWaN7oxbnAspaoe20d0Aw7NkVS9xzlJkTu0C4JVN8XR
	 MPc88xVJdP6LDi1imCc+qfujN8yPswXsY5YVS4DZDyY0+AygK+RZ56myMZuEGDKnt/S1O
	 7w8lsMAI43U3ktQgHhDyX9t69MM7cwiKGdQEr6aVnVa3wn77JN++QaXgeGJincHKf1gfF
	 UeUSi/LYUiZl9VUZeUhya8RKvlE8/SKQjak9N7dBBttnSwIMrFAS5SsrEdpUNbD28lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=cixtech.com;
	spf=pass smtp.mailfrom=cixtech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.136
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022136.outbound.protection.outlook.com [52.101.126.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5414606A31A;
	Wed, 21 Oct 2026 02:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5414606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyFEtMOrbNGxbwAiPGXfxDl/gpzmbmNtsglxvVV7Rt/W6Q7kdQOhwAHifnjFx2PiHV6mt1WEiSpj00vnKwuNjRCvbpcbRdUVRCil9k1Adl8XVS3FGXpCc1y/XFrWYa6WHSJnB3ZJOqD/zkmMVUnLRrLGgiHOS+scFgMtu9nmcOePNMpRCAvQcDG06YbngEGkO7oHsJ9Zt78086s7KhRYWcUl/RxDYcHsG6LspzB+jFmrvzvbFBMHJ8oKRyYqSFiMpH8WRyffZ2X2xtntFR2I/sQ7TZlsNjEEXA4+ccM65/TxSKvdtg+CfjUXcvIepQPEDUJB9Elsfr5yVdNIoh1dBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63deBN37HyGnBdz2VbLL7TIdfIKQaXzHMle1MyqgFYw=;
 b=tZI/7rmEEl3nVFRfRjXKYKszRnmNLDQRm31S3pbHg3OC6K2prkdk2LXx3NseDu95f3VWqEssWnfKOjh+aBqwOf5LWVhg6xwcKNdpqtyETHacY+b6BbIkHtdb5TdqKeVtwJi4hTxcfeQsg54wl7ir/3pz5wT+lLM3Y3kxo+sb1PHBZ8wwOrJeB+gQXvkZcXfAv2zBDKgL9hA5uvu4RszsB42YlWt06JYFE4M1bUAyZ088O+LNwNcE+DT4K9RnqZycoipHJk4dAe8uCwnHdP1BG0oh2pFMQ9us0KjLNlhMSjeQHwV9AwWLEfmFML3zMHW26j07xea+McmDZ3yQHRaULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SE2P216CA0076.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2c6::10)
 by PUZPR06MB5617.apcprd06.prod.outlook.com (2603:1096:301:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:03:25 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:101:2c6:cafe::a9) by SE2P216CA0076.outlook.office365.com
 (2603:1096:101:2c6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 02:03:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 02:03:23 +0000
Received: from JohnnyFan (unknown [172.21.64.24])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 259504102B42;
	Wed, 21 Oct 2026 10:03:23 +0800 (CST)
From: "Johnny.Fan" <johnny.fan@cixtech.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	mike.leach@arm.com,
	james.clark@linaro.org,
	leo.yan@arm.com,
	maz@kernel.org,
	jeremy.linton@arm.com,
	cix-kernel-upstream@cixtech.com,
	bob.zhang@cixtech.com,
	jie.fu@cixtech.com,
	"Johnny.Fan" <Johnny.Fan@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v2] perf: arm_spe: Support heterogeneous ACPI systems
Date: Wed, 21 Oct 2026 10:03:22 +0800
Message-ID: <20261021020322.3015121-1-johnny.fan@cixtech.com>
X-Mailer: git-send-email 2.55.0
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|PUZPR06MB5617:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2b16cb46-8d78-4e7a-6513-08df2f177d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|82310400026|36860700016|1800799024|56012099006|261009223027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VAf+VF04zqgoh0LMmN2JrtcO8y4DmVszmVHdSlbya9rryqLf8G6MBgWEhZLgZGHdAhJuCtGTwn677LTsg0r8CS+gqUX9bsJF/njQETTrL5bcnvL4b6usvhsl36CyaRG1/1c7wgDVQHm02ktLgQTUTazbf7pAfILHOgHd+FGu+PeLvnHic2RqKJRNXFhjwMSbAAuRtg6p5r4rx/uwCe4535o9B6/WN5bGmv3JwNF0Ff/620dVXzMp7KGK+OUZKtdOu2E8/hPjCA+7y0DxmT29UV80PD+fs4Hx6axRYbSyFiJAxlQNPzM4hBO1Fyla3vS0lhs2IA5jCIIyUK1jn8zoOFCIpk+nkGuXZH4ITMrakMQEQRiJSsf8OW6tL7jA/pN4yAX9nNNtMirfnNBKA75PYEBYrmXsBnEl2JTBYiwZJNeJq9w2e1aXIzLUyUAqb+40wFxw7ZeqLYQVIkVMK27t2v0PZotUVz5LVvny5oiS4ASMTpbN+IAsdeJ3E7VIf1kFSSWxx1nIH4OLcs+2uxr7wlR4sSKiRzrC41U3NqIaLi0YPFJDKXxX0NZOjzFvaX+Wn6XJWcykT/rfulb3hCgOPBLfu2S8ouJ0Z1jxgNxvKNf8OQnndaaPZJ4f1e4YfagfLlqh+VLZLOotpCPZPqWYiplsHSaKhvXyw3JDeB66hvwoDxYAaYp38xhV+JxomJ57K5BT6wO7A7fFDr+NBQ5pMw==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(36860700016)(1800799024)(56012099006)(261009223027099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dkxrAa00asHRNwsazLnN1gFLLSUY7pRWfY0pbraWa5USJ/GjJo9ZWBXBWpMkapgOydUMm5abj1+l4sqq60SPHnngUM2gEZakj4uXkerHg0Rz0N6nWLpVsm3j3wrEAxMUZoKvQcT2Ji/aYgPHX06kZUXQz5+SHgwjTBn+zHAKOVrfXIEZHoxYOhJyzn0T5uUN7WzmQgb0FQNNrJRmB2A2uF3bWm15JKuAM9ZmOm44Io9PuTFIXWaWKRi9dWJteZ7yF+zfvspmJL0SPcX0OPG68QpNKizmTK7vr8dRWIphWXCm1m9Ejx29fsxUyhVxQnxjVVgQ2STbjfKbvLlUPa3wA7vhQp2IRLgexMLPimRgSDptMz65oUXL9vi5lZLSY409vAKDvj/HJv0ZA3+9akf37xFhKEzkObtzsd3YWXuKpKzuxz5hexSFkLI3PJ4CKQg7
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:03:23.8994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b16cb46-8d78-4e7a-6513-08df2f177d2b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5617

From: "Johnny.Fan" <Johnny.Fan@cixtech.com>

On heterogeneous ACPI systems, not all CPUs implement SPE, and the
ones that do may use different PPIs. The MADT describes this per
GICC entry: a CPU without SPE reports a zero SPE overflow interrupt,
and the PPTT hetero id identifies CPUs of the same implementation.

The current code registers a single platform device and gives up if
the GICC entries disagree on either the hetero id or the interrupt,
so SPE is unavailable on such systems even though the firmware
describes it.

Group the CPUs by (hetero id, SPE interrupt) and register one
platform device per group. A GSI may be shared between groups with
non-overlapping CPU masks, so only unregister the GSI mapping when
no other group uses the same interrupt, as the mapping is not
reference counted.

These synthetic devices have no fwnode, so the firmware-described
IRQ affinity cannot tell which CPUs implement the feature. Pass the
CPU mask as platform data and have the drivers prefer it over the
IRQ affinity when present.

Apply the same treatment to TRBE, which shares this registration
code. TRBE must also pass a stable copy of the mask to
request_percpu_irq_affinity(), since supported_cpus is pruned as
CPUs are probed.

Tested on a CIX sky1 SoC with heterogeneous SPE support.

Signed-off-by: Johnny.Fan <Johnny.Fan@cixtech.com>
Reviewed-by: Fugang Duan <fugang.duan@cixtech.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c |  22 +-
 drivers/perf/arm_pmu_acpi.c                  | 211 ++++++++++++-------
 drivers/perf/arm_spe_pmu.c                   |  10 +-
 include/linux/perf/arm_pmu.h                 |  10 +
 4 files changed, 176 insertions(+), 77 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index c7cbca45f2de..0c4bc8fbcaf3 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -158,6 +158,7 @@ struct trbe_drvdata {
 	struct hlist_node hotplug_node;
 	int irq;
 	cpumask_t supported_cpus;
+	cpumask_t irq_affinity;
 	enum cpuhp_state trbe_online;
 	struct platform_device *pdev;
 };
@@ -1533,6 +1534,8 @@ static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
 static int arm_trbe_probe_irq(struct platform_device *pdev,
 			      struct trbe_drvdata *drvdata)
 {
+	const struct arm_pmu_acpi_dev_data *acpi_data =
+		dev_get_platdata(&pdev->dev);
 	const struct cpumask *affinity;
 	int ret;
 
@@ -1547,14 +1550,27 @@ static int arm_trbe_probe_irq(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	cpumask_copy(&drvdata->supported_cpus, affinity);
+	/*
+	 * The ACPI path has no fwnode describing which CPUs implement TRBE,
+	 * so it passes the mask explicitly. DT devices still use the
+	 * firmware-described IRQ affinity.
+	 */
+	cpumask_copy(&drvdata->supported_cpus,
+		     acpi_data ? &acpi_data->cpus : affinity);
+
+	/*
+	 * supported_cpus gets pruned as CPUs are probed, so keep a stable
+	 * copy for the IRQ action.
+	 */
+	cpumask_copy(&drvdata->irq_affinity, &drvdata->supported_cpus);
 
 	drvdata->handle = alloc_percpu(struct perf_output_handle *);
 	if (!drvdata->handle)
 		return -ENOMEM;
 
-	ret = request_percpu_irq_affinity(drvdata->irq, arm_trbe_irq_handler, DRVNAME,
-					  affinity, drvdata->handle);
+	ret = request_percpu_irq_affinity(drvdata->irq, arm_trbe_irq_handler,
+					  DRVNAME, &drvdata->irq_affinity,
+					  drvdata->handle);
 	if (ret) {
 		free_percpu(drvdata->handle);
 		return ret;
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index ca6bf8f86cfe..fdf39673648f 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -12,6 +12,8 @@
 #include <linux/irqdesc.h>
 #include <linux/percpu.h>
 #include <linux/perf/arm_pmu.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -68,91 +70,165 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
 		acpi_unregister_gsi(gsi);
 }
 
-static int __maybe_unused
-arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
-			     u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
+struct arm_pmu_acpi_group {
+	int hetid;
+	u16 gsi;
+	struct cpumask cpus;
+};
+
+static int arm_acpi_find_group(struct arm_pmu_acpi_group *groups, int nr_groups,
+			       int hetid, u16 gsi)
 {
-	int cpu, this_hetid, hetid, irq, ret;
-	u16 this_gsi = 0, gsi = 0;
+	int i;
 
-	/*
-	 * Ensure that platform device must have IORESOURCE_IRQ
-	 * resource to hold gsi interrupt.
-	 */
-	if (pdev->num_resources != 1)
-		return -ENXIO;
+	for (i = 0; i < nr_groups; i++) {
+		if (groups[i].hetid == hetid && groups[i].gsi == gsi)
+			return i;
+	}
+
+	return -1;
+}
+
+static bool arm_acpi_gsi_is_shared(struct arm_pmu_acpi_group *groups,
+				   int nr_groups, int idx)
+{
+	int i;
+
+	for (i = 0; i < nr_groups; i++) {
+		if (i != idx && groups[i].gsi == groups[idx].gsi)
+			return true;
+	}
+
+	return false;
+}
+
+static int arm_acpi_register_group(struct arm_pmu_acpi_group *group,
+				   const char *name, bool gsi_shared)
+{
+	struct arm_pmu_acpi_dev_data data = { };
+	struct platform_device *pdev;
+	struct resource res;
+	int irq, ret;
+
+	irq = acpi_register_gsi(NULL, group->gsi, ACPI_LEVEL_SENSITIVE,
+				ACPI_ACTIVE_HIGH);
+	if (irq < 0)
+		return irq;
+
+	pdev = platform_device_alloc(name, PLATFORM_DEVID_AUTO);
+	if (!pdev) {
+		ret = -ENOMEM;
+		goto err_unreg;
+	}
 
-	if (pdev->resource[0].flags != IORESOURCE_IRQ)
-		return -ENXIO;
+	res = DEFINE_RES_IRQ(irq);
+	data.cpus = group->cpus;
 
+	ret = platform_device_add_resources(pdev, &res, 1);
+	if (ret)
+		goto err_put;
+
+	ret = platform_device_add_data(pdev, &data, sizeof(data));
+	if (ret)
+		goto err_put;
+
+	ret = platform_device_add(pdev);
+	if (!ret)
+		return 0;
+
+err_put:
+	platform_device_put(pdev);
+err_unreg:
 	/*
-	 * Sanity check all the GICC tables for the same interrupt
-	 * number. For now, only support homogeneous ACPI machines.
+	 * The GSI mapping is not reference counted, so only drop it if no
+	 * other group shares it.
 	 */
+	if (!gsi_shared)
+		acpi_unregister_gsi(group->gsi);
+
+	return ret;
+}
+
+static int __maybe_unused
+arm_acpi_register_pmu_devices(const char *name, u8 len,
+			      u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
+{
+	struct arm_pmu_acpi_group *groups;
+	int cpu, i, nr_cpus = 0, nr_groups = 0, nr_devices = 0;
+	int last_err = 0, ret;
+
 	for_each_possible_cpu(cpu) {
 		struct acpi_madt_generic_interrupt *gicc;
 
 		gicc = acpi_cpu_get_madt_gicc(cpu);
 		if (gicc->header.length < len)
-			return gsi ? -ENXIO : 0;
-
-		this_gsi = parse_gsi(gicc);
-		this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
-		if (!gsi) {
-			hetid = this_hetid;
-			gsi = this_gsi;
-		} else if (hetid != this_hetid || gsi != this_gsi) {
-			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
-			return -ENXIO;
-		}
+			continue;
+		if (parse_gsi(gicc))
+			nr_cpus++;
 	}
 
-	if (!this_gsi)
+	if (!nr_cpus)
 		return 0;
 
-	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
-	if (irq < 0) {
-		pr_warn("ACPI: %s Unable to register interrupt: %d\n", pdev->name, gsi);
-		return -ENXIO;
-	}
+	groups = kcalloc(nr_cpus, sizeof(*groups), GFP_KERNEL);
+	if (!groups)
+		return -ENOMEM;
 
-	pdev->resource[0].start = irq;
-	ret = platform_device_register(pdev);
-	if (ret)
-		acpi_unregister_gsi(gsi);
+	for_each_possible_cpu(cpu) {
+		struct acpi_madt_generic_interrupt *gicc;
+		int hetid;
+		u16 gsi;
 
-	return ret;
-}
+		gicc = acpi_cpu_get_madt_gicc(cpu);
+		if (gicc->header.length < len)
+			continue;
 
-#if IS_ENABLED(CONFIG_ARM_SPE_PMU)
-static struct resource spe_resources[] = {
-	{
-		/* irq */
-		.flags          = IORESOURCE_IRQ,
+		gsi = parse_gsi(gicc);
+		if (!gsi)
+			continue;
+
+		hetid = find_acpi_cpu_topology_hetero_id(cpu);
+		i = arm_acpi_find_group(groups, nr_groups, hetid, gsi);
+		if (i < 0) {
+			i = nr_groups++;
+			groups[i].hetid = hetid;
+			groups[i].gsi = gsi;
+		}
+
+		cpumask_set_cpu(cpu, &groups[i].cpus);
 	}
-};
 
-static struct platform_device spe_dev = {
-	.name = ARMV8_SPE_PDEV_NAME,
-	.id = -1,
-	.resource = spe_resources,
-	.num_resources = ARRAY_SIZE(spe_resources)
-};
+	for (i = 0; i < nr_groups; i++) {
+		ret = arm_acpi_register_group(&groups[i], name,
+					      arm_acpi_gsi_is_shared(groups,
+								     nr_groups, i));
+		if (ret) {
+			pr_warn("ACPI: %s: %*pbl: add device failed (%d)\n",
+				name, cpumask_pr_args(&groups[i].cpus), ret);
+			last_err = ret;
+		} else {
+			nr_devices++;
+		}
+	}
+
+	kfree(groups);
+
+	return nr_devices ? 0 : last_err;
+}
 
+#if IS_ENABLED(CONFIG_ARM_SPE_PMU)
 static u16 arm_spe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
 {
 	return gicc->spe_interrupt;
 }
 
-/*
- * For lack of a better place, hook the normal PMU MADT walk
- * and create a SPE device if we detect a recent MADT with
- * a homogeneous PPI mapping.
- */
 static void arm_spe_acpi_register_device(void)
 {
-	int ret = arm_acpi_register_pmu_device(&spe_dev, ACPI_MADT_GICC_SPE,
-					       arm_spe_parse_gsi);
+	int ret;
+
+	ret = arm_acpi_register_pmu_devices(ARMV8_SPE_PDEV_NAME,
+					    ACPI_MADT_GICC_SPE,
+					    arm_spe_parse_gsi);
 	if (ret)
 		pr_warn("ACPI: SPE: Unable to register device\n");
 }
@@ -163,20 +239,6 @@ static inline void arm_spe_acpi_register_device(void)
 #endif /* CONFIG_ARM_SPE_PMU */
 
 #if IS_ENABLED(CONFIG_CORESIGHT_TRBE)
-static struct resource trbe_resources[] = {
-	{
-		/* irq */
-		.flags          = IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device trbe_dev = {
-	.name = ARMV8_TRBE_PDEV_NAME,
-	.id = -1,
-	.resource = trbe_resources,
-	.num_resources = ARRAY_SIZE(trbe_resources)
-};
-
 static u16 arm_trbe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
 {
 	return gicc->trbe_interrupt;
@@ -184,8 +246,11 @@ static u16 arm_trbe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
 
 static void arm_trbe_acpi_register_device(void)
 {
-	int ret = arm_acpi_register_pmu_device(&trbe_dev, ACPI_MADT_GICC_TRBE,
-					       arm_trbe_parse_gsi);
+	int ret;
+
+	ret = arm_acpi_register_pmu_devices(ARMV8_TRBE_PDEV_NAME,
+					    ACPI_MADT_GICC_TRBE,
+					    arm_trbe_parse_gsi);
 	if (ret)
 		pr_warn("ACPI: TRBE: Unable to register device\n");
 }
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b70f3fedf028..712b7f187301 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1330,6 +1330,8 @@ static void arm_spe_pmu_dev_teardown(struct arm_spe_pmu *spe_pmu)
 static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
 {
 	struct platform_device *pdev = spe_pmu->pdev;
+	const struct arm_pmu_acpi_dev_data *acpi_data =
+		dev_get_platdata(&pdev->dev);
 	const struct cpumask *affinity;
 	int irq;
 
@@ -1342,7 +1344,13 @@ static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
 		return -EINVAL;
 	}
 
-	cpumask_copy(&spe_pmu->supported_cpus, affinity);
+	/*
+	 * The ACPI path has no fwnode describing which CPUs implement SPE,
+	 * so it passes the mask explicitly. DT devices still use the
+	 * firmware-described IRQ affinity.
+	 */
+	cpumask_copy(&spe_pmu->supported_cpus,
+		     acpi_data ? &acpi_data->cpus : affinity);
 
 	spe_pmu->irq = irq;
 	return 0;
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 02d2c7f45b52..7f1c03c55025 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -8,6 +8,7 @@
 #ifndef __ARM_PMU_H__
 #define __ARM_PMU_H__
 
+#include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
@@ -199,6 +200,15 @@ void armpmu_free_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu);
 #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
 #define ARMV8_TRBE_PDEV_NAME "arm,trbe"
 
+/*
+ * Per-device CPU mask passed by the ACPI MADT walk. The synthetic
+ * platform devices have no fwnode, so the IRQ affinity cannot describe
+ * which CPUs actually implement the feature.
+ */
+struct arm_pmu_acpi_dev_data {
+	struct cpumask cpus;
+};
+
 /* Why does everything I do descend into this? */
 #define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)				\
 	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793608920;
	b=l5MnsWIW4HY7mCfPK4d3oRcttU6tr/VQYhaT6KE9sWUCR3nO7ah796GveYdAOJiSGS2s
	 VbpEwlkUEOORItErPGGrsEC0Oqm5sUu/RP6IUips0JQW/ZxeCzUg+5gVAUQ3Mzu3Lfd5o
	 lukqb9Kc0qEHzmG2KFy7OKZCoGWUy31AQ0Fj1Uh90TUJRzmAkKNWHJhb5GVlxS/xOnEjt
	 YeeXu89WVUf6Bnb+osMsTZ3RL5ZFyyFnt5etX6bU+ua4CTcIVOuWs4gtBgdqn05JNklU3
	 a28SQFKqB8aFPFwNWbj5k6OQ2Z5J3GoyzTYrYbjpvYPpYfTg8l27xAWMQwec6f+RErA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608920;
	h=DMARC-Filter:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	bh=K/VuNAFvyH2RzF9VWtc5C4dx7BhXxQLtuGzqwhLuChE=;
	b=JxLCzRfeeQQisK+gFyYyOf4FtQxcimK/xrHz1TgPhDCwtT6ntdy52QKHhpPyB1k1hH+A
	 Ect9tq15u2UvOvAr3hs/rcOHwvuyxwBLRhuLozd//Hr7Q0bdKcspTX7hPhwvGulPUVY/W
	 9Ndfm7iQPXE31ze6fhpVZre4CK0yQ1ts4lW/2oW7iPCXfSqHU/H375QFJPRHDMpn4vPzB
	 5kEhgKFo1Wk3IWkXnAXDXWRwhEbKZ7l+i9r1RHp5as3OQ4EuGhwDj/mOutyaO1A553cPi
	 Wt94ReT9xjG+vmLa7OTbeowNG6OIMFnxo6EdKBWmGKRnIPQ6ICAX5VB+Vvc1tPCtzXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=cixtech.com;
	spf=pass smtp.mailfrom=cixtech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.77
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022077.outbound.protection.outlook.com [52.101.126.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D4606A326;
	Mon,  2 Nov 2026 08:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C5D4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt5djTDr+hkPJUoMFZfsQPzViYERXrw/3qqXI4YRHiTuSanrahnvf72rz47JEoNCKQjmV8EhbNyooYW0qsA7b3PSw2lIKUPOStL/voXkDJwMz1n4t+Gwq1kLtxpJNnngLCBkbHJLB36jNasgy0J1AeshHrpcwlS/L+SEP+kcdAigLKbdgQ/roZ6yb0y5VejDNXx0Wpt2SBzWFc/D7Lgtv2uRsJAzeYCsjewzpF+lw9+ekX8ZgC7hnoRhLnlDW5eXUa/l8RX20TZbQJJMfp8kPAuAYAJOKJHBShIcLgtMlsPoJFUwHvFC6ehm52rkUHDyxvhyzyb+kmZIVfah7NejAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/VuNAFvyH2RzF9VWtc5C4dx7BhXxQLtuGzqwhLuChE=;
 b=g7xsuFDfwsls+MKc2KRzgt7A1Gmk77GmXFGVY8pDyTsVRYpZ981A659bKTNkeUKW7tqGDGdbu5OtnzXirDsTYSlQ1p91pl5Cc/H8A80ufq1hXZZS5RckvqaOsFwihHAoEVkgcbHe8IVdmLqEYQl8PFoj5FDcjpkG2IybrreLUtr+whReiVJStUnh8T1fMpwOsPUKxRLyYECJ8QEJYll98dTxjp9uVFx3gARrVzcoxf1swHAUU1hVioLbISW1f97nMCLT7kGa47vXYVXKST3OyMv0i5hjQOaaguV3pE7wgECHff7wlldysOOx9hTGlxljHohBQ9yGPk2QJ2snDOUX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0031.apcprd02.prod.outlook.com (2603:1096:4:195::16)
 by PUZPR06MB6005.apcprd06.prod.outlook.com (2603:1096:301:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 08:41:55 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:195:cafe::27) by SI2PR02CA0031.outlook.office365.com
 (2603:1096:4:195::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 08:41:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 08:41:54 +0000
Received: from JohnnyFan (unknown [172.21.64.24])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A2D5E40920E1;
	Mon,  2 Nov 2026 16:41:53 +0800 (CST)
From: "Johnny.Fan" <johnny.fan@cixtech.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	jeremy.linton@arm.com,
	maz@kernel.org,
	mike.leach@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	jie.fu@cixtech.com,
	bob.zhang@cixtech.com,
	"Johnny.Fan" <Johnny.Fan@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v3 1/2] perf: arm_pmu: Accept a per-device CPU mask from platform data
Date: Mon,  2 Nov 2026 16:41:51 +0800
Message-ID: <20261102084153.3975282-2-johnny.fan@cixtech.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102084153.3975282-1-johnny.fan@cixtech.com>
References: <20261102084153.3975282-1-johnny.fan@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|PUZPR06MB6005:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed9b2e39-3567-4e39-dfbd-08df38bd2641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|56012099006|261009223027099003|261021123027099003|261021121427099003|261022075727099003|261026121527099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9+o1zi7ovHGVcjb45h/Q5LYn6VRNS7jJvnP3ejEb04evW7+/dtu3oJku8gG7kAvPA62q3N4wkvR9nqNo39tB5xhQNvkpBPtGObZ6+a9e8iYKEKUKKHXfRhWbBHN5KI7ZyexAZAucVqlReKm/mKlmGdjPYmDEhaoWvAUDy494SsJ3nV3KEVTFLP1f2oQr+5cahargg1lTD/KZNOAil3zVj+ltQK06zUt/eMRaFCQjH33g5PBBKZ/s2TW7/IK1T0bs2n2VRk9PnBClz0dXt9UJq+w6xyqRxkiQJB/vciI/TjQWbos1Sw8d+0d+rZeoG7EzblJQH9QAfRvo97UFII/liFhY/w8b7QRnPAICbkjHaJSwG+KP5eX7CTgD4OWHvbsdZZm4bv5Gr9PWrPU7ubN0c4E0JDcbAG4vXG1bw1qf6LcjvhnbsIHziruHJXwt+vEU9RkMAkPPryqiJKlqnaeSjk4n1L0FZe687jO69jmM2rJY5hPp5rhzhmI/E+wGzEbchpGHLJN46GvpDefWJ/Ti0grdoxYUya7/rA8utLqfJbH77Lf4VlFGKascrrZS+vqYJLAPqLsz4e4pJHZILV4S+HDdQRxuJZzN04G+TB5sh5k2IyGm3OyDvy72W6d3c5vSQnuoBBETE00XYBQO23o2A2b+HaqZEt1rhpzFIpgAm/k6HvtXvb1rZH1cKT9LdIOI4aKjQWH/wwUV7D6dnJzdSA==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U/PEmN3Po6l/7JG/vEQUUYaEgYdZUGFBARH3URFMtYwH4RIB5R+GvtZipQWiRh4pi6EYhmvvb/DPTKmCqAOg/D6ltRDxY8U+i0XCuFEc7m13NtMabH0JMf4/NPkBA29dfmNVvpKVMpvgQvIi2lvShhsD1qMiQr/1NUqkbiV9dYNxjUcRtjZ/7S3G5hkWi9bxb19ZgwWhqgnj8utcue/CAtia8NiBjDwMJ8Ahp3JKSkVPRRfwvkkcJI7Jh4cAPzKt6s70eoh9eZ5aJHDGzMRVrRjrUxuEKed2jVyg3xe42AVp0lTuJmmH3x20ldq93ReLWqBujSCLsF8EtQrogOc8wKHVrRBLMJSWQf3cg7YdzfuT6J/U8hUMC9dXZTs7RTqshDRnNbR71038yTTqjT4usLOWmqgV9xv26kFk1WVJi9zz2a8seVeEahkPnOL6ha1c
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:41:54.6297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9b2e39-3567-4e39-dfbd-08df38bd2641
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6005

From: "Johnny.Fan" <Johnny.Fan@cixtech.com>

Synthetic platform devices created from ACPI data have no fwnode, so
platform_get_irq_affinity() cannot tell which CPUs implement the
feature and falls back to cpu_possible_mask.

Add an optional CPU mask to the platform data and make both the SPE and
the TRBE drivers prefer it over the firmware-described IRQ affinity.
Device tree devices have no platform data and keep using the affinity.

TRBE must also pass a stable copy of the mask to
request_percpu_irq_affinity(), because supported_cpus is pruned as CPUs
are probed, while the IRQ action keeps a pointer to the mask.

This is a preparatory change: no ACPI device carries platform data yet,
so behaviour is unchanged.

Signed-off-by: Johnny.Fan <Johnny.Fan@cixtech.com>
Reviewed-by: Fugang Duan <fugang.duan@cixtech.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 22 +++++++++++++++++---
 drivers/perf/arm_spe_pmu.c                   | 10 ++++++++-
 include/linux/perf/arm_pmu.h                 | 10 +++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

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


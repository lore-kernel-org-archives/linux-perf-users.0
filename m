Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793608920;
	b=G+BSG4uz8iWdwEv5VyZNlM7vqrHreJRPKRitAjiTc1uY7rbOLo45xvDAM9bT98jt2FKX
	 C+/gYaNKe37yCSDv+MsxnEJ+0iEQH6dhE7856X6hD1ZBW2zS0BHrqhajj51NzR/9kiT81
	 WFRLM/Phqb5wKNH410AwnVxEnWFJNTUWNY0RMfe8FXJXB9psKgcap2LZ1RIh8YfbF4FT4
	 +KgMnNKD2eDSyCgOKJ6wWvkgvJDZ0jgB0x1xTv7fuaw2MBzJUQJHP5JXmDLrfwssd4Av+
	 H7/lGpP8jByEcV61AbD1enQPG1AMTbEpNNp9qedamASmcLraqJ+zc0bBw+xP2T0g7rg==
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
	bh=9qzDgUCXrz4JKwbBbc9TcKJRoM2FELG/m/U+XEzH/68=;
	b=ovR++lPM4gdEjC7hN+0hkFRaIJnnLlcR413J8itQnmbUqOH0tfDOwD35yRINs5PnWk9c
	 Idno06QPdFD+XJ03yKtbdi8dH7oeK5gz0k4Way7ZwyCTctmvMs9Ltl35WEW5TrJOwM+OO
	 zhjpSldfO2jF3AeNUe1J9q2uDWXUNpIQ5OfJDkKlKBuqTbnGoDw2M5A5obwZX4ra4mxoM
	 dvCa7U4YBcjyzu5uKvppgTrR2+I0+VS8W6Mn7ThNBzwMTLUXJKiusg+R43rHbJOUWMEgg
	 qJHek3La9U7i+Ylh3+joRemnsoRpT4BvIrc4n3T9MryYAT/papwNaPk8U81Fsyu2a3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=cixtech.com;
	spf=pass smtp.mailfrom=cixtech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.83
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022083.outbound.protection.outlook.com [52.101.126.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B808606A329;
	Mon,  2 Nov 2026 08:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B808606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCVxwcCRaDa+yit29YfRTnvZEKB5Kzzm7867sNHDhzfdJCIKzW+3m+2CGiywfMV9W/omo0gunm6T7VwXLG1Xj5IOqAAQPnWWbFXcH1/nF9vKcELox52OIEGlYmmumt6VRJ9cJr/rzg0ld6656kt7SBSQ0+G4y+oJKTVZ5irmEyMfnJk0gZ1in78BTMkiYCYFhYt3+o5hNRbSYlo0/yaPR0CVoOLBmaDJcokBt/eh/8ONnW6wTb6X2pYcQmU0+gx2UbBBy17iFlKu3T6ODN5wa0AXaAGEnvvmSENJEpTGr65CdW5otbY9FlXyj5iqYF/Wg8s7OX5bItYt6Io7+iV4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qzDgUCXrz4JKwbBbc9TcKJRoM2FELG/m/U+XEzH/68=;
 b=aJ//lECZWI8OzwpiQYqJcRp/E42utB5XKsCKeOIJRYK5p8pWfYzeO8+1sFooaxePaf6fBEZ6OmH2xF+PzEWzcElmhrK/NsIm2ALlxiqrQ04gHGoo5XFnsbsHwxXOYHEA0IsxY1zOw2VfKcXBC9RyYIuMhTosPWabpW/v5Jnt9Nx+P23QS2kiJlB6K/JXO8rb8xzWiyaPOCTPn+XTViYehnWQ6P/nna3S1Eokgn5RhDPs/jYOB2cYH6uyugGQabt+x+EE5tZDfQLlJlr9/Dsfam9iFeO3SeL3E9sK5Sz9wmgUAPbF/5wYSKbLg17IFE86KcWEOfNfFPC8a4jgPHYHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from MA5PR01CA0018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:177::7)
 by TYSPR06MB7260.apcprd06.prod.outlook.com (2603:1096:405:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 08:41:56 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:a01:177:cafe::17) by MA5PR01CA0018.outlook.office365.com
 (2603:1096:a01:177::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 08:41:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 08:41:55 +0000
Received: from JohnnyFan (unknown [172.21.64.24])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id EA58F40920E5;
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
Subject: [PATCH v3 2/2] perf: arm_pmu_acpi: Support heterogeneous ACPI systems
Date: Mon,  2 Nov 2026 16:41:52 +0800
Message-ID: <20261102084153.3975282-3-johnny.fan@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|TYSPR06MB7260:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 286e5f08-bee9-4bbf-9c33-08df38bd2686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|23010399003|10067099003|18002099003|22082099003|56012099006|261021123027099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	3VrQenq5cLYNYRwvGw3Xro0ELRLTaceMyFr+6NurjgzFLE8FBntp+NrYLHAWkgZoI32YhiZMXerd0Ab83tTJ9oeO34ehh7V9X0CqDCDntzoetSvE48QpiopQZQNaKKB/MVLOk3gStI6etJAinURmhqJDOXix47fo8f5634N+E/9qmgBDpkC0sISVSKcCvt8Ugqa23yr0dEIRflOyPxajF5fqN1pv4DX7APGPgimNsMVY9KXzyIL60WlmhcKTky9cbbN+4U4huR0KCegQvbljmcoDJFuicFEfccCL1qmGAHMj8ZUiQoPCLpqw++xnEGRla1TprzAt8Hs5cvQMY3G0qEbVPbph2zyKYD0c1XZ7mlwdMc+OVY46crhCNziUFLeSP/W0evYBElFV8Iq96ufLwZEy81i2C7EGnZidw0JKCAvon70NZkWZezr3LwCapOb+5Joh532sr35ZP7qqJTQCW9LaJ5SudRkUuHv2dRkzqQ/bkULwP9khDSsH9hJ4DowQHntooyQ6sl+KVz2cpPknUwkWgjNCswAF9vNifU6qavdxV5/CFmSwZpUUrUNlkNSThxQirhI5zWIhaA9OJpUt5FzpCWzH/jcCWufVI4ucxaMOXrHOBRqmdaNbIME8WW30DgiyAqmTVSBjjyzF4zXpup+sZguPdx0V+/Km9CFqQGAuZVLU+vvCFRj0uFyc+P2hpO/QSkyWvhyeIJSNQ7kTaQ==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JgFOoNqcsRSD35NG5quAYkkdMbvsIn7EW4GqTYc0s1Wfyl1M+/bSWzO/9VKij1TmA91Ucg1CyjH5lAxNzqZqlPEk2WTQOH4yvjjmU986RF2bsswlCW9275YnkzC9BKD/UUVmPzIG4HGl28x6koEYSiYrEZm3EOZUTtMRn9NgqsMAyIWd0stCUOUJoPk0ZkkpYftHjfOTQqtP9/r5ujRA3NsTfffQ0aHPGe1taHYUP6tECfft3veGxWS+DDFDZNab12b5nw0O/Zd8f22K7zT0YBoUiu/rQaorj9FIrMEAHKkMrZY31CDArAIDv6S3yJXIvglNRwA7XvGAQD8NTqqJ7ZvaSIWb3ZeLhsmmFZD46yeCahb+W5BEIdQVBZg/5hXj0UFymh01WuN2XLqCuIAyaCIBa2KJkpG3MK6TrSq5otXCfYQSf7mrNUCdGK2DyGCO
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:41:55.0891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 286e5f08-bee9-4bbf-9c33-08df38bd2686
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7260

From: "Johnny.Fan" <Johnny.Fan@cixtech.com>

On heterogeneous ACPI systems, not all CPUs implement SPE or TRBE, and
the ones that do may use different PPIs. The MADT describes this per
GICC entry: a CPU without the feature reports a zero overflow
interrupt, and the PPTT hetero id identifies CPUs of the same
implementation.

The current code registers a single platform device and gives up if the
GICC entries disagree on the hetero id or on the interrupt, so the
feature is unavailable on such systems even though the firmware
describes it.

Group the CPUs by (hetero id, interrupt) and register one platform
device per group. A GSI may be shared between groups with
non-overlapping CPU masks, so only unregister the GSI mapping once no
successfully registered device uses it, as the mapping is not reference
counted.

Entries too short to contain the field mean that the firmware does not
describe the feature, which is what pre-ACPI 6.3 (SPE) and pre-ACPI 6.5
(TRBE) tables look like. If only some entries carry the field, the MADT
is inconsistent: warn and create no device at all.

Pass the CPU mask to the driver as platform data, as added by the
previous patch.

Tested on a CIX sky1 SoC with heterogeneous SPE support.

Signed-off-by: Johnny.Fan <Johnny.Fan@cixtech.com>
Reviewed-by: Fugang Duan <fugang.duan@cixtech.com>
---
 drivers/perf/arm_pmu_acpi.c | 238 +++++++++++++++++++++++++-----------
 1 file changed, 167 insertions(+), 71 deletions(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index ca6bf8f86cfe..bffeeb063800 100644
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
@@ -68,91 +70,196 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
 		acpi_unregister_gsi(gsi);
 }
 
+struct arm_pmu_acpi_group {
+	int hetid;
+	u16 gsi;
+	bool registered;
+	struct cpumask cpus;
+};
+
+static int arm_acpi_find_group(struct arm_pmu_acpi_group **groups,
+			       int nr_groups, int hetid, u16 gsi)
+{
+	int i;
+
+	for (i = 0; i < nr_groups; i++) {
+		if (groups[i]->hetid == hetid && groups[i]->gsi == gsi)
+			return i;
+	}
+
+	return -1;
+}
+
+static bool arm_acpi_gsi_in_use(struct arm_pmu_acpi_group **groups,
+				int nr_groups, int idx)
+{
+	int i;
+
+	for (i = 0; i < nr_groups; i++) {
+		if (i == idx)
+			continue;
+		if (groups[i]->registered && groups[i]->gsi == groups[idx]->gsi)
+			return true;
+	}
+
+	return false;
+}
+
+static int arm_acpi_register_group(struct arm_pmu_acpi_group *group,
+				   const char *name)
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
+	if (!pdev)
+		return -ENOMEM;
+
+	res = DEFINE_RES_IRQ(irq);
+	data.cpus = group->cpus;
+
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
+	return ret;
+}
+
 static int __maybe_unused
-arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
-			     u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
+arm_acpi_register_pmu_devices(const char *name, u8 len,
+			      u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
 {
-	int cpu, this_hetid, hetid, irq, ret;
-	u16 this_gsi = 0, gsi = 0;
+	struct arm_pmu_acpi_group **groups;
+	int cpu, i, nr_cpus = 0, nr_groups = 0, nr_devices = 0;
+	int nr_full = 0, nr_short = 0, last_err = 0, ret;
 
 	/*
-	 * Ensure that platform device must have IORESOURCE_IRQ
-	 * resource to hold gsi interrupt.
+	 * The firmware describes the interrupt for every CPU on ACPI 6.3
+	 * (SPE) or 6.5 (TRBE) and later, and for none of them on earlier
+	 * revisions, where the field does not exist. A mix means the MADT
+	 * cannot be trusted, so create no device at all.
 	 */
-	if (pdev->num_resources != 1)
-		return -ENXIO;
+	for_each_possible_cpu(cpu) {
+		struct acpi_madt_generic_interrupt *gicc;
 
-	if (pdev->resource[0].flags != IORESOURCE_IRQ)
+		gicc = acpi_cpu_get_madt_gicc(cpu);
+		if (gicc->header.length < len) {
+			nr_short++;
+			continue;
+		}
+
+		nr_full++;
+		if (parse_gsi(gicc))
+			nr_cpus++;
+	}
+
+	if (nr_short && nr_full) {
+		pr_warn("ACPI: %s: inconsistent GICC entries\n", name);
 		return -ENXIO;
+	}
+
+	if (!nr_cpus)
+		return 0;
+
+	groups = kcalloc(nr_cpus, sizeof(*groups), GFP_KERNEL);
+	if (!groups)
+		return -ENOMEM;
 
-	/*
-	 * Sanity check all the GICC tables for the same interrupt
-	 * number. For now, only support homogeneous ACPI machines.
-	 */
 	for_each_possible_cpu(cpu) {
+		struct arm_pmu_acpi_group *group;
 		struct acpi_madt_generic_interrupt *gicc;
+		int hetid;
+		u16 gsi;
 
 		gicc = acpi_cpu_get_madt_gicc(cpu);
-		if (gicc->header.length < len)
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
+		gsi = parse_gsi(gicc);
+		if (!gsi)
+			continue;
+
+		hetid = find_acpi_cpu_topology_hetero_id(cpu);
+		i = arm_acpi_find_group(groups, nr_groups, hetid, gsi);
+		if (i < 0) {
+			group = kzalloc_obj(*group, GFP_KERNEL);
+			if (!group) {
+				ret = -ENOMEM;
+				goto err_free;
+			}
+
+			group->hetid = hetid;
+			group->gsi = gsi;
+			groups[nr_groups] = group;
+			i = nr_groups++;
 		}
+
+		cpumask_set_cpu(cpu, &groups[i]->cpus);
 	}
 
-	if (!this_gsi)
-		return 0;
+	for (i = 0; i < nr_groups; i++) {
+		ret = arm_acpi_register_group(groups[i], name);
+		if (ret) {
+			pr_warn("ACPI: %s: %*pbl: add device failed (%d)\n",
+				name, cpumask_pr_args(&groups[i]->cpus), ret);
+			last_err = ret;
+			continue;
+		}
 
-	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
-	if (irq < 0) {
-		pr_warn("ACPI: %s Unable to register interrupt: %d\n", pdev->name, gsi);
-		return -ENXIO;
+		groups[i]->registered = true;
+		nr_devices++;
 	}
 
-	pdev->resource[0].start = irq;
-	ret = platform_device_register(pdev);
-	if (ret)
-		acpi_unregister_gsi(gsi);
+	/*
+	 * acpi_register_gsi() does not reference count the GSI mapping, so
+	 * release a shared GSI only once no successfully registered device
+	 * uses it any more.
+	 */
+	for (i = 0; i < nr_groups; i++) {
+		if (groups[i]->registered)
+			continue;
+		if (arm_acpi_gsi_in_use(groups, nr_groups, i))
+			continue;
+		acpi_unregister_gsi(groups[i]->gsi);
+	}
+
+	ret = nr_devices ? 0 : last_err;
+
+err_free:
+	for (i = 0; i < nr_groups; i++)
+		kfree(groups[i]);
+	kfree(groups);
 
 	return ret;
 }
 
 #if IS_ENABLED(CONFIG_ARM_SPE_PMU)
-static struct resource spe_resources[] = {
-	{
-		/* irq */
-		.flags          = IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device spe_dev = {
-	.name = ARMV8_SPE_PDEV_NAME,
-	.id = -1,
-	.resource = spe_resources,
-	.num_resources = ARRAY_SIZE(spe_resources)
-};
-
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
@@ -163,20 +270,6 @@ static inline void arm_spe_acpi_register_device(void)
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
@@ -184,8 +277,11 @@ static u16 arm_trbe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
 
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
-- 
2.55.0


Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A074405C30;
	Sun, 17 May 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018077; cv=fail; b=FkSE8/UmRZj5F7rF1Wp3KIKy0uYiFbrCsOB3B8VzIsSs0MS+VjsIMpaQz3h2iRgphZUdAlR0G5chxKKnBfZg4Bjm5d35b6np63VKrXZ4RZgaydDRVnP7L+kiKfmKpFmBA4HCPCmFDdY4w/vu12u3Tw4qHoAVz90f0XadSRv1KPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018077; c=relaxed/simple;
	bh=AdpiTrhQsm0v2eKE8JNcjp3WnC9OHh0e3bUa2t7YIAo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTvrK4kPQtiQZYjVFwQSeM0YqlQwx7RHBYiZIxRS5cbtPqY2RUFX+SgRf8RV96ttMW5KX+Fs69lh54NdwRsEHIvq3M6soCV1IwCeC1svxHZ5NH52bGVR5g/ljilDG3P7rgog5AnsiW0tlEe4HL3mNab44MpJRh3q7zysh/7aqmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FuTfi8b6; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FuTfi8b6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jis7aqpN6vwVjKfLHYEUuvvW10/p0/Genf7edeUVcxW8qYnf8jgjYXm4JLCUFiBaDwRcgRu9ws4vKFZ/qxYAJEduRmtbSz2HCcpMWOlxJN+eRyoaT5MI5/l8dCIcJ8sSnvjZlTOW5B1xlNKQ35CXANqcVmxJDkxWgyjkp8t6NqkwhmIOJhV8HfnX5RDa82VgFSenNl9fTFMSHy3V3japLOoDTHejxj4VsK0XIwY4VFzuwJTjwCsWhWFDKZcEC2Yol8PIMbAz/GBYbQzocpCc9kQzFQb9sVZ0HtWKjhrLm842W8KQUlvJQukiQM4IUeUAa1aclHF+ItvJY1gxow0rqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8GDziN5L8XPBqqxu3R53/q7ldUUjJKMTNyNJjMGd6g=;
 b=PLE2lBFxVo5o4/RDwkssxuWg5ctTW9nIu6xxZnL9GJVN+MjQg8YzN5pGb6/Hq8rleCtWA/4+yqPl06j20TMU520eVjBKgfvoCriZdzjOUMWTuihoTXnPqtcjUq0CFv4IMsolwyHnHRYaWeo056DM02x4wqiWfAPlZyfRptdrPNjRzMGkxuaVkNisE87TlFj8Acnc2C9Hwrz8HMAT5zJ/pftGzbIY6zhfDtSyrMqt7hauTpouXvHqKz6EMlxxH2W93GkS9uihB/FJTRA8SIvxmoZmX7/tKfHmT4NOijRiGhJx21wZGkvng5JRmDNXTgZ10NcYolZTpKwdHDPjBPjAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8GDziN5L8XPBqqxu3R53/q7ldUUjJKMTNyNJjMGd6g=;
 b=FuTfi8b69Mhcyc1kPU3+8JhXP1v/QTmx2p0AEY9pSJzQzkeyxrdhzjA6XiMCZXgDwIrqn4qy9nMpVFjGzenPY9rc4TsuvNQn7mizlZGb2G7Y39YI7A4pygVOOg5+YUqM6G9mkhS7CndI7s4j62pUO6wIcuC95TSNII/oTvGc+ao=
Received: from PH3PEPF000040AA.namprd05.prod.outlook.com (2603:10b6:518:1::4c)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 11:41:11 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2a01:111:f403:f90e::4) by PH3PEPF000040AA.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Sun, 17
 May 2026 11:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Sun, 17 May 2026 11:41:10 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 06:41:04 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>
CC: <x86@kernel.org>, <dave.hansen@linux.intel.com>, <tglx@kernel.org>,
	<bp@alien8.de>, <hpa@zytor.com>, <iommu@lists.linux.dev>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <sandipan.das@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
Date: Sun, 17 May 2026 11:40:26 +0000
Message-ID: <20260517114026.6817-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b099d4-cd34-442e-6b42-08deb409311a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|921020|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nbLNSrfGCy8VPmrCAmly5aKMLgCb8O10VWU2k8m8fgyAad8UWCzMmfBB/74hV/yLwfuyhlAqg5oB651LY9efcR2e7ERBr2k84qK16idIQvX2HR+z8PI4i4Z2jvpOroSr0zwYhXgm2HdM3uXwEeuw/KlXYDHdS/ytB5mpKX70IJ4a+kO6I/QVl1dySHivNWkT/0cVYPLin0fZ3JaSSNZr9Q6W5rSQnyg6dPUg0zaD+jQ6caJgC1/kJ2UVmdPG/SYq+3rgkoIXjEZvCtMwJaondme6asvKu9pRKaI74+ax/ItUyBuKhXMj0RU+LEmBbDTB/uf09iJXEsig/OMt68uPtg49mK+Ur3K1XKdGfJQm0GLHvBDgS2vhq7M3VzYFYOkc9tUajZ7AEC2WXeaf7HkZTxZ2TxYtQyQdYyVwhxCblWgeaCgcTEZhAqowd0zfRFAu1g2IHC7+fpCaOZ0VAZ2DFxhVjs0qBo9giOlzdnd6wz8ht8H2TkEtRh1px6H8qm8DPeoxCrKes8MkQQAnwqr3tA6CUF08s5yLfJKFY5N8HeyPUj7BfY+a8eqQSubmOqxwSEl5DNNFsCqNbfXsFqIDGlrrW/juGFO7xaNLO6XSnRaJ8E30NgNohVAtUSyaOl0fLOVBaw+PMi0PJmFObCXqkYU4rCmeKt4bMhnAyPrBB6C5hprrJDcNqbB0HM/aOSBhJHcfJpjvPs25r3CxXXajLNZjsd+QTB2kxY1JoFCEKgUvGtysA9PV7gscrfz7MXtmK+B0iehfSmgo2NnunRSt6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(921020)(11063799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YA3MKyBqUk6K9pSHE/JVQFakMVNv5L18j/9HMF2IgB/ReUFKLJffbQxzTAE8lRCB6hjrJD7gBKZhO9PAGUqqgkzvo7eeEwXtGujqGuaulAer92XzvHMtMx900wBkqQeFV5YfFM4ZHUk4OYj83dbPAdFhuvBJWxCAPzaoDrHhgGWffGLSlwJ9m5e36sgoRtlGm4lYxc5k93YQDP2RmuyL5kD/1B5Hd7IdRR7nLapmEVuktDZRlAQtl5zxW/+PsQU7dln5lK+MEbzz2BjBcn7FNo2ncn94r9SWjhmSap6HLjRcQ0sFmTG+NxoQWeFm58/MfwxoEKZNjWsvUSHRa716QwGkeuqN/OcPt5I+we3N4PGyw8oHwxqnp0nLHv61mUt3DRrWEtCuh9u/NAuoajfL6ZlyIt7De4HmiV4yjL5Ail9Ebez801sEkeCY+Gxn8+L2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 11:41:10.4004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b099d4-cd34-442e-6b42-08deb409311a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172

IOMMU performance counters are accessed via MMIO space. Currently IOMMU
PMUs uses a single global cpumask (iommu_cpumask) shared across all AMD
IOMMU PMU instances. This prevents collecting per-socket numbers
(ex: perf stat --per-socket).

Fix this by adjusting cpumask based on IOMMUs NUMA node.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 arch/x86/events/amd/iommu.c | 29 +++++++++++++++++++++++------
 drivers/iommu/amd/init.c    |  7 +++++++
 include/linux/amd-iommu.h   |  1 +
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 07b110e8418a..b1848300028d 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt)	"perf/amd_iommu: " fmt
 
+#include <linux/device.h>
 #include <linux/perf_event.h>
 #include <linux/init.h>
 #include <linux/cpumask.h>
@@ -43,6 +44,7 @@ struct perf_amd_iommu {
 	u8 max_counters;
 	u64 cntr_assign_mask;
 	raw_spinlock_t lock;
+	cpumask_t cpumask;
 };
 
 static LIST_HEAD(perf_amd_iommu_list);
@@ -131,13 +133,15 @@ static struct amd_iommu_event_desc amd_iommu_v2_event_descs[] = {
 /*---------------------------------------------
  * sysfs cpumask attributes
  *---------------------------------------------*/
-static cpumask_t iommu_cpumask;
-
 static ssize_t _iommu_cpumask_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &iommu_cpumask);
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct perf_amd_iommu *perf_iommu =
+			container_of(pmu, struct perf_amd_iommu, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &perf_iommu->cpumask);
 }
 static DEVICE_ATTR(cpumask, S_IRUGO, _iommu_cpumask_show, NULL);
 
@@ -420,7 +424,8 @@ static const struct pmu iommu_pmu __initconst = {
 static __init int init_one_iommu(unsigned int idx)
 {
 	struct perf_amd_iommu *perf_iommu;
-	int ret;
+	struct device *dev;
+	int node, cpu, ret;
 
 	perf_iommu = kzalloc_obj(struct perf_amd_iommu);
 	if (!perf_iommu)
@@ -440,6 +445,20 @@ static __init int init_one_iommu(unsigned int idx)
 		return -EINVAL;
 	}
 
+	dev = amd_iommu_idx_to_dev(idx);
+	node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
+	if (node != NUMA_NO_NODE)
+		cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
+	else
+		cpu = cpumask_any(cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids) {
+		pr_warn("Failed to find online CPU for IOMMU %d.\n", idx);
+		kfree(perf_iommu);
+		return -ENODEV;
+	}
+	cpumask_set_cpu(cpu, &perf_iommu->cpumask);
+
 	snprintf(perf_iommu->name, IOMMU_NAME_SIZE, "amd_iommu_%u", idx);
 
 	ret = perf_pmu_register(&perf_iommu->pmu, perf_iommu->name, -1);
@@ -483,8 +502,6 @@ static __init int amd_iommu_pc_init(void)
 		return -ENODEV;
 	}
 
-	/* Init cpumask attributes to only core 0 */
-	cpumask_set_cpu(0, &iommu_cpumask);
 	return 0;
 }
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3bdb380d23e9..2c35d171b5ae 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3939,6 +3939,13 @@ struct amd_iommu *get_amd_iommu(unsigned int idx)
 	return NULL;
 }
 
+struct device *amd_iommu_idx_to_dev(unsigned int idx)
+{
+	struct amd_iommu *iommu = get_amd_iommu(idx);
+
+	return iommu ? &iommu->dev->dev : NULL;
+}
+
 /****************************************************************************
  *
  * IOMMU EFR Performance Counter support functionality. This code allows
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index edcee9f5335a..6b8d6b53b4e9 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -67,6 +67,7 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 		u64 *value);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
+struct device *amd_iommu_idx_to_dev(unsigned int idx);
 
 #ifdef CONFIG_KVM_AMD_SEV
 int amd_iommu_snp_disable(void);
-- 
2.31.1


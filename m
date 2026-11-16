Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794830068;
	b=sQQu3lzg7NFmWkqg/J3q9eXqMUpgAfN86+8YKPfUA7oaXmo99RDqIufuNgFI0IegRPNt
	 3dYOdd6V+uexczNi6K/UK4bZIq9qeH4SPl2EzP8hL5L3iPUQ0gF+3QvXxlxMaqQMeahol
	 vQoCD8H4k0ZluOHL2goAYSxqC61jz6fZhxE17WgKezjdPFd9ofGXuIcfQ26xIB2A2/WjS
	 a+w6CUGoa+7IAd0TwAU3LX2S6L9IRM85TOLuwSSzFjV/8/YoOjXZBRrZaCu9CNkuPiKlY
	 Lz/ed0JAkDymqvpjyaVei8XhYfrrVM73LaWacsciuih5TzjH94eHwfLEQSI4fPaWmLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830068;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UAm4sbLFtxG2vHP70XbBwPOneCn4DwrQQH9KCD+AVzs=;
	b=jTBRxqBiBDMvA8MSZwtazyp6Q64Ho/246T7m/R6frApX9O+inyTk9YlBwLRmsBVl0oPZ
	 zRmT+H3Ogf+zQbQju2HHtPZVvB7KC21Cjl75RzatTgs0lGj8gikM55560A3WHMZYadICI
	 ZQ1XhBWcyZEu3zT6HkiucNwCSWjrtuSsMArcIT7NWxYSYyKkN++FzqOWkJuncARCPwEZU
	 LvnVAiL4Sk9M9bmqO7yCopvKGxTAllSCu+WyF2/ha1T2SI+a+GTGHBgJtgVwkedgOXxTN
	 QKq3GbU2skqTwt7cy5NexlIgxDTtBeT1eZZKYIHM7bsdBL/dYqppM2X8eCwrmkSSZhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5JQJyc49;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.6
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFA606A323;
	Mon, 16 Nov 2026 11:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2AFA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5JQJyc49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPAFu3buHQx9fBsG88OdhZ5To5swxOrC+124clV+n3hHpFGwLswdY7ADnrDH5aFCOkOtbTPtR3up1my+YWu1kgyIpwtTQ5lBcglmtz1i/9JY/dP7Uy15XfM3IOXGX+9vtSbHNta7tWb1z/AP8YKdMGdC7jYr7Vs+CS+evBYpB45cl/m/FyQ6RSUvcMoIstNbw7QWCvBQTYmWdGCibS/LFRvI27moGtEsK7mNHG5xYSpfMYnXkM9ppyr6m1r85Phvj9dSbPk2jnorbKsgOqfVznPUjTJwLlIK1LvwT4Qydq5sjaLRhUk5mf+eOnTvqtcIclPML59eSBj7IKe6qTsq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAm4sbLFtxG2vHP70XbBwPOneCn4DwrQQH9KCD+AVzs=;
 b=XhwHCPKBK/sCys2Julxu6G6AFrWwVeThE4B8mEosxrZ1OzhLCkO+dW0Dn4L7LAS06GntKTwrl2k83BBWuGIrT1SPjrYrUbF9UsCwfwRV4oSs77rBxljQnT9O2le953rtRaqkpz/ITl/cD9tVBJ34JS+122irw98jvlnnb0C4nLmNUR0eP2ppeaXvUM1w7NeDArxp8/ko/mUaduSmANWw9GfBcc3Vft2A4lY8ZbhMvhe3SscOxMSwo8YHjj+yN/yiU+0xi9/fToK34E9u27QPq87ApObQEQVZ6fwyeCiw1jdtqrIWh1pSV/v0F6hdJRUYhCDtmdrK9xs5/WtAfNRHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAm4sbLFtxG2vHP70XbBwPOneCn4DwrQQH9KCD+AVzs=;
 b=5JQJyc49LkPclUcqWBqhxEx5kAo6wu1EhToF3Gsln9rG1O5u0DAFjoxaNL6Hu4SVgy4ZtgB/vIQowhg8YjMkNNjr2sk9v4vlmpFAui+QmNDPgAq/HKhVGkdmqgzy203T62pQtvfA2fZB37exbJwawV8JKtyl7xPDLxpqhs4rH2Q=
Received: from SJ0PR03CA0148.namprd03.prod.outlook.com (2603:10b6:a03:33c::33)
 by CH9PR12MB966865.namprd12.prod.outlook.com (2603:10b6:610:315::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:54:22 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::6f) by SJ0PR03CA0148.outlook.office365.com
 (2603:10b6:a03:33c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon,
 16 Nov 2026 11:54:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 11:54:21 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 05:54:15 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>
CC: <x86@kernel.org>, <dave.hansen@linux.intel.com>, <tglx@kernel.org>,
	<bp@alien8.de>, <hpa@zytor.com>, <iommu@lists.linux.dev>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <sandipan.das@amd.com>, <ctshao@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3] x86/events/amd/iommu: Use a per-IOMMU cpumask
Date: Mon, 16 Nov 2026 11:53:50 +0000
Message-ID: <20261116115350.13740-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|CH9PR12MB966865:EE_
X-MS-Office365-Filtering-Correlation-Id: 7136b683-b62b-4103-7197-08df43d85a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|18002099003|6133799003|261009221227099003|261009223027099003|13003099007|921020|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	TiqlmLAivjSUZ0px835vVp2L97E3fI6gkJ5LlZCTodsciu8rps0SNsxLXEZxETfZlsrKAQM2bEaW90atJzuoVB6KH0JpuX09kv7VFhv7bArqoF7BFMy3HJHDSF39zs1IZG9aQdh11f1fcCP2pK+nAbGcFB8PUcAFaNV5S44HgNVAj3Qn+QB42QKTYW1I/rzLUbzD2IXzIrcJo9j19B5GtU8CMzEDRgVHkDlGoS8KG/cB+aYjzsqa/Yrij8bpKK+7z+skERCIDANLj/TmRQa5yFiYWjs834+wkQys6tEL7x5mceDkznU6Xu6EwAXjZvqqVolHCqdLr2V2P5ezPQRe0OdWtsGjDztqgHfFBpSKB+9UAvZVK4I8fTaH4rxIBLyF329j242AV9Xf1voMRmwRPnpHjW3qpUOuDLp2kNZfv9RbKkUhoOsSg+3z6YBkarNGabCQOKgnelsgCwBeHMBuU7A/oGhS4edpNU+LL2zpcpG5lz+R5Bzlrp1eqUk91u5EOZiWoyBYj82/PCpqnlEeriWoMThUM7zMbAPnuUa+2w6Iw5ROjTsby7M27E9RYrqY8yrBT2S9t3YwnDWG9wEe6tCCoV1WYBILDH/S/Ixb7Rirs+OVnZ2EJFQ476ijfuT5RpFqDuNAteT8PXhrryBJqmnJfZ4EDnI2J2xsSo71vdiPOpFS6HFQ7Sq/4bU0I+plguDjLGq+gi6WAC4lA4fAKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(18002099003)(6133799003)(261009221227099003)(261009223027099003)(13003099007)(921020)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GGvYpBbIfXjnYOfRHoHPSd9fYO5rMuP2jUwmgO/dSm15qscQNaBhPM5Uwin+j6KGXadBT8/nVznHd0X/z6I+KYFxSmubR/EiV4y6JtGkcAWN2nUJyrv4WroNA28jBFMNdUKbQTAB0Syz1eAe83xpPnYVuwI6RIl16+fLD2yoS7S+fT7bJNwIEs/JJCnbJic6CJFr79x0g7N2lSruxyILd/9wMm/aJD60ADun4XBk6mPnGP30Pn/QV0FITBw/0Hj8UFln8svz2UlaVTC39rRJlzkMK2ZE0tLJ0mHmipPq/bZna6fM89LA5ASRlaq80e2RZYmqDCAwppVAr8fkREwyf3WE1ifyo8ksncDUjUu36pZtQSJj7D+rpP9IC8cKkBfQh4ajoJTaHtNH4jeVniLNF/tawt2bXn72UwFZ/REY6wQJg3TsGnVv4M62R6KiXzsK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:54:21.7197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7136b683-b62b-4103-7197-08df43d85a61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB966865

IOMMU performance counters are accessed via MMIO. The AMD IOMMU PMUs
share one global cpumask, fixed to CPU0, so every IOMMU's events are
read through the same CPU. That prevents collecting per-NUMA-node
numbers (for example perf stat --per-socket). The mask is also never
updated, so counting stops if that CPU goes offline.

Give each IOMMU PMU its own cpumask. The CPU is chosen from the online
CPUs of the NUMA node of the IOMMU's PCI device, via
amd_iommu_idx_to_dev(). If the node is unknown or has no online CPU,
any online CPU is used. If no online CPU exists at all, that PMU is
not registered.

A CPU hotplug callback moves the reader when that CPU goes offline,
preferring another online CPU on the same node. If the reader had to
leave the node, it moves back when a CPU on that node comes online.
Events are pinned to the current reader so they share one context and
migrate together.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes from v2:
  - Addressed Sashiko review comment and added lock in sysfs read path

V2: https://lore.kernel.org/linux-iommu/20261113150502.685887-1-vasant.hegde@amd.com/

Changes since v1:
 - Rebased on top of v7.4-rc2
 - Added hotplug support

V1: https://lore.kernel.org/linux-iommu/20260517114026.6817-1-vasant.hegde@amd.com/

-Vasant

 arch/x86/events/amd/iommu.c | 147 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/amd/init.c    |   7 ++
 include/linux/amd-iommu.h   |   1 +
 include/linux/cpuhotplug.h  |   1 +
 4 files changed, 151 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index f332c7089bd5..b4ed454a0636 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt)	"perf/amd_iommu: " fmt
 
+#include <linux/device.h>
 #include <linux/perf_event.h>
 #include <linux/init.h>
 #include <linux/cpumask.h>
@@ -43,6 +44,8 @@ struct perf_amd_iommu {
 	u8 max_counters;
 	u64 cntr_assign_mask;
 	raw_spinlock_t lock;
+	int node;
+	cpumask_t cpumask;
 };
 
 static LIST_HEAD(perf_amd_iommu_list);
@@ -131,13 +134,32 @@ static struct amd_iommu_event_desc amd_iommu_v2_event_descs[] = {
 /*---------------------------------------------
  * sysfs cpumask attributes
  *---------------------------------------------*/
-static cpumask_t iommu_cpumask;
-
 static ssize_t _iommu_cpumask_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&iommu_cpumask));
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct perf_amd_iommu *perf_iommu =
+			container_of(pmu, struct perf_amd_iommu, pmu);
+	unsigned long flags;
+	cpumask_var_t mask;
+	ssize_t ret;
+
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	/*
+	 * Hotplug clears the outgoing reader and then sets the new one.
+	 * Copy under the lock so a reader cannot observe an empty mask.
+	 */
+	raw_spin_lock_irqsave(&perf_iommu->lock, flags);
+	cpumask_copy(mask, &perf_iommu->cpumask);
+	raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+
+	ret = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(mask));
+	free_cpumask_var(mask);
+
+	return ret;
 }
 static DEVICE_ATTR(cpumask, S_IRUGO, _iommu_cpumask_show, NULL);
 
@@ -207,7 +229,11 @@ static int clear_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu,
 
 static int perf_iommu_event_init(struct perf_event *event)
 {
+	struct perf_amd_iommu *perf_iommu =
+			container_of(event->pmu, struct perf_amd_iommu, pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	unsigned long flags;
+	unsigned int cpu;
 
 	/* test the event attr type check for PMU enumeration */
 	if (event->attr.type != event->pmu->type)
@@ -224,6 +250,18 @@ static int perf_iommu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
+	/*
+	 * Counters are read via MMIO from one CPU. Pin every event there so
+	 * they share a context and move together when that CPU goes offline.
+	 */
+	raw_spin_lock_irqsave(&perf_iommu->lock, flags);
+	cpu = cpumask_first(&perf_iommu->cpumask);
+	raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+	if (cpu >= nr_cpu_ids)
+		return -ENODEV;
+
+	event->cpu = cpu;
+
 	/* update the hw_perf_event struct with the iommu config data */
 	hwc->conf  = event->attr.config;
 	hwc->conf1 = event->attr.config1;
@@ -417,9 +455,93 @@ static const struct pmu iommu_pmu __initconst = {
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
+/*
+ * Pick a CPU to read this IOMMU's counters. Prefer an online CPU on
+ * @node. @except is skipped so a CPU going offline is not chosen again;
+ * pass -1 when any online CPU is acceptable.
+ */
+static unsigned int iommu_pmu_pick_cpu(int node, int except)
+{
+	unsigned int cpu = nr_cpu_ids;
+
+	if (node != NUMA_NO_NODE)
+		cpu = cpumask_any_and_but(cpumask_of_node(node),
+					  cpu_online_mask, except);
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_any_but(cpu_online_mask, except);
+
+	return cpu;
+}
+
+static int iommu_pmu_cpu_offline(unsigned int cpu)
+{
+	struct perf_amd_iommu *perf_iommu;
+	unsigned long flags;
+	unsigned int target;
+
+	list_for_each_entry(perf_iommu, &perf_amd_iommu_list, list) {
+		raw_spin_lock_irqsave(&perf_iommu->lock, flags);
+		if (!cpumask_test_and_clear_cpu(cpu, &perf_iommu->cpumask)) {
+			raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+			continue;
+		}
+
+		target = iommu_pmu_pick_cpu(perf_iommu->node, cpu);
+		if (target < nr_cpu_ids)
+			cpumask_set_cpu(target, &perf_iommu->cpumask);
+		raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+
+		if (target < nr_cpu_ids)
+			perf_pmu_migrate_context(&perf_iommu->pmu, cpu, target);
+	}
+
+	return 0;
+}
+
+static int iommu_pmu_cpu_online(unsigned int cpu)
+{
+	struct perf_amd_iommu *perf_iommu;
+	unsigned long flags;
+	unsigned int target;
+
+	list_for_each_entry(perf_iommu, &perf_amd_iommu_list, list) {
+		if (perf_iommu->node != NUMA_NO_NODE &&
+		    cpu_to_node(cpu) != perf_iommu->node)
+			continue;
+
+		raw_spin_lock_irqsave(&perf_iommu->lock, flags);
+		if (cpumask_empty(&perf_iommu->cpumask)) {
+			cpumask_set_cpu(cpu, &perf_iommu->cpumask);
+			raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+			continue;
+		}
+
+		/*
+		 * A reader that fell off this node, because every local CPU
+		 * was offline, moves back when a local CPU returns.
+		 */
+		target = cpumask_first(&perf_iommu->cpumask);
+		if (perf_iommu->node == NUMA_NO_NODE ||
+		    cpu_to_node(target) == perf_iommu->node) {
+			raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+			continue;
+		}
+
+		cpumask_clear(&perf_iommu->cpumask);
+		cpumask_set_cpu(cpu, &perf_iommu->cpumask);
+		raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+
+		perf_pmu_migrate_context(&perf_iommu->pmu, target, cpu);
+	}
+
+	return 0;
+}
+
 static __init int init_one_iommu(unsigned int idx)
 {
 	struct perf_amd_iommu *perf_iommu;
+	struct device *dev;
+	unsigned int cpu;
 	int ret;
 
 	perf_iommu = kzalloc_obj(struct perf_amd_iommu);
@@ -440,6 +562,17 @@ static __init int init_one_iommu(unsigned int idx)
 		return -EINVAL;
 	}
 
+	dev = amd_iommu_idx_to_dev(idx);
+	perf_iommu->node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
+	cpu = iommu_pmu_pick_cpu(perf_iommu->node, -1);
+	if (cpu >= nr_cpu_ids) {
+		pr_warn("Failed to find online CPU for IOMMU %d.\n", idx);
+		kfree(perf_iommu);
+		return -ENODEV;
+	}
+
+	cpumask_set_cpu(cpu, &perf_iommu->cpumask);
+
 	snprintf(perf_iommu->name, IOMMU_NAME_SIZE, "amd_iommu_%u", idx);
 
 	ret = perf_pmu_register(&perf_iommu->pmu, perf_iommu->name, -1);
@@ -483,8 +616,12 @@ static __init int amd_iommu_pc_init(void)
 		return -ENODEV;
 	}
 
-	/* Init cpumask attributes to only core 0 */
-	cpumask_set_cpu(0, &iommu_cpumask);
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_IOMMU_ONLINE,
+				"perf/x86/amd/iommu:online",
+				iommu_pmu_cpu_online, iommu_pmu_cpu_offline);
+	if (ret)
+		pr_warn("Failed to install CPU hotplug callback (%d)\n", ret);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3dd4ff145e55..f13aa858fd50 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -4077,6 +4077,13 @@ struct amd_iommu *get_amd_iommu(unsigned int idx)
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
index 5c9dcf720f84..e3bddbe1c21b 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -67,6 +67,7 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 		u64 *value);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
+struct device *amd_iommu_idx_to_dev(unsigned int idx);
 
 #ifdef CONFIG_KVM_AMD_SEV
 int amd_iommu_snp_disable(void);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 1b6dba159bb2..468e61c98e80 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -205,6 +205,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
+	CPUHP_AP_PERF_X86_AMD_IOMMU_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
-- 
2.31.1


Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E162C0F75;
	Mon, 16 Feb 2026 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215767; cv=fail; b=m3HiEtPBIcvEC03QRK0a54K0fexvby9TwQ0ksHiqYpDWX8r+gdNGZ3NdAFrUym7nFp4o/NNbdtExxJGUWQ1NXTwprmo4eqKHf17v+LZpqJ63VzgLcOsU4QAvWhEHNGgVcq0rsfyOqpsvFKf7a18i2OZAGU323bhgeBmCQEVVydw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215767; c=relaxed/simple;
	bh=6oe4sS79++F/CutrUGbfOyq9yOgvs41ZH55VsDSgq/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ey06DX+GMBuyTwju3noeXhWD3RCcfPgPJErl8Fm0ZRG8Oqm3IURfmyulfy0vOwVWtWy3tOs451OGmGmjk3zqkV0c6l+HdlD0MrCGGgmNyQmSkqKFpQgJnUxBZLeVL9qYSZYqLqCdTVjz74jwQfxEaUmhoW3bVY7T70VuzYSuCUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uWz4H6NZ; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uWz4H6NZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1hVGJWUjazWB9fPX1p8ojv4NRJ7XG3f/zyb/xok49W2+UXwH4kn9v/MzrC5BGQ2kxV1KK3Q4aCk54baWKnWmvGUEBgyjm9uXwHNUCyz47mJKuQBuFp7UyW82HiJ3yPUPR9aepvrZ92ZgcEUoXIsYmgqNOGfkG+sKoZVNmZVtHlEAvRisp/h1hsGBJXEzgmWb+ehpr+w02+YnyTjtXhqiZllW49TtQvQfEgZpn72auwF+AZtcr/+cbdg6smXKVM/dJSdeEKlGdWO0Rltj7tSXxcUWiKPm3IMAl96wkqkHPi0RY82AuJnftXzmrvAfF8ot0syW15dT+fVcf7B0Vb6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEHbCpHuaBVOYltBF5N3fgIzPGQjSOFl3lshVUh5Aic=;
 b=lZa/Md+7ZHM84fDWhdVPuK02LPoi+UwZp/CZ2pMZRNjbxYjN0ivwEg6mw7CVdKI4FrMVVBxvswY4CyBje8x2bEO/1zlfc3aw342yW+JuKHWF8t3iRtkVroyrmGN/m9lCWcp1AyMvPqioYCVPWShcFLfAPn86I/p8yQjOmYokIST2caNEljzpyhBC6wG3M1JlnlJAN/cuImwnRVu4rmx95V+EpLfyFKcTvoQNLKJj7FEk7wGMmlloNId65FiyF2wLQGft9j5hgVIGXCA5k38DlNQC/1B/eUDOLvedN+7W/T1tJnNlzotWHo9x3S8yns/mXJ6FhcmyZfG9MgQBWMB6GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEHbCpHuaBVOYltBF5N3fgIzPGQjSOFl3lshVUh5Aic=;
 b=uWz4H6NZj7VtdkPFL/Z8Rf/HYZWxLeyazy8l6fhzbq1Xo29/uOofCkIE7FMvAIRYWJkrESIPCzDrM8jbnpbEyTp5HTSr3bjxZCGRCx2HT+6XmsvUkEDYyzWv4+OeyDXxHr+Mlwn2AQ/uUsLoyPIenYf2u2fg/AAfQwS2Q3KpiVc=
Received: from BY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:1d0::14)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:22:42 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::73) by BY5PR04CA0004.outlook.office365.com
 (2603:10b6:a03:1d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:22:41 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:22:36 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 1/5] perf/amd/ibs: Account interrupt for discarded samples
Date: Mon, 16 Feb 2026 04:22:12 +0000
Message-ID: <20260216042216.1440-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216042216.1440-1-ravi.bangoria@amd.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: f3efb198-8c79-4eff-9679-08de6d13069e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HVDnXnO0xiPYzxM2+pCNJR3KR+fQPmgHAAlJprmIELwbJNXGiL+JI7osKDM4?=
 =?us-ascii?Q?8AaQv22yKfujkEsZjBBVmeGExOf8iJTIe4nPiZvtIBb7tvWotyEm8QY9IoIn?=
 =?us-ascii?Q?qv8CQ0rKO3FBqFx4a3cLd0x7PRt56wJ1AC6oiu/z2x6jpHZKf6tQ0UTvoUlS?=
 =?us-ascii?Q?IQzbGBIKyg2G26DLeMiiL40OyUonUcq0+7rCQCwUTdvaWRk0KfM71NTKbojD?=
 =?us-ascii?Q?2lePnrg8ohCEEkxsfO6GojuKbzhVLd0Zvyct1/RFWfYACm8IB+qw5ahwwzdY?=
 =?us-ascii?Q?7goedf5dW4pUSFIoiKCfvFDntJ8nmhBV7jPYMmcKpgYd8GMaLfNnUOk7uVQS?=
 =?us-ascii?Q?cppoNv05S4JcFj8wMOH6DcL0U3wsdjsjKkvgjEgTQKbvKJ3YofV0sTBx6/r8?=
 =?us-ascii?Q?TEsJKB0EZhVnhLaQB/sLGlgSsldQCnQQDloGOMU0/sP3U+pel83KLKS6rCMO?=
 =?us-ascii?Q?HfUurHkt/HubElHhxl/6I5X9jjqEHqoJTqnrms/FJWHIOF27jZkCVNFfuQvL?=
 =?us-ascii?Q?ICCGDZBpggrAf2iQE+niz/ffxwvIkXKuP5bshfLn6730v/KSJMiUvAk1kQ+9?=
 =?us-ascii?Q?oNPUM2iFc1ujQ3B56zEI5ytjWc0WeIqfjyWqHZyGttj2Phi7H4ZsjDONQm3K?=
 =?us-ascii?Q?G0WeXGZGYhgmZkhJQ8HRbqbqs5HagPmO4q8rObrr5EVPiVYnyGjghiHVqPxl?=
 =?us-ascii?Q?JQKSFXTsxRurJkt7/EpE4FnPVFgkd0d+ZTUOnEbWj38lJDTps9e6RMt3zsHp?=
 =?us-ascii?Q?Cs2pMavkiGN5YeV3a8Eq1L8T3jhQWckFfp/D8h7VE5B+dvC5HFbt6I637LKL?=
 =?us-ascii?Q?6TcScGb7oCGKIocvb+iAdO5Oorz12GUPfe92RMkVsscdeeL78ByIHYKgdvO3?=
 =?us-ascii?Q?Jj8AaB99yYf/fOl5P4xI6HlPBK563s6CNSZbVYHur/15fEYllNSqFl2C9Q29?=
 =?us-ascii?Q?pBVpZsrWNUJuh/Yk+/YKPs0iH5vq9ljrxpKeYTj3gjM0g88QVpjn1H9H0tBp?=
 =?us-ascii?Q?dHcoVYVXzh8LZJW7i9Ze2eB2kaWqZBgYZVqSE6x3ILKix8LA6X7yL5oCh8sr?=
 =?us-ascii?Q?ktoyepT0cfQkHIqEU+X8T9DAnA4KoXwOKV+LGeWzx/tCSBNSOkNrf6WUIzXJ?=
 =?us-ascii?Q?0lYy+/jz1JH5kVmsqVTPYwEuWfs5yTjxpZTSzZeOOeW5MAVO1mGa/A48jA1A?=
 =?us-ascii?Q?WMPWx6p4Lq3GqS0mieEsfhSa0UeDYat2Tlfd8rPyS6baWV1E6GcfZY4BoLFV?=
 =?us-ascii?Q?AsIrdhjzAi6Qd/jNRcTSaOnaXkJDeor4dvlYGeI3F3nsMM5otFq4wXjSkrRp?=
 =?us-ascii?Q?uRABLxZzuQCzC1oUlUNeMM8jisDUr6MKbj2R9BdD7H+rcHwajo7foIvhqcqj?=
 =?us-ascii?Q?zLeDs4+wvF8WjyaJnJGYOrgKWAB4OL85wquCzQdCZ0MCXHwKAnUdxgmNQJwd?=
 =?us-ascii?Q?M7v6XTZzFoaXJSKXo4WPd2Bw9bmRq2QLzrwbAQoHUkvyF3qCV96yWFQans8f?=
 =?us-ascii?Q?EKmsvkbr3gOsiRI8RWByr9U2PofOjEyqk/Jq82CheriqD/9PkvHXIjAm10DY?=
 =?us-ascii?Q?KPAWBpJNWzDGCRr//L89Cwmf1PY4K7BWOezSBXa3c8CnN2W/uzG8ISp7hqjZ?=
 =?us-ascii?Q?+5MgvC0gtQtZeq2jJcLJVYDRw5dJhRswrg8Gtl72p7tq+cosvUAbVhW3hupH?=
 =?us-ascii?Q?jOoOLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NpnmwssiaBir+leJMlxzMRTYdT73vy4jVNNyf3RzIrT7fmqbe2/aygo9KmJkppec2XvEL21hqEaCFf12QPa/IVRe9qc8CnvpaMxyrrr2hR5d/pCjj/8v4whSkSCNLIX0KM0FGBtIc/z0ycDwYbWuk4Pu6cFXHuok0vfGdqaEqfr1INEn/8IW30O6NsXJkJ8mZ56dvAFDWt/tHOAFKYbH6SOca4eXwUL9pDyLEcMU1qa1SMTi/Q/NS2ZkTD6z9nUVVELf2iMLPx1clCxLm0cM082VtQ/14HUTcqaaCF2Y2iHmG8ry1rJ9muzfeuupdBt+oynYmmOgl6iL9Q1d8tzomnrZHiS9Xon7HXUjA/lmC1/AO6kiuqhjfK8mmLO/RpcqY2qdoMGiaDp1FhFD46Xg4KXeX4CNqO8clql2TawKMTQuAycSRWm7cHe0B16kPWq6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:22:41.4944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3efb198-8c79-4eff-9679-08de6d13069e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

Add interrupt throttling accounting for below cases:

  o IBS Op PMU: A software filter (in addition to the hardware filter)
    drops samples whose load latency is below the user-specified
    threshold.

  o IBS Fetch PMU: Samples discarded due to the zero-RIP erratum (#1197).

Although these samples are discarded, the NMI cost is still incurred, so
they should be counted for interrupt throttling.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index aca89f23d2e0..705ef43325be 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1293,8 +1293,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		 * within [128, 2048] range.
 		 */
 		if (!op_data3.ld_op || !op_data3.dc_miss ||
-		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF))
+		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF)) {
+			throttle = perf_event_account_interrupt(event);
 			goto out;
+		}
 	}
 
 	/*
@@ -1326,8 +1328,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags &= ~PERF_EFLAGS_EXACT;
 	} else {
 		/* Workaround for erratum #1197 */
-		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1]))
+		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1])) {
+			throttle = perf_event_account_interrupt(event);
 			goto out;
+		}
 
 		set_linear_ip(&regs, ibs_data.regs[1]);
 		regs.flags |= PERF_EFLAGS_EXACT;
-- 
2.43.0


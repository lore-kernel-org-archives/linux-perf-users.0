Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C074221544;
	Fri, 18 Apr 2025 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947902; cv=fail; b=F2qrqoHLUKdBtCyjRVsTkZ25jLKDWNFF66+EKTqgTMdTRbRNKbCkVLCUSyD2ECVHfiSPGTbz7Ivog9AwyBAxrz90mThgsEoQOkG6RSVyo07lUv2QmVbueUobS0Iudr1CoefVwMxKO09tymAwe5xIu7xNlZsSryT2yNc73PPR6eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947902; c=relaxed/simple;
	bh=yNPw7+VGFO7rMhDgOk7zDHNjGzYgKl9S+6Hl0Q1bd4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oktpgsqA6dAi8joBzv3yJdqAejUN6J75lvJinteSF1oAw4fhz0biIUYyTsqKCg483cxyeQ/k20hPsb8N0IGXjSHxHOoP05WL3FmRwn49WTXgv5pYPOb4v+YNW3mGySwz3chVm99QOBJsaIqwAYxelb1gS+lhUiVWHcWqfY2dH7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AQGo17U5; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AQGo17U5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZwTJNnUd2So+/qW74s9RHuAGv0NdldB/JbA1FswWj6mSO+W8uXiJmNVRQhpithaAEmy0+nrIlNuLquYR08TBCw2dFtYS3dOZaMmjPopEwNR0dEBaQ84jkOzoCBGZx3BF8J1LB8qpD7KayNAik1rcnG+hwZrfnyyfRjhYhqRMVwNLsp7s5oyrjFhFJeUBBUDIIJyrwY5VhAa1qpMzDfKEQ3cd8zhfpHNpPd3RpzuyDbZJ5k3W2p72xDiAuZYvz8eMgjYnME4hAWGlaXhze2xB9Ooi/CUkN6avvmIVPqJ6K6MKM1ohfYdt1ygZGrrUpIkvEmussEFZd2gb4/O64gFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwXEajosFg6FLShcgQpstFKykRIF0WmRbsuDXYbbzEY=;
 b=oQikFcM9MsP1s7ng8JlN+tCic/qSrkCSac9Qnf5p28+88K8gZx4tAke4r2lV/b+HIGpQ9avRttK78gizH6KZ0wBkap/ZdqdmlSVV8UOTSye+yjaCMjzM+H5KATtJPt/7Wf0tjhs7/Ev2y3s7K8lldvFif3XYRSZg7jeHOAA0zxqTdmg3JxdDp20fkLuuckiI/OXSEVa9aav8NOBIJSiRAw89K7ncm7axCFnIW8vW94SCce79EhjymW8sKuRHEsJQCG5UCV2YvJQQD71C4ZR3TbmSwwdlPwalzYUdzWX+AEeFmUC1wLYUw0oEgpCBfwhbjQd49amy00+WgfWsJSAp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwXEajosFg6FLShcgQpstFKykRIF0WmRbsuDXYbbzEY=;
 b=AQGo17U5ZboQyMwVCN+dTy6lZqYmXBccIXfb3IWdcxmn+2YEATNfh9JD2ZafSXAg6DX33w8dvi5FVNsUMg7/eORJKV9Yi0iQ+Ew1wDDDNx4NIFjHcNp1ZOaX/d2c8mM3mv0ManK3+k2z/LMBuzx0Xek+vpBkhtZC42zAZpLtU6I=
Received: from PH8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:2cd::19)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 03:44:57 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::79) by PH8PR07CA0011.outlook.office365.com
 (2603:10b6:510:2cd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Fri,
 18 Apr 2025 03:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 03:44:57 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 22:44:43 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <eranian@google.com>,
	<songliubraving@meta.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH v2 5/5] perf/x86/amd/uncore: Prevent UMC counters from saturating
Date: Fri, 18 Apr 2025 09:13:03 +0530
Message-ID: <dee9c8af2c6d66814cf4c6224529c144c620cf2c.1744906694.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744906694.git.sandipan.das@amd.com>
References: <cover.1744906694.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2530ed-a772-41a7-8d73-08dd7e2b6374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|30052699003|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GfYACEazG2/UCU6v+1QVWH1V0dMTGtGdReUI5nVc2RBed2na5bPpZ0QvUAgJ?=
 =?us-ascii?Q?Kn9hyZp57yBbfAc7DpPnOu9pNrlX8TDhk5hx6Iv22eFSbCj8rHkFuiuq7FJA?=
 =?us-ascii?Q?VBoAjvH1qgiO23WjxJfswi4iOD7ATwYMHkvZb7o24VUY5M3z/SsJRSGeLXwq?=
 =?us-ascii?Q?26nHFbk6Ns5jopEhnDl3/wNk5oGe76bVd2QIWi+qkq/PnMa6cqkW3K3tpQbj?=
 =?us-ascii?Q?gblYOUTOcKqp6jJkhkujnpw4XtM81zoq0AEXUalmNk4eTVqt6CPjIjy42vou?=
 =?us-ascii?Q?sey6L2/qvyQ7VOyLggpnevQxyaRYFsfGoQ14qG3uzK/DFcGhm83mT7qJWpHc?=
 =?us-ascii?Q?e7BxxrBEB82TesHwHlj+aamyRRJmuir5tAaNDcjnUm2OsJjcc5nLw0iYW20c?=
 =?us-ascii?Q?IJbZJYWmSRTq41QsyN82mvUbNOmova5Io10WbaGzC/X6NqieSMF/akKGIe3p?=
 =?us-ascii?Q?Kq6I23ZnraFsx0LRkkMw7mBv15p1kXjKEKGObl7GNPWoPPQunazJBgXmpbO/?=
 =?us-ascii?Q?8FvCoIKYDefB4GwLEWEh4pzPb+xFODRTZYfuExf5d2XIAopvf/bGmR+38zQT?=
 =?us-ascii?Q?ODs3oKWC+zgkxquxkcuiHFjFfI1t5gSgzHdFBwm4Wvn+v0k5qvPW4zGBwE6S?=
 =?us-ascii?Q?O93BKJoBhTKzN8BGU9i8LLfpP5v6+DpNPGXPYSvUvrKmB/gyGkIiy833FBUX?=
 =?us-ascii?Q?LJBaHMKnyi+SYPYSJPZzNO0FRMCM3WN69xVU2IbteoR9Y9j+lU8mSCF9GcvR?=
 =?us-ascii?Q?sPtHDD6MhyO+vn6L/O1CZOenz6GnfyjZ8M3Kio1k4OY+9nvdYIiXRYd/xtXC?=
 =?us-ascii?Q?dfNzgZgV9nGb8WiUGZzG/gcrAr05OYUxKk0ViTaG8v7WBiXXgTetJ16j55h8?=
 =?us-ascii?Q?3nMo50ki1n3POPsYt2lP9aes8e+QtrrkWELsStHolluASbkQbLIHD2XkHRIk?=
 =?us-ascii?Q?1thaSvj8rJ6LyRcYQfvOJTUDLwCe/Dgt3WxbIvHD4xFcZWHT7Cj0zUR3pWTC?=
 =?us-ascii?Q?uGwqvvDdrRcrsnhuI2CpXYtedCjXcpukiQ8z2WAagCKq0DLh8tSlsmiqy+e+?=
 =?us-ascii?Q?ehPqUuJL3wrfCAECXQ8moWaRbdcasGhCZN+1ihG+DEhFxhr9Qkds8bOVlU2G?=
 =?us-ascii?Q?MQKf3FlKsg10VRG/fFWtUUf7VZclAhvzd3XUhOLMyS7hEXezL+UlYD3wtpAg?=
 =?us-ascii?Q?yAklrB4Jq6sgzti0aIQoipUQUEe3GC81K5KCNHjMJQasjo8ZUFrmAgJYqaXH?=
 =?us-ascii?Q?6Bkq+2QzHIQwAKYZv2LgSz+knwqOcx2QhkEWV95AgJ3JI5++imGaNTSffza3?=
 =?us-ascii?Q?LkjilkfYfztwCMZbonhWyJ4z8Z6bJmhZPAP+1QH70+i66p32OEVYogjNTszV?=
 =?us-ascii?Q?dJjem1r+9dKzzH7zT9URwzATYLD+vPBiC+w4/J2IX++Vc2nB4wu44ogVmad+?=
 =?us-ascii?Q?LNTFUSgeS1dxTPp99agBLPnUcFNLjtxWi1Xqfc6hg5Ip91mRc9BHNRK0DHrQ?=
 =?us-ascii?Q?DOZxofaEmUopE9LksEU4lEz3nR9Aivg4WWGV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(30052699003)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 03:44:57.2192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2530ed-a772-41a7-8d73-08dd7e2b6374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

Unlike L3 and DF counters, UMC counters (PERF_CTRs) set the Overflow bit
(bit 48) and saturate on overflow. A subsequent pmu->read() of the event
reports an incorrect accumulated count as there is no difference between
the previous and the current values of the counter.

To avoid this, inspect the current counter value and proactively reset
the corresponding PERF_CTR register on every pmu->read(). Combined with
the periodic reads initiated by the hrtimer, the counters never get a
chance saturate but the resolution reduces to 47 bits.

Fixes: 25e56847821f ("perf/x86/amd/uncore: Add memory controller support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Song Liu <song@kernel.org>
---
 arch/x86/events/amd/uncore.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 70e0af36c378..d328de166481 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -956,6 +956,39 @@ static void amd_uncore_umc_start(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
+static void amd_uncore_umc_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev, new, shift;
+	s64 delta;
+
+	shift = COUNTER_SHIFT + 1;
+	prev = local64_read(&hwc->prev_count);
+
+	/*
+	 * UMC counters do not have RDPMC assignments. Read counts directly
+	 * from the corresponding PERF_CTR.
+	 */
+	rdmsrl(hwc->event_base, new);
+
+	/*
+	 * Unlike the other uncore counters, UMC counters saturate and set the
+	 * Overflow bit (bit 48) on overflow. Since they do not roll over,
+	 * proactively reset the corresponding PERF_CTR when bit 47 is set so
+	 * that the counter never gets a chance to saturate.
+	 */
+	if (new & BIT_ULL(63 - COUNTER_SHIFT)) {
+		wrmsrl(hwc->event_base, 0);
+		local64_set(&hwc->prev_count, 0);
+	} else {
+		local64_set(&hwc->prev_count, new);
+	}
+
+	delta = (new << shift) - (prev << shift);
+	delta >>= shift;
+	local64_add(delta, &event->count);
+}
+
 static
 void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 {
@@ -1034,7 +1067,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				.del		= amd_uncore_del,
 				.start		= amd_uncore_umc_start,
 				.stop		= amd_uncore_stop,
-				.read		= amd_uncore_read,
+				.read		= amd_uncore_umc_read,
 				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
 				.module		= THIS_MODULE,
 			};
-- 
2.43.0


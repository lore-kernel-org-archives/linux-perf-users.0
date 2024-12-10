Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D2231C80;
	Tue, 10 Dec 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823346; cv=fail; b=X8ynQ4ncd6LYt7ckaUgapYaio2va7Zn7MzGor3N5BvkS9G4+K7DtV+jP0U19K1LsezQF0Gf4nh0ifFZOiljuQZAvkuWIYQe9ltp5inhU0xDPuGAzbQccsamFNQA44CFG7mVdCanzpwcWLdkGfkXbM9P+Q8/PD39bWCXfbyP9Gxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823346; c=relaxed/simple;
	bh=dXVxjJv7mIY/YEnJmqXOZyzHe3BHcoTte7cJFi0tAX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZBhTNgSpriSD3AckzdMq/ZJZSS5K7klvuuDdASIGYY/xd6N7f/Zf61Lzu9yqdnpm9/MgIRi5KJl3AXyEwSJovGuN8Q2lXloRz/03igf71p3jg0yBLBTH6ho489RBOJBfkdcLd73MzBDWruPsyDo824rqwkvphTBo3nsBAHvdic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U6XtdUn5; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U6XtdUn5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StbXGOvYhGZw8s/dXnzCh4m3GbuQoHU3S61jTK9T8PK4x4O9jLjWRdbTiMGcYDWDgTe2wtBdL7dwrRih//pRot3jPmmtmHYY35YKTqlRETYtDTtks9MkDvofL6hWVFoihLvr8fY0xEZIQG10Cuc/15OpYexwA2qnBNdpdjUGBgtdrTQziFYSDmiYsvRZ8C5I+VC6Pi8u8+wEHRFgBNRG4CnEvlM3zADPpA6XqKE/W8YyDX+q8d3k41TalMlSe8l6EGxoEs+yiyS6LMh/E/2unogMqk/QqJAHKOkgoUMW+1jvm6pBIVGuedMTCZ0VskRavEC4jTWP2qcoMFqkv0YJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcY1kExmgIkETtefDOJ2ADwu3i9bJZLmUEZUzU1dHDM=;
 b=D/Vrg3KJuAfY/cN7kd/bpKNkMOrEBfckvEcj10sgcpI/WvpxiDCxOjmbN7VzlTp6aWildjL1B8YjVW55KbL16IAgBB21RpUsIuRYuaoLJWiA7OGjVrqRxVyNaF0Wb7ie3H4Usz+I1zGGHmSZxl90iB3u6A+x7G7EkFhx3NUSG4KinKkceNO7Cv8mzjis+05bRza08CDuEvBOyZvaEhNCTq5LEwi//7RP/AREqcs8AUNaQ+dBpvAsS8BdjUyhOiEw+I1HXcj6yOZ6rEEpt5q+eFHXgL2uZNiIKuFOwc2ND4cM5NnMfKBw2THbdyGkgB1zaG3FHuztmazRRF/M1K3fAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcY1kExmgIkETtefDOJ2ADwu3i9bJZLmUEZUzU1dHDM=;
 b=U6XtdUn5EbCGMkuOTzDHwqMrGC7tSCIlLEHuhTCXJE7n9rHw5jsBrskMNc48queJNq0IUusmCUlCdlqWs7uvIso8iSRC2ljvyrCOVbUoFPLZAa254bFY06c1e2j9R068ynDqElGB76WOd1a1nX4dskhltPKnD8AWa/7qPJbKtOE=
Received: from BN9PR03CA0872.namprd03.prod.outlook.com (2603:10b6:408:13c::7)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Tue, 10 Dec 2024 09:35:39 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::31) by BN9PR03CA0872.outlook.office365.com
 (2603:10b6:408:13c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 09:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:35:39 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:35:33 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 04/10] perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
Date: Tue, 10 Dec 2024 09:34:43 +0000
Message-ID: <20241210093449.1662-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210093449.1662-1-ravi.bangoria@amd.com>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a4d317-7875-4754-623b-08dd18fe0215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l8ZLRzWQmbm4ZGhISCKKb1mwBju1PkkjXs6n+ZCLleVI7f9by/1OgLSOwfW9?=
 =?us-ascii?Q?//bZpTB6cNe/8kn+2yA8rfFTSyNli5TLRMm+DZkk1l5C+fnwk3qiv2XeOegC?=
 =?us-ascii?Q?+L66jjhbCBdbI7pEm0Kd8PAAuedP74bbPFnUBcg+SJUa21X6qDLJ4H1hPzlj?=
 =?us-ascii?Q?MqEK4HVMr4DFjO1Hl///8PQoX3SKKPflbTn4a8m/GL05KyHP/gO8LJXB6dlg?=
 =?us-ascii?Q?wsV+VaxlRN7oOjLpBpk/x7xgBz7qwnBqCLskv8x0Uhf7ugiEXnWPuwkD8WiJ?=
 =?us-ascii?Q?emqYQYe99oZ3jWW0kTt75+Q8f/XQUcDb2HuGvfNQS+x3rArROALTc+ADCSsc?=
 =?us-ascii?Q?CDA0H63Bixg8D5RU4SxeQ5PXAMJH9kaxbWMEXf20bFf/gN29YuD7eaQDVtMd?=
 =?us-ascii?Q?IK7G4MeIpOJEOSzOgflRLygvq01hiel59kDXxPovyPHLj3+pggNgvu27FYnN?=
 =?us-ascii?Q?yQpF4+DpgddxsvrCB6LrFGtKkOsZVAjRIuzaOOxQRqTrLQQ2vSYVQsBoHgDS?=
 =?us-ascii?Q?InbGiYDGzLS8tdp5SwHeOoaUiVt59wmepEc5QoWRem7ZbVAo1pBYcdqULFgo?=
 =?us-ascii?Q?Ww5EFbAtpmJCS9SzccW/X4K1q9UfV4L4Z65y9I2ja8DxtL6Pgzw4pa6rN7J1?=
 =?us-ascii?Q?3MddFTLZyvInnG9iO3EQMlkulzDiaVOwBxASwjmQ5qm64JKgYTLoSzrMfSxk?=
 =?us-ascii?Q?Gc/XhHu1P5RXz5IroiwUDwc+ayAx4L7can56dcqpJ5wq4c1ww22hBuWrgbU1?=
 =?us-ascii?Q?x0ObEbyw/bXMU2O9Spl1J72n96085H1SORpvuKTLUhpY/8naqRWYhBI0EwU5?=
 =?us-ascii?Q?yk6efS2MNtzuQcKSja3Xka1j3NdOqM984EDW+OGo3O+YIQXmRmDDPd9lO5BX?=
 =?us-ascii?Q?iZl1z3qWGyEOPMup8inoxQ1qobNvhGHiGPo3v/3DpMpneQQPztHP5LG6Q7u4?=
 =?us-ascii?Q?ygDaHmXLSJadfchl/AUbpiO3yYKDnVx7luOsyTJG7AGhGeAB5mPHXCfWcEoV?=
 =?us-ascii?Q?ZxybbyxMLZmNn0OT+CWa2wOipkydme8F1zrzLDbm8cTUevzAQT6FnlJELLj4?=
 =?us-ascii?Q?wD/228ewsY0kNdVhIa7GWcK7k7NYPu6nMYKCwV8rFTKJxW1aehUhccxtCWtP?=
 =?us-ascii?Q?VVn+PcrYUfsSGOM6TwyANgz8hMSoeCMhNELCI6ir5wDrPn8d5F3QbxeowGvh?=
 =?us-ascii?Q?tNfWdCnaIbz6XeufRl/gr1HbnlNzTrEphK2sCOBHukfXpvLMaI5CrbksMxZH?=
 =?us-ascii?Q?W/PFZpmg8I+Gr9aBrjfmATfOFyLN3KXMDlQZyjZ8IP0HQ+3i4EfWzQ38U7SY?=
 =?us-ascii?Q?syydTH3tbGXgjh7mzm6jKp1dXTTJmOtJDhR+oQeT7aPxgA03Hk5OBeLgnSxq?=
 =?us-ascii?Q?R5y10VKfiKnMxT4xYsTWRBo95uHNSnKd7i+qjjvDwylmnzu4/mmuSL80fnq1?=
 =?us-ascii?Q?5JWXmkd0llqZgv8jXMbCyIBVeKcKPg6q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:35:39.1412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a4d317-7875-4754-623b-08dd18fe0215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312

IBS Op uses two counters: MaxCnt and CurCnt. MaxCnt is programmed with
the desired sample period. IBS hw generates sample when CurCnt reaches
to MaxCnt. The size of these counter used to be 20 bits but later they
were extended to 27 bits. The 7 bit extension is indicated by CPUID
Fn8000_001B_EAX[6 / OpCntExt].

perf_ibs->cnt_mask variable contains bit masks for MaxCnt and CurCnt.
But IBS driver does not set upper 7 bits of CurCnt in cnt_mask even
when OpCntExt CPUID bit is set. Fix this.

IBS driver uses cnt_mask[CurCnt] bits only while disabling an event.
Fortunately, CurCnt bits are not read from MSR while re-enabling the
event, instead MaxCnt is programmed with desired period and CurCnt is
set to 0. Hence, we did not see any issues so far.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c         | 3 ++-
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index f95542b75b91..d9c84f1d530f 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1245,7 +1245,8 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
 		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
-		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= (IBS_OP_MAX_CNT_EXT_MASK |
+					    IBS_OP_CUR_CNT_EXT_MASK);
 	}
 
 	if (ibs_caps & IBS_CAPS_ZEN4)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index cb9c4679f45c..aff9fc693b11 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -510,6 +510,7 @@ struct pebs_xmm {
  */
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
+#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
-- 
2.43.0


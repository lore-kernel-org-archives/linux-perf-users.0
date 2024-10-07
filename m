Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F24D8C8;
	Mon,  7 Oct 2024 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272922; cv=fail; b=iSqLP3vfVIynvUlFD3lOVBQUJeMEXxdIJXm8qJEVHZVCp6pU54DSRZz0Algx6ZlNUm8kh/OfZ0m8te9fgf5yoHY2OmtQhOqF1mhOx0q3nACVOh0H4tz9B/Qzwgc2o2DZ7bwzp4iLzfZQZexLTSXFoGrYTtP5eD4j0GfvhRD2+Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272922; c=relaxed/simple;
	bh=jT9Mmx3H7Uj7maZiMLpzklktwWbD4ef8yowtltfH8w4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGciUQTedX2EEOO6Fo7DiopYGoWnQOO1vadk4JfiDRT+XoqRD5qpU3rc9j1wzNX0B6pxVgICr+azbqwCaWjINIk3lWT5QR7odY7o0H8nGxspIh8b3POXRQgtizIrIZaqRAfmbJjZ3Z0vQSjpAs+aFmZLLvsix2c1rgLACivH2dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K4/lxLXr; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K4/lxLXr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcL25KBPe+QfOlWUe6kZ5GirWqOaGTAPiLVDFIHHVcSMpj/STX6caTpYBTfdsEm6ZrXD3qWriVmO+ZogMxCCqPsBGgqHDddwL6vwyqnA3DvTV5hif08cieCTZl7P8QnaH8M+5kqgcDry76nBLx6W0YcLLaxkymlhh6IM6LDhbm2kZ7uIYyHaQLcSuEqQdoCgG70F6OmrRl3NJRYQ7Wo90cpAJ7nmyFG/ECwJu6kBjxx4aJMJHXuyppugWdqaBJ+fKj0Jw2fjkzbReOfQmF1Mrhloh62CbWNt+dudwsPL6YUfH5tqojMxABrgDrZD5ycyFYHaZxqiI/ekqF+iPLplMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKVpkQejlpG+0J2jlvNe2YEkBXw+s5UeHcOxpvoYwtE=;
 b=iNRhmg2pAltkfAehNr4gWaGO/xxIfpFSk99asKWGkxwXCYHdLv95q0yVvq7FYo4Dv+JQRC7PdyN/9CjPtm+4cSYiw68uw1kUMhfsSXGE6/vCwGQGV8qWSdLbj4Cnde/76BAQOeKeXhRhgSjBdjmh4KTNDxPlT4iv1B/bIz8HIEDRqKvyW9UqISH45y7nUeyKxQrrcYGu9KN+4yNRol8nSYRxDERkDT3sDjX0rxrtW1Tivv0Efz0SwPH2ALixsDmTrEMnKMw56uSsbUUKfk56s1GgcFQSUEnFbbKnO9mQi9ZBeTp4XoTSpud0tRU4nIK+tH5wm6XwanBhhsz7PgJmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKVpkQejlpG+0J2jlvNe2YEkBXw+s5UeHcOxpvoYwtE=;
 b=K4/lxLXrkwwVXyKODIdqiXNit4fexLtkunR+Sb30femp5r/S5cfjBrYAlB63osMXtXmYMbVnuIz56/UI0aty4LxTTnXoA+Nw5kOMCNstizU+bhxzZbopu/Ip/6G93hTeUr/TTMXlpFO8rejYHXBeHXuzPqoniRITCoUPJA/7DMU=
Received: from MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 03:48:36 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::8c) by MN2PR11CA0030.outlook.office365.com
 (2603:10b6:208:23b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 03:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 03:48:35 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 22:48:29 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 1/8] perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
Date: Mon, 7 Oct 2024 03:48:03 +0000
Message-ID: <20241007034810.754-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007034810.754-1-ravi.bangoria@amd.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e326a4-e25f-4626-1833-08dce682ec02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6qy38TnMiJwzgBu1jHDBCv5TkF4dI3Tcoufnk+CJ8HtgB20k3KSo8j8wenCj?=
 =?us-ascii?Q?KF+7GqzsVwpZcisn4hmUqTbRhTp5FHWL0e26wL8faPSatViyRqJ9DmqnaNmc?=
 =?us-ascii?Q?8N4D4X6z178abgpXzw3DdtZrXXNo0EYd+B0dB/w8nmm9t46I/H22RSE2LZg1?=
 =?us-ascii?Q?Qni293bk/Kh/JZ4oSgNK2WVs35b/z8jtHxFvgSwp1P3avhjcIYHNxRRpdRJ1?=
 =?us-ascii?Q?z13xoOdbVS7qzAv9IQeC4Xze/MU1DgB0HHIs82OHuhVX8W1a8BXrNf6ZsHD9?=
 =?us-ascii?Q?N2pCPytYMIlDXj60AtJLr7lBQy9PvpxuH4rwbIeJ6mQSJdNrZ9XeghnsfMQT?=
 =?us-ascii?Q?JhEzznyO51MxuPTvmVsGilSqYzsY4xKxiRlEqc1D2bA0Wa4aj26uhbL3EzDA?=
 =?us-ascii?Q?TovYIQhNsrMVNgwT2YdNoZIIUh5TgkbQLirPxcbXJHXfCsjK9VWeyGdxM+9r?=
 =?us-ascii?Q?6xlUIOrMuoyKTwwMfiGnDJ3w9uyi49UfRsAYmBcJN++6kWE8eQKIPMugLhMQ?=
 =?us-ascii?Q?E30xFlp2Fooq4WThxvJo1JHs2BL4XZBxlmc0bqsC/NAkHohKJdq5sKwmjdiq?=
 =?us-ascii?Q?j28g+A9P2S/e+DIiNbUqmKZIhu9GbWDjNi33qoMU5pH/3vs6H0iXLQrWQMdx?=
 =?us-ascii?Q?KQiWFtdsl5f4aBzDWTac50EHdy2YSW5Newo0WYUigHGJ2ELlqleDsVxyp7wx?=
 =?us-ascii?Q?1gw+/8oKWEKTGFIH+mM3AmJyYW/o89zuL3yDwYb9EGBwedLsBX1s1m3mKYG6?=
 =?us-ascii?Q?1e2YVLtnuULPAaUEuYHhqEk9cUPOTEUor676OiwZx7q3v6HKl9G8gZzyy52R?=
 =?us-ascii?Q?6rFQQwRfgxrRv7mwQGPv64TTpTMqFGlWIMK1lvKplDpr0Y2vWK3gQ9S4uZMY?=
 =?us-ascii?Q?IVJ7/BVO1BiIFvAeS0PylCGNztd7emvA7Y+jRDVntGzmTiXblj6UbHbNMpzd?=
 =?us-ascii?Q?pCUtdQ8mm+Rrd9Hu0i/0jejKx6xkT9PC4uLKeNNpuEGjguvgjMrebaq7doE6?=
 =?us-ascii?Q?WhBnHm15eCmUK8qlPqhwOgmOPD3dwwOHN3you77zblRIq1OlWn/3s/R6VnJi?=
 =?us-ascii?Q?O0M8dvMPsHcXKQ4oYSJggm7SwdOEJk+W/a3ZWTUF/YlhhOWAINUZYIvE02b1?=
 =?us-ascii?Q?eVVppFhNbfrAPLBrSpUyCqzwyeQqBjDvJSTlqZsnVsJ+MMfm44cgn8PMSSkn?=
 =?us-ascii?Q?9KUT6qEdYX5jvBi67s0JqKxjw2cg+oq/T6F1kGyHLiuS/+d+S1c1CfizbK9P?=
 =?us-ascii?Q?1bVsSJ3/+bqy6met9GUIK9UuEWzxAMZIQ82IfootmJUmMXtlncEOUz6HZEE/?=
 =?us-ascii?Q?Ei/5nZDrbp3VWNpHMtArv/3sm7NIs7bnWYV7I4LuWN61SywMXtL0fRvIAkMg?=
 =?us-ascii?Q?vOpop193HtE17fmoq2vaG6rMbAFK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 03:48:35.8527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e326a4-e25f-4626-1833-08dce682ec02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

Definition of these macros are very simple and they are used at only one
place. Get rid of unnecessary redirection.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e91970b01d62..347353b9eb70 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -28,10 +28,6 @@ static u32 ibs_caps;
 #include <asm/nmi.h>
 #include <asm/amd-ibs.h>
 
-#define IBS_FETCH_CONFIG_MASK	(IBS_FETCH_RAND_EN | IBS_FETCH_MAX_CNT)
-#define IBS_OP_CONFIG_MASK	IBS_OP_MAX_CNT
-
-
 /*
  * IBS states:
  *
@@ -670,7 +666,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
-	.config_mask		= IBS_FETCH_CONFIG_MASK,
+	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
 	.valid_mask		= IBS_FETCH_VAL,
@@ -694,7 +690,7 @@ static struct perf_ibs perf_ibs_op = {
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
-	.config_mask		= IBS_OP_CONFIG_MASK,
+	.config_mask		= IBS_OP_MAX_CNT,
 	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
 				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
-- 
2.46.2


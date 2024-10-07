Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E861FED;
	Mon,  7 Oct 2024 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272969; cv=fail; b=sEzfqI+UTY1ozhP6RCOSYDrDtAaJ4QiyMiA5Z/lXghNh5Waw5ARBbbMeIIWoprbO4+FJ01HcCeAv8oCOZCwUZqEhNAxlzSfT9jG1Ci3MsrS2BbKfzUuaZk72nROgnQ9tRx8yhB1n5m35NVPZUuV5g8wXFrniRjqgsCBLqI/ebCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272969; c=relaxed/simple;
	bh=iWX0K0Qe3Po7SwsgbFWpYd207NZCHZlnGb3ghK/d7ZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPVvBNbEQSqkUQIFZc/DXdOnvS//mXKbDlX/SrcK9OyClmIKmTA8l1mOsftitgAUSJh7E3ch/df7Y9W8/I3DFvm11Tp4JyLN0hjdgXN84P7jocqdbTIaxKM7FL5uuzFZv+g7BthiZw3/c0fiW05KdczYC3TSeCY7SImuwZ2qmB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GG67tXq2; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GG67tXq2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bxqvrb3nkAdvMhde7azkX/RApX8zThFS9DqI9SH+eo40TAZRR4r/LvrU3r4zrkx9haR15ko24+37ur4Fy1th8ckgNPAoT/0ePtI3sw3iXufqUSB0Vinv7tKkjZFAD1CvXP7lWEu5wPjiBTW2V2I808+fx451A99RLQKQIkyS31W6Qk4qL5WnaEju2a4BaXswpvS6a+1vThkaWQQZm42CD9vN8UA2MjwdbSdO5wo0ZSs4pA/3BmYUSIshr7B0gKUvE2JAGaK1YqfiTMhUg9g5LxJglV9Q4q5m1cezuGji45oU/QBxHZ8XNZqfsKBY4utNQ1NvKf45pTbtFszkSjBb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGPU34SA41ijcHJs/2I5+9tZmxZ50d1ttbC3+YbKafQ=;
 b=qocVfw0AM2WugUtB3G1oC+lcY/fuHvWp2gbIscnOuJZW0CIDTvedhfOHhxOLCiJYZ0vClEFde/rC/StLG7eBtpLYrE7EfcDeeR4xd4fOHw6JMx9yb89n6Q5oZGEeMQ9vANJyGW3ow/pm2hupg59VQHbH2VJn0fCcA2OFhNdEAhF36h68gkejeV8avqZy0emIKvgDLhXpFxU9sFkOgMkd+eKQvXuR/mOYMF+yUKT4/uwvqdzNkp1krgE1ToaaTTe9kidtc5jSFUMii0dFBCZn/SxHKO2ZiRBuvLUW8PZ43V8xF7yNFGJ0U7bONYYcuErRGibqSKRpwzIcHgFCL0RRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGPU34SA41ijcHJs/2I5+9tZmxZ50d1ttbC3+YbKafQ=;
 b=GG67tXq2e/uIsGUCpfLxxMWMtk9rFz+9yBaTRYoDlHv7NlnuIiPlVSd6423DBRIS/zhRwHEITc3mvOlzysEcp4m9+L1q4RwFqNAXtHZxtG/C4mMYpF7ZBUITK3ZksugqweZ8Du5PpodHWyE32ll0KkQMYOL3P1V9WeB0IK37XG0=
Received: from PH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:5::35)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 03:49:20 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::84) by PH0PR07CA0030.outlook.office365.com
 (2603:10b6:510:5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 03:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 03:49:19 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 22:49:13 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 6/8] perf/amd/ibs: Add pmu specific minimum period
Date: Mon, 7 Oct 2024 03:48:08 +0000
Message-ID: <20241007034810.754-7-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: c54b30b0-0370-41cd-7731-08dce683062c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wE2Kt7rNPQSV2lFSv2Dh6jI7LUKORJ8LsvdRnYfzmFpag+np8JAnX4CCQuJY?=
 =?us-ascii?Q?xpqo0yBEgfCJNlF0n5biBzg09zCyaAT3Oz+dlxbE03OgMsMpcnnQeBffgioO?=
 =?us-ascii?Q?0m3Iv22SH3QO3I3jw4KkRfTm0ZMdZzXQcFqIZFUaE6jy16f0iQDNO9xZ4Q1r?=
 =?us-ascii?Q?Fz9xvAQWymO2X56rPKsNm5QsMSYv92utFiZBGBmxrg0jk1C0d3tcIpPt2lHr?=
 =?us-ascii?Q?JM+CcSYd6EWkl0D/2gJsHvvT0itGaXDyhOtlEMZ7jW1aMJfYfDf4m3B4c8Tk?=
 =?us-ascii?Q?52E2r2oGK6BQhoYXNmI88sGbm8Wr54s1xvsSNRdUPaKWVoyEhMldJlQkWut7?=
 =?us-ascii?Q?X/tF2+fV1/34sTl7vIL5PHTa55jNQ1lk7Q3n9NxuoiGsebaVfV+D8Uq4LYxK?=
 =?us-ascii?Q?Ul8koyJzF/ZGLrsM9d0UMM69fcmf93D8fiNM2rlBIoNxuDJ7g7Uu+TDcWZWq?=
 =?us-ascii?Q?1uF8sJ9SWQ1gcO7Fw/FpvY8Jwzuu+7QX5RQ0UUIJGTc7wcWfRMqSOw+KMSiu?=
 =?us-ascii?Q?C7SF3xIC28387HuOU6JfSQxy4noKNW/BnM+wMKkPOW41p6NcfW0DlCwTfCD4?=
 =?us-ascii?Q?bdR7DWCN+L9MEX4BXsw6dseGecK2MhFeVmC6p+zcoEctA5cKAQ4sIvm+dQLi?=
 =?us-ascii?Q?GfuQ2sKbRj/645IHPEQ6qbm/jTykvmwMlH0iMozTvkx4TvTi+Nje8ldcr8qs?=
 =?us-ascii?Q?qvcdJMf6vqX8dq33+16F8eZi5OfCVHZ3AQFt97fYM7ex30XVfT9S079vImfl?=
 =?us-ascii?Q?6i14BHxvGWqb0NByvaJshyIn80GZ6rBJviZlvzzBRY3006ef77rN7aJ4mmty?=
 =?us-ascii?Q?xIwt/dHuboQLOfom1J/aHsVYq3OaP0OPdgey0RHZ1oJbjMnUfEz/FZQU31bT?=
 =?us-ascii?Q?rQlBFNj9lfVsQK9hG41vqRYHaY/JuYdBFwuGXgEgbJ4Hl3OYL4Ynxi0FLbjY?=
 =?us-ascii?Q?hArn7LsDAymf1tLOXzK0nHRpe1K5+hYt0MXLjx/w3KhmtWbUGk90FNWQyZ/A?=
 =?us-ascii?Q?hhjwHvv9R4sMXgNiP2tUhj32uAQNwMo5nxWKPbAIEdHrNtwohu6FtgyyGqnb?=
 =?us-ascii?Q?fciR4UwvRdHWED2en3dq99utbDzj8m2LymsCNRGHnbF3XM+9EcAqr7PjqNHL?=
 =?us-ascii?Q?99tVPVkOU1qQ4L+8QEF0LbasQh+b19SVO7gDtot+UYmtMmwiq3J5m8y0tfVe?=
 =?us-ascii?Q?7kClUFzakOJlaHpsAILMOwnFIBqM3ilfE0WgH8vhWTkjN13kRPh24ouKtF1d?=
 =?us-ascii?Q?LPnp/PQX1gWSYoojlSJsnLxvGhS4mAntir95vx1rdEsEXt/htrDnJGDukfUC?=
 =?us-ascii?Q?71IIzwjjn9PHtiUGqdK5T4wqXtiQo9ggGq5TpsCb12cz1/45oiqDljcqEIjh?=
 =?us-ascii?Q?f31KKcVm3Lwol/ixhGhk4+lEV8cZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 03:49:19.7511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54b30b0-0370-41cd-7731-08dce683062c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732

0x10 is the minimum sample period for IBS Fetch and 0x90 for IBS Op.
Current IBS pmu driver uses 0x10 for both the pmus, which is incorrect.
Fix it by adding pmu specific minimum period values in struct perf_ibs.

Also, bail out opening a 'sample period mode' event if the user requested
sample period is less than pmu supported minimum value. For a 'freq mode'
event, start calibrating sample period from pmu specific minimum period.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 368ed839b612..e7522ba45a7e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -83,6 +83,7 @@ struct perf_ibs {
 	u64				cnt_mask;
 	u64				enable_mask;
 	u64				valid_mask;
+	u16				min_period;
 	u64				max_period;
 	unsigned long			offset_mask[1];
 	int				offset_max;
@@ -295,10 +296,14 @@ static int perf_ibs_init(struct perf_event *event)
 			/* raw max_cnt may not be set */
 			return -EINVAL;
 
-		/* Silently mask off lower nibble. IBS hw mandates it. */
-		hwc->sample_period &= ~0x0FULL;
-		if (!hwc->sample_period)
-			hwc->sample_period = 0x10;
+		if (event->attr.freq) {
+			hwc->sample_period = perf_ibs->min_period;
+		} else {
+			/* Silently mask off lower nibble. IBS hw mandates it. */
+			hwc->sample_period &= ~0x0FULL;
+			if (hwc->sample_period < perf_ibs->min_period)
+				return -EINVAL;
+		}
 	} else {
 		u64 period = 0;
 
@@ -316,10 +321,10 @@ static int perf_ibs_init(struct perf_event *event)
 		config &= ~perf_ibs->cnt_mask;
 		event->attr.sample_period = period;
 		hwc->sample_period = period;
-	}
 
-	if (!hwc->sample_period)
-		return -EINVAL;
+		if (hwc->sample_period < perf_ibs->min_period)
+			return -EINVAL;
+	}
 
 	/*
 	 * If we modify hwc->sample_period, we also need to update
@@ -340,7 +345,8 @@ static int perf_ibs_set_period(struct perf_ibs *perf_ibs,
 	int overflow;
 
 	/* ignore lower 4 bits in min count: */
-	overflow = perf_event_set_period(hwc, 1<<4, perf_ibs->max_period, period);
+	overflow = perf_event_set_period(hwc, perf_ibs->min_period,
+					 perf_ibs->max_period, period);
 	local64_set(&hwc->prev_count, 0);
 
 	return overflow;
@@ -677,6 +683,7 @@ static struct perf_ibs perf_ibs_fetch = {
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
 	.valid_mask		= IBS_FETCH_VAL,
+	.min_period		= 0x10,
 	.max_period		= IBS_FETCH_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
@@ -702,6 +709,7 @@ static struct perf_ibs perf_ibs_op = {
 				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
 	.valid_mask		= IBS_OP_VAL,
+	.min_period		= 0x90,
 	.max_period		= IBS_OP_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,
-- 
2.46.2


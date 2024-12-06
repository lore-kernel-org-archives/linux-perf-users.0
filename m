Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AC196C67;
	Fri,  6 Dec 2024 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462272; cv=fail; b=Db9s0ZGMkXBT1/j0im2WS5o2gyGP+J/PEHqz73Y0HhfbtnKzm2wZ8EsCVn5IgWtJog4sd0kx2yjdJlry31ySC5YHQmWo+2zdtGfUNsXewxSHYyo0w45EfrzJJXoL1ELT+pxd+ccR8e8rz9EFZqqRSgVeAXlVZxs9Ri4TL88cQSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462272; c=relaxed/simple;
	bh=UdYBauzwWinsQHWMPi6MEHqJ8+0+wavhWheJn6MFJKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkR5ARtTboeSASCYVEr6dqteIW1jlwIyZeESMxaK0uCCqKen8uMllhQ5BmPMJwE7ccBkeiUL0D+t11L9jfFt+JBdrwM0t1EjE4IJiHH4ubYZYJ5yddCxdFWyrou5GlmVUY3YaSWx2tyUVQVUJVUZFtBitugJU72IsYyk1h2LZaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NHFfZzPp; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NHFfZzPp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+MYdyIz0GZDC+tOGrrTmJxg9O9EjcHjntYK5NoOEO2IjFccygksSWWQixYpecQcE1SvRyk1ezvq2241HKbO/SLHNuprU4E38x5nYYTdEMwub6GEzP/aYUukMum1i5btcbG5ZslTUqlo1XspBwWQ0osjZjfVB7CcntJCFS/4+Z5uj7woCA2/wM1Kzg0S3oAwvn8riB+ijq3zGAlPEJeejWzZCHq8Xt7RMnFTTPTh5bJyOY7XbN+ay/koaE0n1215CowEnX3ZJZKWwvPNYo6So3QV9Y+J24BBDW5Ln47afzeAbX9uxDuOHNlnrdhaByM/nr6013Su3Uw2/HelkVPq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGYyRwtz7j1mfXSH6uKhg8DIV/8gBFNxUV+TomRQYoQ=;
 b=WT66u81P6k59eIzihCgJXv3Udry+kfP2xuNsTs+UdkojhL7/7I1to9TK8eDTlZrMqDXEYWPNZu2jm2M+3Q7WUW9wNJ2s1JDgiJwG482/FdHKkv22uThPjkojvL/xNq84fgwUVguPI2VDdshcBWKcV0SITSLnkH1R35WoYAf7Z6RQxhYdF372wne0o+fOG45YU3PiHAQorWVGI3nh0ss1kTy7LR4QNMSoPrRqV+hPqrNBFHHwsYiR+v8c1VMnpw9oHgB72jpLIjfb9Fw2UjC4bbt6vN8yoi0q4ki/Lk0cPMntKPb0LyMBpOo1F05VOKIxbRAdu0c6Jd0OT0QHKgZjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGYyRwtz7j1mfXSH6uKhg8DIV/8gBFNxUV+TomRQYoQ=;
 b=NHFfZzPpC+MPEowMGDG/0tTMR3mJZvYSo+do8DZP6nzagVGeG7GuajpBuOPLoB1hgNyJA86L85P5yXbdhWkS5ZfqQZoQ4Rrs8JBUWWHHJkMK1iTeZnB6PTIVB6Q1ikDsYe/9aKH354euWgRE6vhG8lr1NoaAquJOTSgmTf1/v+I=
Received: from SJ0PR05CA0106.namprd05.prod.outlook.com (2603:10b6:a03:334::21)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 05:17:45 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::24) by SJ0PR05CA0106.outlook.office365.com
 (2603:10b6:a03:334::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Fri,
 6 Dec 2024 05:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 05:17:45 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 23:17:38 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 02/10] perf/amd/ibs: Remove pointless sample period check
Date: Fri, 6 Dec 2024 05:17:05 +0000
Message-ID: <20241206051713.991-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206051713.991-1-ravi.bangoria@amd.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4e45ae-e01a-41bd-b3b4-08dd15b5512d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zBD6y7NqvDGXacEwV1g43NabqJMWOjfTWm7HdSh1YYc/5rUUz+v+KHeP1YSS?=
 =?us-ascii?Q?8L+4WG+NgYRzENThzV8IBMV9yWyY6t+BFb2eXtcq0S8uiZkL+Zcq7yAqM18s?=
 =?us-ascii?Q?EO/0m/nYyoMlvqOFwNrYGe/t4JE1Cj28dq6lh4ydu52U6cv3GFAmpObobF9Z?=
 =?us-ascii?Q?Y2k9nS14ql0g1ElQ3fozSZegGdXXymGqkkU1NvtJJrtNqxtCKrr0uhTjWuRQ?=
 =?us-ascii?Q?+nCCEIBdel3QdKmkJDMBS+Qfo2yKs5+BlG4psOtOUwpOGsm3Ym6jJegvlYpc?=
 =?us-ascii?Q?un2b4vlzLE7xx1ccpm9FaQV/jYrN1zCpNUTC6FVxBzHdL7GFlSBjZGMvYTng?=
 =?us-ascii?Q?z56JFcfw3v8MFF/PPOtWyMkLNtFrxsDKWikoTop4D86kd2NTgYGBEQOhVjLM?=
 =?us-ascii?Q?JpIJacSu+pncjLeHzr92DcwJhm6aytNnuJfgyo0eea/PZSWGIY4LuignRmfl?=
 =?us-ascii?Q?XbovWbJweh3FIZVXvmE2tWlfzImHJkrTlSlaO9xERGNrQ9b5VPLpH+8wO6Gd?=
 =?us-ascii?Q?b87lDYby17rKlM5JKnNfOEhnFeURP8djxcDUnLYYaIcuhgqYqZkW9jtbGhNl?=
 =?us-ascii?Q?/9RMKAO0YHId0C5/nC/hhxg+GPWHb8hjrbLbOT7Oygjf3yhuG9lWeOzHSRm2?=
 =?us-ascii?Q?8BobmP6EGeFBcQF7rVBUjAD9YuQ4SlUIPqVSOZVZwkpyE6wc2xONN20PZ0d7?=
 =?us-ascii?Q?jvIVUSEGANvNPCw7BZQFSSJVjNNO4Pq1YnfoIY385WQCsyHuOI6J7cCCJYUH?=
 =?us-ascii?Q?rfBRXneX+MVexyJ4AHFKx4MOM6Nr+77dF6EkyOrkUOAMZjHGX9kqDs37HM5X?=
 =?us-ascii?Q?KSEk361qQUo9F3v18uNnyp0APAcD+ahugrFUJjToeIa8WG3Q08bUNEGMJcNV?=
 =?us-ascii?Q?gwKUbfd+6gK+TS9UcIygvmIpivznWfWYhz46aHSc5Pun6cqgZd9qU0/uNi7W?=
 =?us-ascii?Q?Ru7YC2kfE+Lo7QdXKzDLLtA0Q+4QFYRVPx3/qHLScn9+2a3z2Yx+Gm7Q1tgy?=
 =?us-ascii?Q?2z/J0+Y4zWjpzdvyXBaUep5I48fw4OwLDFDQp3Gt1X1JN8ynIAEUBLOeKf6q?=
 =?us-ascii?Q?DqAEzeX0kuaURAVe/bstbtft24023cAX2kQzIFHUosGX4GBrlNDaeR6eRTZm?=
 =?us-ascii?Q?AGu8ctFILP46s9MGajUMGkPmLynBfZS+kcED7DTkYZ774zDRVPnGBOeM+0ZF?=
 =?us-ascii?Q?dH7iaqorCQdQXSmX1c4URJmkyAaCwiLY66JDouUDXjKHU0HwwbIV5tALOSqd?=
 =?us-ascii?Q?IebuyAGBrmcSbHpabDq8a5zaydGMEjTBCsguL1mRSal+v93jf+t5SZiHhwYd?=
 =?us-ascii?Q?Q1MMzFjtIujhByJp/1KTHQfgxU/LyB8HTKaycBmvwhh2XRztqLUvG1PNS5YW?=
 =?us-ascii?Q?bA0VPbXIhkxjzfErTytqWftpDC8/45uTUEFcY3ABxUdmldcMQC61YMiqfktx?=
 =?us-ascii?Q?iEhh6IXKrow+ss4/YXuYHFpN6WHrzQeM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:17:45.0129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4e45ae-e01a-41bd-b3b4-08dd15b5512d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067

Valid perf event sample period value for IBS PMUs (Fetch and Op both)
is limited to multiple of 0x10. perf_ibs_init() has this check:

  if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
          return -EINVAL;

But it's broken since hwc->sample_period will always be 0 when
event->attr.sample_freq is 0 (irrespective of event->attr.freq value.)

One option to fix this is to change the condition:

  - if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
  + if (!event->attr.freq && hwc->sample_period & 0x0f)

However, that will break all userspace tools which have been using IBS
event with sample_period not multiple of 0x10.

Another option is to remove the condition altogether and mask lower
nibble _silently_, same as what current code is inadvertently doing.
I'm preferring this approach as it keeps the existing behavior.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 26dd5e5874f9..484606a9bf6b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -294,13 +294,8 @@ static int perf_ibs_init(struct perf_event *event)
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
 			return -EINVAL;
-		if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
-			/*
-			 * lower 4 bits can not be set in ibs max cnt,
-			 * but allowing it in case we adjust the
-			 * sample period to set a frequency.
-			 */
-			return -EINVAL;
+
+		/* Silently mask off lower nibble. IBS hw mandates it. */
 		hwc->sample_period &= ~0x0FULL;
 		if (!hwc->sample_period)
 			hwc->sample_period = 0x10;
-- 
2.47.0


Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593925A640;
	Tue,  9 Dec 2025 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268824; cv=fail; b=nH+6C8wMhsKc3qTDbijrx3tmbM5Tglc8+i3kvzvTMe78Fz0RaO8Vf38s7WsxUD/N606e3prF7isrO/YcLS7s/z1lfTkUqZvsUfJYhI6aJ7sJnL4aihDhrfzTPdYrNBSA0H1lbEAS6oupWYzcglfNYo4lJeWBh+XCaONkG8ZE1ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268824; c=relaxed/simple;
	bh=Bt9YvVeD4dPKEsFdC7zCpZjsPonIlNxowjyp3dvuZDA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LLgASrQzg9HcyEDJB4Ug12RG3yCCkFHQK+PwNgShNVRvlTzEu5U/Y+SKpKjFqFDynwvgcwRq2Hg3GRjPnBbdBHqIjuEjZrXTxNZHeAnzUKb6I5XtWVPr9VBMtVwPtp5jAfXO/zWhUAMQX54gol4ETamO36hOCg14WUMEfiDvaok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jNTEPbCO; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jNTEPbCO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d08HRXSdQIxCQY4xIWSuIbgJgoDH/9wDeF8OkQEPuDBS4QWw8sxcoGnQyldvW2CkBQm76IBVtxKiTkpOP2xE0uR3gJtCA5LIN/59xEMn+N/nYe2Z84iLpiXTcY8vzXOdL9Rp4X+vwT2l52C+5YRTV7sIRFOlKpnwfXO9XDWzsPcwyAwWBbGBmM6dJEPymw0/sCyO4rNCikTHCMFM3Igr6PXV2elWLxbxeWhCoxAGErYQhl3HD3gNDwepzZ3EI/Of6CwGZfgE+eO3cpwTGyQUsGhCkO8IfT73gGRxz1xgF2NurCGm9tm3+JcflRp0h8ryeFoS8OTq8u2hFCGdz3lJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAcP7teNMm+8m44AVIR4C33WDyf77rdz5zUZTpVpzJ4=;
 b=ErgFmvcPB5qTIjAGRsTKplbz9FVyFdT1zdv+Ctv9ODn3e93vw7u8AqT/Btk/Bv44S3I8a6Jdr5DYe5/1tT76XLl7dd3y9+KPTcvp+VH2fkdj5/mJUZNcYxZ61ySpbl9zBGMpbz9qIfhFlyl3Atu0MgckCZMeA6IXgd9yE5+tqvrDJ+m37/w0G0jZjny0GcCoXMj7dIyxSmmyTNGpRnnFZyG8f3QEDUrb59+kk1eCLk5QdsN2Z5KUbW5munumZkHdcMlUNEXnjNkcCtzbkL4H1k4A2m+5vdgJnbW0Io6ZvFT/x+1Cu3kl6avq4STFJWmcs9io9VWbUeH2I44gUfKatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAcP7teNMm+8m44AVIR4C33WDyf77rdz5zUZTpVpzJ4=;
 b=jNTEPbCO7W1ccCtVtkH5+1oQawHpR7a8kdICO+a+KaMEZnVZSEe9JbwLgI9w3iwTR9vzhX6SDIouI29hKHZ7ngKyk54T97xa6lTK6gmX1MQCh36CeOjDJrP79AjUUmUkS3ZWnhhoHE0iWzH/fDybApi71KqUHvqYnz1TcqFXRpw=
Received: from CH5PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:1ed::24)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:26:58 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::7c) by CH5PR02CA0023.outlook.office365.com
 (2603:10b6:610:1ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:26:58 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:26:53 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Ravi Bangoria
	<ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>, "Sandipan
 Das" <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/uncore: Fix the return value of amd_uncore_df_event_init() on error
Date: Tue, 9 Dec 2025 13:56:38 +0530
Message-ID: <076935e23a70335d33bd6e23308b75ae0ad35ba2.1765268667.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: b964e43a-5aee-40e5-785c-08de36fcb853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tb6LLevSIiOqRVQOfyN3jCb7v0JesFmhpWxcZBD5JqPrsuBdrLo+P/nmHQ3r?=
 =?us-ascii?Q?z2oGRMS9aHVRtZKMLhRV+YNw4MJi67RAc3SZ4e/8WQAJWJy6AoYEGgCS/k5k?=
 =?us-ascii?Q?V6fOvYH8rNZDnqzD/PkM3nSoLP2aFCyK+PNMyCZYiatq528CrOeTcG9aKmK+?=
 =?us-ascii?Q?Lo5sruf5p1Ia7Jz9Z5cm7GX8TtgICnA3vt8IrXxxIzUjKeRuxPTpezHdrxUt?=
 =?us-ascii?Q?dcUjGVcIzBBEGHubZbc+mwfo4bT9XBykZeQJbHkOEbOYdQFLOWxkyd6+otQ7?=
 =?us-ascii?Q?LysY/sAocd9DdUY18WL9713kKcSxio+fNnvm0EmURfKu+liU5BFcjHhKEXmV?=
 =?us-ascii?Q?MtG3/J8Fggpm+/3Rl+TESXduEMbpPKcZifOaywKEAy/be3MMLkg2POHTpNOM?=
 =?us-ascii?Q?QDealeWQCVVL/i5MmkXVCOdX3HmZ3+I5ZkWV/r+Kw//muku8Tv5eC36LOp3P?=
 =?us-ascii?Q?dZvtd323g/afnzMr4/daJdRWom5JO/pINWNwPoPWgC/pDA8lyrcOqhsLdaJz?=
 =?us-ascii?Q?Zkn2PfNvZOXMKkm4kO6zP7VgXI2y6UZuJijztBjQFytVlfAfKeHwLZ5726CN?=
 =?us-ascii?Q?fIOhBJtkiXwf3xHzNCLkxCjJy8qTThWzqwRyU3oSvNzb0uNT68ONH4ijDZ7m?=
 =?us-ascii?Q?zcJTLb8pwXdGVBelieIoSaEj9i3UI9aPR9SqlClaiOXwDUdroWhmqTxCwnOz?=
 =?us-ascii?Q?b0mFKj/COq0LUWn4ZW6yuWiYTR9ZtrNzZy5+KSRLtZliMGo/KTHueqIRCcVY?=
 =?us-ascii?Q?A+0+VjUdTk/uasEbHSizQ6vkYnVdZeTKFjMTUclTu3FoteLPEHV4b6pNXbjB?=
 =?us-ascii?Q?PjTvu9titFdHS49GQgUyC1GQSzcEape39iWGoHEj0JJlNjKic/cb6kGeszz7?=
 =?us-ascii?Q?tCKstELBSARyI58/I4eWw6+68+ZNsFH9YhLlA3VoSvtb0facA+0Yu46Bv+Yj?=
 =?us-ascii?Q?UrZD10l0T7C/wxUpuVf1XrPeuAgFSr2mQfiTwb8eGGJkPtNUNoYdKLCfLyBB?=
 =?us-ascii?Q?4Ojr8C+zG8HDHbvTRzwhClN2UektBMOo3nxJM2pwre3WXYfb9YGbUcdv0Fzs?=
 =?us-ascii?Q?0yPx0SIFe9vx3EWHhU2QA90kiS3OvS0igcF459zPzrM5CxvIw4c32xf9YDsu?=
 =?us-ascii?Q?z9s9zc2StbE6IA8dkdkJuUhr79h4jn9vZUufuvT38BmEmT68RIPS3jKpbryg?=
 =?us-ascii?Q?PUvkyy4Y8fs4CpG5Ikvia+oh0NSY9vfXQorLcpJQTQ6Ly1A0Gbubm83Zl7gb?=
 =?us-ascii?Q?0jiU/Uy0rlZzyd0FHKo1ql3holWu/HHLwNJOsan+odtcLljo88eUbkBqjVeR?=
 =?us-ascii?Q?N5cSlMZucR7YHfB2mIzAhjBZaLCGDty+KiqYnSzkyACbmXimjLmSzIPc4rEl?=
 =?us-ascii?Q?EvaTGNkbyRavHNsIq+IOmiNnbu5JcXRivGUlCpmgvuVUjD/SA49Uacyvo8v9?=
 =?us-ascii?Q?leHschg6Vc1CraDH1vMIGdPbbgbYfG8yi46mMF0YNMJTiOS6NAhgHsK93Cm7?=
 =?us-ascii?Q?jezMANfz4c2HjWDBU4AV4eDei25JpvxC1pA7OGm11RsdaTZDKeOEgNUC3afW?=
 =?us-ascii?Q?mBpCBOrchXS4zHIADpred8AqCmNyOJZtKOPvCTSJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:26:58.4788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b964e43a-5aee-40e5-785c-08de36fcb853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356

If amd_uncore_event_init() fails, return an error irrespective of the
pmu_version. Setting hwc->config should be safe even if there is an
error so use this opportunity to simplify the code.

Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aTaI0ci3vZ44lmBn@stanley.mountain/
Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e8b6af199c73..9293ce50574d 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -656,14 +656,11 @@ static int amd_uncore_df_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int ret = amd_uncore_event_init(event);
 
-	if (ret || pmu_version < 2)
-		return ret;
-
 	hwc->config = event->attr.config &
 		      (pmu_version >= 2 ? AMD64_PERFMON_V2_RAW_EVENT_MASK_NB :
 					  AMD64_RAW_EVENT_MASK_NB);
 
-	return 0;
+	return ret;
 }
 
 static int amd_uncore_df_add(struct perf_event *event, int flags)
-- 
2.43.0


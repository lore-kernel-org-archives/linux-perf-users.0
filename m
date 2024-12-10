Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F11DC9B8;
	Tue, 10 Dec 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823363; cv=fail; b=oTUDOon6mDBdgBvQIqkJVULVU2MXaQYll0CMjd73opg2tCHJLTPDvNP/kTP49uc7wQVKfBcGPi0KWIjmRhAegIilydPPF+KfnlyrHuev7YdWFIr6XpKlRZzkQhGdzLPQAuC//olu5kYgz3DWgKjF5lplSUCfruyPkQjHYK1zdUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823363; c=relaxed/simple;
	bh=i0A3OCkDuilZk35AaFJGvtjNUXlwAi176YnfoGaTVoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTMc8uBTAlTdLd2139RI0tQKyPMAlrpFmJSxXLsZwS1Qe4KUUJJ2caSAMPY3MbCqc4+udznyB0T5lbeMzJYZidVhLtK5JPXCtyzoBSMztNI7aiUm2qEu2KdM3GzUkcoyJiCZ0nT2V/fN9gmcLhD1x6LAAXjVT6mZo8Yn7IQxTjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ldu4xmDk; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ldu4xmDk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4CvVU7JPLin7JSbzTE4PfztTQbaoRfhcHQWjLVDxG4y3BSt+JnJ3U2qLtVhbg2P6R1mIUxDMe/KJ+1qz3u7OudO0lWvBie9wd1VfuHPPdQpUU78ECFE4+q7oBUNIMBJg6UWXvzqt/KM+frMOGEu23By2ZDNLle+590EmgbPNOjZjFEZgZ3QXX4MMyGC/jwLCqxcbkaaqj7vPW9hx7joJ+09PXRvOWP6L0BuqgidXwALdIWt8393MIj9XfPUyA7bCoTokuOAosQs0b2KDDc0JcnOdL4iLOOlUAEe3iQuFxbcIsRZ9IMRkO5aNkwktPGWsLNRpmP1BIYfVnSxRfQ2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yahYhVz4twi48hph3lwzlrT/hp2CKvMmSCu2tdlGwIM=;
 b=qTzjm1Y6Nb2Xgaepc3aoaHDCLD/H3CC4ERa6LUqqxoTC9Z88cAPPxEEeGfIfG1FP6rPmtew1y+D6kbuRjIyQq31ofU5AhvCP6MJw4fPYn06ovYmuJI1YfZ4vdeNDwZOXhce7veWtt8flh6fhalv+AS6nMlmLe032AE8j7BgIEJJkEpo0wwZENIS384sMBvi/f6g4V2T/coaFX+RNNN7Umnt9ucZNso29nAWRXWSR3jJ11UAGayhdYZTo90yBsTdSzljsdPHcgiVn+MV0caQWpJneZK2F2cuhQal83URyb6f9PIsTB4bYWXcI4yfIwPDy0rCsW/QIKtLeM4xpR6NmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yahYhVz4twi48hph3lwzlrT/hp2CKvMmSCu2tdlGwIM=;
 b=Ldu4xmDkoOFxqYG8DTwtO5oEYLuSm8yB+Enb4ERQ8VPPZM3lNYXe6nJpCKEnlh6v5TwHkgqF/ZjI6uHjbzBYdIJT7Nm3kcQUU+p2iDuLCnAOCT+qVxYVyMg1A9WL6wJPt4rpcCG9oxxo/vVL7go2Oa9gi1WxiJoyqhNhLMxT2As=
Received: from BN6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:405:75::25)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 09:35:57 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:405:75:cafe::24) by BN6PR17CA0036.outlook.office365.com
 (2603:10b6:405:75::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Tue,
 10 Dec 2024 09:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:35:57 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:35:50 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 07/10] perf/amd/ibs: Add ->check_period() callback
Date: Tue, 10 Dec 2024 09:34:46 +0000
Message-ID: <20241210093449.1662-8-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bb6731-16c5-430e-735b-08dd18fe0cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MZMxaY9F2ZGYq2hlM1IAFM7h9cn+tzyWvu4C/xYj2mtZML34DyPchfOMjhmd?=
 =?us-ascii?Q?5lOyES6aKrKe95tRwRwla6oAhx1E8USY+QqAu9xtNw3uZJMD8jhDlIuhOACh?=
 =?us-ascii?Q?I0dPhI0RdOJIrcwmDC00bjmOnfkSg8wVdKEF0LhOzdWiXsK/YHbGjbmOmOW3?=
 =?us-ascii?Q?+vC/0PL0DZReqwJ/bp3vyXndUYcUMd3zisb5VLSbkJzfakL1TdLHo4OsxsTL?=
 =?us-ascii?Q?r26MXmUeSoK/RRiugWPnWjlfY0HOfz97RKBGVI/YeVfIe+nwOEwFAcVgqCQY?=
 =?us-ascii?Q?x/JtxCnAzr+eTgKh0fezUvJA0FIDLksmWRPfPyO8v3+TqZDCWefiurruc6Ch?=
 =?us-ascii?Q?Au4KCaexQmavt7r9+EuvnZeuT4sC/ouSZfTv/YWy2MsAtOSvaTbIx8gMkVQr?=
 =?us-ascii?Q?zfKpXFMjTOJJu6q8z4cq/iZla/M8V99GfyMC615fDcXsQSztoIgwQLHCJXZO?=
 =?us-ascii?Q?p4XeCwNjtp+bS3BbhSOqK9/kSWeZW31zIMzs2bBOgAK4ZFVJlyGE8nJNqEJh?=
 =?us-ascii?Q?AgMkacookkuktX9geVWWLLa0WUwdCzhaj83hC69CMmJdbxef+AQrpoeRJQJL?=
 =?us-ascii?Q?vf+1LSeySS1tC/Flns4p/LMLl647/7Gsyvk8Ky5pcfnkIpyT6Cg9EElta37o?=
 =?us-ascii?Q?GX1I4rfQC0NOh5WClC4Yy77jrk3/7PJISUNAgb3hbhOf3ioBc0KZiskP5p0K?=
 =?us-ascii?Q?Xem8z12JY7VTmaDOwhjJFnnzxYN4MKgFvPxc8WPcyw/BeDLEpFUagGS7eKgJ?=
 =?us-ascii?Q?4Wv8dvA/k2OlyAoynjafkLot/Ird8EBG/uBuKxk0P9rz4WH0AOacw+1gqhaH?=
 =?us-ascii?Q?+cqOkklAhsm9AApbHdNtxAzXdwvdZjv+6QasYZANVXKmQ2kcF1Rhd2EEgXtz?=
 =?us-ascii?Q?DHlWjzkfYdMrrhT9Qb3vGjivyd1QTSHsGy+K+EYOM8QNZon8e5qpQ+1t27Be?=
 =?us-ascii?Q?mtChCL0TnaCKeSIJv4cUU5tmflSqUH9nUAeLcxZhGNyE4A3q63WuGwzn6oyx?=
 =?us-ascii?Q?xk7eCB1g3q6f1VuTYALreZKMIlvAozd/adQA1uSMUhFEPUANaJIWvp6aefuy?=
 =?us-ascii?Q?hyJoKshDKSzlPlGHaTOwewMSML76WJrLtwFZMQQh+OmrFfWPbtANKjvOwTHu?=
 =?us-ascii?Q?rwbyVYXKtR0XUpyJMWN41yatEMphXLB25aoqFApJWDtD8YvKym6Oi3X94HBE?=
 =?us-ascii?Q?LINeVS9WHiczeoQoH9HiEPvDhqbdkMhJkAQoyFi/0b4VKiv1Fjqp17fl4S0F?=
 =?us-ascii?Q?MMYakBL++H5an/jW1sVI3akvpwrfiYQFhiHniVt/OfP1zAwDW3O75CpEZrnO?=
 =?us-ascii?Q?5qO8V2TN/lfU4Bm5vF1uVdoSXqUM7CPahQJzWHpOOvT+SKBJ/B9nq6hdDcEa?=
 =?us-ascii?Q?J7nAz35T1sA3gUfDuogtzLnD6iejKqvOkbC1OMtLgOimhkmBxWv8QQi7+GEn?=
 =?us-ascii?Q?rGp0w+CBShqV5YS4DJbq+EA5E5M+9jaj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:35:57.0683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bb6731-16c5-430e-735b-08dd18fe0cc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

IBS Fetch and IBS Op PMUs have constraints on sample period. The sample
period is verified at the time of opening an event but not at the ioctl()
interface. Hence, a user can open an event with valid period but change
it later with ioctl(). Add a ->check_period() callback to verify the
period provided at ioctl() is also valid.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 7b54b76d39f5..aea893a971b6 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -564,6 +564,28 @@ static void perf_ibs_del(struct perf_event *event, int flags)
 
 static void perf_ibs_read(struct perf_event *event) { }
 
+static int perf_ibs_check_period(struct perf_event *event, u64 value)
+{
+	struct perf_ibs *perf_ibs;
+	u64 low_nibble;
+
+	if (event->attr.freq)
+		return 0;
+
+	perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
+	low_nibble = value & 0xFULL;
+
+	/*
+	 * This contradicts with perf_ibs_init() which allows sample period
+	 * with lower nibble bits set but silently masks them off. Whereas
+	 * this returns error.
+	 */
+	if (low_nibble || value < perf_ibs->min_period)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * We need to initialize with empty group if all attributes in the
  * group are dynamic.
@@ -696,6 +718,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
+		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
@@ -720,6 +743,7 @@ static struct perf_ibs perf_ibs_op = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
+		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_MAX_CNT,
-- 
2.43.0


Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A93221D93;
	Wed,  5 Feb 2025 06:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735592; cv=fail; b=d6CVXMa23XtgbGTwxuxghi2bLaEWgTlxiLjLNX81P6yCVVSRaKh7MqlW1QiooCJhOd9qmC9+6XM/3EmfrW89+NV0eMoSBfJVsW+ZngJtGHHX3L8hxB2gX94kgCMLwnUkT3h45CreQBvBLuwb3JsVEZsPhtBRelfwfD/R3xqLAkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735592; c=relaxed/simple;
	bh=KgB+lZb1ZEG/7T8t190CsMT8rxeZUx7Nb/0JhKbjqbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mol5V3i0Jny3dWkKUlG7PLv8vrkxPiQfjqUCvArowqzEnWIVTHW9HLzj1cvBYa8qr7FoA/3TXShvk8KfhfRrCVZDpeyHlmFprqsAgAKT2isYfcOoVUn49f7DWlAxfm0wy/9MHITS6kqEu84KaPEiNvQ6cyzjEGrfuD8/Pme8O90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Deg6bSEt; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Deg6bSEt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUc1qPz2cW5fuSB+MdLUYYvT1ywd1hXHT+GPEMCYpvX9bDo7rfpeaP6xRM+6+GyH65paMbyH/5eBSqPGjvx4SWy7PzjpiD6kjdkbBVBE4HJvLvendRnF4io33JIQPrApE7kv5DW32b3GBIpkY7eug7ZaOlCEjLZth6Bu+5mrQkFqRqZsN1hG1RdIfP+cW7cCW3QWJjW6XG0qShlx2cVEYdqXBU0vF4HUSUFZc2RoPCoZlYxOfG+hU31rI/Kkz0AdKupucWo0HbRkpIyni446bv4JnKK5DzmTSH2aloufRRPWP3NSLp/zeCIr3NLP3jGHoO+wYrB4pY1QWYpRh04ugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyXUenj8QFLgdXV+8Dp16hCZ8yrWRR5njw2NQ8PGBdo=;
 b=GrrANCBcr16EFLiVLqlVW8IuZtlktjeJOa2WMi8SLGzndS+x9MRe0vM7GCVELevS3o+gDqyTvRGMZp4fUU/5cFIVDD3liQzlhxh7ntuoWJ18UevpEKl0HUXps+WM2SudGJRvmlxuzszQu1MgPX6oW4l1SHRwNGivyr3o33fl0YfLUqs/gdHLgdF57GbJkLp7n7QXuqRXFBPWGacC+LapcfV63M2toGrWeFSIaR82n2Q4cK0YCuxoWAth095g9PcE/UMJifGv/MMDVEAw8SOYnJBps7G72DZtmF9WNHY23eE8PdcOEGMVqp6NwKMbERy6mal8HYAwX1vwNQpxCsAxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyXUenj8QFLgdXV+8Dp16hCZ8yrWRR5njw2NQ8PGBdo=;
 b=Deg6bSEtmknWalggo4bQX3hkVWCduL9j18HfyFW1frPswkaAbigdQa67Uav5lkiu7R1f2T9K/Uk2plAz6/glzwFV6fGk2sbic+swa6DXsAyn5vlFFdz8O88ERB3Z7QDpqWzuFRqUA3CBAn2vXKLHVwu9ccYcO0zEQhtFsse2ihI=
Received: from SJ0PR13CA0168.namprd13.prod.outlook.com (2603:10b6:a03:2c7::23)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 06:06:24 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::e4) by SJ0PR13CA0168.outlook.office365.com
 (2603:10b6:a03:2c7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 06:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 06:06:23 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 00:06:18 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <mingo@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <jolsa@kernel.org>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 1/7] perf/amd/ibs: Add support for OP Load Latency Filtering
Date: Wed, 5 Feb 2025 06:05:41 +0000
Message-ID: <20250205060547.1337-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205060547.1337-1-ravi.bangoria@amd.com>
References: <20250205060547.1337-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3a738b-ed1d-43b0-83fa-08dd45ab37fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7U+AMlBQQl1P2if2NUeMtjglUkifSlkDjS3EWLwNDnqJpoTIDLzQHZ/JAfvH?=
 =?us-ascii?Q?TUJcqdU441hOL5xawSxi2tZUzLQqA1Hkuyi9Tpz3iuFB0F0MNntYyL34VECl?=
 =?us-ascii?Q?7IPMuKHub3u7zb2p605BUVZp+tHvpJJQtCdxzc8V7exRSCHYvu9eNnPek4vG?=
 =?us-ascii?Q?QvHFhE3mk8kE0sZbeKhh0ZR6ddwtLF/DYPbKAp+Xqzojr9VQt7aFVmAlnBQW?=
 =?us-ascii?Q?8Tpaq3yNaNwMREu2A9vqW9Z3HCfHNop3+DXCstXa2ATz2iBBtb7dWHIMzN4k?=
 =?us-ascii?Q?SGpbvGeKmyLtAasJArtM3OwQulFdh1wgebjjsfdwT2blr4pNuj6ixGOLt/bY?=
 =?us-ascii?Q?NKzNqqF82kZ3UkoU+1kCGvZoug6WjZqFS02ickTHNUAL/9cGDqZICdmdNsyW?=
 =?us-ascii?Q?U5BW7A6SpxXrA6YGVuXcMkBW5cMEZSjokCT3e5tI7NmnZsyRyhmaf65AKoHH?=
 =?us-ascii?Q?Ib/I6S/sRh0Nc8y9d9QwUItwiPiHteLRCRz9T/o3nQ+mUjOdBIb3kS6Pa0Bv?=
 =?us-ascii?Q?bL6qOaNXvx7HH1IiGZR2yH8DMqNs37Y1IA/sJ4ZHD63NVji6hqKGa+5Mqrjo?=
 =?us-ascii?Q?BdVJKezzoTNHI2Ko/56oigDCZ7ClGawO76LRjeaHWynRrt2Y0RZm4aNPUCAf?=
 =?us-ascii?Q?HYc0gnymIrhtc1IO+sZ5+dhC6mRuVO/dEEGTP9Xi6uPxwrSvWJHf2+u4TDpD?=
 =?us-ascii?Q?Fe+uPMt+DCSlng+72IeFrpPVJSx8bjd662IC67JUc24JAmcuNk3L9j6anL49?=
 =?us-ascii?Q?QxI2sKqPMo4XoCN8mAsiXiKObAvAYMzrNtLDYe0N9FMNdPCB4M3bZ8tgB4xT?=
 =?us-ascii?Q?bZ1+b3zA0uy+EoLzwb9nwTwaGIj5D0SpQO/bP8fo4OukyjsCWH0PwTQeN6Ji?=
 =?us-ascii?Q?hHt8Au4ZZLXeIaKa48T23umQtU/kCRZNGKtQjEKcm3nwCpFP/kIcTUcH9J0M?=
 =?us-ascii?Q?ulxI3xnC341dE5looqVGNh9fIUC1cH8STN3VTAv73UCjTbiFTl9Byfq++c+3?=
 =?us-ascii?Q?ZG9Tt0hXGkerZDPKUEsQKmNk9tv8NzoEIj12ygkwDLbNUbfBfvXDDcOazhoR?=
 =?us-ascii?Q?BGMv5vHTJz8+SJ7wBJJxOXKKoQ0WbF8hcHHT+nf8cY+8m6+VM4bBWgm3WKSC?=
 =?us-ascii?Q?jvcS3sCuYcKgb7Y2SWEqa4MyuBB+RQN3rChJwHIg0Hmeb2okE9i1q8xBoJbW?=
 =?us-ascii?Q?WoVbwzF6HiRTKFuRXoOzuW0BrF1JF2U+u3kMzB/+kPot3Ntnvlaw38t7kRyu?=
 =?us-ascii?Q?152ZAEmpdjQYSXxbTq/pSZPbQjhMC+3OTlepKSvh4HbPAoSMlO/tB4KL/aqW?=
 =?us-ascii?Q?7wv/C3Y7VIVivCNIaMrPHlf23OEbqsdZ1mLI138cDGVkj6NPdjO5ivOvbv/0?=
 =?us-ascii?Q?oobKS8GjVmCnU6btdnDfNHC7yaGua2Rlv+4g3Cl61lzBals0rQAedWtOjyYJ?=
 =?us-ascii?Q?YopR/2Kc6OIqxxSDqCH0YkhBhL7869aWchM4bgbIuYbSdDlHLCxJYzjKTvuf?=
 =?us-ascii?Q?wHM4K9pxm3o+vFg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 06:06:23.5935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3a738b-ed1d-43b0-83fa-08dd45ab37fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

IBS Op PMU on Zen5 uarch added new Load Latency filtering capability. It's
advertised by CPUID_Fn8000001B_EAX bit 12. When enabled, IBS HW will raise
interrupt only for sample that had an IbsDcMissLat value greater than N
cycles, where N is a programmable value defined as multiples of 128 (i.e.
128, 256, 384 etc.) from 128-2048 cycles. Similar to L3MissOnly, IBS HW
internally drops the sample and restarts if the sample does not meet the
filtering criteria.

Add support for LdLat filtering in IBS Op PMU. Since hardware supports
threshold in multiple of 128, add a software filter on top to support
latency threshold with the granularity of 1 cycle between [128-2048].

Example usage:
  # perf record -a -e ibs_op/ldlat=128/ -- sleep 5

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c         | 93 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/amd-ibs.h    |  3 +-
 arch/x86/include/asm/perf_event.h |  3 +
 3 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 7978d7910adc..85b29b3f305b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -268,6 +268,14 @@ static int validate_group(struct perf_event *event)
 	return 0;
 }
 
+static bool perf_ibs_ldlat_event(struct perf_ibs *perf_ibs,
+				 struct perf_event *event)
+{
+	return perf_ibs == &perf_ibs_op &&
+	       (ibs_caps & IBS_CAPS_OPLDLAT) &&
+	       (event->attr.config1 & 0xFFF);
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -339,6 +347,17 @@ static int perf_ibs_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	if (perf_ibs_ldlat_event(perf_ibs, event)) {
+		u64 ldlat = event->attr.config1 & 0xFFF;
+
+		if (ldlat < 128 || ldlat > 2048)
+			return -EINVAL;
+		ldlat >>= 7;
+
+		config |= (ldlat - 1) << 59;
+		config |= IBS_OP_L3MISSONLY | IBS_OP_LDLAT_EN;
+	}
+
 	/*
 	 * If we modify hwc->sample_period, we also need to update
 	 * hwc->last_period and hwc->period_left.
@@ -607,7 +626,9 @@ PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 PMU_FORMAT_ATTR(swfilt,		"config2:0");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
+PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
+PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -615,6 +636,12 @@ zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int
 	return ibs_caps & IBS_CAPS_ZEN4 ? attr->mode : 0;
 }
 
+static umode_t
+ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_OPLDLAT ? attr->mode : 0;
+}
+
 static struct attribute *fetch_attrs[] = {
 	&format_attr_rand_en.attr,
 	&format_attr_swfilt.attr,
@@ -631,6 +658,11 @@ static struct attribute *zen4_ibs_extensions_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_ldlat_cap_attrs[] = {
+	&ibs_op_ldlat_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_fetch_formats = {
 	.name = "format",
 	.attrs = fetch_attrs,
@@ -648,6 +680,12 @@ static struct attribute_group group_zen4_ibs_extensions = {
 	.is_visible = zen4_ibs_extensions_is_visible,
 };
 
+static struct attribute_group group_ibs_op_ldlat_cap = {
+	.name = "caps",
+	.attrs = ibs_op_ldlat_cap_attrs,
+	.is_visible = ibs_op_ldlat_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_fetch_formats,
 	&empty_caps_group,
@@ -686,6 +724,11 @@ static struct attribute_group group_op_formats = {
 	.attrs = op_attrs,
 };
 
+static struct attribute *ibs_op_ldlat_format_attrs[] = {
+	&ibs_op_ldlat_format.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_cnt_ctl = {
 	.name = "format",
 	.attrs = cnt_ctl_attrs,
@@ -704,10 +747,18 @@ static const struct attribute_group *op_attr_groups[] = {
 	NULL,
 };
 
+static struct attribute_group group_ibs_op_ldlat_format = {
+	.name = "format",
+	.attrs = ibs_op_ldlat_format_attrs,
+	.is_visible = ibs_op_ldlat_is_visible,
+};
+
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
 	&group_op_l3missonly,
 	&group_zen4_ibs_extensions,
+	&group_ibs_op_ldlat_cap,
+	&group_ibs_op_ldlat_format,
 	NULL,
 };
 
@@ -1060,15 +1111,25 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 	}
 }
 
-static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
+static bool perf_ibs_is_mem_sample_type(struct perf_ibs *perf_ibs,
+					struct perf_event *event)
+{
+	u64 sample_type = event->attr.sample_type;
+
+	return perf_ibs == &perf_ibs_op &&
+	       sample_type & (PERF_SAMPLE_DATA_SRC |
+			      PERF_SAMPLE_WEIGHT_TYPE |
+			      PERF_SAMPLE_ADDR |
+			      PERF_SAMPLE_PHYS_ADDR);
+}
+
+static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
+				   struct perf_event *event,
 				   int check_rip)
 {
-	if (sample_type & PERF_SAMPLE_RAW ||
-	    (perf_ibs == &perf_ibs_op &&
-	     (sample_type & PERF_SAMPLE_DATA_SRC ||
-	      sample_type & PERF_SAMPLE_WEIGHT_TYPE ||
-	      sample_type & PERF_SAMPLE_ADDR ||
-	      sample_type & PERF_SAMPLE_PHYS_ADDR)))
+	if (event->attr.sample_type & PERF_SAMPLE_RAW ||
+	    perf_ibs_is_mem_sample_type(perf_ibs, event) ||
+	    perf_ibs_ldlat_event(perf_ibs, event))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1123,7 +1184,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	offset = 1;
 	check_rip = (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_RIPINVALIDCHK));
 
-	offset_max = perf_ibs_get_offset_max(perf_ibs, event->attr.sample_type, check_rip);
+	offset_max = perf_ibs_get_offset_max(perf_ibs, event, check_rip);
 
 	do {
 		rdmsrl(msr + offset, *buf++);
@@ -1132,6 +1193,22 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 				       perf_ibs->offset_max,
 				       offset + 1);
 	} while (offset < offset_max);
+
+	if (perf_ibs_ldlat_event(perf_ibs, event)) {
+		union ibs_op_data3 op_data3;
+
+		op_data3.val = ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+		/*
+		 * Opening event is errored out if load latency threshold is
+		 * outside of [128, 2048] range. Since the event has reached
+		 * interrupt handler, we can safely assume the threshold is
+		 * within [128, 2048] range.
+		 */
+		if (!op_data3.ld_op || !op_data3.dc_miss ||
+		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF))
+			goto out;
+	}
+
 	/*
 	 * Read IbsBrTarget, IbsOpData4, and IbsExtdCtl separately
 	 * depending on their availability.
diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index cb2a5e113daa..77f3a589a99a 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -64,7 +64,8 @@ union ibs_op_ctl {
 			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
 			reserved0:5,	/* 27-31: reserved */
 			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			reserved1:5;	/* 59-63: reserved */
+			ldlat_thrsh:4,	/* 59-62: Load Latency threshold */
+			ldlat_en:1;	/* 63: Load Latency enabled */
 	};
 };
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 73b104049f8c..a60efe47498d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -502,6 +502,7 @@ struct pebs_cntr_header {
 #define IBS_CAPS_FETCHCTLEXTD		(1U<<9)
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
+#define IBS_CAPS_OPLDLAT		(1U<<12)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
 					 | IBS_CAPS_FETCHSAM	\
@@ -527,6 +528,8 @@ struct pebs_cntr_header {
  * The lower 7 bits of the current count are random bits
  * preloaded by hardware and ignored in software
  */
+#define IBS_OP_LDLAT_EN		(1ULL<<63)
+#define IBS_OP_LDLAT_THRSH	(0xFULL<<59)
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
 #define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
-- 
2.43.0


Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F32C0F81;
	Mon, 16 Feb 2026 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215976; cv=fail; b=W78WNin2M7YVyfuScuMbckxD4UKBFsNa2WvrNfVUSSjHpJRGBz0RKoqF0JPh4ofjzdBx4cUpLqfEPBSWSLWSqftDP+Eh1pYbsxgtfitWDtzwe3X73gVYhN6ak4UUlPOHacKb5z9XsV+9/AAfl5EW9C2Wjhb2CQHn3JDGqXIKKRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215976; c=relaxed/simple;
	bh=QKSlLfMLKLBg6o3gnF6FRtCVpP2p7ofOdi7SCC7ONc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7VK1AZYo2wMGa/TemvTYS7Yp1nwRhbPmSb414WMy6y95FzKtu4mSZSZLWR+jQF2cUxRXz5QldBXztFTdBMHU2DQE27U17D7gVw3+u1op6ClFGRv/JlExxTkvIp2d3OGxY9M5AAyKmIjk7GqaDTcjt5Rx4lqw2KAr2ax8W0QdfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gXKsJ4NL; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gXKsJ4NL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtnMCpIYLb5aUd94yOtTiTGo1VvAWgsKY+b5zgZ6WlefNR7UkHqgLNRgAu1lu4MIJiA0jqSl9IXiQA0cfe4YsMC/hlal/+AWY/SHGWKum3FuJmFsQPVX5BYjSDqIR4rfoJO7OSnIjP7/3gDcsDnzzcbxdEeTDA+ASy/Kc3xGXiskK5BEG6uTFn6ScQzPwlXGHCpz5F1aIusnmMrEHPDxYq7HdCnGDa1Z8z07Ni08/YmGXi+d8PlrbE/o0Ia7gjjRcNNcGwhTcJbIcxQLtgkOYdkHlRvMXSVDza8lHqd7fxkdx2K/mAFMqjrszg7x+jKTU3Y6XxkDYKlmOD5dq6nAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrFKlechOeMOH5jfG0d8D2bSD/LY9aSNOX3Sf5ShgUA=;
 b=qvIJg6cebAj0jGVqxm3kgQoFbPWDbNdtklI76sV/RzmEj1WAAJFMP90vmWpBWsyy452DeIQnVVAwViP3m5Gbq7U0VJoQbc68y/klyj6gdcXOCD1Wygy5dJ9Owov8vi13IR31eycCZW46lkNgUT/xpeg18K3DBOLEVGZQQtpWUl9PRsE/2vyJUl2ZG2DuOPEL3d1T6wCun85HfTLGgrO5jK/GtVH3hLHSwhnpR0M7/aJhud4RbxsnF04Vzui75/VaC0GIhA8n6loZPxWiE5wl80Trl0L4wKdzaXF6kRbYhF7n5ab+m1TbBD85PGCEgR7ALEP4dlg6boQo4Ntxqpe0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrFKlechOeMOH5jfG0d8D2bSD/LY9aSNOX3Sf5ShgUA=;
 b=gXKsJ4NLcvvTCdKXQ1t6tw2rW3/sHOMvoZWRi0F1LGsSBLjqWap26AbvUUakIEndS8T2LIjiGBeLmX5EhBfuYxo5drUdBoPinlw4RHPHJgTjCChXGdCmKJKuSkus4EgbZKzzajP30ZIUfmaZTVz5SslfUKHKLDfmAMQs74QK7qY=
Received: from PH7P221CA0085.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::19)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:26:07 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::12) by PH7P221CA0085.outlook.office365.com
 (2603:10b6:510:328::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:26:06 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:26:02 -0600
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
Subject: [PATCH v2 4/7] perf/amd/ibs: Enable fetch latency filtering
Date: Mon, 16 Feb 2026 04:25:27 +0000
Message-ID: <20260216042530.1546-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216042530.1546-1-ravi.bangoria@amd.com>
References: <20260216042530.1546-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 7760aba2-748b-499c-3b4b-08de6d1380e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V5SuSuXretiiIdZL2dpxkhIyt43jDolvz3GTxfAR13SNusUUWawS/14WTt1I?=
 =?us-ascii?Q?VphGFHLclVt4eF68VSXYd3LnYZvyUBbau31zTa2ivr/ZLVXgevkJKKPBIkzW?=
 =?us-ascii?Q?MaYXG0L7f7OUGZ7U3taWkdt4T5+gwj9KHgVD8HlLOZcb4PnruYG8XvYIRElL?=
 =?us-ascii?Q?EHquj3IB9hM6JKCiu/TC04OQmDBBCn6kzA28ZOweGkS3p7ljIpgW0YJY4VnQ?=
 =?us-ascii?Q?UortGvBGH+N/fANp63xr7WmbLbRyZTF69WDU/gFG0iNOZSlAOZany8G45vVN?=
 =?us-ascii?Q?nmv0cT2cufytiDby1aGCBuwbvRjhlC42VU5YZSiRp+M8+PtQFidVJoqnC8a0?=
 =?us-ascii?Q?Lbd+Zo/etUY0RHa2neqGEitFFoa6QjBIGTKEPg0doL7uBJ2a8WX3lge9ElOZ?=
 =?us-ascii?Q?n3qxmlZlIY3cQ78Eb3ficsgfMaW5yErn3Tl4LmXWbA0yvW8XgwMaILPqIN2Y?=
 =?us-ascii?Q?TWWLJF6tR2OyjLj+XRjEWB5df5RF030XblQDv3xTiXUW5hA3fILQ8fHvtL6y?=
 =?us-ascii?Q?0ZqQC3UxOkOmhLsn9cuwYB8olGPh+uK6JswysR4AplLrJcMLJmYzvFVRKIw8?=
 =?us-ascii?Q?MZhYwqOX8UeOHMrcKdcsD4F34zH64ip12QcPsA9AnnYuRgQkgVRlf90jAcH2?=
 =?us-ascii?Q?umG6KIdEWKVXqKAzdqq6PsDp+sP0E3nEtR1g9PVD4L78EXsFKUJFhKtNdyJw?=
 =?us-ascii?Q?iLiR9J84/FpOqUSlo0x+UBmoacZpZ5b+0rMf/GPk6eFrDDAk+yIOXRprrj+k?=
 =?us-ascii?Q?MyWKUNgn/8UEd8ydRlBl/qJVrYeP1Hf27Z8fbxDgOEedkdemjky4XEMf7BgZ?=
 =?us-ascii?Q?n3hdR+fO7cGZLr89A/x7pzR7ZZEnAUeKf4jlpRbB5trfz9VIG1v2gDxxM7pJ?=
 =?us-ascii?Q?LekYeNj32+sbVm32FDbYNY19QoggAV8ebQ/Jmv0fCxd/qj1tjV17SPsHy4Ee?=
 =?us-ascii?Q?v/sqlP+5WojhPEjKF9Q7F43XX5LWZhZIIYw6MeA9PPTW3Ci5zNQ2OzHxK9la?=
 =?us-ascii?Q?t1BtgJ531rgUL1iUuxfBExX7PCFZNQ8+noU5NvIbwGvWenzlDUO4VzcRsZWQ?=
 =?us-ascii?Q?uQesKIxZOZgmX1MF0CK4J6jLuUCMlevpTP2AnkFjpjgwkUvzIL+frJhMvj3p?=
 =?us-ascii?Q?H6Em2EDbWHySQaCWt5HRsGzJnB1Sof+h9Vo+wuTkNwiyc6LM7o9bBasF7emY?=
 =?us-ascii?Q?Tg028tVmC1jHDq6b8Fn9Yi6tcHIFo2TZ3wHqL5Trm5/XtLVMysn56u9bGThc?=
 =?us-ascii?Q?3uo8SBF/UyL9nguNuCD0NvQfl4CtsWVBad21bNJdspQMwKsQya4sMbvQesUy?=
 =?us-ascii?Q?cqP5C3IbtAk99nHZ+qmHD2G8Uv8ev4iSlvQ3AcpSvW+yGPJvEmZaFPTUFtNV?=
 =?us-ascii?Q?EN/n2kknvL0stKgiufSZJ4F6vG0u2Vtwg5zVk/Ils6VqSU4m4mcJWonG/QWh?=
 =?us-ascii?Q?j3UO6DwTImLdFS9EFON6iRKh1mZsTVO+F513z6wBlTHqmYeFftYVRCEHyxvv?=
 =?us-ascii?Q?S7WLZ/teuWUSr9ZSNBIw9vkTftxhqdRnhDp81+QYznhIJEQNeVzPS1ryfeH2?=
 =?us-ascii?Q?1dLrwJloj5ZGWCt8/CwAXRKXsGPgxk2QwloXrQzlJa7AhxBf02IN/YUCK/po?=
 =?us-ascii?Q?v4hZ6iSGE9+BTPjz6NyhjU274Bu+UnXdPBBJ9pyHa0LnYrLXDdZeSCSwrL23?=
 =?us-ascii?Q?ugvEyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0JINwvMhKmyEjH6EumYFLFoDus+6tdnBxonT6yRfojaAD8LizO8ZvkkDvIKXlhWQdbXlLaNv5pvclZagvTqydafu6Yz+pFepkyMYb2dLs9r9oOVA8IJN29HuFJ2kA4k3SLYN60WwqRYjZ0eP74vhryR3oougmmoQLqqir5c0nf+I7IWOuEiDZHuksihbl1f++D6IpnfP/Dav5ScIImfljKESQSFcTuVk1C/+FvvxxD5/lYOTiJGE1PiQEQamEzyfNoKGbYJcedwzY77tVzVg41iCTUQ793NQ/XNrBDLGcaCKMOkXktLfBNrVmDSy+IDwFG3+T6IYx62wFjxrCZnDoGvpUZNWSryePAnlh9Xg+DaoP9bwMfOulojYZ7Re8cVEecMg+bZoAsR2bAtzjiinLtdF+Eceg/zsWUwCtrnclY31pOb/pZdci6WACK9NnFRp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:26:06.7009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7760aba2-748b-499c-3b4b-08de6d1380e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418

IBS Fetch on future hardware adds fetch latency filtering which
generates interrupt only when FetchLat value exceeds a programmable
threshold.

Hardware allows threshold in 128-cycle increment (i.e. 128, 256, 384
etc.) from 128 to 1920 cycles. Like the existing IBS filters, samples
that fail the latency test are dropped and IBS restarts internally.

Since hardware supports threshold in multiple of 128, add a software
filter on top to support latency threshold with the granularity of 1
cycle in between [128-1920].

Example:
  # perf record -e ibs_fetch/fetchlat=128/ -c 10000 -a -- sleep 5

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 66 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index b7f0aad9356c..cb3ae4e4744c 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -35,6 +35,8 @@ static u32 ibs_caps;
 /* attr.config1 */
 #define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
 
+#define IBS_FETCH_CONFIG1_FETCHLAT_MASK		(0x7FFULL <<  0)
+
 /*
  * IBS states:
  *
@@ -282,6 +284,14 @@ static bool perf_ibs_ldlat_event(struct perf_ibs *perf_ibs,
 	       (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK);
 }
 
+static bool perf_ibs_fetch_lat_event(struct perf_ibs *perf_ibs,
+				     struct perf_event *event)
+{
+	return perf_ibs == &perf_ibs_fetch &&
+	       (ibs_caps & IBS_CAPS_FETCHLAT) &&
+	       (event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK);
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -377,6 +387,17 @@ static int perf_ibs_init(struct perf_event *event)
 			config |= IBS_OP_L3MISSONLY;
 	}
 
+	if (perf_ibs_fetch_lat_event(perf_ibs, event)) {
+		u64 fetchlat = event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK;
+
+		if (fetchlat < 128 || fetchlat > 1920)
+			return -EINVAL;
+		fetchlat >>= 7;
+
+		hwc->extra_reg.reg = perf_ibs->msr2;
+		hwc->extra_reg.config |= fetchlat << IBS_FETCH_2_FETCHLAT_FILTER_SHIFT;
+	}
+
 	/*
 	 * If we modify hwc->sample_period, we also need to update
 	 * hwc->last_period and hwc->period_left.
@@ -665,6 +686,8 @@ PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
+PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "config1:0-10");
+PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -672,6 +695,12 @@ zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int
 	return ibs_caps & IBS_CAPS_ZEN4 ? attr->mode : 0;
 }
 
+static umode_t
+ibs_fetch_lat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_FETCHLAT ? attr->mode : 0;
+}
+
 static umode_t
 ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -700,6 +729,16 @@ static struct attribute *zen4_ibs_extensions_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_fetch_lat_format_attrs[] = {
+	&ibs_fetch_lat_format.attr.attr,
+	NULL,
+};
+
+static struct attribute *ibs_fetch_lat_cap_attrs[] = {
+	&ibs_fetch_lat_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute *ibs_op_ldlat_cap_attrs[] = {
 	&ibs_op_ldlat_cap.attr.attr,
 	NULL,
@@ -727,6 +766,18 @@ static struct attribute_group group_zen4_ibs_extensions = {
 	.is_visible = zen4_ibs_extensions_is_visible,
 };
 
+static struct attribute_group group_ibs_fetch_lat_cap = {
+	.name = "caps",
+	.attrs = ibs_fetch_lat_cap_attrs,
+	.is_visible = ibs_fetch_lat_is_visible,
+};
+
+static struct attribute_group group_ibs_fetch_lat_format = {
+	.name = "format",
+	.attrs = ibs_fetch_lat_format_attrs,
+	.is_visible = ibs_fetch_lat_is_visible,
+};
+
 static struct attribute_group group_ibs_op_ldlat_cap = {
 	.name = "caps",
 	.attrs = ibs_op_ldlat_cap_attrs,
@@ -748,6 +799,8 @@ static const struct attribute_group *fetch_attr_groups[] = {
 static const struct attribute_group *fetch_attr_update[] = {
 	&group_fetch_l3missonly,
 	&group_zen4_ibs_extensions,
+	&group_ibs_fetch_lat_cap,
+	&group_ibs_fetch_lat_format,
 	NULL,
 };
 
@@ -1191,7 +1244,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
 {
 	if (event->attr.sample_type & PERF_SAMPLE_RAW ||
 	    perf_ibs_is_mem_sample_type(perf_ibs, event) ||
-	    perf_ibs_ldlat_event(perf_ibs, event))
+	    perf_ibs_ldlat_event(perf_ibs, event) ||
+	    perf_ibs_fetch_lat_event(perf_ibs, event))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1333,6 +1387,16 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		}
 	}
 
+	if (perf_ibs_fetch_lat_event(perf_ibs, event)) {
+		union ibs_fetch_ctl fetch_ctl;
+
+		fetch_ctl.val = ibs_data.regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)];
+		if (fetch_ctl.fetch_lat < (event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK)) {
+			throttle = perf_event_account_interrupt(event);
+			goto out;
+		}
+	}
+
 	/*
 	 * Read IbsBrTarget, IbsOpData4, and IbsExtdCtl separately
 	 * depending on their availability.
-- 
2.43.0


Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4E30C368;
	Fri, 16 Jan 2026 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534575; cv=fail; b=KoI7nkcXdm5ma+9R6VCf8CMK6yDX7jPaZiXgWT3s4VynIfw9n492JUC/L+5kaZkquA1QG1gsqUF5dS66AF94p0LusyDxUOxpFPHVusLNhJxJQAqKGNeKmvIhQ8lilZMDw2rvLcpqZIPk6E4MePLnG0L97YcAgDrrYGdUd+KnDoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534575; c=relaxed/simple;
	bh=Y3EqnxVpfl0pfkut9zN5ubMWs+i2ydNBmtVP+o+Gxrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hi8sg4eFrq4mSvuD+BcOzoIhSt09TVXakoWMTEMWkbLnmVXGGPNi0uqDaGZG2y5yEwRrO8XxztZZ1cNg58HD8hmqVkXJ0Agp6eGbkMkX0NbDsYTV8QUmgUsrkfx321LR+FVrJfsAzTqgWnHYiZAoblw9StrknW2Puv9h9nwNpTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EgYoMA+q; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EgYoMA+q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtjYbRXN9TfL5CNcPEa5YVnlCvKIgSnBlfMobTKQcs85pew3VDAL1pOz2tVKyeO+T2M3KLUtjdFXL1FFJzDxJXlnMLl8sycJAEJb1joCSzLmUzbh6wWemGD4tMkV1u5Ld618pYsC9Md5UfYQWPO7w/4iRhINDKXD5bWPSNy2ieggPKl/mjSKwwY9/h0VYw8Qpt5zof+CodqcR3jh0iQZXIA6aappS3ei9AxjhZ3m8WQRi0qUls6EhC59HwVKtIY21G+2dOB6PEFfpkh8hqbXqp2APCKPaTCmZGL0WON2Jl41pfE9tZXNZZM2cwXS8GaAn54aQ/5CN7NheL4QcwwGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxhmpBtOzGq3EeiwjLUOdo8mGRWXE8m5LkUiiDyvPoo=;
 b=E7JBV5BlU8pjcMKsgrWbulQSebiISZIzmogkJqlTA2wl4lIJrtbTmV4WnU+14cYVz4Q3Q+xWzIyjzz+75ImaM/cYoHtzKm8rkfmiwO+JPIjvIAavelGyv6lRitWJJXr8c/c9t/m4ffJLS905efkclkRf7nzgmo/iypSQZU6Kder9qKx48kgxJbEcbYvxzI4OMebq8GmJoP7+ysLWvhQypkFOZoMP+bGCllXJVfqmaNgF8bpb3WaYLdXCqPj3j5EYQK82dk9ssi77W56SrN/Gf5WuUkidaAounGkpy7wfj2g3glyVrbatCy+0rSRyc1HRtI9vxD8Q5HuO7kknpgaKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxhmpBtOzGq3EeiwjLUOdo8mGRWXE8m5LkUiiDyvPoo=;
 b=EgYoMA+qYy0tN4qtH4DF5cKWo9qKymDpyv4RHkHfA1QDIB7jFWqDn+GLG70IOgGPxU3DzcGv4r6cCxv7iL8pZIYJpaV/Vl12pW/4NTG6w3jTZbAkxT0eeqUlYOLaXPLgEDfsKqG9g0QU9Apyq1EimhsSXbG0YtvoQPlGQqn7Pe4=
Received: from BN9PR03CA0657.namprd03.prod.outlook.com (2603:10b6:408:13b::32)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 03:36:08 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::31) by BN9PR03CA0657.outlook.office365.com
 (2603:10b6:408:13b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 03:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:36:08 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:36:02 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 10/11] perf/amd/ibs: Enable streaming store filter
Date: Fri, 16 Jan 2026 03:34:49 +0000
Message-ID: <20260116033450.965-11-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033450.965-1-ravi.bangoria@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e141bf-c96b-4813-3202-08de54b062d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eR9TRpnK0qwVIk4PI1+xzM7TLRVboc7xPqDUaCR6zKvOY0/nZ85OSCq5cGFs?=
 =?us-ascii?Q?h/os2rJJR8nWstB6khBGQUsy3d0nWh7pFAU9UPtQfAy1152ZBagRsDLlVrFx?=
 =?us-ascii?Q?dnkPYWMJHCKhWMSDanIH8x6h4gitMMbOZsGnLuJYUBRYK3WYMrlzFLIYnpY7?=
 =?us-ascii?Q?t5KX29cZLOBQKXiFihnftDHjCuF8mjMldtVKQQifjDUY/Ff7T4E7bI6u2a0a?=
 =?us-ascii?Q?xgZOwGVrJEeQuOEer4toVWRgb/31kdC5991XNMPWCWhMKFod8qfNb5NFCuyY?=
 =?us-ascii?Q?EiNsD9TJF8e5+8HDjSm2BDLBy5zr7KDR+9FiBbE6AOq3UHm/9rsCFWE8JI2E?=
 =?us-ascii?Q?jFbJ5iArD9g+MaVD4AXID772Xi/kv6XqVa6pyIL/B7eQSzRzOyxlmFoyKaxc?=
 =?us-ascii?Q?kmAMBV+5pmpDbXf7ToMoU5Pqw0pmhEdLl+th7KUsZqlRTx1aYiV2Go4eAfXo?=
 =?us-ascii?Q?sFO4OxpQttw1kLulYf56G2JdBtU5Qu19jvy7pDN/4u51UcNygGv7mKuKHRsM?=
 =?us-ascii?Q?+Wpwd8K4+vqN28OWtiQqBvij4li6KWffb57OgELwChBNMMBt/dKzoyc6PFzF?=
 =?us-ascii?Q?vSHJG8c4+fvU64kiC4FESiF7mlWEzSqev2BPSM1AEEnAIdxTPsjMd6hrrZKp?=
 =?us-ascii?Q?9+M6mknm9zYWFc0eaFUTSwnV9uQWDt18KYGIn1nn/7lPYnSNBvfS+nPZ1qTl?=
 =?us-ascii?Q?optGl5MgXuQePzImNFL1VuLjKeMARQAZ7nNy+p2MiXBGo1BnLEteRXkym17H?=
 =?us-ascii?Q?KLG+O4q3hlOiYI6sym1EKq/cn0K5UKkmhePGI03sJe5wUjggRbVrxfG/w2YT?=
 =?us-ascii?Q?7MKeAQk6gj81RCwWmYQDBIht6PE0zqC0pn7k9E5iczHdrn0+506PmMQhLtMb?=
 =?us-ascii?Q?zekXJIj0khTYtL4TO4s35ww9hNNkejFC4QmHYKEEcrkNifLD8kCn57HFuySP?=
 =?us-ascii?Q?RAKDc1ByOnG8YvvD3fP7DckdJ8TZkUC+1IRHKJ2UUVi543oHBkVRR50q9yc8?=
 =?us-ascii?Q?jLcfjVnEQxq1Ugz4diiRuh60tIdl11z18aK9zeLdB2YDl4rtt58fMCSdHDeV?=
 =?us-ascii?Q?fGTv23IpWodb9DTUqs8NZeC7NUhTmsASEr0PhaZlWsIPaq2w+VxZ7a6N6cEn?=
 =?us-ascii?Q?BW7Wv7HBW4yiEXm9hw7hLQ4D/cZByQKz33aQmhgvQRfx6DNVzwXTUtqF/j9w?=
 =?us-ascii?Q?l9kTz+ibAyoa4jOPxp6CnBptqCK95EnrF+CFsYKNN2oXOswuz5BegAeJHHzu?=
 =?us-ascii?Q?ma/ewRPG6LpKaFz9S8kN1cg2Qk6AbfY5l9iNZkK4kgTcIHwmW+hMkNoDBIrD?=
 =?us-ascii?Q?1/whwg/62CCSGLR0IwtD2JDcz1ueiu04MC7tJARmP3mfkF9QJGP8xbboBRuA?=
 =?us-ascii?Q?vyIqg05JhaWIC+ZtwIOox5t4wOV4R9+gGw8N4DGQSVqBeeQD+z2C0vqBiKz8?=
 =?us-ascii?Q?5fRtSvmr9yGo3pcHu53IctvOWT2qH/qR3v22IBZBqWZVUxzJg7wPHfc6uZzb?=
 =?us-ascii?Q?uETxmOxsE/3XP8SMs3lEvlur61YmE0vvu6Zb/MEjLzCFRCrKp4kSWsZj8ivW?=
 =?us-ascii?Q?vxGcC6o+19HSrlIZuGo3SKByU23jd7yS9VPxvFRNpk7HUcdlDhfZLke2SWId?=
 =?us-ascii?Q?KViI8W6aJQSKoXYWnfw1P12ZGIq7YmMDfzAK9wCNylrsKsLwAD3SRNfMtolV?=
 =?us-ascii?Q?nsh+Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:36:08.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e141bf-c96b-4813-3202-08de54b062d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

IBS OP on future hardware supports recording samples only for instructions
that does streaming store. Like the existing IBS filters, samples pointing
to instruction which does not cause streaming store are discarded and IBS
restarts internally.

Example:

  $ perf record -e ibs_op/strmst=1/ -- <workload>

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c      | 50 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/amd/ibs.h |  3 +-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index a768a82d7ad2..0331bcd82272 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -34,6 +34,7 @@ static u32 ibs_caps;
 
 /* attr.config1 */
 #define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
+#define IBS_OP_CONFIG1_STRMST_MASK		(    1ULL << 12)
 
 #define IBS_FETCH_CONFIG1_FETCHLAT_MASK		(0x7FFULL <<  0)
 
@@ -292,6 +293,14 @@ static bool perf_ibs_fetch_lat_event(struct perf_ibs *perf_ibs,
 	       (event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK);
 }
 
+static bool perf_ibs_strmst_event(struct perf_ibs *perf_ibs,
+				  struct perf_event *event)
+{
+	return perf_ibs == &perf_ibs_op &&
+	       (ibs_caps & IBS_CAPS_STRMST_RMTSOCKET) &&
+	       (event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK);
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -416,6 +425,15 @@ static int perf_ibs_init(struct perf_event *event)
 		hwc->extra_reg.config |= fetchlat << 1;
 	}
 
+	if (perf_ibs_strmst_event(perf_ibs, event)) {
+		u64 strmst = event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK;
+
+		strmst >>= 12;
+
+		hwc->extra_reg.reg = perf_ibs->msr2;
+		hwc->extra_reg.config |= strmst << 3;
+	}
+
 	/*
 	 * If we modify hwc->sample_period, we also need to update
 	 * hwc->last_period and hwc->period_left.
@@ -706,6 +724,8 @@ PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
 PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "config1:0-10");
 PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
+PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_format, "config1:12");
+PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -719,6 +739,12 @@ ibs_fetch_lat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return ibs_caps & IBS_CAPS_FETCHLAT ? attr->mode : 0;
 }
 
+static umode_t
+ibs_op_strmst_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_STRMST_RMTSOCKET ? attr->mode : 0;
+}
+
 static umode_t
 ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -767,6 +793,11 @@ static struct attribute *ibs_op_dtlb_pgsize_cap_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_strmst_cap_attrs[] = {
+	&ibs_op_strmst_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_fetch_formats = {
 	.name = "format",
 	.attrs = fetch_attrs,
@@ -808,6 +839,12 @@ static struct attribute_group group_ibs_op_dtlb_pgsize_cap = {
 	.is_visible = ibs_op_dtlb_pgsize_is_visible,
 };
 
+static struct attribute_group group_ibs_op_strmst_cap = {
+	.name = "caps",
+	.attrs = ibs_op_strmst_cap_attrs,
+	.is_visible = ibs_op_strmst_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_fetch_formats,
 	&empty_caps_group,
@@ -853,6 +890,11 @@ static struct attribute *ibs_op_ldlat_format_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_strmst_format_attrs[] = {
+	&ibs_op_strmst_format.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_cnt_ctl = {
 	.name = "format",
 	.attrs = cnt_ctl_attrs,
@@ -877,6 +919,12 @@ static struct attribute_group group_ibs_op_ldlat_format = {
 	.is_visible = ibs_op_ldlat_is_visible,
 };
 
+static struct attribute_group group_ibs_op_strmst_format = {
+	.name = "format",
+	.attrs = ibs_op_strmst_format_attrs,
+	.is_visible = ibs_op_strmst_is_visible,
+};
+
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
 	&group_op_l3missonly,
@@ -884,6 +932,8 @@ static const struct attribute_group *op_attr_update[] = {
 	&group_ibs_op_ldlat_cap,
 	&group_ibs_op_ldlat_format,
 	&group_ibs_op_dtlb_pgsize_cap,
+	&group_ibs_op_strmst_cap,
+	&group_ibs_op_strmst_format,
 	NULL,
 };
 
diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
index 3ee5903982c2..b940156b7d23 100644
--- a/arch/x86/include/asm/amd/ibs.h
+++ b/arch/x86/include/asm/amd/ibs.h
@@ -99,7 +99,8 @@ union ibs_op_data2 {
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
 			data_src_hi:2,	/* 6-7: data source high */
-			reserved1:56;	/* 8-63: reserved */
+			strm_st:1,	/* 8: streaming store */
+			reserved1:55;	/* 9-63: reserved */
 	};
 };
 
-- 
2.43.0


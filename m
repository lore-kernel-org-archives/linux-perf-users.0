Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B40327C18;
	Fri, 16 Jan 2026 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534563; cv=fail; b=eWwhmXcyEIz9ZJqTsvjzvS5Jwd45mnXF4vOaStHnQB/8vwRETPRUJ7stgYHCcMZu4/uwGAEQ8WvHzlr1lMpWcquvolzwJ1EEI1R2gLIZyL7TnOrD8iTT+GWjgf2OeSKNQw+FlrAGVV0cblZQF23cdPKVO0isklylw3ob6j4vsok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534563; c=relaxed/simple;
	bh=8D3Re5G7zk0aLsPK2+BYfghE9/mTqeCQc6ET4kgs678=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFSblMUBtRj/Jz+Rc2LmUUtOmdVqNnfNQgZCMDOOgPBPIxQ+4uW9dnR8msG3MQo4v+ZVI8pd+pCslP75ciNqnrcD9+0bn01g69TYpmnRpbQju+Fm+N00OUeFsgCl+0HJaO5dGikGBeLTDEi7Ds9w3yUW7WOINtvJUzpTeQbL9O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gz8fUyVl; arc=fail smtp.client-ip=40.93.195.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gz8fUyVl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdeHYBHW+KA/Ys/OZZ0S7Fkom6xBiFnsQtrIXT2GdXAxR+s+IK1LhbrtidDagBw82GScYeeCzmMJjRI+LvBCDlLJZskWmS8Nwm/X3jZ8daW7LnZFFTHLAlq6HTSveHbjdQeF1G6/0a21hQBBUOa9lFkrFFdGxsLeEnq3NXX23mLnPj+yQTzxeu7hJkIXhX41fPgoeyzL12gHxKELEjHmpooO9UKgzJLGIRRrf/hDF7m9w8BkPXayh9N7eJNfMDCG/QzhjDKrtD4We5y6G4lI7+whmmmXnA0onWa6EQyLu9qOVc2W9/PbCfiefjEOBpo298P9+iECbezS5u4jUoI3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgMyrs70eWw04ukdG61UOP4cpvQQr7WiNOZxeMf2GjU=;
 b=rk8lqgqDczaBtLnOvhTuL1U6KpPnt9v7eNhuIG7BJBOqfl41KhQsZV6b2wWdIlm0K0QLl2/CoK6H9iHrHGeB77NaJIjs7UbpxyTt/RCMimaK1LXIWTezGLa1wPwLs+KWO6/FgORD8sBD1EyU1Orl/kxzSPMbImU4NHAveuPh5ehG6Kc9nn3l5K9CV4RQox9ZtF/zdRggbZnCSUyxEG6WY5wbN52UDKvdRXB7PZs+uQiWE+ik5hUQTSg452SVtZ7gYt3kjKFqKIRQJ/V3OiJuVqmAIOz0Yt5dr9zvGqY30OckvZ9GI345iPBVep6hL4YTEnZ5EsjBCFWNARVS0U0DQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgMyrs70eWw04ukdG61UOP4cpvQQr7WiNOZxeMf2GjU=;
 b=Gz8fUyVlDuuXewSApPIN0PRqfu6K5i8yNTHEEcM4/AIr/nLWmoAjYclH3/A8Ff0SyW5D7dDURJOJiRBegs9xrRJRyS2999yiXr8cMsdue440rsG7sGFpDNNMeAiHf81Py04k6hJyEHVyXCYvG6m9Vh6xrHYMMjpMv1XwDYgT878=
Received: from BN9PR03CA0645.namprd03.prod.outlook.com (2603:10b6:408:13b::20)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 03:35:58 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::36) by BN9PR03CA0645.outlook.office365.com
 (2603:10b6:408:13b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 03:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:35:58 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:35:53 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 08/11] perf/amd/ibs: Enable fetch latency filtering
Date: Fri, 16 Jan 2026 03:34:47 +0000
Message-ID: <20260116033450.965-9-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fbc93c-ed9f-4626-effd-08de54b05cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f87M9fiRF5cVkZDh6O70zZFefq16nhzG//1aLsNg3L9i9C/ie5RBB863T5ek?=
 =?us-ascii?Q?COALD0y++mPnRGu8GIzTmpzgo89s/5YYN5SXnhZQtXSRHhPfrvRiUWMChdBW?=
 =?us-ascii?Q?VYgKVfT12RyU8d28VldLV/Mp26uLztGlTNx/usX+ycmoV3EabIu4KmlW9RLv?=
 =?us-ascii?Q?rrcTMKfp6orYcikyTMCuRutFy5PEug0/8S686E8OUHpBtQEIH0lF2KSie3bI?=
 =?us-ascii?Q?2Ije07CQcrrYtDeDIPGmHYHKu4bXEgWR54fhbD+0tzaGxwN9wUv9kXzu7S3B?=
 =?us-ascii?Q?FmMi7LcbZYvP26Ntvxb4WWjabifXTPuc9oNHLy+DnS6peglcEOuPnoqtx3HV?=
 =?us-ascii?Q?C0CMYsBa68ktgehbJIDtkTFpKO8nre7UhsWuU/ykRofR+RuO/WR7nilzbrDA?=
 =?us-ascii?Q?Oj9n+hrfemmWHJn1b0xtaCmnB6780pIeYWmOKfNeE7dsM9Ngc12kV1v7jZVL?=
 =?us-ascii?Q?l3bcgE6uZ/djS7wycqN4P+5bSL1G/s97YOjtCZQNiFFqsI1eLKOHjdaXgaeq?=
 =?us-ascii?Q?/bIAdo4RzsbXH5HZVwiykbd3rh+MoN/IY6yKXk7DC2newXxQ+7jGZXev49b9?=
 =?us-ascii?Q?gCfZBlkDD3H9IsJD4f+SwZwzp4cx3F8Nk0O49NeSQhIyiSCwP6boW2eyX24p?=
 =?us-ascii?Q?LHWPU8PgYK5Wewv//FdodDDrl8+HrcBN/FrFgc7TKCtcVIfWhSLGzi3QcXDO?=
 =?us-ascii?Q?4bnSK5tAgq0MihYYeYjeUkD3BZGeVYzayGEZPPfca8Cn66oldf3Il1IBtL17?=
 =?us-ascii?Q?49TlHURRQEmmXsIFj7StbBFdzeLzQKnQw3Rfuw5oYMCYhdKjHEZEJvWFsVMl?=
 =?us-ascii?Q?ra3l49SAVrILKrD/2cFTHQHul1VNmfqThQAiDEH71B/N9BZICEVpQX6cc6Ah?=
 =?us-ascii?Q?h73selXpMZmkwFeg/qbKd0dklH8XcLBc+64kdj/ujMJrY74gZb9nwvOHzkc/?=
 =?us-ascii?Q?TdiS7Wpg6Dozs5wES1UaxFjlZ0lIzG0KX79pOWSumHLvvaK4oSdY7QzJ6/Sw?=
 =?us-ascii?Q?nuEhIOd2eDa0claXAUnM9UodBN5+hd9p0Xk0V7qBUqYeun5/xhKUcCTcNNfH?=
 =?us-ascii?Q?Fy2h9nDM65suIhmDEPbbakCfSHt423kCSerQJTzzcQKlm4l+CB1JvaEYIlVV?=
 =?us-ascii?Q?uhQvlJ3tlWGMUCzmbAj+WyVl17TFGblzuujmzUSy9bUmIZ25qNFidU3o84JQ?=
 =?us-ascii?Q?Sm1D1rNgIuLdJZB116sM3WRNOlOVmBrf+GNjaPscjVWqKzbHMbbUVrb5QcIN?=
 =?us-ascii?Q?ctEJf1Yy5/tl8NzG4VWjWj+QMhmhNE4zU95iNpcX2xzoM4GJjPCgBjK4nQ/o?=
 =?us-ascii?Q?gGFBUE4hCSBYItdaAg/e2QxW4SBZURDWdp1ZIKc2v9JX3/YUVvrzmVKmqT6i?=
 =?us-ascii?Q?nPjCR+X5IrqgdZAMDrHB7DLjfpbMdKu0mV2nHb+q9HxrR1XmSfCga7lPoVZa?=
 =?us-ascii?Q?xsvMIM3a8dUTFEDnBfoXoa5QKmBMBqmYTPuSIs15VioX7wSww52IGeqOMwc1?=
 =?us-ascii?Q?ZtF77p2tbpEg5KOf0fCPIzxwWR4QXuJisZqeBbZjCyOFXhFDXcd6xbVncqPO?=
 =?us-ascii?Q?2bctFQTGtDexTOE2PbpotEwnWETOfQvvaxE0BznENyxYoeAPf2xtk4HyhRjV?=
 =?us-ascii?Q?oBB6ZEW36ZFWQqB7B5d4TtgBR4WbvxPwRe9yGm2/Pk4bsTwgOedw9+hypeAb?=
 =?us-ascii?Q?lJ2UJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:35:58.1130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fbc93c-ed9f-4626-effd-08de54b05cd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403

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
index d8216048be84..b2d21026edae 100644
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
@@ -374,6 +384,17 @@ static int perf_ibs_init(struct perf_event *event)
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
+		hwc->extra_reg.config |= fetchlat << 1;
+	}
+
 	/*
 	 * If we modify hwc->sample_period, we also need to update
 	 * hwc->last_period and hwc->period_left.
@@ -662,6 +683,8 @@ PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
+PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "config1:0-10");
+PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -669,6 +692,12 @@ zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int
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
@@ -697,6 +726,16 @@ static struct attribute *zen4_ibs_extensions_attrs[] = {
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
@@ -724,6 +763,18 @@ static struct attribute_group group_zen4_ibs_extensions = {
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
@@ -745,6 +796,8 @@ static const struct attribute_group *fetch_attr_groups[] = {
 static const struct attribute_group *fetch_attr_update[] = {
 	&group_fetch_l3missonly,
 	&group_zen4_ibs_extensions,
+	&group_ibs_fetch_lat_cap,
+	&group_ibs_fetch_lat_format,
 	NULL,
 };
 
@@ -1188,7 +1241,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
 {
 	if (event->attr.sample_type & PERF_SAMPLE_RAW ||
 	    perf_ibs_is_mem_sample_type(perf_ibs, event) ||
-	    perf_ibs_ldlat_event(perf_ibs, event))
+	    perf_ibs_ldlat_event(perf_ibs, event) ||
+	    perf_ibs_fetch_lat_event(perf_ibs, event))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1330,6 +1384,16 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
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


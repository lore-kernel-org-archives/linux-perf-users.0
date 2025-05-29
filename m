Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A93224AF0;
	Thu, 29 May 2025 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522128; cv=fail; b=aKKSiOlpAcSJQEuFIw+DqxHUvteay21vx5emuXClsAOGY/PLgJ1GKiFS7TmsbF5CKDi2RkZv8ypUapWz+rxNv6kfnBv9XjTInUUoPEZo1cWIZVN/E7t9K2/ZL8QG4KBZpxIULohGXNFH0Ne0xMJK2AjkycAaJZIkMK4ClQeqOLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522128; c=relaxed/simple;
	bh=b7ZS2cd6P04Z+KBH0avUktFOZ5d0y0AgkkV2IcCCLTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVL50yGamE1+sR4v/4XWTOl5pVlpWWCg7WkWKzKHGrdKW0Yr7QVo/BRH89O6uwfBXLA+bY26T5fi7sqe5KsDujuOkEyXSLLwfadfpUPBE4D1SHi8UD+cQ1huP+V4DxndTcvDeITs6r0iSAIakfljUj64mmegIkXD4VVFaZpZrV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1owAawSU; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1owAawSU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2H0qd3w8oDEIJCuGFprHEXeM+61laivVEWCC5OrxesQ70kQ4PXp7mI/kg+dmnA5x9AQSHVVZL8Dt+87i/3ucR7W0Vz8sjAOMiBPcE2Rl0s3NXQdse53GAtgEVnLLTBdlmQh2YG0m8l9HdxT0vNQ7mLqlam+MWSrnI3m9oMuBl+UmqGtaPKWp8DlFh8AtXztmUiDuz60IS7bXvzabtLI9v3jVxlzfMmsny3x76oRX6GsCCtIKpK2LekBsrpTzTQlgY5p6e/jttloq0Ne9k01bm2BXJf93k10rd3W8AOLgeFbdJ9/lm/382L8FAnFNE23HKEeSVRf3sjFJ/w/gyjvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZyfSlNYr+LaLHbYoXFd8B5aGfRJDrahEKGNaQAhnfM=;
 b=DNy73tC1r+b4l3XtYwQcoD5F8fZn9UJ+rIAFEYr/k2cFPXQPZz3iDu3sHcvM/C2RFFLrCEohTpLmGY3G3ox/QMEkaWDO3gyaBkG5P3k2M8y3KSMZ07nXH1UJLtUJm0u+yWxit8A7iiFFc1IknHHyK7rXyYL4KgIjUbtrTIfEUbpYbpNBwH/+SQPFwMNOHMMAalLXioaYrmS3F8DfoHBfbJmwva/Wa67EwlzHomNSATN05f5unV+iA8vn+KGRiZif9tt7taH9H3U3JLqYvuA2XM7CEjz/AxBesTY4xid4U98WynlOdAs+tdXPeDfWluzxdHe5exv+JHIeUggjCz7Jnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZyfSlNYr+LaLHbYoXFd8B5aGfRJDrahEKGNaQAhnfM=;
 b=1owAawSUslPg3dcuuomy5IRRbjUMqz8IGiq+DQ9d2UF9NN6EUQxrdDer4VZAwcXpLLfj424RqL6gXKRxfGffh6t/EbZ59b4ngqKTZGXj80v3zBT2VHaXU8LrpBsBnTLJG0uLHcV6ul6Tt+Zobc6CRViKnJySg/gOtxpvsaE5XrE=
Received: from SJ0PR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:334::20)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 12:35:21 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::83) by SJ0PR05CA0105.outlook.office365.com
 (2603:10b6:a03:334::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 29 May 2025 12:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 12:35:20 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 07:35:15 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Ingo Molnar <mingo@redhat.com>,
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
	"Leo Yan" <leo.yan@arm.com>, Joe Mario <jmario@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 1/4] perf/amd/ibs: Add load/store SW filters to IBS OP PMU
Date: Thu, 29 May 2025 12:34:53 +0000
Message-ID: <20250529123456.1801-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529123456.1801-1-ravi.bangoria@amd.com>
References: <20250529123456.1801-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 9146b65f-0226-400e-a832-08dd9ead46c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g1YtvJqVDcfCDXlrfRABiulBBmDJWRu+XYOpLvUFS82SzcN1wdH9Ks6lZ0zG?=
 =?us-ascii?Q?cj7mtmlVlBEw2JpCUpzk1B0HdCb0+mKCs8iGwB/eK/A6Mg7YW2t5szY8KdIJ?=
 =?us-ascii?Q?Gw1J2davZryvTPVBKYqiK5tpCvEO0sh/4xmT5UfIsJKE0k3/Nbq89uxab0Qm?=
 =?us-ascii?Q?mM44qZCRhFnquQoncuOusOtiJAgwVHfu7fQNyopPPZ0Glk0YsrCo7hdUDKgL?=
 =?us-ascii?Q?1l+EmHtav/MYzHgkB2ZksE3pTcdHvHBhVmpCh6CKJuTBOlvZGvXIdZtCQBG1?=
 =?us-ascii?Q?6WlXaqwuHkLfUt+3B2TSRkZ86a/AThQ9vpj6K1Y3QQqMavso7PHHBtHE1QVg?=
 =?us-ascii?Q?50/Fm5tSIqU5mWuScgBUFQSO2Zscx6vHMqPXQF+D0mx3bJl3FRVGotwwyc3l?=
 =?us-ascii?Q?7ta6cDZEA6HwyzixRS0Flg5q3LuRCwXZNJyl8T2v4GvcOhH49QjKo2rUnY04?=
 =?us-ascii?Q?Dg0OkY69dy+6t03H+Xv7L4dzAXLIkyB6/KmOGJY9SGT7BDuONFl6YjHhuIpm?=
 =?us-ascii?Q?b8gC50a385z3rweuA88IQow3Ii+gKIfiMJceYUFteySS0wqDwWCbg4Xc4TRA?=
 =?us-ascii?Q?to0NJJ3YSq0BfgoId5ynQSP0OkhUO2tLmK2LzXpq+Wp3xnnn0quiPlpAKbuf?=
 =?us-ascii?Q?USOHJq9SncJr43Enj1WO8Rxxq+FhIQrzvfiPOu+y0QIwP2o5B1+xrvEFswq5?=
 =?us-ascii?Q?wau0yVdy/OomwjQLEqdg3Z49Vd63SzNQ63rh5pqmnhzfNckj7RFjl6xVzECc?=
 =?us-ascii?Q?Bdxsc21iKqKA8mg00ay/cjjdB5hMahxs9/2Th8EG7F3Onnv2Tg6VcWrwJpEs?=
 =?us-ascii?Q?gM0qYa/j/GSo5Jb9T5NXakI9H6654FrDBNiVtzUfzGZ3c30EtcmxRdYdJMhL?=
 =?us-ascii?Q?TpBoJrj0AlnFkx/lSkMOl1eaDAo4pONVH/FcjWB9DOH4rxc4zkA5Jmw0aq++?=
 =?us-ascii?Q?EAWTsSqZbE6WM4dJFGmoIvST5OEZ/vxhWIkEAozYVgVPiEOBjQW9VOrsmtV3?=
 =?us-ascii?Q?ZqIqSxhylbh2nlmbZsIXQY+3ecpSTvIMiAzyeGGNTggODpXi1P0FNCNc7zLh?=
 =?us-ascii?Q?fvhaKx3jfzM2RbW1f0uRc8ChEEMKDhguoPj5emH20epy4HM6Gt/69YJNYLBJ?=
 =?us-ascii?Q?bx8YIpWjVfPIgQfZT33d6eRCg5IGmUAFdwa5T/WRYDbwVXFilXE8HvzXgeJV?=
 =?us-ascii?Q?3RqZsxevrQauTLSe03XhJbKvw6Oln3LKoju/3c6X19FmQUryDsAYp179ZLVZ?=
 =?us-ascii?Q?AT5Xbw8rJncNDAS6DfVr47egIm2ghDpP2P2klpyD9PWE3SSJp5w3p0Jmrj7x?=
 =?us-ascii?Q?GHI5RdRx0/oj+20xtNWQjfMmItWvyWgSDK8KmvbD6LF24VnOOqlAl3tIh8u5?=
 =?us-ascii?Q?Qgxcb+jrORyTrkSlCghSHV24KOswK5sBK+CLZgWmEmCFj8UBgzh/c8PHw1Ex?=
 =?us-ascii?Q?fbmwXg79YgWPhoy3OKH462a9chuRX1aCTxj6G02ls4wRvZcPyIZjhZ1rfqPQ?=
 =?us-ascii?Q?oVn9w9V3grRAf3HzizW96d/QBwb/CATln94O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:35:20.8979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9146b65f-0226-400e-a832-08dd9ead46c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500

Since current IBS OP PMU does not have the capability to tag only load/
stores instructions, tools like perf mem/c2c ends up recording lots of
unwanted samples. So, introduce a load/store software filter in the IBS
OP PMU:

  ibs_op/swfilt=1,ldop=1/         --> Only load samples
  ibs_op/swfilt=1,stop=1/         --> Only store samples
  ibs_op/swfilt=1,ldop=1,stop=1/  --> Load OR store samples

Other HW or SW filters in combination with this ldst filter are logical
AND. For ex:

  ibs_op/swfilt=1,ldop=1,stop=1/u is
  "privilege == userspace && (ldop == 1 || stop == 1)"

  ibs_op/swfilt=1,ldop=1,stop=1,l3missonly=1/ is
  "l3missonly == 1 && (ldop == 1 || stop == 1)"

An alternate approach is mem_op BPF filter:

  perf record --filter "mem_op == load || mem_op == store" ...

However, there are few issues with it:
o BPF filter is called after preparing entire perf sample. If the sample
  does not satisfy the filtering criteria, all the efforts of preparing
  perf sample gets wasted.
o BPF filter requires root privilege.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c  | 73 +++++++++++++++++++++++++++++++++++---
 include/linux/perf_event.h | 14 ++++++++
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 0252b7ea8bca..d18ce6464b27 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -31,6 +31,10 @@ static u32 ibs_caps;
 /* attr.config2 */
 #define IBS_SW_FILTER_MASK	1
 
+/* attr.config1 */
+#define IBS_LDOP_FILTER_MASK	(1UL << 12)
+#define IBS_STOP_FILTER_MASK	(1UL << 13)
+
 /*
  * IBS states:
  *
@@ -308,6 +312,11 @@ static int perf_ibs_init(struct perf_event *event)
 	     event->attr.exclude_hv))
 		return -EINVAL;
 
+	if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
+	    (event->attr.config1 & (IBS_LDOP_FILTER_MASK |
+				    IBS_STOP_FILTER_MASK)))
+		return -EINVAL;
+
 	ret = validate_group(event);
 	if (ret)
 		return ret;
@@ -624,6 +633,10 @@ static struct attribute_group empty_caps_group = {
 PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 PMU_FORMAT_ATTR(swfilt,		"config2:0");
+PMU_FORMAT_ATTR(ldop,		"config1:12"); /* IBS_LDOP_FILTER_MASK */
+PMU_FORMAT_ATTR(stop,		"config1:13"); /* IBS_STOP_FILTER_MASK */
+PMU_CAP_ATTR(swfilt_ldst,	"1");
+
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
@@ -724,6 +737,8 @@ cnt_ctl_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 
 static struct attribute *op_attrs[] = {
 	&format_attr_swfilt.attr,
+	&format_attr_ldop.attr,
+	&format_attr_stop.attr,
 	NULL,
 };
 
@@ -737,11 +752,21 @@ static struct attribute *op_l3missonly_attrs[] = {
 	NULL,
 };
 
+static struct attribute *op_attrs_caps[] = {
+	&cap_attr_swfilt_ldst.attr,
+	NULL,
+};
+
 static struct attribute_group group_op_formats = {
 	.name = "format",
 	.attrs = op_attrs,
 };
 
+static struct attribute_group group_op_caps = {
+	.name = "caps",
+	.attrs = op_attrs_caps,
+};
+
 static struct attribute *ibs_op_ldlat_format_attrs[] = {
 	&ibs_op_ldlat_format.attr.attr,
 	NULL,
@@ -761,7 +786,7 @@ static struct attribute_group group_op_l3missonly = {
 
 static const struct attribute_group *op_attr_groups[] = {
 	&group_op_formats,
-	&empty_caps_group,
+	&group_op_caps,
 	NULL,
 };
 
@@ -1148,13 +1173,23 @@ static bool perf_ibs_is_mem_sample_type(struct perf_ibs *perf_ibs,
 			      PERF_SAMPLE_PHYS_ADDR);
 }
 
+static bool perf_ibs_ld_st_filter_event(struct perf_ibs *perf_ibs,
+					struct perf_event *event)
+{
+	return perf_ibs == &perf_ibs_op &&
+	       (event->attr.config2 & IBS_SW_FILTER_MASK) &&
+	       (event->attr.config1 & (IBS_LDOP_FILTER_MASK |
+				       IBS_STOP_FILTER_MASK));
+}
+
 static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
 				   struct perf_event *event,
 				   int check_rip)
 {
 	if (event->attr.sample_type & PERF_SAMPLE_RAW ||
 	    perf_ibs_is_mem_sample_type(perf_ibs, event) ||
-	    perf_ibs_ldlat_event(perf_ibs, event))
+	    perf_ibs_ldlat_event(perf_ibs, event) ||
+	    perf_ibs_ld_st_filter_event(perf_ibs, event))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1189,6 +1224,32 @@ static bool perf_ibs_is_kernel_br_target(struct perf_event *event,
 			op_data.op_brn_ret && kernel_ip(br_target));
 }
 
+/*
+ * ibs_op/swfilt=1,ldop=1/         --> Only load samples
+ * ibs_op/swfilt=1,stop=1/         --> Only store samples
+ * ibs_op/swfilt=1,ldop=1,stop=1/  --> Load OR store samples
+ */
+static bool perf_ibs_ld_st_filter(struct perf_event *event,
+				  struct perf_ibs_data *ibs_data)
+{
+	union ibs_op_data3 op_data3;
+
+	if (!(event->attr.config1 & (IBS_LDOP_FILTER_MASK |
+				     IBS_STOP_FILTER_MASK))) {
+		return false;
+	}
+
+	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+
+	if ((event->attr.config1 & IBS_LDOP_FILTER_MASK) && op_data3.ld_op)
+		return false;
+
+	if ((event->attr.config1 & IBS_STOP_FILTER_MASK) && op_data3.st_op)
+		return false;
+
+	return true;
+}
+
 static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event *event,
 				    struct pt_regs *regs, struct perf_ibs_data *ibs_data,
 				    int br_target_idx)
@@ -1196,9 +1257,12 @@ static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event
 	if (perf_exclude_event(event, regs))
 		return true;
 
-	if (perf_ibs != &perf_ibs_op || !event->attr.exclude_kernel)
+	if (perf_ibs != &perf_ibs_op)
 		return false;
 
+	if (!event->attr.exclude_kernel)
+		goto ldst_filter;
+
 	if (perf_ibs_is_kernel_data_addr(event, ibs_data))
 		return true;
 
@@ -1206,7 +1270,8 @@ static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event
 	    perf_ibs_is_kernel_br_target(event, ibs_data, br_target_idx))
 		return true;
 
-	return false;
+ldst_filter:
+	return perf_ibs_ld_st_filter(event, ibs_data);
 }
 
 static void perf_ibs_phyaddr_clear(struct perf_ibs *perf_ibs,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0069ba6866a4..dedb92d5cd61 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1998,6 +1998,20 @@ _name##_show(struct device *dev,					\
 									\
 static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
 
+#define PMU_CAP_ATTR_SHOW(_name, _cap)					\
+static ssize_t								\
+_name##_show(struct device *dev, struct device_attribute *attr,		\
+	     char *page)						\
+{									\
+	BUILD_BUG_ON(sizeof(_cap) >= PAGE_SIZE);			\
+	return sprintf(page, _cap "\n");				\
+}
+
+#define PMU_CAP_ATTR(_name, _cap)					\
+	PMU_CAP_ATTR_SHOW(_name, _cap)					\
+									\
+static struct device_attribute cap_attr_##_name = __ATTR_RO(_name)
+
 /* Performance counter hotplug functions */
 #ifdef CONFIG_PERF_EVENTS
 int perf_event_init_cpu(unsigned int cpu);
-- 
2.43.0


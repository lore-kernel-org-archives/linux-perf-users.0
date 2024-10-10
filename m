Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA112F50;
	Thu, 10 Oct 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536928; cv=fail; b=Nfbap0nuoUuW836XL1wFl99z1xo+Wx0ScAGnq1rvReaofGYcbHi7iv9ZoSLc0iPMPogiIWpX7+UZFPDDclL429jmGvh3b8F3aHqPquc7kICvRBnqNuveMbBJV35/Iu4/PhmK73qDej9Zj5nn4yrA5lA1t367T7aFVvvaro32RR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536928; c=relaxed/simple;
	bh=vlNSNUP0Z9kJ8YNMgeDniTLmkJVEjxEYSn2xyBmqUcU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aTi45RlOJVlkPwNTksvQ6pNLh4FOZKaAmWHa4O95IPvY9CnX03ZEYZAUtkz6ilWbbL458rZ9XFhUB/aswNX8efcHzunA/sAizr/mOSNZymK2+rW9QomYx0yNdZleAfpDf/vpAdxSTlG9ZqK4Vwi9mN57htMJN42ra6SiNvEpq0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U+mf1IKH; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U+mf1IKH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxmMLyx439gyEDITSR0VDAaGuOILsNA1/+kngv2XmGqjJBZVjJpbS9bABGG0Zl7Ck6sr/8dtEq9fWT16SuYHQftO5aIAPBGemCVB0wafdCueRug9uQwfX80LowEjy17pH4R5FY9QAr8LhrZSLXhtJI4r0NySpqxnkYcp/qFOKOs6I8kfICykIghlQrgIg9V3dXg6X1RF7QX0rz/08Mr9Q7WK0t6uwIiW+Y+u+2CeNEw4Oazj51VUxIJku8ymYDMdDPS7Xuw9BRXpwyraA+KW0rrlttSyVIST9cK3+HVUaKKtIKn+JsOVpWZSm9wuY96b+Sx1w8J5HU77JD9fq3DVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUIpQQOmYjVlh8TNkigvfghJB73OnDKuK71rbuaVw7U=;
 b=GMWs4n47NPG5AS3b9Q6G4Cy7oU+XRLb3PFnHnewhnkuy3pen/r/wQTS5V1oRERibMJipjlAazepedjIBaweGrihX5J4UO99LWX5fCHFVjyPpJTgh8G1gbhGC1Cbunf1UIKKgsK9DjI4SrUh4xTEYjf4XZK2NjcRZ31VtvnqsLbff7x/4T8SdyxBHru19G9Fgs4tFWktwDDFmDw/VctXhHaEzWe/T6xYR62uvNRXXTZWc0qXdW7G+hrOVByoOhxjneAqGilFNMLvnBHJ6+rp8CbP+w+OF+w1BTwhHTgmT3MAfVU57VhtyZHqA+o1Ci+YefhHIBY9KpvNXJxq6vabMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUIpQQOmYjVlh8TNkigvfghJB73OnDKuK71rbuaVw7U=;
 b=U+mf1IKH+QoqH25F6oW2m4jo8YNoWTpc5vo01PjYRoUOvZWkgPKw5btlXMeMQ3hD6k43z6hnYmZAwy4SL1IP2ISIVoqiZyu4mrVXmbKcaxBCOt1bxLesMOMngGkliSKqfkPCPS0npBhfy2O+FslUnHjxfNOIG3FmFf/fZ7/kSLQ=
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 05:08:41 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::82) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Thu, 10 Oct 2024 05:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 05:08:39 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 00:08:32 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH] perf/amd/ibs: Add support for OP Load Latency Filtering
Date: Thu, 10 Oct 2024 05:08:15 +0000
Message-ID: <20241010050815.751-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: fc54ab90-ee81-4f7a-c6a9-08dce8e99a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NDNm+FtIZV+0MSGF/E739MBkbl4dnM6Jb2qENn5aWUaB+9tTB2NcFvNbhaNi?=
 =?us-ascii?Q?spRill2GvUBN38fYKPwhRO7kh7qDR/R1/6FGpWCIfzs5pm4WSll/kBecCEKU?=
 =?us-ascii?Q?YbGjkrIFOMktMax0zrcHj7LVkxetl4yrpRFERMUf6EEZKgIiz0iPaz5yOFJR?=
 =?us-ascii?Q?8rW7xpy8UG4WHbdczASVuyNIozk8cPUXAcNNzljDIU00cAUBBFM0Fpu0kmQf?=
 =?us-ascii?Q?F1yxTtsZsN985WHUvQR2mIMfqRy8rDbbm6zIop3H3h50EfMZKP554P+YlpbK?=
 =?us-ascii?Q?ZC3tk1K54lQkl221+rsmjIy6URYj2xbK/O11LNypd4yFXHj8m1p5kgkD7VzD?=
 =?us-ascii?Q?EY9JihJhZuEtWSHR7CUMSP9o9WA2GIPT9ZdlE8870tI+sMDkVXdq4a21l+pT?=
 =?us-ascii?Q?LG7RsS6IVZK1rdUfPvM0LlNDyVyqS9ZoRoXQ3iLfJ/9WQ7VTeql4k8b+fn7P?=
 =?us-ascii?Q?belsevp2MjJipHq75EkeNUiYSSEvVErTKpDmqKpcl3kHleLznaZkf6NDB+Ev?=
 =?us-ascii?Q?0Mx/dNbsqcj+fEP6VypsWfMa4hHZZ4ERMCRgtaHha7WwrRcwRY/kGwVgb3w4?=
 =?us-ascii?Q?Hqz/qwR5pAKnaBsS7bxMe0JGh0knK/4qRB/JldRR0jsrHZOAE2p0kPE5qJBv?=
 =?us-ascii?Q?j7aPb/5NcdjAnP8FCg59MHH/hlaKlMiEAbmb1jwM4w0VrTAVVrPA1zGwvDyx?=
 =?us-ascii?Q?RAjYsyzLKJd6tPyqdEjHBrsqoBIEcnjS1oYpGrybCXDDFfuWchAcbJQW2KQO?=
 =?us-ascii?Q?1AMssF3hSt2rgVPdxOiRjAwrN87x+6EjKBoD6WUuxXqgaCvCkoF7fhDJXWiT?=
 =?us-ascii?Q?rWOqVCjmPMpED8lEIPMGLMlM73YkmNkXjT1GhAjbE2RDPIAW0BBPg+SdRPPU?=
 =?us-ascii?Q?OlX+dkXGaSCeomOmEX3wwKxits5dq9CVdZbvat+UGdpJIoBVg8zu/5aTgmkL?=
 =?us-ascii?Q?tuNPkJoN/8nnAnfqPvpOzOE+1wTmiROXsmWgA+/6FDKQO2YjGdI6cEv4lNDV?=
 =?us-ascii?Q?upjHzHRzq3LfEHYl/C8RESUp7QJRXjqoz3PfCqWCLOhDB8qt+6DNcQTAwAXD?=
 =?us-ascii?Q?Vr6q3AZ2uuv7TMbUneTGIsPNzYC+voOBNDCPdhqyZPVMyrax8h+xU+FJLwUc?=
 =?us-ascii?Q?VaBrSkPUk8AgOe/sg2483KSNmeoavL3tQKtZ1NWR5OMjRLAxLQ9bLVCp2+bg?=
 =?us-ascii?Q?RsmkCmnXYSA5/SrRlw+tZw2R7I9H9vJoaAWBUFMugK5DldOpYmCIf3YyY9HF?=
 =?us-ascii?Q?KkQBqXTqKq8aiOzabYGH1amBtgAY2f6HK7Xn2SbIJN+qPbnKKbo570cvJnbj?=
 =?us-ascii?Q?N5LsAspmi1D+BGuF6N2gfkFKk9j+n2eLSArVmzXJmcjQJM/tXPMkCqvpKlL3?=
 =?us-ascii?Q?EECxeSg328zAlxXTE5QIHppkmKHV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 05:08:39.2214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc54ab90-ee81-4f7a-c6a9-08dce8e99a50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536

A new Load Latency Filtering capability is added to IBS Op pmu with
latest (Zen5) uarch. It's advertised by CPUID_Fn8000001B_EAX bit 12.
When enabled, IBS hw will raise interrupts only for samples that had
an IbsDcMissLat value greater than N cycles, where N is a programmable
value defined as multiples of 128 (i.e., 128, 256, 512 etc.) from
128-2048 cycles. L3MissOnly is a mandatory dependency for LdLat, and
like L3MissOnly, Hardware internally drops the sample and restarts if
the sample does not meet the filtering condition.

Add support for LdLat filtering in IBS Op pmu. Since hardware supports
threshold in multiple of 128, add a software filter on top to support
latency threshold with the granularity of 1 cycle between [128-2048].

Example usage:
  # perf record -a -e ibs_op/l3missonly=1,ldlat=128/ -- sleep 5

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---

Note: IBS sample period cleanup patches are pre-req for this.
      https://lore.kernel.org/r/20241007034810.754-1-ravi.bangoria@amd.com

 arch/x86/events/amd/ibs.c         | 96 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/perf_event.h |  3 +
 2 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 0d1db2fffc5b..50c364b7c5bb 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -265,6 +265,14 @@ static int validate_group(struct perf_event *event)
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
@@ -326,6 +334,20 @@ static int perf_ibs_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	if (perf_ibs_ldlat_event(perf_ibs, event)) {
+		u64 ldlat = event->attr.config1 & 0xFFF;
+
+		if (!(config & IBS_OP_L3MISSONLY))
+			return -EINVAL;
+
+		if (ldlat < 128 || ldlat > 2048)
+			return -EINVAL;
+		ldlat >>= 7;
+
+		config |= (ldlat - 1) << 59;
+		config |= IBS_OP_LDLAT_EN;
+	}
+
 	/*
 	 * If we modify hwc->sample_period, we also need to update
 	 * hwc->last_period and hwc->period_left.
@@ -610,7 +632,9 @@ PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
+PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
+PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -618,6 +642,12 @@ zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int
 	return ibs_caps & IBS_CAPS_ZEN4 ? attr->mode : 0;
 }
 
+static umode_t
+ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_OPLDLAT ? attr->mode : 0;
+}
+
 static struct attribute *rand_en_attrs[] = {
 	&format_attr_rand_en.attr,
 	NULL,
@@ -633,6 +663,11 @@ static struct attribute *zen4_ibs_extensions_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_ldlat_cap_attrs[] = {
+	&ibs_op_ldlat_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_rand_en = {
 	.name = "format",
 	.attrs = rand_en_attrs,
@@ -650,6 +685,12 @@ static struct attribute_group group_zen4_ibs_extensions = {
 	.is_visible = zen4_ibs_extensions_is_visible,
 };
 
+static struct attribute_group group_ibs_op_ldlat_cap = {
+	.name = "caps",
+	.attrs = ibs_op_ldlat_cap_attrs,
+	.is_visible = ibs_op_ldlat_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_rand_en,
 	&empty_caps_group,
@@ -678,6 +719,11 @@ static struct attribute *op_l3missonly_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_ldlat_format_attrs[] = {
+	&ibs_op_ldlat_format.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_cnt_ctl = {
 	.name = "format",
 	.attrs = cnt_ctl_attrs,
@@ -690,10 +736,18 @@ static struct attribute_group group_op_l3missonly = {
 	.is_visible = zen4_ibs_extensions_is_visible,
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
 
@@ -1050,15 +1104,25 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
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
@@ -1113,7 +1177,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	offset = 1;
 	check_rip = (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_RIPINVALIDCHK));
 
-	offset_max = perf_ibs_get_offset_max(perf_ibs, event->attr.sample_type, check_rip);
+	offset_max = perf_ibs_get_offset_max(perf_ibs, event, check_rip);
 
 	do {
 		rdmsrl(msr + offset, *buf++);
@@ -1122,6 +1186,22 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
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
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 72f1bcb0fa31..e6cfd948c6e3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -471,6 +471,7 @@ struct pebs_xmm {
 #define IBS_CAPS_FETCHCTLEXTD		(1U<<9)
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
+#define IBS_CAPS_OPLDLAT		(1U<<12)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
 					 | IBS_CAPS_FETCHSAM	\
@@ -496,6 +497,8 @@ struct pebs_xmm {
  * The lower 7 bits of the current count are random bits
  * preloaded by hardware and ignored in software
  */
+#define IBS_OP_LDLAT_EN		(1ULL<<63)
+#define IBS_OP_LDLAT		(0xFULL<<59)
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
 #define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
-- 
2.43.0


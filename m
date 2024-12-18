Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA41A9B45;
	Wed, 18 Dec 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524278; cv=fail; b=E8qUouuZo+DU2A8grqQ14aaIRXIBJR+8jLgALvFi/G7Ap/AiTId5RAtLqHjXXawtM1jh9uoXX+adpW+2J4zrMd8ifz6bWeo/2AA0vywIJsbK0KuveM4L9Bxlz3uQeBIIrQf318KWf6eCGVa2jiwm0p23k5yauem3uUhZlmb8WTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524278; c=relaxed/simple;
	bh=HvjIq6Wnvbr7AVDqTM8QvT1xJlzEgcjh83d4ZYmlLBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gx6e1Apj1e3+qy+RslHrIH2UG3ndm2+D+p05+nfnSH+gQkz0f0VIivAn6ZSgPKnkt5A4aH7MtCLvScKyCFu8XS+jMf4PAt5KmfbHV3Ci0KvpCGDPtuwuqv384pQgdlyQm3mYDjtUbE6soe1NRqpvNE6oL43V3u4KU5iVOz+3un8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w03C3UEF; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w03C3UEF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Onhv6TToPhUFgkcgAoeGxX4FvLGXZuL8+o5Ej3KQcWqhayr/+9xiHRFo/F4j4vkrylAWd8bA5ewI20hzrM9eXhxgbsKmJJzQC0q0IBVC5AnNfX7tr3iOboBmhFY+jjfO4vFhBJjn2pADZrhvzQW7fKGLPyH9fKHdELAFMGi5I505IdA3hoDwh6mJvCF5TJBjwQ/R3AbsrZfNe314+HeymsV9R8BFvhJRJyBjbk2NfQ0TKLDlzH49yDCnWDkV+aZJxSN8qCf+0c+dFoYCdj3ZwCO4amL1yptp3cxnnLvq+kuINaKvA2MSFNAjqbV6HFuDaoUQNXtNSpq8ofPjEC0hFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1/o+MuNeq9TgSmVNN9o2x2EJzI88boCQBSbTV5jQbw=;
 b=SWxcYTM3QOCuxaOd2AzxSvailwyD/tMTqZRGYeB/1fl9nBNWF0Ix1eihZnzN01auzxVNNAmMqyDCs1rw5yooSWt6vN4/L7ylTZu1yUjX8fn4e3GUlcI2aytaTd5cdjk3NjML6ENU1v0lgNkF21eesN8vbiCHmBndoiyZnQP4p5XmNbvrH8+usI2SJR0o1dgPyDOo+F6M0dZBBoRKs9XKoeEdGCeMWX5EvEnxTnwRaFPav1eaulaDvVYlwQBSe2JQ04Ofznkxd4kxO/VqP/rg2bbpHr4hRy53QntULUBMBGticOFzI2s2SALCJdnLsPygxemyNk7LU6xeX5jZIYuirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1/o+MuNeq9TgSmVNN9o2x2EJzI88boCQBSbTV5jQbw=;
 b=w03C3UEFPLf8yFaCFnlYArGksd9mcQ+gSCX3l0AevLwzEq3J9uBAATYbKibvg+BPbIWKd4FqEc6UUtg/JvpxB1+6Xk5TgYjWxOF3iY7S3EG9QFGAT7f8ZMzYQkUvFjHMsRw/ofL+EsmbrXfSaUF7uerftzjGIuCJSAom1h0jxcs=
Received: from PH7PR13CA0020.namprd13.prod.outlook.com (2603:10b6:510:174::27)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Wed, 18 Dec
 2024 12:17:52 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::65) by PH7PR13CA0020.outlook.office365.com
 (2603:10b6:510:174::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.11 via Frontend Transport; Wed,
 18 Dec 2024 12:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 12:17:51 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 06:17:46 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <kan.liang@linux.intel.com>,
	<bp@alien8.de>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 1/6] perf/amd/ibs: Add support for OP Load Latency Filtering
Date: Wed, 18 Dec 2024 12:14:32 +0000
Message-ID: <20241218121437.1717-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218121437.1717-1-ravi.bangoria@amd.com>
References: <20241218121437.1717-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: df9e8ff2-3e7e-4539-de83-08dd1f5dfe6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?quzutJ90wIk5DtjW5peGUWsf0K1Q7jE0nCczlCoLSY8AJEnx79B2pa9v3lOz?=
 =?us-ascii?Q?Osi+GBHW4kpp9mu4YzThidDeVN8AQQwlvhutvvGpCXz7zgNgoYudwh0KFzs8?=
 =?us-ascii?Q?0VquvQs8zpV0QSFeawijzqC6+osX2OD/YffwWDgu9elghgl3hNMeiO/RnYGh?=
 =?us-ascii?Q?P8gewuDJkSm6KKx40eyGTfXICAx9mqxzYii7AnipIw8tw+w8Vvq69vecxvem?=
 =?us-ascii?Q?LdhJcZQxfMpBVhRv517kxwql9FlgFNzmPq9Lm82zDDc2f5d6P1NVlHFgDgS4?=
 =?us-ascii?Q?pUHzYlwnHNFIOYolHR/jIcyCwc0RQBYHsDeP2bEoRrqJG1mk+rXtWBuRrv0g?=
 =?us-ascii?Q?XpHF+8w4fxkXfmlW8Y8N+v9SXQVhsmyimAkqXqrw6i7a2Mvw+s2wZr10viZn?=
 =?us-ascii?Q?4P9Kt2rmGIokbeq5EmlvsRZSC0M2o6V/Vywfp+tCnKjUwphjvw+d1+/K6vrG?=
 =?us-ascii?Q?3ayCIr4UcdQFydS0D6ovM4GQETM3TRx1Yhd4d1C0zyaJGVjA0pGzo90FoqHT?=
 =?us-ascii?Q?AZWx30l1r0sAGpikmvS7SJzg2SIFwrm6HM4a37STqzq4USw4C0lLz/+f1Tkb?=
 =?us-ascii?Q?8ki1+5JdDIM9AxeZs8VopeNU4N3xqR4M+dHgsGdJEvv8BsA9+j60aKrE3V0B?=
 =?us-ascii?Q?IWQYS6LQ2xhIyoOTK32PmFA25DDwnz2Up8eLg/7zzc8YeICp+sSs+z6CGRyR?=
 =?us-ascii?Q?BK2dIUtCURMgPPp3o/mHLHfZCsqJ0cc44fkxP6s7e1k0/vNb3NHSqLcc0MTq?=
 =?us-ascii?Q?UrXeBE4hLbLgQFZrVvhB2rO170yE2IS/DXdL0gYgi6mw8eWRXgXU/zE62f6F?=
 =?us-ascii?Q?stDwiUtKM7eWkYz4GVTnbwD92szY7jJalH5jTvDXD0zraPPWsShbjlk/QYGF?=
 =?us-ascii?Q?0h9oAMPsXZxyE1Wkns8CvVdGsFlSdvJxm/kaWldQ6QEEc0RiJwJSplNk/kQz?=
 =?us-ascii?Q?whlNAL1XP48bZ7lEwQniNxUM8S7vmS4IFCoe5rCJ5yk5YMgY+IBvdZUtoK0+?=
 =?us-ascii?Q?N2doa68QiM9vcUOPfbclqxKloYZalXweSKD0/HdWKSlYULANJuZDgUf1eUqS?=
 =?us-ascii?Q?G5qCb10DOzSMg5A4pwayausJ8XvQM4rK5b/XEUXCavx7oDS0I4B3+OWNtYAL?=
 =?us-ascii?Q?pV4uZhyxWL5Xxo5rJ5lwCVHg84F4BQd/LY86VIo7yEjhoUDIFlYcGPSqC7gL?=
 =?us-ascii?Q?htEbNK+fU+ILyA3ko1mxq5G8gbNa/3K5/RYSPNCl4S/8J65pF9EEa4uSaaq8?=
 =?us-ascii?Q?NCoumIQfnR5fhx8zz1QG88P8Z1wD80Ke+8WK5hYpYapneSaIxZb/qP3P3bUW?=
 =?us-ascii?Q?ToQMyqt5hM50It/xPVt2Sk14FA8w3deuKkwD3Im434Xx8wT3sYX2xxtzyG/K?=
 =?us-ascii?Q?l7syVE/k9Cg80/PKGdHyss+tBtYqjg9WyAOGX97GjvQ81Q4xQci8W3sA6B6J?=
 =?us-ascii?Q?lE0leVL4z//wDTz2m8YgelHXfnvuiPmdxV9rErkac5plnmT3o4tftUtajrxr?=
 =?us-ascii?Q?qK9l8XOMP2OIuck=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 12:17:51.5791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9e8ff2-3e7e-4539-de83-08dd1f5dfe6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434

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
index db6dc7b231e2..62fdb9b8d34f 100644
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
@@ -613,7 +632,9 @@ PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 PMU_FORMAT_ATTR(swfilt,		"config2:0");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
+PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
+PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -621,6 +642,12 @@ zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int
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
@@ -637,6 +664,11 @@ static struct attribute *zen4_ibs_extensions_attrs[] = {
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
@@ -654,6 +686,12 @@ static struct attribute_group group_zen4_ibs_extensions = {
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
@@ -692,6 +730,11 @@ static struct attribute_group group_op_formats = {
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
@@ -710,10 +753,18 @@ static const struct attribute_group *op_attr_groups[] = {
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
 
@@ -1068,15 +1119,25 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
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
@@ -1131,7 +1192,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	offset = 1;
 	check_rip = (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_RIPINVALIDCHK));
 
-	offset_max = perf_ibs_get_offset_max(perf_ibs, event->attr.sample_type, check_rip);
+	offset_max = perf_ibs_get_offset_max(perf_ibs, event, check_rip);
 
 	do {
 		rdmsrl(msr + offset, *buf++);
@@ -1140,6 +1201,22 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
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
index aff9fc693b11..b6af58e743b4 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -483,6 +483,7 @@ struct pebs_xmm {
 #define IBS_CAPS_FETCHCTLEXTD		(1U<<9)
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
+#define IBS_CAPS_OPLDLAT		(1U<<12)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
 					 | IBS_CAPS_FETCHSAM	\
@@ -508,6 +509,8 @@ struct pebs_xmm {
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


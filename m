Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219503314C3;
	Fri, 16 Jan 2026 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534578; cv=fail; b=kLItGxVxMaEmzFnvzgLwt5h8XuhOY5qAa21zZQMBt+SNA397KbQ20vj2XhsAiKFUJw3OrHPrjkkwKAg9MaqWkJH9cDl6a2tT35eIoju26etRfCewDXnS1Y26czOLXvI68t25OB35MsW+SGPuiylGPEAI6vCF9uw31GEhp4XLRhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534578; c=relaxed/simple;
	bh=ps7hD97I39xLEhfqMKWXDUctj+h0MGS7ku5NAzkUq3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJ6D9qy1E/gNMOd525fV6WPhOULtRPZPavMDtVbacB0LfL/eyeosmc1FWeo368srKP4J+CRexjZZsiZC7E4QovUuphNkJNoC/3W5m55tUtcJTr7bXZoL2V9BBhKIyxmbWZNQshxDohdPDzosLGUlWsoqOZ2yXnRPy+WUQQ5/8ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RvLpwTM/; arc=fail smtp.client-ip=40.93.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RvLpwTM/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb8Z/UiK9Eh5Yjt7TIVaiY4ZYLmXV1zHeyW9gFSIfcEyfDbbXvkheL8vf8ozhnPec8WiLHQ0gWCtffjucUb30bS+KANCGZMnxM/RLrJ95TxZXFJO4WzIthClQatVXboXcqZNyI2jlXRqje3JbgKD6YAs989ISKPhWaXe6Jf2LX+z3XR/Q7oZIGKmnVXOjTrMvptmrNT0UP6FqQ8vTo2mKI1ca0yXSKyrwXQXc2qHT5nbO3wsmKwNnBbVq8wzyzuH3YyYE9tnS+wC8pQ2sAt6p8uC7omitVsF0ed+U5fUW6zhsfFNhokE42fwF1HQRjIJMcULHYUPxpKvInJVzjNeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4EKVdMtn3oyjyGBCL5MzLul2WkQpHW+pNAqWPUajmw=;
 b=WhgLRJ+YpkJ2XqCIXThI2KbsuYA46QGm5wMmyOmld5Q2IKlDZMbkj5BLKPx1ivY4I4jHSNS+2ZR7VfnxZNVzUOk1ohjn3+kSBRN85jFwMxMUwP6S3dCQoSikF7HP0+HI9odNx/xaKwPGClkR69fE6aS1kJL3t+ktRKdeeotsgHdnBSQLbzWAO1nHTdoSQ7UQ1jwuL10yweOqm1DQbSOcfQI2a6ceiZw8GmjXVSQV4LALHBxlysBkQQyGh4aRF12V0Qv8CYvQz8VSUG/Bj1OTwAZtgFnV4im41hcaNSyxSOt6qvPOuxoXnjTxehWrAOuL1zH5WQ8kvbVdMajEQjM6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4EKVdMtn3oyjyGBCL5MzLul2WkQpHW+pNAqWPUajmw=;
 b=RvLpwTM/3Ic0NkTx4wFoUKU5we/aO4VPuwFqaUybTY3oPAqxepAaIQY996EfvRKVVcvTTwm19bTqTi1K+w+6Ve6t/+QMQ8JnUE/IM4PToRHO39vGRD6ZcueZfD6JCnSOzGxUQoivcnKRN7wqw95qlltm+yVEknA4DqqdhktIifA=
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 16 Jan
 2026 03:36:12 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::e1) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 03:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:36:11 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:36:07 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 11/11] perf/amd/ibs: Advertise remote socket capability
Date: Fri, 16 Jan 2026 03:34:50 +0000
Message-ID: <20260116033450.965-12-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a500988-58b1-41ed-be61-08de54b0650c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uf1fRWVkcTPK+8ES5Zu+ES3yveeUy1l+feOA2SqSLQIYe6dLxQBRt35HQ4vt?=
 =?us-ascii?Q?jdxBfyO3/tjhkZ0fhlfKZszgmArcGhvW20zVZJ2GdAj+U10iVujW+fjfBCuk?=
 =?us-ascii?Q?VpaCKlhBq8Pr42sAOzFMESzFTIWbsp48g0FnOC1ZV3R41Ap8Ew2bUMD7NtaQ?=
 =?us-ascii?Q?Zeg+5mbcVpIpVSaUDBbvg01Spf1uEyitNY/xORcpyKxEfkUD/WHToOhXRQ8z?=
 =?us-ascii?Q?RURiC8LazufdUP+a81kcAVTWBPRciaWvEkmCOxOaKc2h1asR54Fj1MYlo2kc?=
 =?us-ascii?Q?l94bqDeQOUkrYOeL+OSfhAsYEXobCvirCoP/gX01DjFheZL/VWpBQiiplvfK?=
 =?us-ascii?Q?I0LrAoe0Jj6PpN9MyZ5xY01pWbztgg3+CIEsplSYnpCpMf1OqIuLv4/l3Knb?=
 =?us-ascii?Q?gOplJ8pwedFDKAhrqTeKfHzEeKEewy4YvCJr2TkUB5+3hz6d2jdGcDe7V8Ts?=
 =?us-ascii?Q?qWUISRAouIcmvdJXLZI/FHOAxlX0wH5bbkizpmNhg3T6AQC+2dRG6Ww2MEKd?=
 =?us-ascii?Q?JQsKNYyc368pBu7bSYdnat+qiErtbJL9CAkW5vjHVXRiqhIn7rPJyhDw+tCN?=
 =?us-ascii?Q?fjnzUXVz/Wjm0tca1pqygzKVIUhcQ8Bk8TTN7rj15qQ34n0iJ/mOW0/JucG0?=
 =?us-ascii?Q?jDI2Qr6AoYj/4j68MkWLY8YnXsl2F3bFb+sse7VZrJyoAPRcVvMdwkvWiaRu?=
 =?us-ascii?Q?TTMJRa2Y6kMKd3oxReF+KXqTu/4aWgEGz02Ab/qtTydDfRKmAVCv6eWs7xBM?=
 =?us-ascii?Q?8Q1xqH0Ldd9G8SgEYBAS/+80np1BIsOwlofvjtkTS4dOi+LF/gt88Gb1E33f?=
 =?us-ascii?Q?LOryW/srAzncyG8pwrrDFR7fRuqoaeVt2KGcijAfcr2YgA6zMBUqlsJpmX0I?=
 =?us-ascii?Q?XH6X546DclVO16pJaou9fJRKb5vagzQ2aEWj/l66lFjHTlr57yAw9ryTswEZ?=
 =?us-ascii?Q?TU15BUbXsjKZFp0anPW6aHFFXQTODEYqsxK396VDvOEe9gBwEZ2Ws+SNDmh3?=
 =?us-ascii?Q?QDGHwrsUgLjzosCKTTTUU6vL4cGJifvRgjxMmia1r8h4m4zwVy7DMTWD+XDl?=
 =?us-ascii?Q?dAYttF+BctrTYihfT9YyDMO6ekzaD+uosrBlVThXFoy+v9OjVsiDcY51tidZ?=
 =?us-ascii?Q?7eLgdUJAtVVxL5+EA5gtrqRyDnHQdFA3RCGn8xLfbtXj2wsDJtaFBYaWxRTX?=
 =?us-ascii?Q?eJKPerqgLD65zl0XQpTvJxtBmI+0wCX1LmgerBc1V5RjErhToyEWGIlfIQDy?=
 =?us-ascii?Q?n17TQSAhUimL50uD62DR75zDTDcfPvKNRGGkAaf8rgLZ2ORdOC2t2wuCpI4j?=
 =?us-ascii?Q?v+u2t7Ohbmlwhz+13NTjZeZOUX1A589w9XEJblcd436UqU5yKTb/PPZ56scM?=
 =?us-ascii?Q?qIs2hGcvLljthhLd59WRdXzqz5YYA9xy3w2eGjufYo854jNCIB/M60IV1Nnf?=
 =?us-ascii?Q?7PCDmDcTdxHouy7EsnyxHeYOXNFHNAQ9jqbOfM8FamLAyr6B56EG71xELWIL?=
 =?us-ascii?Q?VfCv3JFVw5lRTYU1jyzWdVZ8xcHliBUvJ7kgkhPZWIZRFvm8KpzkpnNd+ul1?=
 =?us-ascii?Q?5xyq4XGcSzDwzd4bxOxHM9yajxC7dVukQUpbAZxHbUFfaPkESvtwW6OPysdT?=
 =?us-ascii?Q?jUwWdZZKxwPOO4JR3OCkwQGctwqBUtvNCii/kmjrzFERjU1NHNGLyPUMWq77?=
 =?us-ascii?Q?kSKfgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:36:11.9087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a500988-58b1-41ed-be61-08de54b0650c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

IBS OP on future hardware can indicate data source from remote socket
as well. Advertise this capability to userspace so that userspace tools
can decode IBS data accordingly.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c      | 19 +++++++++++++++++++
 arch/x86/include/asm/amd/ibs.h |  3 ++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 0331bcd82272..b1e05a13df7a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -726,6 +726,7 @@ PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "config1:0-10");
 PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
 PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_format, "config1:12");
 PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_cap, "1");
+PMU_EVENT_ATTR_STRING(rmtsocket, ibs_op_rmtsocket_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -745,6 +746,12 @@ ibs_op_strmst_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return ibs_caps & IBS_CAPS_STRMST_RMTSOCKET ? attr->mode : 0;
 }
 
+static umode_t
+ibs_op_rmtsocket_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_STRMST_RMTSOCKET ? attr->mode : 0;
+}
+
 static umode_t
 ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -798,6 +805,11 @@ static struct attribute *ibs_op_strmst_cap_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_rmtsocket_cap_attrs[] = {
+	&ibs_op_rmtsocket_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_fetch_formats = {
 	.name = "format",
 	.attrs = fetch_attrs,
@@ -845,6 +857,12 @@ static struct attribute_group group_ibs_op_strmst_cap = {
 	.is_visible = ibs_op_strmst_is_visible,
 };
 
+static struct attribute_group group_ibs_op_rmtsocket_cap = {
+	.name = "caps",
+	.attrs = ibs_op_rmtsocket_cap_attrs,
+	.is_visible = ibs_op_rmtsocket_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_fetch_formats,
 	&empty_caps_group,
@@ -934,6 +952,7 @@ static const struct attribute_group *op_attr_update[] = {
 	&group_ibs_op_dtlb_pgsize_cap,
 	&group_ibs_op_strmst_cap,
 	&group_ibs_op_strmst_format,
+	&group_ibs_op_rmtsocket_cap,
 	NULL,
 };
 
diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
index b940156b7d23..532c189e77b8 100644
--- a/arch/x86/include/asm/amd/ibs.h
+++ b/arch/x86/include/asm/amd/ibs.h
@@ -100,7 +100,8 @@ union ibs_op_data2 {
 			cache_hit_st:1,	/* 5: cache hit state */
 			data_src_hi:2,	/* 6-7: data source high */
 			strm_st:1,	/* 8: streaming store */
-			reserved1:55;	/* 9-63: reserved */
+			rmt_socket:1,   /* 9: remote socket */
+			reserved1:54;   /* 10-63: reserved */
 	};
 };
 
-- 
2.43.0


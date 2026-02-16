Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA842C11DF;
	Mon, 16 Feb 2026 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215986; cv=fail; b=cWbl+wua8vx1+yIxQkFdjlJepgV0fgLVHOrf+9b5eTTy4yuD4MW+bIv4caZd90DsBnHNq0/7rmkw9N1GEPTRHuK93EAMpjKAtrjgYvroSilEaHY/WrFujLxey9RG4xsASTgxGqLYVAKMS99NDmNEPJWOMLQzFcM6n1vmozBMaqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215986; c=relaxed/simple;
	bh=0fGOVCIVaZgiNmB7eHHJd+JWKkv1wJfRKEC4JbHeE8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtzikboWcmfF8vZoKkeaVxSM317j0MYBzoB5s3WMxdY0Rs6DF+Okvpd2wrlgGqia7PSlG9x34tdn8sbasMF+VRRDytS01zDYVoguoDNWYq3w5aB2p+Rp/8OUMIx1/3mCqZlLeYZ2BkqhYac7ziSZEvpAVT2L8zi8eCKu6X7gS5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vBJoqOuO; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vBJoqOuO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrIA1xV2KzNFoVCccN3+qLeYawfc5fXRAfNc+fXvr0qOwnYYP8RtsHsMPJUIXTmT9o7MYTEjgpnbgvwGmES2v0hHOQiQmZGM5bcYvJwPzeufAcBJvOx4SHm0TEsRF74dP/LYhyj6coygxsWNcNTSj9hZDt955D9WO/oI7AnQ7j+4Qr/bhX9u9JpJzxXOooYmmWbyHLeR1vmEmvtU7GcVjCV5s0OrgqyOv9zmMYhNh2VkXu3aXMd+9QLC601OC/uXbm5+Dogz4Y/7BeNLD3jIyEf1v0p7HCRitU/8Bf+FtgXOt49sKffBHuH5JksCnfoZXS2ahyiW5APCUpnXMapMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0NWyBQbn5NBfol5hsHp0p+SQC9kjSU5WQN52+hIpSI=;
 b=W/1rtKmV2fzZhDWdkN+u5oNwXbcilOoFxAyW3jnHKty1QGJ5hP3erHtE8UY49AsPP8cjRVqMiF/9SxorwDwbd7DSwLjKZ3YY/jMYk5Osv5yCEi/BHfcHqKN4QkrQv8TfbAX1n5bnZP8zE1B+SjjBcHKEjgA1LJrk+kV2o2UGk1YJD2iRn8e2qqXTCgwVJdI7vXJgx2GkkPfVHrd3j/0OjK9fDP+kuBfM76r5GjCw800l9X2f64dt+1qRkpusnWR1/d5KKFsg17XvjI36GS4G3KPYT1Y8lFUJxsJHMdCf2jxg+gdws7TbEg480T7mf8O7EqrF1Mw4m5BOGKX0aq//gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0NWyBQbn5NBfol5hsHp0p+SQC9kjSU5WQN52+hIpSI=;
 b=vBJoqOuOCpBNAucwEU6ax1a+4pR/y82fPHY+uq4vBpOqcBXnlZCXteia7pTtgRA+Ce5+Mq7mJmj2/Av+r3kIpyJX36v81AB5V0SglqA2mf82lc/5GSpWCwj69V2KUqshYklPMzUg5covC7YkJymB8hhCV2bpZlJOAa0O6H2ra8M=
Received: from PH7P220CA0154.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::35)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:26:20 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::59) by PH7P220CA0154.outlook.office365.com
 (2603:10b6:510:33b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:26:20 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:26:15 -0600
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
Subject: [PATCH v2 7/7] perf/amd/ibs: Advertise remote socket capability
Date: Mon, 16 Feb 2026 04:25:30 +0000
Message-ID: <20260216042530.1546-8-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 1282a08f-a8bc-4c22-d47c-08de6d1388d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mwzjlrl+u7jFSYpidHL7es9Rei7+IatfR7d7ctnLkMrw4w0trvF0pKw9pad1?=
 =?us-ascii?Q?QFVvYUt61K2Skldw2GVMf1/OJ2sVLNfxRCTB9l1f1lmc+R2SZJQcI3gqNAeT?=
 =?us-ascii?Q?lnLDb9eIK5Pw+kwbPJg3CZDlcNDjctCH2H5VY3OSaKB0ZQ9z9QZF5YQ6Y+Op?=
 =?us-ascii?Q?HyCCDmHzurXw0QLrbbzBEEriGaBBeFHP9M1qkMEdb+JpjBc6J5l9Qf6xOCTO?=
 =?us-ascii?Q?A2pMvDI8GDvxDGA8z7xKwKvdDEqBRgO39LCBnsCpoqxd8X3aGLlNX+X0Turv?=
 =?us-ascii?Q?PWbvRiPZveMYGTFTzJRBnKiU91HTuU5E1/hYz14BINovt3k9gq6mrNtXXyBi?=
 =?us-ascii?Q?SePz0UtAdg8M2e6ALi1fBdARdQYypWl4Ol6TrahH3VRXJTuBvW9UfJvFQV7M?=
 =?us-ascii?Q?z0SELR8JqOmBYkJOrnnsJgdKEQ8suhrAsggP15QHG2zULCSTj+c7ZpKbkbf1?=
 =?us-ascii?Q?XB8k3w/ZOD0IxmV2qnsaeC3WkuFLXaUL5uTn3z17dlDQPEqLPfYQUT3cRv7O?=
 =?us-ascii?Q?N0D35fYJApG9W0/JTMLL38c2JLOP3ByxB0x6D3B4Y6ZUEzigGcnbHaYVQU2x?=
 =?us-ascii?Q?mlyYzj1PKkuCFiqoSiUmCsFcLKVC985zztj+e4OZm05MSQOAh7Ms+YSw8Bz0?=
 =?us-ascii?Q?kIXnQ+unJJqLHX13TRByzdlsZFigZJ2s7A3S15IVWxBfjiW4z4WZ3T8zspU7?=
 =?us-ascii?Q?GSH5mjw1UtmpMPbnGdq+ymhGL36V6fDI5qk8U2pcQpDa7U5vr0stEGThy0S6?=
 =?us-ascii?Q?YPRH1AUPI7iC4jJAhjQJV6OrbQP+7aw6i5PpKdf3XwqwBfv1F+Xr0n3QdGfD?=
 =?us-ascii?Q?CHx3Qn0p0mTZIqApR01/oW99CwNk6ovLxMYUHXogGP4Ulk0JfF2RTMasIb7W?=
 =?us-ascii?Q?kLcaaxu/IL55BpMp6cwF3kKnuDJXq9xrH4Ae8u+koqGWGFRMltVkuSvHc07Z?=
 =?us-ascii?Q?n+AmSnQ0UokCdgYcVttN+O3nKhiq8A0x8/ToZUaebJ5WizEsouLAC4r+hGcu?=
 =?us-ascii?Q?IgyfzKm3R+N0Dy9GvZ3PpkMlM2VJSLcbIuTK8wf9hfoZ33PcKKTQWW0WS3Rm?=
 =?us-ascii?Q?reDua8lVgeVEk6CMfXo2JIxFsS6dRHZIKp4660s8UU5363GHkHVyhUHzlI+E?=
 =?us-ascii?Q?Kh4Cq5isvT9CjNtgqilwWTXzBS+3+gBsYK0xiOK0YSnL3eLg9GHTtKF0TUGH?=
 =?us-ascii?Q?4G8Q5OSbunzIcs8xtZw4fZt5lJ0HljhVvk9XJj7ghKzx3LYkjPgCpnxL5Ver?=
 =?us-ascii?Q?MnzNSQ2LLQGEOH5oA1jP6qqtzHibpK/EOx5RvtOw72fBOhw1Wxm80kL/knoT?=
 =?us-ascii?Q?svw3j+WHEhfrS/fuSDgaWU9gymsrVylgvQWoU4Vj0DB2Oxo08Nl2XLiiFzyL?=
 =?us-ascii?Q?lmC5m29g3Dzn1yPFszn0mXzoxMxvoPym4dYbk/l4a+ETCHfWPYNpppXCtBvH?=
 =?us-ascii?Q?B+5nHtLlmGYJDF2pb6th1wQVnUPMJXw1uZ/bXw5YGe5Q4eDG3baAzHG+MK+w?=
 =?us-ascii?Q?Bmqu4aSUInzXuXQHr8sA5fGzYgBv58UjQ4F0/ZFj0z2UyI2Q7vJef0c/5CZj?=
 =?us-ascii?Q?TdWHpxM8Qzj1Z3y6S3It4l6fYqc0q5QZ6OQzeyY2ENqacOSDViekEiofmN1I?=
 =?us-ascii?Q?SQcKkAW0RDLhDF/70hWIpKR5Cd62dVRegYkKElqFUknlBJHN9lbut81Os5LZ?=
 =?us-ascii?Q?75YF8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WjLs9kMFg4x4bo1ds6IUjQNyqHohqRMBbNFNboKKWwOLhjZCrbxItTLnpVogaFbLCtJrdbbLJX2xm+4uWAJRV8F27raAkwOmGQvOdbnTlSIZ4+UaikcK2uVhcDN45ld6aQHScU0oCAxA5ZdYe9hRRb5i+8iZ/KWbBwcaTEJh/mOIH8q2IBIK9vxK48C6Mxq3VevA45e4wXeLm3o8WGdDZ1nbD+ReOzUsfLTZxWUdNdnDWWWhBxILUxDipxrZ/6DkGXMyA74zAW+GOsmVUEkABoiKSbIaqErPHiqC/fbPro+G/tCoLvSXtAuuBnX1Mhr68Q7KCQx1jkwsv8zzWMclTqaLdSY6Ctf2pfByPgfKNZD8P2UOBnf2RL95XV3WHoCXkWIdZ78DOqXKwke7++KyJY8DJgewmYsIcSrjvEfSxw5CizVTEPOqnYO/e1l3VQZw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:26:20.0418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1282a08f-a8bc-4c22-d47c-08de6d1388d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237

IBS OP on future hardware can indicate data source from remote socket
as well. Advertise this capability to userspace so that userspace tools
can decode IBS data accordingly.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c      | 19 +++++++++++++++++++
 arch/x86/include/asm/amd/ibs.h |  3 ++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 0a8313ea6331..eeb607b84dda 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -730,6 +730,7 @@ PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "config1:0-10");
 PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
 PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_format, "config1:12");
 PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_cap, "1");
+PMU_EVENT_ATTR_STRING(rmtsocket, ibs_op_rmtsocket_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -749,6 +750,12 @@ ibs_op_strmst_is_visible(struct kobject *kobj, struct attribute *attr, int i)
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
@@ -802,6 +809,11 @@ static struct attribute *ibs_op_strmst_cap_attrs[] = {
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
@@ -849,6 +861,12 @@ static struct attribute_group group_ibs_op_strmst_cap = {
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
@@ -938,6 +956,7 @@ static const struct attribute_group *op_attr_update[] = {
 	&group_ibs_op_dtlb_pgsize_cap,
 	&group_ibs_op_strmst_cap,
 	&group_ibs_op_strmst_format,
+	&group_ibs_op_rmtsocket_cap,
 	NULL,
 };
 
diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
index 020916eb7b4e..4eac36c42db6 100644
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


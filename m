Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7C223309;
	Wed,  5 Feb 2025 06:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735593; cv=fail; b=cgxWd6BVZLUW2yKX4E6V9JevFh8kykaAw6foxNdMKX/BC/+M8P//vg19Y+0Fi+MB75//FLOFGwl3TKUmKBhk4aUqU/Qf0x0BkEnnpazSOYLgPPW9aKD3Sy66yf+ZrrKeI/FK11n2sDAm/IZWbeHylGevDBTq7ZILz5ebEoye5IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735593; c=relaxed/simple;
	bh=qJ6PhnnzUh1ytS27TjA1bmCBG45DN90b7gRg94u5OyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhT2tx65l6Cxdsw63xsiU5J63Hhn5BpYul8PnMSS5ak6Wo0zla5pjnM1h8IeT3awsuvRcsxsawHFEuuLM3m7MTUbsJZUyBmPxq2y5pSvM1cIN0QRF0USslHeQW9UKWdydNIg7PfzUYm1sBhtLSzS5Qux8BJaIpoMwlDLadreuXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uxwLswzl; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uxwLswzl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYUYY4Moz1WjEjIIb64Vcrl7Ijk7xSyRdjzoTUqS6CUnXwxywbXCLkMeqyW1YsWpUNFy5vnpbr18XQXMz9dPFFJ0EHFWWG6+v4Nv1GXO/oHnu87qUVUFqeyFfYUfUxvVvzxERpkHxYDOCMSkrP6Ecanp/APvN63fmx5dpc4oUggIQ7V6OSMecOPi+driEm3B5UDewAfLoYSywoYGGHD2AcM5yJunOVbeE84EkRALVyKwnJXfiaeP4Dy6KfS8k3a5gTzHu8ziWTw2CxKAZ+7ik2X+mHDGVsYoIKGEppQ77P6Wa2JtosqwWCD2SyKlqwSzEn5SHy+v7Q9buHvHn0t+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/5uAiudxFABk6KiijS4q6dXRq7jOnWjQFZ3mYlTDDE=;
 b=orphik0wLRJgh4U7zEiGQH0Z+w7CRDzcnSEzaZnn/0AaWkgZuXLVeLt9xu+M0OuTUlNKuCZGKT3iWyDYaun8nllVhAGYpw1Ha1Vu8IUtQwapi6FTs8Ajnmz6kq3O+EQiae0HFtewxqZfGJDAWREyi3rJ9XxlcsjZq4wftdSr+EBMaWqMN71IUKCHlKSrPWfT7iX8T6LkEazLJvoDLUyCqcFkX7AWRsi8Sr+SceOxjeCig01Zw7nzXG8hMKwxLdGv4PnmnJQU3werIcMmjPdQhJpipKYG49piraMNSzISfYBDLU+AEIgMXZTBrGYZkRbAv5qENYe7SMK6/Gah/0L4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/5uAiudxFABk6KiijS4q6dXRq7jOnWjQFZ3mYlTDDE=;
 b=uxwLswzlyXdK2koRg7p03R2Kxo1Vydam16wLj9iJO+AHV8vsOqEmFYCwFNBJrXqDmoNkSLnk4C1fez0SWZ7CMDqghgqYSXgU0EEQgBjC8WKtO2cTm2m0FzWHVfF/xqllpdZnsDL0xuZrZQxZfwUNyfUXarsY1+edu8ptVgz85y8=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 06:06:29 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::ac) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 06:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 06:06:28 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 00:06:23 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <mingo@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <jolsa@kernel.org>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 2/7] perf/amd/ibs: Update DTLB/PageSize decode logic
Date: Wed, 5 Feb 2025 06:05:42 +0000
Message-ID: <20250205060547.1337-3-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 4079422b-6f46-4aa6-bfd6-08dd45ab3b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wKUX6KXlLnJA7nArOuFuejHaEDjenUPYpHMXk/tcqdubxVgBUFN5p4wZAdRp?=
 =?us-ascii?Q?wH/xR63+9SdjBNKAS7D7cWKdQxViX/38sPcsCp14bCsHlidaln/RxCV2Vyr+?=
 =?us-ascii?Q?2DD4eyF8Xo+kAFkNheHMxeP5O9biq2nV1w8aob13AID8wVM8vg022pVDmYKa?=
 =?us-ascii?Q?KdmtuKNflahuT4pnhz8ieDHNXOmnUUG5otS88OGlheeWGnPdTaxD83A2HBiB?=
 =?us-ascii?Q?6qzZVb1tj2y5Pi98zA7Y9spHziTVEYBZ3m2S91+zh5L61+GQjrmKMba+yUbL?=
 =?us-ascii?Q?Tt4/C3E5uQcLimViAXy0GY60pzd+wz+kMt6/LSJUQyUA0ja7aQxOA6nqe4g0?=
 =?us-ascii?Q?6dKQrWRjEV9SY7IKH9RWeSFZBSwev7R3fi6YGIp1KHKZEWQTRbYcVjd9wL09?=
 =?us-ascii?Q?JK5zSeWSbI1vsPGcuS0dMHwHGl6+QBbcODGI0/lTmQH61SxSaJGFMVolyFAI?=
 =?us-ascii?Q?CkhcoBUPiLGVHz3N1T5AynzU1Bd+3k0LlT9BKCpueqKKh+t9rYJPw3/SOnbT?=
 =?us-ascii?Q?An/LuIz0ED3KR7ewStKEYfzlV+VSQPnP5PuGDtqqcOuUypEkAZMU91QxaF+S?=
 =?us-ascii?Q?WmdLPW+ncOKOgXEr/J4Dni9SYOVbcrgguArzfR1sQHBmnbiLiK9F3SIj24qw?=
 =?us-ascii?Q?ExAKokfJceAa596p9WH2Xq21lyyTJam08iJYOT4U1ex2I2rR2uRHyfNGNJFK?=
 =?us-ascii?Q?NhaSLg8W7IA0i1VI0TBMn0T9Mkmjbr8ELNmXegSqD+lH+0cz5hwhuLfntRm5?=
 =?us-ascii?Q?WzwrJv0x38Y2ER6HX/P8dXJ5EfUXBissK6tYfzrchWZZxEe+BPVbHY27OCLM?=
 =?us-ascii?Q?ZNv+Ja1Dotztczd6y1VIb61xiSLv/X+wkp/r1mvsW62spxB6pA5y5H47yOq5?=
 =?us-ascii?Q?QC9Rj+CdtbOwf8glwrmoc3I4SJQxJxD9oLkDW7qD/YRWdWir4ABVsmmxaG67?=
 =?us-ascii?Q?/u80G6NZFneD0kSwg8smw02Sg70rTxkAXUF5+jcuCsAfEXRC68xLPuyoO75p?=
 =?us-ascii?Q?hpJW2aEOiB5hJvmK+vDoSgQPsEqcJSaCHQ2Hq+vhZcC+DfktT/1/c4qOQdYf?=
 =?us-ascii?Q?rYC6aE6VKv4GW3HWrj010qZbP2PDCYzwoKDSmZjzrTlwZlzrYhmqLh0wnmbO?=
 =?us-ascii?Q?guGFWEGnrwr+lyrsgGeLWca1a7xqag3Q1xT7RcLhY0B/+FqDvbx2FtS/WN+9?=
 =?us-ascii?Q?76D1R1eHjxbDf6GZhmPssFuF7mwOC7+v8j2wDHqiefd5lEElMn7i2jlhfQrN?=
 =?us-ascii?Q?HhCodK5x4V9YoHjbyJuOV+4KCKy++DTFaSXt9blLeCafw1KJbYUnaM/dtzop?=
 =?us-ascii?Q?RIneyJHtr+rjS8wj7Sb16LyRKkqOZZ+VoLQV7lnKxW5daVsynBHmdo09Gyj8?=
 =?us-ascii?Q?gOPRLen7MxbYUOuVod9k32EUUrkspJ1jkPJyC1U2LPEDaDggwmgS17inWJmE?=
 =?us-ascii?Q?W2K6XPeuktpPp8gVUIxUAUx12IzrBWWVJ54YVxUGWgM4iy0AuJPtj/Iq9Kl5?=
 =?us-ascii?Q?LUv3lB5EwwxE5Nk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 06:06:28.6676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4079422b-6f46-4aa6-bfd6-08dd45ab3b02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707

IBS Op PMU on Zen5 reports DTLB and page size information differently
compared to prior generation. The change is enumerated by
CPUID_Fn8000001B_EAX[19].

  IBS_OP_DATA3     Zen3/4                 Zen5
  ----------------------------------------------------------------
  19               IbsDcL2TlbHit1G        Reserved
  ----------------------------------------------------------------
   6               IbsDcL2tlbHit2M        Reserved
  ----------------------------------------------------------------
   5               IbsDcL1TlbHit1G        PageSize:
   4               IbsDcL1TlbHit2M          0 - 4K
                                            1 - 2M
                                            2 - 1G
                                            3 - Reserved
                                          Valid only if
                                            IbsDcPhyAddrValid = 1
  ----------------------------------------------------------------
   3               IbsDcL2TlbMiss         IbsDcL2TlbMiss
                                          Valid only if
                                            IbsDcPhyAddrValid = 1
  ----------------------------------------------------------------
   2               IbsDcL1tlbMiss         IbsDcL1tlbMiss
                                          Valid only if
                                            IbsDcPhyAddrValid = 1
  ----------------------------------------------------------------

o Currently, only bit 2 and 3 are interpreted by IBS NMI handler for
  PERF_SAMPLE_DATA_SRC. Add dependency on IbsDcPhyAddrValid for those
  bits.

o Introduce new IBS Op PMU capability and expose it to userspace via
  PMU's sysfs directory.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c         | 23 +++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 85b29b3f305b..7b52b8e3a185 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -629,6 +629,7 @@ PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
+PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -642,6 +643,12 @@ ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return ibs_caps & IBS_CAPS_OPLDLAT ? attr->mode : 0;
 }
 
+static umode_t
+ibs_op_dtlb_pgsize_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_OPDTLBPGSIZE ? attr->mode : 0;
+}
+
 static struct attribute *fetch_attrs[] = {
 	&format_attr_rand_en.attr,
 	&format_attr_swfilt.attr,
@@ -663,6 +670,11 @@ static struct attribute *ibs_op_ldlat_cap_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ibs_op_dtlb_pgsize_cap_attrs[] = {
+	&ibs_op_dtlb_pgsize_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_fetch_formats = {
 	.name = "format",
 	.attrs = fetch_attrs,
@@ -686,6 +698,12 @@ static struct attribute_group group_ibs_op_ldlat_cap = {
 	.is_visible = ibs_op_ldlat_is_visible,
 };
 
+static struct attribute_group group_ibs_op_dtlb_pgsize_cap = {
+	.name = "caps",
+	.attrs = ibs_op_dtlb_pgsize_cap_attrs,
+	.is_visible = ibs_op_dtlb_pgsize_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_fetch_formats,
 	&empty_caps_group,
@@ -759,6 +777,7 @@ static const struct attribute_group *op_attr_update[] = {
 	&group_zen4_ibs_extensions,
 	&group_ibs_op_ldlat_cap,
 	&group_ibs_op_ldlat_format,
+	&group_ibs_op_dtlb_pgsize_cap,
 	NULL,
 };
 
@@ -1007,6 +1026,10 @@ static void perf_ibs_get_tlb_lvl(union ibs_op_data3 *op_data3,
 	if (!op_data3->dc_lin_addr_valid)
 		return;
 
+	if ((ibs_caps & IBS_CAPS_OPDTLBPGSIZE) &&
+	    !op_data3->dc_phy_addr_valid)
+		return;
+
 	if (!op_data3->dc_l1tlb_miss) {
 		data_src->mem_dtlb = PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT;
 		return;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a60efe47498d..43b17b7b6ac0 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -503,6 +503,7 @@ struct pebs_cntr_header {
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
 #define IBS_CAPS_OPLDLAT		(1U<<12)
+#define IBS_CAPS_OPDTLBPGSIZE		(1U<<19)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
 					 | IBS_CAPS_FETCHSAM	\
-- 
2.43.0


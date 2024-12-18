Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C21B0430;
	Wed, 18 Dec 2024 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524281; cv=fail; b=TaRwPaWMB4WM6oevFK/kzDPaBMV6b/Hlnjhr5xKIwAL0YqZQGv531COCSCJFHb/pZd3taig6dDTLygef0g2WLc4oZYTgva4ubseaEFg0zxm89NoKrjW3dsSZ0WsO/Lni3/l47VHHlOzIoyJqCDIV9pRIRfZhG0XXuK5nmHrxpYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524281; c=relaxed/simple;
	bh=5H4aaK7MMeHxJWvrF8gGZe5U9m2EzxnpbACQVf+qZGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjuTuPlbwjzqgy6AVQVS6KyikdsSvOaGSZCdhfG0uYGlGPB0u2zStVb9Fr/9vdIkwg9oyxgGJJFrBvjhfhkC3I/NOdeZSSmNELUmS/dfAsHxKGZY/W0AqMEQCkG8Ut3G9kvWMdr44DZ+FMaaXQEKGakPjYPjP7e1/fAJaVHdRNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mXn1A857; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mXn1A857"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1NKhzV2wESfWKSu+27MVuEJ7C4lHkWh0efCwY8P69G1pmqKNweg/zOnQQ2sbZIivkBCmRx1lp3DhR2SCPYroumbL8aRoKSUcJKXVCIHxzctCTh+INOPSC43ooCdRrKyeFCIdSBzLe9GEKDDgoBmQt7n5SFQ94L+m7renRJpYyckihNpNMtRn/MzWhbvUqRscnRvuHJcdLZFzED/ccgQ1BP8XwfrVMzm2y9CAjGLUDF5SJArX0ZyS2DCcc5NO2ZoUVJxAoSfFcRGxn+to5yqe/m31y4h2GliFj+fqY55u46A3mupFgwVDDRMbxySIQUJ+VVlGPc7wW2NhRIoYPXcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yit8ExoDssyKLvTbzh30wIKQdHDm6Y4bagXAqxyTgcQ=;
 b=kEb8XkjTxTeBxVGXhNsAF8DbieYQCWQIyALy9iqGa9G6GfRvdcwiiTgSbVnn6Ub3EDJnnUkdHrTDuYXKuRVvZ2cZ0t6yAcrIe0A1I9mrgp1O8cf6rG+fylom65tjO89aVePhAErI96YaDB/i7dc5KXboQXNObF5mnICFBAevZIkeWn8HaotAWPMCwVBn38/nA2WKa6865psE628pZBZzjRui+8zRjuUnju7LPGZlRsZDSt4AwWm3vVUBMd3qWb7qtHsNvAhOVfylR1Uy1lD/PpT3yTHEWLK013Zx4mBR2O9iYMR5mftLzQ9NvfWkWN3lnLHSxpiRmEuYczLj616AcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yit8ExoDssyKLvTbzh30wIKQdHDm6Y4bagXAqxyTgcQ=;
 b=mXn1A857Kshyrr3PgPKg8ELdDbKG1RywXtcIrRWVp05TcFebbD67JU6LKqeVmU6Bnbs22dvEacyAS+bzgKuK8JE3MOOV3YorAdza60baqIS+ksivVLIWIdUgQRpZV+csgenzv1WmreLExBO4UtB+5okjvbvVcxbqtJeUMnxrLfk=
Received: from PH7PR13CA0018.namprd13.prod.outlook.com (2603:10b6:510:174::22)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 12:17:56 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::b1) by PH7PR13CA0018.outlook.office365.com
 (2603:10b6:510:174::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.12 via Frontend Transport; Wed,
 18 Dec 2024 12:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 12:17:55 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 06:17:51 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <kan.liang@linux.intel.com>,
	<bp@alien8.de>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 2/6] perf/amd/ibs: Update DTLB/PageSize decode logic
Date: Wed, 18 Dec 2024 12:14:33 +0000
Message-ID: <20241218121437.1717-3-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 01284a09-adbd-4ccc-cf84-08dd1f5e010b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cZnUS3TB7iWdlFi76DVIV+Z7poAC04qU/vM7eFTP/b08+L4dRZ2/kGmVulMN?=
 =?us-ascii?Q?SloBruurz5+D49Q9U9v/UxcWikCWWZ1cX+WPPudywnB8G+pWThINcQ+KCodj?=
 =?us-ascii?Q?6wY1K8R2DPYd9TRGDMbJtU9BmsaxMq3pqNHqXhuDDnY4YGQ/DwJh/HZsUt+J?=
 =?us-ascii?Q?YHayOfy8VR9fByMhPSDdzv7VCOE/8OYG++vR4fCQZUAs+Z5whyqiWSdIVT5j?=
 =?us-ascii?Q?oWptyYHjshP5BWWXtwydtjYR3t2RrsAS32jgG7jT+DpHfAmiDoSXZNm66i7m?=
 =?us-ascii?Q?1EFPbhgPAZmlhmes1nhC7dsP+3imIBKi+9ree1P6gE4n/E8bCyRXBw/6uPWN?=
 =?us-ascii?Q?3f0OGG72SYfwIqMeyL/IKAqbsXSC//qjc3kzLD2X4znde0iY68ZEvyog9mnh?=
 =?us-ascii?Q?jBgJrNvgYO/qwCu6Oj773yNcRWW9L9Wdso3+FRPs9PbRgGvO+B9qsmvaDj+N?=
 =?us-ascii?Q?ukPLa5cAcaZVJW/NDTGHyifCT60U04q5/dksI4EoxycLSVTtdb/ttMdnSmf2?=
 =?us-ascii?Q?j1uXKS+WJhCvH/TBJ2NwM9D/4/aSIkNJI/E++1hMYWSb3AFnzXG8hqhTyBnn?=
 =?us-ascii?Q?qZV6HqKaQJMH4CjdZyxW7AvxdL3t83+10+7cXN1S7jG68OyE20EhHeUgu3ki?=
 =?us-ascii?Q?EqAbX6nt0xSOfoPj07lu0KN7LPePJyhxXgHIESTlFOmMtN4omFxGfJmYjfcE?=
 =?us-ascii?Q?2MPcY73M6HprwWqBehz9xB8taagwfWFOoNcB/PWdmnvM7ozUTDtS4uTwWS0j?=
 =?us-ascii?Q?ARbu7r+2S8Yfsdku+MwkiM+wxO7nIS/968SFGYrl7Xr0lhyoxA3TpJeql8cT?=
 =?us-ascii?Q?+cntuDS867cJ0sszVwrWzjL+Azsh2nZzf1fQ3iCFbDxeolZ09N4r3XApIf0I?=
 =?us-ascii?Q?P880l8TZLDxUEzdU9P4v1TAoD3qz77bQfyETrt54qS1NJuM2+NTW11gKGWgG?=
 =?us-ascii?Q?d8O94lEaXgqzXI8CvUt2lsNx6WrwezxaOhoRJdlE9oUmw7Wb9V9gM9/+sjfx?=
 =?us-ascii?Q?nAcxox2DpSmjZOoVXy/Dg02DR8WMYKcGTWnsWJQCDHn2v6UvYuwwUpasgHIY?=
 =?us-ascii?Q?PMMDdivBQytclVYSwuZjgCLMpcJUIa8G0X3JlXZvnln86SYMJip1+KhZyYr5?=
 =?us-ascii?Q?ayso3wfNMt+RfTg1c9mEySFNoSgsCCuUF9nvrHUSoke2r9XbbRM/MTMy4gtW?=
 =?us-ascii?Q?hnMuwz5bR3WG3t8bptFMJuJ4xe7zzYRxxfopWNpyfgvN8iWUrf42erKD+Mr4?=
 =?us-ascii?Q?18BOi4uZC6qO928qj5025wAGBqJio6gDlQjRA0+OlNOmpjSU85h6eyoUOrsE?=
 =?us-ascii?Q?KwkXgWv9HS0mW5s0NVFo1eZXzn/hVFNSfUkjyT/kOv5ZF9Yflfa49i2y1wv9?=
 =?us-ascii?Q?49d5iSvG2036t2laMnCErIb7wHGPKVNxiUCWgrz+UYAyvrzfP4DutVQq/82U?=
 =?us-ascii?Q?kNnkx+qx7wXJFodIT/8dpXtkiDYrZBPk6a/TLdqqKBfRNUO1hTG+sQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 12:17:55.9697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01284a09-adbd-4ccc-cf84-08dd1f5e010b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053

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
index 62fdb9b8d34f..231998f01270 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -635,6 +635,7 @@ PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
+PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -648,6 +649,12 @@ ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
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
@@ -669,6 +676,11 @@ static struct attribute *ibs_op_ldlat_cap_attrs[] = {
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
@@ -692,6 +704,12 @@ static struct attribute_group group_ibs_op_ldlat_cap = {
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
@@ -765,6 +783,7 @@ static const struct attribute_group *op_attr_update[] = {
 	&group_zen4_ibs_extensions,
 	&group_ibs_op_ldlat_cap,
 	&group_ibs_op_ldlat_format,
+	&group_ibs_op_dtlb_pgsize_cap,
 	NULL,
 };
 
@@ -1015,6 +1034,10 @@ static void perf_ibs_get_tlb_lvl(union ibs_op_data3 *op_data3,
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
index b6af58e743b4..701a59a90d30 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -484,6 +484,7 @@ struct pebs_xmm {
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
 #define IBS_CAPS_OPLDLAT		(1U<<12)
+#define IBS_CAPS_OPDTLBPGSIZE		(1U<<19)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
 					 | IBS_CAPS_FETCHSAM	\
-- 
2.43.0


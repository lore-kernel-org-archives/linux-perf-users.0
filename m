Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422B2BE7D1;
	Mon, 16 Feb 2026 04:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215981; cv=fail; b=meyWIGfh2qTklON/baTDOTl2NEmGdJ+7AfIST+w3GxLohA8MXVODVSSgxnbObV8NgmtTysHHsR3YCPS2EN51HqpN93iXfG/VziNPZcwJiTW6NIhnkhoAQRJYxGTxEzmRl/81VOBwS2CEaXbN3RiVksOjVVQILEa7M3f5MU2HP5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215981; c=relaxed/simple;
	bh=xONCoYlg7G5Ey29orMz5HhaPhrnUwxdOEaDzHXtc1uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYlPsI2nUAD53UDogK6xJer/pY6dBaI/7cpvNWRXXnaHHLXaf5/Jr+iLPBOiWl1QDJg7zUv3OEEDXASFaIlFwiytTYTA9mDySp/XsyQohY8Qo2zz56cE6tQyZTsR6RbbbGAQnD/KOLHSA1qsEW0oidvZ2WWrpEpjLkBaqR02oVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D+hDQngV; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D+hDQngV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a990Lma7Z2lGoTlnV2qzcsvcuVEkxu95pOelr2v1bjV6t1TvCPcttNOzp7Eu4LYPat2hJBagWaS/fx9AUtehPPsPSIe03FvimpRWA+kb4JRn58j8Rs+5eBx0H9XkmKip0gDPyWuHHSpmy7NA/v8eU7wr41ObLtpv2YLLImACPCMkCBHxEQDKqXIRNFzhOhyhrDVQDESvQ6m+8Rv+u9RhwtmryLC2xIVvuMtNu/IrpzycWep6Ilj2CjLXFTnIWASR0kMBusmWhlRleKiJ4vjDt+RprX8jzWEgy5zSH3lt6nOzF4bpQR+E3tCy+kN7zsYGwCNsSVIxGbe6uTkaEWkodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+8UwMvumN6AtRcr9jfUrg1S9tylRu1hk3jKXqEe+5A=;
 b=B3cCG8tlv9NTKY68T+WCEp8MJ/PJtgXvgAA+VTZtx2mdQx0ZeJVAJbNXtmiRNMt68oXcerJjFkvJdxfPO+Po2cWsgWOXpMlZc+YLg2v4flZWp3VTaEakn6ZgIIJDFDg3qMRg0LJakUPWe0kog1WTYgWJ+SxuIqUPu4Ejq0+TNOyWR8dJTEylsZKiOfKLbYTa6CTv/YR8Efr8qMCyEX7qLoNgymazx0APkitV4UCzxrfYpO3YByV2hjgWXLqN/w0fog+7PeEge6svU43UtKIIfGnq3kiq8xNXr3oIWdHjlryfoAm94SIk/uCGMlFp9I+405RXyXfXGl2bYYwbanQ0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+8UwMvumN6AtRcr9jfUrg1S9tylRu1hk3jKXqEe+5A=;
 b=D+hDQngVBSNjXiyDPjEewKUBwLk9VKyJAi22AE6RcsCicVSlz5772aQ48YiwJrfNPqcsIDztyrBOFUeTCK/sCAWowjOI+Qi/J76qOPJBv0UqlxY+hNC6H5waueCo1RSMoY6lpRvPmlnjxEfdh7leTb/xMyTdbyD6dHUYrXy20/I=
Received: from PH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::33)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:26:16 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::6e) by PH0P220CA0018.outlook.office365.com
 (2603:10b6:510:d3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:26:15 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:26:11 -0600
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
Subject: [PATCH v2 6/7] perf/amd/ibs: Enable streaming store filter
Date: Mon, 16 Feb 2026 04:25:29 +0000
Message-ID: <20260216042530.1546-7-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: d9869f6f-e2cc-4df6-036e-08de6d138629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TBVmL4tuJgfrU1dRht88V9Vti1zuu7hxIxCZkjB9cc2iegZa1QHgvk8djETl?=
 =?us-ascii?Q?46iTLBhy55pbJeU5nbCY3cDeYbpbrp12GOYzQS7EuB1HSgF94QWJ7FV/xYYd?=
 =?us-ascii?Q?WSkIgm+gnhq3F3UxQDDn6qVHorIrB5PBryKZirNhxDGCqIUbZbDr4DxOkl+w?=
 =?us-ascii?Q?3ssnpLGi7/FKLILA0vmE5sNsbxB+jn20CAmb5PBr4BEeq8l24/c5lV4AbMf+?=
 =?us-ascii?Q?QzlLgtaZtLtMzny+0IHdHdJksW6V8asVW3wFCURaRRSYdFz/aTgxsJeSzKbq?=
 =?us-ascii?Q?f2J+kusa/2gcWCu38h/y2R2+XjNQJ96RgCx2CQye//VFi5sTw/g9QYxsKnDq?=
 =?us-ascii?Q?DKPu+/ClDyTV8/nmY+9wm6+euE/ZeKIBEwcqgvIMNFK4zmsRfnWWMNqIn66o?=
 =?us-ascii?Q?SgQEZkxOdFvzBCark8Y1dviVFHyPS0/Qds34bRkup6nQ1pe76dLV8SXT78Bd?=
 =?us-ascii?Q?Rpy5DYQH7m9J3oRhY6fofc+hpknR5BKn1b8o1vXJ4OnkOoaVrY9mKy7vgTfg?=
 =?us-ascii?Q?GLf5RnZVLFZWZZjCclmfDSvMzisfvZider8IkO02k39I10DKSx3RQwT6INn0?=
 =?us-ascii?Q?aIxIczZieyIzRrn9kTl+BdjoiGaeJJFTnOUSwlTRXaohr6zXGV6LNr4b0yWh?=
 =?us-ascii?Q?eIt8+0IJSqLTVX/TkDkYX1gBzZwVO4Yb9ftsEOPMFhQs5kNy9VKWfSelEJKW?=
 =?us-ascii?Q?rbUPFWKuYKbHaULgMt6S/KlPTGRHGch096Ff/YTYE7cQwRYBu/wTKa9Gx9r+?=
 =?us-ascii?Q?lWR7zCR1TiWf3gVZaWsV6PndgNf02SsODvzWnQiG5W+NI21RHABkYgYTyyN/?=
 =?us-ascii?Q?4/KAsSSHUN2fS1IXNeJ8DjtkFOh28BoiCPBu1/522WDyiX0BSoda11z1hODJ?=
 =?us-ascii?Q?uLd9YXGlmmf2LOUMkgs7Q41SUzsj8CXBb/gnpik6Y24f6BHXDbZwhy3Zzo3n?=
 =?us-ascii?Q?3cJWVuxGo4Rv+5YQazwVlLtAz093gjgg9yie43mTFe7qn+9Wzr+t5PbLJYre?=
 =?us-ascii?Q?J8cVvq0KZxj+uAUpOS0p4+EsQ6GxSZ+3XevC+AuIq0+BPULijY0oXb2HFubH?=
 =?us-ascii?Q?whu5FozoaL0iDjTnoZV0cxvQqyfhAqa9LobYYe0pW4cqwF95A00jxX/TmTMa?=
 =?us-ascii?Q?Reh4NN/wOkH5n/otnH7A4tWAzTtPgstHC4bHWqGnWp/n6XEfyY9iDzYDamds?=
 =?us-ascii?Q?9qYwYkXQ1IjzQvsR+RCo+SxdLLQTtyrSGRIoNUhfC60IqWJ5IZxKtkT+mhd4?=
 =?us-ascii?Q?sNxzcwPuzLCl0AJPWrbvF048d0Qp0/UptK66ZSqVFbHve5B5Nx0mohctYhhx?=
 =?us-ascii?Q?hfDXvgwCZOP3aaiUDWiw50pN0+mFz7u5Gm5LRZw6dcxiS9jQNao8YV/cVcqX?=
 =?us-ascii?Q?HICwmcf1/LfxtRhFqzBmxrFwffaLnSMpm7xC/oJbN9mh+n/a0EG4Alu7TdSC?=
 =?us-ascii?Q?AQIh4lCuuOqRlMZr4kI7mW6yXqWKsn0fHWVHYU1isztM7s+6tSeegMnwf608?=
 =?us-ascii?Q?85bV3K8hNp03L66Rx8IFqI5qNmg8K7dijj2uEdtoFPM9/KGHqW1paPQqdMWG?=
 =?us-ascii?Q?+oR4A2pkKjfJpm9ww3iawIkDiAM4jH0wR7rXqHU6GPjgM7V2AP4YcAswVoRF?=
 =?us-ascii?Q?tAhzCE7+DREG6NtWotkRy+kHCZM3MUt3dZD36JN6IZPeuSIRC5aTNDKvCDoU?=
 =?us-ascii?Q?LA5IYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RnqoTA0CrYJbPYITJtEbSLnki7cn0IVCpHDDosBg510z3sH1SLaoLBxXkCXjzEexoVRl4z3/iMWnnMX9EO3fssQ4dEH5UnxRTXvvyL385z4ACH/FCBqIoby+3jWuUmDLQzmHC8sj3Xh7fE2zfrM86g3OVw3Rh9MD3doDpn3zAcHFOQP2lSnQcOSOt/QsznfkjLvi9In66laWbQfOnL4bk24ATC+Z1rhi/ZdPlXvCAuw3Iy++xCBmTqvOcXgsQjm0h01049OUNOVvcyiyDrPD0fE4aL2DB+NQG1qcnzr2+aQxhwQxjwJbvA+gX9VFsnRyAf4WgSdQwZkNtzJQlqLuNa59ZUV32YDcnl09EXifPV6dCqDHXz7SfTrzVIxBArqIMftSc6sW+6M1ZSma4J1QzI04vdp6hcDxgZhjYa3uMluQxtveMIDTdtVXUa6TcwGM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:26:15.5175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9869f6f-e2cc-4df6-036e-08de6d138629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032

IBS OP on future hardware supports recording samples only for instructions
that does streaming store. Like the existing IBS filters, samples pointing
to instruction which does not cause streaming store are discarded and IBS
restarts internally.

Example:

  $ perf record -e ibs_op/strmst=1/ -- <workload>

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c      | 51 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/amd/ibs.h |  3 +-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 13ecc8d92b23..0a8313ea6331 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -34,6 +34,8 @@ static u32 ibs_caps;
 
 /* attr.config1 */
 #define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
+#define IBS_OP_CONFIG1_STRMST_MASK		    (1ULL << 12)
+#define IBS_OP_CONFIG1_STRMST_SHIFT			    (12)
 
 #define IBS_FETCH_CONFIG1_FETCHLAT_MASK		(0x7FFULL <<  0)
 
@@ -292,6 +294,14 @@ static bool perf_ibs_fetch_lat_event(struct perf_ibs *perf_ibs,
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
@@ -419,6 +429,15 @@ static int perf_ibs_init(struct perf_event *event)
 		hwc->extra_reg.config |= fetchlat << IBS_FETCH_2_FETCHLAT_FILTER_SHIFT;
 	}
 
+	if (perf_ibs_strmst_event(perf_ibs, event)) {
+		u64 strmst = event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK;
+
+		strmst >>= IBS_OP_CONFIG1_STRMST_SHIFT;
+
+		hwc->extra_reg.reg = perf_ibs->msr2;
+		hwc->extra_reg.config |= strmst << IBS_OP_2_STRM_ST_FILTER_SHIFT;
+	}
+
 	/*
 	 * If we modify hwc->sample_period, we also need to update
 	 * hwc->last_period and hwc->period_left.
@@ -709,6 +728,8 @@ PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
 PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
 PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "config1:0-10");
 PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
+PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_format, "config1:12");
+PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_cap, "1");
 
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
@@ -722,6 +743,12 @@ ibs_fetch_lat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
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
@@ -770,6 +797,11 @@ static struct attribute *ibs_op_dtlb_pgsize_cap_attrs[] = {
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
@@ -811,6 +843,12 @@ static struct attribute_group group_ibs_op_dtlb_pgsize_cap = {
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
@@ -856,6 +894,11 @@ static struct attribute *ibs_op_ldlat_format_attrs[] = {
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
@@ -880,6 +923,12 @@ static struct attribute_group group_ibs_op_ldlat_format = {
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
@@ -887,6 +936,8 @@ static const struct attribute_group *op_attr_update[] = {
 	&group_ibs_op_ldlat_cap,
 	&group_ibs_op_ldlat_format,
 	&group_ibs_op_dtlb_pgsize_cap,
+	&group_ibs_op_strmst_cap,
+	&group_ibs_op_strmst_format,
 	NULL,
 };
 
diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
index fcc8a5abe54e..020916eb7b4e 100644
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


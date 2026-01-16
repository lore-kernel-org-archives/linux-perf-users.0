Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10518B0A;
	Fri, 16 Jan 2026 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534555; cv=fail; b=iFc4d9VZw+/nRGsSSjwtXmzLb31u6AgV/ytxVE5tQC3Gz33lftsqjwIPHaVzygcDTgEu7Cjkancj9bPeZu/HPr6zrg2no677GnLNBRr3o0KgU8zBeq3tVHAoRPrqngBHIOmikpPp+a3uCPUvbKhWVAnqPetdqJZWCQYMMGix27A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534555; c=relaxed/simple;
	bh=8n/0E3hLRcsRlVCg/RwY8m+4Qt4uX6oQVpv6DPJq9jI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rs8fWu/Mk0qZDDRhBBdCtd9bLf5sG1wM6LhiBJZawFrbAwCdEnc6f+LJIrYY9nXhdzJVUGTKHZVBsHZRKyFCKCOj0hwWsmbhDZBs7Am/VM2kAq/W2PVDL6tWfmGDBdLrbQ0ukEZrikdUEdLwLW5VxU8e9h8vivSVnGz8BHy6Jgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jqF/tV5K; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jqF/tV5K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K31ysM74CdmICzbCg/EEprRDyXC+utl418dX0s1rVS4oCcPOnN3afZQNH2weXQcFds5QqvJdV0YdcOQfAqXUWVeH4a4kcpMTlPBUZ4vwcseeokN5pXGaflJY/ke9sh1z7BQBwylzPLsqIjzmuiOGH5x+NtPP2p0GBrzC0pQP7xyksaumjowyAQW14nb3lvfHrWqKk5bQeXmyP5x23j4MNc9rf/U+RJ1TZxx+ry+1jw3J0+zbmQMNZVos6zETwipZqf7R09oXY1DhEaknj+If3dlFVXmBsU+ZdkZikFfKYzkSSYAvlqxTHPDNpNu6ac90s0sk2BHfnja0sZ/pQzPHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyAY5MKJ1PWPDzdiLIM329q3h8kSDfghS+vtfkTUxeE=;
 b=ft5XWlfuj8oTSXUtnhRshVQOa3dGGqEwJdhMa3+HgX4qhkaPND28990f8Ti/i2oT52/RnaHUewErph5pps10POhDP+pFrW6CJAYuPrXtE0jdEniXxFEqGARQS/pg0lsHsnaePErP6YW66mQtVT037hNTfMj2/B18xcrpyWutEgE+Ck7oWba8xOs2XcJOvISklEuhzNflQBKEb4i8McdUc8V73fwsrL+rWqByAfV88Tn5Wsvr6zN1oYFMjgr76e2Y7QYYvP5WyqlUjxWnv8VSLvFpnQ29/urA1McrBXqzG2xATomSZPjxB+JpxLk2uEIP7BTba679G5gG2aynY2SOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyAY5MKJ1PWPDzdiLIM329q3h8kSDfghS+vtfkTUxeE=;
 b=jqF/tV5KmPBHnddznnsxljocKClGcX0NS4Ra6se++/SvtVYNyM3BYoRBSkiseGfirf9snjEwALg4Wo6qjQucfvK5rRF5CZdxKeMFe7udVHd6F1VXNi368RnFYEuhg2JArSxckDRBMsRBBCGzEWaoGZ/fevMHWThuESPQCReEkJA=
Received: from BN9PR03CA0687.namprd03.prod.outlook.com (2603:10b6:408:10e::32)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 03:35:48 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::bc) by BN9PR03CA0687.outlook.office365.com
 (2603:10b6:408:10e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 03:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:35:48 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:35:43 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 06/11] perf/amd/ibs: Add new MSRs and CPUID bits definitions
Date: Fri, 16 Jan 2026 03:34:45 +0000
Message-ID: <20260116033450.965-7-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a9f607-2aac-4b29-ed49-08de54b0574b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0DKtACxu4j2nK/TvPyirQwrFmrfyOSmb9/oEoZVh1jC5hpSuY5OY99M3MEE6?=
 =?us-ascii?Q?TI97E1fAByQLagYH7xjNiSrUf+q3qE99OAZt/fo6ZQxdncoqEGurEoxEkzT7?=
 =?us-ascii?Q?jsnrKEIqzKlZVSSHldpS7nENwtDFOwjUf6+5AswOAO7WVGEcACNzac5MiIIX?=
 =?us-ascii?Q?7ZxWKJD1Oza6/3r+gBU1kCqecDSrsrS3cu+Cg835sfWzbiDgtHgzKM/nEz04?=
 =?us-ascii?Q?PNK7LzWWMy8wvCqer0gMNNo1t/893lV6OkLpXa3tThPPaqWhpB8Fqq7COm+i?=
 =?us-ascii?Q?c1Ut79UvfFpvkx84kLHnfspYNAuSw6YAX7U3Drywd5DHdRl3vFR74D0A9j9o?=
 =?us-ascii?Q?geVBXcJNq2GrKwcsdI+rDPckYhrq0m569cVnTsf95GlNPZNb3s3Fz2IdII9m?=
 =?us-ascii?Q?9siYwN7T2QIMdGiA7IFtK5JRo8LmBxDyPKfdz/tRslPDQxTAWljBFgSy/3Zt?=
 =?us-ascii?Q?ha+AoE3zU01sI/TxRc3Yp/Swm9RDobDhxiT19zAqGGSkkHWTb00DAKl1PlTN?=
 =?us-ascii?Q?c2JkX/u/DhgDChDMaEhrYPSDF+mqalfOICj7NFnWEBuRV13YZIFJnr+gosdo?=
 =?us-ascii?Q?8+voT2vET5QLAI5/VLpfns3ebRH7bQAAippgrxcGcgS4C94nq2cb3sNJYYl3?=
 =?us-ascii?Q?tob3KPdbKVeAVNVmgiFRmd8179HsSUUO4ps6LewB8KfeNelM5wXcAdfAj4qF?=
 =?us-ascii?Q?NZiTMVFR0j6C9VDiwcnnXFyBVoWNYqt51n7uk2wJmDw/qypQDPFz+yrTil7J?=
 =?us-ascii?Q?WwKRCbquv5FfuqNXNidxIqzxy1UocKegnQS4QTPxq0w2d6HGm0HHGPhLMwtF?=
 =?us-ascii?Q?3phModNobxjYHEwYJIjHDb50XBAjLrq6lJvIm8jLCkTwipTGaW3Nhha724Nw?=
 =?us-ascii?Q?xODqoJTc57Cpz1dBJ0DrTZ1lyT8VeEy5wZob5I0xUXgnveGCdIa1kyq50etv?=
 =?us-ascii?Q?b0SdbuzUdgO+VQm6w+t6mSWCeZa1U5uoZskjnTEEcllkp35s4uNfDx78saPb?=
 =?us-ascii?Q?WWE8co/LSw/nGMBywfaWYtxzekcP73rijQnIUZQSB58zB10p34HKZLPhhgpy?=
 =?us-ascii?Q?1fLsHz/wCVkqexDu55mfDL+0nY5IQxfMqirok357uJ9ztoVkwdSbWs6xX/w2?=
 =?us-ascii?Q?fgu735cvJn+NBlP/2othDTyTsPlduTqo5dCo+vtVempfwYaPn20NgzYuP7BI?=
 =?us-ascii?Q?E4MsRpEWZCntMPR1tSjGyaRIju6AXqnA3GtwRU2fS8x40prpd0cXp3ftYxRR?=
 =?us-ascii?Q?jECRfwq4JZi8WPoWryXrj5xY/T/sKJfiN8/ob6sYXTTot3tvLuF/3rOaoc+K?=
 =?us-ascii?Q?8kCAmjXxQzLbFpgZ2Kski5B58ht9DD887vZmIXFbFOOi1JwL2KnTqfkiL+VR?=
 =?us-ascii?Q?XI4rQW0BgX15kYS4c0+WBBkO9ttBxZ+IdQCN7iLwNe2TYxkNXwV82Zpaz4Ul?=
 =?us-ascii?Q?/0+YYHB2hPw/jFjuwe5hL2S5zYhCf7Ys9CvN0pYk8wRRgu0Be2lwr8iSXDdm?=
 =?us-ascii?Q?3NDUS0eM3c3i245pImE/76HjmctTQAN3fdXFuNacAu4FkazvzC30IFavUytM?=
 =?us-ascii?Q?RRx8lvScd5WwSA7f+GLbPiVVa8L/8x93u9SKkfIZyXcwPMEj+SMy1ZH00duW?=
 =?us-ascii?Q?2JjevZRk2flwg+n4fKiFn1UaasvLVkpuqTO+sE6Q8duNEW7v1U0tlsPLiZxC?=
 =?us-ascii?Q?acxOIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:35:48.8324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a9f607-2aac-4b29-ed49-08de54b0574b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467

IBS on upcoming microarch introduced two new control MSRs and couple of
new features. Define macros for them.

New capabilities:

 o IBS_CAPS_DIS: Alternate Fetch and Op IBS disable bits
 o IBS_CAPS_FETCHLAT: Fetch Latency filter
 o IBS_CAPS_BIT63_FILTER: Virtual address bit 63 based filters for Fetch
   and Op
 o IBS_CAPS_STRMST_RMTSOCKET: Streaming store filter and indicator,
   remote socket indicator

New control MSRs for above features:

 o MSR_AMD64_IBSFETCHCTL2
 o MSR_AMD64_IBSOPCTL2

Also do cosmetic alignment changes.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/include/asm/msr-index.h  |  2 ++
 arch/x86/include/asm/perf_event.h | 52 ++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3d0a0950d20a..d8b3f3abe583 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -693,6 +693,8 @@
 #define MSR_AMD64_IBSBRTARGET		0xc001103b
 #define MSR_AMD64_ICIBSEXTDCTL		0xc001103c
 #define MSR_AMD64_IBSOPDATA4		0xc001103d
+#define MSR_AMD64_IBSOPCTL2		0xc001103e
+#define MSR_AMD64_IBSFETCHCTL2		0xc001103f
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 #define MSR_AMD64_SVM_AVIC_DOORBELL	0xc001011b
 #define MSR_AMD64_VM_PAGE_FLUSH		0xc001011e
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0d9af4135e0a..6f5ec5c9d5b4 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -639,6 +639,10 @@ struct arch_pebs_cntr_header {
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
 #define IBS_CAPS_OPLDLAT		(1U<<12)
+#define IBS_CAPS_DIS			(1U<<13)
+#define IBS_CAPS_FETCHLAT		(1U<<14)
+#define IBS_CAPS_BIT63_FILTER		(1U<<15)
+#define IBS_CAPS_STRMST_RMTSOCKET	(1U<<16)
 #define IBS_CAPS_OPDTLBPGSIZE		(1U<<19)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
@@ -653,31 +657,41 @@ struct arch_pebs_cntr_header {
 #define IBSCTL_LVT_OFFSET_MASK		0x0F
 
 /* IBS fetch bits/masks */
-#define IBS_FETCH_L3MISSONLY	(1ULL<<59)
-#define IBS_FETCH_RAND_EN	(1ULL<<57)
-#define IBS_FETCH_VAL		(1ULL<<49)
-#define IBS_FETCH_ENABLE	(1ULL<<48)
-#define IBS_FETCH_CNT		0xFFFF0000ULL
-#define IBS_FETCH_MAX_CNT	0x0000FFFFULL
+#define IBS_FETCH_L3MISSONLY		      (1ULL << 59)
+#define IBS_FETCH_RAND_EN		      (1ULL << 57)
+#define IBS_FETCH_VAL			      (1ULL << 49)
+#define IBS_FETCH_ENABLE		      (1ULL << 48)
+#define IBS_FETCH_CNT			     0xFFFF0000ULL
+#define IBS_FETCH_MAX_CNT		     0x0000FFFFULL
+
+#define IBS_FETCH_2_DIS			      (1ULL <<  0)
+#define IBS_FETCH_2_FETCH_LAT_FILTER	    (0xFULL <<  1)
+#define IBS_FETCH_2_EXCL_RIP_63_EQ_1	      (1ULL <<  5)
+#define IBS_FETCH_2_EXCL_RIP_63_EQ_0	      (1ULL <<  6)
 
 /*
  * IBS op bits/masks
  * The lower 7 bits of the current count are random bits
  * preloaded by hardware and ignored in software
  */
-#define IBS_OP_LDLAT_EN		(1ULL<<63)
-#define IBS_OP_LDLAT_THRSH	(0xFULL<<59)
-#define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
-#define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
-#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
-#define IBS_OP_CNT_CTL		(1ULL<<19)
-#define IBS_OP_VAL		(1ULL<<18)
-#define IBS_OP_ENABLE		(1ULL<<17)
-#define IBS_OP_L3MISSONLY	(1ULL<<16)
-#define IBS_OP_MAX_CNT		0x0000FFFFULL
-#define IBS_OP_MAX_CNT_EXT	0x007FFFFFULL	/* not a register bit mask */
-#define IBS_OP_MAX_CNT_EXT_MASK	(0x7FULL<<20)	/* separate upper 7 bits */
-#define IBS_RIP_INVALID		(1ULL<<38)
+#define IBS_OP_LDLAT_EN			      (1ULL << 63)
+#define IBS_OP_LDLAT_THRSH		    (0xFULL << 59)
+#define IBS_OP_CUR_CNT			(0xFFF80ULL << 32)
+#define IBS_OP_CUR_CNT_RAND		(0x0007FULL << 32)
+#define IBS_OP_CUR_CNT_EXT_MASK		   (0x7FULL << 52)
+#define IBS_OP_CNT_CTL			      (1ULL << 19)
+#define IBS_OP_VAL			      (1ULL << 18)
+#define IBS_OP_ENABLE			      (1ULL << 17)
+#define IBS_OP_L3MISSONLY		      (1ULL << 16)
+#define IBS_OP_MAX_CNT			     0x0000FFFFULL
+#define IBS_OP_MAX_CNT_EXT		     0x007FFFFFULL	/* not a register bit mask */
+#define IBS_OP_MAX_CNT_EXT_MASK		   (0x7FULL << 20)	/* separate upper 7 bits */
+#define IBS_RIP_INVALID			      (1ULL << 38)
+
+#define IBS_OP_2_DIS			      (1ULL <<  0)
+#define IBS_OP_2_EXCL_RIP_63_EQ_0	      (1ULL <<  1)
+#define IBS_OP_2_EXCL_RIP_63_EQ_1	      (1ULL <<  2)
+#define IBS_OP_2_STRM_ST_FILTER		      (1ULL <<  3)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern u32 get_ibs_caps(void);
-- 
2.43.0


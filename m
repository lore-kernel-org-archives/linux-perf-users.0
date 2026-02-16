Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989812BE64F;
	Mon, 16 Feb 2026 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215966; cv=fail; b=JJO7+NwXdZvdhyKOLOK249AtBbZsp3EGLa0ZjVRN2lTQe+2X1CPvJJsLn8eFvLAkBt8h/qDKSZIEucjaZ6SNmY4nyvftWsjMqpxpePFbg6K/kChBHz+mnPPQs+YMNsF7445lJqf1RwWoo/Jav8RM1hrqJEEWaKRPgkHvaoiD5kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215966; c=relaxed/simple;
	bh=eBlB9F54rhYkBcWpHSsg/PcpxrNraikfDg70v0DuYsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+mW3BTLQ59PdWw187CFK5tupZek5kRJgAgenjyssuznZFPsY8MKKwCL5XtoOF4lJmeEUY8Ae6tjhbwEB/Hlin0xubRj0+iowJfq7K2tSfETdsExnSPFNsHOM/QM8plhhjM5fXJSixQaQFjZz1rTAO6JnlbDG+Ll6CVUP7ebQLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VKz91zrK; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VKz91zrK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Irfm8dfDmMJcVFj8GUJnJL7xbFbhFVrFMbbcEkTCYeBsBKkyQd8ej8LXuZcJEEh8eai1+ETWnhGfYhFPj5ElKuDpybkqTwFcOQizvKKIx239U5Kv5Evri+nuYIxAa7cCS7OZTzzYs0n+KaCfJDJT/i/Ma6cnq6F6d++rwrN/2NH7ahhPdWV8u4fbwUDBSkmDxnZ1REiuGv6V97Pj2Xy6HzMd5eF0jC1yDxTe0Je9+XR98CmfibE+UroQ7n0iU+5uXqcwv13RpvOkG3EeS11LbVoGRPLoz8JrUFcacY61cpRr+cBvdVgEBfVk8M9joyzxq0GNHj3WxmU8suggA0mbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8tlx6gUHSd44KFQyZqSDzIyAIZhASW6Vj3fYVF8PK8=;
 b=rLr9jKvtL0FCKABZLEnz+DcXezExB8i0UMMk5VOuJDXnaGR2e6BVb/VGWp7UF5u+XCjZ81U11/rsHDA65TZUyboNtW9poKDv+O2Cu5X+38jMDRjFjZzreRntOt/5dUxBau+t3yGhAeAc7tMfvADuspxxBjyR/TS0W9Xx+ER45AJXoyB05gv5AOl6FdhH23FbgY/o6buIPUvNm90v+VxUdUwfKb5Q47Bj8grfMZnu8dQaV55NKWUbKJiHm1iKOzfBh70e9jfNb7VUGVOmBYTC8suyYW2cj6BStdUUp+F1TpernBj9JIAtf3+bbQKWxgEZvNGW4xuzYwEQ+NYcT2U9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8tlx6gUHSd44KFQyZqSDzIyAIZhASW6Vj3fYVF8PK8=;
 b=VKz91zrKD8GSPfEYc08mABl/YphRh+3NmgRhfQEjh89lVQiwxQ/SFzMGLWb63XHheyzBAN2NsLUlCblJgk2Iepc9JHy6X+GK2SxkQp3y4NabISGfxLlixhH7n8PGzTGz30mapDLkWFdZZRFiDuXEw5QyMaCqBBJLZe/vaiQ0cfU=
Received: from SA0PR11CA0123.namprd11.prod.outlook.com (2603:10b6:806:131::8)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:25:57 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::2) by SA0PR11CA0123.outlook.office365.com
 (2603:10b6:806:131::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:25:57 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:25:52 -0600
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
Subject: [PATCH v2 2/7] perf/amd/ibs: Add new MSRs and CPUID bits definitions
Date: Mon, 16 Feb 2026 04:25:25 +0000
Message-ID: <20260216042530.1546-3-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc401b6-adda-4af9-bbee-08de6d137b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P2OTdPox4gEjYiv0smCZmkVFMjglvknQUv60kqANty8PeU3/0KEnBJzYXwY6?=
 =?us-ascii?Q?NAEReUL8JgznfcOvXSbAQwAdW1DeY+tQeMMR8HvOtyWi8QcJGKcJdApZVb4p?=
 =?us-ascii?Q?xVSi9yU/WYvWIIVJyDprbpyfTLLvdEvVBn2Ue9wuvPfqrk1pjTmBLIvCIh5k?=
 =?us-ascii?Q?BBNfPfgnMQr8xig4xtzXU8G9BBeYYKKcblIo7BC8dxRHMQWXtbeqIZplKiOJ?=
 =?us-ascii?Q?sWtRQjTbUPSRan7b442E1YaiF++fTuosyNDUu9E2NUfS5heRTpEvB+OItZfM?=
 =?us-ascii?Q?HV5lJvcDYg4wVLveqn1Y5VWp0sFarqYWi1ZcCSVBSNZPmbpVeChFQqTol6Et?=
 =?us-ascii?Q?uLrpIjyt2lT+TC22mWuI+6Gf0K5da+TLI1dBuGM/zih1nncx9i3/n/pkxvv3?=
 =?us-ascii?Q?ZOfdnzLzBONQWSp+1DyDv+LKiVbcyp94VT2g5YUuDx9zc/pIXVj+1bD5mf4L?=
 =?us-ascii?Q?Ttp4G+L2JLdYDlnq6EQFJQajccfi7Ga4excnVbgJwoCccU6u3TIx+uF2KpUa?=
 =?us-ascii?Q?nqKyqHbizTm5xkmZ5F3qr81EJr3AvLQwWP4/uEfPynjtHgvyb2eBZ+UP8glR?=
 =?us-ascii?Q?GkQgGhkVexTnbwhtEhNwVza2Q36eaUe+eJGRRDyVEdoWn0E36f+o+q6Bb0Wl?=
 =?us-ascii?Q?4/RrLFvHwnWX4cdXExtrwEQtc1wPUBnWYHfrfqBAwLB1wQdUCSRs6hf8Dswh?=
 =?us-ascii?Q?tX85GY6u7PxTVsr34lavx/fJd/0JPMF+orf3s5wXudXk2frexR2g3onhsncq?=
 =?us-ascii?Q?WQdatGyPIrm9dI+DfjehrpExioCBJCdr3nAkgdwYrdv4TaBUtHD/B6AEiCXB?=
 =?us-ascii?Q?kueIr9bB4oDswT+0iT5kBmParZGyzGS8jHoWTbZlyosboj0WY95ocARRtsnG?=
 =?us-ascii?Q?j5h+cMoVGh55FZ6RhNvqyLWBjFyW4CnLwviOl95Db2s/AzP1zMzpp0q5aW9D?=
 =?us-ascii?Q?KXD+SdG7q23RfZ8UzZipo65TuoCHl4npIWOzsukjwwGOGrs/Y3IWtX1uJVOK?=
 =?us-ascii?Q?Bw/n/pGmQm7/M8wWeniX7yuplp1fDuD2aRHEJi7yWt2glnWbkUWtxCCsj3yc?=
 =?us-ascii?Q?d+mZiF8jKlvUv9HKYzqctJbOOqFixAD9DlpztgPbQpYpkY6zExinPo67TzSg?=
 =?us-ascii?Q?iq2RISUi+lPCuo2LVOCKSLwf2ofZkn+LLL9ib4mAEgxvJXex7LMQ/VZgc5zd?=
 =?us-ascii?Q?mIKSgDZoiZ/5yXKPSmUT8p/eI17p/ZL9W6R6CrNpc0SSs4GtZPYkfM0LJ0Ds?=
 =?us-ascii?Q?fVr2Qnq3/k8NkmGLwVKKzL1XQHBzu/ZZx/wM5Vj77Vegv4f5xPpRWmeK0iks?=
 =?us-ascii?Q?5hKCOIJNjVP7mT6ptp8kSoGppIJsnrPnY1+VioCT2KL78AFVZBPa/mzrgyUr?=
 =?us-ascii?Q?6M1mn0mK5ZZxGG2DvR1L+8iM+RLMcb2ZbCjuvn6Gca+EcSOrb+oKcb/St/+/?=
 =?us-ascii?Q?U5k0xXZeWIdNY02xRCQr0r3IYa97spo1wgHNf8u/U83Xua5shJjAdeNTEkSK?=
 =?us-ascii?Q?VkRNCgtVBIt7CH3FrmvJUeQwcYS1iBz+zfLHHtz1D6grtTF6A/XP6s9X44QI?=
 =?us-ascii?Q?nYf6Zt5IiiZcajYY+FmXCIto/MAHk0yzwmPM/HZnrUNRYi0pVSdtul+Eh8HR?=
 =?us-ascii?Q?F5+agEYwUuMx25OT0v6KTJ7jD1LKD70oowBKWbewY0cBm38RweU/5Oamoy04?=
 =?us-ascii?Q?MFhPfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L/Gomgy/Q0F6fbg9HDhTl71Vi7pD7wf5+9nmzSL3BppqaWlvkiPR7nZuldoZagFqpZMi8B7d/ntyMr4qJKnZgZdpx9etmCFv3/+1KmwgnYno+JNb2MW2qpBPGYwzs13Ka8mCxofw+q/4dH37upsastJCe7TZpIl2pxu+UHdcS7G9S+HKMXMM4cOoUkd8iXsPeKP3M/ICp+VfVbKfKuYM5sA8UKZ9p6gGjjwJaxzlYVLh4j1AFAcs+TFSKQkE5gvdGZWXU42HrGKlr6ya8qEDsErc+kfUsrbHEh1o9VoeQaaaOwxKYm46ZwgQA/XfMAo8nggoeMrjofcuJxOvMlTyGes2qpC750chLiMjtoK/O6Zpp/IfedsjyrAdCwJix2PR9veG06xq8FIwggpVyRD+lxzY5SqKMMlb35lE4OdAcS/Wzu6/2S3arvKqlQw6IAbe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:25:57.2502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc401b6-adda-4af9-bbee-08de6d137b45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885

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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h  |  2 ++
 arch/x86/include/asm/perf_event.h | 56 ++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6d1b69ea01c2..2313623eb0d0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -698,6 +698,8 @@
 #define MSR_AMD64_IBSBRTARGET		0xc001103b
 #define MSR_AMD64_ICIBSEXTDCTL		0xc001103c
 #define MSR_AMD64_IBSOPDATA4		0xc001103d
+#define MSR_AMD64_IBSOPCTL2		0xc001103e
+#define MSR_AMD64_IBSFETCHCTL2		0xc001103f
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 #define MSR_AMD64_SVM_AVIC_DOORBELL	0xc001011b
 #define MSR_AMD64_VM_PAGE_FLUSH		0xc001011e
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 67ecb989408e..752cb319d5ea 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -643,6 +643,10 @@ struct arch_pebs_cntr_header {
 #define IBS_CAPS_OPDATA4		(1U<<10)
 #define IBS_CAPS_ZEN4			(1U<<11)
 #define IBS_CAPS_OPLDLAT		(1U<<12)
+#define IBS_CAPS_DIS			(1U<<13)
+#define IBS_CAPS_FETCHLAT		(1U<<14)
+#define IBS_CAPS_BIT63_FILTER		(1U<<15)
+#define IBS_CAPS_STRMST_RMTSOCKET	(1U<<16)
 #define IBS_CAPS_OPDTLBPGSIZE		(1U<<19)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
@@ -657,32 +661,44 @@ struct arch_pebs_cntr_header {
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
+#define IBS_FETCH_2_FETCHLAT_FILTER	    (0xFULL <<  1)
+#define IBS_FETCH_2_FETCHLAT_FILTER_SHIFT	       (1)
+#define IBS_FETCH_2_EXCL_RIP_63_EQ_1	      (1ULL <<  5)
+#define IBS_FETCH_2_EXCL_RIP_63_EQ_0	      (1ULL <<  6)
 
 /*
  * IBS op bits/masks
  * The lower 7 bits of the current count are random bits
  * preloaded by hardware and ignored in software
  */
-#define IBS_OP_LDLAT_EN		(1ULL<<63)
-#define IBS_OP_LDLAT_THRSH	(0xFULL<<59)
-#define IBS_OP_LDLAT_THRSH_SHIFT	(59)
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
+#define IBS_OP_LDLAT_THRSH_SHIFT		      (59)
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
+#define IBS_OP_2_STRM_ST_FILTER_SHIFT		       (3)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern u32 get_ibs_caps(void);
-- 
2.43.0


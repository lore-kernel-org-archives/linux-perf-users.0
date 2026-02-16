Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16F2C029D;
	Mon, 16 Feb 2026 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215957; cv=fail; b=D0Nbu0SSqSKjRMmhmImzstK5uDnJA/lEqeAHyIBwio5hsWsharPiz4fbpuPMSkb9FRTucUOh9MRmTyICJ66xc3F55/CmApS4V8g2nLZw9XBPXYONmle3zSG/OOREHgy45wpVBC6fa2F9FOz0jiFnYcO/2ysSPIeHlIT48IUXHVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215957; c=relaxed/simple;
	bh=nR8eFhftRmYvOM89coSs4eQrAVIs9cQ9aDXj6s9p3JE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKoeR99KwfM2uIKnC28AVdz1dExTC65Y1RALcvIgIVlWl6F1diSb4bGQJsAVrnkoX/6VKepanVUhmrN5x5ARzVkdAinWgZZTxMiDqYQFlpqXL8Lx2Xz1Q5GKYrDw9iiyWfqcpjaFKp2wi2y24GTe2gBuhfzXbswQk94YHePPUTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PfZ4+XHz; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PfZ4+XHz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHGPY+Gu4tYSF6N6ByvgBA4+XbMX6YbttDaNv5bYVmZVj6q2Wjk9pDQQrybd9xK7yzLa09fxIB1FMfeSMOydixRAnyr5W6Kwgm+ZZ8lZ/5hkl1XnJafQLXuFVy8PCxY0VUDzitsBw5MFh4ntChgrJlJNOD5RknBfufpzZkgKopPBGhhFQXBe4FdU9HdU4x6qDwTvcsFxZw0rhmqbO8L5EkUE04DXGK5PIoi6kKv4Ptis9lqeMfvmyJZg3qRtoMpOyqfAADnSNYjPk/1fmB50DEVal2guqNVrzg6lpV/H1xVmG1r9JB6wRT3Q80shg/EROhOzC44ECtCij/3S374/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGXv7VSNCG+aw03+HxNmh1nT9xBXFL54bo9rdT0ht9U=;
 b=zDy5q8RMjTTl5MyqL6fgVD9iia0Lhme1BkNedff77jqGq4k5h+upOMlFP5THRr9IO/AEVpmKClTNtAIC56h47hQM7YnFOOaMgH+5CqG33Z70fJvv3/QU0xXCcwMPxNCjN9M5buJS6CPYBz8cMP1YGnwztIJVmPyrL3lbl3lWqh4ejMDKvQ9BaRZgRnV2gs/CbRGO3ZJL9GfEu90NgRQCazR+IoodSgApSlB9TvhU6jdx+fUb35XOoeb1UCrUYMGB1ihhmNZIJ3teLWLD+M9mfbeoZSYhJI0LoAlgCF8JF+EzLF0ZnmkmZs2lDmE6Kv/E4HIDoGomCG6o2FCyQixE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGXv7VSNCG+aw03+HxNmh1nT9xBXFL54bo9rdT0ht9U=;
 b=PfZ4+XHzOEnAFrcmUcN7zPx+4YjKAKrN7ANJS5gkv56Zf0jQonOTA/2z6C3qRn9RBJRdBqLNpnkq08xnSJK7d6PH9uK/3M/7j1KAAO1+k3ldPeDOOJ/ew2S3ZGmXiHgLxGfD+oLKosytm3Dr0nkXCBLMXOKb7YnIP++kvsoxTCQ=
Received: from SA0PR11CA0144.namprd11.prod.outlook.com (2603:10b6:806:131::29)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:25:53 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::14) by SA0PR11CA0144.outlook.office365.com
 (2603:10b6:806:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:25:52 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:25:48 -0600
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
Subject: [PATCH v2 1/7] perf/amd/ibs: Define macro for ldlat mask and shift
Date: Mon, 16 Feb 2026 04:25:24 +0000
Message-ID: <20260216042530.1546-2-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: c81f8c26-5d6f-444f-d0ca-08de6d13789c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wzx3C3UKJ1Gzs45x6Pv2nhkPzkC0G+goJGRykRxzuOsvFsuBn5LXL2SR1hXS?=
 =?us-ascii?Q?9dU37j3GwgrgCF7JbqNZj5M25UtpalfFpLbM6xodmiXXP7JNL9cv6b+IZ3aV?=
 =?us-ascii?Q?qzm5IUeyVmAhYE/ldOGapW3QBJlN6OIPaomdCd5Si/iVUXDRJzfpqxrgtBoF?=
 =?us-ascii?Q?NpC+ZUEeu1K5sZ7LScJi1wTOcxX9gmc6nTufV0b/dR94FMz7qiIZZK2SgHwh?=
 =?us-ascii?Q?PPwRWacbxupARWYw5PgTU78+avswiKNHNTaPOdpxI+LZ7hIr9ykhabWQIxyE?=
 =?us-ascii?Q?PPit16Gr4F0+X/WVBnthX5iCwHaNl3Ds9hejZtIz6Gtg9b4Yzf6fDpD/Aw9/?=
 =?us-ascii?Q?sKCqf7Q963I5BKyurHmA8/OyrGV9PUqgwIweDPdjNI6A20zW8mi+pIxZdOOq?=
 =?us-ascii?Q?vPaLqMDPCfszh0IreKFNg35/cFm2g+Ok4TNhECsmHuS4V+zsL3PoRbCXG58N?=
 =?us-ascii?Q?3H/0iAsJKDqCvvWf4L3xCZnY64bjFAYB/VW/flx+X5WsgOA58PNLo4A2ySqw?=
 =?us-ascii?Q?BldpL3swGdMyYZKQ1t5vv2PtfK/LsKeIyewBFEFMQur/Lz9/SE+iNTG5WAgy?=
 =?us-ascii?Q?C5pS4cM3tks8Sus8pYeyWg10SUV2ay6il6V9rAmTfhFODi7DfJNKdYSfjXmS?=
 =?us-ascii?Q?cyHgmHd+CQig5285RzWGw+fo/1eHY1DmwGhUM93osoPaRZjzVhE9WMZ/wtb8?=
 =?us-ascii?Q?VjArPgK/5BeTO1TJRiuXo1jNDK9mLdkMnGbt8KKc8H3XqQ3nz+eA8u0ZaOvS?=
 =?us-ascii?Q?jOhaFprT5XcIQoPhA4cT/FMAeq9Wj7DKiNVt+FlNYLd+572kDVcqvcFlWYyR?=
 =?us-ascii?Q?vCiM//7iCmwz8IHN/gtVFn8PYkN/l/jD3x1A+R2f7G4Xi89HLb29lI4Qp0jG?=
 =?us-ascii?Q?30sivZedE0TapnCdrW7Dwc6cjA5ntm5TYWsVL5bDayQc8AJMy9pfmIZYyZmj?=
 =?us-ascii?Q?Pp7xeSvijfVuyUgdWoqA+j58q90MUb/Nvw8+gnNJOuRjMMQ1kW71MvXMCY9I?=
 =?us-ascii?Q?5RGAiug8yxD5wivKmX2VZGsnPH7idAHF4PKvlmqFSJAT2RvVb72hrAAQfrzR?=
 =?us-ascii?Q?rEzzi6T+LVgktpv4vVzr5uJliBQUMWZACJ9qroeMK+JlQLbpstfqJy3esWzZ?=
 =?us-ascii?Q?9DGhoTqCJdZ/N+mrW0Pv0zrEv986dv88xxGyzREToRkN1DVzgjjUaIq+otCk?=
 =?us-ascii?Q?hEJ2aHen0Jt/4zuu+zFDu99q6KOYSVt/YhTOKD+/GIn0yM37hEnwxeydFKnp?=
 =?us-ascii?Q?HJMOSXzj/1lM8WEBGkxnHEWUTwy53FegGNQXE/g8lHfHNANQkYnIFPF8cuVI?=
 =?us-ascii?Q?eYo/M0lKu6+uTDA4St6k40wGa7GO6XUBxDVm9U+5f6UGEvoVFFb5TrW35IaT?=
 =?us-ascii?Q?EssKGpVdvnMmO3hhJWvPNxrAcDtcS5WG3MJiLgsvBhGz2JzfszpY7mYMYPwT?=
 =?us-ascii?Q?RQ+WrTzXR0f6xXn+431SUTKTFyapR7H3Q6SGVAEieC7nsOtPAE0aFploEd0N?=
 =?us-ascii?Q?gNO31DTb/SNT7ow7h0lSNQ2jXZR0vw5jk4KQou2E1eyzEdoVkt9ZZS9qa/CW?=
 =?us-ascii?Q?21EvS4SQ/Wva4QnV34AemtK3PbI7PkmK3brl/74ocZedZ6CQYwLpO7o67mhY?=
 =?us-ascii?Q?BBo4zAZdsZ6pfZ+ha0CLMippVP505eT8Alm7cb+1ewwmx1aG6kKoCVS/sUC0?=
 =?us-ascii?Q?XLiDxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3bVOxl7dLcu8NzIhxbDq+iPKwAJXBTBo50xuevA/Tq6GWyHnPIKe6k5JrUHuKBsyIw6cHljL+N9ZOcpEB4Ad78pcbelIGlT9UDOrcpA0Xaif73gs+VcjqdcGutPHT5anxfW37B1MtELrFxVgP+q4u3Huak9NP0oI5OxySm7zuyF5Qx8vpGHGnEQwfDNhOhuetGdC3aVo0L7UWHedajh/MZIsUbHb4UbLoSO69WaCxNGmV+nG4trimedo6WhbVlRmMeqVzRUiLcASKe7pSrw0/bgwAMvP/OiB+YIzyOxWHtx3GISPW7jy2v/4OnHECSZOrUy97RcMqgDnR4EtkCZHeL6RL+4JGFJh/lvY2TDu+0rcDMgOZolpQMC7Q0WOBC2b2HuoI6msOt9kP75C1oi2RhJnOuV61pNHFI0K8qS29tVoLHDGRX+XXT5PCQNWTmJd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:25:52.7893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c81f8c26-5d6f-444f-d0ca-08de6d13789c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

Load latency filter threshold is encoded in config1[11:0]. Define a mask
for it instead of hardcoded 0xFFF. Unlike "config" fields whose layout
maps to PERF_{FETCH|OP}_CTL MSR, layout of "config1" is custom defined
so a new set of macros are needed for "config1" fields.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/amd/ibs.c         | 11 +++++++----
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 32e6456cb5e5..2e8fb0615226 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -32,6 +32,9 @@ static u32 ibs_caps;
 /* attr.config2 */
 #define IBS_SW_FILTER_MASK	1
 
+/* attr.config1 */
+#define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
+
 /*
  * IBS states:
  *
@@ -274,7 +277,7 @@ static bool perf_ibs_ldlat_event(struct perf_ibs *perf_ibs,
 {
 	return perf_ibs == &perf_ibs_op &&
 	       (ibs_caps & IBS_CAPS_OPLDLAT) &&
-	       (event->attr.config1 & 0xFFF);
+	       (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK);
 }
 
 static int perf_ibs_init(struct perf_event *event)
@@ -352,13 +355,13 @@ static int perf_ibs_init(struct perf_event *event)
 	}
 
 	if (perf_ibs_ldlat_event(perf_ibs, event)) {
-		u64 ldlat = event->attr.config1 & 0xFFF;
+		u64 ldlat = event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK;
 
 		if (ldlat < 128 || ldlat > 2048)
 			return -EINVAL;
 		ldlat >>= 7;
 
-		config |= (ldlat - 1) << 59;
+		config |= (ldlat - 1) << IBS_OP_LDLAT_THRSH_SHIFT;
 
 		config |= IBS_OP_LDLAT_EN;
 		if (cpu_feature_enabled(X86_FEATURE_ZEN5))
@@ -1305,7 +1308,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		 * within [128, 2048] range.
 		 */
 		if (!op_data3.ld_op || !op_data3.dc_miss ||
-		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF)) {
+		    op_data3.dc_miss_lat <= (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK)) {
 			throttle = perf_event_account_interrupt(event);
 			goto out;
 		}
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ff5acb8b199b..67ecb989408e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -671,6 +671,7 @@ struct arch_pebs_cntr_header {
  */
 #define IBS_OP_LDLAT_EN		(1ULL<<63)
 #define IBS_OP_LDLAT_THRSH	(0xFULL<<59)
+#define IBS_OP_LDLAT_THRSH_SHIFT	(59)
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
 #define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
-- 
2.43.0


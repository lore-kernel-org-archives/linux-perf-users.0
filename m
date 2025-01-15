Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CE13AA2F;
	Wed, 15 Jan 2025 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920016; cv=fail; b=PUr7KdBGN8jymQf97zBDwzGi71FKhQkrLyVU5nuJjuZ+iSo3k6w6lIFkjjAZZ+sciWFaTKLRyLSGXf9wJpHtVs2TjuVoNPWitC3G6YNl12z5lAM+3b+79jUvOkvLoPQ9juF7wj4l67ttd3k5dQva1pchqiQdAbZII2gyZPRBVbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920016; c=relaxed/simple;
	bh=HBe4yB9WFKZb8kLraYFLV+JRvbBHtBVNW7J41e6WOfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdecweqBufspYriL4gw/gZBsT6yXCcOs8AWrtAunQzaJZ+oawyxi522OpPlO8uIiPpT5ZKjLWHRGEc2ZnUtQy/VJx9m8X2z2qy/qYVz9mFDr1kmh7lF00zHQQbueZ1k/7c5pdk1Xd0b8svrRfugfJQrWfBBjLRED+ZB3LLW73sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GWji5eSq; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GWji5eSq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDntfXNGPPxXh/HsoHckLmtvaR4Q/qfUnmUWp+7xUm8iYAS7ME1bWIo1Xwq7EHrHgRAM3k9MjapXD6edTYRJrKNdrVQjWXhoKP2eJHKwE/FMR+SmgnFcinvy/asuI0z6ukHwxaBiiYgtsM/rhy3IqdJ96uOEH62/GbSr5T2/hZjFhdqQH5CXdScGbGitBuE4U1C/ScpAChoJnOu2iJDalnZtpj2eZ9MMAdwYQCe8ZAEa14timthLU+j/500uGJeXv3HN17iUIe3cRLDzgIH8ynfyQBLD54ID/PbO7EB5xm9uzeIsG7JopMDdxV+5dBPBDvhpk23l1KI2LRjgMu6ugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV9sKGeiV2exTm6uQYbJeZplZbeP811iNBgf12wv2jU=;
 b=UWp39bVTfELKdkDjW1851d2+uWy10VHBsCk64erndYECBsHEDEKrx6Hu4OvkxHU+T4unq9Lxu++2sPiZ5qob7Z4Gs4wXFpPM38Eq544PJ4DttkzH5QFj97tuXjJ1gt/Du/8hTfyuuffygpu8u2NqoNhw7l3Ia+3l/rO30YJB0O4VDt8Meo0u7GKVBBEIlioUCS29Z+Ub9GFqHJU5fhGXqrUzAs/jnYJnnbpknxmMBh1uQCz60uIogy0MYfpv4cXixjVT3eBjI+0W7ajBgGq6sw6vLBscOSls+evWbbP86Gkfv5K45hf3K/YuQg5ytK02SYPAW2nWyjDP4b6L3yZbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV9sKGeiV2exTm6uQYbJeZplZbeP811iNBgf12wv2jU=;
 b=GWji5eSqkeyGw9qQZb9wA9wwGqvnlrXvlTCpx+IWtC1u/RZkkF46doKKcXKQ57YUovWPQIfYYYvNi4JuBt7FMImxarXRSp/FsmWwOqW649ifFSM4OxMc+oKsXmLCSSv4f54OhvgBrUSoTbrr/UBoda3NoEOqO8gYAk2+lB/a9rY=
Received: from MW4PR03CA0065.namprd03.prod.outlook.com (2603:10b6:303:b6::10)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 05:46:52 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::53) by MW4PR03CA0065.outlook.office365.com
 (2603:10b6:303:b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Wed,
 15 Jan 2025 05:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:46:51 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 23:46:11 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 4/9] perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
Date: Wed, 15 Jan 2025 05:44:33 +0000
Message-ID: <20250115054438.1021-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115054438.1021-1-ravi.bangoria@amd.com>
References: <20250115054438.1021-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: b19f8aba-c05f-4f23-8086-08dd352802c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ilsoCRE4dYLxghpuRhnFBnWSSCzxKPni7m2m7npV6YOSE9AYyEFECtRfy2NY?=
 =?us-ascii?Q?63Yo9hIThQMLqk8g2+SWXNDZj11wluQpYo5UCud7rfwTt3JPo6M2J1LbP8bN?=
 =?us-ascii?Q?g/x+JrQFsNyU+xWUVlxaTHirL80yiklikHEO5QON7fjjT/Yebw68gVeqS63T?=
 =?us-ascii?Q?NvNypzS/+Hgl+qLlN+fqAX7cShLoZH5EYQa25MQzz+YbwbVqf6gUPUTiWQ8l?=
 =?us-ascii?Q?3Vw/Gxkcf9vDjptb7l0HlQ0S0JQe0fqsuTjCPkYQhxLtaOiTTNmfKWp35Lh1?=
 =?us-ascii?Q?nxxQNt4baYUWtUJdJoKPW5sIOo1f6DXRXGlqWBkKdhDtHF03+RgEdFQVG968?=
 =?us-ascii?Q?4utTJh1pHAslF1srm6quiNgKoujGCUF1t1BlV51fieUCK9JLrrYqiB8s1aYk?=
 =?us-ascii?Q?x5X6lXz4oODhCHiI8ra0eE1OlehVcIYYgqUX3tkZVkRtyFqJIAopSaO0Uu/I?=
 =?us-ascii?Q?/YLodfW/cA6E4/ySDHNDsRyKkDjvbWVJ+SQV3zED6EftDA2QgoXEVBfgjkFL?=
 =?us-ascii?Q?9SF5JhUpWNOHCNwC7YvQI5kkP6Af1ZzGMV7KCvt7NcAUriDips+RpBJf6Ww6?=
 =?us-ascii?Q?M02WcXoZwhD0/CMXvkaoE6KAA+E621L5OjDR+mtvrL/mWpmtJblCcBl4H/hk?=
 =?us-ascii?Q?PGD6Rc5+L200283OIB5Okaq2Oc5//cfuaRHzw58tc1GL6yIsGW5lrfy2tJnh?=
 =?us-ascii?Q?FEJ8zUOoa5psp7S9K9LQAcYGM8vtRzzR6P7g7yb7eQHkCCt14tNOog9IJD6d?=
 =?us-ascii?Q?ijmRAANYAnnC8Hz/CIjeNBSChDdKXbHRuBR877clHvh2UHTGqp7Vx0GqQ0Be?=
 =?us-ascii?Q?m/fQl3PHy4qeW2ojZbWb3APJ2DESKwKiMv/TbNvRVaSEIOVx7MxeNvltOl0K?=
 =?us-ascii?Q?U3vhmTY3wyq7D9JzCIiXIfi5GUExAZhia2N3B7jQXSRiVsQOv3NnqZrp0bKy?=
 =?us-ascii?Q?/98X5r55mBtMXYnU49wKKGEe/ihlArBW+/cjdYcIS38DRfRfKCR04uHKKMgk?=
 =?us-ascii?Q?Wijt0Ypqw3bBrPsP70LLjPL9mQ89Vj/YMhQWqMztyWIUNLaqNdzgUV+nwoG6?=
 =?us-ascii?Q?xVw+Kybufqc03zLSkJEaPGlFyK2/b6nuYBppIpGExGrs9CDRC6TMofbGDorj?=
 =?us-ascii?Q?/8z3tSYD+mRYCqBbXDOUKQMyhgZ4uavyK5AWDkTD9iM5B7TfiWbrx+yre9j5?=
 =?us-ascii?Q?gAcvgoqM51dM1nsQ68JAV/IghFKVWf+rK1w7G1H+a/JPGOFNKdT+6W/jO9pd?=
 =?us-ascii?Q?dpUUWbyXphBEvLcilZXHgF/W6/JdmbHP1s7vM6Qonchfj8wOf+GjAJOLozVQ?=
 =?us-ascii?Q?TyxuaZsXau68qBRWNaE9rG0kumX1jS3vXAzTu+PrMRWzYTlxeXso9Wi720RR?=
 =?us-ascii?Q?3nrUQLDzb9bKj7t+YFhz6ZgV9czY8ukRAWdXh8HNm5XqNptcyddi6tIHtnQG?=
 =?us-ascii?Q?UGxV+YU5rwW0nZ6cdLzwNCpbI+KpOzPgZEIU8OmtH5zb7G4kbyhryykvbVwu?=
 =?us-ascii?Q?J2WfSjKIZ+2xJkg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:46:51.6181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b19f8aba-c05f-4f23-8086-08dd352802c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009

IBS Op uses two counters: MaxCnt and CurCnt. MaxCnt is programmed with
the desired sample period. IBS hw generates sample when CurCnt reaches
to MaxCnt. The size of these counter used to be 20 bits but later they
were extended to 27 bits. The 7 bit extension is indicated by CPUID
Fn8000_001B_EAX[6 / OpCntExt].

perf_ibs->cnt_mask variable contains bit masks for MaxCnt and CurCnt.
But IBS driver does not set upper 7 bits of CurCnt in cnt_mask even
when OpCntExt CPUID bit is set. Fix this.

IBS driver uses cnt_mask[CurCnt] bits only while disabling an event.
Fortunately, CurCnt bits are not read from MSR while re-enabling the
event, instead MaxCnt is programmed with desired period and CurCnt is
set to 0. Hence, we did not see any issues so far.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c         | 3 ++-
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index f95542b75b91..d9c84f1d530f 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1245,7 +1245,8 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
 		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
-		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= (IBS_OP_MAX_CNT_EXT_MASK |
+					    IBS_OP_CUR_CNT_EXT_MASK);
 	}
 
 	if (ibs_caps & IBS_CAPS_ZEN4)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1ac79f361645..ee5581768fea 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -514,6 +514,7 @@ struct pebs_xmm {
  */
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
+#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
-- 
2.43.0


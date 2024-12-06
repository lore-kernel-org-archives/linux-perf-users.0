Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C991946DF;
	Fri,  6 Dec 2024 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462304; cv=fail; b=n6Bnn5VqPoIdrJq8O4SclbhPvUi7/QLQD/SvtgCQLXhj2HM4PXYSzy8uD3WmQQuZLIv0zN9HnmVfoHoFs9OLnd4HsBDCJ9TR+VUG0v+fZhPAgfdFScXmfpGEP83N3A/VIYjkZMz4XE2QZUDEnoqvsv2ZwQceHGAuontOGXnmKdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462304; c=relaxed/simple;
	bh=77i+7YzNtr+XNFLQFTfyxLB4gfbjuWKHBytoZ0Gayzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQwiSQk4lt2UMEoL4y6U98AHDo3OlDAw/wKAEJW9RBHFvPFB79xb7185y2f3oopgE9FIQPwSjdbA/xXD1ryex4y4qq0QCJ2xaCC/PPl/LMC+K5C8jbqNUrkC8rj7WT1Caamun0RUPwdHNwkMW295b9lzAS7VWI7bLdILW9A59gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RFXG/AMa; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RFXG/AMa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeNr9zZ5+MKZXTszma1Ek/JvL635NOra08cGLLk+h97ncDPg1Fcwy/mySKwL7zOP3A5aUdf9yjkydO/Pus6SDtUu9G2h5gK1NUiGMfjRJFM6FgIyglTQcHf2CV5iy+JQs5fU3rr+1Xv1+RRvGySaqF/ZogkZg09Gh8TLCzLChU2pPr5kRV6enAWkN/wT1YLmu6/T0x/s01tWG81v1Jq5XwVUJSsIj3LCLMudc4HSkuKstZKtOVR1ufuD/TVPP1FkTcWW8aL4iWzuCfAjGcCVrfZuf80A+iIOwzJ6ggNzy+fM952pJKrVh0Ad/G1OL5xHzemOPgcmvO5yhCR1O3Oz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy4jD12lvdnLMvlE18cEMa8JBbjFRYFGGlnpYzYLnPo=;
 b=Mh0Dc37W7DpjRTwTRchoGGyyb+wDMJfv7BCmS2FgOyzhRX7/UBrMVEFGvg3rSq5IAMweCfTxpI97USRcKzxymRNBWmW1FsiFK/tSv0HnWfT1BGIoDOr6+KL/zEZWfOfAzaLZClcPVL33EOdo6/9RQIa1hYsmXHrWmoVElWBbwthWuSebMyqnppSU0qEbCBTdxvpoTHuQEBw2/60Eg9ZuWzxdCKpDIzsT5xQmXXtFCZ0/luIMSEXKft7QoLTwgJGpxlB1sEDbMPzI6wjhAWzhIhGQbIup/8hU9KlBV3FIyvkI5t4S0EGDyneaBhADlnNsTQj18KWf+o17+NhTHSMH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy4jD12lvdnLMvlE18cEMa8JBbjFRYFGGlnpYzYLnPo=;
 b=RFXG/AMatAHJWWTTf1KyUJejXDXY9IpEgpVDn3VorZ0P8DiYJSq6MF4omhuoZfRI36RQMw5tVNxxCgnHr/4BlEILIe9er1wly+iwnpDXawZ68JLklOp9CItjliT0Sk14xDwnhgViJmSwn6H24uSJtbi3GO7FYSrywPrbF4RmK84=
Received: from BYAPR08CA0013.namprd08.prod.outlook.com (2603:10b6:a03:100::26)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 05:18:18 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::73) by BYAPR08CA0013.outlook.office365.com
 (2603:10b6:a03:100::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 05:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 05:18:18 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 23:18:11 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 06/10] perf/amd/ibs: Add pmu specific minimum period
Date: Fri, 6 Dec 2024 05:17:09 +0000
Message-ID: <20241206051713.991-7-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206051713.991-1-ravi.bangoria@amd.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b60babd-eb4e-4b5c-259e-08dd15b564f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTrDA5eXGzc+lHCSwRiZgLIkjTWEPpbdBSxKzl7VLf0Gb7fwV51cY3/jkLYp?=
 =?us-ascii?Q?N9wzm3SV8o/UhKCxMABrTk3B0flcVE1g4FEixBa8lJw2vDFNcpn15uH4bKDa?=
 =?us-ascii?Q?dAYSeBNXXppSowFbHwbvYZ84H3q1Y7BW7KWnbuejFA60KADar09vIaK6zWar?=
 =?us-ascii?Q?xt+zz3DDj+sn8rLDNSWMMr/2vzsuIwpVCH8TEyh+WpkWTNrpQlE3X4XyVvae?=
 =?us-ascii?Q?x1evQkPXr3MQWdLjQfpg5pNec5Apv34EADpYoXD7QAoOmbipZXTrcpcNacsQ?=
 =?us-ascii?Q?lcNgJTZyhqWn+OD8h/X3eYdyQ30ZbQHq4/Kz294aYz6JFhuwSS0YDFMdx2oJ?=
 =?us-ascii?Q?rHrubFjJJ7i31zpKjKNcQRJduXVL8vJGkNJ3AKOANA/XFoB/mUlutC4smVtD?=
 =?us-ascii?Q?+O8srGeZyfkz4PrC+4gYfQgnPoNRnlkHyUmVwdTUaZGZ0oFSeua7WyqgWDwN?=
 =?us-ascii?Q?bUCY+8SCDTEK0+V7Vo4azpKQrDvp+wnZdLhUaRzwGmhVi+F4/k71v4GgPDqs?=
 =?us-ascii?Q?EcPVX8irmn8l8g5ZxeuL6PjPD+CE9Ewm/1N9K43uYdTakPeRa5TNfIbyyIBf?=
 =?us-ascii?Q?wAXjmGeKbgyTgSRIwAz2aJ3On7uXOKPrCkDF7L1M2r7V2iImlA1B/cZCcmdQ?=
 =?us-ascii?Q?PIwPHSDxsFzrUZzwoWrOx6z7Y6mjhTuRmGIsyzFO59dv7G2SdBDmT3Y7P8IG?=
 =?us-ascii?Q?gtsFc2OUuBGecNhxWLW89J0A0CwAxV7VZ5lQYtqNdjwrzcMwKI1SLVlTBagd?=
 =?us-ascii?Q?ew4tS7WG51cf7JZLB5QWBeToEYY8MMEG5iKE4qgszwxqMD0JY/jZyDBenoqa?=
 =?us-ascii?Q?UB5Z9ixzv49r8yogpR3MDunfaS1pT/1kzQk9TJcTmF8ihVGl9euLe92hEHbS?=
 =?us-ascii?Q?JN3BRNJ1n6QlhTcs1GHpI10TROZnYP49fRll18dlAyQzK2SQWzCFv9DKU/Lb?=
 =?us-ascii?Q?T6bRfEaMOB2cCsT/T0FzefSQSPh9t8p7aE5vU/uU76kbi0yUtOPf5Vvihi42?=
 =?us-ascii?Q?+n4WLqSG6u68naiLByUuQK95qHwWOg4dIQQ5/mQSrI3ggeakV6N5/M4rjfHn?=
 =?us-ascii?Q?kNVx3oJ9dXV7ZJR6gpmVtDUqDrUbnhk9PMr8jByDy+19vkavlyZwkKTEK33f?=
 =?us-ascii?Q?zPYzLAPZ4jYwl+2AWK0Dug14qGN7wTsvAL7fbNVPBI0fb7/yNB0WbyE1POtU?=
 =?us-ascii?Q?LAGYWyCMoacQhO+Pnn3Y81PCNgcpA0R1ZdF4jj264kiEURwL9UPanksVXUlE?=
 =?us-ascii?Q?YxMC0plkT7tJbyeXI+FdwKY6lfTVCVL/XuRpXEEirxAA6Sk2RK6JYvCtp4M3?=
 =?us-ascii?Q?cDRFgfVLbvbt104kzjwQBoMzBRrMk2853y7ibNRwDZ+zQGeE9DEE/7sYPTra?=
 =?us-ascii?Q?Te8n9SYp/yFVCyjq7RFs0hItCg5LgRN6jezqsJ9ud0+iFJJstBp5p6epktxy?=
 =?us-ascii?Q?tEA2XKskUUA5viYqwA6xjEgiPu64diHJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:18:18.2229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b60babd-eb4e-4b5c-259e-08dd15b564f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928

0x10 is the minimum sample period for IBS Fetch and 0x90 for IBS Op.
Current IBS pmu driver uses 0x10 for both the pmus, which is incorrect.
Fix it by adding pmu specific minimum period values in struct perf_ibs.

Also, bail out opening a 'sample period mode' event if the user requested
sample period is less than pmu supported minimum value. For a 'freq mode'
event, start calibrating sample period from pmu specific minimum period.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index a687ffb09905..cc58ef4d8de3 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -83,6 +83,7 @@ struct perf_ibs {
 	u64				cnt_mask;
 	u64				enable_mask;
 	u64				valid_mask;
+	u16				min_period;
 	u64				max_period;
 	unsigned long			offset_mask[1];
 	int				offset_max;
@@ -295,10 +296,14 @@ static int perf_ibs_init(struct perf_event *event)
 			/* raw max_cnt may not be set */
 			return -EINVAL;
 
-		/* Silently mask off lower nibble. IBS hw mandates it. */
-		hwc->sample_period &= ~0x0FULL;
-		if (!hwc->sample_period)
-			hwc->sample_period = 0x10;
+		if (event->attr.freq) {
+			hwc->sample_period = perf_ibs->min_period;
+		} else {
+			/* Silently mask off lower nibble. IBS hw mandates it. */
+			hwc->sample_period &= ~0x0FULL;
+			if (hwc->sample_period < perf_ibs->min_period)
+				return -EINVAL;
+		}
 	} else {
 		u64 period = 0;
 
@@ -316,10 +321,10 @@ static int perf_ibs_init(struct perf_event *event)
 		config &= ~perf_ibs->cnt_mask;
 		event->attr.sample_period = period;
 		hwc->sample_period = period;
-	}
 
-	if (!hwc->sample_period)
-		return -EINVAL;
+		if (hwc->sample_period < perf_ibs->min_period)
+			return -EINVAL;
+	}
 
 	/*
 	 * If we modify hwc->sample_period, we also need to update
@@ -340,7 +345,8 @@ static int perf_ibs_set_period(struct perf_ibs *perf_ibs,
 	int overflow;
 
 	/* ignore lower 4 bits in min count: */
-	overflow = perf_event_set_period(hwc, 1<<4, perf_ibs->max_period, period);
+	overflow = perf_event_set_period(hwc, perf_ibs->min_period,
+					 perf_ibs->max_period, period);
 	local64_set(&hwc->prev_count, 0);
 
 	return overflow;
@@ -677,6 +683,7 @@ static struct perf_ibs perf_ibs_fetch = {
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
 	.valid_mask		= IBS_FETCH_VAL,
+	.min_period		= 0x10,
 	.max_period		= IBS_FETCH_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
@@ -702,6 +709,7 @@ static struct perf_ibs perf_ibs_op = {
 				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
 	.valid_mask		= IBS_OP_VAL,
+	.min_period		= 0x90,
 	.max_period		= IBS_OP_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,
-- 
2.47.0


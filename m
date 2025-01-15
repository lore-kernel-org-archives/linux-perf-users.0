Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3A22F831;
	Wed, 15 Jan 2025 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920027; cv=fail; b=U+muH/772dke6gJIquBzgVbYZw0gpFDxILgpp2/mdnj+Yls2UOihGmDe3z8/Li/blg7j12a5RRpYxra729A51IhUU8MubPD9H2qBTCnhsyVcpXjDtmQnnYOujQQKyek0qCDWbAWznXyZALHMK0PA2XM5MnINtteUuou/IBF4UdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920027; c=relaxed/simple;
	bh=6DUSl3hOkhElUC7/h6ai+56QchQyf6WiS+ilpvkxes4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9O4Mjwy+NkKGsC6ArMIy1DgVyA7r02ik1wnI+ixhsDLt/+PEKTPVCvLmGdpFdoGrln/t3mcCQ4zoNV7EoHFZDg4fTkZ3DYACGJgpzhmltKTNgY2o3GJiVztJXTKCeYolKMk4Gy/bZrokvR/F67+ZmGaNu85UeNbctCVg8heefE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tzyznYVn; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tzyznYVn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDakH0fewlexn+nBJSMZ2SF1hFra+Ylox4Et0d2kH6a9L+9AjpfLu4CEH2MiF8ENN3Z1ADakj4XthR7T9zpvOKpnAFwR6ObcweZJVieiMe6ehkqG9Qcuzbx1SPLPdIaRnRXoQC/94e2lAKtm2axESsfI40PU9/bqk1D2cl6mSEIGxQymvbfY9ss/3WcfFDBfFm3Ox9VazOFlPzm7i+gHOPhFgX3LDmkIFx5KACZU1E6n+6p8wpbtUv09ZrCxLgklqmtkfrxZdpQ02AGtrULJ0PcqhS8eAjkS26tYpIkSanjSpcSl4IFdt7o/be0CUmF5YtYga9gYPisn7I9LGovThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OngcRt5TyTocHT4x/EO+sj96PqNmn5WHeeSVujNmMaQ=;
 b=nTR6yZqv8M5xgmb6MPKqApGoij4ce1Ik+AS2c2Nk+x9rucexLzX8VI/7NPUApXffSpHXtF1szF5Cumbuqfyg3uk7IFeq8fdP6h8XgfKyUIdWWdAELrQ8S/tmZhRSyqKSX50KNNe5EXlW+D9/nTyx47ohvobGfwElcEk8IluXmPTttpoTHvwcs+Hiv+0QpaiSZUPlGMKQ2eghv3CeGPKnkyirBM9TwTwCl5lSzicc8BDI+zRuAmjCRRX+FxJpg1R+AKEJy/A3Rc1hIxJgudsOudzAtjJIz5F6V/7No5APljYI5W04LAHUCT/TiJBYauuBm9dJ7F8menrCmnLvtt6IBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OngcRt5TyTocHT4x/EO+sj96PqNmn5WHeeSVujNmMaQ=;
 b=tzyznYVnnEnVaCJWEibJ1aiszGpbkyuia4kJHBv28cXA96CbBnvrJMimTRfJO85+eoMdPSJBHgjvobDqkDktCNV3lP5tGDeUAdDYyGx6usrFT3uuiHO2KscsuAHwNrlQNlY6Dj/zQWjk4bBhhZ+Wr39rGsECk+F7qVPulfJ7TI8=
Received: from MW4PR03CA0084.namprd03.prod.outlook.com (2603:10b6:303:b6::29)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 05:47:02 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::58) by MW4PR03CA0084.outlook.office365.com
 (2603:10b6:303:b6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Wed,
 15 Jan 2025 05:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:47:01 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 23:46:55 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 6/9] perf/amd/ibs: Add PMU specific minimum period
Date: Wed, 15 Jan 2025 05:44:35 +0000
Message-ID: <20250115054438.1021-7-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 648deb44-800b-4951-75e8-08dd352808cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FhiOEcNWppWB3VNVXh07JehDRgn0igXV1+65in+7FxGa4HFJfBRdzAuoe5Kd?=
 =?us-ascii?Q?UUPkZ4qqeWzxFfKrV71HeBcMblBA/6mDhKhlVt2tUx2Cikb6QpfE8+hEBY7E?=
 =?us-ascii?Q?tKyxekvuVk/4zPy5qnODsR3BYAVRZ/ULIjp8puJpBP/gV993tV2H2lo4Ds8D?=
 =?us-ascii?Q?TpqFPlyARo1P3m8nOs4FkNoU7g9+fKvX6tkpHpN/zBYYzxEkfhFjNurrbX/n?=
 =?us-ascii?Q?PzWMkC3+WgzkGKktO6lM3IngsdyNgckmOIUv/A5ureIiTmdoNYoCJxJtIlzW?=
 =?us-ascii?Q?/d2OSuhZu9zjVuysrzpDe9fJ1C7J49G9Jq0/x9VSteEPWibM8jpbLFBya+V5?=
 =?us-ascii?Q?JRMMO3lDRMs3fdO7Wo4XhsBPN57tuTLDiND95TELGZXZgEa2vv4Rg+2ldUrg?=
 =?us-ascii?Q?JcXg0tSDnXu5fbraNqJTPlJnVVeXHKkV/WJMsD6XOK9GjEQ9e5A0hhRK9PQM?=
 =?us-ascii?Q?pV/UOQtdN25eiAMdkMzJAXU/glkU83wVl2xQQTI4R7aGpbwMpndT4API11DN?=
 =?us-ascii?Q?k971IWueBLKB7gfUY0lsEbcaJYU5xUyKb2c/tOacCOQAurh0G4EMLbqSSUGx?=
 =?us-ascii?Q?dVUHXdkWln48+Vms82q3qvC+XCJDoSR+JDPuYvltcdWaNF4S2YNelk84V7L9?=
 =?us-ascii?Q?aNjNyx2K8kE6+73tgxBKWQn51vYQ7FG20A6ceIcvD1eV6dRTdzi+BtsdTTMG?=
 =?us-ascii?Q?zeo4bY13ASTV3t7sb1YCoqF9+frJ2xO/Tl/fxBiqDAIUIpUzYxLKVNJvq0Jq?=
 =?us-ascii?Q?43b5zDtbNUZunPwRsdSiHyAUg6vmM/DrWmBMxFDZ3o14ntn9+kLvdPvz4VnK?=
 =?us-ascii?Q?X7m98fWlCtogL5xCjb5G1Bt4Ys+6eAH6tbn087aYePQwSk+YqraTsRF1E2Kq?=
 =?us-ascii?Q?/fCHLmr+7HShcf9HvCVZN+HfUOM8rQUnq6I/YvbPQmqJVNRnPBJjal5yLSu5?=
 =?us-ascii?Q?LsrqEiCm10vIUQ6qQ/dT+tK5aDmqBboxZ4rjWHdhDL0LXuAqix49Wd5qizSj?=
 =?us-ascii?Q?Q2RMqaTLn4JLW8fSmeb5rXniGn88Bk+yS5GQ1LTyNCN2T5GLdFIl4Cl276wo?=
 =?us-ascii?Q?bHzipgDz4gp1IJ+t/yTGB/foqTh8yWZ4sJcvFECMln0ArPTc+mcoew4zk8/n?=
 =?us-ascii?Q?JUgUEIF4rdMVQWvPFeattm63AUohJJZY+km56VugJWYpfFbUU+xClLmrlxm8?=
 =?us-ascii?Q?xkMqqw0savH2todnK4QJirPdy4td7NB8WwhutHcbaT8K2w+F5664Lb9iWOyv?=
 =?us-ascii?Q?fovy/cdAMI6xUD3VTbaOok/5caOZ2AofHDqZmc2B+hUhVwRkXu1OwqMa4+QL?=
 =?us-ascii?Q?Grsj2xSJcW1k+R0E/ym8IZpZW9hUfNkh1lnZ+X1rDoy4G8qaawwaQ0k5ewPi?=
 =?us-ascii?Q?AeK2SBpQm3QWT9fUfBg8kaedR5DZV3cTeJs8DSscCcywyB1qZpRvBlzecrGV?=
 =?us-ascii?Q?cbmhrDGFQt+lZeREfFI8xuagK2T9L7Tyz3oIMcI9L/9gSYRL4/MqQ5PnddhY?=
 =?us-ascii?Q?10PyDMUpOyr2I7A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:47:01.7431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 648deb44-800b-4951-75e8-08dd352808cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365

0x10 is the minimum sample period for IBS Fetch and 0x90 for IBS Op.
Current IBS PMU driver uses 0x10 for both the PMUs, which is incorrect.
Fix it by adding PMU specific minimum period values in struct perf_ibs.

Also, bail out opening a 'sample period mode' event if the user requested
sample period is less than PMU supported minimum value. For a 'freq mode'
event, start calibrating sample period from PMU specific minimum period.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3e7ca1e2f25e..7b54b76d39f5 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -86,6 +86,7 @@ struct perf_ibs {
 	u64				cnt_mask;
 	u64				enable_mask;
 	u64				valid_mask;
+	u16				min_period;
 	u64				max_period;
 	unsigned long			offset_mask[1];
 	int				offset_max;
@@ -308,10 +309,14 @@ static int perf_ibs_init(struct perf_event *event)
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
 
@@ -329,10 +334,10 @@ static int perf_ibs_init(struct perf_event *event)
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
@@ -353,7 +358,8 @@ static int perf_ibs_set_period(struct perf_ibs *perf_ibs,
 	int overflow;
 
 	/* ignore lower 4 bits in min count: */
-	overflow = perf_event_set_period(hwc, 1<<4, perf_ibs->max_period, period);
+	overflow = perf_event_set_period(hwc, perf_ibs->min_period,
+					 perf_ibs->max_period, period);
 	local64_set(&hwc->prev_count, 0);
 
 	return overflow;
@@ -696,6 +702,7 @@ static struct perf_ibs perf_ibs_fetch = {
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
 	.valid_mask		= IBS_FETCH_VAL,
+	.min_period		= 0x10,
 	.max_period		= IBS_FETCH_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
@@ -720,6 +727,7 @@ static struct perf_ibs perf_ibs_op = {
 				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
 	.valid_mask		= IBS_OP_VAL,
+	.min_period		= 0x90,
 	.max_period		= IBS_OP_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,
-- 
2.43.0


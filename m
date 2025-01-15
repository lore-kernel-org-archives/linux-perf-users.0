Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6C22F84A;
	Wed, 15 Jan 2025 05:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919970; cv=fail; b=L8K0lJ+lkPWlIn/w1pw1iD46QWRSc7A6Ty3FcpO6tYQketz9CeCNj0Bv/foXCmWa4ZiM5Goc55W+lv3PnzP1oBKX13jwD+Q3SKbdeJWor1VcT9zP9j63tgG1UKmqgNRPzhC466JThcPXFp4lXMJK/3v4JVRBaE7BwsIynlepHdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919970; c=relaxed/simple;
	bh=n+HWv0Q+pOPhcb+PfllJ8UIvXY1SnYjH6JA531VqVu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bakXSbxbpH8taij6kD01R43o3Z351btddLIe5uVPYVdzoVeKg3Ti7sXdJawD+zZ1uO/Ip646PsCygyiGbQxqP5yXkq0rnsaxBTDxi4LI71hP4Nxkqu6bKzjYsEYRTphcpL0gdEn20zrAC5DHFjrPbB441+g+Mkul3W9rSf1bDyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gFtYpGoi; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gFtYpGoi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6ddSmXcRwMOIlTANZhrlY7FpLASFusYpO7cJhBeBT7dgSndOa4SGzi17StQo+G7EMvd05zczLXmJz0pwYWaddlWKaxvHSNo5b3xlfoC+wuxX3ZzUCIh9tBWgqTDbqAmGXxZ/696vcshKT5hhK5BbXdbDyoLJdSbXU4+Q6He339dv98x/TwFgD+eNIievz9PUM5p3CZF2GMtww4U9HMfOwBusWqavzhnQtaOesWDhnBqP97Qdy1XUlHIS7UPsgaDudEmQhFkzE2tCLIdGxhZ+EDpJsgsGxDu1xBqdp1XZkL/pEc0rtxqyn1InYaiJ8CPX+x71LprHHQPQb/7JoeZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7prG4ufdRXruifM+sWVwi9X6Ewy6VrtxiBVtiq7/Y0=;
 b=dxub7NCcPTvl0tNNtLQj6wfks8PXEtO+Pqkx4QzQ409LNXvLkBUaeZVf52k1alW7nOo4bT+wClGaGkd3S2tJ2R7Kt9l90jG4VAvvv6S8BjNMPuxezXRL9HnOo2d8KjDPxWBmsvux64pYFhdAeywi9EnQQzLnql6uPf/GRUsAlaOoqBHU83jEhXFUSu5n3xA4mQrYacmXLyXJeULhg/aofq5k1dWKLjwIYqWxKZne6BFu2iCgB9aHAXM8guQxighsUxZEbL2h1wVW0taeMHy1fSuQD9yB5U3GrtxUCNSmCshDpdMgfAmM6zs/9MVelsb6gv7ALzdlTjlGurkjGPJ9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7prG4ufdRXruifM+sWVwi9X6Ewy6VrtxiBVtiq7/Y0=;
 b=gFtYpGoib4Z1tH9uEG7PJ0IIxFMUFFf19XNfoummeXhIrx0DrYtu8euWHcDzIkgim/6m/IFc/5RF5X5CqsUAe/CxI7FTJcA7b1SatDDXV3kTEakuORby4VIi9UfJldV/ZykHvJQWQcx6IJN/47pqjsmZ8L02GNm/6o5vSQTIgXc=
Received: from MW4PR03CA0069.namprd03.prod.outlook.com (2603:10b6:303:b6::14)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 05:46:04 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::f) by MW4PR03CA0069.outlook.office365.com
 (2603:10b6:303:b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Wed,
 15 Jan 2025 05:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:46:03 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 23:45:57 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 1/9] perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
Date: Wed, 15 Jan 2025 05:44:30 +0000
Message-ID: <20250115054438.1021-2-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 9615191c-639c-4523-53e3-08dd3527e639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8cP5SOcbn/aeIQ/uc9tCHLfs8eh41EN/6mRYC3hhRdwIR06Utcc5tA9rOTJP?=
 =?us-ascii?Q?J6n5JPXyDgnQjyqRyC6/w8qCKl0jlBfGJMelCt35iXuwhLhHia87TUQbcYbP?=
 =?us-ascii?Q?SFRXhSsGLgqSpFWduixqNgD6l1bLY4QTRfVWG0dC0KNiRX7BTLzG4gMK6XAf?=
 =?us-ascii?Q?UKucy4RekWRPe9zaNZZn+0XQBxE1m4sLvKXjSY/IeUkFZ2gBK3g1Z/OcxeRd?=
 =?us-ascii?Q?q9VBQkuToBvVwndnwloumXPIPq0M13WzkA1ieWT+EEmvovMR/X5OW5ocSKc6?=
 =?us-ascii?Q?jZG01E9x0Wt/p7KvDO5/Fgj73nCeQ1GeJBgim+L4fTOZlKh2VC1MKCp9DkPa?=
 =?us-ascii?Q?xn+ikPJAeaF+1/nsXUfAp4V/MDN0Ae+ToLo/nOeWwu/oR2SQGMfKAcJKawqV?=
 =?us-ascii?Q?0kYtzpk7ihWGKV2lE1txZVtO92fExbKBpTy+vyBhLP26/dpvMRLewwI1q/Dh?=
 =?us-ascii?Q?Em2WbKJJKyAhfpdytxU6FDo9dmNMXJrQYl+N4fI8WpLIOKeUHggv1bggDJ/b?=
 =?us-ascii?Q?uUhwHYKV9Mb3aq8E4F70Oy1a02SjIrifONX98FJdggQgOO9a2dObePWN23Pq?=
 =?us-ascii?Q?ceDvf1/DL4MvbiaG1uNS52oaPwaxL2DVVMdh6qwnB0gcosLpG/TOshKcQ25a?=
 =?us-ascii?Q?dvdcIymuxypYFtTcEfHaeGEgDoX5mgYELN0llECfG88D05Tik7z3UYp+vsar?=
 =?us-ascii?Q?KH4rtY3h83fa2QQxwfAgGNx2ph4544w8MhY/ElFOxI2ivmaEnaHJkYBUgrwV?=
 =?us-ascii?Q?IcaR296pGTAjOa6hNwj/oawPSlczl3mtDArQPoTnTve+vNrP6pspejrxoQ1j?=
 =?us-ascii?Q?epXoTpMiDliDyRmuVBd4WXc4nPgTnpfav2qiRo8RhfHzOKXdP7ua0DfI/wtv?=
 =?us-ascii?Q?5wWcTQKJ7Qb2jyEfCsFJ+2dH7cf5cPRB49kQhEb6zbvxrJLytA7XI2vAZOha?=
 =?us-ascii?Q?Gi7kG9kRLHn/rEqqV9cFAthWqFWM58gd6VTJevLy8/YCXhNAMtYC+01kgrvt?=
 =?us-ascii?Q?OqkeynW9qbDV/+JCnYX32M06TqooP3XBuo+zOgQH/wouG/vjnt3u18hx/1yM?=
 =?us-ascii?Q?t4kHYNg6TWo8Qp4129vZqaJpG4TxTB5z7eaHq33dR9KkRMjp+10dttTgMqPf?=
 =?us-ascii?Q?7UllEaAEmwnS3e+vgsf8K9Mx4eHW8FjKeKOs/szZ32wIM11yLmX561r08isr?=
 =?us-ascii?Q?GpcjKz8qDAO1HEVUvSdnDWKR7z2Z4XIyhvliPt5OYrmPYphCCULvJZ57kLf8?=
 =?us-ascii?Q?hYfbeqPMrZ4ZWulQYQ2Vx7KdaYu3tur+tEBTBGtMfgaYT8iCcPfj506tuCW6?=
 =?us-ascii?Q?E8f/kOdTKgdpHvxJnlseyLRWYZBRbHp8suaMByYIIt0F8yhQtN4pFwHx31nQ?=
 =?us-ascii?Q?8AZ4bcFjfQ93LWfCW3P14W3SOg+ZRSERsyMYS82qUNL9pT7QgY6D4KQy+xCH?=
 =?us-ascii?Q?k26KysWfj+n3N9TI2++sYUuDadxOdFVyOVtWdEUfrsGwNvFEnvqKizX7Qb69?=
 =?us-ascii?Q?w2Dz8XfNn6asV30=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:46:03.7429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9615191c-639c-4523-53e3-08dd3527e639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661

Definition of these macros are very simple and they are used at only one
place. Get rid of unnecessary redirection.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e7a8b8758e08..4ca8006d2221 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -28,9 +28,6 @@ static u32 ibs_caps;
 #include <asm/nmi.h>
 #include <asm/amd-ibs.h>
 
-#define IBS_FETCH_CONFIG_MASK	(IBS_FETCH_RAND_EN | IBS_FETCH_MAX_CNT)
-#define IBS_OP_CONFIG_MASK	IBS_OP_MAX_CNT
-
 /* attr.config2 */
 #define IBS_SW_FILTER_MASK	1
 
@@ -688,7 +685,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.read		= perf_ibs_read,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
-	.config_mask		= IBS_FETCH_CONFIG_MASK,
+	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
 	.valid_mask		= IBS_FETCH_VAL,
@@ -711,7 +708,7 @@ static struct perf_ibs perf_ibs_op = {
 		.read		= perf_ibs_read,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
-	.config_mask		= IBS_OP_CONFIG_MASK,
+	.config_mask		= IBS_OP_MAX_CNT,
 	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
 				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
-- 
2.43.0


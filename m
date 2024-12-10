Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A5223E9D;
	Tue, 10 Dec 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823330; cv=fail; b=gFnXkT5rtNEhRvkSxxxJOUtP9QAUgt/UWrzmZ/2CWtR2jpUpoZCAZW0bwNu3zHY5hiimXdvTUSdS9Er91g9nbyI8sePgji3htlS0rkb6WKhmsUtbEzlhcGZzptpYsydST6j0dG1OHp4FVvn0wercMELh1V4tke4bpDsYiLCXNGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823330; c=relaxed/simple;
	bh=n+HWv0Q+pOPhcb+PfllJ8UIvXY1SnYjH6JA531VqVu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLldAAFbthmcrZ3HzXqrERGGFLthRUtCa2LLIFApG3rqb6ZMExtqGqLAbx+K1L/e4ruI0xfob1M2COfUjterczmHEWA0c1b125h7NcHPKiUf886ySCugB+g1hfuTgkd9oSJpd51Byu7vegE2/jsMDNwBH/9Zy8b2TgXExAs2uts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FQyqYQXL; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FQyqYQXL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AovVjFDeO3GV2RhDyB/l0gAw/yUZnbihzNlgiAstNiEQwoR1bDcUb1on5pkoh4plWW9sx9pfSgB5WMv9StgGUF1manSmFQf40epmjHHDOTWmKhyhaqB91hliOopy8wYSjCQIwQtGJ8TrcQAw5X72eNdJI5w6B+LNzsdd6ubzeyXh/GuIL4BlfnHCudniE38zextggW2YoxQ4YULhuzaa1ZaN/8cVIT4vQ0Rw1/9ifsTp+PVwA8BqAxCGeVFiPHHvBUaErC55eziwjAf/VQwYkgXiUuMyg/6ll8+kzjYK9P/ugL8XnVf0VkXDgF6sMRqScmX55cy8dyqXH9aCLwdNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7prG4ufdRXruifM+sWVwi9X6Ewy6VrtxiBVtiq7/Y0=;
 b=h2b/CSQ9UZN+d2aoBlv05eRChe3JUuPClq0nk+u85qucIa7NkagDCCobLwNL9kirArdAldGfXINwkGixkV2lq6TLGPj5RWFcArn2vrbxxJMYoGQP9zNi2Wdd+Sb5HrJs1bfQLAcB0MBjmbWvOk4glkHHSrEIoR6L5BRsY9E/fiTUGc8Hd/us+v+r99r6s6sVlEOjKCGOd1MVduVDQcPZ4wiUcKZNGsGWc2JnOtEOwtCJ25oOPZ80QLicu98sAR5Miud5XUNQwkcWP9zUBHC5pnZKfoNLyKjlO8q+Sh/Xq4NqHL+duz7/v61GjQ5IddiuGWltqSX5LNvSis+OinJGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7prG4ufdRXruifM+sWVwi9X6Ewy6VrtxiBVtiq7/Y0=;
 b=FQyqYQXLEqpI4v0ACpOxE7MRc5LV+hdDbZxhucDeHceQ7EAK3wozIOMIkZlykbqZ9HSBkcV5SvQ0IbBCdBna5HFdNOT0WPtINhreHPBSZ5k8FJCdZF/F0VDCEsbBO/N/EwV88uD9RfnPO6H1A8aBa9gz3xvyTRNiHN3fjBdpXWE=
Received: from BN9PR03CA0890.namprd03.prod.outlook.com (2603:10b6:408:13c::25)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 09:35:22 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::3b) by BN9PR03CA0890.outlook.office365.com
 (2603:10b6:408:13c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 09:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:35:21 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:35:15 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 01/10] perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
Date: Tue, 10 Dec 2024 09:34:40 +0000
Message-ID: <20241210093449.1662-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210093449.1662-1-ravi.bangoria@amd.com>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0f3eb8-1670-4cb2-f413-08dd18fdf761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b5DRW5DIt6ieR15n8uB7djz3wheakq2UwTGEaw7rjqPY54Lw61zsW7itE0Xb?=
 =?us-ascii?Q?XaTUWMEK40vRJLh+MOIweE2FLkJPk9KcEnhE0Up951nr9XqOQyttrXEANED0?=
 =?us-ascii?Q?3Zz54SUIzzqfEG1BEC/Jq7Oa62MrjXtZi0e0mwuNH1V2OddjwBiiUp5RDlHa?=
 =?us-ascii?Q?fCphqaw817WfzQQc9nYHeBxlEwTDe4nSg+K6dG59DeWIx/VDzRG9oPz66zJh?=
 =?us-ascii?Q?MNLSr7GNh8NNLzu8XXib356g1wLpWDojiLD1xvTqm8hbMiOxst2m1pevvHKT?=
 =?us-ascii?Q?g7WgASZRO63F8HAKVCB0+xcC9acCDa0X6Ef0h0JHLEQLY3c32RTLUs9mIl3b?=
 =?us-ascii?Q?ZbHCHAsKdgNbNj6BFFOMD2y3tBRf1i+Kta7aKtc0oRVHjSnWlDogniOjxTmL?=
 =?us-ascii?Q?r/bHL1jv++/DE5QZj/dJdZkwmsEj6mO7Qj+9CZx04YTO2BZcFPvD3FrBePBb?=
 =?us-ascii?Q?MXt9/UVPALrcoiH8BFGs2VBf2I33ey+zz/Ns66OsIx7wK8d5YWVL+uxuRrKL?=
 =?us-ascii?Q?qXRBraHZWri1kIRMH4pr5bnpCxbv/86tQ5d1peGDVrIPekd8Z+hGeDAxZuQX?=
 =?us-ascii?Q?opOcNnJiEtftNKEc8geDwID2PipP/nO/nc3vdc3ve42FuYXEhvcw29P+enQj?=
 =?us-ascii?Q?qG4Rbqvv50zvCNxCHKczxBwaaqzfXa55vzjjIlJ53cYlsTNqQ1rlxm1oKb1t?=
 =?us-ascii?Q?2qkb9lQW318nDixX2Ul5vuUhEGKq/nqqogxMlmAGizewvf5pg1NbUCDgmL/M?=
 =?us-ascii?Q?TVOrNEKLvcVLB0dWc0oFK2nlziWi3xQQt9Q8uc6YV16azLsTQLmzSeHNalfv?=
 =?us-ascii?Q?Ip4sLMdVNHtAoJK+T6hWgecmp5qNcCLf2fPq1KRAxNOp1ynGGfwYVJH66u3O?=
 =?us-ascii?Q?D+WRXVI3jAd4GSIa/OQ77g5HGnHjWjaFIrPpHJuWJnvo7QecmMmLraemdrtu?=
 =?us-ascii?Q?IQykwidQt+6sZvTaEmXUEcXqPhfyCfYhcoxPtIy2+lzHygGUi9XjyVUZPMQr?=
 =?us-ascii?Q?x5Q/6C91xUrAfPwqXELYcMxrQSZmINdyYCvUFZ+4Fqd3LftCPqxQZlbduV5q?=
 =?us-ascii?Q?FdLgSHaThlPF7Ue/dsElmlQ+Tjt7p3YqXY3UPa0xJlJWoRKFPjoHqoYsSaul?=
 =?us-ascii?Q?a2vzenLvJYqpLozwPMDircojZuJ7mk+teBUc+J0A3L9NAhA9Khk2Me3QkzRv?=
 =?us-ascii?Q?wKrvWU6VqIXN12OmtiNPMyhNJQY3MmR6zqFBByGIiuFng/5HZcxD2OfhAYXo?=
 =?us-ascii?Q?jASsLKlKs8Wp08MuPz9YK/GGPPmdXE+Y3oVyq8GrKy/T0yIjP6P4r/762yn+?=
 =?us-ascii?Q?70bab9qZKSfeSeUDPqEZ6evQsiNDffD1Fmd7V131AtkLFDEr2Kp79VrGTx94?=
 =?us-ascii?Q?fl4jj56ZgJAv+R+Mmd+wyHOxu1tNFJGlR1oTaPlELCu+skJ6O/bBamiXrIUM?=
 =?us-ascii?Q?ckoSOoPAtJMWY3VY6ApFbAajNz1bT+Us?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:35:21.1881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0f3eb8-1670-4cb2-f413-08dd18fdf761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

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


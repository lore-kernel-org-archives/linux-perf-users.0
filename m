Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0B198A39;
	Fri,  6 Dec 2024 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462265; cv=fail; b=GVzYjuI91RgAMOPYQcBs5L0lHhwaAY6/kddiG7WTByXakYF392yKr3SdY9EHvSeXfyvpoH5pq4utQZ5sgRsHGGUkGsm0YVTDmbzhESOCql/BmC0JzLmQ7f0kanSXBcn0NAfut0oKhtr//ebSp/D0Rr/J4rc6sYTI22/ldQS4U5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462265; c=relaxed/simple;
	bh=7RgHw3NPL3/t0hxSBG+x85S9B2vc/t4gfkMccMh3ubQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEkzFoUpFN/8TnSz1QsHRIeTgQhoP6hp1H0Qp1SqZGE7w1VS4Sc+pYWO+Lzk9LHHoIcrfZXrR7y02hJeUB1Rp7JDstaJP0UFp7m7L5uZUSA5TOPmqdy8H6fovahmQMqrme9eDc3AUv0hw9ew3t5tbaByOwJOj9mBnyXx63o7qmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Wp+0NYG; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Wp+0NYG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUHjuyGw2P+LEG9LP2Mwd2/2NNRQDwkOV7fL4bTMR576gAGGBLrh0PX8cFQ53B6eulVZ3Fk0QfKIcsaKc562pEcHXl/r8czzqj4GZhvSy1SOTkD4R921LLpaWuyER6pOhN0nUTtdltc1hsRjLkux4sxRxzF5EU3JzgsMD2fwizstI5rD5zjjNi4/zxGK7mdeC2RMzJO2NeM7oaDhwGpTYIMtCz7Z7HSg30JTMJXfyRnLsNwby8++U+lRuRDYSsnaRfk3C7eCoZa3PGAdwq0parNrLkIkVTAwFrDg35r9y9B6r+xK6QbmTYhRQWBPalO2PRMknQKSfnT8e0yWHv/Ljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2AxjG9VKqRNGQG0rKr4tUn/LRUut0cum1WoSRf2UBw=;
 b=snJYC3tB2HRQ2Ubn6VsS72x5jQfe7osEF2GB7q0TpVaSdB4FUVLae6aLjGHXElUVssQtSZOeF1mLaQ/pQyxC5tAl9nq+2sLOCzT7Jlfeo6IN45ismiCGTu1JQOZTdj8DOE6vlpspsyUma7al7huWLO44/khy1Xk5zQHJkv5jdrmh5dfcn6k1QCJl+Np+Z3LlrhTFvb+nc8u/dQ0J2ErVQvCfco4ca9Yd5+9IoJLOdxsIrGcpfVsQguj/n7MZ2lZJtSIpRKiFjnEtTW3PCtVFtGJt7cGKo/lRhdSKFoMLBymdoPeqVe6WIWw2NPHuCw72Tc1n89lF7pXOlD5uI6T5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2AxjG9VKqRNGQG0rKr4tUn/LRUut0cum1WoSRf2UBw=;
 b=0Wp+0NYGAMi5xeNcK11pr86/xnNMY3lC6EcMy7Swk//BU6OMiqpYbSe5BZnvX0YIWDAX5R7+PMqRJ5PJjGdWV7D1anPKnRXuCIES0Rw92h4l2zPBeSNIkjjbYke+zl9+lYonazow4+62TG9njmX5Gm9t612HldK0miQcKNTs2YM=
Received: from MW4PR04CA0114.namprd04.prod.outlook.com (2603:10b6:303:83::29)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 05:17:39 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::8f) by MW4PR04CA0114.outlook.office365.com
 (2603:10b6:303:83::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 05:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 05:17:38 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 23:17:32 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 01/10] perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
Date: Fri, 6 Dec 2024 05:17:04 +0000
Message-ID: <20241206051713.991-2-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ffb0e2-7f80-4364-bd76-08dd15b54d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rh/z5X34CJEHGBxl5AALwoIKkTD1mawqA3vyLIcQf4Wf4aqTZP64ECUBZEER?=
 =?us-ascii?Q?lvD0xGejbAhEZQSoFaXfs/1QLJtLLS++YarmD6ERU3HFNvtjen1maYwd/unW?=
 =?us-ascii?Q?zsS8h55fa9BgbCjHGUrZrGgVQaiXh9dUJt/h1mO2gLJs76W0r4YDQ2eGCD6y?=
 =?us-ascii?Q?2kYgv73kIE1Kwc8zJo7phiLiX2gLJKnGwGiI8pxJfsKVcucCEGZMzjG4ZNz+?=
 =?us-ascii?Q?+D3ccjxeXhD6usaRDIJltsL94bAkuE5a8FVwetQF19tj1XhuqQzowFzB0tXq?=
 =?us-ascii?Q?sn1AZVX5DEjdBtPfD6WCRvctxrnBrmyjWq3ztiAu22RAFBauVwyRmypwSm4S?=
 =?us-ascii?Q?xVo/d747QeGE08ZbyNq/cOyhAJLdMHMmTBnb7px4RWOyzSrcjzCog7G0MXck?=
 =?us-ascii?Q?2f32MrY1xxA5ud1StiOsAnBdxgeNy19iE9w7rWFu7Wn/MZUrZ1MoRijbuThj?=
 =?us-ascii?Q?aKFXmakfOo5wNTykDJwSP4Et2jIUHLbYL0m08JtEWqoEFTR+Je/UQ6exzgac?=
 =?us-ascii?Q?axCjEfjz6/SVh66yXaUk5o0DBlw5pzHY+Uqx3d+xB2MUw9ifsfvy8j3hLahP?=
 =?us-ascii?Q?9gKqUt4iu9H/V1DOyT1dN/cJFKlNbu6nkQ+/+mQb5xXYVRQqu4fVop/nE3JK?=
 =?us-ascii?Q?p2h1XW23kYOv+lRwrVvtTfdc0ru04do1JBtUQSE6JKhkLL6gMCxnGafRP7+B?=
 =?us-ascii?Q?PJbcM/ixaHqvmRoXBdKg9n83hxsiSqrzbc0JhEDCAGPy6dY6ROWz45wLtgNV?=
 =?us-ascii?Q?UCpIZfK5kbdFLaqSXoy5B+Mix7fzp7fTE8Dbj0oeNXKmR37G4RmJQiaGPkKJ?=
 =?us-ascii?Q?Ch6SGOAcxI/JSxHJZkcTGHXA8htIQOpeYebbzXS0PWh5v8eVHufTe1gypX2B?=
 =?us-ascii?Q?lM6URyWfSKqQUZhaPKUjdZHlxY4zDoWUfwXMo4MOEQ3WZ4HE4PWG85AOJ9ww?=
 =?us-ascii?Q?1IDlfusnQNHuPFEKrzBitiZzLKrL3wgvKc/gUQaxQpZit69XKEcMQ4or1lGn?=
 =?us-ascii?Q?JNt4mq3vB7qE5N2bOFFxM2xQSd3YE7TpVvDchSMJwBoR3Ow7Re1lmJ94zJh2?=
 =?us-ascii?Q?3GhvIaw0N5DlpA+nz83xqNnGotCeS6nQ98MbGzuPcmsQv6JWZ6f07SWEQX1S?=
 =?us-ascii?Q?JLdNHzSrwB1yG5bXVtGIIr2f829iekZy3A8ynlQmGqQ+kt1KNLf57nOSmy+4?=
 =?us-ascii?Q?jbUO1LTZ5o4FAEGOPzzA5F1IeBdQBJztH/HO5tOTpdKSC2OgX4moJl/KXxhd?=
 =?us-ascii?Q?KqswrrbiKq6rNfus7KRIatjXIva8CfQPnU8q+eB/hXvizLjU9GDf+zfFRdQ6?=
 =?us-ascii?Q?Uh8pLSa8btELodlOnFyvm4lbnoTPiFosmLErieTpwFlT+MY8/negLQ4KijQC?=
 =?us-ascii?Q?EiDHGVslSlA34IwMW7U6V186+zRGVbatynhJIxY6IQOS+wkjxpXz6/OnCFbu?=
 =?us-ascii?Q?5VqsRDD1Zt8DJ2f2yk0NcN6z77eUMpmU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:17:38.9939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ffb0e2-7f80-4364-bd76-08dd15b54d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

Definition of these macros are very simple and they are used at only one
place. Get rid of unnecessary redirection.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index f02939655b2a..26dd5e5874f9 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -28,10 +28,6 @@ static u32 ibs_caps;
 #include <asm/nmi.h>
 #include <asm/amd-ibs.h>
 
-#define IBS_FETCH_CONFIG_MASK	(IBS_FETCH_RAND_EN | IBS_FETCH_MAX_CNT)
-#define IBS_OP_CONFIG_MASK	IBS_OP_MAX_CNT
-
-
 /*
  * IBS states:
  *
@@ -670,7 +666,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
-	.config_mask		= IBS_FETCH_CONFIG_MASK,
+	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
 	.valid_mask		= IBS_FETCH_VAL,
@@ -694,7 +690,7 @@ static struct perf_ibs perf_ibs_op = {
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
-	.config_mask		= IBS_OP_CONFIG_MASK,
+	.config_mask		= IBS_OP_MAX_CNT,
 	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
 				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
-- 
2.47.0


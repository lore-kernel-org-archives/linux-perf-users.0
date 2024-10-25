Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8A1F818C;
	Fri, 25 Oct 2024 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854880; cv=fail; b=cbPS2iO8S5hNhKQr65xZ1DWKBWhTkNn7MIAPyUNcLFwkBOirDjnETQFXrdZ3nbp8teus8DAuCjn9SL+11vo4ukcBG+xLI9ERK32fPec19lEb0rmI7wcNTuxqlTJYhG+CzSRGDHNlytqmpzRXBG8j5dVPPbA3lwhuH/leC4iKab8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854880; c=relaxed/simple;
	bh=9Nus01Y6Sj7VftrizeWy85Vr7MbpELBgcKpxf8CZddM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/qjIrIWcvAEmUnF1dBHBYD5G1Y04Oe/9a8ssFPKNNuW3LkrMt7CRs0hDvg5oeNnJ5Ll52gkilK4VoLo12jJ9WUhV0/EtvN4a9IG8Muv1pIbAtMPg2hezYs4I84oLHZPIr+ECEyrxL4D8mzzj1DKe2TZ3Q1gyz75IjKZ0m9MC04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QjCzYQ0K; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QjCzYQ0K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnrCEl5bHP/stAyEiVnzMk4D/hC1i2xmRieWE/XhIJkf58jr4P/pa0nw5zC1l7fqkNBE96RXGNVdYzVUozFafZzatQqjdeKW4XfSgt1VqAEFPlj38e0n9lNbObyc3mb+k2jum5G8PtGTxBpLzYggT3Pb9jTiC3EtDqN0zgwx2+OlVmScjNswF299NYwiC0rUcB3K2RbNx/LjqRQIt0ftjI8O+dKQyuvMKtzl2VMFXJEoQzAPbtnc27Ej4bOxKtty+V8qSj7PDBfimNVoBcIFB8OSYV5Y+YKK1IbLThSLaB4NtEEGhxuzF3gbLsM15nNmw8LgkFIxjTjZukYMtk1RlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT/VMOMDJVx4XVQB3f3sGXqkV1+5ZEhgKuipvGneiK8=;
 b=jFwweQSa72U/vXg8QHVDTLUWDxc5sXzd+W8qonNbpJvFH9n3C++wLb3sFEwBu9tkKZPtSV6/QZz+atF6eCYEr6TuMLxzd+uchK7YMEps/HY3bfj6/ACb9DmjyFVyWJejGfxSXB6dxbwhB5xIhLmaarc8ppL0ODlJ0SqJmFmbvTfFEM/hGkBV/l02CV9Kyu0I9FInEEBVVjf9Y8cybLetjer8o7Kb3pBqWSSrf66dqudAhbhXBgRflp6/opVGWvLzDltuFtxMVZPuuNXPEoUFgqxbqNPM15sn3ch8ReRWvYcxAA6wucgt4Pg+ydA4s+JFK8YsvqifihIGQnNc/aamlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT/VMOMDJVx4XVQB3f3sGXqkV1+5ZEhgKuipvGneiK8=;
 b=QjCzYQ0KH01x9cE43hCiVGVBMxNuSe5/0FcbtwKpSDtlIJHkVUeFab8y0j1iGQ765ARs+aeRY/WSysCUEjOcgXA5vUeuA6NOnHUecUXaZMBI1W6UOeEjYDkaG5cZedHFjwZr/ILTlnouNFczjdMBaFVKWIEYGKtAxbxERWe6a5k=
Received: from BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::23)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 11:14:35 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::1b) by BN9P220CA0018.outlook.office365.com
 (2603:10b6:408:13e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Fri, 25 Oct 2024 11:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:14:35 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:14:29 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v6 01/10] perf/x86/rapl: Remove the unused get_rapl_pmu_cpumask() function
Date: Fri, 25 Oct 2024 11:13:39 +0000
Message-ID: <20241025111348.3810-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c2c5b8-d765-49b8-0b2c-08dcf4e6353f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dEnTSX0kFBLZgQt3BVgS0yDWjN/3cjBO+D/PZ3bTmP2/8jZ5a2C4mYKBpWBm?=
 =?us-ascii?Q?vgX3Ns9h26119Mz/DKbmhuVYhLWG+dMSnpf9uIPcLYh5xy15QCyYXj07ixtO?=
 =?us-ascii?Q?ZqtQ0ezEBX5Qy9jLW+5ewYaiKFmBQ8uxrYSeNH9Xx+Lj2xffuNtuMfsNsA7w?=
 =?us-ascii?Q?1udqJM9YeYXi/4mx27GsBeyVrTGUrukRMcaDP+drT7SaSzAKu7W8A4exYjco?=
 =?us-ascii?Q?BlM7t/cXvRzoCWzjVH7PXKIU3Nk58c0rtcvA5VRCpnPCBd5kyumYgE6u10Y1?=
 =?us-ascii?Q?D87iyinkRAmm/O5cakPkp/iEuwFeFaQSQqLGp5VCij7O1ivAzryl5BHssgTt?=
 =?us-ascii?Q?VgSXX8bCAmacC5olpLS6kNhTccR6436isbRXGT2+1/W6n3G+iTNumoNnGXzS?=
 =?us-ascii?Q?V0fWJHBWnwrNOFFf0Hn0qRSxo/eRdlOcn220u6oZhr8bN4CCwuRx+nXT/kpv?=
 =?us-ascii?Q?S3pJjQ3mhklPtRxbvMQMDOJJPrT2Ebnus7QMusi5fT3miz/lZ7kU16FP/suz?=
 =?us-ascii?Q?vXmj5L2BZDrZ25VKE1r0aMpm6Mf3Sv1Qo6zzgd+984q6PWwQd7eevp6rgh8t?=
 =?us-ascii?Q?BFYcRlQ6cAxEw+Uk30YxWUAUQAIjjSiYhc85LD9VmHRnhdo2EITN2F1StKB3?=
 =?us-ascii?Q?SHgQHuty0rjK1HsF85g68+/H6TJS7HeK0kanEu0tmH0V6pZjEh1C5wRzi9SP?=
 =?us-ascii?Q?0GUVPMIcWxL/5/oyPiUMg3QMrKmyaGpBQNFxNhKWI534BgP6yKHie/LpU9eH?=
 =?us-ascii?Q?O881aaoRhlE3DNwTnQlxcQvr0tfCuIe4MUhcOORztpq+GIBMOmgr+b6LiBRs?=
 =?us-ascii?Q?8e5lvvWFkMgJW2OqZ3dQD7jXCX6gvowcuySGlOfzuP8gLHEb8ux81DRlfOgD?=
 =?us-ascii?Q?xn5iu5qOTB6aSbh3dLNX4t41Q9tWlxVEUtLzpCrxGUaEt63vdEz/vKhVVO0p?=
 =?us-ascii?Q?YiglUuVbY/fXmeJNoud3eQ1gFenpZSKTXvl/NL5mnHOY68nAgaXq4A1WsmBm?=
 =?us-ascii?Q?lhNhsiWy24i9uRbvjUAMr/i/skm3RYBnZZqEY3978Hfj8tqGnXYc0iCtvjjn?=
 =?us-ascii?Q?Y5w/5RrFO+71n9hudtxMDFqBN0Q6JDeI7vB/Dl1F86nx6Gwyjz+wWVrUUnec?=
 =?us-ascii?Q?dtOHE/H/9OhkNeDu7qcXndS2MQqW8kAjkba6SNBAC+NsKF8DTL/SrifxSBG5?=
 =?us-ascii?Q?/rtnSpaDG98eMIsZK7vmqRa3haejNgUAzuTaTJb4AkvTYBYaEQjD2PW/An8R?=
 =?us-ascii?Q?S/zPR3ZZRoRFEkg1cMgZtuIBTjsCoVK+0GLzPyqMbl5gwhgyRGG/8S+g5qet?=
 =?us-ascii?Q?Rc8htbTCXNJ27PmAyCKeUrmQMLAsplCTBgEp7npbR5TWEgfm6DCYe26tZ1+3?=
 =?us-ascii?Q?inVvh1KzIU1GbqdpMQez2E4Jio96R7DAWlvK/dSmhV2BYWPfuRazLLiJ88z+?=
 =?us-ascii?Q?xBC2eZLr7tM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:14:35.2122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c2c5b8-d765-49b8-0b2c-08dcf4e6353f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

An earlier commit eliminates the need for this function, so remove it.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a8defc813c36..f70c49ca0ef3 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -153,7 +153,7 @@ static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
 /*
- * Helper functions to get the correct topology macros according to the
+ * Helper function to get the correct topology id according to the
  * RAPL PMU scope.
  */
 static inline unsigned int get_rapl_pmu_idx(int cpu)
@@ -162,12 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
 					 topology_logical_die_id(cpu);
 }
 
-static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
-{
-	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
-					 topology_die_cpumask(cpu);
-}
-
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
 	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-- 
2.34.1


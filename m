Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BED1E25E1;
	Fri, 18 Apr 2025 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947876; cv=fail; b=XX2pqR00P7QAewAMca06D+lP8TGjsFadWFGVnkiZ7G8vrVUfVll3aqMjOknjJVVBHXbOOtkBOcwDeeshMOMJXpSZQaghn/Fz++NtD9EdlMrUHUxyu2hEmDNYqP4VVimXGov0xwpK4XA+5g9mQYqFAfBU72DFcaveU1pz/EFd5XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947876; c=relaxed/simple;
	bh=00/zgUApdOj+61DBAtXEe52ASv0dbTS1Kge4+pVHzsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLxdoGLZebtRfBgL6aQdl9Aalc6606Ts7ZcRdWbV/yb/cQsiwLGti2YT3lXPiwgTewsrngoFIAZEc3Ra862ubQuHf8lrNPC07RZBCO7j1H+e4bQl82b3zffPFN1dZzUnyUVy9Fi3DKZrJ0JfPy3JK0LB7Q87+FWYbDbFmHvQrWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V7/EEeC7; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V7/EEeC7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSwvceg9MiqjuGau+gxEnK9eHTeDEM8opq4mc05rRqS4Uhrom46o+eauFIwwWEZ0IUtzR1jZzdz2is6ko7j/55lT5KRAyrQ5YhMHBMgquaSAQ8/vfnvoISeUvvXuaB6mUSYtJ5ij25uFXRabohZrPdZIJKmd2vwpvvh3aIRW9/SvQJ47olp7vjqSrJk6DcxRIjzyI9AfGZMxXoWXCCgIWAed6VSvudHqkdKlNW7wApLvzoF/VqRNf6L7EjzF1aa7R7FAuW3SvxsOM6KbnPch/pGl2Q+7qO1rKtuhVaO/aXKKvePKP77jYhgoOHfOfAxobEZwjBcNKRM+569hO6ojAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igTW3EO4+H2eTMAC49fOXnmLKf6uHgVGfwgsQkluuuk=;
 b=mh2ajFWOTmB1u60HLZ8jibFROnkXc0Fjn74my15etPyEyCu1EAcvZM1haiUPXGBj+9+mUJPcyKBA+UvApnqtYqgl5P3x3lrmBbYxtRXSrsiau9Nx1ASwEcTAa9cPrhhzbdrO6w2FyE/bsBUPiWs5z2Rh5LCodH48rvkdyq0glV1i+T6TwnssRmacYx6AXwjXIVUgSSqWavRBP5eyK50wMD55UGugxgmiuGB+4ey0xTpPsslCw+aYmEKx0brC6d0TruxkitHI9LGm2VoFLn2gAqrgGcX2hBJPnSBZbUzTE0wlbt1YTaz0e+0lHhrXC8iImETXLNIjADDyz7J4pJhGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igTW3EO4+H2eTMAC49fOXnmLKf6uHgVGfwgsQkluuuk=;
 b=V7/EEeC7jEaWllOKbQEHVMpjhkNdXnHz+SJZiKTrshaUqON3oyLBDHXTW/NGsvyyWTLHVgEULzq2DkaDbpXzBOfii/Fa2g3wTDF03LYNOBurS66kAgFzG5XxUqliW/hIZSPcy8TeLk5dyrssle3ycct7evxhM7L9oltK31lFmkM=
Received: from DS7PR03CA0306.namprd03.prod.outlook.com (2603:10b6:8:2b::14) by
 MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 03:44:32 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::2b) by DS7PR03CA0306.outlook.office365.com
 (2603:10b6:8:2b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Fri,
 18 Apr 2025 03:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 03:44:31 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 22:44:25 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <eranian@google.com>,
	<songliubraving@meta.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH v2 4/5] perf/x86/amd/uncore: Add parameter to configure hrtimer
Date: Fri, 18 Apr 2025 09:13:02 +0530
Message-ID: <6cb0101da74955fa9c8361f168ffdf481ae8a200.1744906694.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744906694.git.sandipan.das@amd.com>
References: <cover.1744906694.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: eec85bc7-fc27-4004-df66-08dd7e2b5434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9nmNB7ByYkmWq3X7RElOYwuCU11txVQNo6VoLZYl6ErAKWFAuAhoij2kUYsn?=
 =?us-ascii?Q?DMKIflbDRIHeVVIOijiCq1OY/JDIJyE+iqn2/fjxYv68lAQO6mMwhZlUG4k+?=
 =?us-ascii?Q?Ykw2MPPoXphp9ueiZo002XdwLtu4MzakFapXlfBH05anbFVODsd3F0CtJFaH?=
 =?us-ascii?Q?2+ITcALC1Rq52jLWDMM+BKDz0zb+AYBb7Sm3biCEsWv7OVD7LiewBj9Lylbm?=
 =?us-ascii?Q?Fh8jSdoqSwZsFtDeRuCahZ1/1Ojzk7D/cUX7YhbFbTFYSqur6WuidMDeHzyR?=
 =?us-ascii?Q?QguCSXYVv9ZPPpm4JrhY99QcijsRSDxY6aY0HD5bZuzkx3cy8XfbJeJ8QhUO?=
 =?us-ascii?Q?Bi0Lw+iV+63BwDe93OV4dKVaZhrEMQ2g7zoulaWgRA2kwU4mXD4mUTJBT501?=
 =?us-ascii?Q?sfWXVP9/qjMtKtmJ0vd7VS8Tv/6Hq+4NvvbXOjlz7fmUlB6FZ3nAjI7axsNs?=
 =?us-ascii?Q?9NoCDSUSo8o2/iGHauUSuGkOOHgYNi9Q9p/rO7r1/xjF7AXcpvlp2nd14RPh?=
 =?us-ascii?Q?1OSfsbUc/oyqj7mTiSt999sWcihFx3DCmfa5BIXoQ919XpQQP8RNAFxtPn90?=
 =?us-ascii?Q?D5q3U11XT9QwL6CG/7oNOl1vmAoruj2NQ4Re4FEvC8FXe0qolIQyxzY7nMYA?=
 =?us-ascii?Q?tf7zcvoL/S3YqLUlJ9ddeljIN+HW23nbvAttnC7wMemIQSqIUDgXA/ojLuCR?=
 =?us-ascii?Q?rSJ7PSpFuMr+PcYzV/wzO9+kAJS70sY3+FmKB6ZZP/eiMpgacG2p+wJod1gJ?=
 =?us-ascii?Q?NpW4nr8qXK16A0gfgfbS6e1yciHXYvV98NSfJ6W9USLJpjulB/+7/SNYCPdj?=
 =?us-ascii?Q?MBXWrE4/A8vvkkWISIkJN8wU4S6qJK2yPcnkjHLtNN5yXOW5OvJ5MGWyiRKy?=
 =?us-ascii?Q?bjLmJvnDzYOBqoTOEjTD8BPDutHh8CoQEX751sCN/ybBr0izKZHLU+Gg/Dnd?=
 =?us-ascii?Q?vutNjvfqwgGGDO5UBs8x3tq90ygF0bp+2Hnj5bMxHH7MKHxrv/7FyK78Dk7W?=
 =?us-ascii?Q?KrFoUGeiwZPoAR5hz7OfeFVe5YJ3UrhnTvW/kQJH07ryw3vOiKv5aOAYIn6y?=
 =?us-ascii?Q?YA75dXQs515BQANjD9/57oCzL4RipJDj7BeJjkIfqTwlw4jQUCcaeYuX8xno?=
 =?us-ascii?Q?Zycongd7ZUxTjhSTDGcPph2RmGau4Os4mqlagv+9S8aG72yrptx68DrNBbEz?=
 =?us-ascii?Q?0m4NXJYXa9JS/7i0t7iZ0Lvz03+7pHY+kgsT1tX1DhCTr3+iOUY0REd74DY7?=
 =?us-ascii?Q?mV3jqFtf2uNJo34vTnsGiw9Rdm7oD3GwJuFBd91/b+IPORduYoHUZBs/xw22?=
 =?us-ascii?Q?uEoxBuiOj13ngxkLYPqx26p+zA/26RjmIgZfKCE+jl+01F0aHpQ/2WQk0lyH?=
 =?us-ascii?Q?4U4E8VVqFSbwIqu5oPyGC7ejuKrkhlLom9fBUxbXSnFg2lg39Yr0RTeDaO4n?=
 =?us-ascii?Q?1bycyCoWxS7jwsbv34ysAfx0Nthf4XorClE3Jz5HOwduKsWj4SiP2dAr7FCv?=
 =?us-ascii?Q?htZIw/eW1d/bzWaFNTSP6K7cHejnECXkQ2bW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 03:44:31.6516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec85bc7-fc27-4004-df66-08dd7e2b5434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334

Introduce a module parameter for configuring the hrtimer duration in
milliseconds. The default duration is 60000 milliseconds and the intent
is to allow users to customize it to suit jitter tolerances. It should
be noted that a longer duration will reduce jitter but affect accuracy
if the programmed events cause the counters to overflow multiple times
in a single interval.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e09bfbb4a4cd..70e0af36c378 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -87,6 +87,10 @@ struct amd_uncore {
 
 static struct amd_uncore uncores[UNCORE_TYPE_MAX];
 
+/* Interval for hrtimer, defaults to 60000 milliseconds */
+static unsigned int update_interval = 60 * MSEC_PER_SEC;
+module_param(update_interval, uint, 0444);
+
 static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
 {
 	return container_of(event->pmu, struct amd_uncore_pmu, pmu);
@@ -545,7 +549,7 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 			}
 
 			amd_uncore_init_hrtimer(curr);
-			curr->hrtimer_duration = 60LL * NSEC_PER_SEC;
+			curr->hrtimer_duration = (u64)update_interval * NSEC_PER_MSEC;
 
 			cpumask_set_cpu(cpu, &pmu->active_mask);
 		}
-- 
2.43.0


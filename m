Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B355893;
	Fri, 13 Sep 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242577; cv=fail; b=S6CYYmvo+rlsxlAvAwk2FvuE6UKe7XIpqaH8ntzaawfqMQKtRQrPtBzOzmJXXL4xK8h/fYoABHGO2SYK1R9nFLzKfmcF+BuXNiXTBD2STly70keMCWUMg3h/qwnRMALS99PCRrsWcdnHQq/FuU76rtAgObcTIIK3KQs9F0cjxS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242577; c=relaxed/simple;
	bh=9dVEzdkvwnovstb43fzemWHZD99Mo5w1XS7CmemeFZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvFnzPcHhkmhc+gUkX9YV6Jtdcl2RUcj/2iRgf35SJbjtOAWbh9syahkTd/2xAeZpXxg6l2IJ7p26Yixhca3AfRo8r2BdkK9emjOVONjf7XyCecmtQxokLkpF6PqhDhOLN3+wtlWtrrtRipxx+gAisB8TN3tNBoZ+6FAJTqvJ2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a4PNfpK0; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a4PNfpK0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxWZ62kzoTaqVFysJLO3EjgcN/wEHf9TeH9IUQsafdvMSPXJdaj9y96McYNk5avinDc2HyZ7rgmUo935OoPv8zBRi3ukIgKw5nkH500nOzP6mpUdHPP3whrU1xzDvq4bnDh6o7p2A4I8I5vv2ljptVKPCULsG4IIh8kFverFJqCJ3RMX6Iv/WIxDYTcLSc+3kya/0qOb+SeNbhVKKLlLxGUDMM9Ey2KJtrGNkXfq6S6R92OhcOoLkLZIjj0Nt0zC7SnU6rEPHKMJ9x86HgLQ1+ZKIJt7HA8mX/VDpjp+fFt+DxKLgApzEilSm4ZoREKdctvHlI0FnTbVSbkwM2H9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtSKu4Zlj5DXczVyuIQlF/hyE9SWQ0YHz7z/SLZjEW4=;
 b=R8S4ttXYj56+tpr4yeGQdHYrvE9gx/Bv4OeBd0CMwi6ny/MEmXTYNtmbDVq/+FdYqGqWkqUv4sHnWN3Tn1KG8tyZL9nC2yqARs9DJyOOK+9pfZ+50e22r9FsBDdebEXPPmnR0z8HeavpynI9fy+oPNUSfYiBLvQbwe4cw8rFZzFxdGxE+3S9UskSNAY8+FgfmvafIf5ZjtLUJP6meTNrPMb+qlJM+ikKYlKXXvUvA6Z/ZHe4D3d6xobaVFvDDyc00pM8LoYjNsGqYgIKrowSbOuiIcq7Dh4eoMi9H8P2NR0sVur1buzZlW4Rj9h4iWqOs9S4jxK81WUJ1UN/goOCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtSKu4Zlj5DXczVyuIQlF/hyE9SWQ0YHz7z/SLZjEW4=;
 b=a4PNfpK0JeuhK2v5zVAHyFMKmBjF8lnQi06oyYF0Q1FR3WhpwDWwhUszN8BUV0AytkzdL5cBkLwSSwpldqNkxlNCcFYk+4a0yTSHDMCeL5eGvWxyzyGddLRsmWntf38DAgVcEvTULeY9wDb0lL5Jqh8HW8DRgBoxhR0leqX+WG8=
Received: from BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21) by
 DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.20; Fri, 13 Sep 2024 15:49:33 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::21) by BYAPR01CA0008.outlook.office365.com
 (2603:10b6:a02:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Fri, 13 Sep 2024 15:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 15:49:32 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:49:25 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <rui.zhang@intel.com>,
	<oleksandr@natalenko.name>
CC: <eranian@google.com>, <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v5 7/9] perf/x86/rapl: Remove the global variable rapl_msrs
Date: Fri, 13 Sep 2024 15:47:59 +0000
Message-ID: <20240913154801.6446-4-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913154801.6446-1-Dhananjay.Ugwekar@amd.com>
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
 <20240913154801.6446-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a5e2f9-2bcf-4d83-ea35-08dcd40ba94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1vRQfJ7rQOiMSZZdhtzTjG7NR/nZlnjzOnv0qZvkWCTKPgpV3t4wlgzs5FM1?=
 =?us-ascii?Q?awpvKoj76nMHjMMo6Qq2677vONM8mNA289vXe39FnW/FgnbY5ff4sqxfwqdv?=
 =?us-ascii?Q?VtguTwlY6JEFRRUM9O+gkqHFP9RpWQODYE4qy3mIlnHt/BC4m+4HcF5IhE2g?=
 =?us-ascii?Q?+cfYoIgKsnu+ckwElv9mraL0WD6kay3zyva4lYi8OZ7at3gRIxgmlsbnExxF?=
 =?us-ascii?Q?OZxsIW8LkBivl+3kVpPndhw+b6At8AQxdFAVWJ0j9SNpixMDV6n3btp3b/L8?=
 =?us-ascii?Q?fqLRRPLKgAQ4lGz+jUbut+E7kS64rMrkap8hhsjGuT6dzzWYS3/fxZmqjO+a?=
 =?us-ascii?Q?rvXKQ5G3I9DsbWJqnK6AuCRsOEd+g0ckatS5MSTFZ773zQvlEP8b7ncVMsew?=
 =?us-ascii?Q?2UJnl/JVGvh+Y9JoSzAbi3z5FdzHgKPDf7zBpkHtl1Ji/eCCxcPKcR8z/ge3?=
 =?us-ascii?Q?hSHNLgxPiLaBoeBZKzHwg826XBRqOSi2cls7Q1frm0kol3zNeAK+8ANLMa5x?=
 =?us-ascii?Q?0AGFbD88lcNxqG+k9VbUmXiyteW6cLqgT+CoNMQdsYwwYGfqcy38x6vqCv3O?=
 =?us-ascii?Q?7QGcizIVn5pikU8DEkFgO2y0ixk23WEPNpjK9GRjlsWi1bzTL0SDsidVy7E5?=
 =?us-ascii?Q?puY7QqVT+SKltTE/UxtwGShKvTsGG5c9QT2Bp9rgmODg9n1usqTnEuEcjgxQ?=
 =?us-ascii?Q?A29/8ldH8QvoMFUz3VmaohL4Ev/sNwTKKdYtdFzEfQdg91XIoO72rEc1qHCy?=
 =?us-ascii?Q?jZrn/lsALLBiEYzZtkt3JrCSiRLfUy5Cjz8O2R1hgrjEfsAzabG3kqEVqfem?=
 =?us-ascii?Q?fePq4M2iNI0re5loJ6/rOG07h5962wkw1Fniz6VqtyMe/BEb+5ssiedXUO4v?=
 =?us-ascii?Q?qRZNsFI4oAm6kSXiadMVss2DI96ADLdhtnKAJ8x237M0NiUwKy8RpqaHeVdm?=
 =?us-ascii?Q?aSzvIGf5Fz1P3yzidT/u05aR1HWiORtta7DKo1w2j5oNvPkMg6I6JccdsUsY?=
 =?us-ascii?Q?beNuMJU2/rfOGWzpNch3NyXp53d+YdROlG62ZXbfLj8gymgj+SaOLNtoUW/X?=
 =?us-ascii?Q?hYpTJobKVUg9yoctaBRmH2RR/7KvCEjBE5I+jUiubmGFEr33R6LnmfjW7tWZ?=
 =?us-ascii?Q?qiCNwYarnxEocPS3FKuErBBxhBoA9ERwAZY1sb5HTAZ4cN40PsXHhxxaiCr2?=
 =?us-ascii?Q?Q4/Xz4an4ujmqigFzubMLC9C+jzVKKO+2Ny1Jmch1hXNlCUb0WXiHJnOvsdB?=
 =?us-ascii?Q?vGfsChAx+ozzoy/gi9ZsiMtmoHecBhDCCf4yNECQhhO3nQPCJZcH2gOdaCR7?=
 =?us-ascii?Q?X0QfEFbFnu/5B646BsdEq+nwloaxm0He1xxXUjIo0cihnIS9JpM9HXKwd7GF?=
 =?us-ascii?Q?l5++sdAB/J5VyWVv1RabQrJcz/JAP74KIUS3Xn4h/EofDVu7VL2zUyBdr03X?=
 =?us-ascii?Q?+SQR87JyrVafwTkcUHSWjwTBZl/m+Meg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:49:32.8414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a5e2f9-2bcf-4d83-ea35-08dcd40ba94b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

After making the rapl_model struct global, the rapl_msrs global
variable isn't needed, so remove it.

Also it will be cleaner when new per-core scope PMU is added. As we will
need to maintain two rapl_msrs array(one for per-core scope and one for
package scope PMU), inside the rapl_model struct.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 023d208966bc..bfd8bbcc1421 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -137,7 +137,6 @@ static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
 static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
-static struct perf_msr *rapl_msrs;
 static struct rapl_model *rapl_model;
 
 /*
@@ -376,7 +375,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	event->pmu_private = rapl_pmu;
-	event->hw.event_base = rapl_msrs[bit].msr;
+	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -813,9 +812,7 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rapl_model->rapl_pkg_msrs;
-
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
+	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
 					false, (void *) &rapl_model->pkg_events);
 
 	ret = rapl_check_hw_unit();
-- 
2.34.1


Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449583563FD;
	Thu, 22 Jan 2026 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069409; cv=fail; b=eEtM+f0rlIk50WQi+h2fQB1iALeL78IDVVVN0QD5tsbmU8CtebPdbj6BOTSI/3MjvVLRd3OZYW8uR2CjuUtIH5WNIUvn9aRH3tLlZWBQrToe8/4orbuLvcpZ3ldNH54EWAGfrkHRAoj6L6/dChqfi4kUOKPdUgju+EDQBYoMzjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069409; c=relaxed/simple;
	bh=kKXgvQVzZ5nbQNDtrYn2TNvw4tsVDIz+8qQDpe3g2/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pEOCcJKRTrfzfGYHxQnOKl/+D9W5fwICWnB2i3DBLPdD1vZTCOAO7U2z7tdtNB04finCvRff3Bj+0Ntgh0zm9pTiGyRfktBugYRh1N1FBT/DrHb3VSfQZf8ar80Zhg0Xz7tgnYQgtM47u0qj7z9/nAyLz4RGxWS242uIpIAvbq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W30RL7M2; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W30RL7M2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+Wgto5QtgpBt6zMFyNE5g0cDX9nFuQMW00GmAF3N507NJEQmnWTJeLHgj6Xaz1w5eRL8v6FQ3wOYwn1DCHZgfvjhfTq/wZDhDDCRA6WvVPlOdF9w+259KUcofn6W4LZe+iOUB6nces/rVboALKcLE+oyJYmy0xI+Ych4nJhkF+Y5ct8JchDurmMKxYmbliNJ8QpsLqFqyjGH7ItajTDBUvM4p+uOkNNTXzwN1rIpZ2LKUMPK1ir5V/YX8SpViVAyJGGnfjpj9HZTaW2XIITNLudG5hBoDoVFiooAaCKZJkLxdtcQEeygBWD5wdvWLhBKefutEHFRjkD5hqGG7/U0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+Tj4y2QhzhvHME1YB+uiKymEaamZ0mOaKHhDj0scvQ=;
 b=rm5i5efosq7KJQuIvHdo2xMeggOdDD0GxULVem4nhoQ+t4ppyAtLiNH7eoNCkLQROkcKBhBKdxpdnvTcjZwJr4zvnSzG7zCdwrosKacOfT/cTuh+nkTHMBTo35rrEog2zV3ckaSVP9QTIlXEaaGgR7OB8XSXuYJ2Xy4n/TVcoW/xHuvxMeMbpusA+CvUPxPmPpwzTh/ji1qtGtAK5vdexQLqMmZkrDMm48fgWH8HAgnafXWce4G08srWGwIpMdmOFXtLoP2JhM2vzKizYN9ZQ0QmU+NudTKWfQJyqlhx2FfE/C4FLyCQNVBhQrB2VYg/pSfwaMrIAGvPPHs8L9QGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+Tj4y2QhzhvHME1YB+uiKymEaamZ0mOaKHhDj0scvQ=;
 b=W30RL7M223n2sM4v5Ozte+4TDO708rgf0bqtrX0yX9dAz6HH0JDlNl4fjZdUdUODzKXomFcXsTylCIYpY6rmlU7U6s7yvyiTiWzljNx02mS8gvJo+scXdw0E5iWp4MsjQVKOmHH2M8VJoBsOp0DEpZ4+x77+3nFClhUR4hlRypg=
Received: from PH7PR17CA0039.namprd17.prod.outlook.com (2603:10b6:510:323::18)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 08:09:59 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::a6) by PH7PR17CA0039.outlook.office365.com
 (2603:10b6:510:323::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 08:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Thu, 22 Jan 2026 08:09:58 +0000
Received: from sindhu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 02:09:54 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Suyash Mahar <smahar@meta.com>, "Ravi
 Bangoria" <ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH] perf vendor events amd: Fix Zen 5 MAB allocation events
Date: Thu, 22 Jan 2026 13:39:46 +0530
Message-ID: <9a7eaa4f2e50a4ab2d98781c52bce6f98568a888.1769069215.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ccca4d3-be30-4210-7930-08de598da2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2oNelD9NZRsuwoVopfpZV7lcBg76CsimgAzEvsj3Q/88foeuxIfGKqVd8J1b?=
 =?us-ascii?Q?UyZPiGW390+4bJc7+UPRBK9DnEhGzqRiXqh11Uwvi7NeB/9QRxyId0erCDnT?=
 =?us-ascii?Q?a04Fzlga1onNDLhWG5h1Aqz+jsRfTBQTzik4VemzKIR9oBi7bO2TFnSELmmM?=
 =?us-ascii?Q?RR3begRHDTvwkUfSpFOdg2Sz/6D4zu65/goYFMU7gHKecS9g4PFH72cCFtyb?=
 =?us-ascii?Q?pD3+kljbB2m8x0wdgedp7AjNhkirEr33ycoqpTkJUlnW3m0xlpe8U+UdA6XT?=
 =?us-ascii?Q?+JU1afkbJrnS76zNKs6Gt2bQkf3LxLybt81iXMuFx86oBQnlmBzFPm6tCfBM?=
 =?us-ascii?Q?GbQxMmZ8bJgP81dFJVitFNSKhMySHBxslu+ED3t2HW6ijBOKX0yXj92c/QXJ?=
 =?us-ascii?Q?zpsUWXY9elp6Hc10RnmOHb8dklmHL5rjNeUnz2xEy5RT2V/nbHLDayNqb+Xu?=
 =?us-ascii?Q?6X0Sm6w8ZMrqeS0TECRBOPqlCoEG8LDgb5ARmMRIYCPJoAwNgPcGllascvdn?=
 =?us-ascii?Q?kdebQIV/WH1tkj4BoEyYnGmV4MJA7wiujXVqTYw0be/JRvitkuILBllbhRcX?=
 =?us-ascii?Q?3Uf39Pw9xoLlJV+kXRURc/NiB0qyz7IPF+x+nDpdPF8Vgses5yyEeNh7r0Kk?=
 =?us-ascii?Q?EwjEoY45xMqHEQYDmm4VTws+keBKM64YnnHcm2ADQcHIujG9mA+zpwJ6eLPe?=
 =?us-ascii?Q?6Ulh2t/VXfcSg0bQk+gnfS4HEfbA1s29fuYp5XShlvReU3ONzNTVb5tXDgXy?=
 =?us-ascii?Q?BI4tehyCB62hzyt7GRK+U5wxr69osqkuCKWBQPzWD3yXGGxi7H9s0mZ2/Prt?=
 =?us-ascii?Q?6fgS6YTpFcBbQnVXRRu+aA4ZdmYcFfJKGegN1De6skvZNgAEMDwYVnK9zICi?=
 =?us-ascii?Q?Oid6lP0rnDASM+Tg5JOF9T99ch9HV/enOUnJTVpC9ShyA2AgX1Hzfo6A4BrV?=
 =?us-ascii?Q?cuYwIhXLfiZ1cbJF9IIOMr6RH0VswFibwZFVcTERVrd/7e7S96xIrfaZS+vC?=
 =?us-ascii?Q?Jg0xbKks+fFEDzPwnRntwRqeTPEvw+rhlozD6opzqwSVqvR//YGSeB7CmAwQ?=
 =?us-ascii?Q?O1tNMm5iNf4O/3ORDrMchb7kwTIa2I7UrrTpGtWBW0nLGwdIL2JPaK0d8EQu?=
 =?us-ascii?Q?8JHmAY1CbG4k9q6UZprlmr/8tZcuHp6PYJ/mX94bqdqeLBC1ZiK91ZMqzX/l?=
 =?us-ascii?Q?n8WVk1wr7/QgmrqnOZOg495GLfYXEEoTk9iOdWxjbNPiSpNtL12XjpzaMc4o?=
 =?us-ascii?Q?Y9BeBVhw/4epVJStbDNnyanG7poY0gyNbokk5hi5ex9AimzuhtBZrSdDZZRA?=
 =?us-ascii?Q?3aBU5xdOav825IDqdhCKjGrCjSMNWwmY2/3GT43G4Fee0ccN7gYrx3cZnjCW?=
 =?us-ascii?Q?dcjOmrbJZ69xpcIIVadgOQNWitIGtpjyoYgBnnUOucAjzlQ9cXV9P4TgH7d8?=
 =?us-ascii?Q?VJo90C2NKpJxSp1ZUr4wQf93UpYN2L44EqjvMOJF0kGD1NSJtoU+RlLzaQvG?=
 =?us-ascii?Q?Mc5J9JLoEPz19tFi4fSxNMCuIARoruEpiZIkfUWQn7dct2WMKE2Pcz9TWyRM?=
 =?us-ascii?Q?YjuFtFrDHSQFhGSkQarLSjG7R/I4l9TiqMGbGtOnfJj++/dzB04FLC4tsJAM?=
 =?us-ascii?Q?bNQQZWRp0OSd+M/qyzQ+3ByNYA/p844n9NQ7+N3qxy6QcrcgA4gRmMCA1coC?=
 =?us-ascii?Q?gtGrCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:09:58.9177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccca4d3-be30-4210-7930-08de598da2cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157

The unit masks for PMCx041 vary across different generations of Zen
processors. Fix the Zen 5 events based on PMCx041 as they incorrectly
use the same unit masks as that of Zen 4.

Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
Reported-by: Suyash Mahar <smahar@meta.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/arch/x86/amdzen5/load-store.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
index ff6627a77805..06bbaea15925 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
@@ -70,19 +70,19 @@
     "EventName": "ls_mab_alloc.load_store_allocations",
     "EventCode": "0x41",
     "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for load-store allocations.",
-    "UMask": "0x3f"
+    "UMask": "0x07"
   },
   {
     "EventName": "ls_mab_alloc.hardware_prefetcher_allocations",
     "EventCode": "0x41",
     "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for hardware prefetcher allocations.",
-    "UMask": "0x40"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_mab_alloc.all_allocations",
     "EventCode": "0x41",
     "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for all types of allocations.",
-    "UMask": "0x7f"
+    "UMask": "0x0f"
   },
   {
     "EventName": "ls_dmnd_fills_from_sys.local_l2",
-- 
2.43.0


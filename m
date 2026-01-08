Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CA38A733;
	Thu,  8 Jan 2026 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858776; cv=fail; b=nhRNZhDFWJOK3FVhjVRQLpTiUlYGppUywUDVGui4SIQQlJcPH2JZbeAJZKjM/sfsQywPvSRI6KEVBl9C973lQvFarYaRy9n+8pesc6dRLlDlbT8mdfu5F8E/8foLje2FQ2YY1TZ2ADFr4t8uXvCTNZhcA2qFbR/VDM0BqEmX8MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858776; c=relaxed/simple;
	bh=ePnW0Hua4pPKJkDaL5E7dQld1HqK3ds2coh4wU/mFNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVPdrbZuRb1g93T1HXRD4bMC41zPFYeCRQe0D7nF/8l+PiusMfReBs3vlnafXTBflTd9hV6DPS1nsSwRAPv8QkhfeakmE7+Eu3F0YfPX4EMeEWqtdzPiFC97SMZNzGoSK7bkb86t147DhRdMKJQl5uMgdCvcLhKbqXOVy0+EIdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mzGbNeqO; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mzGbNeqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGvKAVTGZm+FpSMY6Z+Bkrg+hpoClKZNeEb1OMmQouBy/FQQFHji9u/KHo8jPPKEHwqUzDGqLWER9pzOf0Dsw5JbHMWvPwZfCFAnsL1qce56+Antf+e3bKjHctj3vEYcv58zd8G/8vZCjCqX00qUUZ+q9m4AKp1KjAeOW3aSjvUkFnvi9Z7/CD22gcsA9k3Unn/IdQkpr6mWAU98TBhz/csYuUk6ldxr+uX6Lx6n3SZyjBZEw52Y0ghXC4q5Vsx4ZQP9YF0yQw4kctfi7WIIzHdoFbxFmkFqLM+uYIHs0S09nSLIzx+BTpdQcJqO+VmSYDxJ6Vhc2w7FHBA+LriNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/E8YXs40dKZt4OoBEokHIZ5PYFdv+ENtGth5Yq+Ess=;
 b=xwskeFSFJL2WWplCtU3QbBxKNcXgp36YKgTJIdXrqYg9l3aGofaSUa0drfJYwruMhEycNzav9/pa539dAfU80vRASwOQQ2GsLTn3ifgGv67sOtfW58xJ8GglgLXoBql8ohCvlEIjhzWu0OPp7iKqVTVo/3OLrjTlPAAd+PNZTNZBEgbQrp3su2j7lYo+OT50vg3096c0rS8PmpGNCMF3FNblJTCzR1Ca5ofHbCg3KWtOa6g/cG5sePEF2ZpGGoxuNHMjMzFc7K42Or1yxD1ZbT2sSWeXbOBLMati8PThd3u+3thhVLOzFAAZzjMCBuOZxrUhmpBH715kj/2/7cZN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/E8YXs40dKZt4OoBEokHIZ5PYFdv+ENtGth5Yq+Ess=;
 b=mzGbNeqOk96R0bug0vxuj1ODBXww6yNhsPFM2zsDMuX29cFy5lkBF22odW+T3Jh/j12r9bvoK1MBDJwDNj1aWQZviycNABdsuUKq2QOE9QVEeKnAvIdUQywl4xVxQk8waORrR20jHwZT5vnFoSD5kkJJEPDPZJ/Wu351/qawjKc=
Received: from BYAPR02CA0013.namprd02.prod.outlook.com (2603:10b6:a02:ee::26)
 by CH1PPF711010B62.namprd12.prod.outlook.com (2603:10b6:61f:fc00::614) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 07:52:30 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::24) by BYAPR02CA0013.outlook.office365.com
 (2603:10b6:a02:ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 07:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 07:52:29 +0000
Received: from sindhu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 01:52:24 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>, Stephane Eranian
	<eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 0/4] perf vendor events amd: Add Zen 6 events and metrics
Date: Thu, 8 Jan 2026 13:22:13 +0530
Message-ID: <cover.1767858676.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: 047cece9-3b4c-494e-8c27-08de4e8adf95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2O+dDFuyWfjPSwqsspENZTfjrAm35dCx1rhN8l/qEMTmDJGR1IhIEIvweRdI?=
 =?us-ascii?Q?vBp9On3Ge7W3dIz0dJX2ACNlO+nvNusa1Lc7K4vCe/zlE8mOAzzsgiTBeoY/?=
 =?us-ascii?Q?lQ8N4JLFFtEmO4g/r8mWsd0reEFPEQ0QlQgHs6SxsYoh/rLL7u9B95RwHRoK?=
 =?us-ascii?Q?ZMsfy3Mcmp0bQRS/N59X4CIsk/LZLT+4ulST1flKFPN51nVAE++ILZ30BLfS?=
 =?us-ascii?Q?WYdcp96kpE2tfbo3bb3O505isadxpGxv6G4mCiiRIAR+HsjGOzWBO7Un91ln?=
 =?us-ascii?Q?U7vf0bc9B0YIpdoN3vFK8A+yaxx+EcWtfLPj1NVSuF5zoS/IWN6OaJl5Li5w?=
 =?us-ascii?Q?b8e10/Kj6A2Bw28fZw+4GIcocOE7H7OocT4ufMWhV6MA+oMvc7gspug8ufMe?=
 =?us-ascii?Q?ltmsuzJrC9BbtA5+LlwwLl0ml6w5efY0RorWEYucrtNv5riVJAZs8FCeKM5U?=
 =?us-ascii?Q?q7dnUfj8UwnRCJgAp2TJruSOhhWILm9WBV+Cur1O9vY/uU4jI2LaFbehEq24?=
 =?us-ascii?Q?EB5QoHe2L/Kqxb3rp/KgifGOGybXzoNp8O0cJothVKCvwi5RlGnI78crJ2c/?=
 =?us-ascii?Q?fimjHYQ3Ch7V8lbdWb8XA7obw64J2Xqbk1n7EYjftLr8lGSOK2/uez65AQiM?=
 =?us-ascii?Q?Kjavf8Ax8Ic4W6/+hXfqH0PmkLiBwDDBq8bzp6JBUmLKnBE1XTLF37ZO0IOi?=
 =?us-ascii?Q?QGAf0Hxx1q9zTznqNRWdUn4ez+dl50hoGuKaXLYacQxre88uYskvtxdF+UYj?=
 =?us-ascii?Q?T7c4+KaoFzsp12yJgIv+x/FN4he3EVInK43o8LTVg6OJWT1drJmGamAt58JF?=
 =?us-ascii?Q?U3cqtpSSdkaRypK32Ot14Hg2ath/MzLt9tUlvt4MmywCnUvmOx0Y1VeWG4OF?=
 =?us-ascii?Q?/Azf92kZqIWkjM02E78qL8d/hSRiLVGCPaH7Uxxhf95R7Rhaevfol4pIOXlM?=
 =?us-ascii?Q?xru6yEQO7R3aMCnlIlv/RMe3UYCpMSBp4umXifwymWHoYYl2mUq0pRPOYwKn?=
 =?us-ascii?Q?gy/AY4crfNtD1Cj5+HWvhlGqE5ip/ktfSFLmKZ7ZE8G1wou0sC8iRJpCd8wb?=
 =?us-ascii?Q?dXr4PX9O/u4Z7g37I0balWVM0F+w84v+P13tqRKvzZVtjVOSP7bVnPei/bEt?=
 =?us-ascii?Q?PD9UfuXlG/pzGS6jNr6LyfObKEXSRS4TsbYMepyPfsSFCVZKs7XvEJ8W9rBL?=
 =?us-ascii?Q?ZkUCirTioQ2SQ7HoCpSyyI5icrYz/hzcZqeQYoZFRzzL2sld4Nfwhbep35bt?=
 =?us-ascii?Q?LXZ55rBEy249aaTJuUxFOGwfiujF01XmCzVh/GXG6+yWr7JYIfOZfyLZEvlu?=
 =?us-ascii?Q?YjnVV5+G994qR+4lV/S2GNghndV7zUZxir1ADGSkpqxlGaW62qAI+KIrB/9t?=
 =?us-ascii?Q?749GXiU+OeHofnOBiSyAK3glRczadkzMfpw3ADsYTKXdkabAwWkepFSH3i1w?=
 =?us-ascii?Q?Y8X8a3pz2cWaT1bW/KBeYk15xc4Ggk4B2uArcfy+dvBxVgUmW6fDJ9bmdV2q?=
 =?us-ascii?Q?jrApHbKWLMF/FSDkQ19rh/vvzxAVr/nSlBCftXPp4BKkDpuHeN8qKzJtn+LI?=
 =?us-ascii?Q?hCNSFjGg7UNM3ldEjkY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:52:29.6074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047cece9-3b4c-494e-8c27-08de4e8adf95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62

Add events and metrics taken from the Performance Monitor Counters for
AMD Family 1Ah Model 50h-57h Processors document available at
https://bugzilla.kernel.org/attachment.cgi?id=309149

Sandipan Das (4):
  perf vendor events amd: Add Zen 6 core events
  perf vendor events amd: Add Zen 6 uncore events
  perf vendor events amd: Add Zen 6 metrics
  perf vendor events amd: Add Zen 6 mapping

 .../arch/x86/amdzen6/branch-prediction.json   |   93 ++
 .../pmu-events/arch/x86/amdzen6/decode.json   |  139 +++
 .../arch/x86/amdzen6/execution.json           |  192 +++
 .../arch/x86/amdzen6/floating-point.json      | 1106 +++++++++++++++++
 .../arch/x86/amdzen6/inst-cache.json          |  120 ++
 .../pmu-events/arch/x86/amdzen6/l2-cache.json |  326 +++++
 .../pmu-events/arch/x86/amdzen6/l3-cache.json |  177 +++
 .../arch/x86/amdzen6/load-store.json          |  523 ++++++++
 .../arch/x86/amdzen6/memory-controller.json   |  101 ++
 .../pmu-events/arch/x86/amdzen6/pipeline.json |   99 ++
 .../arch/x86/amdzen6/recommended.json         |  339 +++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    3 +-
 12 files changed, 3217 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/branch-prediction.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/decode.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/execution.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/inst-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/l2-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/load-store.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/recommended.json

-- 
2.43.0


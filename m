Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406754785;
	Tue, 23 Jun 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211792; cv=fail; b=Xq4I878FOUdkowFbv4pwKpiERWABUFy2OG3DLNLC2kloV7MBR4bEN27e+9IKYXSIpvHzgTpjxkB9NQwQ1VjbaYTW/K79OidMJCQZ51yQcgfsuIfC8FFrZ3U9SUJrwfdywjQmoZCvEVhdCpi2cz4oPhV6iSevxH8m0NZv+Y6lR9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211792; c=relaxed/simple;
	bh=QkQ/BovI3j6j8eIyHLJJ/wmLeRNLgB7x3ytMU/JoNUA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fW8RSzlIWeIKpdREbbvi6Ajv94Ug4Hb429KcQ69q6yrJPaybet6x8VN2CLPahMCV5nR5ZsX4OnubPoUxAa2kka2Sp8kkO19yBCDYuT3jX+jGFdboFJ2BKV6hzQbDpW5VjpPyaPhSKVKXr1/v87SsU5qdI0jcB2I/Q2Rz9kwoWgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ab+g9GFb; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ab+g9GFb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWFaa9ctbLfdi9qW1ODMSnRI4i41PgqFYLfD1bsuVRd5h/td8LtavyuyGuxXWp/CEyRwce61f+9oscLpIOBfLuKySaw3aEmZp+gblcvshEkbm0CcdhwLFeTlPviscSDRt1TwncVv+Cmx9ifPxTFhcLt2dlA9VLvKzasxBahX6d0NUg119AignOSH0/c/Uwxz4v01U8SGa4tKgtI2eNbxCrGOLImTM68LcFx7+KSxITW9g7JAaP/0O7fDMQ/upcF75Ia4AtHgEjQwtP5TTau6n1L4fY4YqobDSaGtU64YbE6NaQA4tBFyUIb48iYlqEsD1XhQCU6wJByyju2wnIuX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yk3Qt6lX8PpC4Nt4pFizpxgtANMYLBrPdVPS6htBw0=;
 b=YK8e/Jbt+gHJYhyhvXj/dmU4wqz+HRzhz6TnCL++rj7uJrVu6o+pp0EDFTJSzYIPmAVMcuoxlcsEKkN+3lIkaUiYiCvSX8gX5SG6Q4x+Hs9pzVDW+N21M/e3gK3Gu5+InSc+AExc8mT/GA0Q6FErN5eyqaH5bpJHzHODUJuPVqcHBcenozZZQQPhsRJ+Wnwj5AhuL5EhHG2zsxzd1R8S//9vsPPCw38FWKobjFZm7oWywsIhfPlrC/5IfXY4PXNQoYbtenhfqjEbWupBVWC+UNrvEMPCw8zAv5XQoWwPjfs8PEGoD54lUwW4FlOCfZKpvPIe65dfSlXBPtdhDou6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yk3Qt6lX8PpC4Nt4pFizpxgtANMYLBrPdVPS6htBw0=;
 b=ab+g9GFbDY1dc7Y8ZOedrDYkeSVdpMR9UwdfPKmgpa493uKKUKvtFLJk4zcKc8Y1gMsqybTvpi6Dv1DUmxIhULqhR0oMQNr5iM+zQDbFt3yCiMIuRFthThykvVyS7iXOTu35Mmv+VZpzSRX+r2IWxl/r5FJqIc2AiMMPo+I0Shk=
Received: from MN2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:23a::23)
 by DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 10:49:46 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::90) by MN2PR03CA0018.outlook.office365.com
 (2603:10b6:208:23a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Tue,
 23 Jun 2026 10:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 10:49:45 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 05:49:40 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Ravi Bangoria
	<ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>, "Sandipan
 Das" <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/uncore: Add group validation
Date: Tue, 23 Jun 2026 16:19:32 +0530
Message-ID: <0f2cff983d79521e153d211ce412fedbc4ed942c.1782211518.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 665112f9-38f8-4f69-e9ae-08ded11523b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|23010399003|18002099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	giEetd/ToJ0YpeRyOv/p9eX5Ojn3rS3cqw0NXynQzja3YJdUgkLNyF4Ywvu9Wj2uodH24uZMaKSJpXvcVT8l4Nn8tz5kAkkKVDtx8FX35ajQKYzAFTRgxEoRc+rVHx2v8yjoqdOtk8Vyaf5s3YjuMaqeQCJle9VQsSB+bjLwRX5cjdmilJv/hYxiqQ1G6R24gu3llU3ZJ1E8NKKicaeQpEdJgkMM16tEw5mPV+ZeylzZnf/EgsRjhrUVVZpTZgsWoDhb8+h7ef567TSbv676EsAp0mcpmRaHZU5uaJw9Ql5O0aWKojadIXCAUW2KiR2utT7a/B8GoEM89usTxtirQoLO1SAnAb/xHkfstNrz6BoP3O+8KFgVj9gqM6feFg+W2zZorW4jpCsg6dA4GprubUm+43pc9Z3jp2J3nlRtQCy7BoOOyf+TzaXh7E7Br5wAC5n0H9Sy6CYzlB/IOA/DyiVVQUFO0LqEEU7BDZoD5t4jjlelErnOpMjl6KeUqKvTfBIWn4thxl4B/mCwKbvzotGmtqI8Fcp+xtwNpHYxXrbSxa42JoVtm/ApSYMz5NXR8+5E+DNLqVf24eCbjVQaigBeRz+57hEC2O/P3i/swEufshEARCDOAEn/SuGKSZGLHb4K7Kext/2wI7SM9O36t8wlBHh1WyfeMAXpZJnWZT8+O3PtP9qSi8/0SD00mZclDIpMk2XTiBFjDz6mpJMbLg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(18002099003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mv7bk5bMR9QUfaJ3k6OZ2qB2HMGZXpvzz/wa7jASb1DRVNvluDJhDgGqG85h8TSqffdTjIHcTdLs+qLXIXwoH1rG8Ra5dUfPrX5mDHup+TEm+ZzFWqc1Ts6qCMBbIPH2YaOKmR5PxXdxfBmb/+FeXCG3u92qPazrAE6eqLJsbf2C3yZXN9vRt+gpSMSro60mqGk8/pw4YdxKL/77o2OjVcpZhVhoFK/4W6CeqlFYJ+BMBJ7Z34jzaY8eWgCiZ1dUkxmCCsx3AtesegdmT8AhwjDMjYAnxNmselLFaG2k0eMypKHz8pIJc+vjNjxqaYAl7iET9WG2W+Hlb1EHv7mH/nteXCtJjAVgXoRwBWtydYkcBcQLEeuarWwoXKvDSMtL51q0yGrvM1d4/Yjj0SfcVffTpOVFGiBO6FTs7BiTSR+z1ZoaXJvytmqlwr6yVRTY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 10:49:45.6529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 665112f9-38f8-4f69-e9ae-08ded11523b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348

The amd_uncore driver currently does not validate event groups and
allows creation of groups with more events than the number of available
hardware counters. Because of this, pmu->event_init() succeeds but
counter assignment fails later in pmu->add() which returns -EBUSY once
all counters are exhausted.

Address this by introducing group validation in the pmu->event_init()
path. Since the uncore PMUs have no per-event constraints and all
counters of a PMU are interchangeable, validation is reduced to just
counting the group members that target a PMU and ensuring that they fit
within the available set of counters.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index dbc00b6dd69e..9715cfb8cce3 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -265,6 +265,29 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 	hwc->idx = -1;
 }
 
+static bool amd_uncore_group_valid(struct perf_event *event)
+{
+	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling;
+	int counters = 0;
+
+	/* Ignore software events as they do not occupy hardware counters */
+	if (leader->pmu == event->pmu && !is_software_event(leader))
+		counters++;
+
+	for_each_sibling_event(sibling, leader) {
+		if (sibling->pmu == event->pmu && !is_software_event(sibling))
+			counters++;
+	}
+
+	/*
+	 * When pmu->event_init() is called, the event is yet to be linked to
+	 * its leader's sibling list, so it is counted separately
+	 */
+	return (counters + 1) <= pmu->num_counters;
+}
+
 static int amd_uncore_event_init(struct perf_event *event)
 {
 	struct amd_uncore_pmu *pmu;
@@ -282,6 +305,15 @@ static int amd_uncore_event_init(struct perf_event *event)
 	if (!ctx)
 		return -ENODEV;
 
+	/*
+	 * Ensure that all events in a group can be scheduled together so that
+	 * a failure can be reported at perf_event_open() time rather than
+	 * silently at pmu->add() time when no free counter is found
+	 */
+	if (event->group_leader != event &&
+	    !amd_uncore_group_valid(event))
+		return -EINVAL;
+
 	/*
 	 * NB and Last level cache counters (MSRs) are shared across all cores
 	 * that share the same NB / Last level cache.  On family 16h and below,
-- 
2.53.0


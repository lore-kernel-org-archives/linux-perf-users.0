Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6AB366826;
	Wed,  1 Jul 2026 05:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884539; cv=fail; b=cBbVSCCq+fR1nKbfi+DyDeZPcNXB/QJ9djOVAp525Jv0D/xvlEZvREV6AreZ6dmhAPeHfS5OP6cF7eSX3hP55tOMtRWeBO+BJz5GidGk3Uyp4rklDzslTlgaM4Af8tNToNqmUEojO0XSDA4KTUoEpiN3rMjnJiW37cqI7lphheI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884539; c=relaxed/simple;
	bh=gVc4TR4LlKh1Zcvc+ddcLMPRdfE5Eahhp2lmZMWqXAw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sr+oiG6AmTqcXV+FIu4tDQQyydhhVcDP86/2wcKtJ97JHwR2zUGUAfB/Ua0ioFkgF5LC1pIUpNxjW9PQTF/UQDtxWVU4rgACGWj07nZX/jsxbFZg+sv0zwWtKSWdVhhDWGpyLpC56H/G4Ad7uirtu1qbvdSH01haefwVNRs4vTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sjZ88YUW; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sjZ88YUW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLGnUfO34EdblKRdRkRx1OojWhhl+fEDgJY+EjjgPkGLpAcTwuzZDbXt9rWPYy9xmFNZyVznB3PAVNrCRUhjHi30JehqL3YO8ZwvxbNa9CW2Kxxtq57tRQjE1qeIBt3C4XdNKxg/4cHF3iB+GpC+AMZgsD07uE54IJhESlSGKSK8SrtjoLgwVrRSTLgRixXrhzbbJVxZvTstgs1jUTd3A1Yl/acYoqa/o8I/eTQzEmI75fOZDL1GGoLcf220xuE1LNz66cm7TMjR3t9Gpc0q1twp8vUAa5tHdCgQ/I1MrezPcnkCf9X/u4SoiV0KPg8b03DoYykk9/oTQbKzrFBSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YDfpjQq3iA6BrrSqn2l1pMG1z+N7N8CL5SM1jRsqcw=;
 b=zGoTexhVfEe4NSdsbkXjLkHjJT0Te64gZOTsIrLbXb0zkccISAbsYNAxaJTSeviOhwYtjCgS3NM/k5R9DJeZlQdOyiW5u40MPuL7LrDd4AGYLQ9LJLACoTmsdp5Vz3Ph0SGqOc3pedD6V6M0uJWUDD5YXM4XczSkRfyXQs+3QZp3H53wj6s/vG/kLxJQ276KLkhYK9pAmufwWw5iw6ZHYdoJ6H6RFMv5iVKs6Fvru+TkuEcFiknVxJddjb7ukBkB6ow1Zvtx0oIBhDgaHHG8J/KHkTXxwG2rKS0j0UzHrnDPkWtSFD0Mi+6s3qORuslwQdq37BEzXQGFW+qhdY4sFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YDfpjQq3iA6BrrSqn2l1pMG1z+N7N8CL5SM1jRsqcw=;
 b=sjZ88YUWzbqP1A/0SGuaKQ+Bl+EjMx4W41+wATZT9SOu/80l5L5ZzXahCrA6G2Iq7H1AW2NgLO9npRY9hPlDViqW0WfNZ1TvGzBGfvx03QNrhPoBWKNx9w+ziHJ+y8Ue2XDQZpi5h++zM/rBi/GZr4zlwKGAB72NXElJf9FoMKc=
Received: from BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::6)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 05:42:14 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::5a) by BL1P223CA0031.outlook.office365.com
 (2603:10b6:208:5b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 05:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 05:42:13 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 00:42:08 -0500
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
Subject: [PATCH v2] perf/x86/amd/uncore: Add group validation
Date: Wed, 1 Jul 2026 11:12:00 +0530
Message-ID: <750877d66e208603c3047f13eed6399625d43969.1782884387.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 1645f7f2-127f-4f9e-d029-08ded73380c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9NMlYQDpgjhUDW3gsRk/43jtcHJ2d1x47mqSehXDSjQLVb2zh/wzB/WtGDOedIKfft8NmrnsKdFxiTZTGLLcY3EDpJKkAu6i/Ql1neRi7HQ2uNQE8HvyEdf6mFdApAXd3xUnz8IjwnVVOcifVoBVnw9x5iYeYPcgSemCkh1uXt8WvZuX6lUgCEkLrwDmdOuRvZ7W16cbJLaN7TdWpc23WCXg2/O/n1XGuQKw37DT2LeXjfjJ3G/iI2GTXSToEwNm5KIR2yO6bBXjb1LhwScoL+bkgLjm/n0ITlAc7bdqIJbsE+zZhqFHcxbabzcIq5C/b2SNIPENbGnp6QV3+8KdFHPM1zC22wMRMzYjvyJ9MBfgKuF0Seb5ZysjzmRglM2u2E8wpIM3CSpSLF8UvJ17E5Gt2rwSy9GGV6qD4uolQeaMGoIIHJdV7zwbAPjSKs+jcKUhpA+5q96EdYGC6ahI45E8qPE0eFokjzGZCmfhEiS6AveM+wwoWOnxtC1hR7SJAFtUX+ubZn71mgkocjWp/MJ03NGK2k04ATqxWU9hU1AAM+YhgDmbhkij4Z+oG9M6toazg3M3dhH/UlaOhW9ala3CAgEr2l+sBhXkXroF2SIOK8uG/fx7I9aSc4OTCuzomSsTRTP9/rm9IzcKlCIiDwmzkJ9UHis/F1sg3aTuKclVtNf4wV7KegisQAoYmE8AMYJeykoKeHnjNJArZ3CipQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nvuoQgcfwtcK8pMvyewOmrzxm4LJPRwXbrUnCCYZCLfl4iBNM4xZuWd7fRNvqN3Ur7S+dkbc4BR1LZdJ5BKOkYIOphjadK59vc1gwytl9LPjbhLjWNtI5xYj3GTG0nDn+znVnhTibw5ASeXCjAvuKsEF8SvNVwKCluDiD72ETRp1UWauFD2gU74PwsM9/LV/4fY2Hwg3EdUJ51/IIiSCs6J0XDBDFj9z/2yblf6JvzU6zHQwk8VXIViBMWYdfwj1dz2wZrJ+LzmRFRN8BVh84Z9Kz2SLQT1D+csVKLif5sSqRU3+b2WfjZyZz9vGHrD0bw5aXpPU9GDVgW1rRVOlPxz7gjFwIVC+ZwmEQkB6qunw/eEiPFfJ13YGgDp05J1U/RHYYcj6piGvOAFneoJw+Q4ORyV2zDtoxYL/kiS+ynnYjnu57+x4eRUf0Y10WZ1f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 05:42:13.6582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1645f7f2-127f-4f9e-d029-08ded73380c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285

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

Fixes: c43ca5091a37 ("perf/x86/amd: Add support for AMD NB and L2I "uncore" counters")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---

Previous versions can be found at:
v1: https://lore.kernel.org/all/0f2cff983d79521e153d211ce412fedbc4ed942c.1782211518.git.sandipan.das@amd.com/

Changes in v2:
  * Fix handling of disabled sibling events as pointed out by sashiko.
  * Add a Fixes tag as suggested by Ian.
  * Remove redundant is_software_event() check as event->pmu matching
    seems to be sufficient.

---
 arch/x86/events/amd/uncore.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index dbc00b6dd69e..222dfab9225f 100644
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
+	if (leader->pmu == event->pmu)
+		counters++;
+
+	for_each_sibling_event(sibling, leader) {
+		if (sibling->pmu == event->pmu &&
+		    sibling->state > PERF_EVENT_STATE_OFF)
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
@@ -282,6 +305,14 @@ static int amd_uncore_event_init(struct perf_event *event)
 	if (!ctx)
 		return -ENODEV;
 
+	/*
+	 * Ensure that all events in a group can be scheduled together so that
+	 * a failure can be reported at perf_event_open() time rather than
+	 * silently at pmu->add() time when no free counter is found
+	 */
+	if (event->group_leader != event && !amd_uncore_group_valid(event))
+		return -EINVAL;
+
 	/*
 	 * NB and Last level cache counters (MSRs) are shared across all cores
 	 * that share the same NB / Last level cache.  On family 16h and below,
-- 
2.53.0


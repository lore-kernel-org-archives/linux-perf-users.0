Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3037E2EF;
	Thu,  8 Jan 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858800; cv=fail; b=nGch/j/p7bxZhopkylqfk1Ky60SbT2pICPNkScthCEc6Y44cJkhav5WXNIUrGQPgwscyrd/I3URWF+IkFYcVlXdBHNuYbLewk1ho+LjHe10VU4/Jk6BlT91IR8T+hLf+rDii2NWu9iHwFQuRuef3wNezbqMifmg+w13Y+JnStMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858800; c=relaxed/simple;
	bh=blpkrKyUdAYZ5MxT9AKpUrrcyPsKE9yOmklleembBSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+LCundiSfJqdR5fneKOwQjncIInIOyVb2tM+0N3gviJOR9trxS3vo9HWA0cRl3Xz9Zb9OVxWpDd0ZdIUNIA6Ep4slj61/v723iXmlBCpjzkliiu122Y78TzE+9TjsyY9bSZPxNbXCWjS9TtOfaH/SxD+DlKoyOpWULeUnwHMHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1s82EKIp; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1s82EKIp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH4uhT01UUIRxT1JQLc2J611BIJcE7AJlJx5S3rkWhDcJxGrVEFrzlqVZQZtPNgP4oi2bK55Efm8jllju6GaDlYyiNEQ86KlPJDU44j46VdrYCU1ALgTkKPjBFLAto3RLnY6hCcSmchR1FRFSE83RzEBKgvaQ6AIxHhLEFRgVr81rWObkNKWuHypxK+q8E1D8a6HyWfjO0htLyXzv4mg2pZAe8y/2cSnamG0D863ZknTwIi3VF931UWuKQQyQNumbdtv80C3afABPDZrx1kiPJpmGkKgyTEaCShfgF/lCMah0wBM3yAhWoICcS2P4zDzPsclGf9lNGj5Bbb5RhkU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoyu32dEnlrdrn5j1Jcf/GAfkyDY5Ig+LvXWYBEsaM8=;
 b=HcVYv/+ZAglwSpHs5KsX0Txjl8LX0Te/waRN1HUzDLYr4s75pcVBgGEqEsFXQV8PF9vWrvzkatbbNSwWHs/bSm6F5z/Z2TH8OnqcXmF0t2new6n9peu7ia3C1rEysxcGf2WYSCN967vtFyHh6Sgp4rkl5sHv6NBa6Cnwyckj12ADZDkOxDObLhG/E3P22En+ftdEerE34uZkDly3zQ5S4FdoXvPIZ+qTyX6VkaeElxwdE2c4IyOeYub5EHI645OPatYgzT6FiAwacU/7R6N4nbEb5pP61aVTviXrIHwrofpFzrZw/M6N8hVHTtNizxIEo4zglKH6aMCshLEKCOe6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoyu32dEnlrdrn5j1Jcf/GAfkyDY5Ig+LvXWYBEsaM8=;
 b=1s82EKIp4Sa5zme7GPQxQUTA78riay83SYoW9rQq6xYVzJyLQmr5/h4AW0Qm87cZSr+vgxpnZnbvTEWhm2xguACUmKW0mkReARJ8m0s0JjWeIcYIG8VIppLHMbCT+qAH0p8hmZIl3reAkEES+kyOn3zE/OKeQI2+BFUpSqo0ZQA=
Received: from BY5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:1e0::32)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:53:05 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::27) by BY5PR03CA0022.outlook.office365.com
 (2603:10b6:a03:1e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 07:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 07:53:05 +0000
Received: from sindhu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 01:53:00 -0600
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
Subject: [PATCH 2/4] perf vendor events amd: Add Zen 6 uncore events
Date: Thu, 8 Jan 2026 13:22:15 +0530
Message-ID: <b00e27727d8aea8cf49c5e6e08b29357d04bc2b8.1767858676.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1767858676.git.sandipan.das@amd.com>
References: <cover.1767858676.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DS2PR12MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: c02221db-62ad-49d6-6c8e-08de4e8af505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1PSpgnr4xlh2r8Acrsby/KFn3pNETSvG9fmzoWOqF5EqlnQEMzajCerkuain?=
 =?us-ascii?Q?Bh4Z3YVohY4QqGmfM8EDYAeINOy4h8faT6qZnjkWFwqrLXeGpCTYrQmxZCgD?=
 =?us-ascii?Q?CMNtGBF9Yu3hTTjbN3V7h2KM+CZGJAzBcHO8jrHODxvtfiDydGwJVgTy7Aa+?=
 =?us-ascii?Q?WWwdQTguDOnWoUpr9DjfVLhVx39JnV2A/V+6j64MSBXw2nJ375wa4hIu4WWN?=
 =?us-ascii?Q?8HXN1PgYNvqGwNfHm71I9E94mXjqsbnxN/G5plAwCm9Hj2SBCSS7D42Z2rnP?=
 =?us-ascii?Q?f5OYv+K7sWPg9j6QtuLz9LfGsG3IaU0nCapktVLcAK8Ck4mD3nRTYYewTceF?=
 =?us-ascii?Q?KH2PtITFI74Uc16QhFIhvzSLyw+QXSYvhGYdhC9bSud1dnvFT4P3Zc/pSX6U?=
 =?us-ascii?Q?6WfzwhyCGb8Og9AL6bsKBlgk56ZIWlMn8eVsSMhiuMp3VdbNYod224G8URAd?=
 =?us-ascii?Q?nCdkHit/17TU4A7ngEdDeEo+Xljw7qGCoopabV93mhOuRLt3CUYuuZU+VZ4D?=
 =?us-ascii?Q?NE4TCpMDAcdvcVl0aT8v0uZ1uy81wLb2tyZcnja3/eTkj1DT1v8zCb/MzQYD?=
 =?us-ascii?Q?tdBSDwrDv+5IrJQ116mFhUF2LPP3eEUrppydLVYwV4Gi7uF1KlIe6tB7epP2?=
 =?us-ascii?Q?YGBIHPfL7kIi4xruW9HFwIbGUKGNYaIujhodCwTA9vrCB/rC0pfiafcZQMAF?=
 =?us-ascii?Q?3dA96a4V18jnX0qGopzi9jT7psQg3/UoyvtsEbiRRIAEnluyYk80mb5gdm9l?=
 =?us-ascii?Q?o5O6p2PdhSGAbKQuYj3XDhZdiwt6kkS+cxWXeDbwUsHMifPVLSIjlsVKZIyp?=
 =?us-ascii?Q?0Ccs/mQ5dbPTFokz4iB72Wgahpl0c0q8dLraeU/K4pO3aVmxNKFB9gk/OOiw?=
 =?us-ascii?Q?iixTNrrWT0hRW1vXrei7zYpdsxnmqLfRJZc67D4YmwD8SmeXPcGMavrfaKK7?=
 =?us-ascii?Q?zTfS1Y1nu1Y5C/pDnDwpYJrce/2NLkPz4KGRAujfi/odaFLb+ra9DsFw2aVL?=
 =?us-ascii?Q?pYKkuTgSTm+2f+xkjb0pQk9t6dz1TgjQBzbK3br8SeVqbq1FXsxUglzZK9mS?=
 =?us-ascii?Q?sHPz7LnLb1RmdlDtpdXiChUqGyn3hwnlGxbVR3Ge30CD4DRQzYWZ+FUn7beP?=
 =?us-ascii?Q?qjskSP8BlxnBVd8+9OALEaOr+2HDe8NvwPrN+bGW5u2HdyYxFVsmHSN8wn6s?=
 =?us-ascii?Q?UShAr1OPK76oBCVxFXPIFcoSjPsON5W6KTL9E404o4ctrex+ESqCETr/y2C/?=
 =?us-ascii?Q?+Lj6SjLGFz9WUWtGyZGciHnfd501nrJPfLkuiF8ajwn6agXFcZIDTC+m20LS?=
 =?us-ascii?Q?WGw960zfq1WQpTrK0v+yBUMsdJg9h50GlDvexMpN7C88neGxmuik9DdPlSfe?=
 =?us-ascii?Q?5K0iLXUCgQ6CHucEmJ6iUoCwH1YPzkKX8MvGCQ1sUdxhpdirI3O90C0CZfUh?=
 =?us-ascii?Q?mw5zN7/kJ9t19c/egov0LfGSfly52M5mkJOLKZwpEA9mwIwCJ+ArIQVWensK?=
 =?us-ascii?Q?oW1H85cP41fdE1WgLZzB509LsWWy11YJ5XyVu5EIErwPGgb/6C6H58XeHpAW?=
 =?us-ascii?Q?wLTCXikuTMRd9EktOac=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:53:05.5377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c02221db-62ad-49d6-6c8e-08de4e8af505
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798

Add uncore events taken from Section 1.6 "L3 Cache Performance Monitor
Counters" and Section 2.2 "UMC Performance Monitor Events" of the
Performance Monitor Counters for AMD Family 1Ah Model 50h-57h Processors
document available at the link below.

This constitutes events which capture L3 cache and UMC command activity.

Link: https://bugzilla.kernel.org/attachment.cgi?id=309149
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../pmu-events/arch/x86/amdzen6/l3-cache.json | 177 ++++++++++++++++++
 .../arch/x86/amdzen6/memory-controller.json   | 101 ++++++++++
 2 files changed, 278 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json b/tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
new file mode 100644
index 000000000000..9b9804317da7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
@@ -0,0 +1,177 @@
+[
+  {
+    "EventName": "l3_lookup_state.l3_miss",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 cache misses.",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.l3_hit",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 cache hits.",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_coherent_accesses_to_l3",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 cache requests for all coherent accesses.",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.dram_near",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency for L3 requests where data is returned from DRAM in the same NUMA node.",
+    "UMask": "0x01",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.dram_far",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency for L3 requests where data is returned from DRAM in a different NUMA node.",
+    "UMask": "0x02",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.near_cache",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency for L3 requests where data is returned from cache of another CCX in the same NUMA node.",
+    "UMask": "0x04",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.far_cache",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency for L3 requests where data is returned from cache of another CCX in a different NUMA node.",
+    "UMask": "0x08",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.ext_near",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency for L3 requests where data is returned from extension memory (CXL) in the same NUMA node.",
+    "UMask": "0x10",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.ext_far",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency for L3 requests where data is returned from extension memory (CXL) in a different NUMA node.",
+    "UMask": "0x20",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.all",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency for L3 requests where data is returned from all types of sources.",
+    "UMask": "0x3f",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.dram_near",
+    "EventCode": "0xad",
+    "BriefDescription": "Average sampled L3 requests where data is returned from DRAM in the same NUMA node.",
+    "UMask": "0x01",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.dram_far",
+    "EventCode": "0xad",
+    "BriefDescription": "Average sampled L3 requests where data is returned from DRAM in a different NUMA node.",
+    "UMask": "0x02",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.near_cache",
+    "EventCode": "0xad",
+    "BriefDescription": "Average sampled L3 requests where data is returned from cache of another CCX in the same NUMA node.",
+    "UMask": "0x04",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.far_cache",
+    "EventCode": "0xad",
+    "BriefDescription": "Average sampled L3 requests where data is returned from cache of another CCX in a different NUMA node.",
+    "UMask": "0x08",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.ext_near",
+    "EventCode": "0xad",
+    "BriefDescription": "Average sampled L3 requests where data is returned from extension memory (CXL) in the same NUMA node.",
+    "UMask": "0x10",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.ext_far",
+    "EventCode": "0xad",
+    "BriefDescription": "Average sampled L3 requests where data is returned from extension memory (CXL) in a different NUMA node.",
+    "UMask": "0x20",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.all",
+    "EventCode": "0xad",
+    "BriefDescription": "Average sampled L3 requests where data is returned from all types of sources.",
+    "UMask": "0x3f",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json b/tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json
new file mode 100644
index 000000000000..649a60b09e1b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json
@@ -0,0 +1,101 @@
+[
+  {
+    "EventName": "umc_mem_clk",
+    "PublicDescription": "Memory clock (MEMCLK) cycles.",
+    "EventCode": "0x00",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.all",
+    "PublicDescription": "ACTIVATE commands sent.",
+    "EventCode": "0x05",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.rd",
+    "PublicDescription": "ACTIVATE commands sent for reads.",
+    "EventCode": "0x05",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.wr",
+    "PublicDescription": "ACTIVATE commands sent for writes.",
+    "EventCode": "0x05",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.all",
+    "PublicDescription": "PRECHARGE commands sent.",
+    "EventCode": "0x06",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.rd",
+    "PublicDescription": "PRECHARGE commands sent for reads.",
+    "EventCode": "0x06",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.wr",
+    "PublicDescription": "PRECHARGE commands sent for writes.",
+    "EventCode": "0x06",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.all",
+    "PublicDescription": "CAS commands sent.",
+    "EventCode": "0x0a",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.rd",
+    "PublicDescription": "CAS commands sent for reads.",
+    "EventCode": "0x0a",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.wr",
+    "PublicDescription": "CAS commands sent for writes.",
+    "EventCode": "0x0a",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.all",
+    "PublicDescription": "Clock cycles where the data bus is utilized.",
+    "EventCode": "0x14",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.rd",
+    "PublicDescription": "Clock cycles where the data bus is utilized for reads.",
+    "EventCode": "0x14",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.wr",
+    "PublicDescription": "Clock cycles where the data bus is utilized for writes.",
+    "EventCode": "0x14",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  }
+]
-- 
2.43.0


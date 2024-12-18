Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2E1BEF9E;
	Wed, 18 Dec 2024 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524302; cv=fail; b=mypz6AX7qscjDZRTwMsvcqmA8JcY7VKRm2XyVhVVYJe8rqlPkJSeBsExexK1QhKsVJX60FTT8BUgHiZbVnRXUE4D/DKNtHXv/Wbkqn7EL9eVNkrQE9EUW6T7xHsUHYoIHuijYf+6QRRILzQSXuMHINGS/rHz5qMRsekjLFfmzXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524302; c=relaxed/simple;
	bh=m3is8Hdo4yN/ovjknpavmij0PU+R+Y1NPb37tuBDoNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVn+Ows3z7E10o6oZCZ0yxpjsfKJyBJrE8BB+cuu0EmlesoDQQtYhqiBPGpJtJbYpt9xfFGbuTKyaDAsft3RhOTF3vr0V3zJjYyWdH3S/urHWNm1iI19zvRJKuo5Tx8CDwm3iwo9taChyVLUMJdncyO6hZgkyOecX1Ir2najEQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GPyiJn9v; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GPyiJn9v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZfMQP1phL3C0bhRwSxa/AVgw1RqX5xk4cdjiQwr6AA2Wk1MT1xCo9NLeA3YNC7JiGRRdnGW2r9i1gEMYrKssZoJDg5nodB/Lv2pC3vyGbP2CuIm307D/31aOE48h6wrbh0pz024bjlHPakxHdCi0MP8Et2jFvoa75+3r8MRHPRSixVKJUsPeodZ5cPka1crSaztzgBF3TQYtERiHowS3NxdhYKupGP+oivT1EWeDGLI4UBdf3NGmAyYwubJZ6i1uAdw+A/D4puEh/ghWUDwtIxnKN0SpimAwDG1wB6w9NJ6geOz0ERwuzsMz8ZJNCNmdOly0O5s0Sal/Ie/LihXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fOunl9dtBMReyo7FfrktLQoqCz/rf/Hlv7sByAXFd0=;
 b=gw7sheYacrUPxYzvzWVl6ymgQgQO43cXzBir0kb0saK8n5Aap9fY5ZngLAPeEZuHADc/WesKMR3ubIVhDIM5WGX76F2LaqlQ30YYrmotrNO95vrib+Q5N4lhORcxUvpWOiboOSktsQT3BrDaKvEof+u82xrmDsymVYbNZwKlP/gu5X7NbZuz92J+ZHccLS+TeQLSYLHAnq85lUHPqX+7H0F3SsFvBpo4LzWSGH633iDs+giUln4yumcBHnTTcoGcEcwjVh8bdwK8ktXn5lZA94RJ3bmhrtwzVa07mMSsbGvLoocuqFDmKGXPLXqZChRMwoAJV4MtAB59bKD2cK+ZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fOunl9dtBMReyo7FfrktLQoqCz/rf/Hlv7sByAXFd0=;
 b=GPyiJn9v2ZfykI2vnPKDUF7nr1vCKxMpdS8ku8A2kM5FSPf1s4Qkh2B26xKP3HjrEPw3p4B9u2pFBjdzG/6lauttjrs72l4M0DbulnF9oCh0biZXKPkTOsSDmosOcgQjONI2QFGKTaX6MseDsRSfougNOR0i1N86hOh7eJ5TTvE=
Received: from DS7PR03CA0187.namprd03.prod.outlook.com (2603:10b6:5:3b6::12)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 12:18:14 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::5d) by DS7PR03CA0187.outlook.office365.com
 (2603:10b6:5:3b6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 12:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 12:18:14 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 06:18:09 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <kan.liang@linux.intel.com>,
	<bp@alien8.de>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 6/6] perf mem/c2c amd: Add ldlat support
Date: Wed, 18 Dec 2024 12:14:37 +0000
Message-ID: <20241218121437.1717-7-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218121437.1717-1-ravi.bangoria@amd.com>
References: <20241218121437.1717-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 3783fd64-910d-4b1e-eb43-08dd1f5e0bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k7K6XwSjziDRQECQ4h5e5gWBbndCaQxWtH1JCcS4iHSDVfZiJK00mCNFLsZx?=
 =?us-ascii?Q?fQirbcPvMLw+nfVCL9VZNVax6pTj9HjPUIlvxudQ0a3SixnU+4mW28qZKZX2?=
 =?us-ascii?Q?/8B2Y3150wjeFawcflQNcH7LNcXqhzn2T1NB6d6iqA/tT4uc0sElki9h9hPp?=
 =?us-ascii?Q?JjwT/EkBN7k5QyiCjjhLqcTVyxC0V7fYZw1gMix0vmXl5IlLtDXYytIXi7yZ?=
 =?us-ascii?Q?oR3fYBG+ga+U5VeoDfA1dZedfnOd8jVWCNTgrcXgys0oRxGBwljbA7vPRi3Q?=
 =?us-ascii?Q?WqDpE/VuZIThk7oA3S8A7imQ4floiNaRNrWf7cLXlwBkLngjcP1Z+ZCumj4o?=
 =?us-ascii?Q?squg9jUWXFGgA3PY3PW9fKBrUCpQtDqH37MAQj+Q8R5drwJE8bQ/ZQgMLdWc?=
 =?us-ascii?Q?9PESRNg0oxEC58RX3qa/YPQiepkgecIFYNCwXnP0/bUYimoBRbrfW00HiA3j?=
 =?us-ascii?Q?HT7gngtgLVvl1WrndJZZMpEYQfS5A6TRQB/ZIrtxwb5c8/WZ3Zrf2aPrqTGw?=
 =?us-ascii?Q?gi0oD575+A+nZKnlUXhaAiXKD2hIHIocKVvw2BqBw1PHX1l6T1yYVhIuB9iu?=
 =?us-ascii?Q?x5v15tySwuP09R1q61/gvBVe3bUiKgdGqp4PXqvWiLB2o6PI8yqUCWf/y0p+?=
 =?us-ascii?Q?sngOJPezD77ert6qJaK9pqnIpjZKzhYsGpf/ORD53Pxec7ge6JowiwQlqlNS?=
 =?us-ascii?Q?IYOKe+tkcJsykPK/5r0Av56Yx2M8GKNc9FbNtzggotWfO+ALClbW2THFhKOt?=
 =?us-ascii?Q?1BtKZM7cYSSs/93mYu6K9Dld92TwNDmjW+qj0Uvl/ORTbv28RA5IGvGHHBqz?=
 =?us-ascii?Q?OhdndwTBIGJTLX0GHu/9w2vyLWaaeATUUKU92zKTmkKnluYo/R2jrk4F50Zc?=
 =?us-ascii?Q?48TxFZ2p9XL1K5hYKJ0LRhCl3bXwUZqgROivYwtnVsmxN65kkBbktO1iQSDy?=
 =?us-ascii?Q?av9EoYfwvb7EOFulGaJwurvV7CFgnFIHawkH8F0Oqax402S9BIw61IxSGWfk?=
 =?us-ascii?Q?P8Mun5iK2Ifs1p9CT4qReZ6kSJzplR0D+C0wnRo/LxdFmP1bYZ19nZZ1Eb2p?=
 =?us-ascii?Q?snvITlEOSKMPLzKzhCDdWALtJIyQ65WvNAym6yJWYp2ez4sDCXTytUGMu7hH?=
 =?us-ascii?Q?LrwknrygkjH3iouiGLPnZRNCF4UTF+oXwsPFczlVOFT1inNEd1ZD6yIqBiRp?=
 =?us-ascii?Q?+3Nkq//lD3VgQHPr5LeQc5jSlR9u21gbnY47UvF+Dmq2jqn8aPfderKj0VSp?=
 =?us-ascii?Q?GlNb/jqu4uboJU6U5kFvbLdg2tem5W7Gf75RuIYT3vPN82OaVh/EQenJKxx/?=
 =?us-ascii?Q?36LMK/c9twswO6pB2f4TRfbcyd5OkCr/x1gIEAwEP6hFTe0MHsHie+wmGAgk?=
 =?us-ascii?Q?yZSd4f2mq0pozZCjgC9mJ/XxlYhLy1abNcJEo2lHLQEz9YdytjqjDAfe/A8V?=
 =?us-ascii?Q?J268cVlSyLIYC6/VkEJYNGXtDGqIIIFYQFSc+jDv08ZnSdNZ4Q1RVg9PJ/kW?=
 =?us-ascii?Q?COY7xZ75mkfaW2k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 12:18:14.2353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3783fd64-910d-4b1e-eb43-08dd1f5e0bee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304

Perf mem and c2c uses IBS Op PMU on AMD platforms. IBS Op PMU on Zen5
uarch has added support for Load Latency filtering. Implement perf mem/
c2c --ldlat using IBS Op Load Latency filtering capability.

Some subtle differences between AMD and other arch:
o --ldlat is disabled by default on AMD
o Supported values are 128 to 2048.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-c2c.txt      | 10 ++++++--
 tools/perf/Documentation/perf-mem.txt      | 12 +++++++--
 tools/perf/arch/x86/util/mem-events.c      |  6 +++++
 tools/perf/arch/x86/util/mem-events.h      |  1 +
 tools/perf/arch/x86/util/pmu.c             | 20 ++++++++++++---
 tools/perf/tests/shell/test_data_symbol.sh | 29 +++++++++++++++++++---
 tools/perf/util/pmu.c                      | 11 ++++++++
 tools/perf/util/pmu.h                      |  2 ++
 8 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 856f0dfb8e5a..3e2f690f127a 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -54,8 +54,14 @@ RECORD OPTIONS
 
 -l::
 --ldlat::
-	Configure mem-loads latency. Supported on Intel and Arm64 processors
-	only. Ignored on other archs.
+	Configure mem-loads latency. Supported on Intel, Arm64 and some variants
+	of AMD platforms. Ignored on other archs.
+
+	On AMD platforms:
+	- Supported latency values are 128 to 2048 (both inclusive).
+	- Latency value which is a multiple of 128 incurs a little less profiling
+	  overhead compared to other values.
+	- Load latency filtering is disabled by default.
 
 -k::
 --all-kernel::
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 8a1bd9ff0f86..f28837d6b783 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -28,6 +28,8 @@ and kernel support is required. See linkperf:perf-arm-spe[1] for a setup guide.
 Due to the statistical nature of SPE sampling, not every memory operation will
 be sampled.
 
+On AMD this use IBS Op PMU to sample load-store operations.
+
 COMMON OPTIONS
 --------------
 -f::
@@ -67,8 +69,14 @@ RECORD OPTIONS
 	Configure all used events to run in user space.
 
 --ldlat <n>::
-	Specify desired latency for loads event. Supported on Intel and Arm64
-	processors only. Ignored on other archs.
+	Specify desired latency for loads event. Supported on Intel, Arm64 and
+	some variants of AMD platforms. Ignored on other archs.
+
+	On AMD platforms:
+	- Supported latency values are 128 to 2048 (both inclusive).
+	- Latency value which is a multiple of 128 incurs a little less profiling
+	  overhead compared to other values.
+	- Load latency filtering is disabled by default.
 
 REPORT OPTIONS
 --------------
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index 62df03e91c7e..b38f519020ff 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -26,3 +26,9 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E("mem-ldst",	"%s//",		NULL,	false,	0),
 };
+
+struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX] = {
+	E(NULL,		NULL,		NULL,	false,	0),
+	E(NULL,		NULL,		NULL,	false,	0),
+	E("mem-ldst",	"%s/ldlat=%u/",	NULL,	true,	0),
+};
diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
index f55c8d3b7d59..11e09a256f5b 100644
--- a/tools/perf/arch/x86/util/mem-events.h
+++ b/tools/perf/arch/x86/util/mem-events.h
@@ -6,5 +6,6 @@ extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
 extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX];
 
 extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
+extern struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX];
 
 #endif /* _X86_MEM_EVENTS_H */
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index e0060dac2a9f..8712cbbbc712 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -18,8 +18,10 @@
 #include "mem-events.h"
 #include "util/env.h"
 
-void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
+void perf_pmu__arch_init(struct perf_pmu *pmu)
 {
+	struct perf_pmu_caps *ldlat_cap;
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
 		pmu->auxtrace = true;
@@ -33,8 +35,20 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 #endif
 
 	if (x86__is_amd_cpu()) {
-		if (!strcmp(pmu->name, "ibs_op"))
-			pmu->mem_events = perf_mem_events_amd;
+		if (strcmp(pmu->name, "ibs_op"))
+			return;
+
+		pmu->mem_events = perf_mem_events_amd;
+
+		if (!perf_pmu__caps_parse(pmu))
+			return;
+
+		ldlat_cap = perf_pmu__get_cap(pmu, "ldlat");
+		if (!ldlat_cap || strcmp(ldlat_cap->value, "1"))
+			return;
+
+		perf_mem_events__loads_ldlat = 0;
+		pmu->mem_events = perf_mem_events_amd_ldlat;
 	} else if (pmu->is_core) {
 		if (perf_pmu__have_event(pmu, "mem-loads-aux"))
 			pmu->mem_events = perf_mem_events_intel_aux;
diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index c86da0235059..747f5dc9d679 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -55,11 +55,34 @@ trap cleanup_files exit term int
 
 echo "Recording workload..."
 
-# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
-# user/kernel filtering and per-process monitoring, spin program on
-# specific CPU and test in per-CPU mode.
 is_amd=$(grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
 if (($is_amd >= 1)); then
+	mem_events="$(perf mem record -v -e list 2>&1)"
+	if ! [[ "$mem_events" =~ ^mem\-ldst.*ibs_op/(.*)/.*available ]]; then
+		echo "ERROR: mem-ldst event is not matching"
+		exit 1
+	fi
+
+	# --ldlat on AMD:
+	# o Zen4 and earlier uarch does not support ldlat
+	# o Even on supported platforms, it's disabled (--ldlat=0) by default.
+	ldlat=${BASH_REMATCH[1]}
+	if [[ -n $ldlat ]]; then
+		if ! [[ "$ldlat" =~ ldlat=0 ]]; then
+			echo "ERROR: ldlat not initialized to 0?"
+			exit 1
+		fi
+
+		mem_events="$(perf mem record -v --ldlat=150 -e list 2>&1)"
+		if ! [[ "$mem_events" =~ ^mem-ldst.*ibs_op/ldlat=150/.*available ]]; then
+			echo "ERROR: --ldlat not honored?"
+			exit 1
+		fi
+	fi
+
+	# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't
+	# support user/kernel filtering and per-process monitoring on older
+	# kernels, spin program on specific CPU and test in per-CPU mode.
 	perf mem record -vvv -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM 2>"${ERR_FILE}" &
 else
 	perf mem record -vvv --all-user -o ${PERF_DATA} -- $TEST_PROGRAM 2>"${ERR_FILE}" &
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 08a9d0bd9301..e480fd4744dd 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2103,6 +2103,17 @@ static void perf_pmu__del_caps(struct perf_pmu *pmu)
 	}
 }
 
+struct perf_pmu_caps *perf_pmu__get_cap(struct perf_pmu *pmu, const char *name)
+{
+	struct perf_pmu_caps *caps;
+
+	list_for_each_entry(caps, &pmu->caps, list) {
+		if (!strcmp(caps->name, name))
+			return caps;
+	}
+	return NULL;
+}
+
 /*
  * Reading/parsing the given pmu capabilities, which should be located at:
  * /sys/bus/event_source/devices/<dev>/caps as sysfs group attributes.
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index dbed6c243a5e..b3d4d7c5b92d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -266,6 +266,8 @@ bool pmu_uncore_identifier_match(const char *compat, const char *id);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
+struct perf_pmu_caps *perf_pmu__get_cap(struct perf_pmu *pmu, const char *name);
+
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
-- 
2.43.0


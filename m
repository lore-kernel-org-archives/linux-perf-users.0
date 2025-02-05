Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE4227BB2;
	Wed,  5 Feb 2025 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735612; cv=fail; b=eOp+t0DqHSPGXVSOSSlhKaHvOfkzJAhBGfWMAt2LOjzpJ/lCMFHArES/8qsiGHf4xXsiYKIunJB85p5DI2F3GVPzCuPliiTytVXOVrbTHg7wSG0cRAnbANLyWJmq4LjF0i7rXIyhWRzVUaBEOsB0KA0riFOPhRtB6VPlrQw1+kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735612; c=relaxed/simple;
	bh=xkm9Si+Y1gc3vIB4wzXq5Xl5HE6FLnIiL46VMZ8JL9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Slsy+Q5DbjNA9iXJ1RzVyo3Vw6NRVT6UYYBvc+dJldQBcnmFM23zbJUBn7ARufGRv7nHpqSyrzj9ryYnn7qtADW09/K/THp1vdGkd9lu8E7udN9c3HXeYTe8kLR4zj9GFRWhyitHMxuzIKtP5/deKoAG0Ec2I66DWFlKBs78YeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2PBElOx/; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2PBElOx/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3YEdvrMhJbeLsW0QHJ73IKsMpcSfZUedPEqbzri0yJYRTKsktVin+un6icAHyEgBnvcAKxkRLbsDNnW/A8OPCagc2g0xpdTPk50e+7h1vdyRd+aarNG8jIqJ5JdXHxPi4IJl2c18i5DcFGoR9saHAU0xCNt00RV0Fkn01mnxKfBrWhidDNE0zjL5snsQ4fpm/1Hlc0op0hKntqEwfpO1KaACwivWNIME5sy9CAqswNPAmFYsFGo99byY9+ibyi86m2hXQOq0nnqhumtY5lIq7SWdz5XnuQicCMu6rRIQdWRR/v3PnGkjYmM5cCO18KE6rlrAjKxL1YWfiNjHNeuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt6nSEDoYcS8AgOjkyGNNb2pAqoT3+kTYbeMgj2WNw4=;
 b=ZmFnKgT3frl0nt3NYK9x3q2qOReQPZftPIY06Zyh4SOgLNnOOgD/hgAE+RjaXnkXRQTX7cE1ZpRN/5nO8Z8fg8SzNYfr3toenUg26p3lutV5Us7I7WIkjn6v/gSBPTE81W5Keqjh5br/0VjXLmso4asf2n2GTYIP13VWFFzybhQgwtjemg+jYPCFZPpTugWjsV9NBBPcDljJKKj4DhFXe0kbbnlu7BvlLJko+txLSsxDkc6zAEZx5+444oUUx+Xt7Es+oEEzvR1A2+5Eo3uhq78WoFCj6FEruUeYnfBukcCCOTab5AFRE00z3tWz4/fai29ubcG432jozpIlBOlsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt6nSEDoYcS8AgOjkyGNNb2pAqoT3+kTYbeMgj2WNw4=;
 b=2PBElOx/bFhdwR97pEqapEJxzZ+uE58utReFdbyd4wDp2BZl2ESuWjkAzrIgC6uFInakQmlxGrJeEikoL2ifjt/ewez4CbhaJMeK+07vPGfqH6bKv2gocGXckL9n5LebBSfLUiKetNz0CWctp6VDpGMWXm0AnxrzySqis8jw77o=
Received: from SJ0PR05CA0208.namprd05.prod.outlook.com (2603:10b6:a03:330::33)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 06:06:48 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::33) by SJ0PR05CA0208.outlook.office365.com
 (2603:10b6:a03:330::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 06:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 06:06:48 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 00:06:42 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <mingo@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <jolsa@kernel.org>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 6/7] perf mem/c2c amd: Add ldlat support
Date: Wed, 5 Feb 2025 06:05:46 +0000
Message-ID: <20250205060547.1337-7-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205060547.1337-1-ravi.bangoria@amd.com>
References: <20250205060547.1337-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e83fb41-a769-4da3-a0cb-08dd45ab4691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1lQSnTxu2YoyJPtaMfconUCF7LFVxfuatdP7/RY40vNKxlSDBN0sbGjNQ7Mn?=
 =?us-ascii?Q?u5CrJgCj9UxUil7lVEhPNHzeLMhGl5BgjLWHOYCsPEo8jF7MZ3LMvm3CIkB2?=
 =?us-ascii?Q?Vj4jdpGqwSovTOq6oAV3L7RVvU8Yb1zQ5tpylci79S01wZM0/MFTbRltLF0A?=
 =?us-ascii?Q?QN4RopjofjcXicmRyLyfeqEUop+0fpeaXby+LqJU3euV+kvQ7cwpm03Lh3o7?=
 =?us-ascii?Q?IbHWy63qP/0CggPONGYUuumeCMKIXAzcMYof3TXs5z0hrcfQI0hFKv+Uo+ZD?=
 =?us-ascii?Q?12BjdTPvzCt+A/ta2+9A1paT4lBvLXlHENGCZx0lxQdZ3+3uZ1Pj1NxJ3wdq?=
 =?us-ascii?Q?Hd6eYk0wwl8mYhu9yeSZLFmi6acoYAIvoAYDBdzjUGu4PMF69eOwWiuz2ArH?=
 =?us-ascii?Q?DU12aBnveYoBZEl5fLGOH0YR6uTnJltKhJgjQaV7WYaRlbHnt/BMFiS+f1Ov?=
 =?us-ascii?Q?5l8sXkxNsLKsWgM4O07gzrzGf7JoTgsdeOthQclUXR1jZ3itPxS7JaVj+hMo?=
 =?us-ascii?Q?nw3dY7MUBF56HdJxVLju6S+A3sRGLL2AmVx6kC2vtsNzFTna1is8BpxYZyDw?=
 =?us-ascii?Q?OzokAyXUnFF/AyYq5zFndqdotc3NZCcdiKmjjwq/CuMq+AZtxoFqsR7CMGK0?=
 =?us-ascii?Q?Sy8JmstAJu9vKWj0DVjLDJIvKjla4KpPfZyFXfzbSPdyJKMq5NEYo+oFsS4d?=
 =?us-ascii?Q?UJ2f20ZBLwbGA7v7h6+2+Rrhy7Y98c9KRSc7T8w3+dWsluW1NfggcI9kCSMA?=
 =?us-ascii?Q?So/ZQCAfcTTMriW6aiC8X+5zbUPMkwYYkIBuoBl3V4A9k5OLXmE+e8u1eCiv?=
 =?us-ascii?Q?JKEPQ1R46ZZYjGobwq2z9DlyNL/vDg6lgv3wKDfNKdgFco0nCOHBZMrKRaJE?=
 =?us-ascii?Q?7Z8zZO365WCzbMS23gSNY1xn4/xKVehDqddaU/AdEgpZQDsVuYsgn9C1D8EB?=
 =?us-ascii?Q?1gGEdwRd6fPotSyBkvIWsQwPDmIMtkD87uTTrg5AEuupy9RPpZljFhGcwe9x?=
 =?us-ascii?Q?SwGXXuqYl9PosG0KP+sfF6m6iI6zdWehY8fqQp6xj1tT4wRQ4DDSJyQe7TuZ?=
 =?us-ascii?Q?IgLFkBa7AtKq3Ctv3tQKorC47puvTbKolnwS2wzvlx6BMz86qXz0BcjsDrmv?=
 =?us-ascii?Q?ljuPm0neEErI/tVOQNeo9RcuGXEjaUt8H4wGKaLIjN55Rbti+N5GVEH734oo?=
 =?us-ascii?Q?3rX5sko9/UWXkXSV1aiiuJEzmrzcLmOJBwrqHu3BdDMrVrhiq5NILHMDlktF?=
 =?us-ascii?Q?gksadrlQxc38De90PYDzIAkDw4oNFixmXImP8nj6gstXdGkyPZ4UBxlzYhuw?=
 =?us-ascii?Q?llKKlv4hB8pAjPg1ZZokIqZnT6Z8Hxnpne1R+RcgJlHvyTgdxXOmPYXNwoXF?=
 =?us-ascii?Q?R0Yr73p1XjtI06cHmcccOJQOZGBEPhyuT1jOm99ZhHtS450AphuCIqguXhtK?=
 =?us-ascii?Q?aaGvq/7yfA+XsBtE7uJniXYACVW3mZOUhgJ57+O5i43Fis1ezFQrolXX6Jjz?=
 =?us-ascii?Q?UoJoHwzZ+abTqoA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 06:06:48.0589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e83fb41-a769-4da3-a0cb-08dd45ab4691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181

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
+	On supported AMD platforms:
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
+	On supported AMD platforms:
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
index 6206c8fe2bf9..7053a59083a8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2114,6 +2114,17 @@ static void perf_pmu__del_caps(struct perf_pmu *pmu)
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


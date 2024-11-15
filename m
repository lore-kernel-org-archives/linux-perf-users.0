Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F887181CE1;
	Fri, 15 Nov 2024 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651103; cv=fail; b=BH2ir0n87ljb5e3QVDFKuNgnoIosdf+ciohkcA+D2geOWk+P2YG4LxuBNs1n+QpQMmW+krJlHWkkp7Uc/eoJgsLokX/icO/35WfVDDMD8as8hFZhZ9erX4twTqTQPIcqPB9cehUBujaypInZXRqwGI48mRzDOnchDi0fTe/t5uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651103; c=relaxed/simple;
	bh=frj57svjHjW11bI4pl7gjFl0Cnk+lORQreM/dCbm52U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5eUnE/1VElb4Hta/FmWPkqkoDNExo5+1qs/gta7GuZtgg3FC0DyAyB7Cia14w5+4gAln/2eY0SKIhspe/gbw4YowTrioGXFnHHGREVeU2JuvvVvmuNI799A1fCvIsutUuz+f/N62/HBc+dpqrjjfYxLb4i0E/KTs6nXF9c1e6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NGjPf68G; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NGjPf68G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol4k0GTTv1N9APNyZvbEpkuiWG88ejT7/ayKPS9O9Yf7sSy5KEY6edMwmN8YvxA7yswrx0lYSLuf1tCWGmeYE5fxWUgqzoc3Bdd0GzbJUId/yU+rlmyYOXWeT157RuH08SO4InGxpMfvu3+6QAoAYSLe6RPQEa+wj6P4AZMehQsj9maPtC0G2wPo+aLu7si322iAPtoTYiFLQmP4u9V2Ta78X89MT9HWbt5NwFzIz05d5L9xLoQoB0W4Fva4y2BMOEiod5JJnHjR/V/h50vvX7Zdyj1/XF5V5xK3Rqp8TC0NNvZ6Ygr9Um+XkVp3EQOqGwkMidae7AeCjnJCUXYskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8iwe1QU9nFWB7O8iO6gKvKUKX7pZDiT1EycU9vOdJA=;
 b=tfoBPxsHv4m+zg24tDG+JUL7uCyMJJAeiS2cwSmzi6T3EQGKDpl+wyVL9DsbdUnXufPBfp9/x/xWhpTp7PZrP/HZjPJIH9Luu1VMoy/yl6G7hWyZaTGWXNxYo7Qjvdb9QXGPq8mS4f3g352kVEXWSmw8ddQhZmPHUQOjkohVUf0+ffquLvXOK8DaLe4gBo0MCyIqk7/FnFOnerh6AE0cwRSoRYLGO7uvgPrMxLmUja0DoiqlUjPSNdJFjeQrL1kk6r74/4FdKXS1Fo+TMGnMQxDPXFou5pyny4JaWr2BaH1L3ElrjeopUXot4ufdxJYcH6LsodzSR6HFaM3laUVPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8iwe1QU9nFWB7O8iO6gKvKUKX7pZDiT1EycU9vOdJA=;
 b=NGjPf68Gk02FOmf+o9euPxYRllbnVlHn70Q1+p1603uSTeNK8Wd+qKW7Snc90xZ7LN6KTO6RQNpkQo8SZjHRmA63kUUqmfaRLEoGDpBbfmJtpVRtXALAmpFMi4Q2Z4NtlWk9A5tiWO/0LprHugeAHadQyONCs+iL0TG/fcB7pW4=
Received: from SJ0PR13CA0133.namprd13.prod.outlook.com (2603:10b6:a03:2c6::18)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 06:11:35 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::6f) by SJ0PR13CA0133.outlook.office365.com
 (2603:10b6:a03:2c6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 06:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:11:34 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:11:29 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 10/10] perf/x86/rapl: Add core energy counter support for AMD CPUs
Date: Fri, 15 Nov 2024 06:08:06 +0000
Message-ID: <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: fc50fcfa-a7b8-47d0-8046-08dd053c5b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Vk6ExpOYhEb7uxrl7Jd4y7qZkFj+5Dm3vugaAtPYmZufCGZAjB+k6VsS9f7?=
 =?us-ascii?Q?zbjFHAuiZdYpbfrXk1Atl+FJGqqi1y3d7dPJfcQpjfKPsHgg2xStu20WahMV?=
 =?us-ascii?Q?4k6jc8puT/WrKN1AIpx1fVSf7lxXfEWm+svYEjxmNWzQ6JS3X5jvhFtVkiLi?=
 =?us-ascii?Q?yjbSJo9i0r7gdnstWqJvn+zVzQpSDmw0DvD6RqXLcMkFfsFSJYZKfYBUfN6c?=
 =?us-ascii?Q?Qs5BIw2SFCePKzXl+kQ45OtudiEgG8Ds6YwAxMsue9RKFr8szhKB3Eb2tgcP?=
 =?us-ascii?Q?pab9AMy3PfaT/wUCLHBSe4jSVd5qsV3jyZ0vRSBPnlp531qaYZp4SPOtoWWP?=
 =?us-ascii?Q?3/RajOzv6eeeU1wBvBYsW5s7yyQkxf9SVUM43T1A4qJeTEYqSVLslOpJ4NLV?=
 =?us-ascii?Q?sQXx3GqbKpxchEvljWOBHJzLsevs79X1F0GOcdHVLYYTko5WiuzVNS00xMeB?=
 =?us-ascii?Q?8DI88OOc0YPR7eBoqiyavdkP8ew7B215SeNIQoOSKce3KXjYYdIrj8gyh72U?=
 =?us-ascii?Q?rH/AweMGKwhJJTsuLfzHDh8cMW/kjRkDGj6rZzNwS+eRF6PEMz0W9i2a2lIc?=
 =?us-ascii?Q?HAUPp+FEsuNHeZ8Qy4vZtIpeoWfkeKUEwA7shWb4rIexsdIJN9J676qpiUq9?=
 =?us-ascii?Q?rLn/58z/oAcm9E5ozW+Fl8odkMG8uuTtBTdUElElH8Ycmq/kr++Y2xNJO4Qu?=
 =?us-ascii?Q?g+fAbugwMA84WxmHBZhAxOHATkpicJkiUjaw5dFmQ+JiOyn1RCX/9zWLvtQj?=
 =?us-ascii?Q?nFif3kmJfjCJIGwjyM4gT3cEJnz76SoIlCghQCip0dgjuw3bWn6GT9fjfqkw?=
 =?us-ascii?Q?OUTsiRwVMbAV0eQ2RnINVabF95wZpyppaFOKzmCvrKqCo92dZnN96yO8QTRr?=
 =?us-ascii?Q?RaUbqP9XKsAtsSruH1uYEtMHisXuw1TNMhEqm+Hs0+OycdYVqalIzngLvJag?=
 =?us-ascii?Q?uqkJ2KzRnTfgCKMrEVmDrhgUSxqZpP2GIm3Mr2EXmuNjb13vBjThvTfi3PJt?=
 =?us-ascii?Q?jUmIiZ2KAJBYZEtlBvjWMqYF7WxfNI9DU6jNuzfapVUxs0WxFVjRZM4u+1p+?=
 =?us-ascii?Q?m6KWWAJYouMdu2Cqlo3tm6OT6JucRGdEluXmzqN0wQYKxC4fDc8LuZlOSnN6?=
 =?us-ascii?Q?nDi3rpj7OUKCCGIagSQDSY3N4fOkJK5wjDoNr8cmMJeyShh7FocAfmWRt7FE?=
 =?us-ascii?Q?zKBJmQlaM4ItHe9QDhS6XkJej37bUW+vV5fpjS+Mw+95I0XIHBm0ERuZf36N?=
 =?us-ascii?Q?juBaJ8KuzHn2e3ZpgqNuLhBxG4dDr6pcb9slZztLxYM8f8AD9AXFhiJIYATA?=
 =?us-ascii?Q?noM+GCWUrZbDXjFe58ofNt3enKx/fL/FnahiBzUkrUYyEmBR7uoPwZ7tH+pC?=
 =?us-ascii?Q?MgJXpKUmhrUgP8IKrknGyR1WpgyuvAH/rmUK2UkLszPFYKP72g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:11:34.6245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc50fcfa-a7b8-47d0-8046-08dd053c5b8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

Add a new "power_core" PMU and "energy-core" event for monitoring
energy consumption by each individual core. The existing energy-cores
event aggregates the energy consumption of CPU cores at the package level.
This new event aligns with the AMD's per-core energy counters.

Tested the package level and core level PMU counters with workloads
pinned to different CPUs.

Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa
machine:

$ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
stress-ng: info:  [21250] setting to a 5 second run per stressor
stress-ng: info:  [21250] dispatching hogs: 1 matrix
stress-ng: info:  [21250] successful run completed in 5.00s

 Performance counter stats for 'system wide':

S0-D0-C0              1               0.00 Joules power_core/energy-core/
S0-D0-C1              1               0.00 Joules power_core/energy-core/
S0-D0-C2              1               0.00 Joules power_core/energy-core/
S0-D0-C3              1               0.00 Joules power_core/energy-core/
S0-D0-C4              1               8.43 Joules power_core/energy-core/
S0-D0-C5              1               0.00 Joules power_core/energy-core/
S0-D0-C6              1               0.00 Joules power_core/energy-core/
S0-D0-C7              1               0.00 Joules power_core/energy-core/
S0-D1-C8              1               0.00 Joules power_core/energy-core/
S0-D1-C9              1               0.00 Joules power_core/energy-core/
S0-D1-C10             1               0.00 Joules power_core/energy-core/

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 arch/x86/events/rapl.c | 185 +++++++++++++++++++++++++++++++++--------
 1 file changed, 152 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 6e51386ff91f..e9be1f31163d 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -39,6 +39,10 @@
  *	  event: rapl_energy_psys
  *    perf code: 0x5
  *
+ *  core counter: consumption of a single physical core
+ *	  event: rapl_energy_core (power_core PMU)
+ *    perf code: 0x1
+ *
  * We manage those counters as free running (read-only). They may be
  * use simultaneously by other tools, such as turbostat.
  *
@@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
 	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
 };
 
+#define PERF_RAPL_CORE			0		/* single core */
+#define PERF_RAPL_CORE_EVENTS_MAX	1
+#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
+
 static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
 	"pp0-core",
 	"package",
@@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
 	"psys",
 };
 
+static const char *const rapl_core_domain_name __initconst = "core";
+
 /*
  * event code: LSB 8 bits, passed in attr->config
  * any other bit is reserved
@@ -141,14 +151,18 @@ enum rapl_unit_quirk {
 
 struct rapl_model {
 	struct perf_msr *rapl_pkg_msrs;
+	struct perf_msr *rapl_core_msrs;
 	unsigned long	pkg_events;
+	unsigned long	core_events;
 	unsigned int	msr_power_unit;
 	enum rapl_unit_quirk	unit_quirk;
 };
 
  /* 1/2^hw_unit Joule */
 static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
+static int rapl_core_hw_unit __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
+static struct rapl_pmus *rapl_pmus_core;
 static u64 rapl_timer_ms;
 static struct rapl_model *rapl_model;
 
@@ -156,14 +170,23 @@ static struct rapl_model *rapl_model;
  * Helper function to get the correct topology id according to the
  * RAPL PMU scope.
  */
-static inline unsigned int get_rapl_pmu_idx(int cpu)
-{	/*
+static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
+{
+	/*
 	 * Returns unsigned int, which converts the '-1' return value
 	 * (for non-existent mappings in topology map) to UINT_MAX, so
 	 * the error check in the caller is simplified.
 	 */
-	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
-					     topology_logical_die_id(cpu);
+	switch (scope) {
+	case PERF_PMU_SCOPE_PKG:
+		return topology_logical_package_id(cpu);
+	case PERF_PMU_SCOPE_DIE:
+		return topology_logical_die_id(cpu);
+	case PERF_PMU_SCOPE_CORE:
+		return topology_logical_core_id(cpu);
+	default:
+		return -EINVAL;
+	}
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -173,19 +196,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
 	return raw;
 }
 
-static inline u64 rapl_scale(u64 v, int cfg)
+static inline u64 rapl_scale(u64 v, struct perf_event *event)
 {
-	if (cfg > NR_RAPL_PKG_DOMAINS) {
-		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
-		return v;
-	}
+	int hw_unit = rapl_pkg_hw_unit[event->hw.config - 1];
+
+	if (event->pmu->scope == PERF_PMU_SCOPE_CORE)
+		hw_unit = rapl_core_hw_unit;
+
 	/*
 	 * scale delta to smallest unit (1/2^32)
 	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
 	 * or use ldexp(count, -32).
 	 * Watts = Joules/Time delta
 	 */
-	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
+	return v << (32 - hw_unit);
 }
 
 static u64 rapl_event_update(struct perf_event *event)
@@ -212,7 +236,7 @@ static u64 rapl_event_update(struct perf_event *event)
 	delta = (new_raw_count << shift) - (prev_raw_count << shift);
 	delta >>= shift;
 
-	sdelta = rapl_scale(delta, event->hw.config);
+	sdelta = rapl_scale(delta, event);
 
 	local64_add(sdelta, &event->count);
 
@@ -341,13 +365,14 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
 static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
-	int bit, ret = 0;
+	int bit, rapl_pmus_scope, ret = 0;
 	struct rapl_pmu *rapl_pmu;
 	unsigned int rapl_pmu_idx;
+	struct rapl_pmus *rapl_pmus;
 
-	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus_pkg->pmu.type)
-		return -ENOENT;
+	/* unsupported modes and filters */
+	if (event->attr.sample_period) /* no sampling */
+		return -EINVAL;
 
 	/* check only supported bits are set */
 	if (event->attr.config & ~RAPL_EVENT_MASK)
@@ -356,31 +381,49 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
+	rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
+	if (!rapl_pmus)
 		return -EINVAL;
-
-	cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
-	bit = cfg - 1;
-
-	/* check event supported */
-	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
+	rapl_pmus_scope = rapl_pmus->pmu.scope;
+
+	if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
+		/* only look at RAPL package events */
+		if (event->attr.type != rapl_pmus_pkg->pmu.type)
+			return -ENOENT;
+
+		cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
+		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
+			return -EINVAL;
+
+		bit = cfg - 1;
+		event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
+	} else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
+		/* only look at RAPL core events */
+		if (event->attr.type != rapl_pmus_core->pmu.type)
+			return -ENOENT;
+
+		cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
+		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
+			return -EINVAL;
+
+		bit = cfg - 1;
+		event->hw.event_base = rapl_model->rapl_core_msrs[bit].msr;
+	} else
 		return -EINVAL;
 
-	/* unsupported modes and filters */
-	if (event->attr.sample_period) /* no sampling */
+	/* check event supported */
+	if (!(rapl_pmus->cntr_mask & (1 << bit)))
 		return -EINVAL;
 
-	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
-	if (rapl_pmu_idx >= rapl_pmus_pkg->nr_rapl_pmu)
+	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu, rapl_pmus_scope);
+	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
 		return -EINVAL;
-
 	/* must be done before validate_group */
-	rapl_pmu = rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx];
+	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
 	if (!rapl_pmu)
 		return -EINVAL;
 
 	event->pmu_private = rapl_pmu;
-	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -397,12 +440,14 @@ RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
 RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
 RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
 RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
+RAPL_EVENT_ATTR_STR(energy-core,   rapl_core, "event=0x01");
 
 RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-core.unit,   rapl_core_unit, "Joules");
 
 /*
  * we compute in 0.23 nJ increments regardless of MSR
@@ -412,6 +457,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
 RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-core.scale,   rapl_core_scale, "2.3283064365386962890625e-10");
 
 /*
  * There are no default events, but we need to create
@@ -444,6 +490,12 @@ static const struct attribute_group *rapl_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *rapl_core_attr_groups[] = {
+	&rapl_pmu_format_group,
+	&rapl_pmu_events_group,
+	NULL,
+};
+
 static struct attribute *rapl_events_cores[] = {
 	EVENT_PTR(rapl_cores),
 	EVENT_PTR(rapl_cores_unit),
@@ -504,6 +556,18 @@ static struct attribute_group rapl_events_psys_group = {
 	.attrs = rapl_events_psys,
 };
 
+static struct attribute *rapl_events_core[] = {
+	EVENT_PTR(rapl_core),
+	EVENT_PTR(rapl_core_unit),
+	EVENT_PTR(rapl_core_scale),
+	NULL,
+};
+
+static struct attribute_group rapl_events_core_group = {
+	.name  = "events",
+	.attrs = rapl_events_core,
+};
+
 static bool test_msr(int idx, void *data)
 {
 	return test_bit(idx, (unsigned long *) data);
@@ -541,6 +605,11 @@ static struct perf_msr amd_rapl_pkg_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
+static struct perf_msr amd_rapl_core_msrs[] = {
+	[PERF_RAPL_CORE] = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_core_group,
+				 test_msr, false, RAPL_MSR_MASK },
+};
+
 static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
@@ -552,6 +621,8 @@ static int rapl_check_hw_unit(void)
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
 		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
+	rapl_core_hw_unit = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
+
 	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
@@ -570,7 +641,6 @@ static int rapl_check_hw_unit(void)
 		break;
 	}
 
-
 	/*
 	 * Calculate the timer rate:
 	 * Use reference of 200W for scaling the timeout to avoid counter
@@ -589,9 +659,13 @@ static int rapl_check_hw_unit(void)
 static void __init rapl_advertise(void)
 {
 	int i;
+	int num_counters = hweight32(rapl_pmus_pkg->cntr_mask);
+
+	if (rapl_pmus_core)
+		num_counters += hweight32(rapl_pmus_core->cntr_mask);
 
 	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_pmus_pkg->cntr_mask), rapl_timer_ms);
+		num_counters, rapl_timer_ms);
 
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
 		if (rapl_pmus_pkg->cntr_mask & (1 << i)) {
@@ -599,6 +673,10 @@ static void __init rapl_advertise(void)
 				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
 		}
 	}
+
+	if (rapl_pmus_core && (rapl_pmus_core->cntr_mask & (1 << PERF_RAPL_CORE)))
+		pr_info("hw unit of domain %s 2^-%d Joules\n",
+			rapl_core_domain_name, rapl_core_hw_unit);
 }
 
 static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
@@ -619,6 +697,10 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
+static const struct attribute_group *rapl_core_attr_update[] = {
+	&rapl_events_core_group,
+};
+
 static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 {
 	struct rapl_pmu *rapl_pmu;
@@ -645,13 +727,22 @@ static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 	return -ENOMEM;
 }
 
-static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope,
+				 const struct attribute_group **rapl_attr_groups,
+				 const struct attribute_group **rapl_attr_update)
 {
 	int nr_rapl_pmu = topology_max_packages();
 	struct rapl_pmus *rapl_pmus;
 
+	/*
+	 * rapl_pmu_scope must be either PKG, DIE or CORE
+	 */
 	if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
 		nr_rapl_pmu	*= topology_max_dies_per_package();
+	else if (rapl_pmu_scope == PERF_PMU_SCOPE_CORE)
+		nr_rapl_pmu	*= topology_num_cores_per_package();
+	else if (rapl_pmu_scope != PERF_PMU_SCOPE_PKG)
+		return -EINVAL;
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
@@ -740,8 +831,10 @@ static struct rapl_model model_spr = {
 
 static struct rapl_model model_amd_hygon = {
 	.pkg_events	= BIT(PERF_RAPL_PKG),
+	.core_events	= BIT(PERF_RAPL_CORE),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
+	.rapl_core_msrs	= amd_rapl_core_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -813,7 +906,8 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope);
+	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope, rapl_attr_groups,
+			     rapl_attr_update);
 	if (ret)
 		return ret;
 
@@ -825,6 +919,27 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		goto out;
 
+	if (rapl_model->core_events) {
+		ret = init_rapl_pmus(&rapl_pmus_core, PERF_PMU_SCOPE_CORE,
+				     rapl_core_attr_groups,
+				     rapl_core_attr_update);
+		if (ret) {
+			pr_warn("power-core PMU initialization failed (%d)\n", ret);
+			goto core_init_failed;
+		}
+
+		rapl_pmus_core->cntr_mask = perf_msr_probe(rapl_model->rapl_core_msrs,
+						     PERF_RAPL_CORE_EVENTS_MAX, false,
+						     (void *) &rapl_model->core_events);
+
+		ret = perf_pmu_register(&rapl_pmus_core->pmu, "power_core", -1);
+		if (ret) {
+			pr_warn("power-core PMU registration failed (%d)\n", ret);
+			cleanup_rapl_pmus(rapl_pmus_core);
+		}
+	}
+
+core_init_failed:
 	rapl_advertise();
 	return 0;
 
@@ -837,6 +952,10 @@ module_init(rapl_pmu_init);
 
 static void __exit intel_rapl_exit(void)
 {
+	if (rapl_pmus_core) {
+		perf_pmu_unregister(&rapl_pmus_core->pmu);
+		cleanup_rapl_pmus(rapl_pmus_core);
+	}
 	perf_pmu_unregister(&rapl_pmus_pkg->pmu);
 	cleanup_rapl_pmus(rapl_pmus_pkg);
 }
-- 
2.34.1


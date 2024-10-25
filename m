Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D91F9EA1;
	Fri, 25 Oct 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855054; cv=fail; b=kIsmc2lk4ZUUs8Y4cMBC4IDVf9fwSfyiQ8WsyRktIP8Qe/zLSSksqbrBlIa4CfPoKEi7UyECLo3QqNmX1HtcFVTaBbyhOqyVxRsrLp6glk0R/ZFtp60uzsIKrqfS8AeFZ8h+MmqGlyYiHKw7tlZX2J3FVBaxyH0VskdwcDOyJ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855054; c=relaxed/simple;
	bh=UQFmXGBVWLQyrXAo5P2iJsex9h0NbHQaBxeeggVZTLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqYUlO0mbAJyWUg1HXeB2MW1SX0m1ix8omKATijyrDgBJ9JbuPhzGyPvVMp7dQk3q13RaEuiKRHiriUihrzLuAmgZQwxFAYK//CuCbkU6fhNrvQ3gKKkHubgX7c+qVyh6NZfaQtI7jHCh54eKFCxUpEcxc+ZGMHL0FWYPjINk6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4e/UsgP5; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4e/UsgP5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUudwlajc+vhVim7ZPTUlDjAnhngUfEpWbDhfcUdOEQoXSrp+YaR3F5dt1EshH+d773S5+0RhKl251Jn0kvPgddZoltmaaTuKWGXV/SVTk9sAfQmsXQeQ+teFbSq54QK5nJBtfsLqfo9zqbtvtgzNtjoY/ZjmeDSA3CDlg6kHNBiVgr9l8BiMwmysNJ5b9rMz+lBQE88JgkgFRf+FqynvC+GntUTmnhdz3m+fGuIMKXAgR/4EBO7Zd/QLFkbMAPTiNtLeEdDeHcCXfLRbYVM/HOX8fIlcCQrXqUxJ1TG9uS6I+MoVDkvsuy0UOuk/rhLYVeYIgkRKZWMVlCRxbIFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWGIdtphgUybql2H2vcEM9l+2kPm3KdKbzzcyfP37zE=;
 b=ZOOIeUImvdW0/hH6ICoVabkZYjROhYY9h1usaJ/9cha1YN87c0ojpFu9EtY3cYfrubzG0m8faOR0WuGirNWZuu9YIdeCpVJlqpKrwukT8g6WP4/BfSTQDtG8M9912y4v1TJUwxXJBtZGq0de5f/4NARfs7mj0Fv2oJTFMjKK8iawCpm4+IZnGIjKHXrvv5es01hDv2SdYfQ6zR6c+GQS1BeTu2fTK/Yf0JKy+58DNfRswlW1H5LxpgZKF98gf9dpX7986UP5Derbs22pbufrfQS+k6eyC7c8H19AJ8ZK9OCggzLDW1Y7LxJ9F9kY4AzSR2smgUTNLVdvDFd1neuDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWGIdtphgUybql2H2vcEM9l+2kPm3KdKbzzcyfP37zE=;
 b=4e/UsgP5PnrrLUt5CBmWi6FHz634RlpdH3XFYbyfAL6D8vHGgNPjuSqnZtU9aD/zJEChhUIaXxDVMl4+NOWaebI12ZkOgPTNoYePSk11t7ONWWJfvPEkY7J066XQztAR3kgPFLosBxA6LWfD+9X+cmMnQmih6jobPyCXUoJeWnc=
Received: from BN0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:408:142::33)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 11:17:27 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::5f) by BN0PR08CA0011.outlook.office365.com
 (2603:10b6:408:142::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Fri, 25 Oct 2024 11:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:17:27 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:17:20 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v6 10/10] perf/x86/rapl: Add core energy counter support for AMD CPUs
Date: Fri, 25 Oct 2024 11:13:48 +0000
Message-ID: <20241025111348.3810-11-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b83bc7-3a3f-44a2-570b-08dcf4e69bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gUJIwxLlO+5abB2+lF+Sm4v/AEubqqTfc7cgYdzUBRFexLSbsghugCzmqQ9n?=
 =?us-ascii?Q?/c+rb9z2opLURHjCRY0E3/L+rvQx1tsgMKfISbGZoAhbYDqqzeJ/saJIsKw5?=
 =?us-ascii?Q?QnkGHt1IsZjVJiuPGrJwovWC69o92FiZ6hCBiQG3RKO+k0HkWkXLTqevB9hP?=
 =?us-ascii?Q?LqManHaeniwGwVcRax3ab/TqC153/gMakOQC5AKcFaxzY9OGjBPwDaXZ681x?=
 =?us-ascii?Q?TM5wTpIzdBlzW00g1JPy5zVNztQCZOwEAgG48xWHRnjWFXGZZ/6B7RpKsRWT?=
 =?us-ascii?Q?VH77/mk6Sp5z0ieUXdpRmYXw58qfNUIqMoHa1DEnnx6eXAJFigZ9/otFifcH?=
 =?us-ascii?Q?uQn143n0i42IgoNU6InTiSVXWMPc3WRLLJg3mFdbYjA6CJRdOXw7JvLCsXXM?=
 =?us-ascii?Q?gKK9u9HXMuZD/Ig1HfWV/aXCDqTkBLrNxoICIT4SIcsVkrD2veeWdREXpY0B?=
 =?us-ascii?Q?sxuxuOlpeLcwsfVRp9bQ0zEFI5l/M9r37hOWcyKJXUnkmD88F/bvbKJW/2LV?=
 =?us-ascii?Q?0usYuFk7e8aWkb8QCyzzrThjM9BOaU1YWh/ajPd6ZCtmNhP68GUZND8DnVQ0?=
 =?us-ascii?Q?uehZG16v5B3VeqPpG0FSF+sHpX0mXk3le5AVpKxDENFDBJqmDkKmaDj2AOJN?=
 =?us-ascii?Q?BXOclnSIzO0lpbo2oERFCLxJKEExXWtetxXn+C6G88V6RBI5J5dLcFRrM3aV?=
 =?us-ascii?Q?ctUtzbqKaTJOKYNKSJbI/HZzcmT/qI7LAH8mPLLNLklGOZWbdI9pkAaeb4ac?=
 =?us-ascii?Q?BFBJRDGh9JMyucUkYd+GPHqLlAvTKTXup3OcWR4kaXByHwarJp0hPdHLZNbA?=
 =?us-ascii?Q?CkYe9UXufuusesPs+mqeaUIypvw42WM4eniaUXTe9hhrJs2wdC2YNSyQMSJP?=
 =?us-ascii?Q?pVr6Icur03fXMp28cuI1z3Ol5NgpQebf0fcC5SVcppw6y1SU3MXSusArl0ba?=
 =?us-ascii?Q?09hZ/mRC+1ATnScF9vRsEQRuAHzv3lLPfqrHgjOjXfmI5vjppgFuHEyM8pKW?=
 =?us-ascii?Q?VzCzSVjRoW3pLh9VPf4v2BW2anO3zpEKRdAQLz1+InxJDkLyzCanMLMSwfnC?=
 =?us-ascii?Q?tIDbYTyBAZwugoVnlU7gfGuctN3R/iQvk406Zg34W4ndfXKlcZdPdB9psOvq?=
 =?us-ascii?Q?G1fSfF1rLluFHU2BuInPPjy0zHTsSWorCcug2CqtPkliEjj/WhBGzmI78Fuo?=
 =?us-ascii?Q?31YSnHdLWRbucssrjOtsueS3zhEC70e9dd8XaBHWL4jxaLYp5N+BWlbIr+jg?=
 =?us-ascii?Q?IDksPOZHV3RIcJM9Q1rFWGnHfirB1No9ov5WhzTNapCIuhUCHgyYnvqFXVXB?=
 =?us-ascii?Q?DDAub9zrU1o4hpauMpn9Dwus50FpBTUYCNRpglf+bA22MxsHVS4fxCBv/Fh5?=
 =?us-ascii?Q?uPISw0ZOF4lcvZxSC9gUMe6j2gA6iGBqHc/P5mkp8UMTryGz05d5evn7WhAM?=
 =?us-ascii?Q?M4nB4xmrYvQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:17:27.1912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b83bc7-3a3f-44a2-570b-08dcf4e69bc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068

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
---
v6 changes:
* Replaced the if-ladder in get_rapl_pmu_idx() with a switch case. (Gautham)
* Added the error if condition in init_rapl_pmus().
* Modify the PMU name from "power_per_core" to "power_core" and event name
  from "event_per_core" to "event_core"
---
 arch/x86/events/rapl.c | 182 +++++++++++++++++++++++++++++++++--------
 1 file changed, 150 insertions(+), 32 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index d3acc70a3d31..57cf15a19b7c 100644
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
 
@@ -156,10 +170,18 @@ static struct rapl_model *rapl_model;
  * Helper function to get the correct topology id according to the
  * RAPL PMU scope.
  */
-static inline unsigned int get_rapl_pmu_idx(int cpu)
+static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
 {
-	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
-					 topology_logical_die_id(cpu);
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
@@ -169,19 +191,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
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
@@ -208,7 +231,7 @@ static u64 rapl_event_update(struct perf_event *event)
 	delta = (new_raw_count << shift) - (prev_raw_count << shift);
 	delta >>= shift;
 
-	sdelta = rapl_scale(delta, event->hw.config);
+	sdelta = rapl_scale(delta, event);
 
 	local64_add(sdelta, &event->count);
 
@@ -337,12 +360,13 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
 static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
-	int bit, rapl_pmu_idx, ret = 0;
+	int bit, rapl_pmus_scope, rapl_pmu_idx, ret = 0;
 	struct rapl_pmu *rapl_pmu;
+	struct rapl_pmus *rapl_pmus;
 
-	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus_pkg->pmu.type)
-		return -ENOENT;
+	/* unsupported modes and filters */
+	if (event->attr.sample_period) /* no sampling */
+		return -EINVAL;
 
 	/* check only supported bits are set */
 	if (event->attr.config & ~RAPL_EVENT_MASK)
@@ -351,31 +375,49 @@ static int rapl_pmu_event_init(struct perf_event *event)
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
 
@@ -392,12 +434,14 @@ RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
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
@@ -407,6 +451,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
 RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-core.scale,   rapl_core_scale, "2.3283064365386962890625e-10");
 
 /*
  * There are no default events, but we need to create
@@ -439,6 +484,12 @@ static const struct attribute_group *rapl_attr_groups[] = {
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
@@ -499,6 +550,18 @@ static struct attribute_group rapl_events_psys_group = {
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
@@ -536,6 +599,11 @@ static struct perf_msr amd_rapl_pkg_msrs[] = {
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
@@ -547,6 +615,8 @@ static int rapl_check_hw_unit(void)
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
 		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
+	rapl_core_hw_unit = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
+
 	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
@@ -565,7 +635,6 @@ static int rapl_check_hw_unit(void)
 		break;
 	}
 
-
 	/*
 	 * Calculate the timer rate:
 	 * Use reference of 200W for scaling the timeout to avoid counter
@@ -584,9 +653,13 @@ static int rapl_check_hw_unit(void)
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
@@ -594,6 +667,10 @@ static void __init rapl_advertise(void)
 				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
 		}
 	}
+
+	if (rapl_pmus_core && (rapl_pmus_core->cntr_mask & (1 << PERF_RAPL_CORE)))
+		pr_info("hw unit of domain %s 2^-%d Joules\n",
+			rapl_core_domain_name, rapl_core_hw_unit);
 }
 
 static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
@@ -614,6 +691,10 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
+static const struct attribute_group *rapl_core_attr_update[] = {
+	&rapl_events_core_group,
+};
+
 static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 {
 	struct rapl_pmu *rapl_pmu;
@@ -640,13 +721,22 @@ static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
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
@@ -735,8 +825,10 @@ static struct rapl_model model_spr = {
 
 static struct rapl_model model_amd_hygon = {
 	.pkg_events	= BIT(PERF_RAPL_PKG),
+	.core_events	= BIT(PERF_RAPL_CORE),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
+	.rapl_core_msrs	= amd_rapl_core_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -808,7 +900,8 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope);
+	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope, rapl_attr_groups,
+			     rapl_attr_update);
 	if (ret)
 		return ret;
 
@@ -820,6 +913,27 @@ static int __init rapl_pmu_init(void)
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
 
@@ -832,6 +946,10 @@ module_init(rapl_pmu_init);
 
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


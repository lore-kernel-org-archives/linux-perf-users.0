Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977C374076;
	Fri, 13 Sep 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242616; cv=fail; b=LsS/c15IidiFla/T+2IoSQg6BQUHZaa7ORjf9ZN8och8FgrmyBkZtzULVzWJ8F9YG3kk1ErLa733vUelUc+nwi6AIyaG4724pYnwquaNgZjHfBeQuLvZZpqu3nfoc+AK1f1XAnrw9JSiy/4w5wr91QDrQ3lmxBcOGVsatrSZ0Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242616; c=relaxed/simple;
	bh=xvoimusXWOKDwuJjGt2zGTYEl4op+gR3pvPsPWT87rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZAajsgTqREbjwaox4W40N6reJN4C39szWLdfArKcIzLjlZ8Cxzy7z26tvpRJ/3PtF9CUmG88cdTl9gvJImHACpPjGOsIiWHJHh0pa9PqoSN2Be45VXb7Bdxwabywv5z+OVmAl2V7TCFa4fjVSf5oy85CWAYTDfMajo2YCXz/EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ebh7kvVx; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ebh7kvVx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMavI8pj0gOnN8GViYryz3PSXKjKy7M+n2gums1w4i+GrPmB9N+KWNp3PMmRxfGKj7RMztm77qdDvSN31+cbQ0o1VLgDbeuukrXnAuwC1bKi2w4oFKCCSxDSkKw7DMAi4kqpoA0G1XPER91pxygKqkzMqtGrVpOzYVN5E1zRMu4GOKrQM70AjYuLA39bOcQdf/XgZlklmkGSkbljo7oDy8qjRvoHnWW10Y0PQ+Dw/G266o8KDhsqUbJX34CxRq9tudhctlV9FsOYQRLNEU2h0k1AIcAMVtriuQvKV6ANmH01Mi7Ntdgz2qDTlImGz2EDAGogJvc6zjm7UYvfCHaY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi10zN8T3feEltMQUGBF1iSvyYTDFdMlTdJFoCjEofU=;
 b=IML1dB76ff3ykWOpUnlZP86iO/v+9CiNvrVF0eq9xRYwFKLKxHHmJzDxMiaQOL+TibcJKdHpTiBs0PFM6PbB2j97kdg74MYg0KKIaJX3danUExl+bddjNnxN2QMtnlrLF1XQHDWMMPIM4unm5LPG+cdqadjLmyrUtPD6JsWkAYY5TfgWb2WcDFcUrREpt/HFVU3XdPuJXnn+oRbr3r0tOcwVxl6qX2ose/xvlOOq6C0IufrW06Z7aov/TE/c+EWbH+qG1HTAtJcbkE5UPmoGU6HeTHuE29V5FIol3RDRwbN5wMQwlXyPRGOQKfcVE+7iM70QlnYvQ0oTVT5EZD4JRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi10zN8T3feEltMQUGBF1iSvyYTDFdMlTdJFoCjEofU=;
 b=Ebh7kvVxkHBN3ti+APGp4xJy8GTiRiJhMXDSPA+CIXNSU6IckGu+i1+Tw3p/+HBoh2Q42iNR7QLipMbHtM3r/i2n9BjCWGd0JDoE5BSosiAm7K/FZWgJoog/YnNu1Yii73a7OG+beDdvD+9N4691CEwDJrpgl7IBjbDUsOLNFjQ=
Received: from BYAPR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:74::15)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 15:50:10 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::c) by BYAPR05CA0038.outlook.office365.com
 (2603:10b6:a03:74::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Fri, 13 Sep 2024 15:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 15:50:09 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:50:03 -0500
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
Subject: [PATCH v5 9/9] perf/x86/rapl: Add per-core energy counter support for AMD CPUs
Date: Fri, 13 Sep 2024 15:48:01 +0000
Message-ID: <20240913154801.6446-6-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 7656c089-1bd0-4e28-d427-08dcd40bbf41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WdHZ6FhL28TsLcHGXc1GJCBMNOAGTx1SGI9iHUCNabjmjruTNkF8JGuhPOHr?=
 =?us-ascii?Q?ydADs4rirBc92/NvqRqwYxpcZEzMBxTWalj0JoZnOF//bQWwv3ex8o47FwVw?=
 =?us-ascii?Q?vTOHsKHtL/0hsS4wftvLDcVHBFfTCmkY2umTOkD5uGsrningVqLiNn/xZdMj?=
 =?us-ascii?Q?Ib+8MKbVSXapWnsZtAwTq7ZM3qKbE3vctqYauFx2mBOtqhkbzov2WSJt5pZi?=
 =?us-ascii?Q?KCx4hK9ofE2e6RlB1HMxxImXIB5kZa/cJgmJZaHDblKjSX1Bf0iz8O3ICUPw?=
 =?us-ascii?Q?hcW7XAAPEDIaF/8cMQIkSqFa+qxxDz81pC1SFy9CuFUL3P5yGz/JBtQBtO9K?=
 =?us-ascii?Q?ez9cgXxHSwfhlTZ5Ups3X8aEJu3sn/ZiTtNjVasWCbhrcrfrzUoXIVY+ohUs?=
 =?us-ascii?Q?foNUnERlB3CVCjsnZqiIGz1pJeQy54nM6iGgQbaqKa5YcRuV1AtX8qMI971n?=
 =?us-ascii?Q?JMd6/bunKxseh2eXPlOOpzOFIXOcwCmLNveJOVDBeG1AdrTMXI4NPfOrIgVC?=
 =?us-ascii?Q?abduaZ5Cc1ZoKVE7RnPo2Yr4YBxkr5VW6cEC+hwaspnIUm+O3aAFKenU7veP?=
 =?us-ascii?Q?djxlBpoCr7W8rgnAFSQMWCaNGnArceaUpBcO84+xVoBHFWipfnjhagdXo98H?=
 =?us-ascii?Q?Oe4iJn5/jXK6RquSemK6DLS9iGqMWGThdDYJpPEX3wIzzYlSOk874cNEgGJK?=
 =?us-ascii?Q?9Mk2+8rFFkK48xAJimZkyHcJusw2MzrPwntR2JWtzGPnrOXPXjrP4G7/e48Q?=
 =?us-ascii?Q?2PPP4DJh9No9cbU6w3IQFYksvOxS90iB0y02uMVX8j1jveGYAQBi+bJ1IdY2?=
 =?us-ascii?Q?zIcURxT/rVredtL6xh+yf0Yvt/JvuPQfwZMlbfFC+3hOGqyhFwS51tXyOL8k?=
 =?us-ascii?Q?eDoM64w34Ah+4jGjdVmlI/jRNwCbQFq/StkweR+NoFTwuv5C6U4tfzEAgPgI?=
 =?us-ascii?Q?5LVZT1io0H7VkQ8Va0sr1w8lN4mQmiA6RQSB60sEHir8cUqch5sICk/S0PfW?=
 =?us-ascii?Q?fLVPZGIzrqcALBo2tKH04gBinmwe9O1L7ljGwazKd46s933FsdsNPMLka6xN?=
 =?us-ascii?Q?vrA1E8OdfnCGdqvaYQkw1oCBaRzlniBfWR2fDgUUWL6/F0e9zmh+jOrV1Irn?=
 =?us-ascii?Q?nqBSTDkweby1Nil1sBqC4iudtv/9lGB1qxEKgC4CYU3emA5C14JPikHt27ei?=
 =?us-ascii?Q?uBn9zFInKWsH6MQySNBwqNw8FpWTAYeUi7Zqg5aTE3TfBpAdgneB8qbuN1uM?=
 =?us-ascii?Q?pdm4IMC6ieh7YE0krSIBDRKXmH0cUG+BBsoD8c0uditr1xEG4ItJG82Q0yfk?=
 =?us-ascii?Q?yggqrt/BXpRGOVEXJxfUwlaHPcGwycIGjC5gJDExm6y0CGRvOR134CRl4Tl8?=
 =?us-ascii?Q?4xLfbmKK5r/5lfxFSKuKooCfvjyxV/6mlq0R6D/gbOURIL3+S0G6udBm03wf?=
 =?us-ascii?Q?q63jQnI3WdtDqyHJe2+k35N2+Di51Nlcx464YuA36vUbi4PyLaYQAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:50:09.7321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7656c089-1bd0-4e28-d427-08dcd40bbf41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052

Add a new "power_per_core" PMU and "energy-per-core" event for
monitoring energy consumption by each core. The existing energy-cores
event aggregates the energy consumption at the package level.
This new event aligns with the AMD's per_core energy counters.

Tested the package level and core level PMU counters with workloads
pinned to different CPUs.

Results with workload pinned to CPU 1 in core 1 on a AMD Zen4 Genoa
machine:

$ perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1

 Performance counter stats for 'system wide':

S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
v5 changes:
* Pass an extra "scope" argument to the get_rapl_pmu_idx() to
  support the per-core PMU as well.
* Pass "perf_event" pointer argument to rapl_scale(), to use the 
  corresponding hw_unit value (pkg or core) to scale.
* Move around the code in rapl_pmu_event_init() to consolidate the PMU
  specific code to single if block.
* Removed the sanity check in rapl_scale() as we have already
  bound-checked "cfg" in rapl_pmu_event_init()
---
 arch/x86/events/rapl.c | 178 +++++++++++++++++++++++++++++++++--------
 1 file changed, 143 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7e9cb01f749a..6514ea67cf0c 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -39,6 +39,10 @@
  *	  event: rapl_energy_psys
  *    perf code: 0x5
  *
+ *  per_core counter: consumption of a single physical core
+ *	  event: rapl_energy_per_core (power_per_core PMU)
+ *    perf code: 0x1
+ *
  * We manage those counters as free running (read-only). They may be
  * use simultaneously by other tools, such as turbostat.
  *
@@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
 	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
 };
 
+#define PERF_RAPL_PER_CORE		0		/* per-core */
+#define PERF_RAPL_CORE_EVENTS_MAX	1
+#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
+
 static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
 	"pp0-core",
 	"package",
@@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
 	"psys",
 };
 
+static const char *const rapl_core_domain_name __initconst = "per-core";
+
 /*
  * event code: LSB 8 bits, passed in attr->config
  * any other bit is reserved
@@ -128,14 +138,18 @@ enum rapl_unit_quirk {
 
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
 
@@ -156,10 +170,14 @@ static struct rapl_model *rapl_model;
  * Helper function to get the correct topology id according to the
  * RAPL PMU scope.
  */
-static inline unsigned int get_rapl_pmu_idx(int cpu)
+static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
 {
-	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
-					 topology_logical_die_id(cpu);
+	if (scope == PERF_PMU_SCOPE_PKG)
+		return topology_logical_package_id(cpu);
+	else if (scope == PERF_PMU_SCOPE_DIE)
+		return topology_logical_die_id(cpu);
+	else
+		return topology_logical_core_id(cpu);
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -169,19 +187,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
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
@@ -208,7 +227,7 @@ static u64 rapl_event_update(struct perf_event *event)
 	delta = (new_raw_count << shift) - (prev_raw_count << shift);
 	delta >>= shift;
 
-	sdelta = rapl_scale(delta, event->hw.config);
+	sdelta = rapl_scale(delta, event);
 
 	local64_add(sdelta, &event->count);
 
@@ -337,12 +356,13 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
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
@@ -351,31 +371,49 @@ static int rapl_pmu_event_init(struct perf_event *event)
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
+		/* only look at RAPL per-core events */
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
 
@@ -392,12 +430,14 @@ RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
 RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
 RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
 RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
+RAPL_EVENT_ATTR_STR(energy-per-core,   rapl_per_core, "event=0x01");
 
 RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-per-core.unit,   rapl_per_core_unit, "Joules");
 
 /*
  * we compute in 0.23 nJ increments regardless of MSR
@@ -407,6 +447,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
 RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-per-core.scale,   rapl_per_core_scale, "2.3283064365386962890625e-10");
 
 /*
  * There are no default events, but we need to create
@@ -439,6 +480,12 @@ static const struct attribute_group *rapl_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *rapl_per_core_attr_groups[] = {
+	&rapl_pmu_format_group,
+	&rapl_pmu_events_group,
+	NULL,
+};
+
 static struct attribute *rapl_events_cores[] = {
 	EVENT_PTR(rapl_cores),
 	EVENT_PTR(rapl_cores_unit),
@@ -499,6 +546,18 @@ static struct attribute_group rapl_events_psys_group = {
 	.attrs = rapl_events_psys,
 };
 
+static struct attribute *rapl_events_per_core[] = {
+	EVENT_PTR(rapl_per_core),
+	EVENT_PTR(rapl_per_core_unit),
+	EVENT_PTR(rapl_per_core_scale),
+	NULL,
+};
+
+static struct attribute_group rapl_events_per_core_group = {
+	.name  = "events",
+	.attrs = rapl_events_per_core,
+};
+
 static bool test_msr(int idx, void *data)
 {
 	return test_bit(idx, (unsigned long *) data);
@@ -536,6 +595,11 @@ static struct perf_msr amd_rapl_pkg_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
+static struct perf_msr amd_rapl_core_msrs[] = {
+	[PERF_RAPL_PER_CORE] = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_per_core_group,
+				 test_msr, false, RAPL_MSR_MASK },
+};
+
 static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
@@ -547,6 +611,8 @@ static int rapl_check_hw_unit(void)
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
 		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
+	rapl_core_hw_unit = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
+
 	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
@@ -565,7 +631,6 @@ static int rapl_check_hw_unit(void)
 		break;
 	}
 
-
 	/*
 	 * Calculate the timer rate:
 	 * Use reference of 200W for scaling the timeout to avoid counter
@@ -584,9 +649,13 @@ static int rapl_check_hw_unit(void)
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
@@ -594,6 +663,10 @@ static void __init rapl_advertise(void)
 				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
 		}
 	}
+
+	if (rapl_pmus_core && (rapl_pmus_core->cntr_mask & (1 << PERF_RAPL_PER_CORE)))
+		pr_info("hw unit of domain %s 2^-%d Joules\n",
+			rapl_core_domain_name, rapl_core_hw_unit);
 }
 
 static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
@@ -614,6 +687,10 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
+static const struct attribute_group *rapl_per_core_attr_update[] = {
+	&rapl_events_per_core_group,
+};
+
 static void __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 {
 	struct rapl_pmu *rapl_pmu;
@@ -622,10 +699,9 @@ static void __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 	cpus_read_lock();
 
 	for_each_cpu(cpu, cpu_online_mask) {
-		rapl_pmu_idx = get_rapl_pmu_idx(cpu);
+		rapl_pmu_idx = get_rapl_pmu_idx(cpu, rapl_pmus->pmu.scope);
 		if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
 			continue;
-
 		rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
 		if (rapl_pmu)
 			continue;
@@ -644,15 +720,19 @@ static void __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 	cpus_read_unlock();
 }
 
-static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope,
+				 const struct attribute_group **rapl_attr_groups,
+				 const struct attribute_group **rapl_attr_update)
 {
 	int nr_rapl_pmu;
 	struct rapl_pmus *rapl_pmus;
 
 	if (rapl_pmu_scope == PERF_PMU_SCOPE_PKG)
 		nr_rapl_pmu	= topology_max_packages();
-	else
+	else if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
 		nr_rapl_pmu	= topology_max_packages() * topology_max_dies_per_package();
+	else
+		nr_rapl_pmu	= topology_max_packages() * topology_num_cores_per_package();
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
@@ -743,8 +823,10 @@ static struct rapl_model model_spr = {
 
 static struct rapl_model model_amd_hygon = {
 	.pkg_events	= BIT(PERF_RAPL_PKG),
+	.core_events	= BIT(PERF_RAPL_PER_CORE),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
+	.rapl_core_msrs	= amd_rapl_core_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -816,7 +898,8 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope);
+	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope, rapl_attr_groups,
+			     rapl_attr_update);
 	if (ret)
 		return ret;
 
@@ -828,6 +911,27 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		goto out;
 
+	if (rapl_model->core_events) {
+		ret = init_rapl_pmus(&rapl_pmus_core, PERF_PMU_SCOPE_CORE,
+				     rapl_per_core_attr_groups,
+				     rapl_per_core_attr_update);
+		if (ret) {
+			pr_warn("Per-core PMU initialization failed (%d)\n", ret);
+			goto per_core_init_failed;
+		}
+
+		rapl_pmus_core->cntr_mask = perf_msr_probe(rapl_model->rapl_core_msrs,
+						     PERF_RAPL_CORE_EVENTS_MAX, false,
+						     (void *) &rapl_model->core_events);
+
+		ret = perf_pmu_register(&rapl_pmus_core->pmu, "power_per_core", -1);
+		if (ret) {
+			pr_warn("Per-core PMU registration failed (%d)\n", ret);
+			cleanup_rapl_pmus(rapl_pmus_core);
+		}
+	}
+
+per_core_init_failed:
 	rapl_advertise();
 	return 0;
 
@@ -840,6 +944,10 @@ module_init(rapl_pmu_init);
 
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


Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3442A79E;
	Thu,  6 Aug 2026 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011398; cv=fail; b=onHrvFNFSlICd2W7QvtjjLYFuAY4g6V1PMpWtvGZ8fCC6yfXRrHbCqd1u2Se8tnJoM4QBp5oQ8NRl6Q8bwspb+gVUvZyA3ksbv7SH0c4O/khbs5ufyGp6PmbdRLoK3P2mdPLxdleai1s+359BnnUN5T/49OlHpRyu7HaEOZyo8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011398; c=relaxed/simple;
	bh=1HhiwoZQnKHJtykM8i/YrSjmpkUoJ46gHZhW5V0/NW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDGWqTc20aIEXpQt7aGNoQbOSa1psKBb6rdfdoSIXuxVYfHY5oUHALnfm3f7XGhRYmPSVZvDMn9fj7aMLwuq+YS8SR24/foepgdpcp87zQdl0shxxKFZU1j2BXwil58C12ExpOLfEDnL9f1uzDeSC7Z/v7RAORU37/bcyyds7kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QFPpcGWN; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QFPpcGWN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD1giuQd7mMGK01xkFqTZY7wMiqzMVor22jFgatJSkXp4xVGIAsA5WZzKCzD5QGpPB2gzLj+8YShMXcv+uaUmxyDnk4bOjSDuoGjDx4gwGIJjfKt2rFhw46bQ4DjucJ7UriG26rmCE4Q1a9sKNXhYmLnZefjsR/n/v4cuWdSSR9YezbTHeM+TyIFeR6iI5UxkFJE/abnKRoQm6qg82/URLXdW9BNuuw1mYLamEkfBDDlzNwHWnDmpgGBpa+y80Khr2JRe5ORZg25wNxVjVxxj+wKIkyopnPVYLEhjw/Wn7jAKbGjBWuRkXIp2TsxjE6WobNpFSs4z+4Hbtkg0pQKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F78dRUflJNN17PmOK+VbbOK8zWXVlnaS4395o5uG2CU=;
 b=jtIiW7PRNbhChwC9ixLw18a3JWT6GksUTya1oe0ic0UTWjKuDmrKy5iy33uj2oyZZPOJCkIJWviNYkLRXlveyZgKVWgIP50g5NIJECxO5bPGe94+Qb5aNEr4GKi9PGqCAzw2iFiriB1eaZ9oHLDSXaaOFIEhUdtm40JOLCKzid6JxMZQTl8Aty56I4Vq8Oi8kUdPzb/X6r/SwN9bfjNKGOK8TNQC9C5yVAhceL0iONsP8NKzj0GO61t1Ugwy6Wzj/FOGU5r6lktIAEq2n3SytdskkGS9DJwyBbybwsceq2xDpDqD7VxdIXX1MFmJy5D1qquxWyFGDMSUPpv1f1h5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F78dRUflJNN17PmOK+VbbOK8zWXVlnaS4395o5uG2CU=;
 b=QFPpcGWNM9ZwD3KL6nQjqTZSuInQhB1CuTl9GiZ7BkEF3EVDEx5xTekcNuQzJnfnO2BbXtmdcevloKyYuKo/Yo/jJN6ZW+OXaDXDlgWrfT5egAQsLsVDw94bhEa/n5lZ/eW1LPcPNI0VWanSM8o/2dNLbReRbNpXWvLxsastOKM=
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 10:16:22 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::a1) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 10:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 10:16:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 05:16:18 -0500
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 05:04:57 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Petr Tesarik
	<ptesarik@suse.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 2/3] perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to vendor code
Date: Thu, 6 Aug 2026 15:33:27 +0530
Message-ID: <c97fdca26b60d9021fc96ecc660e516352988376.1786010408.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786010408.git.sandipan.das@amd.com>
References: <cover.1786010408.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb10.amd.com
 (10.181.42.219)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 561e368b-f8a3-4025-457d-08def3a3c3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8GchDt59lE+n+fVtbQ+LUqPBEgqOokgw58cb/xhWSp88Vr/aLAR2x2Nn7y98oh0OTfNx2bDXGIJP3zQXc5jnMZKQsnA9Hj0qnhZC2s3QCENrN/2QRB3T4zpANh8AbfrN3Hz/XuaoDDIA6H3tFj/1rS8ruJhGf0gcMKB/iA0uuo1uOUBnCih8ADk01Dv8qVgKFvW11GBeeH2onjtUZQa5iMJIOg3tBDaffFILw18vNSQmzfhdhNMinchfABLZof3oG0dngaocDMoFfYN182Baw/xG5WgWvfW5JPIHINPRW6Sa5RRR4Q3BeA7UTb+1S6O9157RY4t6icU5afjcgjbuvvVsU+If8YRL8oLCKUPL0zi36wrYiKagBiui+wLGWAndnDkJFq5v+XfdXSt/j9QMc/R8SVy0HdjaVX7nQ/kxXEqh/f4wT4akQjKooym3/+E2aQ0d2s/yfy4jGTFIE2m6DY2wvleXpc7W5b4xbFDhYdLDX5NkAgJExLNuH+vBDEWsnzFZm6bGUajtEYp9t3HoTRSP3PQI/vcdEvUPDyvMOfILAYQigdgkrhfTrqWyBSJYwhwEErpkf2Gq+XXg+fA6vaZUwd4bKd3x5K3GCN8Baosjj/NqABDnYE3sYQFv4dW4gA5zuH6/+DYGFbch13DM7WXweLomx4UW7xQ7+xUlbF9lT9RmrZvI0nAyMV8arP4VwalhW+dyjdNn/UlRaXI2xg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sTpCI7c2CZvZqAKBnitzmcMpnpeMcTbsmcbjlNuhV4TIl9Cj05PmIT8Q83Od1WHG23/52VYhFWA13c9XcbXWv99ZZy4w1YUmNZtfjehObYjBuUNhvUOSZlVGV9uFoJSvDSU/5OxY85S87IOGlfcZt57UiVC1CgFh/J6E36z/kVHgm9xDxvKFirKEvG1x3OqTvxCYv0I2w15onUmFR0NCDb3yIUFGuRFIILD2FVqrYgaZKFe/5y82KdJfhqwY77C8+6P3KxwFmUS+8iVeycSeq2RdISbj3ly5JbhbPn8fy9VN7ktNjUQnNhSXrFfCfgtL/jWR7CgW3CZdN4YqWrIm/3G6pkllf5lHhTzMmNWgP+2+kqu31NGl4uVmfb+tHexTNZ4Rca9Uv5QlWlmAS9kN/rTaKNnFoAANFLbmqOTJ82KeRMwvpu9zR1wurOECbel5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 10:16:22.3111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 561e368b-f8a3-4025-457d-08def3a3c3d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078

MSR_CORE_PERF_GLOBAL_{CTRL,STATUS} and MSR_ARCH_PERFMON_FIXED_CTR_CTRL
are Intel Architectural PerfMon registers that are not available on AMD
processors.

Since commit 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2
support"), x86_pmu.version is also set to 2 on AMD processors that
support PerfMonV2, which makes perf_event_print_debug() attempt to read
these non-existent MSRs. The resulting #GP is caught by the exception
fixup, but as the reads are unchecked, SysRq-P logs an "unchecked MSR
access error" for each one and then prints zeroes as if they were valid
register contents.

Implement x86_pmu::print_debug for the Intel and Zhaoxin PMUs, which do
have these registers, and drop the reads from common code. Both are
wired up through PMU descriptors that are selected only when the PMU
version is at least 2, so the version check is no longer needed.

MSR_CORE_PERF_GLOBAL_OVF_CTRL is also dropped from the dump since it is
write-to-clear and does not read back the overflow state.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Reported-by: Petr Tesarik <ptesarik@suse.com>
Closes: https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.com/
Cc: stable@vger.kernel.org
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/core.c         | 29 +++--------------------------
 arch/x86/events/intel/core.c   | 32 ++++++++++++++++++++++++++++++++
 arch/x86/events/zhaoxin/core.c | 18 ++++++++++++++++++
 3 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 17dc53a62378..7511197579fd 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1559,38 +1559,15 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 
 void x86_pmu_print_debug(int cpu)
 {
-	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
 	unsigned long *cntr_mask, *fixed_cntr_mask;
-	struct event_constraint *pebs_constraints;
+	u64 pmc_ctrl, pmc_count, prev_left;
 	struct cpu_hw_events *cpuc;
-	u64 pebs, debugctl;
-	int cpu, idx;
+	int idx;
 
 	cpuc = &per_cpu(cpu_hw_events, cpu);
 	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
 	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
-	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
-
-	if (x86_pmu.version >= 2) {
-		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
-		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
-		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
-		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
-
-		pr_info("\n");
-		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
-		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
-		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
-		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
-		if (pebs_constraints) {
-			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
-			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
-		}
-		if (x86_pmu.lbr_nr) {
-			rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
-			pr_info("CPU#%d: debugctl:   %016llx\n", cpu, debugctl);
-		}
-	}
+
 	pr_info("CPU#%d: active:     %016llx\n", cpu, *(u64 *)cpuc->active_mask);
 
 	for_each_set_bit(idx, cntr_mask, X86_PMC_IDX_MAX) {
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b39c6ce0efb5..e1ed0e173d0c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3736,6 +3736,36 @@ static void intel_pmu_reset(void)
 	local_irq_restore(flags);
 }
 
+static void intel_pmu_print_debug(int cpu)
+{
+	struct event_constraint *pebs_constraints;
+	struct cpu_hw_events *cpuc;
+	u64 ctrl, status, fixed;
+	u64 pebs, debugctl;
+
+	cpuc = &per_cpu(cpu_hw_events, cpu);
+	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
+
+	rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
+	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
+	rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
+
+	pr_info("\n");
+	pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
+	pr_info("CPU#%d: status:     %016llx\n", cpu, status);
+	pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
+	if (pebs_constraints) {
+		rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
+		pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
+	}
+	if (x86_pmu.lbr_nr) {
+		rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
+		pr_info("CPU#%d: debugctl:   %016llx\n", cpu, debugctl);
+	}
+
+	x86_pmu_print_debug(cpu);
+}
+
 /*
  * We may be running with guest PEBS events created by KVM, and the
  * PEBS records are logged into the guest's DS and invisible to host.
@@ -6680,6 +6710,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	 * counting SMM by default.
 	 */
 	.attr_freeze_on_smi	= 1,
+
+	.print_debug		= intel_pmu_print_debug,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index e506f677db57..cc447e228efb 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -288,6 +288,22 @@ static inline void zxc_pmu_ack_status(u64 ack)
 	zhaoxin_pmu_disable_all();
 }
 
+static void zhaoxin_pmu_print_debug(int cpu)
+{
+	u64 ctrl, status, fixed;
+
+	rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
+	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
+	rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
+
+	pr_info("\n");
+	pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
+	pr_info("CPU#%d: status:     %016llx\n", cpu, status);
+	pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
+
+	x86_pmu_print_debug(cpu);
+}
+
 static void zhaoxin_pmu_disable_fixed(struct hw_perf_event *hwc)
 {
 	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
@@ -479,6 +495,8 @@ static const struct x86_pmu zhaoxin_pmu __initconst = {
 
 	.format_attrs		= zx_arch_formats_attr,
 	.events_sysfs_show	= zhaoxin_event_sysfs_show,
+
+	.print_debug		= zhaoxin_pmu_print_debug,
 };
 
 static const struct { int id; char *name; } zx_arch_events_map[] __initconst = {
-- 
2.53.0


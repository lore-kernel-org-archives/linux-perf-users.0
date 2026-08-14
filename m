Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17993477E31;
	Fri, 14 Aug 2026 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729779; cv=fail; b=cd05eats/Wxx5rsAJ0H8jS34OQunFdwS72fSYv0fKluIDdoXGORZQH8DlxerFdCFtVmwXlV8obmFMWQmo36bNDaqDG0tvbPMD1RmDhAspiX3tIqJCKosxVVb3LJ1JRmlzHHolVLUteukC3rVNxgh/D5Doeg2dZQtRxfDyiI3Xp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729779; c=relaxed/simple;
	bh=9QsXzy5aZCBS7cUTPchNDnyTw98vEsVX5HYn3+YN8Z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILjRdpaMvH39b4PQPDFBSvsQpLngVJd+tved9tq1D+k+4CIiFTtzmOR2M09wUjFZVu09Ixdv3ezWxvcqQC/K/1OSuu3bbiHu5Gk5lxxFaVi5SKovlab6KV3q9b7Lxnf+SJL3FwoY8J7hSrf65zLzN12VFCyE8/EKP2LAS7XuRCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GYL84HLZ; arc=fail smtp.client-ip=52.101.46.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GYL84HLZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSGaBOs2Q6GpahGNAn9CRs5bmetw9DcbqhKi7X6yC3nZ/h0C4014I2KUJ9EVytpixCQHnoBtiWbu1nqfopLPs5MQ8R/mpkZawxKtcS9UG1QBny4foFmnuKJEW+o+UKNs/O2j7CENVIrtzGtdwNq0xwdNMfIlOXutf4HgLZ2bv7FuAAIA2gC6U2CFMmCAl29Ed0AAcSHOC9auvoJn603hlsyH0e7l+zr87JUfLv67PGBKce7ijZ8RiHYdw0piWmnpl+UCsvn9hfDlkQbCwc1clP1twzcIH/52gwMHsXrfwzLsuibuo5Mx+fAHt9tmMhtqG/RLXmrxK9tvDHhpVtD+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1pn/O16GGuJ7kdQ3aHFoDU97mEYhaDyJxOJQRDijcQ=;
 b=ZFCop6xoHYt/5KcSJtLTLa1VbWyrlQ/7fZWAJBkl0a9r1kpWJZjrPnz5YClx/S51TtaWf7akDzQrIRtKrMu48sFc/gKjHsUb9lJg5p5IsI1J/YuT8bpZ+/sD1B+4q9rzEBpLV6YOEgpMO6Gp9B8z3xql45YBklPttab5qxpb9YwGExgvaHzwUWMLMRYo9eW3X8upEmhf6UiiTbKdWtzEj+lu9ph0IYpk1I3bHujEW+YR1vD8aGlYsK5Q8kr5U35CZK5ZCRqS5zOeebgjoKCmHglgosSvMPgUpPSSUTZz0BlGjG6dDxHca7nw7i0L3jqnS2bgwr5894fnBzffnzX//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1pn/O16GGuJ7kdQ3aHFoDU97mEYhaDyJxOJQRDijcQ=;
 b=GYL84HLZhACq2AQMnbkXSib6RORlShmqGOqKPwfMqjP648nIHN0b4W2N1fw4/60dmuFECPE0z4nWH/xlX4qDWbPGI30G/j2KzL+t275pHAEdDqG1g1JOeD82UXpUoLC64PLWrOzllls96kSAJq7qWWPKbP1bRjOF4D578wE2Pqg=
Received: from SA1PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:2ce::21)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 17:49:31 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::f) by SA1PR04CA0016.outlook.office365.com
 (2603:10b6:806:2ce::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 17:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 17:49:31 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 12:49:24 -0500
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
	<ptesarik@suse.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen
	<zide.chen@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 1/3] perf/x86: Add x86_pmu::print_debug
Date: Fri, 14 Aug 2026 23:18:06 +0530
Message-ID: <36cb7f0289adf8a186e6107ae3f6f5286857fd00.1786728929.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786728929.git.sandipan.das@amd.com>
References: <cover.1786728929.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bde1d7-fda0-4197-0d86-08defa2c64ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|82310400026|1800799024|6133799003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	siFaJdRVw0BkrNzalYN5yy4iPvAnWwYSZggFSLLoy5W1ycLdoTnmA/x64SVqrRq1X5a7CDM4zTSghVravQwHKAs0HpraWOMtxfnIFkFunnGrSIYMpjWrB7J6gX+e7U600Ug6HfMkggkuiYH3dCkgHINkj3/BMdpw3+Ya6p05YZt/3yGfrSbo2uhFHyiUoVbrrbojULZeoeVcFFSUARDZ9XcnKduGASOC7ib8RUcG5l334sIpXKoLR2pQ71pODZwTPG5w+2DjJ6VY3PFDTDqAI1ctgIEUVlkP0IJsBfNBrctHoQXwAntXs4QsJeWhEcnGlyAZUseoYE+Q/C3HLI0R6t8y70uUAlmq5ewwICegfRW94zET0VmH1qXbuyHkhhJhD9xgZQSh1KSeuVhwCF0kvlFxdT2RbZLtp4K6IAWR23CHqQGmMx8/c/H8ZtkL8CFx7xQXuMyCoiyLmTot0lP6FwbOcDJUUlWEbgikSXlQ3oJUzmTxb+4MNuAaKhj6j97WCDDn+0XQiWiAIFkCwXi09McAsUpdvbvCY3rIe1/8tKK9f7VBPK2zQaf16WI5XoTPZto3w9mg5lh0WIjgTfcNKcAIDzZs5nsAu2z4melImEHLLHpaky6TGerBkdiicndgn1Jbk1eWAm0NtJrv8jHp1lVQR6Dj2JYas20ULlVFcQcn5whrtcIkYNsVT4NluRAy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aJnXRqkioVz+TXBeqCloGqKNMe0bKVbD8cbAhG9tcutQe2MIJ06kDurn6anvl2d/4C1gDBovE+ih0L3dPWFsoVh4nrfgeLOlNvvXYzKPcyZSErTLR2CiLO95t7xoQppb4jIrf+xLevsHk7/w4X2unwxCzPWjboTLeC/QoithB4gqQ3Q3gTcju2TC74w2tNCWJ6zl/JViV5Vtzs53O672ga29zQV4am+Whm8RlHYLiomG/XHxLBqkU13FJs1le8SNJwkxNmW/Noofc9hmn5DoSJcLKxvixWLESIFAenxijaqgQyFKK/OaX8s6p6dSEKli83xlijPNt3zgaAPISzYOICpy16pwuw14U2S6Fs2Bn15iDAl6Ao6opyXro8ryq7gGJ+iCeJLiB+sbeQWutCEZlfMiO0oeCSUN03Z+lYlqfdGqcXChEh96F06fFSlYTIlt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:49:31.1220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bde1d7-fda0-4197-0d86-08defa2c64ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231

perf_event_print_debug() dumps the global control and status MSRs
whenever x86_pmu.version >= 2, reading registers that exist only on
Intel-compatible PMUs. This is not safe since x86_pmu.version is not
Intel-specific and is now set by other vendors whose global registers
use different addresses.

As a first step, split perf_event_print_debug() in two. The register
dump moves into a new common helper, x86_pmu_print_debug(), leaving
perf_event_print_debug() to handle the preamble and dispatch to an
optional x86_pmu::print_debug method. This lets each vendor-specific
PMU dump its own global state before chaining into the common helper.
PMUs that do not implement the method, such as those with
x86_pmu.version < 2, get the common helper alone.

No functional change intended.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/core.c       | 35 +++++++++++++++++++++++++++--------
 arch/x86/events/perf_event.h |  4 ++++
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8b3ea0adb965..364a4c83f677 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -105,6 +105,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_disable, *x86_pmu.pebs_disable);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_enable_all, *x86_pmu.pebs_enable_all);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_disable_all, *x86_pmu.pebs_disable_all);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_print_debug, *x86_pmu.print_debug);
+
 /*
  * This one is magic, it will get called even when PMU init fails (because
  * there is no PMU), in which case it should simply return NULL.
@@ -1571,26 +1573,20 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
-void perf_event_print_debug(void)
+void x86_pmu_print_debug(int cpu)
 {
 	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
 	unsigned long *cntr_mask, *fixed_cntr_mask;
 	struct event_constraint *pebs_constraints;
 	struct cpu_hw_events *cpuc;
 	u64 pebs, debugctl;
-	int cpu, idx;
-
-	guard(irqsave)();
+	int idx;
 
-	cpu = smp_processor_id();
 	cpuc = &per_cpu(cpu_hw_events, cpu);
 	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
 	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
 	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
 
-	if (!*(u64 *)cntr_mask)
-		return;
-
 	if (x86_pmu.version >= 2) {
 		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
 		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
@@ -1634,6 +1630,24 @@ void perf_event_print_debug(void)
 	}
 }
 
+void perf_event_print_debug(void)
+{
+	struct cpu_hw_events *cpuc;
+	unsigned long *cntr_mask;
+	int cpu;
+
+	guard(irqsave)();
+
+	cpu = smp_processor_id();
+	cpuc = &per_cpu(cpu_hw_events, cpu);
+	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
+
+	if (!*(u64 *)cntr_mask)
+		return;
+
+	static_call(x86_pmu_print_debug)(cpu);
+}
+
 void x86_pmu_stop(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -2122,6 +2136,8 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_pebs_disable, x86_pmu.pebs_disable);
 	static_call_update(x86_pmu_pebs_enable_all, x86_pmu.pebs_enable_all);
 	static_call_update(x86_pmu_pebs_disable_all, x86_pmu.pebs_disable_all);
+
+	static_call_update(x86_pmu_print_debug, x86_pmu.print_debug);
 }
 
 static void _x86_pmu_read(struct perf_event *event)
@@ -2233,6 +2249,9 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.update)
 		x86_pmu.update = x86_perf_event_update;
 
+	if (!x86_pmu.print_debug)
+		x86_pmu.print_debug = x86_pmu_print_debug;
+
 	x86_pmu_static_call_update();
 
 	/*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fa381110f7a7..a5d15ff50a2d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1052,6 +1052,8 @@ struct x86_pmu {
 	int				num_hybrid_pmus;
 	struct x86_hybrid_pmu		*hybrid_pmu;
 	enum intel_cpu_type (*get_hybrid_cpu_type)	(void);
+
+	void (*print_debug)(int cpu);
 };
 
 struct x86_perf_task_context_opt {
@@ -1317,6 +1319,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
 
 void x86_pmu_show_pmu_cap(struct pmu *pmu);
 
+void x86_pmu_print_debug(int cpu);
+
 static inline int x86_pmu_num_counters(struct pmu *pmu)
 {
 	return hweight64(hybrid(pmu, cntr_mask64));
-- 
2.53.0


Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7323F0770;
	Thu,  6 Aug 2026 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011392; cv=fail; b=jNlnx5t25a2hFu4vexGBVenei/DW5knXNmfk/j9+MV5C7zdOtUWSrQq/Tf/K6FKb7wjsLAt48uRMPL+pnwh53XA+9o60h4RVBdkrDbAq+CdU30v5DIObyGRZWfRvpJkAG/apCbywsJv9YCVq2mLNUUCk0nQmUuXSBLkbE8ybU4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011392; c=relaxed/simple;
	bh=UX2rRANitbXBGqoK83LGf7+XgCyIm2kF0m/JRKuVk0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jukAXuhLY6r+H4S+IuLKSpYNxOguG5c+lpILTb3f5yXTjdHE/CPEI2ThWLNwgp38G9sOHpXpOPfnZB7YbwuHzdOzI1wAQRbp3AOjn+JU/Hty7eJlCM0/LsutF9n+YiG5Z0K9dW8RacieeuMIk3SJeUkHZNhD76t1sVb1NC0/Pbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y8et7G96; arc=fail smtp.client-ip=52.101.46.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y8et7G96"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpTrI9fGeRn61tkxlOWp7QNdovUCRrIQccFlAK4R2UD2U3vacPv+/gJxPczoE+/3nOJbFRgfvbpFF8iU0FJora4rq7pBXsjgUvf9EQACGvwL15NCU1QO2U19YWDazCd6msAIE1ObRZGp52il25hvaVnqj5DUbB041q94mZz0kmXDSY2/M3XMiRjsDMvalqKWXwx07dSXnzAE1XJ0nw9jch6pwxvhgPN3Np+X5bWZziFbfrLizSqOT3xcKncxp0O86ufzV/Ajht7Jk4f3k1hpGW5+HKHQYGBxT/90xy1EELYhDvFua4hoXtpDYr0YjPR7higgSYg86Blvoc8f1lPyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKgn4rljFEPpBb9QETemYNVEOlyfBlLHW/vaV0957UU=;
 b=VJAHCxaPADzVDV7J5bZvo29a7QC3RUtCKsnmbTLs+YVQBV0IpRTvm8xqNp6wi1O4/eqnF4J92vscrFcSfB+2AJqvWjxo4yotNI5FNynlpCUXOQbeujqkLfxTSwCR+TQBH0gzETj7vbs7COXYcaEK2PIEUQPWDZGF8Zmwj1k0kmtagga3sRBQ/af4y/lzcHcGFP+GMhjJwU9/tKYckJJ+5TJxphFLnHjsA4MUTQveVO9eqwKZGRffdvKdeuVVXr7KNhbiF8SXRWR4205DHM5ETwHwdIyPnP8l2EiRmbzCIMCZmS+frutNYEIWEUzkUKbQYbKjLecc+XLQhi75x0wLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKgn4rljFEPpBb9QETemYNVEOlyfBlLHW/vaV0957UU=;
 b=Y8et7G96C2WEmyWQtDc2weuiX5W7yTa1d5/rA6Q3IcTseRtJ9NOsVK//BFaIBUOdHSKyN9fDuWICPqs+qYvxxaLOrvbUXiyjprla6587cpotWr8meoQZpOaDwRMzuuay3j7NA0YeQC75sYfjSEhCXoseChgV6YfnUQLUThXrOFk=
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 10:16:21 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::41) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 10:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 10:16:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 05:16:17 -0500
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 05:04:38 -0500
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
Subject: [PATCH 1/3] perf/x86: Add x86_pmu::print_debug
Date: Thu, 6 Aug 2026 15:33:26 +0530
Message-ID: <fc6ff612d26c2f5b0f015d9fac309cc58e913c1f.1786010408.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 615ca743-71af-46f2-0605-08def3a3c2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0uLGBZzmvsXlN3durF93oSyy/NqcKaEvGbqFxD6K82fwvo6pdnLn5Q1H+xHtu6/naORkfSxJ0WAM6MyQOKBLjbEi3RhX6B1WCrDOx7va1pCPe1JMtxDP7Rl+GaAIwWL+H12ZjFQ4isrlTYZykQzO6F8ZyF0O4awv3796aHhk2UU9/jibxThYXT0yGWc5jEXkyibBiKPWX/6sXmjiRpRAbK/msd8zEWXrsnb/4y2ayZ/950b+E2CZLxeYslEwxDbwrLfSE6ULulDNNFAMfHkHR2gbiaaB7ZH/nP4LfMSw+QxWmsjT8LdnHxnhQ+oGBc41DaZQ/0rx7PRN+dPCWbEKKof+ZE+YzdTNJ4syVNhM7WGgCnRYfqUh2+86U555hhcWQrQ2Grj4iJtHmM/XGDPHJeHqbcNoWGAyhq6qyjUT1KI/6OqdYwoQkQiqc7Zfm3NMmWzhHvrZOKp4velcYvPFbUijtfB2oJqTw6QNwMghyMzAiP812I1SrnHwSmeZm3hg2ecnPnNQ6Zm309JvjY16KM9cWnIt5dk4V/bgzqi0HbrHUfUnFN+wbVgfAIOqeVqUYs0ATrwticGqFSmjllnCFyDPWs8HA2xLQUA7kCKQcFG37Nz1Bz+1D4o/3qQE04gvLph+dPd109pJWTWPfpPwsa+31Z6iR9bR+mvnAAS3T3vMT+oUxnWPUg/FVQetCeib
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j+G58DiFGWxmrIbFHgnyrL5aVaO/HRRqbivNUWSU4NOZxjR4ESQ2ZDhRmmn2/vSs/98AayoTzm3EiAVcemSxhVPY8mU2GK6WXmxfidIcLHW6WUOg948cvtmCYeJ8Nkwaqpzr3/ilJGAYVvcwZxLjBjmrZS64bDaX2lFxscqBNnWYp1YXKunDQ4TWKV8lk7IMpwVYbAs9xRenzB4O88S2LeQrez+h2lC3zwzS5cEhpAApYDYkHKr+8BRczJ1FDrfa9SWXrpplaDxE7EvC/G2NCn1hkOsVQk4NBgu5zOPs758/27YNMKMozsbquvTo2ftOGORf85OFDcRIZ/lPTHC56qDa9rVS231LddnXWwYQmu74Ir/tFxB+VGW5Pm9NUdZYCzRvC341pymiGhMl7YxW1aGy3s15BcV15zycAV/c1kxQZ+LKCBccs1BSznDNT1dr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 10:16:20.8541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615ca743-71af-46f2-0605-08def3a3c2fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461

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
 arch/x86/events/core.c       | 29 ++++++++++++++++++++++-------
 arch/x86/events/perf_event.h |  4 ++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index af0b67ffb43d..17dc53a62378 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1557,7 +1557,7 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
-void perf_event_print_debug(void)
+void x86_pmu_print_debug(int cpu)
 {
 	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
 	unsigned long *cntr_mask, *fixed_cntr_mask;
@@ -1566,17 +1566,11 @@ void perf_event_print_debug(void)
 	u64 pebs, debugctl;
 	int cpu, idx;
 
-	guard(irqsave)();
-
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
@@ -1622,6 +1616,27 @@ void perf_event_print_debug(void)
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
+	if (x86_pmu.print_debug)
+		x86_pmu.print_debug(cpu);
+	else
+		x86_pmu_print_debug(cpu);
+}
+
 void x86_pmu_stop(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a8afea8d38f0..465bf513bb82 100644
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
@@ -1316,6 +1318,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
 
 void x86_pmu_show_pmu_cap(struct pmu *pmu);
 
+void x86_pmu_print_debug(int cpu);
+
 static inline int x86_pmu_num_counters(struct pmu *pmu)
 {
 	return hweight64(hybrid(pmu, cntr_mask64));
-- 
2.53.0


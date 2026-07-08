Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B33C10B7;
	Wed,  8 Jul 2026 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506755; cv=fail; b=cfWoeHg53mtiqmot6qoFf9Jze4c85rC+43u9wHlJSaMa60VzIjtHXqecdowHB8sWEhQ1SlF7j1sqzIsYwM6irNbdnfMbBDIU5hi9o4M/G4HFlL8o9LAQ0lv6EO7/oKDRpXNSGT3qgea7l+RB+4YTbbIcWYgehkUzRAnDwO4I55k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506755; c=relaxed/simple;
	bh=W/98m/hKPRNtLngImh9WJ4H6iz63p7WrWUm6Di9XlH8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I1itjyIwrsBtmtSM7G0ZTkmR91IMWfBFdwlttOWUwwxTWpBz22xQJLDoSL8GbjEOPIB99tmT5ovmA75x9ehrjQjN2+ch9j3i9UeV7HadSXh5IaKz8caVEPGKKucV/YA9k1po3brzT5JQJpFwP4OCEwVBwxbPtLsKFuU90F55fgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WErDvV6p; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WErDvV6p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okMhYSgL5n+J1tDdXYzmkSxcz21xAQjGpKUSl1oZWardyNQWdoBTuOa76RqMMjnhpfLVaqd3cp6cEbXqHklH/NQzRQ1c/+Fr2bk/1llpKWQAYeZdUSPBU2wlTDoL33avNsx4TkWn2B+QC9P8xzPj3eEMFD40CjhTftUE3xN6X8hVRejJQUt+si9wSCITe7NBc9iHZ8nwkn+7MJIu6/j+UUDWykvDb4vHqHb1j/Kgs6OuS3ZpKSklZwwZv9N742ojX/Hbnm9ekdD9XYzBptTVbVh4yTb6WG5tatKsi2++0+7ZJx/N5xQsW7a1AIOs7KDdstoHQE8pFwaRdzQnQmMuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMjOFwgHveNaccT2tkfImoXPhEE/J5itRSI7d3DPp3k=;
 b=floYf3dRsp/cepqyLuHtyIi3Qrw+QQexf3ZSXVur+LIniMmrJJVms9+9gc2JjvmuFfFslY1/eQhrqeynoyLSTichU9nXkL1tiLQuuv8gUVmEbBXcS/NqaU/MDQvpQ+co56uYaAARAYeb0CTM2rgHguRDHt8GjLt+MZmYGCEuvc67oIqRmTQtNGaJVuE1ta3TnXyMH/arMdH0ltmzCcYoxo+PJoSIVhjvyji4mKBrw02oaKizw+NavobMUpu+fxhOrFjtGD28VAo2RZuNF8PYRbSDo2dXakB/vL8b8HmvIPsl0CA1L53OYSnU3EH3e3UpB8Q+VcVGkbjzjNC/jDGKVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMjOFwgHveNaccT2tkfImoXPhEE/J5itRSI7d3DPp3k=;
 b=WErDvV6pcR4IPdYxMAU54Mu5FQvy2/r2kpxsreE3E1O3rYX8Q0zgkkDA9UEe2a841M8QFSF5PTT3HPFsd/5jA+L/pEzJCjKTWgRLP/MPormy9lE+lkPn7qqoHyITN1vGnie4hdgk8ZSXwOKU9fOI+mQ3/GHSPb/pDhJu9niytwQ=
Received: from MN2PR05CA0052.namprd05.prod.outlook.com (2603:10b6:208:236::21)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 10:32:18 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::25) by MN2PR05CA0052.outlook.office365.com
 (2603:10b6:208:236::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Wed, 8
 Jul 2026 10:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 10:32:18 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 05:32:12 -0500
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
Subject: [PATCH] perf/x86/amd/core: Avoid enabling BRS from the SVM reload path
Date: Wed, 8 Jul 2026 16:02:04 +0530
Message-ID: <702fa204d574b03d14e3664c7d4b201db048bbfd.1783506528.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb6b5bc-9280-40ab-7c11-08dedcdc2f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|23010399003|56012099006|5023799004|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	MgZHNGbrp+ALg1jmpejvTSD1I4fSuhANhFwpiIqLwF1GGiWKGJsxCah+jRJvOgbwhv3uPj+Qf8p9hBXEacNO7C/h0sgR06Kdlj0eaFjwWzJ7gNGm1b8OCwITc+lHLx+XYAcFhlmOptpY3ndRb4kvLy0akmnu9vDOoX8vWRLyjjRMFtaB1SsQN43AOaJFwS1UJW9/EN1tHtmcc2P8BJpa/L1cqWoV3X7uB/+JRAzaChknngDXsgoWpyKKfVxa/4t3KzdBEep6MkkuIqtiZuPAHon8O/4gfbH3wA1UdhFwjfZaEVKLsaoN66WTRXYG8U4rEEAGkDxX3NZvKgdAK6nt8o8aCx0C21Ey6gR7+DvBow54oXDDGGy1gD1KKlA4xY4SNcP5wihrtN0388xuQ45DZXt6XYg+DKPiZ1DzNhjuz2b4sXeh3lBdDO7T4e1FLMPrw6toaOWnofcdBzwfsuTjQp7b3j68zQb3/wFa0lLy5mYxLWzu2n9uZPYcJBET1rdeHP99YVQaXbjoyHMqNvO+u7ATysBO1Wh3hhJRVXlBiW98Su2RlikQIPV9ilVBaQB07lUlDKLtbEVL+40BdY2vBMVcJmh/Slqffv7Yy/IparcifS4hhwy7ZIVy02Pm3XYe/ri4K+Qq97qpyZvqP5pp6MQwlUFK2bQM22fngpK3QbFTgVHxqs7gT7EdCB0jOCASKiILXBvsa4ba72Qi/O5G2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(5023799004)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gt8IpFuycVSO5mekTT/CtC/jWKfnn1vT2T3ETZ0B7zqnMYeOAgyOhXwkvqt91opj5dwKz8l1gfraiayaQ6UT0jhetlpkCWm0GtjzlyXvYzHOLYBEflc8h+v9+qMqNxYnz5qtm13bYV2QmIFHC/8PW08pjpn8lfE9GWs8lUWnfuKWlVoOOvWWkt/5Oj4PYiKnF+CuHfI5x+OGn5imgRMHTanC94Fb1YYf9TSUJ8oyldp8S2qhBp5LtGjttWgQG5RgqoK07RtCas0SZG93IiP65mrKpE3Bn3we9vPKL5a+PkABVxolFcWqugDFhr6SP43jtb1hRrH64XMSxat4uCPzjFLWUNy/9CKyHjPtJLe1ptduJLTev2SFs8BNpdqogxZ9ZOYYqcf3QhkYZDhqO1uoa3fj26lA6otSVSPwuvHgHeb8HAzMPoInh6shNp/HeVGf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:32:18.0167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb6b5bc-9280-40ab-7c11-08dedcdc2f79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

Branch Sampling (BRS) and Last Branch Record (LBR) are mutually
exclusive hardware features, and users of both are tracked via
cpuc->lbr_users.

When SVM is toggled on a CPU, the host perf events are reprogrammed to
update the HostOnly filter bit (set when virtualization is enabled,
cleared when it is disabled). On PerfMonV2-capable processors, this
reprogramming is performed by calling amd_pmu_enable_all() to rewrite
the event selectors. However, amd_pmu_enable_all() also calls
amd_brs_enable_all(), which enables BRS whenever cpuc->lbr_users > 0.
Having active LBR events satisfies this gating on processors that have
LBR but not BRS. The kernel then tries to set the BRS enable bit in
DebugExtnCfg (MSR 0xc000010f). Since that bit is deprecated on such
hardware, the write results in a #GP, as seen below.

  [ 6869.372584] unchecked MSR access error: WRMSR to 0xc000010f (tried to write 0x000000000000001c) at rIP: 0xffffffff810100f3 (amd_brs_enable_all+0x43/0x50)
  [ 6869.372606] Call Trace:
  [ 6869.372611]  <IRQ>
  [ 6869.372613]  amd_pmu_enable_all+0x1d/0x90
  [ 6869.372620]  amd_pmu_disable_virt+0x62/0xb0
  [ 6869.372627]  kvm_arch_disable_virtualization_cpu+0xa/0x40 [kvm]
  [ 6869.372690]  hardware_disable_nolock+0x1a/0x30 [kvm]
  [ 6869.372729]  __flush_smp_call_function_queue+0x9b/0x410
  [ 6869.372735]  __sysvec_call_function+0x18/0xc0
  [ 6869.372740]  sysvec_call_function+0x69/0x90
  [ 6869.372746]  </IRQ>
  [ 6869.372747]  <TASK>
  [ 6869.372748]  asm_sysvec_call_function+0x16/0x20
  [ 6869.372754] RIP: 0010:cpuidle_enter_state+0xc4/0x450
  [ 6869.372759] Code: 00 e8 10 ab 33 ff e8 db f3 ff ff 8b 53 04 49 89 c5 0f 1f 44 00 00 31 ff e8 39 00 32 ff 45 84 ff 0f 85 76 02 00 00 fb 45 85 f6 <0f> 88 9d 01 00 00 49 63 d6 4c 89 e9 48 89 d0 48 c1 e0 04 48 01 d0
  [ 6869.372761] RSP: 0018:ffa0000008bafe88 EFLAGS: 00000202
  [ 6869.372764] RAX: ff11001fd09c7a80 RBX: ff11000115682800 RCX: 000000000000001f
  [ 6869.372766] RDX: 00000000000000b3 RSI: 0000000040189ace RDI: 0000000000000000
  [ 6869.372768] RBP: 0000000000000002 R08: 0000000000000002 R09: 00000000001d317e
  [ 6869.372768] R10: ff11001fd09c32ec R11: 071c71c71c71c71c R12: ffffffff8381aa20
  [ 6869.372770] R13: 0000063f6683245b R14: 0000000000000002 R15: 0000000000000000
  [ 6869.372773]  ? cpuidle_enter_state+0xb7/0x450
  [ 6869.372776]  cpuidle_enter+0x29/0x40
  [ 6869.372782]  cpuidle_idle_call+0xf5/0x160
  [ 6869.372787]  do_idle+0x7b/0xe0
  [ 6869.372789]  cpu_startup_entry+0x26/0x30
  [ 6869.372792]  start_secondary+0x115/0x140
  [ 6869.372795]  secondary_startup_64_no_verify+0x194/0x19b
  [ 6869.372802]  </TASK>

Fix this by ensuring that BRS is not enabled from the event selector
reprogramming path even when cpuc->lbr_users > 0.

Fixes: bae19fdd7e9e ("perf/x86/amd/core: Fix reloading events for SVM")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 6569048a8c1c..a787409f5a62 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -754,13 +754,11 @@ static void amd_pmu_enable_event(struct perf_event *event)
 	x86_pmu_enable_event(event);
 }
 
-static void amd_pmu_enable_all(int added)
+static void __amd_pmu_enable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;
 
-	amd_brs_enable_all();
-
 	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		/* only activate events which are marked as active */
 		if (!test_bit(idx, cpuc->active_mask))
@@ -775,6 +773,12 @@ static void amd_pmu_enable_all(int added)
 	}
 }
 
+static void amd_pmu_enable_all(int added)
+{
+	amd_brs_enable_all();
+	__amd_pmu_enable_all();
+}
+
 static void amd_pmu_v2_enable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -1561,7 +1565,7 @@ static inline void amd_pmu_reload_virt(void)
 		 * set global enable bits once again
 		 */
 		amd_pmu_v2_disable_all();
-		amd_pmu_enable_all(0);
+		__amd_pmu_enable_all();
 		amd_pmu_v2_enable_all(0);
 		return;
 	}
-- 
2.53.0


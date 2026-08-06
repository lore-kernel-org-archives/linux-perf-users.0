Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD94302E1;
	Thu,  6 Aug 2026 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011398; cv=fail; b=Yh/lHQzCCK1Yr+In3a0rp52yKRcalLT8XlbFGrfs061j0flvH1cMozubnNo9YnTkEnHpeLl5341v/6BUPnZ7FcmPmd9iiReYPwJJpoNQwB0CS4O3LTPeBz0hy40psWxsr8ypKOLbKLCsLeZbW4LnZU0UDD2xKp6eepDaOm+Ux2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011398; c=relaxed/simple;
	bh=rU+MkObVUv/cMaiEoGJlMYGLYVthircYqyb5rNsSW88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDJW+IjdZ4prLSl+I0N2WNl8f/ME+tB6K9R7qd1i7DwlmkTJqRVyyQvO5yAljjtvwbhwj+Vg1oOYyZqNgFz9hevQgI8B48QTsENwI6q5qbT35rvD0nekgXzsHkc8H3+m0qjrUCidt8o3y0+Qgt90b3dBYOqwYYndBr/gxkwQxxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4GBjIJ8T; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4GBjIJ8T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD0dqHsnoKGJui/OetraZ5bPyfxOoMXQz9RUz3ySIcTZEgUxPQpvfyvmJURrj2vP634qMlZJVvScWq5osnkk8PtqmR3Bf4nSk0ZqnYa15ybhjebqQa26zcegjRZS/55qzdmu62GplUtzMijZctj/f9uDMl8BVfalYUD8V5ovnf3oyA05fUvvOiQUL82xqFi8USGcgTnR2NT7KAbCDa6dzZVSzLUTz6UlG11WWKqI7qkmO///t88W/O15X21OrME5BsSgs3pm5Kb+5MpICK5UZfbvU+Q1tGkWglZz3POtrsUwbI5WjF6H9xogIrAEn/hG7ht+Ut3XEmgPIhij2Puj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUo28aVtWQ27tfst0edLwbhPuvG2OKOWnQbPPxvRjm0=;
 b=S5wz6HLtvRzfMfHmQVywZtKZ+DCfbBVXyGsyH8aATtFS2mjS3XFV4L5JvNG4awoqrjI3KqKhSdvv4eJ4gFNvPAP7QscA9OQ9q8dEprFKMTqzMET4sAgeXefeymZEAfe2xvlCwJo20jGAFT4Q9j5AXGoEhdRUvBz8as6UsdCQPiMUlVc93dqfwik5OFp0JASk5IZV6eRIyi8ynzp1WhJ/a6wXWL8VG3qVQu8iQ1FKdkhMaYunizvhC8tBlw65wpcf6PzcguilYSLKEZbejtPiLq3jYSwMuwk93pxn//lfxpRv8yguT5oDvJv2WTVJUlmDoOQDC6P5b9kmu8tbMi8P5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUo28aVtWQ27tfst0edLwbhPuvG2OKOWnQbPPxvRjm0=;
 b=4GBjIJ8TFF4U64k0ubMP4Ov/PyfaZw6MhR8OmRR0YCqgQRLS+s53LKKA+NmA8vtAGcYGLgG2sJP6ysv5cs6tMCA5EWJ4GsOmwDg2UOQFKLlAbhvGXhlUYBcpSQm2K8Ek3iL5SMpvSo/IPahkMhFfypd3mZGuI2UjLR3lMhMeTzA=
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 10:16:26 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::56) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 10:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 10:16:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 05:16:20 -0500
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 05:05:15 -0500
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
Subject: [PATCH 3/3] perf/x86/amd: Implement x86_pmu::print_debug
Date: Thu, 6 Aug 2026 15:33:28 +0530
Message-ID: <eedf1d302389327c79a256e8646ac251aba8fefc.1786010408.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c70ba7-cdcc-432d-b017-08def3a3c636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|23010399003|13003099007|6133799003|56012099006|10067099003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	lQ+0rqw+3GLYuPDQBr2Ndt3xaZ96dE4f97otonoZvcPAvxhOU61sTsCxKSQLs3j129Dr8rQYDFXZXGz42sDWsPRirj4xR20U9aCram/QJGBfhTg+sOJQ+zSQneupzSLfGNrtISCqUVUkpYIgIXpCRPApSMCR3T7NYb3eaO4hDwZWYSoI+unpzMWnoxdC87Sa0/pRb49LlV81ovwDS73WOzIVTfq+myV8PBhkavnz9O6r8ZzFP/vo9tHugTVQWE2Qlp/QnbDwHc3Soifz2NUmxnFLuCjxCeNPdO8DQip39P5NFQL6K8ciD1gQsFMpYhPBNRvij6iqBD6dN1HyGQrMWKWZjgy62QftUXqb1u2DUciKmV+PNYL/v0BXUmZ9GMXXYFJnwkgQr+JCv/ONQA1J/w0PvmSL24ypKylZz0gmWpVfRZaCvJH4GpgO/ZjM7TimkDfGmxWb7KopyFlxnBrUEnNcS2pv4qloJg+yxSx9cv/9ku2TiPFC8fLXkS6bKQSJure2ejAYDYubyzrxUZ0AHGOq1Ik37i4PrG9Ijg9CfNgmbKkGM+/t/KIvMHXt0SbH+DaaX+h8rYS2Z+93RitM2KXRN+3reU18q1UJX9/ucyS2mMGectZEz3JBMGXuJC1uDBZbUm2eGp2yDu1y0rjQJrKRMB6X6/q0+aCTqWDT2vi3F0GqjmOH+fY8cwEwxZP+cm5AyoOVfoQhDGXAu1UUkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(23010399003)(13003099007)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	acocvgCxbqX58vRIEuXN8HF+Vc6rmCvB4vPrqamhYlL/QhjE3w64Tn/gCYK49GZ4NGDVcH5r9E6Fpgz8UqEvIG4Jl6HjHIqXrNb5Pq5SHyKt4Q1ypQ+sbCnDzPM0snnlgFynw7fOatH4Rv0A7BKD5md1CTCrNgornVluRsLLap9FxzR44ZgpC8tsLgvpZIQmuKNMLdZPH2E5JATbtpt9rHT0Sya9IBxPpTveGuWj+KZ84TrJaDXsEycQ653QIMFSWfjA/9D0Obfc3BdkjvyUto7+hqwVL/D5T/Bbtr4nGbxn1GlzYBDo54SkI84/V03/A22RRnZpjO8glGfxWaaXVpUqhG5BOWh15mAV8Jx7Gr2MvQQqOOv7NvmBkZagSlnNicuf4BpBVx/wC6B88vkary0WLRD4IuhnloO/6aS8ru1PPYCgg4byvyYaS72BX1Uq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 10:16:26.2533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c70ba7-cdcc-432d-b017-08def3a3c636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252

Implement x86_pmu::print_debug for PerfMonV2 capable processors to dump
MSR_AMD64_PERF_CNTR_GLOBAL_{CTL,STATUS}, plus MSR_AMD_DBG_EXTN_CFG if
LBR Extension Version 2 is available. Chain into x86_pmu_print_debug()
afterwards to dump the event selectors and counters.

MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_{CLR,SET} are left out since they are
write-only.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Reported-by: Petr Tesarik <ptesarik@suse.com>
Closes: https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.com/
Cc: stable@vger.kernel.org
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index a787409f5a62..ecd648af81f7 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -841,6 +841,25 @@ static void amd_pmu_v2_disable_all(void)
 	amd_pmu_check_overflow();
 }
 
+static void amd_pmu_v2_print_debug(int cpu)
+{
+	u64 ctrl, status, debugextn;
+
+	rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctrl);
+	rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
+
+	pr_info("\n");
+	pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
+	pr_info("CPU#%d: status:     %016llx\n", cpu, status);
+
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_V2)) {
+		rdmsrq(MSR_AMD_DBG_EXTN_CFG, debugextn);
+		pr_info("CPU#%d: debugextn:  %016llx\n", cpu, debugextn);
+	}
+
+	x86_pmu_print_debug(cpu);
+}
+
 DEFINE_STATIC_CALL_NULL(amd_pmu_branch_add, *x86_pmu.add);
 
 static void amd_pmu_add_event(struct perf_event *event)
@@ -1452,6 +1471,7 @@ static int __init amd_core_pmu_init(void)
 		x86_pmu.disable_all = amd_pmu_v2_disable_all;
 		x86_pmu.enable = amd_pmu_v2_enable_event;
 		x86_pmu.handle_irq = amd_pmu_v2_handle_irq;
+		x86_pmu.print_debug = amd_pmu_v2_print_debug;
 		static_call_update(amd_pmu_test_overflow, amd_pmu_test_overflow_status);
 	}
 
-- 
2.53.0


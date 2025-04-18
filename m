Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29FE2E40B;
	Fri, 18 Apr 2025 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744957199; cv=fail; b=bhddHqmuDCFZPEdQPdhlsgUwt27DbY0vJ8rfA0PcVClIUamk6CbJ2WHDXhik2IkoIpTFbYOivRln48XshlzE0EVSnVQ8mJSV36Hwg3uMPBtuxlM1w7UK9zLOwgD7LbKWG9eWtNGUKAHvNLkRsrvnOROM4F1rFz7clY3lAsZLXpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744957199; c=relaxed/simple;
	bh=hXZbvuzCaN2j02etROoefEyyTjhsq4vSZ97MNoz53qQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dog7TUHJdy4pxdmA6TAWT6B5lg7bWID7PmTPEm8SL1p8roEDBtASmecvh29cdj6Ba/xF4Q+gK24SMfDYolP143c5V1Yf4fQg4uNdw7Czjqyw1jUYv5mggq3iqQ7IviXqCCCs8aQgka0I6W/J7rtUr+vHmM0u7Be48pacJTapQ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i7dTyjtE; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i7dTyjtE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpMAi7vVSx46MsEwZMTbW8xAmyqOKJI+Wwv2yHLWkFeDBItdjCOL4s3AbFa1xQe3mIHb6+EbR6fcA/iwUTrgS8dyh1PUelITDttNsVZ9TsYw8m9Uks87rQ137vBTAHBXVgVhO1ANTUS6oKNiBWRiYVAZdn0aU6mv664tXOTmkSe8TUwGgyWOq1vW9GiTUL750i7s9s8LNBB860UM6wI9scqkEczl4gBGWJuEXqXPmb/gJBIbgP7bKhAT2CS6naZdGTJ34dYJ0eaE+yYVM06U5Q1WlCf9XwmOBTl4ncWlsIMBc8py11coEDJXLG2+WjPi/vCYG/6GRsjhqczAuEHOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/gBVeY2GDUE2rVJ5phvun090ntjVuNt6rw8dv4dSGw=;
 b=BG1bvHrmtP37FlFVCA3MOy/O692wttiZUiAxEFynQLD3RC10O7E9QeUHRty/kKp07SVX2QV35Vd/2HixFkt3nS/utXXEZwhwSIgGgZvFw26O/c/yUuDbbmarWXdo1CdfJXY3eGTKivXNhKA4dvS1WsgVgTKEUjCE3tjHbtE7fao4yfE4H031/euiPyFxqVLmFQER9dIm8RSfjYEzFvFgKrHR4MvooDWCwYMzX7vTmVdeODi7WDTZ96ackbxiCi4wafz7X6IZ2MIU2UUC3NsQgOivSJDoxlBnWeVH/D+Oo7Wx4Z0/RxPj5prFDWv7KqzOtiQa6Rzoz92vnWVuX79lHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/gBVeY2GDUE2rVJ5phvun090ntjVuNt6rw8dv4dSGw=;
 b=i7dTyjtE9Aqr/mi4/0KWz9TpHd9uUgScN1YxtXsR+d59nzkobx5Mf6UqqKSkKtxgrueaaJKXFWk4Wb6lobzKu3/WMsKAUmdYTMxdqOqidsnDyUuFSBKDNUf7Q8N0rGsbCNaSFL4XUVzoOK6R0zsG9WVXc8dO+h79+J4RYhaXgRg=
Received: from SN7PR04CA0081.namprd04.prod.outlook.com (2603:10b6:806:121::26)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Fri, 18 Apr
 2025 06:19:54 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::27) by SN7PR04CA0081.outlook.office365.com
 (2603:10b6:806:121::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Fri,
 18 Apr 2025 06:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 06:19:53 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 01:19:48 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <riel@surriel.com>, <perry.yuan@amd.com>,
	<mario.limonciello@amd.com>, <mjguzik@gmail.com>, <bigeasy@linutronix.de>,
	<darwi@linutronix.de>, <eranian@google.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH] x86/cpu/amd: Fix workaround for erratum 1054
Date: Fri, 18 Apr 2025 11:49:40 +0530
Message-ID: <caa057a9d6f8ad579e2f1abaa71efbd5bd4eaf6d.1744956467.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: acf5aa6f-38b3-4f0d-05fe-08dd7e41089f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2fdGlOEvAYeNdO8eKqkbsfUdnHj0z3XRvsWwPZXXP11o8kWRThliy/q69NuL?=
 =?us-ascii?Q?q4EbmTJTzsc20hNWBEdD3oZFyGMecMvNwQzCqb1iulsAb0Zfi+me5of3+RkH?=
 =?us-ascii?Q?nyo0R5v/PHhVwnd6YjRcUtz30y299d8aiFN4Vn3PfhXfK/3j+uCIfxynbwA2?=
 =?us-ascii?Q?bXUBJT6EO6toe+mNFXOofQ8bKAzFakKSwpamkkXAX6IU6Sp+uVciJgR3jELb?=
 =?us-ascii?Q?lO30KYs1hujIjTfMCfK+5N0g+e/j8UMpq5AJaVcO0SHlaQwqLUaN/uwwF8GE?=
 =?us-ascii?Q?0wu7jkQpaI2cn0VVdDiPtgYYnUvolUm87Wp3ObMvjLW/GqrHWs6Oe7Wc4Ag0?=
 =?us-ascii?Q?nM2P6N8GOgOY6m9HKcAET2WMQOz7A0mX7X4p7LImxyNGCmEUnDM/ReZscfR4?=
 =?us-ascii?Q?y2ymuOmf4ZMp5yU1qLHKnQ+UcrW+fpeFp3f3zRq4G8Cg9zinEtQw8tNrYVr4?=
 =?us-ascii?Q?EIUxJaUWrzhxsQbHZHymeUGG+BiYmcj630TvWbDHLHOLt6ls1/N5yRIHrgkp?=
 =?us-ascii?Q?Rp7QmBS0vfOdqy79lxeJYmAHeTpFSuzsBammjMgZcAkecZz1MxVO3yVc3A+y?=
 =?us-ascii?Q?L5dHWh0yBw57vf4WIG3ocQtGuCM4AC3JsQ8ENcg6Z7SOJE7WsiE18+j2wtdj?=
 =?us-ascii?Q?oD8rvydbiCAtPBZuBzSucaviS1UEl3A7r8qHYgG8soy7u8do+7dqH+KGcbYx?=
 =?us-ascii?Q?3Cvsief0JBRMI2yA07XhWLy8bc6JL4ciEbVEXYKK44FGqctFVTRxmnlOhHY8?=
 =?us-ascii?Q?KHkOPI3OaCxsqDexk9+OCQawDqkAOhjOX20C62qC6pkff+ag8p6kCMbth7Id?=
 =?us-ascii?Q?sy+oqmcC9vnbgPDACGLhFC6JZHykjQMjazFzyq5653Wk7U2W+sV8UYpywa2w?=
 =?us-ascii?Q?VKe0HNF5cVUCRhXy8RRraPpNa7Wuz01MliO7052SShXUcihnX0c6SOSoqfFa?=
 =?us-ascii?Q?Enrabs6C8fUda+b8OPJ69Sgv78hre12i9/gdWMC3fjSed09fCBqzCferOCiU?=
 =?us-ascii?Q?TJTExNxZqrV/zEqbo2vSe9EoeJDbOa/bYcW7Z9ZqYpN5PPHlXnZXrKe/Dvag?=
 =?us-ascii?Q?dc8XDBCnXtLHz18xtVOxxtFHiV0SCS8C4bRIDEI5OdFeS8E32pBCzt8iCn3k?=
 =?us-ascii?Q?VwqlmIA/ZP6HfDB1seLczY9ElDamaAwrarBCdBtMlfC+uXyvx164IEpPc9aj?=
 =?us-ascii?Q?oPvATnKYpXaUgIgzbA/gcV8KQF5bESXn9NdTlCxjirJ2QhvpyEl/u+m1hqZ8?=
 =?us-ascii?Q?rWk9lKInKlKNxUY99XTRvUNThCAJ0Hg+UIkmaJ2KpRLsTj5BTPh5wNX461Dp?=
 =?us-ascii?Q?vSOKY8OKP+T3bn/LFn8bsi3g6WYZZ96T1DIp/PLmMsOsDXlqTbPMNCzdGcxi?=
 =?us-ascii?Q?Wy/GIgPI/duGkabxi2D9130rp62QL2Hn8TWgX/uGdWtghw26yAlmFL7eSyUc?=
 =?us-ascii?Q?qr+3Oi5zgUFPGkTag21+UCRv3QB58yeABmtdQZf7NMzkW7ofiStu/UBdJOpI?=
 =?us-ascii?Q?tSaIjITio3S1jjLMM91zOaEw9WcrTm2y7ZRy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 06:19:53.7841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf5aa6f-38b3-4f0d-05fe-08dd7e41089f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822

Erratum 1054 affects AMD Zen processors that are a part of Family 17h
Models 00-2Fh and the workaround is to not set HWCR[IRPerfEn]. However,
when X86_FEATURE_ZEN1 was introduced, the condition to detect unaffected
processors was incorrectly changed in a way that the IRPerfEn bit gets
set only for unaffected Zen 1 processors.

Ensure that HWCR[IRPerfEn] is set for all unaffected processors. This
includes a subset of Zen 1 (Family 17h Models 30h and above) and all
later processors. Also clear X86_FEATURE_IRPERF on affected processors
so that the IRPerfCount register is not used by other entities like the
MSR PMU driver.

Fixes: 232afb557835 ("x86/CPU/AMD: Add X86_FEATURE_ZEN1")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a839ff506f45..2b36379ff675 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -869,6 +869,16 @@ static void init_amd_zen1(struct cpuinfo_x86 *c)
 
 	pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
 	setup_force_cpu_bug(X86_BUG_DIV0);
+
+	/*
+	 * Turn off the Instructions Retired free counter on machines that are
+	 * susceptible to erratum #1054 "Instructions Retired Performance
+	 * Counter May Be Inaccurate".
+	 */
+	if (c->x86_model < 0x30) {
+		msr_clear_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
+		clear_cpu_cap(c, X86_FEATURE_IRPERF);
+	}
 }
 
 static bool cpu_has_zenbleed_microcode(void)
@@ -1052,13 +1062,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 	if (!cpu_feature_enabled(X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 
-	/*
-	 * Turn on the Instructions Retired free counter on machines not
-	 * susceptible to erratum #1054 "Instructions Retired Performance
-	 * Counter May Be Inaccurate".
-	 */
-	if (cpu_has(c, X86_FEATURE_IRPERF) &&
-	    (boot_cpu_has(X86_FEATURE_ZEN1) && c->x86_model > 0x2f))
+	/* Enable the Instructions Retired free counter */
+	if (cpu_has(c, X86_FEATURE_IRPERF))
 		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 
 	check_null_seg_clears_base(c);
-- 
2.43.0


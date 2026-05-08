Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012014.outbound.protection.outlook.com [40.107.200.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2F36E497;
	Fri,  8 May 2026 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220045; cv=fail; b=CiiW5arNUqdrig8zHm6pOVV4qIr9gUlHbQvt24cuW7JzyyMqume1KF5db/ccNtMZGcwCEp9RUEsIl0+KrMEY7Z6dgH+0qyg4shty/bfRb2lQ0MPAIe0ijeOn3J3v4buoB+BdUHhvIrijdx2fjSIixlV5a/S8flLG1N7g2PC/Jng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220045; c=relaxed/simple;
	bh=7zXAJ4yn6KrmshMAL2TLnr1rwAvlIeQjfgYhRQGwVOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JR3yuOYuqfQBjCZSAf3pFN/kI0xY/HjViaRDt/MII9ju39mEK00GA+H89mRnlepnmekNUDsRyynUaiBn57l5MA3rwVHdoAfU1uZbnCiId/+WRLyjMfX8l2XhYWPYVIetIx0RemcdIAYoFAdHUjmYUGTIWqOK5p62xReGBn17ueQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k3AFto81; arc=fail smtp.client-ip=40.107.200.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k3AFto81"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjqNehqc6UWb1Ga1wKd75do7oPoeyoThUY5SAiM0D0Oh43xhAHv4KT0DiNuyMR9DsKvrFcU2I+mUcdYlXfNdC3Rjt5QmKrAIWqzcaoKYPjD7JlwqUn8CGHhkZX+cnhyl6qQc2Mky398rZO9mgPebTtZeL+gSiCd+7wnRsJPYxL8P/7yzpC08ryff8lxKWfuWhSrrV1yrlV8r0xnM4J43MXwRyRPusE46UCD9ze6w3yz1ODzxCRZfQsP/iFr+AvzOt0HD3YYqlWprA/13pvPpN1LQEhA/eghrAFSmU2/3lnS8J0AqzlRbz6alUC8aIz+rSA9wmt8LySVY3qns8clkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl8FXe6pRqmEWIwlwc9yNDjG9gVaKpV0+YVl7Tgq3oE=;
 b=H90T/xDoN0guIbb7/HqtY46MaWRO8vzsywfVnG1fSo8bEs3sU8z7j6WWJ9Ngs1hkXDpyWu5ExV3+Sg1UqcD6RqWnqnjRlvAD527V7FLLcLkSiupX1MsRA51zfiwJP3UGV766Yk+a9q75DeD7ibpIhutay20R7ZnfuPN1XxH+KD02JrATN+9WAB6e/PCZYFirmTmXpLqZswFuvPTflqaT9Xuuc6OjWfpeWGeIl19Cpjz5cHbTCy0Jjky1dtJtXuP1YQQfL7llMwUb4xuAkPaY7G0Yjf5oT8LVdTkwFz+jPHMG/U0DrtLxQ5E35d/Tn0MgkXJXmA+gglPezdvgY8p3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sl8FXe6pRqmEWIwlwc9yNDjG9gVaKpV0+YVl7Tgq3oE=;
 b=k3AFto81DOJ0rnq2ghfisxo31PXjzQLtSVsPTMTwbASTBRE9nWOTl74P8nkOr3u5O0npu+jm2xR5fravNKvfrCz8hb/0DhuiVXAJqk5CxOqeI8jQfhwF+glij8Z9kAivn0sYDWQxR7STsFRHXmT/2uKYpC9hlBME202b8BCRB/4=
Received: from BYAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:a02:a8::21)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 06:00:26 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::81) by BYAPR03CA0008.outlook.office365.com
 (2603:10b6:a02:a8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Fri,
 8 May 2026 06:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:00:26 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 01:00:21 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v3 1/8] perf test amd ibs: Fix incorrect kernel version check
Date: Fri, 8 May 2026 05:59:57 +0000
Message-ID: <20260508060004.2575-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508060004.2575-1-ravi.bangoria@amd.com>
References: <20260508060004.2575-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 4026ec17-6c97-4232-f271-08deacc719a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7PnjN1Px2+gNZiuRvXKWjtKRTtAaHZ/Z7/8bvefdTzYdpSI+MRE0zjznSvoXN4F8Cc/SDEcL/oCiVs3z3LE3SUURovYoVOCqTE76CcOPooiUYmA/h6lyWiuUXSJIsY6AuZG/xcUbG36meUN7Ad/hhuqI4NSsJRFZhL9HUvwyPLmJZh6BKCB6OEU2QtluzPDdhFVPvOBFljaJR55lVQZCsXor3rEdH0nByYln/JJHf0iiCy/oO6yDmZTJbQR7CwifWXfB6piPZEpFSvrZd5nsQ4cQ3rtQthTibHXAZFBmD7gdr0By+E3lylUM8cuqABmu6FOoXKCV+cEoKpiJEejp5b5pKCBciUDRLrGxKH+nv5ec2OxjdZmYM+UVqCnTOXJOOfib6rX1dXmvOBgWipXC9yBgyOvxIJjf32WikfvA2BpfR1WvHNgVvgXQ/Q7WnJ4Cy0F+KaB6v6SvmZGig77VYBS32hdnaLQanfNtm9N56usIFC/jNwE3EHKcT0ZT48gYtR71G0YFgZTURS352er4cBB3N+pCxkGwmlf44yD0wclaLPWcze0GdUCm4DhQoL5YPpl0fyWnspRrl7KOUjvtTfNmUgXxbj3VnXZ/Fgrcls2zKv4jkfLSSFsK/+MCg4QnTNiBgWxyP+v79bv3Vwu6uWZxss2tQi/1S06ScO6QtpOwGp8RlEXh6KimifTBz9PCg23Yd9HBpZvSA0GctXtmQs1T2LVR/CjRo4DqF/IfVF4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qFyZmzJzsNV6FfYd8rH1E3KiqefasYetozSdGtGZxOtpojoRaq0+BDyGR/flMJI8duaB4wl7HbPC8HxGO9yqL2b/FmRUjlGskkZVPNsXXq3Xx3tfT95HaMAOGSGHq0DGc/RqG3w+tbgi4t3iVg2Nbt8O+87UedFmYbwZScaDHiOTV2aIFXYK4KmZExTY3IsKFTn7aTij0fQwVxqQQ/cUyt3TMPKA4vmnBkkX2IYkapJ4kNG4iFDWXiM3GuogOg5MRsYaNBYswwcD4sZwU59mS2faN+4TPcD7ZHsd4D90/INc0SVOnE+ZWi0hn7GGM9fdQIQsRHMYuRB+6c3d+s7Vr8vVXYEwm49wk3ODe1riu7gff77o+W2T8Rnx+IyQUJ2qZXWwOz5gsyw8T8UE3hoH/J8drkU57/1M4KmitdNXMctL3wi12lPI1kk+vv7L75EV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:00:26.0864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4026ec17-6c97-4232-f271-08deacc719a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891

"AMD IBS sample period" unit test is getting skipped on kernel v7.x. Fix
the kernel version >= v6.15 check.

Fixes: 21fb366b2f457 ("perf test amd: Skip amd-ibs-period test on kernel < v6.15")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/tests/amd-ibs-period.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
index cee9e11c05e0..6a92b3a23ed7 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -932,7 +932,7 @@ static bool kernel_v6_15_or_newer(void)
 	endptr++;
 	minor = strtol(endptr, NULL, 10);
 
-	return major >= 6 && minor >= 15;
+	return major > 6 || (major == 6 && minor >= 15);
 }
 
 int test__amd_ibs_period(struct test_suite *test __maybe_unused,
-- 
2.43.0


Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09744BD36E;
	Wed,  7 Oct 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791386965; cv=fail; b=ZCpl7YT8caPSSYSqkqqxN1rcwE9bWS1VQJzlKMv+1xxgfAmexMjpnQps41z94VnVbSXeqUlqk7AY0Vnt+uuQ0zs3r2OhMZtdct24nDabdzu2hX5sXEfkzcLG68xOqyuroqyuIdruZy5DqbNkb9dnE04m6WabLto8EDM1qvJ4W+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791386965; c=relaxed/simple;
	bh=P+RZGtmgRmiISHT0TvznAUQ8EVODC/kL83bspdueIvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=itzjqKlEE6Y02drtpwJST9+4sk0OAqBf8QtlrJlqOXrj2S6475V6liAY0JdqPnMEZ8tPWdAohB1tbTs6/ClRgxk9aaPobkeWy8E7o1+mskZtuE3C1l3Nj6zxMOGkx5jqZfSuCQIvSiI8JJDN921MC7grNfaRPVkDbpN0SuY6Ffg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HE488piI; arc=fail smtp.client-ip=40.107.208.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HE488piI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sP9K9DmfTWxZRrtx3z1CUtNntkbisZOzizKaBzsuooiCrN7oXaU/3YhwXpmNkXUed7X/JinfLpHJFQK4LvNwfsSveZR27NTT9xdPacVne7p2s8IpIxwxNHa6Y/NIkoPr5VIK8p0ToCOsOowimU324Y+KVBM5YBtL4Qf9WF/3/rODlz0BnOP/eDd9VDqkli6uTaDyrmlNQf7Hq2l/sQihsKyTSJFa/gW0RwFCLBKl2orOwbARiuwKUYZYzojHIm/ai3pQkv+7cMYOpXcvlYR3fSIvU1yDSFG8XlsS0MVcvyf/SyhiYzC8cFUri2Yl+9X94FZdjWZ8Qz/BZ8jKaqZDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkgLhue0tjAIDJ/+Ra2QfyTXeq6iNMz8xFTcM2ZOaQs=;
 b=i6IoJ/bjj5HE52WCeuCBOCwy9GR7C6O/SfonjjH3H+a9HN0IEBE1XKau0csDqkNT6jautR2ROds5fZw3l5ogqE6U6h8ooJrtFzXrJ+vwH9lELkK3BUea/CpZMnEyzlAeCc0yomPxB1T5M/Py343uVHDEhn1JEBo0HFFcwP5Rgy5aX6qeyKUERCiBV0NeMJ17HbyTaoltMohF76qduMyTkk/QPCIiRUy1YW6IvIVWknE5R3fQR36w7RULV75Mfjxsf4lkzEiMBrjBL7Xgt18i2rJ84t5tcAKD/BpuJk/OvZVavx2YbqQpob44w2YX9b4AUyjNuN+ORkogjOpgSbKx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkgLhue0tjAIDJ/+Ra2QfyTXeq6iNMz8xFTcM2ZOaQs=;
 b=HE488piIzLHbOOdkFvpDeoVsny5sCIUJtHbutD70or6GHp08Gh+hDBYG7C5rrk/67i1VyhbxlOrF04m50WQ9tjnSxMDmmWsBjrtQlk8XKDMH1PQQmqy9dc/64THCT17sg6cv9DHEFxP2Fx5c/aceiQxXRmDbtBtcCAbtv+9eQvs=
Received: from BLAPR03CA0128.namprd03.prod.outlook.com (2603:10b6:208:32e::13)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 15:29:15 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::12) by BLAPR03CA0128.outlook.office365.com
 (2603:10b6:208:32e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 15:29:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 15:29:15 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 10:29:09 -0500
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
Subject: [PATCH] perf/x86/amd/uncore: Extend num_umc_pmc to fix UMC discovery
Date: Wed, 7 Oct 2026 20:57:46 +0530
Message-ID: <20261007152746.3658877-1-sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9ffab5-3157-48e1-1761-08df2487bf23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|6133799003|18002099003|10067099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Sv0DFleDmID7a6N+gh1sS5u++YOVLxyU1ShWOJKTlBsHip8RcISp9n2QguiPFR2sVUrDombaJCkpJEvo65aeu+MqQ4kuje1cuUvBj91ziMmpqCfHCzz6GJcl+3vFnZZrgnuVokrRyMtCc6DHTon2fPwsZXSjwM6EdCXKzoMNs/RkN+DBrlh/8Dw6LSEXUzPSApUTRNocL5BEtv/Ap+UIfpy4RgjcrP4JAwz9ZVdfjGb/gwe/t4e7mxDah0HT3sCUvakVLWca1rvFkdWOGA0bfet4GgPTMxYy+s67ndkuvy/HLUd6cLNltwgCfSTUDG4P3T/bsLQLilfbWh45rBQbABJj1c1SU0asoqJrXGDkpP+mt4ecbUowoahMaQ4f/WsG6SK2KZccsw2X5jyrs9FVeskDhw+VzKYQDLm7PTXl4ndTktS7LucpeuS8Yx8TkwKORmhrUBBwYG8qP9MUxskBNE25j4QFwvmOrm6hddKfUVOx/D/dJpOINBqe0ojRjNsxByxyZg1PX0ZPWJJMeWxMvNE39cF2sPukyvs/ggZ6yPFZYu1Pf0rY1x/sG+UH1ssU3jTUHrIq6Ow46liDMnmd3YhiWWmNUcD3KHIS8B0799PYPL3tEm2KKF+J81OcBfJAYT4x4OJDU8ghnoKCCcXCeZCEEiAnve8uonCYr16HjAvYHj/SStBhkfyU1NCNatN7ZyiQSCOSV91BKVfFBgxMUw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(6133799003)(18002099003)(10067099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BcrqU9MMSYJxMev0gi5T8nRqRUM/AbgT04JSESZ70YZHvFhl/eQEr2Pf3VRtqM1m0s3z7X3gE4fDUh3W8s0k/Tv0M/mwc+95vpHj3AjxI5ObjqF4uicPVckWdOB9BRS57FhhPNUZyhGoIYk3vG0TXcf4+duhU1RGuMFeXY8h/3WF/X2Y8+3lPg8G2Zd3d/Anj/mzfvA5S/WYQHOiPYewk3SYPisJOvRiWD/+UsPcIJ/PgC6ViaBhz4qnTbD0V5oqUg8UKao5FkPTQBYhMem9YASxKopQxCW4u7YuFNnbv+BGcGffIwkQPNZj46iEpLMsp79mbUEPIcVcXWqNN/mwuxTLVuoHBLreOKr4EvUTUOkDa/IMGoC9zscoTO3aHjL1AvmRLHdJs4TtrgxljckRlumz6tRsE1c25DC8eSPamGTC7g9HdnvRpMmlw0EvqT1c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 15:29:15.5400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9ffab5-3157-48e1-1761-08df2487bf23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441

The number of Unified Memory Controller (UMC) counters is advertised by
CPUID 0x80000022[EBX].NumPerfCtrUmc which corresponds to num_umc_pmc.
NumPerfCtrUmc was introduced in Zen 4 with a width of six bits (21:16)
but Zen 5 documentation revised it to eight bits (23:16).

No issues were observed thus far because the maximum possible count,
which depends on the maximum number of UMCs across the product lineup,
remained the same as that of Zen 4. Six bits were still enough to
accommodate the value. However, Zen 6 can have values as high as 64 in
fully-populated configurations and run into discovery issues since the
two most significant bits are ignored. Fix this by extending the size
of the bitfield to eight bits.

For Zen 4 processors, the two most significant bits that documentation
flags as reserved, are guaranteed to be zero.

Fixes: 25e56847821f ("perf/x86/amd/uncore: Add memory controller support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 5c92d43bbef8..18b8b0c0c5e3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -298,7 +298,7 @@ union cpuid_0x80000022_ebx {
 		/* Number of Data Fabric Counters */
 		unsigned int	num_df_pmc:6;
 		/* Number of Unified Memory Controller Counters */
-		unsigned int	num_umc_pmc:6;
+		unsigned int	num_umc_pmc:8;
 	} split;
 	unsigned int		full;
 };
-- 
2.53.0


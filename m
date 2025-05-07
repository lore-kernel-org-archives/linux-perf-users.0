Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC125B67A;
	Wed,  7 May 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619946; cv=fail; b=ppcAIF3QqyJwQYcZ64w+msjEzhEpTqmcD789Khuvo1q4hKKmUw/JMvCjv52z8Omx7xmvP40X/dlCC3TrZR1ObLRpAgWevTfpdhnpYd+kCmm2/B+8t+hAB6fXgm0uYM/6ClEFoNI4F1Ki3ZdMsarzCTSaH04FMLc5H7kWNak+pCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619946; c=relaxed/simple;
	bh=Ax4vALR2n0BLU76+tW03h++MiLhFKd/E4UWdCF++Xx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y/a7SSRvL5Kcthzbe304PCM52v4jjuWL77tEB59Nu+HK8K291gskGsgOycjxtAZRSFR5aB+ima+XJgLI7JYfoVdmb37cFalEIu5Ff1qxvErpZMiWFpyfxff/+s4heTsJth8XRw5QCurXmOn5pmn5LeZbhGe3Aqn7sqTu9xr8n/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ISmXT16K; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ISmXT16K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvHX0qqM33ca4gcgGFu+btf7Nl6ipudkc4ab2qa+g5hXb0g7HCK+fzLeO8+9tao42z+HcemB7hm5png84+OAIDl78AXYbJKcwpgEOl0zGukimL/3cUngiwDskJeTjaGFGZ8uwtpUlz4ldRL8Q36xe4/rnUrRcGe3Qt3TTej1Ov6/5nNkyGjin3uJwnfw7ar+Kx9sV36463QbQf3h4btCYD1HOG6knwbt5PmnopcYDU9llrbMDmW654wXk0xlIKjxK8+cHjEax1B+dMk/DaQw/LrbeSTO96PXYmvfUOcyKaHIPP1uOahAsxatuibR0nlgQE3mXAd8Y/EvgNUyu1zRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+pjdzLugyYnHdllO13hIqRMz/hMI1AN15ZN6lMpePI=;
 b=p2ewhnux4RITqHM8/bTaYMOHErQNRKLpylEDfulZZYLws04lE58IJ1zONQyVDmBLdPK76YFNJCeUpHjIFSWF8I/HfHg0W5FfZLrOjPdx6Wg22yEYzhX6CMzEvkTUMgE1/hAMbilgvu+0rJ1vesyrv/6sVZGmVM20nv0zkcQFGTTFuMO9gHt2RW4PYY4SKfy+3NKgBgzcfXQO/cjeyoM8b7Pak5DHDPpRprMFmsBPby4pWjyxqNRy9iWVKOuAY3w9xf5D5/T9zf6GGs6UrwHlKlbsliuRuzu22Wt7oclSueGXj2C/znogNwpaVpdy4lEphEFxKQHbs/I/ogEUGHkXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+pjdzLugyYnHdllO13hIqRMz/hMI1AN15ZN6lMpePI=;
 b=ISmXT16K3B4S8KsUk8mlLzl8aOwN4K9g+r0cRnDuarTuafPRhHmkQckdIXdaQ1l4J1LdYgD7ahMPrkymKCAkEhzvt4J9iv1UNQk4rMSPikFh3PL4zW69yGZrnSUh0wzMwYwUWOViar/aEZFh7WFpQaAxY8GFCXmuBC/YAU8awMk=
Received: from BLAPR03CA0150.namprd03.prod.outlook.com (2603:10b6:208:32e::35)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Wed, 7 May
 2025 12:12:18 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::c3) by BLAPR03CA0150.outlook.office365.com
 (2603:10b6:208:32e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 7 May 2025 12:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 12:12:17 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 07:12:12 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Stephane Eranian
	<eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/core: Fix Family 17h+ instruction cache events
Date: Wed, 7 May 2025 17:42:04 +0530
Message-ID: <2f475a1ba4b240111e69644fc2d5bf93b2e39c99.1746618724.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f06bc9-7631-4844-e2f9-08dd8d606914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TpW3HvI/LFyGrJpWzc77G6DrIFUp+TFJ3gukOL2Y7rBMICbcAlCRNwybs0Zk?=
 =?us-ascii?Q?aqPHajjRxxPjqaHjNrGe8gNHRgEUPhGhFBDQjgmlYLRFUnehl3uDAFUuAjWs?=
 =?us-ascii?Q?aa0IY4SijPuqEoXGv69F2nUz4itfEDI2zqkAeg7C9vzFYnS474s/O3yusE8t?=
 =?us-ascii?Q?WPdUXzkWJGNMpC3SXrnZz96SzIuliFQwXBYnKiIzd4bvn9RorDdrsLFv+HFI?=
 =?us-ascii?Q?yeyj9SGOI7wWKh2lJs7tpox869i39XpICZR9KJLyB267aavOb2Gsi9YiIoEX?=
 =?us-ascii?Q?jUHGF66+uBBinH/KdxEd8XoW5MjRlObjFuwo9vbm0mmXWfjDJtV4SJjTdDYc?=
 =?us-ascii?Q?F88H2JOwt7LQa500hEj5WbXHho5Y+Fw/GblrLbkFJBsFgaQ/TCfJO/LcWHHh?=
 =?us-ascii?Q?rYiggetVJGQYhriHsooe4n9SfpGt2s+vDPa3GbtTnKxC5gfNioyMZgqZ3m4A?=
 =?us-ascii?Q?yEoAArN2S7kP25SLtzSGdK1+ZwTkPAuAix5vJ5Zxn1z6QF1Lqe+4rhOCTqjp?=
 =?us-ascii?Q?v7QvA5XgDs0JSnxcH+67UB0liU6Xwi6C//THVmsyKe7GzB/HbthnO1gLClcp?=
 =?us-ascii?Q?LbSv5iDyejegf5RA5hox6iLMcOPmxqDGGvmifbkX3LmpxuQgzaV2Bm2Nlpu9?=
 =?us-ascii?Q?rSMWzAIkoahK5TQZ3FiSXTSyIghphhpMX0vRw72PPgxEiSSEg8oKhc/0XsuK?=
 =?us-ascii?Q?vSu1XLs8K1h+VEWC87IG/X6jUbBV4RWbsBpD40/oVm9O2OFwUJbG8v8sXkAR?=
 =?us-ascii?Q?G+PKgML+azq7m5JOP8Ix03AM64c1alih/mfXwhoL8ZQQEmzDKYbK+nLv83pO?=
 =?us-ascii?Q?8NhxQIfhMBgW6y7JjHcqbNEQRDOhUmO1nyvihZ5lmEzYjbDhXwUhhTWWTkNk?=
 =?us-ascii?Q?yyzYqcGJshG0VRjMALsjWtiohI53eP9seDPWHnINCbe0nJHCa6q5LrINpoye?=
 =?us-ascii?Q?NMSlWiCIHmfUtMzI+Me096mN1PV23OL8JH3vpaEliyX9CWPsXJIYVl2QgTI3?=
 =?us-ascii?Q?w5lbGbBL1YhAiXAOCH7n+bWnLh8Z1nCYb/m8eX8fcmI6cyH6LsU+K+L+PhWZ?=
 =?us-ascii?Q?0JlQKLrIacWHDYB5bKZOOMyO5hKXiflJUDq4GNzWyC3Z7iXBivFOFtDXZAQa?=
 =?us-ascii?Q?KXBb8s9PUSFCID33r82OMx+r6xf0AQbpiW1z9iPdJXKCSZwQcLPz1DthzPm2?=
 =?us-ascii?Q?dMcBBn0aiyvySXkW1u9Pk7mICotAyGri1AlaUOmD5bamZh00C4U4VpLi4x09?=
 =?us-ascii?Q?olfZokMS8GMvos5GCqQMFMRuenwWDMm4qmnXOvvpddGLb5bQISoxQtQvi0lR?=
 =?us-ascii?Q?2abGuVdlxe/+at18oDQM0PMYVPGruNJFULHisFttjqOE9gIpsl/e8IJGbp06?=
 =?us-ascii?Q?abPg8hd/SrXI/hH5eDheNKrxIPmhbV2dUGRMbXwgNfAtAyEpT8S1wtvmE3v9?=
 =?us-ascii?Q?7DgD0UGnF3l3HSJP3Dvf7GazjakjA9c4v9SKtianREkoc2WwYdUhli4NROPa?=
 =?us-ascii?Q?ThjtWvcTtKhfEGTRFcVgT7LN3rqNJ7RAKUJP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:12:17.5321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f06bc9-7631-4844-e2f9-08dd8d606914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516

PMCx080 and PMCx081 report incorrect IC accesses and misses respectively
for all Family 17h and later processors. PMCx060 unit mask 0x10 replaces
PMCx081 for counting IC misses but there is no suitable replacement for
counting IC accesses.

Fixes: 0e3b74e26280 ("perf/x86/amd: Update generic hardware cache events for Family 17h")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 30d6ceb4c8ad..52860b99d70e 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -148,8 +148,8 @@ static __initconst const u64 amd_hw_cache_event_ids_f17h
 },
 [C(L1I)] = {
 	[C(OP_READ)] = {
-		[C(RESULT_ACCESS)] = 0x0080, /* Instruction cache fetches  */
-		[C(RESULT_MISS)]   = 0x0081, /* Instruction cache misses   */
+		[C(RESULT_ACCESS)] = 0,
+		[C(RESULT_MISS)]   = 0x1060, /* L2$ access from IC Miss */
 	},
 	[C(OP_WRITE)] = {
 		[C(RESULT_ACCESS)] = -1,
-- 
2.43.0


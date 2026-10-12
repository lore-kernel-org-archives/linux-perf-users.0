Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D632B108;
	Mon, 12 Oct 2026 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791706; cv=fail; b=rTDJLyKdxzNP58lY3aNj+IdcGCAzGvmKdlz71KAnlZUhXxxVVj7kFMUyGC4C4ZjkZsspgsVS67zl2LHPz4ImXtxzVKQ4oHpjDmKuSMpVqJaq2Hn0Lr/vwmJMLt124VXQMI7rk2zY9omgkETTpvsdkTpzYAaynOezhkDhDqVN/8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791706; c=relaxed/simple;
	bh=8Syk3CE+DRIQaPZBaJWuy/Tz31xm5iu58Y9+5N7uqN0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZFGzlgYF+toewztCgCQuQsMGXgeJ+psxkQuVFbtESGOGwtb2fuG+95qhMY3eAG1ACk5QgDXSX4k+C7KWmf+q6Dn20jmXd/cN9whvfOt6ztWkV+LjAWmmYYfBF4l7Tvdtjrv6uFM8jXyWYXIFd95RAOM9kSXTegR03ljAcYhRy8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X6kLSRxX; arc=fail smtp.client-ip=52.101.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X6kLSRxX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikUtvSJwJVv+O5x4TVGJXw3AP/n8INnLL3kNB/2Vln4rgWMJf/QDWriH20VKAfVBH1spJgJoMqTNRPYH2Xf8WEDYz5FOCZ6p3qevAwC5jgVbbIQi8iyRv8csRvcMGSqXhlRklEjVWQIpXW1srmOmid9ghauSaIb51eJdkWT+4TVkYbvKwrGhzoFFD6HApGkFiTRZf5CcEY1iLpEDI+J+3k2MWaR80hEZlhjUlXZPI/vn7xQdXbxdTGIu2p6pC+GkjLpgB2cRfDI85BrzXwJNiap/TVkySByz6UwPdgg2Dhw+UBEFQJKJyK0jVLucLOcC27sGYJyBbd4YuIQ0k4Mhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yu7Ur9cBm0TNIP++IGO5yBNn5/5MRFAP3iyzz5eCkas=;
 b=w37/o9CZAru/TRVeBVcYSAXID919ZrLYzzawb4dujNYnMPPAtFJvGra546Or5EZO5wCpVulre0ppegoF0DmtNtlqDf5bRWYhLbs2I81KN+DfaaayfLIvM4ywqqA7iQy04EZX2VRCaDD1tOpIwmlQt7DjoPzGl1ZkwASjFTS3fLdMQ2c4igSyCPNgw8pVvoTZ5wXf8Mjj+0yer8IPPgKvcWSnA9xhISKurvqdVyaFLfqz9HJEHCdNt+1EG9P1TLENQFvKHOqrVBw1CdSAlSMyEvL2OVBZ7lIkDbmRw20Q+813zl6Gk/bJTGfvqzktRV8Lmz+loI+ShLyWDgJVhPwspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu7Ur9cBm0TNIP++IGO5yBNn5/5MRFAP3iyzz5eCkas=;
 b=X6kLSRxXAQ2Fsd5vD7RTE7nLsnNAUV5GB4aQ2FA+rVsYPiy9Ul4VMcEluCzAQvY80C6LRvCz3VKs0lXhEG+XOqOUirKBTuQzTSiyOZdIKIjj24pgFq/77YIH5qNNJ8eK2EmzFnPOMTdZkrF7U7E6BLdL6zSuT69msnsZiBf4mgY=
Received: from BL0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:91::13)
 by IA1PR12MB9498.namprd12.prod.outlook.com (2603:10b6:208:594::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 07:55:00 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::1e) by BL0PR05CA0003.outlook.office365.com
 (2603:10b6:208:91::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 07:55:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 07:55:00 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 02:54:50 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 0/3] perf vendor events amd: Add Zen 6 data fabric events and metrics
Date: Mon, 12 Oct 2026 13:23:29 +0530
Message-ID: <cover.1791791463.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA1PR12MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2eb418-3bf2-4432-ddc5-08df28361dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Z7Qt+ia4ldP53z2OyJf/7dUzJD32fN1n2so4w4q6eZ8HrTY2wM62Qqvi2aAjVSrLi23Re5K7r4oxE+cprhE3R1Zao5COMaUD1u0NPoOBEaCAHZDc9ew2OTSUMzbfVlQUFlPmLvmb1mQ85cGTIgHgp4fWwKBZ4HJJlFa0MKRmhCHnf/z/eYVpGL6zUL+0flDEBTN0J/ZBhoeFYItIy+iNmQJbuqMVJWcsKsSw0T8RQZf/a+63GKX/DGM71DpcD7gQj5aHH23KeI7cg0ymJ0Y3Qz8/wlONVATwpBBvH9O9Eux+Zh7sGP8OlMAg7/zgyI2jPjcmcYZiAqWxP/8oyOsP+D+EUlTQ+it/ojzAvzU7eJhVtcaSOyIt0XAyYXQFV1q/QuBthMlKbTauOKWDSpwCzW6sl6hKAlmOj5a9JV/4MF0Sbodbrz5CCkV9ZaqI4CRUwCZWaVVlVe8LlAyoqPDwIxluB44qwuAkPCl4BupS+uX6+2H+7+w7ftWmoNx3C0cHJlIS7/t6X9e9hPx18YkOoj1tdI4O5y+HNV8Ku7Q5gSe+9/2dQJHR8DrB7dA/X8FBb2BMXyIXd71IPL4j5cbjm9R29j4U7ciXcPpI9DpUe+qhHE3PtPOON62wjObkEEnb5zVOWruTte8nBFRFszbOkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GYQsa3TAOA2GaekMSneIV2FoCjbxJKjUy5BT9iDl3V05P086YYZTfM9jWhuUMtVI3nglgEm365gLeifQxI0YB4mT+uKx+m5ERpIckY/OWlIy7AGCp6jQplrteEnf9EcR6W1wjHn94uSTh2bLZYKyBmusCxsHClqKD3ZECStTFweLGemonxFPlw98TTG4BnoSfM3huicrCBF3aGIsqUJBT0g6uIKULOy3x6QOYlb0Mf1wOm8cMF9RCuNp2u/4xmF+/9t3BbQokQzpFjmx04QQ+7PYDDA8Xr3gj+/3ORn5L9f0AIBzMKZlsBPko9CJqiD92pCF9MPfMnNLLXK+H5JuWk3w09Rq4QZsed622G5VZAEOwqV13gT/OFVX0JaeVXbBOdhF6ifpPVEV0IGpn4NUQsfbWG2keZ4dSmgjddJYtymTHTwWX7EfUEqTALAdjT3w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:55:00.6116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2eb418-3bf2-4432-ddc5-08df28361dff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9498

Add data fabric events and metrics sourced from Volume 3 of the
Processor Programming Reference (PPR) for AMD Family 1Ah Model 51h
Revision B0 processors, available at the link below.
https://bugzilla.kernel.org/attachment.cgi?id=311021

While at it, also clean up redundant attributes for other metrics.

Sandipan Das (3):
  perf vendor events amd: Add Zen 6 data fabric events
  perf vendor events amd: Add Zen 6 data fabric metrics
  perf vendor events amd: Remove "PerPkg" from Zen 6 memory controller
    metrics

 .../arch/x86/amdzen6/data-fabric.json         | 1542 +++++++++++++++++
 .../arch/x86/amdzen6/recommended.json         |  107 +-
 2 files changed, 1640 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/data-fabric.json

-- 
2.53.0


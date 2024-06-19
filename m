Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D87FBB4;
	Wed, 19 Jun 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788981; cv=fail; b=S6zyWP1JQETNNeD5xWirXHBqkQOmyLgJcgotl89k/apXPNwkNOEm+zYLnYGTFArrqeFkwjQ+p81Ko+LQW0SCIwJ2W6yd1M7LhfDspRk2ptskjsGIlTjnFk6cWHoT0WGYDNZzOLBdVCNXiAzbKeWnAa+6pAK+nHSmy/8cb6JKF5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788981; c=relaxed/simple;
	bh=IxurbwbXKay08t1uSN6EmlyWX9tSuuSvo2Xl/o0vgX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tm4TtImMDvQEHXguJc9h+tLDUwX+b/n/fczy0r7MtA5YFT//yYS83Mp5Ycoe011YsJlw/HnpbX7UuC4sBL9FinuQeIHLr1fMOb9jnFLvfbAHeEBN38NuwdRCvf1/LPfghi7eOuqK8OivbSQsRsQMv7aci5W71s52Ns4wlh0b+J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YfJyEjFN; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YfJyEjFN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bid5w1M0jluJRCb7k+u82wZAAhtl2et6Kywi3k1K8UgcfXFRqoVZJToY0qaDQy54pni3WxIPWSmiPS0f4isjARG6UtV21f/nCr/NzfHYkNuuwfcgWwWlMCzU8czEy1mg0kPrsbr235f59ab8nSYTQtQRxQS2WdWj1qii1uI10XM+15PVeefObZl7moRMuOBEX33pZRfoDHWaOU7DQWA0IESfaGvPx8UDIR6p/X4btYgbB39o/cyp4NR2wlGpdys9X7y2PA5pc4NTyg0qZTbpSBORZhF/3thCq745ewr2vYTLXy01fcr6miB+9E2U/RRx++/4sJCGQdFDhRtLEuNrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TQXm9/JCu9x+AXzGeZEPPKq+GJj0VzZp4rOTXvMlFM=;
 b=DPWfh1DnAl6P2Tszs8qzrUBFlg+WuWeXcVqmzes7UwZ96yw4VuWAoG0nvXNoqEq4yw62yq0Dzgeh2x2ROJEd07ar90tVa3bL8mEcTFfs8hMjIezvtiltPSmkwYnb82i9y4BUQtmYhVyFeodnqlgRKdiZXLZvcrfbuSHbOuhiHTgY0JKAzJZtpcT0lzqWC4KYtAea1f/nH3+/S63MtHPbL2VMFfH/QDUiu2XegrGM4VmhSmuS3wwf+5KlYgX06qaXohab7ZaKThQ4d40rNsecJEIl2hgDUgP1l0QPnKASBNr8D/90V63sWhkm+0xAeLhCwFY4W2Yq3BBqkX39McTXiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TQXm9/JCu9x+AXzGeZEPPKq+GJj0VzZp4rOTXvMlFM=;
 b=YfJyEjFNYBBc7LfKXjSGj+mGfkRY4Ddx0vKmTO1qbNlR2q+5g5UcL1vQFf+McBn5OEE3fwue3OOeRzV0/sSt4G/ksEWpxDqbFe1ImBDxG3xmjAl6ish3KUhEbs8+DBvljLDS7uCjv2BDG2UD0UFvcFmuH0DuSgTN8hZc/NC/PJU=
Received: from DM6PR11CA0024.namprd11.prod.outlook.com (2603:10b6:5:190::37)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32; Wed, 19 Jun
 2024 09:22:57 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::6a) by DM6PR11CA0024.outlook.office365.com
 (2603:10b6:5:190::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 09:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:22:57 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 04:22:52 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <acme@kernel.org>
CC: <ravi.bangoria@amd.com>, <namhyung@kernel.org>, <irogers@google.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<yangjihong1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <sandipan.das@amd.com>,
	<ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH] perf doc: Add AMD IBS usage document
Date: Wed, 19 Jun 2024 09:22:34 +0000
Message-ID: <20240619092234.1165-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dd49fd-0277-4ca5-9ee7-08dc90416835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7rDjqP5ZK4otUPf1nb1TWRNsAkw5N/I5BDzo1UVfmPPPJTaRazBLO/H7OxQw?=
 =?us-ascii?Q?HvqqGJLIStJ+ip6brQkocYj0q6LPEFwOFR9oeyqg9YZoN2ExOdAUl9+V9etY?=
 =?us-ascii?Q?my9KljHvPh+aeMHiefIq10c/g8kb4JLhIodLn/gnlgPy50HN/SRWQwSJso7a?=
 =?us-ascii?Q?BW+/r1hX6aNUR8j1v/My/PTlyCfEwciHJm6fYyZghdlHad+27uokJcELfu1O?=
 =?us-ascii?Q?E0AGcsUGOILo3SwGKr0BB86kRicprugmK2Q486Y9iZw3/3I05ZxnX9e1dyBB?=
 =?us-ascii?Q?hCypNLQVJLDjD3Jxfaehp7ws+toPka0DcWh6+rQl4qzbWw6lBXXSnLX/2KLU?=
 =?us-ascii?Q?upkgCAe8BUxm1MGFVjTnJDAS4bhnN9rwlgq5gB7D9qKyEBskPX45cptecl5R?=
 =?us-ascii?Q?dH3nGZO2sjrb2ZEQADAhbVSLRgvAhdB7v7Od8g1JGqr96MB6PNwwGmEWpiHl?=
 =?us-ascii?Q?rzWnQAIbZ91tOKk/YwrM4Bfys/OTLrH9DsnoHPGLUnYCw4lptqmGnaFUaelI?=
 =?us-ascii?Q?MC0KeYg1EHNtmhsukGqBuO0Zdh1PIonToRdjetpKNa44cGNRXj9fkef9XDtd?=
 =?us-ascii?Q?m3yit7wnLUtY2voS6nFaSBGPq2muJ3jJ1myiXgrvsSwp+pOhmMrG8TCDtGCy?=
 =?us-ascii?Q?1UBkIl7LyqSgBMjxhGzVnuzgT0nodT9E5cIAeD1WMmZimbCRtDRd0p1Ht/vF?=
 =?us-ascii?Q?OlE0FHimoylXIBZDMyjd4hGmanPVgU+36toCzcFQWFU+IsB4MiCU+y8/HVOo?=
 =?us-ascii?Q?59OS+rEU1hvLXanFpNVh7WM3aS8POn8SxV1vijj8n5MoEv+6xLnQtmxuAS3n?=
 =?us-ascii?Q?8COEDj9zmohg1cnch3Hdh8w2d5YDsNLo9uhpuz/jzmzQgLYlf5yJTyU4CAh+?=
 =?us-ascii?Q?6Z6tZoy4/mifAJbg9f4o4tjpGV2ZnHVURvFDBaWs9I19oIGCX9bsBf6aXnId?=
 =?us-ascii?Q?F2RTFTGk/+GEH7HzA0v7d0+on8ZJw5Jr450VnAjTVm7ilL7uofFgdc5RmgZi?=
 =?us-ascii?Q?IbuABUISLrLmycgF51QJMD3NlhkOjikqNBkqYbaw4aLCLg/jeQ2zlWuLuzsW?=
 =?us-ascii?Q?oyaY6Zr1V1iwymmOqPDVJTS9vnm+0jxueTFksGy2ksY8bGDN54Xnfe0rHTtF?=
 =?us-ascii?Q?+3bm7LASLc3v5axNMXcls4L40Z2hHNPfaIyrnoFPfV4sqE4sRnixNxEmgmBc?=
 =?us-ascii?Q?QrP3YJbdlsug1PZ/5Xk2LNRZ/tGkFw3MCiKlnH+5P6MPg3iF2zJ6oqlH8zQJ?=
 =?us-ascii?Q?Mqd2goFgIMS3idMOyr+zwqaw2A7o4T0RXTR2qzhi1kapGtzPWskm6k3rg5DR?=
 =?us-ascii?Q?5Z6/fZ15/To/2A6LfBFrKWbwJXc3VXH8xQUQbTJx2r//B05VMGZCUD3Gs/SZ?=
 =?us-ascii?Q?o+dkAYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:22:57.4292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dd49fd-0277-4ca5-9ee7-08dc90416835
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

Add a perf man page document that describes how to exploit AMD IBS with
Linux perf. Brief intro about IBS and simple one-liner examples will help
naive users to get started. This is not meant to be an exhaustive IBS
guide. User should refer latest AMD64 Architecture Programmer's Manual
for detailed description of IBS.

Usage:

  $ man perf-amd-ibs

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-amd-ibs.txt | 126 ++++++++++++++++++++++
 tools/perf/Documentation/perf.txt         |   3 +-
 2 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/Documentation/perf-amd-ibs.txt

diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Documentation/perf-amd-ibs.txt
new file mode 100644
index 000000000000..d3dfa71e320c
--- /dev/null
+++ b/tools/perf/Documentation/perf-amd-ibs.txt
@@ -0,0 +1,126 @@
+perf-amd-ibs(1)
+===============
+
+NAME
+----
+perf-amd-ibs - Support for AMD Instruction-Based Sampling with perf tool
+
+SYNOPSIS
+--------
+[verse]
+'perf record' -e ibs_op//
+'perf record' -e ibs_fetch//
+
+DESCRIPTION
+-----------
+
+Instruction-Based Sampling (IBS) provides precise Instruction Pointer (IP)
+profiling support on AMD platforms. IBS has two independent components: IBS
+Op and IBS Fetch. IBS Op sampling provides information about instruction
+execution (micro-op execution to be precise) with details like d-cache
+hit/miss, d-TLB hit/miss, cache miss latency, load/store data source, branch
+behavior etc. IBS Fetch sampling provides information about instruction fetch
+with details like i-cache hit/miss, i-TLB hit/miss, fetch latency etc. IBS is
+per-smt-thread i.e. each SMT hardware thread contains standalone IBS units.
+
+Both, IBS Op and IBS Fetch, are exposed as PMUs by Linux and can be exploited
+using Linux perf utility. Following files will be created at boot time if IBS
+is supported by the hardware and kernel.
+
+  /sys/bus/event_source/devices/ibs_op/
+  /sys/bus/event_source/devices/ibs_fetch/
+
+IBS Op PMU supports two events: cycles and micro ops. IBS Fetch PMU supports
+one event: fetch ops.
+
+IBS VS. REGULAR CORE PMU
+------------------------
+
+IBS gives samples with precise IP, i.e. the IP recorded with IBS sample has
+no skid. Whereas the IP recorded by regular core PMU will have some skid
+(sample was generated at IP X but perf would record it at IP X+n). Hence,
+regular core PMU might not help for profiling with instruction level
+precision. Further, IBS provides additional information about the sample in
+question. On the other hand, regular core PMU has it's own advantages like
+plethora of events, counting mode (less interference), up to 6 parallel
+counters, event grouping support, filtering capabilities etc.
+
+EXAMPLES
+--------
+
+IBS Op PMU
+~~~~~~~~~~
+
+System-wide profile, cycles event, sampling period: 100000
+
+	$ sudo perf record -e ibs_op// -c 100000 -a
+
+Per-cpu profile (cpu10), cycles event, sampling period: 100000
+
+	$ sudo perf record -e ibs_op// -c 100000 -C 10
+
+Per-cpu profile (cpu10), cycles event, sampling freq: 1000
+
+	$ sudo perf record -e ibs_op// -F 1000 -C 10
+
+System-wide profile, uOps event, sampling period: 100000
+
+	$ sudo perf record -e ibs_op/cnt_ctl=1/ -c 100000 -a
+
+Same command, but also capture IBS register raw dump along with perf sample:
+
+	$ sudo perf record -e ibs_op/cnt_ctl=1/ -c 100000 -a --raw-samples
+
+System-wide profile, uOps event, sampling period: 100000, L3MissOnly (Zen4 onward)
+
+	$ sudo perf record -e ibs_op/cnt_ctl=1,l3missonly=1/ -c 100000 -a
+
+Per process(upstream v6.2 onward), uOps event, sampling period: 100000
+
+	$ sudo perf record -e ibs_op/cnt_ctl=1/ -c 100000 -p 1234
+
+Per process(upstream v6.2 onward), uOps event, sampling period: 100000
+
+	$ sudo perf record -e ibs_op/cnt_ctl=1/ -c 100000 -- ls
+
+To analyse recorded profile in aggregate mode
+
+	$ sudo perf report
+	/* Select a line and press 'a' to drill down at instruction level. */
+
+To go over each sample
+
+	$ sudo perf script
+
+Raw dump of IBS registers when profiled with --raw-samples
+
+	$ sudo perf report -D
+	/* Look for PERF_RECORD_SAMPLE */
+
+IBS applied in a real world usecase
+
+~90% regression was observed in tbench with specific scheduler hint which
+was counter intuitive. IBS profile of good and bad run captured using perf
+helped in identifying exact cause of the problem:
+
+	https://lore.kernel.org/r/20220921063638.2489-1-kprateek.nayak@amd.com
+
+IBS Fetch PMU
+~~~~~~~~~~~~~
+
+Similar commands can be used with Fetch PMU as well.
+
+System-wide profile, fetch ops event, sampling period: 100000
+
+	$ sudo perf record -e ibs_fetch// -c 100000 -a
+
+System-wide profile, fetch ops event, sampling period: 100000, Random enable
+
+	$ sudo perf record -e ibs_fetch/rand_en=1/ -c 100000 -a
+
+etc.
+
+SEE ALSO
+--------
+
+linkperf:perf-record[1], linkperf:perf-script[1], linkperf:perf-report[1]
diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 09f516f3fdfb..cbcc2e4d557e 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -82,7 +82,8 @@ linkperf:perf-stat[1], linkperf:perf-top[1],
 linkperf:perf-record[1], linkperf:perf-report[1],
 linkperf:perf-list[1]
 
-linkperf:perf-annotate[1],linkperf:perf-archive[1],linkperf:perf-arm-spe[1],
+linkperf:perf-amd-ibs[1], linkperf:perf-annotate[1],
+linkperf:perf-archive[1], linkperf:perf-arm-spe[1],
 linkperf:perf-bench[1], linkperf:perf-buildid-cache[1],
 linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
 linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
-- 
2.45.2


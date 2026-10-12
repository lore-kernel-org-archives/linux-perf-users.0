Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165935A38C;
	Mon, 12 Oct 2026 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791759; cv=fail; b=ndhdjH4BgzDDs0eMJsmin56Bkm4SYEUgxHm9Hv4OFVQGf4192Q01qrwQRPFeMueTb4TS/fM3GTQxhVWDXdQlxUYa2PYYQ1g4vnOhDkwybtb4hJCJWKKhyVdbo0NtVrk4SKBCpICEQb8caJntznP4m20gDbbyjcSMH44Q4heKjiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791759; c=relaxed/simple;
	bh=X+uvvrduCGQzCFhQgfFz9GeKGp5mjSQRqO7pweDgb60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elT6ipNYnOLnkbW7woPeU44Q8+Tqpmxs7x6hC4FEdKfWnGPdHa2TYmAfFKaCY0U6aGFGKBQJcLExwH7D3Ii5KwKsfODFsb526xl0Qk2txQ/F+Bu7ih8LrojFr9c3/nUkmhMA0UtpU9UfaWspV+iFJDB2bivo+3hKRa/5HjAZgIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LDXlSDJH; arc=fail smtp.client-ip=52.101.85.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LDXlSDJH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAxzmwafqbTtRhzJTLEio+HVwkigHA5uRlIsO+fnNmZOx5nItw3MjQJ+GwsZJFz4+36YfNNMeyFRcZMyr66F45HriVuujmnWKHk5o5tcW7UAay3V2rgDqNRfs69H2Ms4IpZW44giXJnGBzqB566+C2bBRvAJPk+YcHrsK91/DFV7Um/sfX+k3BH8vZX3GGkIg9qMYtWK+0+ujJJmBL2OmHxRuWKwM861LzNpv5h1DQZvDY/fOPZ4Lhm2AvNRj8laa6lcJpipIMndMRwcrsu1oQtrLHFhRSyi2rzu64G3X0ZJavj5eWFDNbcCY6+viVOQ7DeHOjDD67Mqy7IVeZixag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8oHOphYB5eXZHsO0cHzOZz8k1wxTr1uCeyMZZzyT5k=;
 b=ZQusdB+bfc37XKckZTRWVfkjLUHiQh+x02MN7wAfnT9PW1+m7t79rGA+mQzDWmT9XmeXm2TVlscTZuzv4TUQSqy8/SAV9gUAXdY2/4Hza2EvBKW37J9PMYgt35D/3GCtqccwI14hWGRSzC08FfMBpTmJyq8nbRHN7konzHHGyiboKymkxQvcTOL2kRafc/R7Y24daVUXFCAPMPWg76OU8tBj08awEiro+cDF5W8UhniIXtpDwVSkdaoXGxnnKcKqA2VHpShbR3/ExAYhc/qM8YPbIbDFSagXEL/ndje/BNJFp/gE8SyvAfIqTRFBRQiUaKi0s9ghRHLuwhnzTTL15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8oHOphYB5eXZHsO0cHzOZz8k1wxTr1uCeyMZZzyT5k=;
 b=LDXlSDJHn0VgHPxu/xbymjG5OLky+fOh34B/udDFkP35E8UQ+fsd0LEMH1Y2gYFEZtlId62zl3l+CIc9volwpWtaJlZrGrxEL9fl6px4c+436LoJAEfy/aNeve6tPPN0GUX0s5fesMgLQXzNyYpGawBY3tV8FqBjaMdjYF6VbyM=
Received: from BN0PR04CA0159.namprd04.prod.outlook.com (2603:10b6:408:eb::14)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 07:55:53 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::6) by BN0PR04CA0159.outlook.office365.com
 (2603:10b6:408:eb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 07:55:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 07:55:52 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 02:55:43 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 3/3] perf vendor events amd: Remove "PerPkg" from Zen 6 memory controller metrics
Date: Mon, 12 Oct 2026 13:23:32 +0530
Message-ID: <8f22b9814dbe0014a1486a9510da3bb48ba8aeb1.1791791463.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791791463.git.sandipan.das@amd.com>
References: <cover.1791791463.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: a00e64b1-b090-4780-ab35-08df28363d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|6133799003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	6CS/lzQVwuXEMIzx0JSXujR/DPQkA0V33UE+ITtlGkWByj3bfHT3xyJQLR6miCtnxDfQb1ai9mq7CzWMieNYHrZ2CrOG13xvHwiI1zBaaTp7C8q4H85SYHsmflPgoiY/TaFqXpYpGzET8/uJdi1kv8X2JsW7E/k+3zZwev9wndX7xuAbmKzcPbhd0A+mp4TjcLnoY+2QNFIcX80rEMDrf496rRFJGvHq7niZ5u6ZyJhh6o90PQ7T2+fdV6jtMzs+EJbdjd5VbTa65WTd738Oyr9gPygi/LsUdUqP4jf9x0VMdJooVLMJ3oBhfsA1sCKLgITsIvWflr5L7ImojJnWk4gFnUH0f6FpnnEv2M/dt+BW3lsheM6Vj0IGIXeXp2EQNlCkTcFfK8ggfIL5X1KAjO+eFuxQd9WQY3dssl+oLAoXQOzJ/3huwXfMAtkWUXipUi2TInCaTy3nX5DW/McZlNSvSOIMnfZjDUM2/oz6/G031i853w7NV/EdoaTa35/I8zZGKRpwpTD0NglRcU8SPwI2jT6jovGCQg5g9HhbBnQd6h2rdgB5v6wR3nZ8jKIVlI+R9YI6bBMN+1ZfdKAWCFjhkIhV2T4Qf65yFU1hR0nwjcUWli8vEaiEQLELx8OO0iYEjUHD4Hae/Erc45pF0rE5/OdClR6WjA5WjQyj0Hd14MtyH0TquguBBhTHOHOZs9d+RVPXAvUbjEA3joY+mA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kwdwEq9WDO8k+kVP8Gm4q7udQSz/Ady+zOADqIynya/E1QYX9mrywsq4j1rZIZN2kmINLVheqZFFFvoZAlxJlhyDBddVUWx8CxWG48fd6BDC0i1yFlBDZkXQ3F4zwH9upibZv2Zav8kwgYefsOc01/DBLKdW+9qjUxAMWPRS/2Q5aavikvBkPKXB6JYsxUnkaea7hjxAFZuvJo97CgZPD7z+mSeC2R8sXsACfU3Vi9gVqJKpp6dhpiO6PF7q/0E2FAupSryxntaHpNu8c8g0upKQKhZLZW4iaGa7QL9ZN+LC8V2EBxM9Gor+ogIVqDKi8vjKJDPrUUldXan6E55esMn6yOxlK3d67kP7hORTSUoP63RIsiHh5+5bcGZ97Uiw+DRtkdpeg0QpkJW6mWe8BQqL/Dmc2L/dp9zv0zewqDj+aPC7/95IF3ER01UvqSTG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:55:52.7558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00e64b1-b090-4780-ab35-08df28363d14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682

"PerPkg" is an event attribute and has no effect on metrics. Remove it
from the Zen 6 memory controller metrics for consistency with the data
fabric metrics, which do not set it.

The "PerPkg" setting on the underlying events remains correct on Zen 6.
perf de-duplicates "PerPkg" counts by socket and die, and on AMD
processors these are the same domain. Each UMC PMU instance belongs to
a single IOD, so the CPUs it counts on always share the same socket and
die. De-duplication therefore never merges counts from different IODs,
unlike the single Data Fabric PMU, which spans both IODs in a socket.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/arch/x86/amdzen6/recommended.json | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
index 853700a3a0de..1bc397f933f2 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
@@ -269,7 +269,6 @@
     "BriefDescription": "Memory controller data bus utilization.",
     "MetricExpr": "d_ratio(umc_data_slot_clks.all / 2, umc_mem_clk)",
     "MetricGroup": "memory_controller",
-    "PerPkg": "1",
     "ScaleUnit": "100%"
   },
   {
@@ -277,7 +276,6 @@
     "BriefDescription": "Memory controller CAS command rate.",
     "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
     "MetricGroup": "memory_controller",
-    "PerPkg": "1",
     "ScaleUnit": "1per_memclk"
   },
   {
@@ -285,7 +283,6 @@
     "BriefDescription": "Ratio of memory controller CAS commands for reads.",
     "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
     "MetricGroup": "memory_controller",
-    "PerPkg": "1",
     "ScaleUnit": "100%"
   },
   {
@@ -293,7 +290,6 @@
     "BriefDescription": "Ratio of memory controller CAS commands for writes.",
     "MetricExpr": "d_ratio(umc_cas_cmd.wr, umc_cas_cmd.all)",
     "MetricGroup": "memory_controller",
-    "PerPkg": "1",
     "ScaleUnit": "100%"
   },
   {
@@ -301,7 +297,6 @@
     "BriefDescription": "Estimated memory read bandwidth.",
     "MetricExpr": "(umc_cas_cmd.rd * 64) / 1e6 / duration_time",
     "MetricGroup": "memory_controller",
-    "PerPkg": "1",
     "ScaleUnit": "1MB/s"
   },
   {
@@ -309,7 +304,6 @@
     "BriefDescription": "Estimated memory write bandwidth.",
     "MetricExpr": "(umc_cas_cmd.wr * 64) / 1e6 / duration_time",
     "MetricGroup": "memory_controller",
-    "PerPkg": "1",
     "ScaleUnit": "1MB/s"
   },
   {
@@ -317,7 +311,6 @@
     "BriefDescription": "Estimated combined memory bandwidth.",
     "MetricExpr": "(umc_cas_cmd.all * 64) / 1e6 / duration_time",
     "MetricGroup": "memory_controller",
-    "PerPkg": "1",
     "ScaleUnit": "1MB/s"
   },
   {
@@ -325,7 +318,6 @@
     "BriefDescription": "Memory controller ACTIVATE command rate.",
     "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
     "MetricGroup": "memory_controller",
-    "PerPkg": "1",
     "ScaleUnit": "1per_memclk"
   },
   {
@@ -333,7 +325,6 @@
     "BriefDescription": "Memory controller PRECHARGE command rate.",
     "MetricExpr": "d_ratio(umc_pchg_cmd.all * 1000, umc_mem_clk)",
     "MetricGroup": "memory_controller",
-    "PerPkg": "1",
     "ScaleUnit": "1per_memclk"
   },
   {
-- 
2.53.0


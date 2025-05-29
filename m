Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ABB224B1B;
	Thu, 29 May 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522144; cv=fail; b=I52JgtF4/Fi7SxGTEzAdn4hCZtEwmPFMB1bDZ0vl3Q4oNzqchaiFRc4BA3aKnmU2lCrjhh2J4eHv+ENyEtkHfxBNcL9hmgpwMNGkavwbyDoMkf6XmL0m7f6JAlENZl0RnqyxYUFKqidXt1M/Sp4E5QUwONRO5Or6wuJapOOjgxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522144; c=relaxed/simple;
	bh=8m2dYGOUHlHtbHXKM20enZzd9/uxNZ9OvkWKr7rzQ4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMeX2HLw7YIVyLLWdAHcZ6aygg9llmkCVXFHeuYOsa/BNMDpe5mwKn1IB/tcMlbIImS0TJWSxoQwyay44S03yOxzckGSWFdZBb8qZXJUSQK2ggD3mpFdDgU5T2R+Oc48DS0ZDtqJA2NjTl+IJi6Ao6uKHjnEPvo+/iFNpFWls4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wZcfiB2k; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wZcfiB2k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bV8Q3qBEEnE/3OuXdmvLdEA0xI2/3O7Lt6wtA/J4Ipb//fwrJgud9JSAiz1xRS+q1pQc4WnoOBsrDlXN+UKC18G3ONRiMqbZKOiwbe2cYOLNbrIaT5fYoSmWxaUv6JFM616/rBAi/C2BgZ++5tse6+empe45T8uwz3KXBTjxqCMJtdBufC2Eexk1r18Xkj2mNkM9IttXLApd/37A6KWVlhm9LVQtOEdYQImSnWrrN26AoIcf78q5ESQgXaDoKQeYIgFNUuVeQIjDcGsDM4nlgBB8J0pNcBm3Mypd4YJr1TcmKfkUMTx5A937+fifyIk1H5rjem97c/8Nj0zyocvx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFAlZ/WkEXSqnCgSK1fYbKV/nr0l0cmpVFzf2Zq1NvI=;
 b=sRPh9Eu8T3JtvQc3wsl+ralliECkQRMXs6HW14LauWBJuF968gLskrbu/bhmRxBek4yOdSs916tpAoStRpMk2D4v9bi0Gcu8fL3Yqj/4KermiWOcgufI7966rQ0zCUq8y7yniIQ/O+1h8WVOXwmB/x+g5lK7dg/z6nAReMraK4kIoym9a3Je5lQ3WbNNmyXOy5GTGLPV/1wFwNPCCcypqGPHLrHGQP9Sn+sf9Zi/UYVACOqD9iMFUWKPeYmKSRJuOEO0Axbdq7zPD+oTPqtakt/uw/u386glrZdD9GasRKcNXHh7yK1NHrGFXcj+VjgpaaBcFgGb0eBvzIEblTjbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFAlZ/WkEXSqnCgSK1fYbKV/nr0l0cmpVFzf2Zq1NvI=;
 b=wZcfiB2k9wXrrFN/8W06+zSJGvtDiBEnlpQMuMrojwlGrFRnKt0HC16Z07kBrw3Uu/kFN9kMWYL7Y0bBlIMxwL478oWbOl4QhVoBvPZJzOTkzAWbzhA0eewk7M6Y1kuGo3PwBoUrIbFTnpnAWZMeenI8qoutd0Twm0HCfJ/IzfM=
Received: from SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 12:35:35 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::27) by SJ0PR05CA0102.outlook.office365.com
 (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.17 via Frontend Transport; Thu,
 29 May 2025 12:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 12:35:34 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 07:35:29 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Ingo Molnar <mingo@redhat.com>,
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
	"Leo Yan" <leo.yan@arm.com>, Joe Mario <jmario@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 4/4] perf doc amd: Update perf-amd-ibs man page
Date: Thu, 29 May 2025 12:34:56 +0000
Message-ID: <20250529123456.1801-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529123456.1801-1-ravi.bangoria@amd.com>
References: <20250529123456.1801-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: fb74c1a6-248b-46ae-d71f-08dd9ead4f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pypg4iiqTONLh3efz2iWa88TggrlsBdlsvdZuVAVvFvzGLi9OI8LFU1ik+BA?=
 =?us-ascii?Q?DQwYW2LRbbNoHcqt1r9BfiTiOwl99KjyLJqhFnU2U4nmaM3lvB52efWqdkbL?=
 =?us-ascii?Q?JpCuOaSclwm+ZWF2+iMejND3vYmEDZm/CkBNdGE7lozCvMLkNvXTPrqFVG2d?=
 =?us-ascii?Q?+4UbbfL/fMjQM+0WLf4iTRw351HnrPw6HHAcTMFczz/7SmR0rIKdE7j6QMfw?=
 =?us-ascii?Q?emD60zJp3/AvIvvZ0zkIjBgO4FzMD7BrOHmcuiU8mM/ovX0x39gRykw/GkI9?=
 =?us-ascii?Q?wpMPo5k+4k2xsd06AWjE8GtNoVMxgtRvDYM/vZfGYR1t2B3iXRxv+AEyVpfZ?=
 =?us-ascii?Q?KzwNTS7HJnQVnquhhhETZfBAZ3eYr/YRbs2TTgYnUQZjG8ewgOiSRieFMSUY?=
 =?us-ascii?Q?+zLaodUV1DPIxf2n7/mt9wj/m+R1MO3gxiJF0+GpM2g76VkETPj6K/vqXA1/?=
 =?us-ascii?Q?NdVot+b2Md8T1thw05VIY1pCCt5VJTxKFdUSGZ84hTRcpq8ULpY7FP/AYBNI?=
 =?us-ascii?Q?zpQlRb7YcixnaN4XvxQNVFV5l7NUcr3vb1BaDTMn5zflEkWBzZeK04awSPvB?=
 =?us-ascii?Q?YV6a9bwAm/JFuTdeBLYmd1Gpa5o5p8lsl2zgVIl3v/m1s+vqwAgIaxACFtzJ?=
 =?us-ascii?Q?9BlJ6BB8/mlFJigGyQe6N4X1Y87HJtkS+0JAnL5bk1zvlliOJJv2d3O/8hig?=
 =?us-ascii?Q?XrsH94pez5ApDjT4DTXXM/1LA6T8C7dsC1TRhlwABDkB25+euIuoHDYThTJ/?=
 =?us-ascii?Q?yI2mWeX0Ufc/2HHfJMeewPMz/+Px9tdBNHNCniVZlfFbIEsZVr6RildZEads?=
 =?us-ascii?Q?L7+U7L4c7lppgMctdVAko+mVwrqFuanltX+2FcVrWf/JX73p7Ufo4XIlQ1OF?=
 =?us-ascii?Q?l0JlMgf7mt+3BVUEcLubxvfJ3YocDDsZ5f+/Q6YAGE9PnUBmIRXxegvHXJ9a?=
 =?us-ascii?Q?8KDSfvl8ajy7o6ny/KT0+xhxZXttBNrP5ywU+Yf5QoFSSAYAFOkkEUJupN05?=
 =?us-ascii?Q?iX4y77gbbz2JyQX8a+l9gq4V8DIVcyeDzyIuq+rKli6dJ5YUPTkqCaDWSrr/?=
 =?us-ascii?Q?JLc/Wq+RSfBPpQehBuIbKDpyF/xBscEpH1mMXkvbSpY6+dH4Cix+HhyB5gSo?=
 =?us-ascii?Q?3MHD2hyQwsUC3gqLzvaH3TF74s/mUDj7eAnIf0vGAF8wRu0Baz82T/IJHr68?=
 =?us-ascii?Q?Uf7+l+nataGPt2kWW3sd4pvYcdiq3HzelB2WoEPmauteR+hPeYjSQLZsa2LT?=
 =?us-ascii?Q?yAu5yjrrKPiHr5ukzij1GUJAnclplvtYdcIzAvodPRF+z/uavrmH7vOLgTb/?=
 =?us-ascii?Q?s6WKXrxyw7pPx78TtpE8gFIg+4q4lFHwp6NJCdT7vpzTsSO6JEtdrxS4RP9Z?=
 =?us-ascii?Q?OF09pUQ4dY2+2uFN2S8bAxszeNBaka1aeZ1AOjhO3rSfqqCDekNp4G46q7AT?=
 =?us-ascii?Q?u4q59qvzGUnR8BXKH360FmMm9ht45dBAQ5jJa5vKwf/qvMEPtpqjb4xdUH2K?=
 =?us-ascii?Q?H5Kwzs1fSPaglhnXiWr9F+kGu5w6v+d6gG3R+T9tUAwGbrnoHmLObSFmEA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:35:34.8355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb74c1a6-248b-46ae-d71f-08dd9ead4f13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

o Document software filtering capabilities provided by IBS kernel
  driver.
o After recent perf-mem hist updates [1], the perf-mem example command
  in the perf-amd-ibs man page renders output differently. Unfortunately,
  there is no way to get the same aggregated output now. So use alternate
  command that can aggregate and show data at the command level.

[1]: https://lore.kernel.org/r/20250430205548.789750-1-namhyung@kernel.org

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-amd-ibs.txt | 72 +++++++++++++++++------
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Documentation/perf-amd-ibs.txt
index 55f80beae037..a543a68e3c94 100644
--- a/tools/perf/Documentation/perf-amd-ibs.txt
+++ b/tools/perf/Documentation/perf-amd-ibs.txt
@@ -33,9 +33,6 @@ if IBS is supported by the hardware and kernel.
 IBS Op PMU supports two events: cycles and micro ops. IBS Fetch PMU supports
 one event: fetch ops.
 
-IBS PMUs do not have user/kernel filtering capability and thus it requires
-CAP_SYS_ADMIN or CAP_PERFMON privilege.
-
 IBS VS. REGULAR CORE PMU
 ------------------------
 
@@ -160,6 +157,38 @@ System-wide profile, fetch ops event, sampling period: 100000, Random enable
 
 etc.
 
+IBS SW FILTERING
+----------------
+
+IBS PMU driver provides few additional software filtering capabilities. When
+supported, kernel exposes config format through the following files:
+
+  /sys/bus/event_source/devices/ibs_fetch/format/swfilt
+  /sys/bus/event_source/devices/ibs_op/format/swfilt
+
+1. Privilege (user/kernel) filtering. IBS PMUs do not support privilege
+filtering in hardware so IBS driver supports it as a software filter.
+
+  ibs_op/swfilt=1/u               --> Only usermode samples
+  ibs_op/swfilt=1/k               --> Only kernelmode samples
+  ibs_fetch/swfilt=1/u            --> Only usermode samples
+  ibs_fetch/swfilt=1/k            --> Only kernelmode samples
+
+  Privilege filtering is always available when "swfilt" is supported.
+  So, kernel does not expose any separate PMU capability for this.
+
+2. Load/Store sampling. IBS OP PMU do not support load/store filtering in
+hardware, so IBS driver supports it as a software filter.
+
+  ibs_op/swfilt=1,ldop=1/         --> Only load samples
+  ibs_op/swfilt=1,stop=1/         --> Only store samples
+  ibs_op/swfilt=1,ldop=1,stop=1/  --> Load OR store samples
+
+  Kernel creates following PMU capability file when load/store software
+  filtering is supported:
+
+  /sys/bus/event_source/devices/ibs_op/caps/swfilt_ldst
+
 PERF MEM AND PERF C2C
 ---------------------
 
@@ -173,21 +202,28 @@ Below is a simple example of the perf mem tool.
 A normal perf mem report output will provide detailed memory access profile.
 However, it can also be aggregated based on output fields. For example:
 
-	# perf mem report -F mem,sample,snoop
-	Samples: 3M of event 'ibs_op//', Event count (approx.): 23524876
-	Memory access                                 Samples  Snoop
-	N/A                                           1903343  N/A
-	L1 hit                                        1056754  N/A
-	L2 hit                                          75231  N/A
-	L3 hit                                           9496  HitM
-	L3 hit                                           2270  N/A
-	RAM hit                                          8710  N/A
-	Remote node, same socket RAM hit                 3241  N/A
-	Remote core, same node Any cache hit             1572  HitM
-	Remote core, same node Any cache hit              514  N/A
-	Remote node, same socket Any cache hit           1216  HitM
-	Remote node, same socket Any cache hit            350  N/A
-	Uncached hit                                       18  N/A
+	# perf mem report -s comm,mem -H --stdio
+	     Overhead       Samples  Command / Memory access
+	  .........................  ..........................................
+	    66.46%        471728     cc1
+	       34.70%          1393     RAM hit
+	       10.42%           370     Remote node, same socket RAM hit
+		6.73%         10239     L2 hit
+		5.84%        293953     N/A
+		3.26%        163803     L1 hit
+		3.16%          1796     L3 hit
+		1.29%            95     Remote core, same node Any cache hit
+		1.06%            73     Remote node, same socket Any cache hit
+		0.00%             6     Uncached hit
+	     9.45%         44994     sh
+		2.60%           131     RAM hit
+		2.21%           219     Remote core, same node Any cache hit
+		1.89%           190     Remote node, same socket Any cache hit
+		1.02%            52     Remote node, same socket RAM hit
+		0.72%           785     L2 hit
+		0.60%         30149     N/A
+		0.27%         13340     L1 hit
+             ...
 
 Please refer to their man page for more detail.
 
-- 
2.43.0


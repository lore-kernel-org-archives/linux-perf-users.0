Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8099B4457B8;
	Mon, 12 Oct 2026 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791752; cv=fail; b=bgD7MWnRPRYmiNON0vMlF5JnBOsONkAtqU9VM3ojxKpS/qh1gS69O3X0hbMSmys7AhFolQs/KkpHeVPLJJ1uUrTAINIP1LVN23pv7w1B7p63VvVva4BPmPoZ7nRVBGc6bpsoQObGOqnBsYASDBA39qPM6dmRp1PAjn/P5MYU16c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791752; c=relaxed/simple;
	bh=UHE1uVB3bTMZVP79nX8LMIaJt1UF64+BcjzHLvCtbhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tk94njcwns0DzfmDhm/brW9rSP0T6xU7IDTwJYccNZUYlzqjysF5rpqUrFQmOj1P6DWhQcmT3ejDrm9BjwHxdZ40aYMoCh+UT56kxAa3xKnfu172XpiTRF6aEgx/ItoccYTmxglIvduDlX2j8bbBRAvLEPKPEnoJnLwUz3jEhGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JQ09VXL2; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JQ09VXL2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INUVtsS7O7KRefAX85WOYomW7LgvY4glYN0UlA7UY9yL8pJyF93TZn8mFHaxOdx3n4SoA6dnT+eMZas/jqYMUlagdmb+A9MzAFNHjNH8GjF+QqPPJ6UwhPiPvYga1x11l0twFZvM7opYjx2R2oNcCtYv3r75Makng90SToNabec7kQlYR5YlqWQI9/0LJZotF7KpYJyhYC9ViQl6wlnhR1row3KM1XeHvmODs4/HKJ+4+aRCx+9kYEATSPwkO3z4IdXmT5ySmB/vp0kLLfXuABlk2TkT966hUn+IxdXQmO1SFQS/tXubWLFUlvVoKKBtrGAzON0SqK1PuLVZmkeTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehVIziCtPzjpqKVnEVHCYuGMTcfpiCnAOtkplBjdvco=;
 b=ZHYt/EtwcjbkA6aeLbNkkLdE1jg+UyRJWNubLIt43dFBTyNnrtNU1LX2iePhCoD9TLFwRfqWHJqXKDgKim7SdSYoNH/xAB4Vgkvz8lo7skJy8lWkUWggOIdjq79Vq85Ak5UhMIRtQH3BUSvZuFNveVcPALivDuciW0QfeLVeFzXQCmHFmIXvypMYrzKuKG2LvWDkMeOse0VYn8IvPoLyLOG83qLg/LqlaBo65Gz+yDOlImdpht8e2Kz8+1mqU4nSLc+aTejQT/D1fH86RLorw/2ZKFrHCGHFfjHe8m2Jy4aHCH6U4gzc+tpbmwwBsH4TUar8PKEt+8v9BOBnALASbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehVIziCtPzjpqKVnEVHCYuGMTcfpiCnAOtkplBjdvco=;
 b=JQ09VXL2Bai4ZgErrW0XaAvWUZpE7LneVwbwFxYKBAhDa5xoVfPEvC+LjUfHbpXKMkEJlDSvhZAzFQ331SWQBQpN9df4p5jqRLeI1t4/LRGqWkhUs2DCzik/lWKkTpuYgQDd3i1yiM+sTF1IGimHetzxgJgkSCvL1Cg12WxGLxU=
Received: from BN9PR03CA0580.namprd03.prod.outlook.com (2603:10b6:408:10d::15)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.21; Mon, 12 Oct 2026 07:55:37 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::13) by BN9PR03CA0580.outlook.office365.com
 (2603:10b6:408:10d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 07:55:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 07:55:36 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 02:55:25 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 2/3] perf vendor events amd: Add Zen 6 data fabric metrics
Date: Mon, 12 Oct 2026 13:23:31 +0530
Message-ID: <6f975087e56e652ae49e8a410ad31b3e76a34b9a.1791791463.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cf92bc-0c13-49bc-8e75-08df28363382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|6133799003|261009223027099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	cI5Eyr1Xvl26QiZR7HemW/r6ocw9D9/YvXeCoBgee0yyLMn09aoX98CbNJw6sQUly9ldjHrvPguerUjewFLIm/sTZik3Rdx5c4qCEGmONzl/BqQiIPHhSAbN+G8lEwzwwbdNeG0K86oZdhMBxCdlmLUR793/GKO4Kb/BxkKuNkHNRIeqcyi/HLHxMvGqteBuAwaGgUew+CqZIyeUvDPoTzena5sIdeA8KvORMBYkgZtOh1NrTCifXByuc9Nz9/MF+6IIxUm0cN7RJYKb8AnL887WcIMYpU0oKnMqGyeMukAkBvkoHo0Qu4ISeFGtMd3s9odGjDwsrcirZhRzXLJDBPbc5M8cMNGdhod5uDq7netnjK0mQ3w7FpaFlbQ0oSjsUSzv5svTVhL+9c+1RhIm+f1w0rchTLX1fm+KU35j6p1QbbscvDAMsi7hETXGsTZJ3WwscS5GYZKZflXct1d1+yW8UKs/iYvVqSH/FMl+aR2KE7s9U1r5DvDke/OwQpx+eERU1QQqL80gDcf9OsGVMOYeZqxdxUwo2DELt7M1s8MQ9g2OXV5ZB+bW+4D/N0nEuwrIq8AbWjW/bGPnVZ2PmWNSNCoRtCk1XzbHxlyBibwHPlMwWJjp1muUmgiEQPDtZCGHQOWv30cC1o/fXy0vdQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(261009223027099003)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0DieL2+vHYbD6wk3dn1NWFZTGINsIENfjXaR61Ivu0HpPSNdr1+qIr7M6aR0Bg/9jls6LE6bovTGc7bGJLCTjdWooweuRllnJx/cuo5dgNrELLfURkv6anZOvaQuuBmJtj0Bpytb9MCOnYBUijXXzj5QqkoFcZJTfg2dR2n1LS/d3fvIvie26zDCxJjXmDF2/LsT3eCmmzRcy+m+zwGl4l2aiuJmC35ebfFZyH3Lnff8Xzzdo251ARo+sqNpoE7/Emi/wDm33/Lnu+YF89DTW0lDsdvEhfiIKpBs8RUUYoQMNsWq+P7VUV3NYuT6iT6dhKOUlUuCLotcLK2c0LveYSQ57Von+3bXKgq5VRG49PcLNnJsSz9SOd6F1VtgBSwQgV/bk2OLLUW1KooVJoqNbXUEkHgu4gMBagIUNTi3gGBFpXyMP/26s3KCob26vvtL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:55:36.7000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cf92bc-0c13-49bc-8e75-08df28363382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795

Add Zen 6 data fabric metrics sourced from Table 193 in Section 9.1
titled "Guidance for Common DF Performance Statistics" of the Processor
Programming Reference (PPR) for AMD Family 1Ah Model 51h Revision B0
processors, available at the link below.

The metrics are primarily meant to monitor data bandwidth at various
links and interfaces within the Data Fabric.

Link: https://bugzilla.kernel.org/attachment.cgi?id=311021
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen6/recommended.json         | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
index 2849a8c159f6..853700a3a0de 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
@@ -335,5 +335,103 @@
     "MetricGroup": "memory_controller",
     "PerPkg": "1",
     "ScaleUnit": "1per_memclk"
+  },
+  {
+    "MetricName": "df_fclk",
+    "BriefDescription": "Average Fabric Clock (FCLK) frequency.",
+    "MetricExpr": "pie_general.fclk / aggr_nr(pie_general.fclk) / duration_time / 1e9",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "1GHz"
+  },
+  {
+    "MetricName": "df_dram_data_bw.rd_local",
+    "BriefDescription": "Local DRAM read data bandwidth.",
+    "MetricExpr": "(data_beats_cs_0.rd_local + data_beats_cs_1.rd_local + data_beats_cs_2.rd_local + data_beats_cs_3.rd_local + data_beats_cs_4.rd_local + data_beats_cs_5.rd_local + data_beats_cs_6.rd_local + data_beats_cs_7.rd_local + data_beats_cs_8.rd_local + data_beats_cs_9.rd_local + data_beats_cs_10.rd_local + data_beats_cs_11.rd_local + data_beats_cs_12.rd_local + data_beats_cs_13.rd_local + data_beats_cs_14.rd_local + data_beats_cs_15.rd_local) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "df_dram_data_bw.wr_local",
+    "BriefDescription": "Local DRAM write data bandwidth.",
+    "MetricExpr": "(data_beats_cs_0.wr_local + data_beats_cs_1.wr_local + data_beats_cs_2.wr_local + data_beats_cs_3.wr_local + data_beats_cs_4.wr_local + data_beats_cs_5.wr_local + data_beats_cs_6.wr_local + data_beats_cs_7.wr_local + data_beats_cs_8.wr_local + data_beats_cs_9.wr_local + data_beats_cs_10.wr_local + data_beats_cs_11.wr_local + data_beats_cs_12.wr_local + data_beats_cs_13.wr_local + data_beats_cs_14.wr_local + data_beats_cs_15.wr_local) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "df_dram_data_bw.rd_remote",
+    "BriefDescription": "Remote DRAM read data bandwidth.",
+    "MetricExpr": "(data_beats_cs_0.rd_remote + data_beats_cs_1.rd_remote + data_beats_cs_2.rd_remote + data_beats_cs_3.rd_remote + data_beats_cs_4.rd_remote + data_beats_cs_5.rd_remote + data_beats_cs_6.rd_remote + data_beats_cs_7.rd_remote + data_beats_cs_8.rd_remote + data_beats_cs_9.rd_remote + data_beats_cs_10.rd_remote + data_beats_cs_11.rd_remote + data_beats_cs_12.rd_remote + data_beats_cs_13.rd_remote + data_beats_cs_14.rd_remote + data_beats_cs_15.rd_remote) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "df_dram_data_bw.wr_remote",
+    "BriefDescription": "Remote DRAM write data bandwidth.",
+    "MetricExpr": "(data_beats_cs_0.wr_remote + data_beats_cs_1.wr_remote + data_beats_cs_2.wr_remote + data_beats_cs_3.wr_remote + data_beats_cs_4.wr_remote + data_beats_cs_5.wr_remote + data_beats_cs_6.wr_remote + data_beats_cs_7.wr_remote + data_beats_cs_8.wr_remote + data_beats_cs_9.wr_remote + data_beats_cs_10.wr_remote + data_beats_cs_11.wr_remote + data_beats_cs_12.wr_remote + data_beats_cs_13.wr_remote + data_beats_cs_14.wr_remote + data_beats_cs_15.wr_remote) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "df_cpu_data_bw.in_local",
+    "BriefDescription": "Local CPU inbound data bandwidth.",
+    "MetricExpr": "(data_beats_ccm_0.rd_local + data_beats_ccm_1.rd_local + data_beats_ccm_2.rd_local + data_beats_ccm_3.rd_local + data_beats_ccm_4.rd_local + data_beats_ccm_5.rd_local + data_beats_ccm_6.rd_local + data_beats_ccm_7.rd_local + data_beats_ccm_8.rd_local + data_beats_ccm_9.rd_local + data_beats_ccm_10.rd_local + data_beats_ccm_11.rd_local + data_beats_ccm_12.rd_local + data_beats_ccm_13.rd_local + data_beats_ccm_14.rd_local + data_beats_ccm_15.rd_local) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "3.2e-5MB/s"
+  },
+  {
+    "MetricName": "df_cpu_data_bw.out_local",
+    "BriefDescription": "Local CPU outbound data bandwidth.",
+    "MetricExpr": "(data_beats_ccm_0.wr_local + data_beats_ccm_1.wr_local + data_beats_ccm_2.wr_local + data_beats_ccm_3.wr_local + data_beats_ccm_4.wr_local + data_beats_ccm_5.wr_local + data_beats_ccm_6.wr_local + data_beats_ccm_7.wr_local + data_beats_ccm_8.wr_local + data_beats_ccm_9.wr_local + data_beats_ccm_10.wr_local + data_beats_ccm_11.wr_local + data_beats_ccm_12.wr_local + data_beats_ccm_13.wr_local + data_beats_ccm_14.wr_local + data_beats_ccm_15.wr_local) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "df_cpu_data_bw.in_remote",
+    "BriefDescription": "Remote CPU inbound data bandwidth.",
+    "MetricExpr": "(data_beats_ccm_0.rd_remote + data_beats_ccm_1.rd_remote + data_beats_ccm_2.rd_remote + data_beats_ccm_3.rd_remote + data_beats_ccm_4.rd_remote + data_beats_ccm_5.rd_remote + data_beats_ccm_6.rd_remote + data_beats_ccm_7.rd_remote + data_beats_ccm_8.rd_remote + data_beats_ccm_9.rd_remote + data_beats_ccm_10.rd_remote + data_beats_ccm_11.rd_remote + data_beats_ccm_12.rd_remote + data_beats_ccm_13.rd_remote + data_beats_ccm_14.rd_remote + data_beats_ccm_15.rd_remote) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "3.2e-5MB/s"
+  },
+  {
+    "MetricName": "df_cpu_data_bw.out_remote",
+    "BriefDescription": "Remote CPU outbound data bandwidth.",
+    "MetricExpr": "(data_beats_ccm_0.wr_remote + data_beats_ccm_1.wr_remote + data_beats_ccm_2.wr_remote + data_beats_ccm_3.wr_remote + data_beats_ccm_4.wr_remote + data_beats_ccm_5.wr_remote + data_beats_ccm_6.wr_remote + data_beats_ccm_7.wr_remote + data_beats_ccm_8.wr_remote + data_beats_ccm_9.wr_remote + data_beats_ccm_10.wr_remote + data_beats_ccm_11.wr_remote + data_beats_ccm_12.wr_remote + data_beats_ccm_13.wr_remote + data_beats_ccm_14.wr_remote + data_beats_ccm_15.wr_remote) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "df_io_data_bw.rd_local",
+    "BriefDescription": "Local I/O read data bandwidth.",
+    "MetricExpr": "(data_beats_iom_0.rd_local + data_beats_iom_1.rd_local + data_beats_iom_2.rd_local + data_beats_iom_3.rd_local) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "df_io_data_bw.wr_local",
+    "BriefDescription": "Local I/O write data bandwidth.",
+    "MetricExpr": "(data_beats_iom_0.wr_local + data_beats_iom_1.wr_local + data_beats_iom_2.wr_local + data_beats_iom_3.wr_local) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "df_io_data_bw.rd_remote",
+    "BriefDescription": "Remote I/O read data bandwidth.",
+    "MetricExpr": "(data_beats_iom_0.rd_remote + data_beats_iom_1.rd_remote + data_beats_iom_2.rd_remote + data_beats_iom_3.rd_remote) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "df_io_data_bw.wr_remote",
+    "BriefDescription": "Remote I/O write data bandwidth.",
+    "MetricExpr": "(data_beats_iom_0.wr_remote + data_beats_iom_1.wr_remote + data_beats_iom_2.wr_remote + data_beats_iom_3.wr_remote) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "df_link_data_bw.out_local",
+    "BriefDescription": "Local inter-socket outbound data bandwidth.",
+    "MetricExpr": "(data_beats_link_0.out_local + data_beats_link_1.out_local + data_beats_link_2.out_local) / duration_time",
+    "MetricGroup": "data_fabric",
+    "ScaleUnit": "6.4e-5MB/s"
   }
 ]
-- 
2.53.0


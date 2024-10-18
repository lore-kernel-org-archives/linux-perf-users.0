Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62899190482;
	Fri, 18 Oct 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243914; cv=fail; b=iriXdCwUXIZx4G3cWGjzJJLL2IlaEbAW1xbiuKNJ9vLTA6zLXgDrys1kcRafkZhKQu3yW+MiUuCbEzJYvO1n9X0xaEku2JxgW681ufaPMNjhbtNzWOjLNcTzNT2eiJI267Mg2ZZPLwRxdiC9EanLuzXBolhFDT6DXYahYzR2Pzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243914; c=relaxed/simple;
	bh=HQfe3kiNOkhZZ5Sv9j/jhXIE3tUBLrpSBNY/ne075pY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boe3MSU4gKC1UsLDJUkMl/pu7Vx3vYI7yxQFhCZj11DWaf+nJUghm7Nec8L9Wafr3VV+kNQdF5AkRAUCPdLN7a4W8UvxvFF8DDy3qjY/+sN0hqPbdbLQecPWuCaZMjM2d8XywNiHJIgtxXRBFWa45JIOYg0JDxosg11/wBHv4XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kTbY1ARb; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kTbY1ARb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISF0mLf4eBTQtw+/A+E8dGCmmH9WMcUHRiGmY+WjBkYRuDsLpFblqRj4zzk08e+QM5tw0y7riea4FhuD20L+bc3VqI7jmP2zruY0UA4JY/oK+MNj9t5xf51mKNoFF7Y6NZPTNH43HrOBqTdCyA7Mkxpqu4N7tYAXpd3rLAhvH1nYEYl41EKHHXhOC1sM1hqNM2Tb/OR54sfcZuQlgc2uwH+8aI6KXlWrWe16aN6zZJ69eI4XMpRWetYkL+cGiaWO5LXVSTJ6EXYs4RSvXie/BvwEzPnh/aR88UWLtz9Kvw12YfncqNchk4PNWqf7DKtWy8cnteJhnsFJdpffHsWVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoAtaf3hTLa0p2qW1KfJN3fgHt+Lxyav0NFyDUWEsF0=;
 b=LIgJcq6CTRmhUwaFU5Ptf89gMGxL3KkIBP5GwBU2mk/8/MoC2wZa5HJxqNNvWlHWb8KXKokCPXOad+jONgE2Drq7cepyAQ79tJM7djUsRPNwM9K94+5AgA6HDK2vZve89JvarBbvP6Y5AbQPAMKxnm24EJLS2vPmePDlQWrAQ/vtItMwfXTfC9xGvcwjYA7D9ZK9PiQQU/PgzjJyhSRPV6yTPOCuufSWFs0JGwS8lwvldNDb3SiwaMDya/7GCQvTC2Uxqpy3UhtjZ+OpOWQZTMrY8KxPVdw+giFhzb7kl7ETV0+IbDn4NuKLz5QQCUcIG0HYMVzpfSDPKsQIdkoJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoAtaf3hTLa0p2qW1KfJN3fgHt+Lxyav0NFyDUWEsF0=;
 b=kTbY1ARbVXR/n3/FSMtc9kgy5SzT/ec5qnXQGqjCRryMizR8fRJTsV3R2KuzckHdATmmLBVkt5L1fJ5KMRKwOjXmGFBw5xcsUZIol74nGI1BWQyz8ryNtAA5GJCJuh7jD8WDsmdX83JRTU9oSL8QYNKqosp2RhlVuy3bryZkMKk=
Received: from PH8PR15CA0005.namprd15.prod.outlook.com (2603:10b6:510:2d2::12)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 09:31:43 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::2d) by PH8PR15CA0005.outlook.office365.com
 (2603:10b6:510:2d2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 09:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 09:31:41 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 04:31:36 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 1/3] perf vendor events amd: Add Zen 5 data fabric events
Date: Fri, 18 Oct 2024 15:01:03 +0530
Message-ID: <198049e27366f3980e4991b95cec5eaac6d31d75.1729242778.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729242778.git.sandipan.das@amd.com>
References: <cover.1729242778.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: bee9779f-235f-4cd8-2668-08dcef57acbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owZ9d1LhYpNsP80GNWWW707OKuEnHgRUbnGZ5Smj3Tzvuf17C5jsK2uYJPKw?=
 =?us-ascii?Q?xTeK8T/XlTNiwJ8goRMRNA/rHnyhD35UujbmYvMbZWYXKWCF5+SM8PXtTdvt?=
 =?us-ascii?Q?Mqpxwy2+IK+tupx29Zf1J6KTKIuwtdkrW+25iPWmwyUCnlxvfqzO5MqHMRQx?=
 =?us-ascii?Q?ya2M0pf7xEYHUUSJkS4fD19kUShD4NN2GchKu1swx/Sn8Rb5zDsW68mcYs9W?=
 =?us-ascii?Q?+/BBbhQQwa30/ISjI9ntG2hsseU5BvJpKZnKiOms+8+KtXguo6t/2BxUY5/f?=
 =?us-ascii?Q?6mkcI9KgMX5alUnMsLgeLgsRG/fJrmJ1ZEAPBrezRmp76p3Yibz/i+LnAAgU?=
 =?us-ascii?Q?0b969L2YOfthIGMfFAcJdMk1rI6viV8nhTtHT5uYEpxmPuzAciyr3L+gvyJf?=
 =?us-ascii?Q?U566HiAXtmLzwyYaA1L+JcAjzexA7fjShR/xtFrntskPXKjnoOfEffZEReUa?=
 =?us-ascii?Q?MJHtQ/c734Hh0pS3v699cf4JXi/cWFkkefXsPMAvyOcRiC2qsQx3Qbnurv0e?=
 =?us-ascii?Q?GA/aP3dwsG4ITQ0/s+jU/A5IYUgHpH8ZeqKBc9f2lwtAHNXNp434UALhdHB4?=
 =?us-ascii?Q?CkVn9yqZg1XIWlzuOZ7W2Ra8+BXs4NMYWwjiqgGp1A+j1A725YgNXjbCwRAE?=
 =?us-ascii?Q?Ot8onwpxhbSqtk80xHFHmAV6Tu4rOyt0L/+Kf7vx9HeHm1iPDQkgskmDKKoE?=
 =?us-ascii?Q?5iwvealItSkt1mwm4Rg+QkQsmUcyIefyEAxxrcuRL9FmN/FcKeYBmVtblLD1?=
 =?us-ascii?Q?W/TYILsJqA2YkkY/KVqpu1SudapxdBYZTyRkibrGlTw95jeiS+nRRrbZi9aU?=
 =?us-ascii?Q?i6d6JeG8bm/jvsDVlJrHjjgR/EuZBtrG61eG1F7oN5MgrdQJEBjDi5tEVd7u?=
 =?us-ascii?Q?Uh5hswMMFW3m0V5nrlAIGp90a8ckFhzqV03UtORIxV4PSaA36bpED/xp7LJv?=
 =?us-ascii?Q?krHGcDiQxnGsKksK4gup2ULW1vUsmUy1t5BXX/OEwV6Rr5Oy0YGPAqxFg0di?=
 =?us-ascii?Q?BHnADmhkGLee3wmOmK79MAVJ+t94r0jU9ragdL43IGCTPgd/z21gMRfLjkts?=
 =?us-ascii?Q?sd1rnGqoI1x8ooZvsheY6n21GjErc7MrMg4+9dhUNWgY7zH6T29t7u5CyL2i?=
 =?us-ascii?Q?jvOhTZKZFb3ebsEJ21LG4b9Nh/0eBuiwY+zWOl7UpHZDo8KDty61tQhrgQBs?=
 =?us-ascii?Q?6vQZn7VIqhbNKVkY05qr4jJPLc24kmAjeK6Ec6jBv9XgIoplBUQRYxnwxMKf?=
 =?us-ascii?Q?aXlzOJ/wGHsVIWJyXkdzkqftp3n09fXIsIUFB20XGVbu2r4YvEqEfZRsGF2g?=
 =?us-ascii?Q?FNTPxgTsX2kyyGVY+jITitv1yMRHcjDLij/7iNgcwzVYydi3QtgCLBxXt8l6?=
 =?us-ascii?Q?St94Pl2elRFuBIiaK87U1ZQWKbr+hQMvmiCHKFBBU2QQpTGoiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:31:41.7097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee9779f-235f-4cd8-2668-08dcef57acbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394

Add data fabric events taken from Section 2.1.16.2 "Performance
Measurement" in the Processor Programming Reference (PPR) for AMD Family
1Ah Model 02h Revision C1 Processors document available at the link
below.

This constitutes events which capture the flow of data beats at various
links and interfaces in the data fabric.

Link: https://bugzilla.kernel.org/attachment.cgi?id=307010
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen5/data-fabric.json         | 1634 +++++++++++++++++
 1 file changed, 1634 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/data-fabric.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/data-fabric.json b/tools/perf/pmu-events/arch/x86/amdzen5/data-fabric.json
new file mode 100644
index 000000000000..fa06569d881d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/data-fabric.json
@@ -0,0 +1,1634 @@
+[
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_0",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 0.",
+    "EventCode": "0x1f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_1",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 1.",
+    "EventCode": "0x5f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_2",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 2.",
+    "EventCode": "0x9f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_3",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 3.",
+    "EventCode": "0xdf",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_4",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 4.",
+    "EventCode": "0x11f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_5",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 5.",
+    "EventCode": "0x15f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_6",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 6.",
+    "EventCode": "0x19f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_7",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 7.",
+    "EventCode": "0x1df",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_8",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 8.",
+    "EventCode": "0x21f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_9",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 9.",
+    "EventCode": "0x25f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_10",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 10.",
+    "EventCode": "0x29f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_read_data_beats_dram_11",
+    "PublicDescription": "Read data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 11.",
+    "EventCode": "0x2df",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_0",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 0.",
+    "EventCode": "0x1f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_1",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 1.",
+    "EventCode": "0x5f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_2",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 2.",
+    "EventCode": "0x9f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_3",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 3.",
+    "EventCode": "0xdf",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_4",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 4.",
+    "EventCode": "0x11f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_5",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 5.",
+    "EventCode": "0x15f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_6",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 6.",
+    "EventCode": "0x19f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_7",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 7.",
+    "EventCode": "0x1df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_8",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 8.",
+    "EventCode": "0x21f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_9",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 9.",
+    "EventCode": "0x25f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_10",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 10.",
+    "EventCode": "0x29f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_write_data_beats_dram_11",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local socket and DRAM Channel 11.",
+    "EventCode": "0x2df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_0",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 0.",
+    "EventCode": "0x1f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_1",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 1.",
+    "EventCode": "0x5f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_2",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 2.",
+    "EventCode": "0x9f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_3",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 3.",
+    "EventCode": "0xdf",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_4",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 4.",
+    "EventCode": "0x11f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_5",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 5.",
+    "EventCode": "0x15f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_6",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 6.",
+    "EventCode": "0x19f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_7",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 7.",
+    "EventCode": "0x1df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_8",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 8.",
+    "EventCode": "0x21f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_9",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 9.",
+    "EventCode": "0x25f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_10",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 10.",
+    "EventCode": "0x29f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_write_data_beats_dram_11",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between remote socket and DRAM Channel 11.",
+    "EventCode": "0x2df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_0",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 0.",
+    "EventCode": "0x1f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_1",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 1.",
+    "EventCode": "0x5f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_2",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 2.",
+    "EventCode": "0x9f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_3",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 3.",
+    "EventCode": "0xdf",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_4",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 4.",
+    "EventCode": "0x11f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_5",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 5.",
+    "EventCode": "0x15f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_6",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 6.",
+    "EventCode": "0x19f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_7",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 7.",
+    "EventCode": "0x1df",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_8",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 8.",
+    "EventCode": "0x21f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_9",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 9.",
+    "EventCode": "0x25f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_10",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 10.",
+    "EventCode": "0x29f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_write_data_beats_dram_11",
+    "PublicDescription": "Write data beats (64 bytes) for transactions between local or remote socket and DRAM Channel 11.",
+    "EventCode": "0x2df",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_data_beats_io_0",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local socket and IO Root Complex 0.",
+    "EventCode": "0x81f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_data_beats_io_1",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local socket and IO Root Complex 1.",
+    "EventCode": "0x85f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_data_beats_io_2",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local socket and IO Root Complex 2.",
+    "EventCode": "0x89f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_data_beats_io_3",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local socket and IO Root Complex 3.",
+    "EventCode": "0x8df",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_data_beats_io_4",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local socket and IO Root Complex 4.",
+    "EventCode": "0x91f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_data_beats_io_5",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local socket and IO Root Complex 5.",
+    "EventCode": "0x95f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_data_beats_io_6",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local socket and IO Root Complex 6.",
+    "EventCode": "0x99f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_read_data_beats_io_7",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local socket and IO Root Complex 7.",
+    "EventCode": "0x9df",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_data_beats_io_0",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local socket and IO Root Complex 0.",
+    "EventCode": "0x81f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_data_beats_io_1",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local socket and IO Root Complex 1.",
+    "EventCode": "0x85f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_data_beats_io_2",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local socket and IO Root Complex 2.",
+    "EventCode": "0x89f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_data_beats_io_3",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local socket and IO Root Complex 3.",
+    "EventCode": "0x8df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_data_beats_io_4",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local socket and IO Root Complex 4.",
+    "EventCode": "0x91f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_data_beats_io_5",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local socket and IO Root Complex 5.",
+    "EventCode": "0x95f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_data_beats_io_6",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local socket and IO Root Complex 6.",
+    "EventCode": "0x99f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_upstream_write_data_beats_io_7",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local socket and IO Root Complex 7.",
+    "EventCode": "0x9df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_data_beats_io_0",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between remote socket and IO Root Complex 0.",
+    "EventCode": "0x81f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_data_beats_io_1",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between remote socket and IO Root Complex 1.",
+    "EventCode": "0x85f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_data_beats_io_2",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between remote socket and IO Root Complex 2.",
+    "EventCode": "0x89f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_data_beats_io_3",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between remote socket and IO Root Complex 3.",
+    "EventCode": "0x8df",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_data_beats_io_4",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between remote socket and IO Root Complex 4.",
+    "EventCode": "0x91f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_data_beats_io_5",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between remote socket and IO Root Complex 5.",
+    "EventCode": "0x95f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_data_beats_io_6",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between remote socket and IO Root Complex 6.",
+    "EventCode": "0x99f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_read_data_beats_io_7",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between remote socket and IO Root Complex 7.",
+    "EventCode": "0x9df",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_data_beats_io_0",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between remote socket and IO Root Complex 0.",
+    "EventCode": "0x81f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_data_beats_io_1",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between remote socket and IO Root Complex 1.",
+    "EventCode": "0x85f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_data_beats_io_2",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between remote socket and IO Root Complex 2.",
+    "EventCode": "0x89f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_data_beats_io_3",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between remote socket and IO Root Complex 3.",
+    "EventCode": "0x8df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_data_beats_io_4",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between remote socket and IO Root Complex 4.",
+    "EventCode": "0x91f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_data_beats_io_5",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between remote socket and IO Root Complex 5.",
+    "EventCode": "0x95f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_data_beats_io_6",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between remote socket and IO Root Complex 6.",
+    "EventCode": "0x99f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_upstream_write_data_beats_io_7",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between remote socket and IO Root Complex 7.",
+    "EventCode": "0x9df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_read_data_beats_io_0",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 0.",
+    "EventCode": "0x81f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_read_data_beats_io_1",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 1.",
+    "EventCode": "0x85f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_read_data_beats_io_2",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 2.",
+    "EventCode": "0x89f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_read_data_beats_io_3",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 3.",
+    "EventCode": "0x8df",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_read_data_beats_io_4",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 4.",
+    "EventCode": "0x91f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_read_data_beats_io_5",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 5.",
+    "EventCode": "0x95f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_read_data_beats_io_6",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 6.",
+    "EventCode": "0x99f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_read_data_beats_io_7",
+    "PublicDescription": "Upstream DMA read data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 7.",
+    "EventCode": "0x9df",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_write_data_beats_io_0",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 0.",
+    "EventCode": "0x81f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_write_data_beats_io_1",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 1.",
+    "EventCode": "0x85f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_write_data_beats_io_2",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 2.",
+    "EventCode": "0x89f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_write_data_beats_io_3",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 3.",
+    "EventCode": "0x8df",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_write_data_beats_io_4",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 4.",
+    "EventCode": "0x91f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_write_data_beats_io_5",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 5.",
+    "EventCode": "0x95f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_write_data_beats_io_6",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 6.",
+    "EventCode": "0x99f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_upstream_write_data_beats_io_7",
+    "PublicDescription": "Upstream DMA write data beats (64 bytes) for transactions between local or remote socket and IO Root Complex 7.",
+    "EventCode": "0x9df",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_0",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 0.",
+    "EventCode": "0x41e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_1",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 1.",
+    "EventCode": "0x45e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_2",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 2.",
+    "EventCode": "0x49e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_3",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 3.",
+    "EventCode": "0x4de",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_4",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 4.",
+    "EventCode": "0x51e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_5",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 5.",
+    "EventCode": "0x55e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_6",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 6.",
+    "EventCode": "0x59e",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_7",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 7.",
+    "EventCode": "0x5de",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_8",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 8.",
+    "EventCode": "0x41f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_9",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 9.",
+    "EventCode": "0x45f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_10",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 10.",
+    "EventCode": "0x49f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_11",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 11.",
+    "EventCode": "0x4df",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_12",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 12.",
+    "EventCode": "0x51f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_13",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 13.",
+    "EventCode": "0x55f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_14",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 14.",
+    "EventCode": "0x59f",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_cfi_15",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local socket and Core-to-Fabric Interface 15.",
+    "EventCode": "0x5df",
+    "UMask": "0x7fe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_0",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 0.",
+    "EventCode": "0x41e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_1",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 1.",
+    "EventCode": "0x45e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_2",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 2.",
+    "EventCode": "0x49e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_3",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 3.",
+    "EventCode": "0x4de",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_4",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 4.",
+    "EventCode": "0x51e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_5",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 5.",
+    "EventCode": "0x55e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_6",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 6.",
+    "EventCode": "0x59e",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_7",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 7.",
+    "EventCode": "0x5de",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_8",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 8.",
+    "EventCode": "0x41f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_9",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 9.",
+    "EventCode": "0x45f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_10",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 10.",
+    "EventCode": "0x49f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_11",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 11.",
+    "EventCode": "0x4df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_12",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 12.",
+    "EventCode": "0x51f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_13",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 13.",
+    "EventCode": "0x55f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_14",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 14.",
+    "EventCode": "0x59f",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_cfi_15",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and Core-to-Fabric Interface 15.",
+    "EventCode": "0x5df",
+    "UMask": "0x7ff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_0",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 0.",
+    "EventCode": "0x41e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_1",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 1.",
+    "EventCode": "0x45e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_2",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 2.",
+    "EventCode": "0x49e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_3",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 3.",
+    "EventCode": "0x4de",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_4",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 4.",
+    "EventCode": "0x51e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_5",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 5.",
+    "EventCode": "0x55e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_6",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 6.",
+    "EventCode": "0x59e",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_7",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 7.",
+    "EventCode": "0x5de",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_8",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 8.",
+    "EventCode": "0x41f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_9",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 9.",
+    "EventCode": "0x45f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_10",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 10.",
+    "EventCode": "0x49f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_11",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 11.",
+    "EventCode": "0x4df",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_12",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 12.",
+    "EventCode": "0x51f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_13",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 13.",
+    "EventCode": "0x55f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_14",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 14.",
+    "EventCode": "0x59f",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_inbound_data_beats_cfi_15",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between remote socket and Core-to-Fabric Interface 15.",
+    "EventCode": "0x5df",
+    "UMask": "0xbfe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_0",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 0.",
+    "EventCode": "0x41e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_1",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 1.",
+    "EventCode": "0x45e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_2",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 2.",
+    "EventCode": "0x49e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_3",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 3.",
+    "EventCode": "0x4de",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_4",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 4.",
+    "EventCode": "0x51e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_5",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 5.",
+    "EventCode": "0x55e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_6",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 6.",
+    "EventCode": "0x59e",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_7",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 7.",
+    "EventCode": "0x5de",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_8",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 8.",
+    "EventCode": "0x41f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_9",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 9.",
+    "EventCode": "0x45f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_10",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 10.",
+    "EventCode": "0x49f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_11",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 11.",
+    "EventCode": "0x4df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_12",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 12.",
+    "EventCode": "0x51f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_13",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 13.",
+    "EventCode": "0x55f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_14",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 14.",
+    "EventCode": "0x59f",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_socket_outbound_data_beats_cfi_15",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between remote socket and Core-to-Fabric Interface 15.",
+    "EventCode": "0x5df",
+    "UMask": "0xbff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_0",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 0.",
+    "EventCode": "0x41e",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_1",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 1.",
+    "EventCode": "0x45e",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_2",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 2.",
+    "EventCode": "0x49e",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_3",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 3.",
+    "EventCode": "0x4de",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_4",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 4.",
+    "EventCode": "0x51e",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_5",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 5.",
+    "EventCode": "0x55e",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_6",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 6.",
+    "EventCode": "0x59e",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_7",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 7.",
+    "EventCode": "0x5de",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_8",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 8.",
+    "EventCode": "0x41f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_9",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 9.",
+    "EventCode": "0x45f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_10",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 10.",
+    "EventCode": "0x49f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_11",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 11.",
+    "EventCode": "0x4df",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_12",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 12.",
+    "EventCode": "0x51f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_13",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 13.",
+    "EventCode": "0x55f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_14",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 14.",
+    "EventCode": "0x59f",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_inbound_data_beats_cfi_15",
+    "PublicDescription": "Inbound data beats (32 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 15.",
+    "EventCode": "0x5df",
+    "UMask": "0xffe",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_0",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 0.",
+    "EventCode": "0x41e",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_1",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 1.",
+    "EventCode": "0x45e",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_2",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 2.",
+    "EventCode": "0x49e",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_3",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 3.",
+    "EventCode": "0x4de",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_4",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 4.",
+    "EventCode": "0x51e",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_5",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 5.",
+    "EventCode": "0x55e",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_6",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 6.",
+    "EventCode": "0x59e",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_7",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 7.",
+    "EventCode": "0x5de",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_8",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 8.",
+    "EventCode": "0x41f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_9",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 9.",
+    "EventCode": "0x45f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_10",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 10.",
+    "EventCode": "0x49f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_11",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 11.",
+    "EventCode": "0x4df",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_12",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 12.",
+    "EventCode": "0x51f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_13",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 13.",
+    "EventCode": "0x55f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_14",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 14.",
+    "EventCode": "0x59f",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_or_remote_socket_outbound_data_beats_cfi_15",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local or remote socket and Core-to-Fabric Interface 15.",
+    "EventCode": "0x5df",
+    "UMask": "0xfff",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_link_0",
+    "PublicDescription": "Inbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 0.",
+    "EventCode": "0xd5f",
+    "UMask": "0xf3f",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_link_1",
+    "PublicDescription": "Inbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 1.",
+    "EventCode": "0xd9f",
+    "UMask": "0xf3f",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_link_2",
+    "PublicDescription": "Inbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 2.",
+    "EventCode": "0xddf",
+    "UMask": "0xf3f",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_link_3",
+    "PublicDescription": "Inbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 3.",
+    "EventCode": "0xe1f",
+    "UMask": "0xf3f",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_link_4",
+    "PublicDescription": "Inbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 4.",
+    "EventCode": "0xe5f",
+    "UMask": "0xf3f",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_inbound_data_beats_link_5",
+    "PublicDescription": "Inbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 5.",
+    "EventCode": "0xe9f",
+    "UMask": "0xf3f",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link_0",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 0.",
+    "EventCode": "0xd5f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link_1",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 1.",
+    "EventCode": "0xd9f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link_2",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 2.",
+    "EventCode": "0xddf",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link_3",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 3.",
+    "EventCode": "0xe1f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link_4",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 4.",
+    "EventCode": "0xe5f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "local_socket_outbound_data_beats_link_5",
+    "PublicDescription": "Outbound data beats (64 bytes) for transactions between local socket and remote socket over Cross-socket Link 5.",
+    "EventCode": "0xe9f",
+    "UMask": "0xf3e",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  }
+]
-- 
2.43.0


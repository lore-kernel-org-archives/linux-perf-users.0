Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA301FA25A;
	Fri, 18 Oct 2024 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243927; cv=fail; b=jhqWd9XhZqzlW2lyqlL/BTfhhzYQTQ+HTgC6ro9QoATZrEAS2s8ytj3X9HWKqfbXkBa6RMta7h+Z2zQxoWv3pHjnmHAe5wl67voz2S2Jf6SNf0mZfKlG+q2RgYOF0vXs36NWc3M69Nddn3zy1h9/ANOuZkd40Daza7t++P8VoLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243927; c=relaxed/simple;
	bh=kT47ABbDguNuRU8IllXIm7rEObcL0of2qLexYwavrNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIK/VvWVpcljdX1ix6A4PjUut9qdyDw71fi71VVcpO8KUXA+ke/+dDNBffb0iZmuNWx0/QLuhWUW6cp1+iqk1J3ulNLxOeFUIRCuvsUPsQJyyWbRT+cTYOf2zmJvyokeuNzvPYf2cQyGd9ksAsoVMNG9qTVwvAZWjbKvFObSOxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o/ITWlQ5; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o/ITWlQ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEZ8ed3Iqd1yQ/kaW4ADBMGWyP50UVfvzYUZs6V3tDCBOt7MoQXcZ4b1SWwxnhZhIEmc0JV68raLnppmIvyqgET96yzZhmidQdjOtRWJrJoQgJfxlS3l37orP3jCKFs4VJFfKYLjFIDEtidk6XOfgG7ThMah4M73MueEZeONRNNj+ZOUc7YySp5oc3FCTsTL6hAiZ73y8iMLffq1sXen3NT0LN5q4Remp6fC6F1Ao6yHFNFgMoaXjd5LzOXNM8PeQbEbAAusxDcPuRpQBrtfS6dHKxLyazTJkFC42ixI7L+/PNoaZ+7c2D+t3u9bGyqqqxScVjsGwHuDY9H22tJPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfWjga/6ulA0l9XoJRFz9Owki4+740jYtw84PGP13vM=;
 b=QGbRIDGnRWbSkWIDoEvVsWmzq4l1puACPbjRPzifxbkGjYEC1O3wHT/Ge+uZ3tTQxcCOB1X0kbxqleQ5yA68kQwyMPC6IlGuMW5CGPC+La5g2CV/dwIXSPvvC83O/q41jh0pcDj+SxglK5lnTUIo6wKR7V7ysNK+F5d4W13gK1fhEXywMfTifUAS2VL/WeTawSKqGmG/oJHkJNf/EJkRL56EgaJg5uTqo9IIrCbRs5e4XZ0nU9/GY9SE8ClIA0E8gGX+3TkMrHCoSC15EOfkBvPdIL8d3ck8mNGmtINACc2V8qseip/ZA1BdnpKoSWdrgGFp/q7/2APTrDblfkGrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfWjga/6ulA0l9XoJRFz9Owki4+740jYtw84PGP13vM=;
 b=o/ITWlQ5OPRjOenBS83+ap26qvanFK0zjjdwQU5W3d/nZDWbXlZPufnVEmEjXl8PB3eoiBUEFXXhYZRIVJkBvGD+wuTY9aUYcTU8au4WQJMvUD8nmi7OM1cJQxVHCR1znUQsDC6SajnOS7J6DfAxzrCbBkIGzoFVgAGSMR7No+c=
Received: from DM6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:5:174::32)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Fri, 18 Oct
 2024 09:32:00 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::4f) by DM6PR21CA0022.outlook.office365.com
 (2603:10b6:5:174::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8 via Frontend
 Transport; Fri, 18 Oct 2024 09:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 09:31:59 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 04:31:54 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 2/3] perf vendor events amd: Add Zen 5 data fabric metrics
Date: Fri, 18 Oct 2024 15:01:04 +0530
Message-ID: <e8757bb9f511907a52bc182de9395c5edec2fccf.1729242778.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 727af977-88e7-425b-45c1-08dcef57b752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aBUbWIVs7TOlG4CMwUXEmzNnzU7xXmPiP0gq92afGI5l/varqta6Vl0ELL3X?=
 =?us-ascii?Q?A1hTVV1exHvzYAlXmXqJ1nzAdpQJJ7c8dEntGIqqCm/SFWU0fvn8fHyakYco?=
 =?us-ascii?Q?JD8/7eXK81fD3iLeATHI0Dj9tPzSfK78WRSs2vLzylA6RC2PX01/ek1hwsc7?=
 =?us-ascii?Q?0hGjEs3aQc8DNAeMlUdc+Tb1Q8Z3m4Wr0d2glfXqkaM7V8sCl1Nr8EP7ogzG?=
 =?us-ascii?Q?hm6La/y534ccm+ppulFdBPYJR5dSn7As8JBKwSAb1Od6pqmXJlW6/jT2IaP6?=
 =?us-ascii?Q?dVxltJoFSVrKJcPTHwOG1I63q9ng7wNtzT5bEmBuNkUjkBNVguh2wWrqTNOV?=
 =?us-ascii?Q?rIR0hHRGi9mE1lYDnMjZ6urGtVt/7FKOcZi+4AIsLVk4nVQ+8j1pKpFVd9uG?=
 =?us-ascii?Q?yTg0wz9Yf0TOltkp07AIcJdkgKRKXv7d+Ig5W6D0tArURBurak+GwnJ/oAaE?=
 =?us-ascii?Q?C7blW9a4O54zo5Bo6IKAEvrTR+bs+QfSnKZko341XtSbSTrTmr/CZ8gPOpKS?=
 =?us-ascii?Q?aL5XyXxyvoaKdY5SS866NvnU50CkpAqzaITGi9YpRW3+BIQMQCUl1WDaBdCw?=
 =?us-ascii?Q?llnPBDfPj0wDcpo8jkHrbxf4Cyo1NQ0K2ZeI2E/cLTmKheLpfSH9os6bpHC/?=
 =?us-ascii?Q?x8kvzLcYt/bW6dJZ2fCqRjkfehVQiMCbLVm7VrQOVMR6T83QutxM0D+ECu0v?=
 =?us-ascii?Q?nMq5G6gEosdAWcbCL/SErccgRt5MyL0ihE68c5xKsr3o8G+QLeUwJ+WiTvPv?=
 =?us-ascii?Q?yUl9jg0t4C8Mee2JoFv0x9yRqZV0iLcGkM1j7uUy2GBKTILCREviJXFbCarU?=
 =?us-ascii?Q?dBwE00cb6ExAVXKrwfXyKDBx6CtUuK5/XlXtUpsQ2BZ9a8B5Dl60eDzXT53D?=
 =?us-ascii?Q?ZH4Vc/1brAl7tF/QCNLRtbYtp0xrs5n5ApqdSvgDxc8CaKOYwIBW6hctoqp8?=
 =?us-ascii?Q?6aGSJ2olZv8OwRcIon9LqSrHpET1qAmDpsIdlVAn4xEpTsAqeAbkcwX8wPRc?=
 =?us-ascii?Q?dkhgfrQa0BGgty3dLb27h0htzLr1f3VFyGl7u6m2mNM/nMjo8IyBwRDOhQf0?=
 =?us-ascii?Q?z/0wjhZl2mBoe8ajg3+LTu61+xfMahxJ6z7VuGulTqnrwfTiehR+N7KI4I1F?=
 =?us-ascii?Q?act0psbonhhJf167uQWTIoGoLv8ud9WuOaKiGP0tBWM4hSuRUT3aGyuYm18A?=
 =?us-ascii?Q?pskqQ1GBsMwk2RD8vfVnbIQhKubTtKMBlcX2Mu+VVyagPXGzPIeQWNfbz/YC?=
 =?us-ascii?Q?Z9k0nobN/oXRm0vsb5IwXeqlas8/eOzBbSIRlDIRk9dEWYy7ekrlEGdC7M5P?=
 =?us-ascii?Q?8kggAFfkfGfxfWmJCTy2mFySh+NUqfUKiCCJnKzWIkyffFl+HZx7uPUdZeRu?=
 =?us-ascii?Q?S6CWN5mMOe9mgWKFpKHQY6CNkEFc1ojHkAXD2Mb4ppU1acE59Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:31:59.5020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727af977-88e7-425b-45c1-08dcef57b752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943

Add data fabric metrics taken from Section 2.1.16.2 "Performance
Measurement" in the Processor Programming Reference (PPR) for AMD Family
1Ah Model 02h Revision C1 Processors document available at the link
below.

The recommended metrics are sourced from Table 28 "Guidance for Common
Performance Statistics with Complex Event Selects". They capture data
bandwidth for various links and interfaces in the data fabric.

Link: https://bugzilla.kernel.org/attachment.cgi?id=307010
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen5/recommended.json         | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
index c97874039c1e..635d57e3bc15 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
@@ -341,5 +341,117 @@
     "MetricGroup": "memory_controller",
     "PerPkg": "1",
     "ScaleUnit": "1per_memclk"
+  },
+  {
+    "MetricName": "dram_read_bandwidth_for_local_or_remote_socket",
+    "BriefDescription": "DRAM read data bandwidth for accesses in local or remote socket.",
+    "MetricExpr": "(local_or_remote_socket_read_data_beats_dram_0 + local_or_remote_socket_read_data_beats_dram_1 + local_or_remote_socket_read_data_beats_dram_2 + local_or_remote_socket_read_data_beats_dram_3 + local_or_remote_socket_read_data_beats_dram_4 + local_or_remote_socket_read_data_beats_dram_5 + local_or_remote_socket_read_data_beats_dram_6 + local_or_remote_socket_read_data_beats_dram_7 + local_or_remote_socket_read_data_beats_dram_8 + local_or_remote_socket_read_data_beats_dram_9 + local_or_remote_socket_read_data_beats_dram_10 + local_or_remote_socket_read_data_beats_dram_11) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "dram_write_bandwidth_for_local_socket",
+    "BriefDescription": "DRAM write data bandwidth for accesses in local socket.",
+    "MetricExpr": "(local_socket_write_data_beats_dram_0 + local_socket_write_data_beats_dram_1 + local_socket_write_data_beats_dram_2 + local_socket_write_data_beats_dram_3 + local_socket_write_data_beats_dram_4 + local_socket_write_data_beats_dram_5 + local_socket_write_data_beats_dram_6 + local_socket_write_data_beats_dram_7 + local_socket_write_data_beats_dram_8 + local_socket_write_data_beats_dram_9 + local_socket_write_data_beats_dram_10 + local_socket_write_data_beats_dram_11) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "dram_write_bandwidth_for_remote_socket",
+    "BriefDescription": "DRAM write data bandwidth for accesses in remote socket.",
+    "MetricExpr": "(remote_socket_write_data_beats_dram_0 + remote_socket_write_data_beats_dram_1 + remote_socket_write_data_beats_dram_2 + remote_socket_write_data_beats_dram_3 + remote_socket_write_data_beats_dram_4 + remote_socket_write_data_beats_dram_5 + remote_socket_write_data_beats_dram_6 + remote_socket_write_data_beats_dram_7 + remote_socket_write_data_beats_dram_8 + remote_socket_write_data_beats_dram_9 + remote_socket_write_data_beats_dram_10 + remote_socket_write_data_beats_dram_11) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "dram_write_bandwidth_for_local_or_remote_socket",
+    "BriefDescription": "DRAM write data bandwidth for accesses in local or remote socket.",
+    "MetricExpr": "(local_or_remote_socket_write_data_beats_dram_0 + local_or_remote_socket_write_data_beats_dram_1 + local_or_remote_socket_write_data_beats_dram_2 + local_or_remote_socket_write_data_beats_dram_3 + local_or_remote_socket_write_data_beats_dram_4 + local_or_remote_socket_write_data_beats_dram_5 + local_or_remote_socket_write_data_beats_dram_6 + local_or_remote_socket_write_data_beats_dram_7 + local_or_remote_socket_write_data_beats_dram_8 + local_or_remote_socket_write_data_beats_dram_9 + local_or_remote_socket_write_data_beats_dram_10 + local_or_remote_socket_write_data_beats_dram_11) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "upstream_dma_read_bandwidth_for_local_socket",
+    "BriefDescription": "Upstream DMA read data bandwidth for accesses in local socket.",
+    "MetricExpr": "(local_socket_upstream_read_data_beats_io_0 + local_socket_upstream_read_data_beats_io_1 + local_socket_upstream_read_data_beats_io_2 + local_socket_upstream_read_data_beats_io_3 + local_socket_upstream_read_data_beats_io_4 + local_socket_upstream_read_data_beats_io_5 + local_socket_upstream_read_data_beats_io_6 + local_socket_upstream_read_data_beats_io_7) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "upstream_dma_write_bandwidth_for_local_socket",
+    "BriefDescription": "Upstream DMA write data bandwidth for accesses in local socket.",
+    "MetricExpr": "(local_socket_upstream_write_data_beats_io_0 + local_socket_upstream_write_data_beats_io_1 + local_socket_upstream_write_data_beats_io_2 + local_socket_upstream_write_data_beats_io_3 + local_socket_upstream_write_data_beats_io_4 + local_socket_upstream_write_data_beats_io_5 + local_socket_upstream_write_data_beats_io_6 + local_socket_upstream_write_data_beats_io_7) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "upstream_dma_read_bandwidth_for_remote_socket",
+    "BriefDescription": "Upstream DMA read data bandwidth for accesses in remote socket.",
+    "MetricExpr": "(remote_socket_upstream_read_data_beats_io_0 + remote_socket_upstream_read_data_beats_io_1 + remote_socket_upstream_read_data_beats_io_2 + remote_socket_upstream_read_data_beats_io_3 + remote_socket_upstream_read_data_beats_io_4 + remote_socket_upstream_read_data_beats_io_5 + remote_socket_upstream_read_data_beats_io_6 + remote_socket_upstream_read_data_beats_io_7) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "upstream_dma_write_bandwidth_for_remote_socket",
+    "BriefDescription": "Upstream DMA write data bandwidth for accesses in remote socket.",
+    "MetricExpr": "(remote_socket_upstream_write_data_beats_io_0 + remote_socket_upstream_write_data_beats_io_1 + remote_socket_upstream_write_data_beats_io_2 + remote_socket_upstream_write_data_beats_io_3 + remote_socket_upstream_write_data_beats_io_4 + remote_socket_upstream_write_data_beats_io_5 + remote_socket_upstream_write_data_beats_io_6 + remote_socket_upstream_write_data_beats_io_7) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "core_inbound_data_bandwidth_for_local_socket",
+    "BriefDescription": "Core inbound data bandwidth for accesses in local socket.",
+    "MetricExpr": "(local_socket_inbound_data_beats_cfi_0 + local_socket_inbound_data_beats_cfi_1 + local_socket_inbound_data_beats_cfi_2 + local_socket_inbound_data_beats_cfi_3 + local_socket_inbound_data_beats_cfi_4 + local_socket_inbound_data_beats_cfi_5 + local_socket_inbound_data_beats_cfi_6 + local_socket_inbound_data_beats_cfi_7 + local_socket_inbound_data_beats_cfi_8 + local_socket_inbound_data_beats_cfi_9 + local_socket_inbound_data_beats_cfi_10 + local_socket_inbound_data_beats_cfi_11 + local_socket_inbound_data_beats_cfi_12 + local_socket_inbound_data_beats_cfi_13 + local_socket_inbound_data_beats_cfi_14 + local_socket_inbound_data_beats_cfi_15) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "3.2e-5MB/s"
+  },
+  {
+    "MetricName": "core_outbound_data_bandwidth_for_local_socket",
+    "BriefDescription": "Core outbound data bandwidth for accesses in local socket.",
+    "MetricExpr": "(local_socket_outbound_data_beats_cfi_0 + local_socket_outbound_data_beats_cfi_1 + local_socket_outbound_data_beats_cfi_2 + local_socket_outbound_data_beats_cfi_3 + local_socket_outbound_data_beats_cfi_4 + local_socket_outbound_data_beats_cfi_5 + local_socket_outbound_data_beats_cfi_6 + local_socket_outbound_data_beats_cfi_7 + local_socket_outbound_data_beats_cfi_8 + local_socket_outbound_data_beats_cfi_9 + local_socket_outbound_data_beats_cfi_10 + local_socket_outbound_data_beats_cfi_11 + local_socket_outbound_data_beats_cfi_12 + local_socket_outbound_data_beats_cfi_13 + local_socket_outbound_data_beats_cfi_14 + local_socket_outbound_data_beats_cfi_15) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "core_inbound_data_bandwidth_for_remote_socket",
+    "BriefDescription": "Core inbound data bandwidth for accesses in remote socket.",
+    "MetricExpr": "(remote_socket_inbound_data_beats_cfi_0 + remote_socket_inbound_data_beats_cfi_1 + remote_socket_inbound_data_beats_cfi_2 + remote_socket_inbound_data_beats_cfi_3 + remote_socket_inbound_data_beats_cfi_4 + remote_socket_inbound_data_beats_cfi_5 + remote_socket_inbound_data_beats_cfi_6 + remote_socket_inbound_data_beats_cfi_7 + remote_socket_inbound_data_beats_cfi_8 + remote_socket_inbound_data_beats_cfi_9 + remote_socket_inbound_data_beats_cfi_10 + remote_socket_inbound_data_beats_cfi_11 + remote_socket_inbound_data_beats_cfi_12 + remote_socket_inbound_data_beats_cfi_13 + remote_socket_inbound_data_beats_cfi_14 + remote_socket_inbound_data_beats_cfi_15) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "3.2e-5MB/s"
+  },
+  {
+    "MetricName": "core_outbound_data_bandwidth_for_remote_socket",
+    "BriefDescription": "Core outbound data bandwidth for accesses in remote socket.",
+    "MetricExpr": "(remote_socket_outbound_data_beats_cfi_0 + remote_socket_outbound_data_beats_cfi_1 + remote_socket_outbound_data_beats_cfi_2 + remote_socket_outbound_data_beats_cfi_3 + remote_socket_outbound_data_beats_cfi_4 + remote_socket_outbound_data_beats_cfi_5 + remote_socket_outbound_data_beats_cfi_6 + remote_socket_outbound_data_beats_cfi_7 + remote_socket_outbound_data_beats_cfi_8 + remote_socket_outbound_data_beats_cfi_9 + remote_socket_outbound_data_beats_cfi_10 + remote_socket_outbound_data_beats_cfi_11 + remote_socket_outbound_data_beats_cfi_12 + remote_socket_outbound_data_beats_cfi_13 + remote_socket_outbound_data_beats_cfi_14 + remote_socket_outbound_data_beats_cfi_15) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "cross_socket_inbound_data_bandwidth_for_local_socket",
+    "BriefDescription": "Inbound data bandwidth for accesses between local socket and remote socket.",
+    "MetricExpr": "(local_socket_inbound_data_beats_link_0 + local_socket_inbound_data_beats_link_1 + local_socket_inbound_data_beats_link_2 + local_socket_inbound_data_beats_link_3 + local_socket_inbound_data_beats_link_4 + local_socket_inbound_data_beats_link_5) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
+  },
+  {
+    "MetricName": "cross_socket_outbound_data_bandwidth_for_local_socket",
+    "BriefDescription": "Outbound data bandwidth for accesses between local socket and remote socket.",
+    "MetricExpr": "(local_socket_outbound_data_beats_link_0 + local_socket_outbound_data_beats_link_1 + local_socket_outbound_data_beats_link_2 + local_socket_outbound_data_beats_link_3 + local_socket_outbound_data_beats_link_4 + local_socket_outbound_data_beats_link_5) / duration_time",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.4e-5MB/s"
   }
 ]
-- 
2.43.0


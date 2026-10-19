Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792428302;
	b=MZskVF+O56uHlYZaFyvP8hTIrR4HOQ+x1CnvqTpuzWRT3NQP06f91IZyZbxARZ49h/k5
	 P1o955sBlZwSsTxrvlIbAJpzE7yvraoZNZ7MhrFvYnqfRwLxGmefD7tAFgEf+K1idjTzQ
	 fPfXpjXmeHHpvai87ysww+FRNrfzZdqY0nXjLpvGhnl5/Gv+cXrdLB5aggvl+eBLsRAm9
	 EE1TiApOuizUDs782dOguQoG7zPrSczX7wEXX9K/+arswA4KNuiBhW4bDUsJmUiuD8rk7
	 bXMnbn0M8J4BCMOVjNDpCkpwiMSH4+5OzNgWRjCC89VGj+NNFd9e/JSXQdJ7tuKbklQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428302;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BxOFuWfHCobRcTLmWpyLhiNcwOEdVTys81sfY1IHbQM=;
	b=jNsd54rZvJ9djZu/7pyE68TPXOVlm0y++Lca4Smu4XWvwWNGwEXAugRHI+gv5Sbts0D7
	 e/qFq3rSZoGgZG5DJUi77YJ0aE1oewG1fH4lCEpzbdgm1Ro38jw122ckQNqG6LbudOf/e
	 4UpEKSo+DIqEeRiWz5FmsrX4Tuci9ZnwvQ0ulNavXBpR7k7Yp/B8xoOzyelu+hX4ezAdl
	 7OHrC04N/BtNJXt6ULUtKS3Fq0L8ypBAJWfpeB/BMUVti1muc9/qZszh+UcKhR7KWv/mD
	 ZRH8l49GlU53X2GiQSMXao0XWkECfZaxdJQBBx4ypxsuudFWT2rHppQRM8A3aOTjk9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IB7tFqA5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.37
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F1606A319;
	Mon, 19 Oct 2026 16:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 914F1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IB7tFqA5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ws9TaIK0Oic9rnYhqukM+W8a8PgDSt0DwuXXeqsuCOmS8m8euo3/icVxb4o1A1CHx/DozHmVZmT3OQQ0LZZOXqWBK5ypo+wUrodbSReA9S3fV72UEwtIY7tb3pcHFFsPnu6IFuZQvWbzN+rYnK++seK0C/C4mnhMbzGSSCmKGlaU7yV73+l8Z6Ui21bx0fi81FQeGAcWIufpZUupbxb0VWWCM+0gXCF/XfklxGyla9cN4cBUYxZseAfsvtF90hOHdDxd7A55jTGk8tXZhzQa96OcMi6LfamHUr6TM21IiFq84wgKIXCkeMn/nCIlD/f+l/KVA0WZjpOGlLGHQJivrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxOFuWfHCobRcTLmWpyLhiNcwOEdVTys81sfY1IHbQM=;
 b=eUWN3z6uU6WhE+wL9lZHNZjNtHGXJoJ6zS3YNSLfjgs7ZUvRQc9xUT19nlc9Gr54QbRR2la7GGfBGohWahz90VrvwmC0lZO0v8xYBBzDtZSPEqOxruCwT+c9xTMOa2UoMVxMc4iulwdVxIfUQ+pYhDjuYDhbLmC2eBIEJU7aeQVnEieyTEPRUAA2uKaIE1itm1R1w5X7xeYCDrrWfo9rlp/2OQN4QaEW8yXJf3Na1odW7GSKv33gQn5k8L6xHXXlie5f2tSQ7h+rced1fVjAG+AONK+RdSyfY3EmPO/c7R12DC8zM8N0U5fXW4u8x1z3rZgoM6BnXWdcvjy2TWtmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxOFuWfHCobRcTLmWpyLhiNcwOEdVTys81sfY1IHbQM=;
 b=IB7tFqA5bmYNmrXOUA/ePe38avfdWMFSBYK+om8qwFv6avMM1e0MnbmbXqLlU01pC9hBAY8D/E8r0odj7D1/KSHILlzOp7S0SFY3GxdRxq02ogJbXJIKp5DU2kx95L4Fr4Srq31CLqBm5bINu9l+oaqEnRSiuwfq1Fi8nnoRDF/m9fmNE5iyqELeXCWY7WIYU/TSlaBfbpGTIm3M1m5G5t8aTom6n54gE1/p6++M3vhkl/5ojzSpp3ZS5+n04S3Jnm4XKdeXzU9fOW6X3Y+Er/F87emkgNlLWSq3yJMqiDRjXJH5s2uHa1Bc7kMI/HKbBJuVnO19cRTLvfEK5j4m+w==
Received: from SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:44:56 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::3f) by SJ0PR05CA0085.outlook.office365.com
 (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Mon,
 19 Oct 2026 16:44:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:44:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 19 Oct
 2026 09:44:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 19 Oct
 2026 09:44:31 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 19 Oct 2026 09:44:30 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vsethi@nvidia.com>, <rwiley@nvidia.com>, <skelley@nvidia.com>,
	<mochs@nvidia.com>, <rajjoshi@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <john.garry@linux.dev>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ctshao@google.com>, "Besar
 Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH 4/6] perf jevents: Add support for NVIDIA Tegra410 PCIE-TGT PMU aliasing
Date: Mon, 19 Oct 2026 16:42:39 +0000
Message-ID: <20261019164241.403644-5-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019164241.403644-1-bwicaksono@nvidia.com>
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|LV5PR12MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 881e53af-18f1-4857-65ca-08df2e004eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	8FL0nc+UBcuRcjjKsc8kR1wSzWA/30bpM+YZMNXlYdwHEMEQsKMVlgpcOzKpefKMvKQ+aXHu06zmfQpMTl0E88eNe6Irqq8JNCqcknFS57Q9n40YSZZMQ6et0fKTfSlKMC+SdzVAQc2WZ1RjbEAitw7UOmiaCWI7vOWJBz3qfRyL8azXTrwWZUajJ9KZHw2OTtCJPNEzMswAG7qibpMo+1vcOkAo/lTqAfCTYi75dBCVp8LZKWBM++sJdY1lfsEGwYsNFLU3yg5EZpI0JCJO3KvXS88QPFSImQrksF7MIs7Oe9JH0tqyJpBx3h/Mz+4/TrXJ6jDxRfuhl+rVjft3t8cknvAs1IZALRdOA8ibsGctAcaqj5csyxvR5Um9gNFvDJqwdhRtkg2JGo8aiLmShlh1NLsB+vveBGOSfkbGs5kFd9nJwJ5ni4YWiqnb0s7u6UaFkcvlGQFvQ7XZtl1t8bWqu8NKVWDlYWdLhEZGzsdaJ+DuJjCz8LdNEqJCpRV5Fni5e0uEtvF6q3XkLEQ0RUaBkFCq17Vqzy8sdhI1KfagPC9Yvsp/v+/i6QxvFyNtB9pRGetO4asktX+NXU81ESabphdTCQiJfwawmMmHO7dyeqkng7qY1Fcg+73HMrVKRsqG4nYZchALRhcGoDAntxpO/1m+WO3FOS5EA31kGTa4l9wxpKvz+UukwvRd8aRZaBfoRbr2iWrYMoQrGRqBTw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Eb19mIAAuaL9niNneL+9iGgvMTkDMvCzeXDa0ZE7yk2IReZfPV7T7b/lZnEjUJi93kbpyCLkNi74PLEdgIDnmnoYsvsjuY0gAkMJeJA3cCMKWauRCIJyzyf/GHfxEd8m/sCWl5+FMm7+gyb6yYdPS3rQWpJ3Vo3HNgisPSj387Gyu9aQrT+HKkU68lj7+ggVpa92V70MONLlCp/trj+nB9JJDV23bY3iRjDfj65Vo96it8eTSJFyUrzYt2NBl5JKac9MIFWZZXP+8PUIjJDjvN0NP6wyccp8xSySuhLqYGucG7dX+nR2HNwnYgtOxZrNngHbw2yw9gKGcgPD+Yx4lBg/70kQx0BS2y1xZt3qJIkrREmaIna5WuYhdd5WHP8Z8usUHP4UWre0y4CJ694HEuCEanOTTx9QmUH7l1bv9nF96W9zpryd85VxG8ctZyN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:44:56.4408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881e53af-18f1-4857-65ca-08df2e004eb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753

Add alias support for NVIDIA Tegra410 PCIE-TGT PMU events and metrics.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../nvidia/t410/sys/uncore-pcie_tgt.json      | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.json

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.json
new file mode 100644
index 000000000000..74786fc3d578
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.json
@@ -0,0 +1,93 @@
+[
+    {
+        "EventCode": "0x4",
+        "EventName": "PCIE_TGT_CYCLES",
+        "BriefDescription": "Counts cycles at the PCIe interface to the Tegra SoC data fabric.",
+        "PublicDescription": "Counts cycles at the PCIe interface to the Tegra SoC data fabric.",
+        "Compat": "1070036b",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "PCIE_TGT_RD_REQ",
+        "BriefDescription": "Counts read requests from any source to PCIe BAR or CXL HDM ranges under this PCIe root complex.",
+        "PublicDescription": "Counts read requests from any source to PCIe BAR or CXL HDM ranges under this PCIe root complex, where the target responds with data. Request size can be from 1 to 256 bytes. Filters: dst_rp_mask selects PCIe BAR traffic to root ports (bit n = root port n). dst_addr_en with dst_addr_base and dst_addr_mask selects PCIe BAR or CXL HDM addresses that equal the base in the mask's set bits. If both dst_rp_mask and the address filter are set, a request matching either is counted. With no filter, PCIe BAR traffic to all root ports is counted.",
+        "Compat": "1070036b",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x3",
+        "EventName": "PCIE_TGT_WR_REQ",
+        "BriefDescription": "Counts write requests from any source to PCIe BAR or CXL HDM ranges under this PCIe root complex.",
+        "PublicDescription": "Counts write requests from any source to PCIe BAR or CXL HDM ranges under this PCIe root complex, where the source sends data. Request size can be from 1 to 256 bytes. Filters: dst_rp_mask selects PCIe BAR traffic to root ports (bit n = root port n). dst_addr_en with dst_addr_base and dst_addr_mask selects PCIe BAR or CXL HDM addresses that equal the base in the mask's set bits. If both dst_rp_mask and the address filter are set, a request matching either is counted. With no filter, PCIe BAR traffic to all root ports is counted.",
+        "Compat": "1070036b",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x0",
+        "EventName": "PCIE_TGT_RD_BYTES",
+        "BriefDescription": "Counts bytes transferred by the read requests counted by PCIE_TGT_RD_REQ.",
+        "PublicDescription": "Counts bytes transferred by the read requests counted by PCIE_TGT_RD_REQ. Destination filters work as described for PCIE_TGT_RD_REQ.",
+        "Compat": "1070036b",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "PCIE_TGT_WR_BYTES",
+        "BriefDescription": "Counts bytes transferred by the write requests counted by PCIE_TGT_WR_REQ.",
+        "PublicDescription": "Counts bytes transferred by the write requests counted by PCIE_TGT_WR_REQ. Destination filters work as described for PCIE_TGT_WR_REQ.",
+        "Compat": "1070036b",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_tgt_freq",
+        "MetricGroup": "PCIE_TGT_Frequency",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(PCIE_TGT_CYCLES / aggr_nr(PCIE_TGT_CYCLES)) / 1e9 / duration_time",
+        "ScaleUnit": "1GHz",
+        "BriefDescription": "Frequency of the cycles at the PCIe interface to the Tegra SoC data fabric.",
+        "PublicDescription": "Average frequency of the cycles at the PCIe interface to the Tegra SoC data fabric over the measurement interval.",
+        "Compat": "1070036b",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_tgt_avg_rd_bandwidth_to_all_dst",
+        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR_CXL_HDM",
+        "MetricExpr": "PCIE_TGT_RD_BYTES@dst_addr_en=1,dst_addr_base=0,dst_addr_mask=0@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth to all PCIe BAR and CXL HDM ranges under this PCIe root complex.",
+        "PublicDescription": "Average read bandwidth of requests from any source to all PCIe BAR and CXL HDM ranges under this PCIe root complex.",
+        "Compat": "1070036b",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_tgt_avg_wr_bandwidth_to_all_dst",
+        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR_CXL_HDM",
+        "MetricExpr": "PCIE_TGT_WR_BYTES@dst_addr_en=1,dst_addr_base=0,dst_addr_mask=0@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth to all PCIe BAR and CXL HDM ranges under this PCIe root complex.",
+        "PublicDescription": "Average write bandwidth of requests from any source to all PCIe BAR and CXL HDM ranges under this PCIe root complex.",
+        "Compat": "1070036b",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_tgt_avg_rd_bandwidth_to_pcie_bar",
+        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR",
+        "MetricExpr": "PCIE_TGT_RD_BYTES / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth of PCIe BAR traffic to all root ports under this PCIe root complex.",
+        "PublicDescription": "Average read bandwidth of PCIe BAR traffic from any source to all root ports under this PCIe root complex.",
+        "Compat": "1070036b",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_tgt_avg_wr_bandwidth_to_pcie_bar",
+        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR",
+        "MetricExpr": "PCIE_TGT_WR_BYTES / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth of PCIe BAR traffic to all root ports under this PCIe root complex.",
+        "PublicDescription": "Average write bandwidth of PCIe BAR traffic from any source to all root ports under this PCIe root complex.",
+        "Compat": "1070036b",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    }
+]
-- 
2.43.0


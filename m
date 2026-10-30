Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793382634;
	b=xQmZT/lfJrGXcA/XaO0U3n0W6+ytq3z4Ju+j+dq2d3ogwEAOd4UiaT/3VrqySZXm99lK
	 LKPDQ7iEhl2U37+eSaJu2xKuBQ5lCLSmhjwUsfDkMIj9tLbY4o/KS2yp6clMDwwMGY4KT
	 tEdjXR2xRTe+u8TWMsX5Kq1B1mYLR+xFlFRWfJ2aUBBBn5r/ovva+vGKUtt26RWFclGxk
	 BCITMo/EbORbuy98veWs7PP0vhWUy+lamsDkZf3T+W/MASmAhS23frxWch+cOOYmcbzNH
	 U0g+V+ccy/eBdDdHxAiz2zxYPBDkHwcAR7rlIo741N3vNLwHQL55jg8WG9dYvuMgL9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382634;
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
	bh=+3vWWcXvQ1G+1hgayIa+HoU7zvRHN6JB8hslECzlT90=;
	b=Y+HAPftPmQUNfwDfVy/8W6ZbuBaiR6lQz8kYWTUCJL7HaIjrtFRo46z9TpF86FHPhz+K
	 UzipvUFUNXvqaz+0LvhP/NaYbbUMaxSlga7nleq/hs//5VKp+IkH5l/xATpTDPPpcQcOV
	 3gSblpkc6LhL+R1cTaVR5Q7sF79Jc1qBoemW+Wtsvifr1+ECYLKCLz1PAdd9+w+l1fn/l
	 FAfVmybXnne2XWVMqo3ZubVMslMhMm/el9+0Q80R/lpE23zLz9CEdg6sjBV4zpnQp4Ad9
	 /q6gsDgiww486qEa2YA2HnbUwYQyPcUD3ZOdr0xkXhxT9hqgc1J1AS1eBsQsT61Sgeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G+Z0B4eS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.3
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB046606A327;
	Fri, 30 Oct 2026 17:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB046606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G+Z0B4eS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inA29waVaBNU5w226UkUDDu6Y3HTJB1k7j1DcdbLSdzKnFDGk9nd4kIkOmRdmn4PTvB+bZiuQFjVOapazNLui0qPd9QSS/rQ7Bqgo1Cn1ZFCaS9TvC7IeFJremgjTz4pMfeq4QWouikQHUlz5jFm9CAUPqcMiWyQz71PJziIS4vZub+BYLle8dRLQg0R6DFX5HH9Ej2wxOq/PpouSd0pV51UZLhDusGPNGrE4L82uG3IUWc30X3TLOZe2mDMBO7x4bEhj+Lf+YaAr4azWeuxs9lXaJF/OSin7c3ugmFvZZoc0GXhjpGu+rJ3EUlWV0TgLUAA4nzL32AB0rav2MIB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3vWWcXvQ1G+1hgayIa+HoU7zvRHN6JB8hslECzlT90=;
 b=kWg64d5wGY5AEQX4xExiX3A16HMIUZ1YisEzrbjKRadXI9mgq9SAKOqcmb5TPYowq1Sv9A0usVXnoBqPXYQx83E1sZzQ3ameWaSsT+x4YVV/iUV3218vjSc8r95DiMAx6BGA7X5WOjmwR2vA5jx1r+WZn9pKH5ROPuACd60FcONaafNbaR44V0zbWYy/dHv3xdOEZFubYOqhR0rp0RpnYxtWXVzDuWyhkzxeRMf+gSa6JjpAoyM2+tSeCtefZvpRv/KWZVszPUKoMVX/fGd8BBIHkhxdO8MB75R6tiNzKqq89gUeuXdEtBzYPjSqavrqioMZw8yX3Isw314RmSbWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3vWWcXvQ1G+1hgayIa+HoU7zvRHN6JB8hslECzlT90=;
 b=G+Z0B4eSgPI0n7McGlGWvdWv2+oFkzJralj+XrvwAUEKB2z7XQ1XLo8B0mnjWP/E43A1qsJL22kvgx+fVdkG131by7uNkyPjFKv6V/y6w+0rq2WDdfWp152JBJj1UBbOst6yPCYl45+UiMBtMJlhngnZPd4ZU9SJTGZyzoCbIon1KrriD9yITMRCV6D+Os/5AqJ52CnXa9gnZevYczXhK2qG51phbQneCa9eT+jrQf5CnyBdRp3YlMyL9KShIzAqPtG+ViqBpDfs959nGvnc5ZhtCa37wo2zpBQBBz8d5LakmrpfvhCQ6VkiqIpckYT8jmv3HSD0GRAY/gyg4dVlpg==
Received: from CH2PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:4e::15)
 by CH1PPF934D73F2C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 17:50:26 +0000
Received: from IA0PEPF00000046.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::13) by CH2PR02CA0005.outlook.office365.com
 (2603:10b6:610:4e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Fri, 30
 Oct 2026 17:50:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 IA0PEPF00000046.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:50:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:50:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:50:06 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Fri, 30 Oct 2026 10:50:06 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<ctshao@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vsethi@nvidia.com>, <rwiley@nvidia.com>, <skelley@nvidia.com>,
	<mochs@nvidia.com>, <rajjoshi@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <john.garry@linux.dev>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v2 3/9] perf jevents: Add support for NVIDIA Tegra410 PCIE-TGT PMU aliasing
Date: Fri, 30 Oct 2026 17:48:10 +0000
Message-ID: <20261030174816.1544471-4-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030174816.1544471-1-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000046:EE_|CH1PPF934D73F2C:EE_
X-MS-Office365-Filtering-Correlation-Id: 14086e6d-6786-4d1d-29b9-08df36ae47a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|10067099003|11063799006|6133799003|261028144727099003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|56012099006|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nOxYlX/poIL+lWQfx+RFo3qf719mJbNkn6Crfv/2QqHTmegOI/Ypt56AwiT2CNh2cIO/0sKASTDjGeCX3AZwuCFWO4N0dWLCL96LYzt3pdr3F/w+jzORokaNczc9HKddIxvX50qKpo2Pb3WsNGY96ZnQGpjCXbd1F4Ler7rAOCUM9Vq1aP6j95dO2BxHIMEWuOs8cAt8FQs6bbwEyZBSRK8mB13giWxp9iFMzYUpITktIl5U0fJauU4qjDKeA4JHZoHncLE24MwumYAoEXwAlHpkxnQlmOIsggUgwS7AV0tNjiSxj5+07q0J7hktPFrPF+l+UqYWLbX5fGQQmZ2WqAqmKC/zK3F67l1xzPMtiOZSewqJAtgIjVL5cHv40k445EVHWapeByMcgMo5Jf8YxHbJDqxZut0Yj5LiqdzlCfcRfk+L4QKIk0FboGtZ9DEZiUvMgaT1FCQ+mLsaVadcD6S5NJc4lJN4mCFZtXvOtEtzLk2v62wXeBzocnG4NCLz9Xjo4kUJLw5/dLSNa/eTnWsp6E11c11496AyoUD1ZyMRvdb9AN8jnyBC1zLbmTPftp5r7SUMwn3c63KWZdTLebx4fh1WDf154S5s8KuwrNp1bo2a3qJjjtN3kIIqytk92XNKvNyqkB973WipjecPACKF/TuM66SgKWcRShCxjnRFWI9oQKluP27MTcqG3git8BCPebcvgN71XndMbDjIKQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(10067099003)(11063799006)(6133799003)(261028144727099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(56012099006)(261026140227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8QyEEmlI8n3GJQ4RKvJmv0XHflhgEnyb6de5BpDbWMu1HeA554xWi21mLytVBNi/PgPKqZDJZwOqS23x+6nQ3TUBNbKWlUMVUjHu2XZ6XXRcW9fv2Fg0q0iCKmSc6gbsuE85B5/eIDRbFV+K2XmA46PQy05qe97S1USgb4Ax8gJmRT1ttIcL7P7krJHcTehJbXVZ5Qrbjm35qOFC1vAGdh3M8j7EvYQae68v0h3Urck5RvmNvuNHXFFdxsp3F9CwW+j0QhdlrdvUW8m15ruQOjAHsJkW+gAyMhi0BBw1DMwWmxrtcqeA3br4mGPvXSMUznJ9nEKyODwTHFg1RpJOJMMTL/ZjKwQy0E1irgrCWragcwpYYcQfnmsQgTkm6QBFPMHys0yVRL8spa1T5ctMu00zUfxqPn/4A+ZgmN6bZKtjDWjbzdS+EHR5lsP8QLaY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:50:26.2142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14086e6d-6786-4d1d-29b9-08df36ae47a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000046.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF934D73F2C

Add alias support for NVIDIA Tegra410 PCIE-TGT PMU events and metrics.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../arm64/nvidia/t410/uncore-pcie_tgt.json    | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie_tgt.json

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie_tgt.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie_tgt.json
new file mode 100644
index 000000000000..0f4765042d1f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie_tgt.json
@@ -0,0 +1,83 @@
+[
+    {
+        "EventCode": "0x4",
+        "EventName": "PCIE_TGT_CYCLES",
+        "BriefDescription": "Counts cycles at the PCIe interface to the Tegra SoC data fabric.",
+        "PublicDescription": "Counts cycles at the PCIe interface to the Tegra SoC data fabric.",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "PCIE_TGT_RD_REQ",
+        "BriefDescription": "Counts read requests from any source to PCIe BAR or CXL HDM ranges under this PCIe root complex.",
+        "PublicDescription": "Counts read requests from any source to PCIe BAR or CXL HDM ranges under this PCIe root complex, where the target responds with data. Request size can be from 1 to 256 bytes. Filters: dst_rp_mask selects PCIe BAR traffic to root ports (bit n = root port n). dst_addr_en with dst_addr_base and dst_addr_mask selects PCIe BAR or CXL HDM addresses that equal the base in the mask's set bits. If both dst_rp_mask and the address filter are set, a request matching either is counted. With no filter, PCIe BAR traffic to all root ports is counted.",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x3",
+        "EventName": "PCIE_TGT_WR_REQ",
+        "BriefDescription": "Counts write requests from any source to PCIe BAR or CXL HDM ranges under this PCIe root complex.",
+        "PublicDescription": "Counts write requests from any source to PCIe BAR or CXL HDM ranges under this PCIe root complex, where the source sends data. Request size can be from 1 to 256 bytes. Filters: dst_rp_mask selects PCIe BAR traffic to root ports (bit n = root port n). dst_addr_en with dst_addr_base and dst_addr_mask selects PCIe BAR or CXL HDM addresses that equal the base in the mask's set bits. If both dst_rp_mask and the address filter are set, a request matching either is counted. With no filter, PCIe BAR traffic to all root ports is counted.",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x0",
+        "EventName": "PCIE_TGT_RD_BYTES",
+        "BriefDescription": "Counts bytes transferred by the read requests counted by PCIE_TGT_RD_REQ.",
+        "PublicDescription": "Counts bytes transferred by the read requests counted by PCIE_TGT_RD_REQ. Destination filters work as described for PCIE_TGT_RD_REQ.",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "PCIE_TGT_WR_BYTES",
+        "BriefDescription": "Counts bytes transferred by the write requests counted by PCIE_TGT_WR_REQ.",
+        "PublicDescription": "Counts bytes transferred by the write requests counted by PCIE_TGT_WR_REQ. Destination filters work as described for PCIE_TGT_WR_REQ.",
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
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_tgt_avg_rd_bandwidth_to_all_dst",
+        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR_CXL_HDM",
+        "MetricExpr": "PCIE_TGT_RD_BYTES@dst_addr_en=1,dst_addr_base=0,dst_addr_mask=0@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth to all PCIe BAR and CXL HDM ranges under this PCIe root complex.",
+        "PublicDescription": "Average read bandwidth of requests from any source to all PCIe BAR and CXL HDM ranges under this PCIe root complex.",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_tgt_avg_wr_bandwidth_to_all_dst",
+        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR_CXL_HDM",
+        "MetricExpr": "PCIE_TGT_WR_BYTES@dst_addr_en=1,dst_addr_base=0,dst_addr_mask=0@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth to all PCIe BAR and CXL HDM ranges under this PCIe root complex.",
+        "PublicDescription": "Average write bandwidth of requests from any source to all PCIe BAR and CXL HDM ranges under this PCIe root complex.",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_tgt_avg_rd_bandwidth_to_pcie_bar",
+        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR",
+        "MetricExpr": "PCIE_TGT_RD_BYTES / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth of PCIe BAR traffic to all root ports under this PCIe root complex.",
+        "PublicDescription": "Average read bandwidth of PCIe BAR traffic from any source to all root ports under this PCIe root complex.",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_tgt_avg_wr_bandwidth_to_pcie_bar",
+        "MetricGroup": "PCIE_TGT_Bandwidth;PCIE_TGT_BW_PCIE_BAR",
+        "MetricExpr": "PCIE_TGT_WR_BYTES / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth of PCIe BAR traffic to all root ports under this PCIe root complex.",
+        "PublicDescription": "Average write bandwidth of PCIe BAR traffic from any source to all root ports under this PCIe root complex.",
+        "Unit": "nvidia_pcie_tgt_pmu_,rc_"
+    }
+]
-- 
2.43.0


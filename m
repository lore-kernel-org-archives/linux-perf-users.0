Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808503;
	b=d2Rpzv06JWsphAaCg8MPyqJxc2JACGPH3/4El1foCansAOW6anO+UcQoe1OiHvI6JgTi
	 SpHpo3RsvFWD3avm9VYN4LD3M7v6GacrDnFUuZRAdehflcHKsg56JjD1fra1WHjdjUUaV
	 vLtYsXe/G5KbZJL/xnZNR6TL7qzQ4a/dXY1lALC+TunR3f4obfP2hp9dkos1dABlfCJFT
	 kJlUHJmvTYiHAJNyUja1skprT29qYc1yknkACUej0KIZ6svKYSKHWc4Mv4qFbZAA6j/nK
	 fAI9YQYsyV9csDpdp3KKlNa4DtIMS6pDYIxMpu8GcX607eliQHk+69W/S73SlfXxH0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808503;
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
	bh=zcZDpjepUQX+LaEyemriJWEf9v0V4tH2ON1ySVGwDQw=;
	b=ZWl6qdKpAlnKDDSdfuJ6Gr7tjaCbA3En6V2Ox8cBZSZ1uH1QNKorToe8d38DlULGEodh
	 kF4B4SL2+vBYYszQeDW88CaNsleIy8qVddAnBsuNOCGbvfhVgDBFvz99fm7w3BHXEL8v/
	 TfXTXNgn0Sp6Tbh3rcDXTuUUTPgGpTMHZK3EftNXduek467YeuAm13ibqVhiJMr4G+WSN
	 Ywh8e+foXbF6GS8Dpb90mGXFSwy0K1LT5M8e7DhrAimNJGLwqeVviwczWOz4sFwKFfLmi
	 upSKeySTfe/0rB9OedcNVFBYnjkQQorlCqy4+gRS3LRDGbnqasY4++7+f6m8A9mN9sQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ValPuVqO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.58
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092C606A31B;
	Wed,  4 Nov 2026 16:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E092C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ValPuVqO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD9TSxVphcefiOLefkPIgvrOrH+yYsXFkvU9FDffaqfptuwFRdy0VC3Xm4fWQhuqpjN32xvF0qaR54U40WRfuRJxidLGCsJReZcH6wv1xQSp+bHmRayTTHqCWncaTeKyYVn9y9bOx1F+E8ZANlUCr2kK7mHj6ZuHiwNRJcAFj2AOYNziQ3zcdXLei39ZDlq++LEguDjPAr1rVs785M66+ltVXVscoW3DxCO9QrHu3ZzD6FNrwS5mWngQQ17aOk2h9+40zM3OREtt/60DRGPAmZLhfWTuSMTKMUuho64VNTxXbjVX3Im+Bag0hPSktdc63AjOZVn+pH13Vw6XHW+Y/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcZDpjepUQX+LaEyemriJWEf9v0V4tH2ON1ySVGwDQw=;
 b=flwxLL2PcreL08WMH7BZr5O9tU9RGakdvOUabsasDfqD14EPpEBQ1y35hnI+4vfZmMaiKNdPftTYZivDmCpJIji9uwKUs4nO5RKZWeqcgNQmAgRC7BYCqdomq42tSAyDTXx66g5MwXnN9aEkdxCgA4O+F8kKtl7I628XCI2tCE08aLbqzmNfObcATnCAIeKEvQZTi8NJBd3w0/Pex7MHMVyTe6+EDfKnN1ZNwVjAh+/YyxuW+Tl9nyv4af+wYXQweybX++hoRvj0+c2vgsBUMIo5UO8JK1MNG2wE7PAHQ/ySN2AuYtK+nsIN5Lz0+1gko6nY0j3lgd8sOgmf5lcRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcZDpjepUQX+LaEyemriJWEf9v0V4tH2ON1ySVGwDQw=;
 b=ValPuVqObnkbq63kVM6TqwsOf/DcNhRR8q+S0oHF9I3sX6HND0IvdV8+HkJA/BzQK5xFYWt014EnG5IvG941GMurvdnZdQR21/CJPs3U3xqxLTEu8LYl72ZnmGkHRSzVHJX2BUtm5udf54btqPOKU1p+3Fn+2Bnd4TWojmoGQu/3am/GCcY8s3+SRg5Zw5kGsruh6P+HD6MDbE1bNYsjWPxDkLJ1NmclEyEqiiLCMRsEow7rsDog0hr8vnD9Gg3TXvpoJ4iex8pR3MRkGdRJ48V/Trs2i0ZAW4MyMSq2S31H/5bxxsJq60iEhQC9RjDcmq57nfZ1BBCqlH9bhU24cw==
Received: from DS7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:8:54::30) by
 DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.10; Wed, 4 Nov 2026 16:08:17 +0000
Received: from CH01EPF000BE94D.namprd02.prod.outlook.com
 (2603:10b6:8:54:cafe::53) by DS7PR06CA0052.outlook.office365.com
 (2603:10b6:8:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 16:08:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94D.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 16:08:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:07:54 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:07:53 -0800
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via
 Frontend Transport; Wed, 4 Nov 2026 08:07:52 -0800
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
Subject: [PATCH v3 2/7] perf jevents: Add support for NVIDIA Tegra410 PCIE PMU aliasing
Date: Wed, 4 Nov 2026 16:07:11 +0000
Message-ID: <20261104160716.2910873-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104160716.2910873-1-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94D:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0f8b3a-ce52-4f30-a263-08df3a8dd69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|82310400026|36860700016|56012099006|261022105027099003|10067099003|261021121427099003|11063799006|261022075727099003|261009223027099003|261028144727099003|261026140227099003|18002099003|22082099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	yBc4yvcUDQ8Fbgl2YadkHgIJmsOM6iSp7eSNR47siCPotgE3o+0K6aQXYkBg60YE6BUyFpv54Q/Vrz9mnFSzxXrBS4Ase4YRSk1rtQMq1kc/7rv/mitbn8XbUAXhSL3b1yk5Mz7rYnJkhD5P8G7xfcDyWQ76GsLijF/14JUZ6C22higHvagi171FYuPFSy9kozOXfT4yHiN8QQF+5W7YR+CIZWXIf/c6qV0z7MsGVR0nWyIjFLtQ4NzCVfQOxD1oN+wnHwD5d6H242kow7YnTBRkHuIkVAN9CDuh6XyT4oAWEmJAiOCxPj67cY4Zs6RewER+cxKv8qqJtGmsHwhDfYVzENy+EuyLtlvmFdxKhShnTxrthvqw/maty6laI168OOJZpon14uX7AD3lIzHapE+dwy3T5h2b9PZWNbBZ0rgl+o33wr+F51RGFwnNwfa8VprtqmuvcX4KXGVCH+FLg2pEyk3CHrKLjoJy2ifGVyxWVkmE+agAynQ5RAztzexQSO1+dlGKykx2xtIvssB+rdpXEpe+DtVDe4Z+XbWIUQ2XJmYLa/pheKCjBCZz9MWWCy7q0aOh5OROUElse6R5Va7TYs6If6wFO/Ai2TRHSSaO5JSfZI+xPJFOVSFLuQXhFXaaoCavUlR5M1pmcBAyaW75iZDm+moKKrZB/IOy7+MKU2k1QvmaUcQZi4Ff3SEcmB1CjPIzcYfz8bv8HboPWQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(82310400026)(36860700016)(56012099006)(261022105027099003)(10067099003)(261021121427099003)(11063799006)(261022075727099003)(261009223027099003)(261028144727099003)(261026140227099003)(18002099003)(22082099003)(261102123227099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LrOgPDPnqmwQv+nFWQh/CYfQ62vD1AWqs0qimiEE4u7SSaZJFta7Sj5TmvQgDtKssNOt856dE1/f2U+n7zVZkKKQJgRSe4VU8bBVEbKMAikH+RrslJaIyWBt6GYnE5X0qyl+tiB6l6JOxmvOxtDO26RrSSC+ndbFash/uPngPDUTb2KKU+bJ1n+M2bY7f+nSuJ370NAUMTcrT7qrioi/oidOzdMr3qQR5cxdIrFnFr8OVviaNoDQEFEH//Z3Rjbb/OWikAXXkE/7UlOQesNj6kqpDPce6fXFYma5b/fg/+LxNdJQ8Km9wKtQY4bBnJjhwdCc+LF+HzNZoXdeWibmB49tNrWHEPPfHE/C+Voh3UDV0p7wcDKrM7kjX67EbKCQy2sL4eKLeCNzQhIaZ6dq2KigtYRXM/hf1wBF8Yr7qzaNcZf7i11ei5I1k3+l3jvr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:08:17.3793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0f8b3a-ce52-4f30-a263-08df3a8dd69b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089

Add alias support for NVIDIA Tegra410 PCIE PMU events and metrics.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../arch/arm64/nvidia/t410/uncore-pcie.json   | 249 ++++++++++++++++++
 1 file changed, 249 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie.json

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie.json
new file mode 100644
index 000000000000..3fbf1799a8bb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie.json
@@ -0,0 +1,249 @@
+[
+    {
+        "EventCode": "0x100000000",
+        "EventName": "PCIE_CYCLES",
+        "BriefDescription": "Counts cycles at the PCIe interface to the Tegra SoC data fabric.",
+        "PublicDescription": "Counts cycles at the PCIe interface to the Tegra SoC data fabric.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "PCIE_RD_REQ",
+        "BriefDescription": "Counts read requests from PCIe devices under this PCIe root complex to memory or another PCIe device.",
+        "PublicDescription": "Counts read requests from PCIe devices under this PCIe root complex to memory or another PCIe device, where the target responds with data. Request size can be from 1 to 256 bytes. Filters: src_rp_mask selects the requesting root ports. Alternatively, src_bdf with src_bdf_en selects one requesting device (BDF); it cannot be combined with src_rp_mask and applies to all counters of this PMU. Destination filters select the memory type of the request address: dst_loc_cmem local CMEM, dst_loc_gmem local GMEM, dst_loc_pcie_p2p local PCIe peer addresses, dst_loc_pcie_cxl local CXL memory, dst_rem remote memory. This is the address's home type, not where the data currently resides; local or remote is determined by the home socket of the address. An unset source filter counts all root ports; an unset destination filter counts all destinations.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x3",
+        "EventName": "PCIE_WR_REQ",
+        "BriefDescription": "Counts write requests from PCIe devices under this PCIe root complex to memory or another PCIe device.",
+        "PublicDescription": "Counts write requests from PCIe devices under this PCIe root complex to memory or another PCIe device, where the PCIe device sends data. Request size can be from 1 to 256 bytes. Filters: src_rp_mask selects the requesting root ports. Alternatively, src_bdf with src_bdf_en selects one requesting device (BDF); it cannot be combined with src_rp_mask and applies to all counters of this PMU. Destination filters select the memory type of the request address: dst_loc_cmem local CMEM, dst_loc_gmem local GMEM, dst_loc_pcie_p2p local PCIe peer addresses, dst_loc_pcie_cxl local CXL memory, dst_rem remote memory. This is the address's home type, not where the data currently resides; local or remote is determined by the home socket of the address. An unset source filter counts all root ports; an unset destination filter counts all destinations.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x0",
+        "EventName": "PCIE_RD_BYTES",
+        "BriefDescription": "Counts bytes transferred by the read requests counted by PCIE_RD_REQ.",
+        "PublicDescription": "Counts bytes transferred by the read requests counted by PCIE_RD_REQ. Source and destination filters work as described for PCIE_RD_REQ.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "PCIE_WR_BYTES",
+        "BriefDescription": "Counts bytes transferred by the write requests counted by PCIE_WR_REQ.",
+        "PublicDescription": "Counts bytes transferred by the write requests counted by PCIE_WR_REQ. Source and destination filters work as described for PCIE_WR_REQ.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x4",
+        "EventName": "PCIE_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding read requests counted by PCIE_RD_REQ each cycle at the PCIe interface.",
+        "PublicDescription": "Accumulates the outstanding read requests counted by PCIE_RD_REQ each cycle at the PCIe interface. Pair the two under the same filters for the average read latency. Source and destination filters work as described for PCIE_RD_REQ.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_freq",
+        "MetricGroup": "PCIE_Frequency;PCIE_Read_Latency",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(PCIE_CYCLES / aggr_nr(PCIE_CYCLES)) / 1e9 / duration_time",
+        "ScaleUnit": "1GHz",
+        "BriefDescription": "Frequency of the cycles at the PCIe interface to the Tegra SoC data fabric.",
+        "PublicDescription": "Average frequency of the cycles at the PCIe interface to the Tegra SoC data fabric over the measurement interval.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_all_dst",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_To_All_Destinations",
+        "MetricExpr": "PCIE_RD_BYTES@dst_loc_cmem=1,dst_loc_gmem=1,dst_loc_pcie_p2p=1,dst_loc_pcie_cxl=1,dst_rem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to all destinations.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to all destinations: local CMEM, local GMEM, local PCIe peer addresses, local CXL memory and remote memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_all_dst",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_To_All_Destinations",
+        "MetricExpr": "PCIE_WR_BYTES@dst_loc_cmem=1,dst_loc_gmem=1,dst_loc_pcie_p2p=1,dst_loc_pcie_cxl=1,dst_rem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to all destinations.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to all destinations: local CMEM, local GMEM, local PCIe peer addresses, local CXL memory and remote memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_bandwidth_to_all_dst",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_To_All_Destinations",
+        "MetricExpr": "pcie_avg_rd_bandwidth_to_all_dst + pcie_avg_wr_bandwidth_to_all_dst",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read and write bandwidth from PCIe devices under this PCIe root complex to all destinations.",
+        "PublicDescription": "Average read and write bandwidth of requests from all PCIe devices under this PCIe root complex to all destinations: local CMEM, local GMEM, local PCIe peer addresses, local CXL memory and remote memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_latency_to_all_dst",
+        "MetricGroup": "PCIE_Read_Latency;PCIE_To_All_Destinations",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_loc_cmem=1,dst_loc_gmem=1,dst_loc_pcie_p2p=1,dst_loc_pcie_cxl=1,dst_rem=1@ / PCIE_RD_REQ@dst_loc_cmem=1,dst_loc_gmem=1,dst_loc_pcie_p2p=1,dst_loc_pcie_cxl=1,dst_rem=1@) / pcie_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average read latency from PCIe devices under this PCIe root complex to all destinations.",
+        "PublicDescription": "Average latency of read requests from all PCIe devices under this PCIe root complex to all destinations: local CMEM, local GMEM, local PCIe peer addresses, local CXL memory and remote memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_local_dst",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_To_Local_Destinations",
+        "MetricExpr": "pcie_avg_rd_bandwidth_to_local_cmem + pcie_avg_rd_bandwidth_to_local_gmem + pcie_avg_rd_bandwidth_to_local_pcie_peer + pcie_avg_rd_bandwidth_to_local_cxlmem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to local destinations.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to local destinations: local CMEM, local GMEM, local PCIe peer addresses and local CXL memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_local_dst",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_To_Local_Destinations",
+        "MetricExpr": "pcie_avg_wr_bandwidth_to_local_cmem + pcie_avg_wr_bandwidth_to_local_gmem + pcie_avg_wr_bandwidth_to_local_pcie_peer + pcie_avg_wr_bandwidth_to_local_cxlmem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to local destinations.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to local destinations: local CMEM, local GMEM, local PCIe peer addresses and local CXL memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_local_cmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_CMEM",
+        "MetricExpr": "PCIE_RD_BYTES@dst_loc_cmem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to local CMEM.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to local CMEM.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_local_cmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_CMEM",
+        "MetricExpr": "PCIE_WR_BYTES@dst_loc_cmem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to local CMEM.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to local CMEM.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_latency_to_local_cmem",
+        "MetricGroup": "PCIE_Read_Latency;PCIE_Read;PCIE_To_Local_CMEM",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_loc_cmem=1@ / PCIE_RD_REQ@dst_loc_cmem=1@) / pcie_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average read latency from PCIe devices under this PCIe root complex to local CMEM.",
+        "PublicDescription": "Average latency of read requests from all PCIe devices under this PCIe root complex to local CMEM.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_local_gmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_GMEM",
+        "MetricExpr": "PCIE_RD_BYTES@dst_loc_gmem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to local GMEM.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to local GMEM.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_local_gmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_GMEM",
+        "MetricExpr": "PCIE_WR_BYTES@dst_loc_gmem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to local GMEM.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to local GMEM.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_latency_to_local_gmem",
+        "MetricGroup": "PCIE_Read_Latency;PCIE_Read;PCIE_To_Local_GMEM",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_loc_gmem=1@ / PCIE_RD_REQ@dst_loc_gmem=1@) / pcie_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average read latency from PCIe devices under this PCIe root complex to local GMEM.",
+        "PublicDescription": "Average latency of read requests from all PCIe devices under this PCIe root complex to local GMEM.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_local_cxlmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_CXLMEM",
+        "MetricExpr": "PCIE_RD_BYTES@dst_loc_pcie_cxl=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to local CXL memory.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to local CXL memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_local_cxlmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_CXLMEM",
+        "MetricExpr": "PCIE_WR_BYTES@dst_loc_pcie_cxl=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to local CXL memory.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to local CXL memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_latency_to_local_cxlmem",
+        "MetricGroup": "PCIE_Read_Latency;PCIE_Read;PCIE_To_Local_CXLMEM",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_loc_pcie_cxl=1@ / PCIE_RD_REQ@dst_loc_pcie_cxl=1@) / pcie_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average read latency from PCIe devices under this PCIe root complex to local CXL memory.",
+        "PublicDescription": "Average latency of read requests from all PCIe devices under this PCIe root complex to local CXL memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_remote_mem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Remote_Memory",
+        "MetricExpr": "PCIE_RD_BYTES@dst_rem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to remote memory.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to remote memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_remote_mem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Remote_Memory",
+        "MetricExpr": "PCIE_WR_BYTES@dst_rem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to remote memory.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to remote memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_latency_to_remote_mem",
+        "MetricGroup": "PCIE_Read_Latency;PCIE_Read;PCIE_To_Remote_Memory",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_rem=1@ / PCIE_RD_REQ@dst_rem=1@) / pcie_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average read latency from PCIe devices under this PCIe root complex to remote memory.",
+        "PublicDescription": "Average latency of read requests from all PCIe devices under this PCIe root complex to remote memory.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_local_pcie_peer",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_PCIE_Peer",
+        "MetricExpr": "PCIE_RD_BYTES@dst_loc_pcie_p2p=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to local PCIe peer addresses.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to local PCIe peer addresses.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_local_pcie_peer",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_PCIE_Peer",
+        "MetricExpr": "PCIE_WR_BYTES@dst_loc_pcie_p2p=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to local PCIe peer addresses.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to local PCIe peer addresses.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_latency_to_local_pcie_peer",
+        "MetricGroup": "PCIE_Read_Latency;PCIE_Read;PCIE_To_Local_PCIE_Peer",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(PCIE_RD_CUM_OUTS@dst_loc_pcie_p2p=1@ / PCIE_RD_REQ@dst_loc_pcie_p2p=1@) / pcie_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average read latency from PCIe devices under this PCIe root complex to local PCIe peer addresses.",
+        "PublicDescription": "Average latency of read requests from all PCIe devices under this PCIe root complex to local PCIe peer addresses.",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    }
+]
-- 
2.43.0


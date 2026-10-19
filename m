Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792428301;
	b=CelHEpshJmf8aqXisSlt9swDqqGK79q/zhJWO2lrKbBg+TyncGPetapXLv53KfJ7cEjq
	 pi+3qUmfcdfnNl7zcOgK6ZoaIQUIjANe79qkT3g4EnbgHTAXuHi3cAjehhKFiTuojIF/o
	 aH2VF6Q2bIz0HLeJwx1P81H1Y1Sd5Z0A60f2Rx4iYAInDGgaaFO3cSZhUMAowmu/xrOfp
	 Hw7gujFd5MQJxhamrEIJ8RkAeUGNi9AtypkCEYUsmJWFK83XNP32J3OMU3+ekEyfPRpMl
	 2zrUuSZgW6FplwOrt47tI699nxivhxQxwuE/BQIqDcC2CerQvfHuE0rvS9qLeeflzpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428301;
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
	bh=S5+YECRWm2kM+qQnCabcImaFCrJxGLEyr0xAg2QZCh0=;
	b=eipMxPsqvVtbZroQa7gxkUcfhx/Yo9sVI+kL/AM+ReEFpGWGpLuestb0OV0TtzK1SnSf
	 0CNjPBub4zqqUqvrz+UMSavL46/wUAT2t24KgGspuYm2WpwxYBmoDB1JtIovY+lmwhg+w
	 qt8ARMyFwVKCqfa9el9VKGZ/IVyrye/u4u37C4vRLYVVLS804UUnGjaIC37+H1M8hKxYR
	 PpiW2HB39i6OeChJLP6uhNdKbnPsSsgDRmb96XqazpL/WIKWJAXPy1fVEhdDLcVEly0Gk
	 yLxCgSoVh5BDqp/zjZB9BMkLkBKA9V5CeH5dqwiwecYwiOie56CiH4I5CfJYiKGUx0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Mx6sJIPJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.46
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5A606A31D;
	Mon, 19 Oct 2026 16:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0F5A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Mx6sJIPJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqN/Tc/ghtRHxOftNmHz4qdscrp3P/w3SZYHDq8NtEeCVb5pUUTdl7XHUni7dRIrxpWGcFMp2o1lWAcaJ5MT2WnMxjgHiaCOq9L+44KBqM0/kO1K5qdDov44S43JiRf/wtUPWgJ9tupEd3vI4FFgAsWxjAhqxmrp+X/DDpztHRr9wQqk8aHNosvIoyUS6Jlko7rMQDyRpPxh098xsk6mWwSsYfQ9y6DMy166uioES7PtdCaQfmJ86MNFnZXzH6Yr5ZxJ4lrcBezKttu7SxIzD/ZXiFOecr0WtLbb03j2PFJ1jwhVnmTT/ih8S6wj4rXjh0Mk5f28nnj7lDZ3FGztGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5+YECRWm2kM+qQnCabcImaFCrJxGLEyr0xAg2QZCh0=;
 b=ZWq0odS6TVFK8utaRWO3Q/DdnYKctrkNIoTTZVhnvLPdO7JBSKtR00iK+o2bgVjDvPlY0/q6x+jVsSuEPhjX/HLSQMRVN/8Om+CB2Fo/Ag2pkQ7levjZVq+JssX1ihB8s6x3bJ/Iw3xvd/DauP+XtUjxC7H+C/Oi/oJRB7227uiPuUR1EyVTQ+fCIcFeuij8UyqoZ1e0yhbwLLxIos9yUwBUcrZNENINEvYVG0YF18cQpGaqiy9cuwHnvfHx97dDaGGwJKGCjvdQ76tWGclxicvTypI/07s0TNu1Bb68n98rfZYdTKrjeTA+90G4jFb0Hi4eb/Q8ikxR495iUaMxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5+YECRWm2kM+qQnCabcImaFCrJxGLEyr0xAg2QZCh0=;
 b=Mx6sJIPJtkP7BjaKiMKaNGlyGi2z48rvQarQxFaGwLLO5Xc0qORwLI6fH04dd0Gxnfh4Kcd5zwNL0o75BQlfY94JgfxGv8ynMeXFoQdP5nzSTxOVPCrSgCDiW17oYgFoGKJFJ5UEj19Opqkd/b5dSS6XyVbL8u3wuOoNw8snEwu+an231NCYP53GuLRTJwr8L3Zo4GjRE38NwPOwP19s45Ggn3CYXLKPstmk5rqHoZB9UlFNmvS0AvU94asMZTwSOSZs4zKNYYocIh4Pg6nsHHLlzoDuciMGTuqhns9QnTW8L5T1VfS6C4zE1oFGHvXMSq0D56AVi4FAvdHnyvNMtg==
Received: from PH7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:510:339::34)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:44:52 +0000
Received: from PH3PEPF0005961D.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::5b) by PH7PR03CA0008.outlook.office365.com
 (2603:10b6:510:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 19
 Oct 2026 16:44:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF0005961D.mail.protection.outlook.com (10.167.243.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:44:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 19 Oct
 2026 09:44:27 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 19 Oct
 2026 09:44:26 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 19 Oct 2026 09:44:25 -0700
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
Subject: [PATCH 3/6] perf jevents: Add support for NVIDIA Tegra410 PCIE PMU aliasing
Date: Mon, 19 Oct 2026 16:42:38 +0000
Message-ID: <20261019164241.403644-4-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961D:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: e13d6f30-bd8c-4e8f-b76b-08df2e004c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|261009223027099003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	e3EFRtDMIcXCwKOpvQ6pnBMz7baHqjS+SMV9/BbriYli9lRS+IHl5Di1biu0UGIeNo4Sy8Hfza4EjmcV6Dty/DHEAomc+K0vUkAf9MsuZpAtXy4xLBqJ+DSrJxGEv84GH827MTuvGIsNL7GvvCiZ7Si7+CIunUx49ZZzJ/p9ggyS/qdhqa3Mht7pfNttEc+z4WwECGzqdMIoDKkfiD33E9uZIbSzFlP++X06UMyJG/CEjkA2N/jgjbthkLBDO5u4wttMeHopzKfsUgVaN4sLZsWFTYYoMMhsKfCKMKK7iaI1oPjCf3XyWgEgzBT3k/iWWG4EibmiXg+xETlGhz91JX9fMNXlOKTC+2+2iJuwCGXqQMCdfVUffycHAOz0cTQkIjHwYe/43W7Q31aPF3XpKYvAW40MfQS3aAgfsNbjgIonJQrFmvmPiWDTHIKmBpCwE4LtEtrrbxlRAfVJ8xirBt4x2wq6Rnz8Ynhl5sOXqei+aP3h96R/98fwVqEIj/hw/8J+1mjmYdGhRBaxFfeo7DeSStWSL7Z/xHacX++m0xhQs0R9+XuFrKhhwzJ69rurUvm5bqPNm+BwZj1Go9CNHO+ZxiImdgCHRBXAkKE+kXAsl40O9F96CbzmUQKDqwILxKAoY4sTk7FQr0IQamFD1d1f5fSKQ3r9+3l7gwmNdHu41b5uW3l6myAb3lRXI68I5Wv+LZ6oe2ixs/a9AyO4og==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(261009223027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tu6db+ipIgpB+0U3BpVT36a7XvQhacMnKzD7R7A3KtECfGqlMi08vY8lfb2yfOzKkvI3UDf33Kd9CXo79oE6OTgP0OmLuEngIu/zShCqPmT5DxIB4fqlnU1nHDSuh6VagML20+VcRLZWUanZNB0bh0ZxFX3+qw0pXGXf4o29RaZ9I0WdI3uizIFOL+5ikyWKlt6ED4h6gVNEPYUV+Ncpl7g/x0z5BVQJteBieK6uFrefubC2QF5LejLsebvKiHxK2QrVWZEzkzmvjmXyOL3zIE2JkGbaJgESnRy6THEjmoDgFAHOi0bju4uel6X+IPpDo1xDWmyYEgs1RrmXP5NFIK4tXqfB+8Fs/CX8vyv658Hzf+p4kILSRCz6JTvRsDaAGvfwukhWJEfZElfrAC++RutcC1mb5o0l20Ket0X0nzGSetdGRs7Z2s33kMxYjL7h
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:44:52.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13d6f30-bd8c-4e8f-b76b-08df2e004c31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF0005961D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030

Add alias support for NVIDIA Tegra410 PCIE PMU events and metrics.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../arm64/nvidia/t410/sys/uncore-pcie.json    | 247 ++++++++++++++++++
 1 file changed, 247 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie.json

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie.json
new file mode 100644
index 000000000000..37c3eac305e5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie.json
@@ -0,0 +1,247 @@
+[
+    {
+        "EventCode": "0x100000000",
+        "EventName": "PCIE_CYCLES",
+        "BriefDescription": "Counts cycles at the PCIe interface to the Tegra SoC data fabric.",
+        "PublicDescription": "Counts cycles at the PCIe interface to the Tegra SoC data fabric.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "PCIE_RD_REQ",
+        "BriefDescription": "Counts read requests from PCIe devices under this PCIe root complex to memory or another PCIe device.",
+        "PublicDescription": "Counts read requests from PCIe devices under this PCIe root complex to memory or another PCIe device, where the target responds with data. Request size can be from 1 to 256 bytes. Filters: src_rp_mask selects the requesting root ports. Alternatively, src_bdf with src_bdf_en selects one requesting device (BDF); it cannot be combined with src_rp_mask and applies to all counters of this PMU. Destination filters select the memory type of the request address: dst_loc_cmem local CMEM, dst_loc_gmem local GMEM, dst_loc_pcie_p2p local PCIe peer addresses, dst_loc_pcie_cxl local CXL memory, dst_rem remote memory. This is the address's home type, not where the data currently resides; local or remote is determined by the home socket of the address. An unset source filter counts all root ports; an unset destination filter counts all destinations.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x3",
+        "EventName": "PCIE_WR_REQ",
+        "BriefDescription": "Counts write requests from PCIe devices under this PCIe root complex to memory or another PCIe device.",
+        "PublicDescription": "Counts write requests from PCIe devices under this PCIe root complex to memory or another PCIe device, where the PCIe device sends data. Request size can be from 1 to 256 bytes. Filters: src_rp_mask selects the requesting root ports. Alternatively, src_bdf with src_bdf_en selects one requesting device (BDF); it cannot be combined with src_rp_mask and applies to all counters of this PMU. Destination filters select the memory type of the request address: dst_loc_cmem local CMEM, dst_loc_gmem local GMEM, dst_loc_pcie_p2p local PCIe peer addresses, dst_loc_pcie_cxl local CXL memory, dst_rem remote memory. This is the address's home type, not where the data currently resides; local or remote is determined by the home socket of the address. An unset source filter counts all root ports; an unset destination filter counts all destinations.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x0",
+        "EventName": "PCIE_RD_BYTES",
+        "BriefDescription": "Counts bytes transferred by the read requests counted by PCIE_RD_REQ.",
+        "PublicDescription": "Counts bytes transferred by the read requests counted by PCIE_RD_REQ. Source and destination filters work as described for PCIE_RD_REQ.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "PCIE_WR_BYTES",
+        "BriefDescription": "Counts bytes transferred by the write requests counted by PCIE_WR_REQ.",
+        "PublicDescription": "Counts bytes transferred by the write requests counted by PCIE_WR_REQ. Source and destination filters work as described for PCIE_WR_REQ.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "EventCode": "0x4",
+        "EventName": "PCIE_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding read requests counted by PCIE_RD_REQ each cycle at the PCIe interface.",
+        "PublicDescription": "Accumulates the outstanding read requests counted by PCIE_RD_REQ each cycle at the PCIe interface. Pair the two under the same filters for the average read latency. Source and destination filters work as described for PCIE_RD_REQ.",
+        "Compat": "1030136b",
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
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_all_dst",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_To_All_Destinations",
+        "MetricExpr": "PCIE_RD_BYTES@dst_loc_cmem=1,dst_loc_gmem=1,dst_loc_pcie_p2p=1,dst_loc_pcie_cxl=1,dst_rem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to all destinations.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to all destinations: local CMEM, local GMEM, local PCIe peer addresses, local CXL memory and remote memory.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_all_dst",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_To_All_Destinations",
+        "MetricExpr": "PCIE_WR_BYTES@dst_loc_cmem=1,dst_loc_gmem=1,dst_loc_pcie_p2p=1,dst_loc_pcie_cxl=1,dst_rem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to all destinations.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to all destinations: local CMEM, local GMEM, local PCIe peer addresses, local CXL memory and remote memory.",
+        "Compat": "1030136b",
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
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_local_cmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_CMEM",
+        "MetricExpr": "PCIE_RD_BYTES@dst_loc_cmem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to local CMEM.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to local CMEM.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_local_cmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_CMEM",
+        "MetricExpr": "PCIE_WR_BYTES@dst_loc_cmem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to local CMEM.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to local CMEM.",
+        "Compat": "1030136b",
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
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_local_gmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_GMEM",
+        "MetricExpr": "PCIE_RD_BYTES@dst_loc_gmem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to local GMEM.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to local GMEM.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_local_gmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_GMEM",
+        "MetricExpr": "PCIE_WR_BYTES@dst_loc_gmem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to local GMEM.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to local GMEM.",
+        "Compat": "1030136b",
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
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_local_cxlmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_CXLMEM",
+        "MetricExpr": "PCIE_RD_BYTES@dst_loc_pcie_cxl=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to local CXL memory.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to local CXL memory.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_local_cxlmem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_CXLMEM",
+        "MetricExpr": "PCIE_WR_BYTES@dst_loc_pcie_cxl=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to local CXL memory.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to local CXL memory.",
+        "Compat": "1030136b",
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
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_remote_mem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Remote_Memory",
+        "MetricExpr": "PCIE_RD_BYTES@dst_rem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to remote memory.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to remote memory.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_remote_mem",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Remote_Memory",
+        "MetricExpr": "PCIE_WR_BYTES@dst_rem=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to remote memory.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to remote memory.",
+        "Compat": "1030136b",
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
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_rd_bandwidth_to_local_pcie_peer",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Read;PCIE_To_Local_PCIE_Peer",
+        "MetricExpr": "PCIE_RD_BYTES@dst_loc_pcie_p2p=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average read bandwidth from PCIe devices under this PCIe root complex to local PCIe peer addresses.",
+        "PublicDescription": "Average read bandwidth of requests from all PCIe devices under this PCIe root complex to local PCIe peer addresses.",
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    },
+    {
+        "MetricName": "pcie_avg_wr_bandwidth_to_local_pcie_peer",
+        "MetricGroup": "PCIE_Bandwidth;PCIE_Write;PCIE_To_Local_PCIE_Peer",
+        "MetricExpr": "PCIE_WR_BYTES@dst_loc_pcie_p2p=1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average write bandwidth from PCIe devices under this PCIe root complex to local PCIe peer addresses.",
+        "PublicDescription": "Average write bandwidth of requests from all PCIe devices under this PCIe root complex to local PCIe peer addresses.",
+        "Compat": "1030136b",
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
+        "Compat": "1030136b",
+        "Unit": "nvidia_pcie_pmu_,rc_"
+    }
+]
-- 
2.43.0


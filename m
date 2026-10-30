Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793382627;
	b=inxTggpSRSNzNrxI286LwcU0eO8nwNYyUeKj2vqEb8Dzt06Mgw/9vcFHdJr0mbA4ylwS
	 tcm18q4p4FeE+tbz/wlG8Gu8EkYJwmaGOA74bgc+uruwQW29FEEsHiKpfp5QkVeQH2iOx
	 j48W1cSO8aeEYjy07Dm2Y1RvCCCCy3CeCUKD2aOYoMTzQRxn8DiftWkp/hdW6DH5umy59
	 A5+dn0KVWJJhrDYp1vghjLNgHFjf9Y41I0All4K/DZzveJ2BfKE6IFl/vvIxXUvVn3Rb/
	 sLiEbGNzU+tsANMLW0m33OAbtuYPU1WldOaGD8bozrcoTZtUx+FGiyblIkvi5BwXjkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382627;
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
	b=pUgiR6s+MJRqxZMM18D/8wxHaiL2gsVDZWctSiIdn3qmEGZt30k/4RcfHwsQcL8f6s6r
	 g50Hll7b1gP4ZtK/nQ4WoEGr0vyHDpbZKLO7kHmroh7Kp6Aq8qM1nFNpsFZkLaXtPz8VT
	 gh8iUePQ7Gc260JFGDmRTPm3SuqY9EXU0hdTkg20BcXJC00DL2jbt4Bn4y7aMYWTljlrW
	 jP2GTbIuG6y4b1JtK1tA4VDh3qUpi6Lre6T5HXJ7lBmYouxHNqm8t0nab9JrPDbrJhTCT
	 jWpV0uCOJDR77sQRNbHIyfZfcLcdOU7v32Ff4nRAADrC3YCwMe3laFMXtXsQZAUsEsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H+ITVIOT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.14
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4BA606A31A;
	Fri, 30 Oct 2026 17:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB4BA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H+ITVIOT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsR+j/34U5uY27jvm2CXVOYl/Qa60aetVobzJmQxlIU2RhzdXEvBKOBtSN9RM1GneRRuXw1XUeJ6Tr9ODM9jXwpdnrVY6hem+wx5iDqVIgBck/hLxjBdaDS2ftZdNmaWwIkartLO17XMbXuwDg+F/MnNEGOHpq7fD+MzGVYlWHq5wxGxvrbNWBQ4jiNu75V88y4MI8aSuFt88uUNkpf2A65bs7uiWcuVhHEznvuCVkkYtQEc3Oo+y4OzYNknhYi2lZG2sFHF7P05WTdFQLeFPX+JzHccMBTmNhzop4WVteA73AA9o6JHiST97cswKxyEwLEOgFgWtHUDuCDAU9ywLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcZDpjepUQX+LaEyemriJWEf9v0V4tH2ON1ySVGwDQw=;
 b=ypH8U4+jTiFlBzQIlzBFD6+T5AfRUNzkPhJQTnxcI7Hxj7yShPgqiAG2ip+y6eYCoDJ2TsSkwIH+vm+lmn32yUNmKZE0C010UEad1nWGfdqg90U1Y6YY5OOlY9ykm/+WxKa4Hdf97GdwNLFNHpQXuV/svVjPAkwjCqkTZhYxxzOwgGve5WnolMtc05P0V/b0jLMK03VdKbSrvagxGBcl03H2MVnqK8S1R9VfCPXq48tVlkXVqv8VbQKz5MQU1SauK1mSolsV2CByZ8//zUskEWEBJLTUGI35nfTGbFtWlxOfOReZVo93Ufj273oShj8cWkCqJMOj5dIVgY5uNw9hVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcZDpjepUQX+LaEyemriJWEf9v0V4tH2ON1ySVGwDQw=;
 b=H+ITVIOTW3J1VWmWEBi+btZjCTXQghjPDJjDvADYGbFBl7NIFlamxizKRKU4OK8s0Axe2qtMx8XIHzS/DKuKEotm76/nPWTTmUh3XEwp3aOrt8zvbELsHrPLVdBcfuwQQzCqFDbYAXvHRQb8ZebY8zB8Mf3M0tGRgMeEO4NjNH3va49cUa19ZTCimM2RTKL1Svsofrh/zocJyzVRtSdGE/tsdS8X83T+9P0ZEXVZ2qjrJm9m4iu2kOA2kh2MZXzSISAu/Dx9Ntj+/1PypGzTdDclLW6pVToN2BQpkXextKYQPxbAzu7+hkIIdXxDP5mKcFD/pOFVkFNkFd99S3xVAA==
Received: from MN2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:208:23c::7)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:50:18 +0000
Received: from IA0PEPF00000041.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::21) by MN2PR18CA0002.outlook.office365.com
 (2603:10b6:208:23c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Fri, 30
 Oct 2026 17:50:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 IA0PEPF00000041.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 17:50:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:50:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:50:02 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Fri, 30 Oct 2026 10:50:02 -0700
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
Subject: [PATCH v2 2/9] perf jevents: Add support for NVIDIA Tegra410 PCIE PMU aliasing
Date: Fri, 30 Oct 2026 17:48:09 +0000
Message-ID: <20261030174816.1544471-3-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000041:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: f183d5fa-e094-4231-5561-08df36ae42e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EiXtpkjbKgzFA4eEKAdq7jz4Duz+m/kT/nl0qHjzf8ykxJaqqgXZZ9rYbPzqjb/gT/6HK9pSS5x8AjCf5dCMqamBVro73oTsZNzFvu+KgqoshGOqmAA/sepm5MCcveDLQhHom+xrDWq3lksWC7iEHVL0I8LAA2RvxLOQtlNzW1tv09bkeB8uFW/CztgSPVxmol8AcDF4W3iCUu+/f8YWoQ9rYMiQ38w6T7gpookWq3EWiCpTvWDFUIHKTAMi0jKzE8ZtxgXiXrRp6dn/PN9l2wLlzvSCE4oWBy5QhYwpIT/Alhbdb5uQxs6U6dM0T68+5ySKWZvKpYwnXsVbj1FRaCqaAhYhNFBJk3wOxMism7KU9fR9JwgmPd7AAGAsxNlpshDbbjisBUFGpOtjeNdz4lvi9j2cSS5WaumSzjvAYWM97wgX2xi3NnVsPYjELxPwiEd8GMiF2sGZ3F+4Gf9prWV7nc0ZjMsro6knJ4qonKx9U1m84gLo4roFFgFu2QZw3Txbt4k6y03Qs11DJ7JSaeDyz8aL1JPiat3AJgKQfRVJ7ujYUiKTqODDLY6gfvqopk/GvbbQ1bBdW0CWRDhWe29HhPrqh67WmDWwftYn/ASD1KzpahWUAVRNqvl5nZvDOqLtY7LVyVPpu6ofKBgf2fT8dMDntlnEvgv/bviNcZBsCvfHKtQfojMzxiyXLXSLTH2GJGPVWbXFtujNqAFyDA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mcq04bGXtINQSY8Osj7eV9YN+ouP7vwC50soo6alWb4V67kP0JSnA+2Jine+ZpkfPZUpbr3qfyZh6xgfc0S7WHCKPAmAunofKgfp2a1aI3V3wkI0pNlnKWZpNfb47lsnvi8weBdtMVG2f11g3yOH/C98lbQ2RF69h0JeMwfU6+QSO+B58O3DCEiwn2bs4GgXAJxGyEpjYxGP1VS43pJRTc8J83hx8vZ6KiVSv4wrEORWcJwZ0VPmsShS1X3QjuNbZcxfkhwlv3hRmhVELLBitv60xTnpdQfaIWoxbTgOwiYtz/Vve0OnH05Wdtcl3c29DjAvVE+R3EXdapTdOlOh51Svs1LHyEMMILAH2d8KJ67q4vC9fz6L+WD4JX0gM6RybyZDMUOXHjXqLiKF1TPTPekKITUBynrv0rPtwKp3iLnoz5/l3tGLteVzJz8xtbnh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:50:18.2753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f183d5fa-e094-4231-5561-08df36ae42e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

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


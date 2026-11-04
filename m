Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808509;
	b=xojlTvbgkHZS+hvcCLCSyO2HMO7eusaodP+zCJrcusp9haW4IZhfGPy83Dos0vj7QSBC
	 FWh5zmlZEB4MY9GnaChVQsoIMrl7gYAILQtXV7k238Bc9JjtzFSv3ybPi2FShMueB+TyS
	 bUvlZ/bp+UXlFsjM6g01Ojj5+q5mrEmuK8iXP+byhWVgO1Wr+UHXWg5XZSbSmIx60NdcO
	 vZdmpnnOMznw1o1XcWITiAjm8ngHYkuQmcc7J1K/Ty9xDqaPjl8Wv9OmLyw/z7gExQJRU
	 UhngK/v6tyx2I1vjbiNoq9XH8LkQw1g4CzNKaAkdpf1D3QiYNwQ/w5vNBawyZA3TMGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808509;
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
	b=Qv5yGF3UxfmoZY+kgyOaGsRVBktafjiYDVPjJnowBY0oPw9rzYRa9xy1vfQge/F40cx8
	 wNNduNnRbBUpVSpK4OLHO+p6V9tk9VP1qwkEWfjNjE1thb21SS9dNoVqPCCtiCIes4nGn
	 pp4zb/kauJ+Vm2QPARicF7/Zrm+N4VtQQ5T1690nYI8HrvUb3xVWfGTeiHnP+g5DLgqYM
	 rcvfQi1XsGv/7q/AbLH4Ho/k+dJMsT25Jg4bDad7hs2LMt/gGKRGZkuV5hkfVnpQnyqks
	 MjNE3C1BbQNF9kCJjBH+5kTC3hKH3SLgEuv4qbfQ/0+XzVN+UnD5ovtG7bczsugzQyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NePJEkcV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.31
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1900606A32F;
	Wed,  4 Nov 2026 16:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1900606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NePJEkcV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jC0yVdwFp9/CAeFQymwse0Lovr3jxzolIDNJmpvgsOIPRXFvwYbNRL+hv/RxQNj3l2GNANEOTSv+Tfma5jbbkC4KidPGa+MJ/NpJIug3pUCJpo06MjiuqJWZWNwppNaUxfOaVAvKxBMW3BeGvosiG+PCySYVI1TTiwylN1/j16BWIKe7L4wIwq2zgntVS5KGYyFGSVRsIVx2SE5s6vI4V/XJwfjEaJlxt7VTjlNp8roXQHPzOAh8IbMwQDa0Dj5WK7T9QEvEDlU/vu8GNz+eCxO5YyHLkYoI8bJ4gV6M/jgPAVc1DCWBO1DnoiR1VF/6aYP2udY8XbQyxEsj40FGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3vWWcXvQ1G+1hgayIa+HoU7zvRHN6JB8hslECzlT90=;
 b=FZ0PDzbZau3FgZtamftqBU50ajTE0DOhjP/AS/UKVFNWEArhqnwwFpy3QNjERsan7qbHmBBQvy6VXk5A3i86znCeIVQ7AtqViX4JRbhcZQ1XMK5q6Rr1wOJT/oGXNF0Rol1FoIOdIcZX0nas8MFEf3xnomJAfkAbr3DOJSkaKaRBp1yRiH1oGzOtfnmL2AkjRQOkMH984XiNB/Iuj70mhmLXiHzlKd2FF0n0qxv9GXaa9RXzlOThdazqOwQlCrOIkDSMQLukB2CFujfNuK9jDb+WHbTqshszXoEW6Lo/sMgovc1GX5Tvngmyl42Fcsv72AJPmHEENTJU+9nJC8OdIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3vWWcXvQ1G+1hgayIa+HoU7zvRHN6JB8hslECzlT90=;
 b=NePJEkcV2Gtd1PjW+c7pG/KqtkDqdWoNuUVwkrCezQ2VpWsd4mXu0g01kCWCj2kbPY4wS52FONYKp1jPTaKEzwjPYtqbPE/MeG8eIinIKyytXgmm+UnxrdU9gHBXfxeacXZzNzxFClc3LO16tPEc7sndiLRGnjN5nZ190wze3rQ9RlMnvVZAU5G5g4Z0YcRA9b+S3gyBhg3w/g/BxjXS1IoVg4/lVX5PR5VgIS/4D+VhMRou3YeqN/EEKZDby4u2Ll8oOOFj8kQmZ1izl4tcW242qqR6GRzPzH8AwkBeXNU7ieuq7mL4xaSTIBFZMol6yhkmVLHigT8C/AsmO+TChQ==
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 SJ2PR12MB8010.namprd12.prod.outlook.com (2603:10b6:a03:4c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:08:21 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::32) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 16:08:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 16:08:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:07:57 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:07:57 -0800
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via
 Frontend Transport; Wed, 4 Nov 2026 08:07:55 -0800
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
Subject: [PATCH v3 3/7] perf jevents: Add support for NVIDIA Tegra410 PCIE-TGT PMU aliasing
Date: Wed, 4 Nov 2026 16:07:12 +0000
Message-ID: <20261104160716.2910873-4-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|SJ2PR12MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe38af7-7215-4f60-ab57-08df3a8dd886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|11063799006|261021121427099003|56012099006|261009223027099003|261028144727099003|261022105027099003|261022075727099003|261102123227099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	YQq4frUE897Vka5+v/6bmh/vmfReVot3XmrheIBJ9i5lsieuWRU40B3bj7E8SEtsbUZplRO5uxXPx8Dydl7BNaJBsdbuWXCAppF6xfIhpt/87rWYuFOrBIscHDEdb9puL+Dh2kBNCH1bBq0GB+R6MbT+U8HYRdCmgdG9X7PS8knG1j0poSGNb1JCqtNe5sqj98vHQJaJeyNpPagNjXurbuSEih4aqT/dlX0Hs8RhDBjGR6oE0m8vR1ZU47ejqOF7NoE+KbyCp6lUl94qUpJouqVDuOR2tsJ8UwGPQd5mPBzEg5hcULLkFhjCRYX5tvLsvtyFjR2dRbskNLR/4fPwv/4Se6xIRWBuqNV50zU8o4S6BFiajJ5UgMZpAlAJwHz6ofN1xAzk2UFAxjgnG1BDnfQt1WAxdS304tLgj+uKSScEXJgaQf1Bjn4O7W1q1TxeQH9ef3Qi3GsdqfoSX7GuUmnQvmanKxv9VtTRODeUo8YHdXEK2G9Fkj1AbrjnOiFvk21G18eMgm6on8+X/1rFLlqbA0e2IoY7MDc2Q35c86GCQxC3el1TDjFXEF2KSRRIrTkuDFLzh1ihnofp43lgTea0T82m0AZe0vkHDOKZiW2E9/+JZwBDVPgDcRlqkV4HMS9NmuhqAQHv34f8aI8clqmssNs1tYHVH6NB9Ruu2SFcpryTPObYevvRAqcibsNHrFVMd2ix6HnpGZ1vTRk9Bw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(261028144727099003)(261022105027099003)(261022075727099003)(261102123227099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ioDjKyyW9eilaReQcvFjDmzT1n50hMiaPLU/QXKPlrmI71xqO2Y5mAEdKRNAj9SDII6+x4D4uJoJKbB45SUYHz79CbwRKNbuM20V/dj7ivlst7ovhG06/zbTo83Jb0nQ4zpdF7UQ/4F8PmbBYrwcqdFdK46DCtopOyXoZFotoRAelsSkE5MwR3dath5cymjZcn/lGmrOsASVfuxcmBly8vGIToxGDp0mqlYZXSl9zeqaFQY0Ih3NTElWTQGXAQOmEVkuHyjlER88+thbHD0hR0Qsshg7UDtsGTSmK6+UR2BMNYd01sFi7MMrMUtaUtTAb8KwcCigis7xMUrQ4p72dwQH6ORCP82ELGN1ujI9c0cMBhCrXfw0elOkZ5P3pltq5YzARhwP1xMhw69mxOp87Rkuo2mE/8nQOeLoWu6gEFJ0t5b2qbLsX+HmtWt3Vbbj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:08:20.6349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe38af7-7215-4f60-ab57-08df3a8dd886
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8010

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


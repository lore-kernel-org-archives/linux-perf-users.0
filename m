Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793382604;
	b=wyBSVhHhVixCvCs1uCsHD0+Ixw8fT1rJrw1VXTjuajvnoSrRUsAvNTS/B237Y2AqfuEr
	 unjtim774X+WVIJr0COenD61KWo/oGtUHXkblMhSR803iWNX9za3LrFelsZR+81VP+aei
	 PtgDXMXtoOlUFf/1yeVg1WmsRXtGJ4mUhB48AHlus2qtUTLZ7OoJ66J50j5WsT6AqGvMm
	 9oO+vmJLGLmlSIVyq0cr+e0eYx3YS6QOR3uJPmWjpAjnVuGxxebYCcOBFPG9htnTinZH+
	 6f4GviSdYEogcvmVmF2Hznq0AJwovbOdCaZbfYZ8NBKTa3cLcYouUteU2vXsvnrclVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382604;
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
	bh=6tj+5d0UfNnMCWkAJDG8Qeo+KwXLzoRZ7s4oS0H+lhU=;
	b=m/4uJ8FX5a6D9tDcI7oldmrM/MI+QumxS7oxkK6d48cMfkNs90CV2C4CMRmNs+w0k0+b
	 Afz0IcTKz81azGviMJO+0i6y9jVJcnZoQtW4lStmpniE4uqrhPmaj7eBMUCt91cElNfP6
	 jAZC9g8BGgWwo8BKCmkwZgAcjHZXxUrlNR4FLzG9oAvKjp0mVaquxMvLDFGGza3N0SbWZ
	 xijPZYZ4/ZlQVbOUbjrFxkdVAVe//ThmZMsikJRh9Ofl0foM2kWLS1yCOViwR1pyCdGiC
	 n7gkb3+bV2fGaC5Y2nK1A7CXypFCMd+gGcV6wG4gd65vZbXnzRlARxVsCWyfQYTjkLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FdJz6WbC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.3
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839A606A31D;
	Fri, 30 Oct 2026 17:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A839A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FdJz6WbC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olyusY9LOyM4EOx9UD7AD7wJYsVe6rcKLZAJeDsEMLARTBoiw3jkUnhd+xAwbM6lB1j2+xKUKxfM7peS+lOrmvIk1iDAqmtyyfglZmpov1BvWjR810iTulp5FL8AAbaR5bfWey+gMaZvDxQxMEYDDgNb7FAhW/14sCsfQxHBU0bpSmNNbCs/HKiXE6IXQycAF+yoBHPIVoCaQWONdbLlbwiELaM3s2mtMI2yiCwkUPBZ5YohY59hSTbJrqLrDo+K0iJmlyMuwHZLLrR+cz2Tx2apuQ9Gk/+VIeuP0tFkgtS6oKeUs1hEYsZFr4dh1Itpyrz2x+/8Qm4Dq0dyEtSfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tj+5d0UfNnMCWkAJDG8Qeo+KwXLzoRZ7s4oS0H+lhU=;
 b=R6zHGPtpsHbzd1xfIhkpG3QDx92jSgGZQe8TAyc9gcT59HC29NyMb10hJAyahEY8zs9j9F6di8FcvEC2MAf6vK9M2iuWLhEjkTFjcAN2ndk2aNsOKpLTy3HW5pE1vkUtRBSw+9ZpvjwgPMmQsX76LrvZIMbErdQAxk81o+S2jga6QWqiK+2medvyfLGf4DyGIWF1n/CJ8B4HweXcSRGzvNi00RT7VUBnXiMn25Tzuia7bKph1sHhGO6brBPUl1apMDOZIwYSMSnx8vSjHBHaKvEbelAlRjoqmgs6dk9p/GEc+qkZBvMBMMu9IHENksLG2EA01fZszvzxd19x4jUCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tj+5d0UfNnMCWkAJDG8Qeo+KwXLzoRZ7s4oS0H+lhU=;
 b=FdJz6WbC9quMFw3qsw9Iuk/M5U+5s2dHFLZPbnQOyCOTYM0mNFyQtDxWx9Pp0scUcAFKP9ekm4JnFDInCEW/skh+rBYF9sFwgZG6RCFRJPH3O6KapizdxxK56ktCY8Pqsr43Petcnr+kTHIyUNU+DsNXo82UqFRqFuMjQh3Fr/ZhgwsMsR+peUrEdf5QmILp9FCKt8h2tlh/PgLoH/ZyIQjH+lTJga9ooA0PuvM5LFQmhFLwgd52x+4zL9PieLabJ38P2XIe9qfYNi/tJzpvqmyhhHG0kupmxe8dGJN6JF1a+db0B87QGdPBCNqS0g72nxY+s3LdVKnhXZNBDHEL/g==
Received: from CH0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:610:cd::22)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:49:55 +0000
Received: from IA0PEPF00000044.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::a2) by CH0PR03CA0107.outlook.office365.com
 (2603:10b6:610:cd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 17:49:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 IA0PEPF00000044.mail.protection.outlook.com (10.167.249.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 17:49:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:49:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:49:39 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Fri, 30 Oct 2026 10:49:38 -0700
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
Subject: [PATCH v2 1/9] perf jevents: Add support for NVIDIA Tegra410 UCF PMU aliasing
Date: Fri, 30 Oct 2026 17:48:08 +0000
Message-ID: <20261030174816.1544471-2-bwicaksono@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000044:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: b29ad0e9-1b45-404d-3f15-08df36ae34fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|23010399003|1800799024|82310400026|22082099003|18002099003|11063799006|5023799004|56012099006|261009223027099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026121527099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HesOQRNxZsGa1rxTQC/WnWbBOiULJJoBwM6lnjRemjKUO/NxZPslV0G6ioXGF1SiTcWyjYNl+itgE/30AKD+wCM/DU8T1YorgvQ5wy9BARHDUpfFntYnpThc3NC+gJ60Teg2hFab7l9jvG/Ey0mOcDWxTSVnOdTiMWIWLKOS2R/58vFtrYukHbeoN94TehxYvpr+43/HbnSmAlEiiAiO5BCUpq2Q9QdNY4ixd3nKpjpbXKEXXeefUZCgYBJJYg2h719hKsC1+Ggcp8trR3zBU2y57sV/euj5nlD+VQvbHk1aGwgKz52bzQIkJy1qWprCK42EwBW+CvybBfiikOr18dBXL0/skcRohXaUhh36B3B8GOVGydYakh0zibaluQ6TmgLq1bMgDFM2ohEHYIBJwH9vtqKP+8Rj+Mv2K1NJf02Xi//jELt8NV1jfNjym2JeFEb+8URiUEEf6bGAZDwl6LUHxvOHgnvtdUMWlIAB+tTdfEtY47I0irF/b1OKP+KRyQQExPCKILDFuLtYPiq6XOPFch0AFTEy8J55LbcAqeDkKmSW2yx0wFAn2fB9jn2OeE5RPZ5ITqrs9HRGSTJDuBWXhFTus6UiSb6WOKbN/z06Rz6V7W4Ivjdn+vhlVicc/hGN3q66jBqtNl3JsJqBMdR/w1Fg2NYGL2D/qu/5PSmYZcAqGq5ZLNds+/gCa93DkSAHsCma4LfP5s35pR+vTw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026121527099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bCCFouz4YxeFd1hW5/ycp8iEaDJCxN/D48pfrgXuuAHMr9VTzEIGJZoKR+1TdqgvLgBFNHHot/fehSnk8LfjRYp7eb4QTg752BYYkB9zjjq+coIU1abPBXOHYpGnmWImSR0iS/I+wIo5QNstpbt/+U6VjDa55XDnrAhVut4tT3yi5BCGwmUhyVRE2erLdQ5HYL6xX8flKRrmxby8U+8NBf0BsT9KKNQ9p3pBrzLQgVfK9NV+cOsTd6fxZWPK8wS8uInIFun75Iz/M616myWFOfPOT/WiYXnxxnHy/ykVeLtQwrCXVXh3ebC18qrIQfcqLCMj1r4GGDeidNGgHzB2HfRIEhZSuK9C9e/JAoh3rJSkN9Fp9BJhHACFRWNGfrVLEvFdFl1MGesXq90yp4oOebvWGXygMsx9Sm7RRgtgUfSiGQwyfwhMuszqJJp+SAM2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:49:54.9314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b29ad0e9-1b45-404d-3f15-08df36ae34fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000044.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177

Add alias support for NVIDIA Tegra410 UCF PMU events and metrics.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../arch/arm64/nvidia/t410/uncore-ucf.json    | 764 ++++++++++++++++++
 1 file changed, 764 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-ucf=
.json

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-ucf.json b=
/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-ucf.json
new file mode 100644
index 000000000000..9cb964f7c53d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-ucf.json
@@ -0,0 +1,764 @@
+[
+    {
+        "EventCode": "0x100000000",
+        "EventName": "UCF_CYCLES",
+        "BriefDescription": "Counts UCF cycles using the dedicated PMU cyc=
le counter.",
+        "PublicDescription": "Counts UCF cycles using the PMU's dedicated =
cycle counter.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x1d",
+        "EventName": "UCF_BUS_CYCLES",
+        "BriefDescription": "Counts UCF cycles using a programmable event =
counter.",
+        "PublicDescription": "Counts UCF cycles using a programmable event=
 counter. The count is identical to UCF_CYCLES. Source and destination filt=
ers are ignored.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x111",
+        "EventName": "UCF_SLC_ACCESS_RD",
+        "BriefDescription": "Counts read requests from a requester to the =
SLC.",
+        "PublicDescription": "Counts read requests from a requester to the=
 SLC. A read is a request for which the completer returns data: dataless Ma=
keReadUnique and snoop requests are not reads, and prefetches issued by the=
 cores' L1/L2 caches count as reads rather than as prefetch requests. Filte=
rs: src_loc_cpu, src_loc_noncpu and src_rem select the request initiator: l=
ocal CPU, local non-CPU device or remote socket. dst_loc_cmem, dst_loc_gmem=
, dst_loc_other and dst_rem select the memory type of the request address: =
local CMEM, local GMEM, local CXL memory or remote memory; local or remote =
is determined by the home socket of the address. An unset group counts all.=
",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x112",
+        "EventName": "UCF_SLC_ACCESS_WR",
+        "BriefDescription": "Counts write requests from a requester to the=
 SLC.",
+        "PublicDescription": "Counts write requests from a requester to th=
e SLC. A write is a request in which the requester sends data: dataless Wri=
teEvictOrEvict is not a write, and CHI Write*Zero is a write because it eve=
ntually consumes DRAM bandwidth although it sends no data over the interfac=
e. Filters: src_loc_cpu, src_loc_noncpu and src_rem select the request init=
iator: local CPU, local non-CPU device or remote socket. dst_loc_cmem, dst_=
loc_gmem, dst_loc_other and dst_rem select the memory type of the request a=
ddress: local CMEM, local GMEM, local CXL memory or remote memory; local or=
 remote is determined by the home socket of the address. An unset group cou=
nts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x183",
+        "EventName": "UCF_SLC_ACCESS_DATALESS",
+        "BriefDescription": "Counts CHI Dataless requests to the SLC.",
+        "PublicDescription": "Counts CHI Dataless requests to the SLC. Dat=
aless MakeReadUnique and WriteEvictOrEvict requests are not counted. Filter=
s: src_loc_cpu, src_loc_noncpu and src_rem select the request initiator: lo=
cal CPU, local non-CPU device or remote socket. dst_loc_cmem, dst_loc_gmem,=
 dst_loc_other and dst_rem select the memory type of the request address: l=
ocal CMEM, local GMEM, local CXL memory or remote memory; local or remote i=
s determined by the home socket of the address. An unset group counts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x184",
+        "EventName": "UCF_SLC_ACCESS_ATOMIC",
+        "BriefDescription": "Counts CHI Atomic requests to the SLC.",
+        "PublicDescription": "Counts CHI Atomic requests to the SLC. Filte=
rs: src_loc_cpu, src_loc_noncpu and src_rem select the request initiator: l=
ocal CPU, local non-CPU device or remote socket. dst_loc_cmem, dst_loc_gmem=
, dst_loc_other and dst_rem select the memory type of the request address: =
local CMEM, local GMEM, local CXL memory or remote memory; local or remote =
is determined by the home socket of the address. An unset group counts all.=
",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x113",
+        "EventName": "UCF_SLC_BYTES_RD",
+        "BriefDescription": "Counts bytes transferred by the read requests=
 counted by UCF_SLC_ACCESS_RD.",
+        "PublicDescription": "Counts the bytes transferred by the read req=
uests counted by UCF_SLC_ACCESS_RD, including read data sent by Direct Memo=
ry Transfer (DMT) or Direct Cache Transfer (DCT). For transfers of an odd n=
umber of bytes, the count is rounded to the nearest power of 2 greater than=
 the bytes transferred. Because reads can be smaller than 64 bytes, the cou=
nt may not equal UCF_SLC_ACCESS_RD times 64. Source and destination filters=
 work as described for UCF_SLC_ACCESS_RD.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x114",
+        "EventName": "UCF_SLC_BYTES_WR",
+        "BriefDescription": "Counts bytes transferred by the write request=
s counted by UCF_SLC_ACCESS_WR.",
+        "PublicDescription": "Counts the bytes transferred by the write re=
quests counted by UCF_SLC_ACCESS_WR, including write data sent by Direct Wr=
ite Transfer (DWT). For transfers of an odd number of bytes, the count is r=
ounded to the nearest power of 2. Data returned to the SLC by a requester's=
 cache in response to a snoop is not counted. Because writes can be smaller=
 than 64 bytes, the count may not equal UCF_SLC_ACCESS_WR times 64. Source =
and destination filters work as described for UCF_SLC_ACCESS_WR.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x119",
+        "EventName": "UCF_SLC_HIT_RD",
+        "BriefDescription": "Counts inbound read requests that hit in the =
SLC's L3 cache or in a peer requester cache.",
+        "PublicDescription": "Counts inbound read requests that hit in the=
 SLC's L3 cache or in a peer requester cache, including one in a remote soc=
ket. Some hits are still refilled from memory (see UCF_SLC_REFILL_RD). Filt=
ers: src_loc_cpu, src_loc_noncpu and src_rem select the request initiator: =
local CPU, local non-CPU device or remote socket. dst_loc_cmem, dst_loc_gme=
m, dst_loc_other and dst_rem select the memory type of the request address:=
 local CMEM, local GMEM, local CXL memory or remote memory; local or remote=
 is determined by the home socket of the address. An unset group counts all=
.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x109",
+        "EventName": "UCF_SLC_REFILL_RD",
+        "BriefDescription": "Counts inbound read requests not supplied by =
the local socket's L1, L2 or L3 caches.",
+        "PublicDescription": "Counts inbound read requests not supplied by=
 the local socket's L1, L2 or L3 caches. For remote-memory addresses, it al=
so counts each Shared-to-Unique permission upgrade (dataless MakeReadUnique=
) of a cache line shared by requesters in different sockets. A refill is no=
t the same as a miss: the SLC may fetch data from memory even when a reques=
ter cache holds clean data, and such accesses are hits that are still refil=
led. Filters: src_loc_cpu, src_loc_noncpu and src_rem select the request in=
itiator: local CPU, local non-CPU device or remote socket. dst_loc_cmem, ds=
t_loc_gmem, dst_loc_other and dst_rem select the memory type of the request=
 address: local CMEM, local GMEM, local CXL memory or remote memory; local =
or remote is determined by the home socket of the address. An unset group c=
ounts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x10a",
+        "EventName": "UCF_SLC_REFILL_WR",
+        "BriefDescription": "Counts inbound write requests not supplied by=
 the local socket's L1, L2 or L3 caches.",
+        "PublicDescription": "Counts inbound write requests not supplied b=
y the local socket's L1, L2 or L3 caches. A write refill occurs only for a =
partial write that needs the existing data; dataless write requests do not =
cause a refill and are not counted. Filters: src_loc_cpu, src_loc_noncpu an=
d src_rem select the request initiator: local CPU, local non-CPU device or =
remote socket. dst_loc_cmem, dst_loc_gmem, dst_loc_other and dst_rem select=
 the memory type of the request address: local CMEM, local GMEM, local CXL =
memory or remote memory; local or remote is determined by the home socket o=
f the address. An unset group counts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0xf0",
+        "EventName": "UCF_SLC_ALLOCATE",
+        "BriefDescription": "Counts read, write, atomic or prefetch access=
es that allocate a line in the SLC's L3 cache.",
+        "PublicDescription": "Counts read, write, atomic or prefetch acces=
ses that allocate a line in the SLC's L3 cache. Filters: src_loc_cpu, src_l=
oc_noncpu and src_rem select the request initiator: local CPU, local non-CP=
U device or remote socket. dst_loc_cmem, dst_loc_gmem, dst_loc_other and ds=
t_rem select the memory type of the request address: local CMEM, local GMEM=
, local CXL memory or remote memory; local or remote is determined by the h=
ome socket of the address. An unset group counts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0xf3",
+        "EventName": "UCF_SLC_WB",
+        "BriefDescription": "Counts SLC eviction and coherence write-backs=
, and non-allocating write-backs from upstream clients.",
+        "PublicDescription": "Counts SLC write-backs: eviction write-backs=
, coherence write-backs, and non-allocating write-backs from upstream clien=
ts. Evictions include L3 cache and snoop filter evictions. A coherence writ=
e-back occurs when data is dirty in the L3 cache or another requester node =
cache, but a requesting agent needs clean data. A home SLC in another socke=
t, or the GL2 of a connected local or remote GPU (the point of coherence fo=
r GPU memory), can evict a line and snoop this SLC. A data-bearing snoop re=
sponse from this SLC is not counted by this event, though it uses this SLC'=
s downstream bandwidth. For a home SLC eviction, the home SLC's events coun=
t the downstream write traffic it causes. Filters: src_loc_cpu, src_loc_non=
cpu and src_rem select the initiator of the request that caused the write-b=
ack: local CPU, local non-CPU device or remote socket. This need not be the=
 agent that produced or modified the data. dst_loc_cmem, dst_loc_gmem, dst_=
loc_other and dst_rem select the memory type of the memory written back: lo=
cal CMEM, local GMEM, local CXL memory or remote memory; local or remote is=
 determined by the home socket of the address. An unset group counts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x180",
+        "EventName": "UCF_LOCAL_SNOOP",
+        "BriefDescription": "Counts snoop requests sent by this SLC to loc=
al fully coherent requester nodes or to an SLC in another socket.",
+        "PublicDescription": "Counts snoop requests sent by this SLC to fu=
lly coherent requester nodes in the local socket or to an SLC in another so=
cket, including an SLC that this SLC tracks as a sharing node. Invalidating=
, forwarding, and non-forwarding snoops are included. Each snoop request is=
 counted separately, even when one transaction snoops several clients for t=
he same cache line. Snoops generated for atomic requests or dataless reques=
ts are not counted. Filters: src_loc_cpu, src_loc_noncpu and src_rem select=
 the initiator of the request that caused the snoop: local CPU, local non-C=
PU device or remote socket. dst_loc_cmem, dst_loc_gmem, dst_loc_other and d=
st_rem select the memory type of the request address: local CMEM, local GME=
M, local CXL memory or remote memory; local or remote is determined by the =
home socket of the address. An unset group counts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x181",
+        "EventName": "UCF_EXT_SNP_ACCESS",
+        "BriefDescription": "Counts snoop requests that a home SLC or GL2 =
in another socket sends to this SLC.",
+        "PublicDescription": "Counts snoop requests that a home SLC or GL2=
 in another socket sends to this SLC. Snoops are counted whether or not the=
 response carries data. Filters: every counted snoop matches src_rem and ds=
t_rem, since it comes from a remote initiator for an address homed in anoth=
er socket. An unset source or destination group counts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x182",
+        "EventName": "UCF_EXT_SNP_EVICT",
+        "BriefDescription": "Counts snoop requests from a home SLC or GL2 =
in another socket that invalidate an L3 cache or snoop filter entry in this=
 SLC.",
+        "PublicDescription": "Counts snoop requests from a home SLC or GL2=
 in another socket that invalidate an L3 cache entry or snoop filter entry =
in this SLC. Snoops are counted whether or not the response carries data, s=
o this event cannot give the number or volume of data-bearing snoop respons=
es (see UCF_SLC_WB). Filters: every counted snoop matches src_rem and dst_r=
em, since it comes from a remote initiator for an address homed in another =
socket. An unset source or destination group counts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x121",
+        "EventName": "UCF_MEM_ACCESS_RD",
+        "BriefDescription": "Counts read requests from the SLC toward loca=
l CMEM, local GMEM, local CXL memory or remote memory.",
+        "PublicDescription": "Counts read requests from the SLC toward loc=
al CMEM, local GMEM, local CXL memory or remote memory. For remote memory i=
t can overcount: it also increments for each Shared-to-Unique permission up=
grade (dataless MakeReadUnique) of a cache line shared by requesters in dif=
ferent sockets. To count reads from remote sources without this overcount, =
count UCF_SLC_ACCESS_RD on the memory's home socket with src_rem, dst_loc_c=
mem, dst_loc_gmem and dst_loc_other set. Filters: src_loc_cpu, src_loc_nonc=
pu and src_rem select the request initiator: local CPU, local non-CPU devic=
e or remote socket. dst_loc_cmem, dst_loc_gmem, dst_loc_other and dst_rem s=
elect the memory type of the request address: local CMEM, local GMEM, local=
 CXL memory or remote memory; local or remote is determined by the home soc=
ket of the address. An unset group counts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x122",
+        "EventName": "UCF_MEM_ACCESS_WR",
+        "BriefDescription": "Counts write requests from the SLC toward loc=
al CMEM, local GMEM, local CXL memory or remote memory.",
+        "PublicDescription": "Counts write requests from the SLC toward lo=
cal CMEM, local GMEM, local CXL memory or remote memory. It includes SLC wr=
ite-backs, which are attributed as described for UCF_SLC_WB. Data-bearing s=
noop responses to evictions by a home SLC in another socket or a connected =
GPU's GL2 are not counted (see UCF_SLC_WB). Filters: src_loc_cpu, src_loc_n=
oncpu and src_rem select the request initiator: local CPU, local non-CPU de=
vice or remote socket. dst_loc_cmem, dst_loc_gmem, dst_loc_other and dst_re=
m select the memory type of the request address: local CMEM, local GMEM, lo=
cal CXL memory or remote memory; local or remote is determined by the home =
socket of the address. An unset group counts all.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x123",
+        "EventName": "UCF_MEM_BYTES_RD",
+        "BriefDescription": "Counts bytes transferred by the read requests=
 counted by UCF_MEM_ACCESS_RD.",
+        "PublicDescription": "Counts bytes transferred by the read request=
s counted by UCF_MEM_ACCESS_RD. Source and destination filters work as desc=
ribed for UCF_MEM_ACCESS_RD.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "EventCode": "0x124",
+        "EventName": "UCF_MEM_BYTES_WR",
+        "BriefDescription": "Counts bytes transferred by the write request=
s counted by UCF_MEM_ACCESS_WR.",
+        "PublicDescription": "Counts bytes transferred by the write reques=
ts counted by UCF_MEM_ACCESS_WR, including write-back data attributed as de=
scribed for UCF_SLC_WB. Data-bearing snoop responses to evictions by a home=
 SLC in another socket or a connected GPU's GL2 are not counted (see UCF_SL=
C_WB). Source and destination filters work as described for UCF_MEM_ACCESS_=
WR.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_freq",
+        "MetricGroup": "UCF_Frequency",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(UCF_CYCLES / aggr_nr(UCF_CYCLES)) / 1e9 / duration=
_time",
+        "ScaleUnit": "1GHz",
+        "BriefDescription": "UCF clock frequency.",
+        "PublicDescription": "Average UCF clock frequency over the measure=
ment interval.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_all_src_to_all_dst",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_All_Src_To_All_Dst",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_loc_cpu=3D1,src_loc_noncpu=3D1=
,src_rem=3D1,dst_loc_cmem=3D1,dst_loc_gmem=3D1,dst_loc_other=3D1,dst_rem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for r=
equests from all sources to all destinations.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local CPUs, local non-CPU devices and remote sockets for local=
 CMEM, local GMEM, local CXL memory and remote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_all_src_to_all_dst",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_All_Src_To_All_Dst",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_loc_cpu=3D1,src_loc_noncpu=3D1=
,src_rem=3D1,dst_loc_cmem=3D1,dst_loc_gmem=3D1,dst_loc_other=3D1,dst_rem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for all =
memory destinations, for requests from all initiators.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al CMEM, local GMEM, local CXL memory and remote memory, for requests initi=
ated by local CPUs, local non-CPU devices and remote sockets.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_all_src_to_all_dst",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_All_Src_To_All_Dst",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_loc_cpu=3D1,src_loc_noncpu=3D1=
,src_rem=3D1,dst_loc_cmem=3D1,dst_loc_gmem=3D1,dst_loc_other=3D1,dst_rem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
requests from all sources to all destinations.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local CPUs, local non-CPU devices and remote sockets for loca=
l CMEM, local GMEM, local CXL memory and remote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_all_src_to_all_dst",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_All_Src_To_All_Dst",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_loc_cpu=3D1,src_loc_noncpu=3D1=
,src_rem=3D1,dst_loc_cmem=3D1,dst_loc_gmem=3D1,dst_loc_other=3D1,dst_rem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al and remote memory, for traffic from all initiators.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal CMEM, local GMEM, local CXL memory and remote memory, for traffic initi=
ated by local CPUs, local non-CPU devices and remote sockets. Includes writ=
e-backs, attributed as described for UCF_SLC_WB. Data-bearing snoop respons=
es to evictions by a home SLC in another socket or a connected GPU's GL2 ar=
e not counted (see UCF_SLC_WB).",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_bandwidth_all_src_to_all_dst",
+        "MetricGroup": "UCF_BW_All_Src_To_All_Dst",
+        "MetricExpr": "ucf_avg_slc_rd_bandwidth_all_src_to_all_dst + ucf_a=
vg_slc_wr_bandwidth_all_src_to_all_dst",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read and write bandw=
idth for requests from all sources to all destinations.",
+        "PublicDescription": "Average requester-to-SLC read and write band=
width of requests from local CPUs, local non-CPU devices and remote sockets=
 for local CMEM, local GMEM, local CXL memory and remote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_bandwidth_all_src_to_all_dst",
+        "MetricGroup": "UCF_BW_All_Src_To_All_Dst",
+        "MetricExpr": "ucf_avg_mem_rd_bandwidth_all_src_to_all_dst + ucf_a=
vg_mem_wr_bandwidth_all_src_to_all_dst",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read and write bandwidt=
h for local and remote memory, for traffic from all initiators.",
+        "PublicDescription": "Average SLC-to-memory read and write bandwid=
th for local CMEM, local GMEM, local CXL memory and remote memory, for traf=
fic initiated by local CPUs, local non-CPU devices and remote sockets. Writ=
es include write-backs, attributed as described for UCF_SLC_WB. Data-bearin=
g snoop responses to evictions by a home SLC in another socket or a connect=
ed GPU's GL2 are not counted (see UCF_SLC_WB).",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_all_src_to_local_cmem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Local_CMEM;UCF_BW_All_Sr=
c_To_Local_CMEM",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_loc_cpu=3D1,src_loc_noncpu=3D1=
,src_rem=3D1,dst_loc_cmem=3D1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for r=
equests from all sources to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local CPUs, local non-CPU devices and remote sockets for local=
 CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_all_src_to_local_cmem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Local_CMEM;UCF_BW_All_=
Src_To_Local_CMEM",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_loc_cpu=3D1,src_loc_noncpu=3D1=
,src_rem=3D1,dst_loc_cmem=3D1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l CMEM, for requests from all initiators.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al CMEM, for requests initiated by local CPUs, local non-CPU devices and re=
mote sockets.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_all_src_to_local_cmem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Local_CMEM;UCF_BW_All_Sr=
c_To_Local_CMEM",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_loc_cpu=3D1,src_loc_noncpu=3D1=
,src_rem=3D1,dst_loc_cmem=3D1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
requests from all sources to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local CPUs, local non-CPU devices and remote sockets for loca=
l CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_all_src_to_local_cmem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Local_CMEM;UCF_BW_All_=
Src_To_Local_CMEM",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_loc_cpu=3D1,src_loc_noncpu=3D1=
,src_rem=3D1,dst_loc_cmem=3D1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al CMEM, for traffic from all initiators.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal CMEM, for traffic initiated by local CPUs, local non-CPU devices and re=
mote sockets. Includes write-backs, attributed as described for UCF_SLC_WB.=
",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_bandwidth_all_src_to_local_cmem",
+        "MetricGroup": "UCF_BW_All_Src_To_Local_CMEM",
+        "MetricExpr": "ucf_avg_slc_rd_bandwidth_all_src_to_local_cmem + uc=
f_avg_slc_wr_bandwidth_all_src_to_local_cmem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read and write bandw=
idth for requests from all sources to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC read and write band=
width of requests from local CPUs, local non-CPU devices and remote sockets=
 for local CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_bandwidth_all_src_to_local_cmem",
+        "MetricGroup": "UCF_BW_All_Src_To_Local_CMEM",
+        "MetricExpr": "ucf_avg_mem_rd_bandwidth_all_src_to_local_cmem + uc=
f_avg_mem_wr_bandwidth_all_src_to_local_cmem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read and write bandwidt=
h for local CMEM, for traffic from all initiators.",
+        "PublicDescription": "Average SLC-to-memory read and write bandwid=
th for local CMEM, for traffic initiated by local CPUs, local non-CPU devic=
es and remote sockets. Writes include write-backs, attributed as described =
for UCF_SLC_WB.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_local_src_to_local_cmem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Local_CMEM;UCF_BW_Local_=
Src_To_Local_CMEM",
+        "MetricExpr": "ucf_avg_slc_rd_bandwidth_local_cpu_to_local_cmem + =
ucf_avg_slc_rd_bandwidth_local_noncpu_to_local_cmem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for l=
ocal CPU and local non-CPU requests to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local CPUs and local non-CPU devices such as the GPU and PCIe =
devices for local CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_local_src_to_local_cmem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Local_CMEM;UCF_BW_Loca=
l_Src_To_Local_CMEM",
+        "MetricExpr": "ucf_avg_mem_rd_bandwidth_local_cpu_to_local_cmem + =
ucf_avg_mem_rd_bandwidth_local_noncpu_to_local_cmem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l CMEM, for requests initiated by local CPUs and local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al CMEM, for requests initiated by local CPUs and local non-CPU devices suc=
h as the GPU and PCIe devices.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_local_src_to_local_cmem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Local_CMEM;UCF_BW_Local_=
Src_To_Local_CMEM",
+        "MetricExpr": "ucf_avg_slc_wr_bandwidth_local_cpu_to_local_cmem + =
ucf_avg_slc_wr_bandwidth_local_noncpu_to_local_cmem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
local CPU and local non-CPU requests to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local CPUs and local non-CPU devices such as the GPU and PCIe=
 devices for local CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_local_src_to_local_cmem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Local_CMEM;UCF_BW_Loca=
l_Src_To_Local_CMEM",
+        "MetricExpr": "ucf_avg_mem_wr_bandwidth_local_cpu_to_local_cmem + =
ucf_avg_mem_wr_bandwidth_local_noncpu_to_local_cmem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al CMEM, for traffic initiated by local CPUs and local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal CMEM, for traffic initiated by local CPUs and local non-CPU devices suc=
h as the GPU and PCIe devices. Includes write-backs, attributed as describe=
d for UCF_SLC_WB.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_local_src_to_remote_mem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Remote_Memory;UCF_BW_Loc=
al_Src_To_Remote_Memory",
+        "MetricExpr": "ucf_avg_slc_rd_bandwidth_local_cpu_to_remote_mem + =
ucf_avg_slc_rd_bandwidth_local_noncpu_to_remote_mem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for l=
ocal CPU and local non-CPU requests to remote memory addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local CPUs and local non-CPU devices such as the GPU and PCIe =
devices for remote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_local_src_to_remote_mem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Remote_Memory;UCF_BW_L=
ocal_Src_To_Remote_Memory",
+        "MetricExpr": "ucf_avg_mem_rd_bandwidth_local_cpu_to_remote_mem + =
ucf_avg_mem_rd_bandwidth_local_noncpu_to_remote_mem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for remo=
te memory, for requests initiated by local CPUs and local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for rem=
ote memory, for requests initiated by local CPUs and local non-CPU devices =
such as the GPU and PCIe devices.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_local_src_to_remote_mem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Remote_Memory;UCF_BW_Loc=
al_Src_To_Remote_Memory",
+        "MetricExpr": "ucf_avg_slc_wr_bandwidth_local_cpu_to_remote_mem + =
ucf_avg_slc_wr_bandwidth_local_noncpu_to_remote_mem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
local CPU and local non-CPU requests to remote memory addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local CPUs and local non-CPU devices such as the GPU and PCIe=
 devices for remote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_local_src_to_remote_mem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Remote_Memory;UCF_BW_L=
ocal_Src_To_Remote_Memory",
+        "MetricExpr": "ucf_avg_mem_wr_bandwidth_local_cpu_to_remote_mem + =
ucf_avg_mem_wr_bandwidth_local_noncpu_to_remote_mem",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for rem=
ote memory, for traffic initiated by local CPUs and local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for re=
mote memory, for traffic initiated by local CPUs and local non-CPU devices =
such as the GPU and PCIe devices. Includes write-backs, attributed as descr=
ibed for UCF_SLC_WB. Data-bearing snoop responses to evictions by a home SL=
C in another socket or a connected GPU's GL2 are not counted (see UCF_SLC_W=
B).",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_local_cpu_to_local_cmem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Local_CPU;UCF_BW_Local_C=
MEM;UCF_BW_Local_CPU_To_Local_CMEM",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_loc_cpu=3D1,dst_loc_cmem=3D1@ =
/ 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for l=
ocal CPU requests to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local CPUs for local CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_local_cpu_to_local_cmem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Local_CPU;UCF_BW_Local=
_CMEM;UCF_BW_Local_CPU_To_Local_CMEM",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_loc_cpu=3D1,dst_loc_cmem=3D1@ =
/ 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l CMEM, for requests initiated by local CPUs.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al CMEM, for requests initiated by local CPUs.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_local_cpu_to_local_cmem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Local_CPU;UCF_BW_Local_C=
MEM;UCF_BW_Local_CPU_To_Local_CMEM",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_loc_cpu=3D1,dst_loc_cmem=3D1@ =
/ 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
local CPU requests to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local CPUs for local CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_local_cpu_to_local_cmem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Local_CPU;UCF_BW_Local=
_CMEM;UCF_BW_Local_CPU_To_Local_CMEM",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_loc_cpu=3D1,dst_loc_cmem=3D1@ =
/ 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al CMEM, for traffic initiated by local CPUs.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal CMEM, for traffic initiated by local CPUs. Includes write-backs, attrib=
uted as described for UCF_SLC_WB.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_local_cpu_to_local_gmem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Local_CPU;UCF_BW_Local_G=
MEM;UCF_BW_Local_CPU_To_Local_GMEM",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_loc_cpu=3D1,dst_loc_gmem=3D1@ =
/ 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for l=
ocal CPU requests to local GMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local CPUs for local GMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_local_cpu_to_local_gmem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Local_CPU;UCF_BW_Local=
_GMEM;UCF_BW_Local_CPU_To_Local_GMEM",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_loc_cpu=3D1,dst_loc_gmem=3D1@ =
/ 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l GMEM, for requests initiated by local CPUs.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al GMEM, for requests initiated by local CPUs.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_local_cpu_to_local_gmem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Local_CPU;UCF_BW_Local_G=
MEM;UCF_BW_Local_CPU_To_Local_GMEM",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_loc_cpu=3D1,dst_loc_gmem=3D1@ =
/ 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
local CPU requests to local GMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local CPUs for local GMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_local_cpu_to_local_gmem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Local_CPU;UCF_BW_Local=
_GMEM;UCF_BW_Local_CPU_To_Local_GMEM",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_loc_cpu=3D1,dst_loc_gmem=3D1@ =
/ 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al GMEM, for traffic initiated by local CPUs.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal GMEM, for traffic initiated by local CPUs. Includes write-backs, attrib=
uted as described for UCF_SLC_WB. Data-bearing snoop responses to evictions=
 by a home SLC in another socket or a connected GPU's GL2 are not counted (=
see UCF_SLC_WB).",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_local_cpu_to_local_cxlmem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Local_CPU;UCF_BW_Local_C=
XLMEM;UCF_BW_Local_CPU_To_Local_CXLMEM",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_loc_cpu=3D1,dst_loc_other=3D1@=
 / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for l=
ocal CPU requests to local CXL memory addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local CPUs for local CXL memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_local_cpu_to_local_cxlmem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Local_CPU;UCF_BW_Local=
_CXLMEM;UCF_BW_Local_CPU_To_Local_CXLMEM",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_loc_cpu=3D1,dst_loc_other=3D1@=
 / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l CXL memory, for requests initiated by local CPUs.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al CXL memory, for requests initiated by local CPUs.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_local_cpu_to_local_cxlmem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Local_CPU;UCF_BW_Local_C=
XLMEM;UCF_BW_Local_CPU_To_Local_CXLMEM",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_loc_cpu=3D1,dst_loc_other=3D1@=
 / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
local CPU requests to local CXL memory addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local CPUs for local CXL memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_local_cpu_to_local_cxlmem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Local_CPU;UCF_BW_Local=
_CXLMEM;UCF_BW_Local_CPU_To_Local_CXLMEM",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_loc_cpu=3D1,dst_loc_other=3D1@=
 / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al CXL memory, for traffic initiated by local CPUs.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal CXL memory, for traffic initiated by local CPUs. Includes write-backs, =
attributed as described for UCF_SLC_WB.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_local_cpu_to_remote_mem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Local_CPU;UCF_BW_Remote_=
Memory;UCF_BW_Local_CPU_To_Remote_Memory",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_loc_cpu=3D1,dst_rem=3D1@ / 1e6=
 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for l=
ocal CPU requests to remote memory addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local CPUs for remote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_local_cpu_to_remote_mem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Local_CPU;UCF_BW_Remot=
e_Memory;UCF_BW_Local_CPU_To_Remote_Memory",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_loc_cpu=3D1,dst_rem=3D1@ / 1e6=
 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for remo=
te memory, for requests initiated by local CPUs.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for rem=
ote memory, for requests initiated by local CPUs.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_local_cpu_to_remote_mem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Local_CPU;UCF_BW_Remote_=
Memory;UCF_BW_Local_CPU_To_Remote_Memory",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_loc_cpu=3D1,dst_rem=3D1@ / 1e6=
 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
local CPU requests to remote memory addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local CPUs for remote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_local_cpu_to_remote_mem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Local_CPU;UCF_BW_Remot=
e_Memory;UCF_BW_Local_CPU_To_Remote_Memory",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_loc_cpu=3D1,dst_rem=3D1@ / 1e6=
 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for rem=
ote memory, for traffic initiated by local CPUs.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for re=
mote memory, for traffic initiated by local CPUs. Includes write-backs, att=
ributed as described for UCF_SLC_WB. Data-bearing snoop responses to evicti=
ons by a home SLC in another socket or a connected GPU's GL2 are not counte=
d (see UCF_SLC_WB).",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_local_noncpu_to_local_cmem=
",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Local_NonCPU;UCF_BW_Loca=
l_CMEM;UCF_BW_Local_NonCPU_To_Local_CMEM",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_loc_noncpu=3D1,dst_loc_cmem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for l=
ocal non-CPU requests to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local non-CPU devices such as the GPU and PCIe devices for loc=
al CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_local_noncpu_to_local_cmem=
",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Local_NonCPU;UCF_BW_Lo=
cal_CMEM;UCF_BW_Local_NonCPU_To_Local_CMEM",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_loc_noncpu=3D1,dst_loc_cmem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l CMEM, for requests initiated by local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al CMEM, for requests initiated by local non-CPU devices such as the GPU an=
d PCIe devices.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_local_noncpu_to_local_cmem=
",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Local_NonCPU;UCF_BW_Loca=
l_CMEM;UCF_BW_Local_NonCPU_To_Local_CMEM",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_loc_noncpu=3D1,dst_loc_cmem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
local non-CPU requests to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local non-CPU devices such as the GPU and PCIe devices for lo=
cal CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_local_noncpu_to_local_cmem=
",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Local_NonCPU;UCF_BW_Lo=
cal_CMEM;UCF_BW_Local_NonCPU_To_Local_CMEM",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_loc_noncpu=3D1,dst_loc_cmem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al CMEM, for traffic initiated by local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal CMEM, for traffic initiated by local non-CPU devices such as the GPU an=
d PCIe devices. Includes write-backs, attributed as described for UCF_SLC_W=
B.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_local_noncpu_to_local_gmem=
",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Local_NonCPU;UCF_BW_Loca=
l_GMEM;UCF_BW_Local_NonCPU_To_Local_GMEM",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_loc_noncpu=3D1,dst_loc_gmem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for l=
ocal non-CPU requests to local GMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local non-CPU devices such as the GPU and PCIe devices for loc=
al GMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_local_noncpu_to_local_gmem=
",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Local_NonCPU;UCF_BW_Lo=
cal_GMEM;UCF_BW_Local_NonCPU_To_Local_GMEM",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_loc_noncpu=3D1,dst_loc_gmem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l GMEM, for requests initiated by local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al GMEM, for requests initiated by local non-CPU devices such as the GPU an=
d PCIe devices.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_local_noncpu_to_local_gmem=
",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Local_NonCPU;UCF_BW_Loca=
l_GMEM;UCF_BW_Local_NonCPU_To_Local_GMEM",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_loc_noncpu=3D1,dst_loc_gmem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
local non-CPU requests to local GMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local non-CPU devices such as the GPU and PCIe devices for lo=
cal GMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_local_noncpu_to_local_gmem=
",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Local_NonCPU;UCF_BW_Lo=
cal_GMEM;UCF_BW_Local_NonCPU_To_Local_GMEM",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_loc_noncpu=3D1,dst_loc_gmem=3D=
1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al GMEM, for traffic initiated by local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal GMEM, for traffic initiated by local non-CPU devices such as the GPU an=
d PCIe devices. Includes write-backs, attributed as described for UCF_SLC_W=
B. Data-bearing snoop responses to evictions by a home SLC in another socke=
t or a connected GPU's GL2 are not counted (see UCF_SLC_WB).",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_local_noncpu_to_local_cxlm=
em",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Local_NonCPU;UCF_BW_Loca=
l_CXLMEM;UCF_BW_Local_NonCPU_To_Local_CXLMEM",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_loc_noncpu=3D1,dst_loc_other=
=3D1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for l=
ocal non-CPU requests to local CXL memory addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local non-CPU devices such as the GPU and PCIe devices for loc=
al CXL memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_local_noncpu_to_local_cxlm=
em",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Local_NonCPU;UCF_BW_Lo=
cal_CXLMEM;UCF_BW_Local_NonCPU_To_Local_CXLMEM",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_loc_noncpu=3D1,dst_loc_other=
=3D1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l CXL memory, for requests initiated by local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al CXL memory, for requests initiated by local non-CPU devices such as the =
GPU and PCIe devices.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_local_noncpu_to_local_cxlm=
em",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Local_NonCPU;UCF_BW_Loca=
l_CXLMEM;UCF_BW_Local_NonCPU_To_Local_CXLMEM",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_loc_noncpu=3D1,dst_loc_other=
=3D1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
local non-CPU requests to local CXL memory addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local non-CPU devices such as the GPU and PCIe devices for lo=
cal CXL memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_local_noncpu_to_local_cxlm=
em",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Local_NonCPU;UCF_BW_Lo=
cal_CXLMEM;UCF_BW_Local_NonCPU_To_Local_CXLMEM",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_loc_noncpu=3D1,dst_loc_other=
=3D1@ / 1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al CXL memory, for traffic initiated by local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal CXL memory, for traffic initiated by local non-CPU devices such as the =
GPU and PCIe devices. Includes write-backs, attributed as described for UCF=
_SLC_WB.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_local_noncpu_to_remote_mem=
",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Local_NonCPU;UCF_BW_Remo=
te_Memory;UCF_BW_Local_NonCPU_To_Remote_Memory",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_loc_noncpu=3D1,dst_rem=3D1@ / =
1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for l=
ocal non-CPU requests to remote memory addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from local non-CPU devices such as the GPU and PCIe devices for rem=
ote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_local_noncpu_to_remote_mem=
",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Local_NonCPU;UCF_BW_Re=
mote_Memory;UCF_BW_Local_NonCPU_To_Remote_Memory",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_loc_noncpu=3D1,dst_rem=3D1@ / =
1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for remo=
te memory, for requests initiated by local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for rem=
ote memory, for requests initiated by local non-CPU devices such as the GPU=
 and PCIe devices.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_local_noncpu_to_remote_mem=
",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Local_NonCPU;UCF_BW_Remo=
te_Memory;UCF_BW_Local_NonCPU_To_Remote_Memory",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_loc_noncpu=3D1,dst_rem=3D1@ / =
1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
local non-CPU requests to remote memory addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from local non-CPU devices such as the GPU and PCIe devices for re=
mote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_local_noncpu_to_remote_mem=
",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Local_NonCPU;UCF_BW_Re=
mote_Memory;UCF_BW_Local_NonCPU_To_Remote_Memory",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_loc_noncpu=3D1,dst_rem=3D1@ / =
1e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for rem=
ote memory, for traffic initiated by local non-CPU devices.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for re=
mote memory, for traffic initiated by local non-CPU devices such as the GPU=
 and PCIe devices. Includes write-backs, attributed as described for UCF_SL=
C_WB. Data-bearing snoop responses to evictions by a home SLC in another so=
cket or a connected GPU's GL2 are not counted (see UCF_SLC_WB).",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_remote_to_local_cmem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Remote_Source;UCF_BW_Loc=
al_CMEM;UCF_BW_Remote_To_Local_CMEM",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_rem=3D1,dst_loc_cmem=3D1@ / 1e=
6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for r=
emote-socket requests to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from a remote socket for local CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_remote_to_local_cmem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Remote_Source;UCF_BW_L=
ocal_CMEM;UCF_BW_Remote_To_Local_CMEM",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_rem=3D1,dst_loc_cmem=3D1@ / 1e=
6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l CMEM, for requests initiated by a remote socket.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al CMEM, for requests initiated by a remote socket.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_remote_to_local_cmem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Remote_Source;UCF_BW_Loc=
al_CMEM;UCF_BW_Remote_To_Local_CMEM",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_rem=3D1,dst_loc_cmem=3D1@ / 1e=
6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
remote-socket requests to local CMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from a remote socket for local CMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_remote_to_local_cmem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Remote_Source;UCF_BW_L=
ocal_CMEM;UCF_BW_Remote_To_Local_CMEM",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_rem=3D1,dst_loc_cmem=3D1@ / 1e=
6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al CMEM, for traffic initiated by a remote socket.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal CMEM, for traffic initiated by a remote socket. Includes write-backs, a=
ttributed as described for UCF_SLC_WB.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_remote_to_local_gmem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Remote_Source;UCF_BW_Loc=
al_GMEM;UCF_BW_Remote_To_Local_GMEM",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_rem=3D1,dst_loc_gmem=3D1@ / 1e=
6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for r=
emote-socket requests to local GMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from a remote socket for local GMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_remote_to_local_gmem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Remote_Source;UCF_BW_L=
ocal_GMEM;UCF_BW_Remote_To_Local_GMEM",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_rem=3D1,dst_loc_gmem=3D1@ / 1e=
6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l GMEM, for requests initiated by a remote socket.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al GMEM, for requests initiated by a remote socket.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_remote_to_local_gmem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Remote_Source;UCF_BW_Loc=
al_GMEM;UCF_BW_Remote_To_Local_GMEM",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_rem=3D1,dst_loc_gmem=3D1@ / 1e=
6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
remote-socket requests to local GMEM addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from a remote socket for local GMEM addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_remote_to_local_gmem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Remote_Source;UCF_BW_L=
ocal_GMEM;UCF_BW_Remote_To_Local_GMEM",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_rem=3D1,dst_loc_gmem=3D1@ / 1e=
6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al GMEM, for traffic initiated by a remote socket.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal GMEM, for traffic initiated by a remote socket. Includes write-backs, a=
ttributed as described for UCF_SLC_WB. Data-bearing snoop responses to evic=
tions by a home SLC in another socket or a connected GPU's GL2 are not coun=
ted (see UCF_SLC_WB).",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_remote_to_local_cxlmem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Remote_Source;UCF_BW_Loc=
al_CXLMEM;UCF_BW_Remote_To_Local_CXLMEM",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_rem=3D1,dst_loc_other=3D1@ / 1=
e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for r=
emote-socket requests to local CXL memory addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from a remote socket for local CXL memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_remote_to_local_cxlmem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Remote_Source;UCF_BW_L=
ocal_CXLMEM;UCF_BW_Remote_To_Local_CXLMEM",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_rem=3D1,dst_loc_other=3D1@ / 1=
e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for loca=
l CXL memory, for requests initiated by a remote socket.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for loc=
al CXL memory, for requests initiated by a remote socket.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_remote_to_local_cxlmem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Remote_Source;UCF_BW_Loc=
al_CXLMEM;UCF_BW_Remote_To_Local_CXLMEM",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_rem=3D1,dst_loc_other=3D1@ / 1=
e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
remote-socket requests to local CXL memory addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from a remote socket for local CXL memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_remote_to_local_cxlmem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Remote_Source;UCF_BW_L=
ocal_CXLMEM;UCF_BW_Remote_To_Local_CXLMEM",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_rem=3D1,dst_loc_other=3D1@ / 1=
e6 / duration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for loc=
al CXL memory, for traffic initiated by a remote socket.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for lo=
cal CXL memory, for traffic initiated by a remote socket. Includes write-ba=
cks, attributed as described for UCF_SLC_WB.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_rd_bandwidth_remote_to_remote_mem",
+        "MetricGroup": "UCF_BW_Upstream_RD;UCF_BW_Remote_Source;UCF_BW_Rem=
ote_Memory;UCF_BW_Remote_To_Remote_Memory",
+        "MetricExpr": "UCF_SLC_BYTES_RD@src_rem=3D1,dst_rem=3D1@ / 1e6 / d=
uration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC read bandwidth for r=
emote-socket requests to remote memory addresses.",
+        "PublicDescription": "Average requester-to-SLC read bandwidth of r=
equests from a remote socket for remote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_rd_bandwidth_remote_to_remote_mem",
+        "MetricGroup": "UCF_BW_Downstream_RD;UCF_BW_Remote_Source;UCF_BW_R=
emote_Memory;UCF_BW_Remote_To_Remote_Memory",
+        "MetricExpr": "UCF_MEM_BYTES_RD@src_rem=3D1,dst_rem=3D1@ / 1e6 / d=
uration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory read bandwidth for remo=
te memory, for requests initiated by a remote socket.",
+        "PublicDescription": "Average SLC-to-memory read bandwidth for rem=
ote memory, for requests initiated by a remote socket.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_slc_wr_bandwidth_remote_to_remote_mem",
+        "MetricGroup": "UCF_BW_Upstream_WR;UCF_BW_Remote_Source;UCF_BW_Rem=
ote_Memory;UCF_BW_Remote_To_Remote_Memory",
+        "MetricExpr": "UCF_SLC_BYTES_WR@src_rem=3D1,dst_rem=3D1@ / 1e6 / d=
uration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average requester-to-SLC write bandwidth for =
remote-socket requests to remote memory addresses.",
+        "PublicDescription": "Average requester-to-SLC write bandwidth of =
requests from a remote socket for remote memory addresses.",
+        "Unit": "nvidia_ucf_pmu_"
+    },
+    {
+        "MetricName": "ucf_avg_mem_wr_bandwidth_remote_to_remote_mem",
+        "MetricGroup": "UCF_BW_Downstream_WR;UCF_BW_Remote_Source;UCF_BW_R=
emote_Memory;UCF_BW_Remote_To_Remote_Memory",
+        "MetricExpr": "UCF_MEM_BYTES_WR@src_rem=3D1,dst_rem=3D1@ / 1e6 / d=
uration_time",
+        "ScaleUnit": "1MB/s",
+        "BriefDescription": "Average SLC-to-memory write bandwidth for rem=
ote memory, for traffic initiated by a remote socket.",
+        "PublicDescription": "Average SLC-to-memory write bandwidth for re=
mote memory, for traffic initiated by a remote socket. Includes write-backs=
, attributed as described for UCF_SLC_WB. Data-bearing snoop responses to e=
victions by a home SLC in another socket or a connected GPU's GL2 are not c=
ounted (see UCF_SLC_WB).",
+        "Unit": "nvidia_ucf_pmu_"
+    }
+]
--=20
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792428286;
	b=gmSHOF7jL3hjr3P7Xu/PL1aBYtVCdqlruI2pgshx2/eue+mxngjnXeigWnQc3Bsa7KGw
	 6JPpMCYkaIngC6SCJV3GH6XxnBYKLAslnxA62Co+I5mRNfmcMeoTplulwqeKNMJZyBgkL
	 EMUGI3awUZSa53AQoJ1m67IM+QXPbQk4d0jfUDvuzvSBtPjLAeVUZhRGDRWNeEJTIrynk
	 lkHcxvr3pO6Ezd7YIEA1Cjq95ufsSBhYA+TanmaStpRqs7Wc5xjku1ghF3zv3UWA1CdHG
	 ijKOR6HpLq3RuJV9XyJemPG/7uNKnn4FD2AqVAWJ28dMUFwf1nnyBVwuEXDUEhBMYdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428286;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PAv2C5jbUFRj2qr2qF5L3NjdXGU3iGt2kdM76KAKBpA=;
	b=c33hWcikXFsvVNQ5jB8eBP+A4Pw79sJDgaiLTpenfN0NNSXHfqlPyXJS5MphltGDPXm9
	 cpP9IXlt4N0akWbN+H5lbYQF6ambZmTEoG5IfsjWpMGJMk8NVaQCOkB5X2KzgTQxrAFGn
	 fCsVdinJMjfdvfOuTGRlojwj8KVg7tYbmcueG4CK07RWzTGfSKf4cf/lOY8zjIbNzp2dV
	 QEIk6MBXVMnPZBari0uHEAy88+ByNracFkyKuCGp4JoB0tbufB4BsDf21+sSMtEAya6QP
	 FnL/bszSj/ssErGC3jEl/eR9yy7DdY4B5MH6tlczB6LNZJ7ZXzqC7hCXnidntptRGig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i30Qf4F0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.31
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F9606A325;
	Mon, 19 Oct 2026 16:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F6F9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i30Qf4F0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQfAZ4OwuzruXFbCs9OMmK2IrCF0sE1+j3ZCEkfo/QPVHkfXHVsQKUSL34ri4jbFxeH6InYCz/nKIJkiVUpaiqE7hVwTmPIVYNZgG6JDLc03jT+jJoKCzhz3VPMNNMxvV9mUsanWJryGtq8AZCcloZnNU7njr7mrwUKwGPUGvEbIbymVYIu9kUlevz/pBuKIyBnmT3TUdvqdyU/nG3mWXUe8SCqcxjbwvDkOXVRZV7dNyL62jX45a3Wxtf+fSN7QgkDU9eDeq0t3DLN/lS/9A43QitwiDMNLNeJ3BU3/FXmbyl4/xuNbd3d20voAo0OYPwSbUqiVLb+SmSj3Ncu6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAv2C5jbUFRj2qr2qF5L3NjdXGU3iGt2kdM76KAKBpA=;
 b=BjBqDStz9xwMI/jEN2/jYX6ZyG5hiR4pvJ44H35l61d4EXt/arrz4hYwAsxaSpjs/szREtdUfomYCDaZnekiP9dOHhDDthngwwBQ9A1dxxrGExn9NIajXWXhuP9gVbjdxo+2Y4329Wy2Fke6mD8k4ZwOTbGkBDhSoCmAJ8gDoupH45rxXSPulGj2BH+sEruerORudCqAvmgXrR0ARlkZq4oREXYjrvMLxTOLAK+Eh3SP4c/gGWgGyk1iWSBf8b/mFnoQydN7C+3wquRqzYudx2rzkixAF/ivQe3DlDqvqpAxOgAKjhlFKPehDu9sUA0JKVvzvC8qvPmibw0/ypt5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAv2C5jbUFRj2qr2qF5L3NjdXGU3iGt2kdM76KAKBpA=;
 b=i30Qf4F0uC//lv5cnwzWkrrusBJzGVxLKbYSxAmFMy83/UaINm6gO+I2vjjSXlTjXvblkVRJU6dHvUhf+o/DaVh0Rwery5wnsBOx36z5v4u6ENAYvYdmkN5hUeVSkhBqMccWkmcbnrHxAyASvED5cziBBboMFZau7e7Sx3tYM6fUH0p1SIbXSM0Thpy0d16WRSC1RTBHyToS8BQEl/KFYIxPn8LxUI450A8AfhdefZ7YgqfZluO4+Do9iqCvldg/ubY++LvYcK+TZFs6tf6rzZ6UeOcNRT8jhpS8W/PYTJt6DijOohSf1uSZGfjLlpPRVBe8v72Utdnlkn80kiNOxw==
Received: from PH8P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::11)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 16:43:34 +0000
Received: from PH2PEPF00048913.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::30) by PH8P220CA0010.outlook.office365.com
 (2603:10b6:510:345::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Mon,
 19 Oct 2026 16:43:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH2PEPF00048913.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:43:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 19 Oct
 2026 09:43:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 19 Oct
 2026 09:43:12 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 19 Oct 2026 09:43:12 -0700
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
Subject: [PATCH 0/6] perf jevents: Add NVIDIA Tegra410 uncore PMU events and metrics
Date: Mon, 19 Oct 2026 16:42:35 +0000
Message-ID: <20261019164241.403644-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: PH2PEPF00048913:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd2b916-21e0-42ba-c4e4-08df2e001d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	S0G0+uUcay/Yjgf7e6VoADwFqdxaqbM2gSXg0OFA57hFNFbH8mHDoUHIENJN+t1Q9t0wroW5oNLE7ul2oFt1RvF4IrP6wAgG0YuvSFo4jq3PLa5C9MjlImv+K1kIoYCiNVmBuMFVWw6mqVEjm8zGrQZSNPMKVRk2FtSRJ+OzKALN4B/eJMR+vgHd4g35VtRJUXS494yujuDwp7zu8f8hbDB61MGpBEU8ucX/1riPfdoEcMPsqXR57073zB/MBWboenSubUSoJVZuYxUA6PjzSzeKwUpbltMT2aMIG8RkCVTWqJWT77FwhHPlIemOFiaZNJglJgqA080KueEav2kBXVVXKRQwW8yP7o0B2AqablBdydRcCyjfwr/R6V8tm5FFlKb6qpTu2ps8/sd2s+1AxStv/79MClz3ELDCTx0r17disbUqOeZEMx1BaNrXhXUo5qUyjGysi2fA81mByD0kbepm2tF8Ed11YwtjAuI+9k9jGyKapsVv00J13GniZ41bP9Q5y7It6viE/V1bpDtqjL5cfni+Svt5GWXeleHs2oW1IOTJGnPt4vRuN+CRpplR3AJ7a3HZsUQMhAVD00Sjbn0q7DUvgbOr+j1BmW8gwdd74ZvyoT2bJRZIB65ZnP7wX9YHORs2K0o+pPXa+NOCJJFhf0MBWAFBfbL6LhhL/8CbalCeo+OAfMGsl8h5ApOjCs9KhtzYw11LpK6joGKBNw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mOo7bpOlTquEXmdcLKT8gStLe63Zdb3mj1+QYoyOfy54oGxt4gmNvlXJWl064oBja69T8r9T4PuqIUPA/x4rOSAqlXI1Yfw9NT2FJS3cKss2qyI13OzYVytM5YzfI/QLwmEJu+46bqHlgHDBO8mcnXbQxi5ED7jeKgtq9H6B0/dxAJIn7z8piri+7YkdwpKVWcgTtVhh7HGD1u8UC/y+8nwo0OvavYSZ/rlin6jm+bsClvzmW7df675vafXPhgcmIAlXNEwzADJNPm4v6+eYuGblQraIZgPnRmQQt+xEw/V0h4U+7iJhQk0B2sYsGShfdA0iRjAgtDIPykJCpEu0yEN7k4BpZzxlf5ij7FRpup8CbxrcmhHie4s3VCFZTnchINZZ/h931Pr5Hur6FjeBitYe/zfmld+od/OEXETHTHmGqZtOYdH5/ZVKtsIurh8P
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:43:33.6673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd2b916-21e0-42ba-c4e4-08df2e001d5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH2PEPF00048913.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

Add event aliases and derived metrics for the NVIDIA Tegra410 uncore
PMUs.

The series covers the UCF, PCIe, PCIe target, CPU memory latency, and
chip-to-chip interconnect PMUs. It provides symbolic names for the raw
event encodings and metrics for bandwidth, frequency, and average read
latency.

Patch 1 fixes a jevents ordering problem found with this layout: the
uncore events live in arch/arm64/nvidia/t410/sys/, next to the T410 core
events, and without the fix jevents puts the core tlb.json (which sorts
after "sys") into the sys table, so its events are lost from perf list
and perf stat.

Besar Wicaksono (6):
  perf jevents: Process model files before sys subdirectories
  perf jevents: Add support for NVIDIA Tegra410 UCF PMU aliasing
  perf jevents: Add support for NVIDIA Tegra410 PCIE PMU aliasing
  perf jevents: Add support for NVIDIA Tegra410 PCIE-TGT PMU aliasing
  perf jevents: Add support for NVIDIA Tegra410 CPU Memory Latency PMU
    aliasing
  perf jevents: Add support for NVIDIA Tegra410 C2C PMU aliasing

 .../arm64/nvidia/t410/sys/uncore-cpu_mem.json |  48 ++
 .../arm64/nvidia/t410/sys/uncore-nvclink.json |  75 ++
 .../arm64/nvidia/t410/sys/uncore-nvdlink.json |  48 ++
 .../nvidia/t410/sys/uncore-nvlink_c2c.json    | 129 ++++
 .../arm64/nvidia/t410/sys/uncore-pcie.json    | 247 +++++++
 .../nvidia/t410/sys/uncore-pcie_tgt.json      |  93 +++
 .../arm64/nvidia/t410/sys/uncore-ucf.json     | 693 ++++++++++++++++++
 tools/perf/pmu-events/jevents.py              |   4 +-
 8 files changed, 1336 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-cpu_mem.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvclink.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvdlink.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvlink_c2c.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-ucf.json

-- 
2.43.0


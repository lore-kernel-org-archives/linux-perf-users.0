Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793382544;
	b=tGGIHZo40mi/shHtARVQLWR1PTa8fh9Lu79M5XGRxPRwVKDifCqG56zykW6g0C0gSntJ
	 15HQBEpSyTHtbcshalUTA+uq3ZfeABmcXRIkGnzVzN4TRpeUEBjs43AE1tVz8jiL20I3T
	 lYHp9q1PZSCtiNZnsFGJ1Nkb++7ryetHJKnUhmcXwM8APqwPKfq6UIi01C6hjONKOWHNz
	 kT7hZM2mXrXY/c3Rfu5/E2nIpYM//9bezK8of9B45ofCEHLigwMHAr4FvIKbK6UaRUdb7
	 FftQOXQeePHlQ33lSykAF9xJcdFunrGTHG7L3G4Br6y2jd1nJ9wEWxoG7hNv/woXT/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382544;
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
	bh=oEUkhLQ9hiwnAz7jBimcklLa0OaqWnfTgyZa3o1XbJ4=;
	b=5fQeLz/OMOxj1wXl/tr8qXTjeMDrTkQmrAv626cpx8F9suHZSlkJ7NTfFlsO5px/ZUyh
	 RzukdvAeTisRiAGGj+nMaQZgn0ssSnlw8LAFA9JeOJSYd8r2OHYwSC3Boz5DYf/+cI+HC
	 qVtICuvEqMdfkYntWGG6O4ryflmwl+TX+UwKufP8kXhtfWxGGi0SfNmlLiEcMdVik5OU2
	 gxBFaeryy2CV9S8cij/+tn1eLVAH45SyTgvlMzeV8tbzsp976tgRy7MJT7RvTldHsx21d
	 NV4zJpsWpdkzOsCiiQlBn4wE+btRc3u65zQLvi6RSvXwJeu240hzrHfySD3bffUQjtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=flNDkKyH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.39
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B15606A31C;
	Fri, 30 Oct 2026 17:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B15606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=flNDkKyH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWu6VpoiQh72N+ZUwMI+0nC/JSVyC+PSVYEkGSIjq0F9rJFyRue65ev2mfPBNzjQWibFze1zqCIgr+LdBiObK5CmJ0MpRcncRMRkdeTG+FQXqczpU6QXz/n2rJFoSYlKH4o3xVG6QV7VPMJOmnQPyXCRhZ1mao/UddJj7r3qq58sdGdsUQ0NXQYkj/0X/Q1CwDqKVnqlWTmuSjROfN2kYNgdrSnweABy4hKNDeY+D9YR7+juLbV1u2TzRlPkvZjYjoAKqftW69B7q2ng3f6OrX+dHGPrqr1RWzYJ2Jzkqx/1sCgRTI66FCZwSf7HKxAf4YQHlu4xIaF+yvbYRRDo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEUkhLQ9hiwnAz7jBimcklLa0OaqWnfTgyZa3o1XbJ4=;
 b=cjPMA2Sl5a7G0DjpbJLxVmpCwQe6UCcNYnzoiWvrcLctr94J4wMejGaGoiUxyAHVTJMAd1HUWzZrJzwJF4YiL8iV2C7TM32z01/NQiZI62afNETNiEJIGlJfyUTkZWO4Zs7nfidcC0zLtDSwuM0DxJyUHVTqCTKYuncZUPSnc/KWbsPGw336601jRmlbyO9EqBXZUgTLNOHP31U5eCPaNjcm70EXwPGG55iBgHXThBUyY2gOKLjCkXID64Vo2Gz0HvQmWbGAhr3Xb2+C5x+FIrn+l0eXAvJaD74Q8+4jM8Ce5QoeHlhz159AKjZWYK4WoX4bGDWd689TSUigOLFCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEUkhLQ9hiwnAz7jBimcklLa0OaqWnfTgyZa3o1XbJ4=;
 b=flNDkKyHuOBlX8wunqTPjcflGW8QkJSopoYt6/T/GaBTn7wdyBbdTZ/VFi7j1EKym1IjdbalQRS4YcvhMZvZ1uYxVlroqfOJaC/yh/yhNjALh/4HSd2xExP57/f0IfTQ68nYN2eKrNgyNYyApHlZReBD0bE+u1mzYpywYPZzOg9pspfYvvxNaXzXfmDvQJ0UC5EcCim4TSCykPZJ2jivpIFQdF2l9/YYLm5rOrbUteRMwOEEhEd0w0GDEBRvFoddeAM8YFu7n8btMInYwbXO2T0jX09gdEB9V9MXhlmygots1zzPCpE1S0pVOz68MmonC2sRkIjPliXcx6as6xFOfA==
Received: from BN0PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:e8::32)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:48:50 +0000
Received: from IA0PEPF00000045.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::7a) by BN0PR04CA0057.outlook.office365.com
 (2603:10b6:408:e8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 17:48:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 IA0PEPF00000045.mail.protection.outlook.com (10.167.249.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 17:48:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:48:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:48:25 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Fri, 30 Oct 2026 10:48:25 -0700
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
Subject: [PATCH v2 0/9] perf: Add NVIDIA Tegra410 uncore PMU events and metrics
Date: Fri, 30 Oct 2026 17:48:07 +0000
Message-ID: <20261030174816.1544471-1-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000045:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 898c4bba-39e3-4a93-9843-08df36ae0e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|6133799003|18002099003|3023799007|56012099006|11063799006|5023799004|261026140227099003|261026121527099003|261028144727099003|261021123027099003|10067099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	fqrKS87C3uko3V2qhx4sdRbGZLOjREOwyrIcCjmn/ONS5Qg2Q3XiHKtwm21DuOP9hn+3f2jzryPcn0/pYv9MNbLOsomGaNM8Nzk/CD4XpJ/L88q0o5hDezm3qU3P7u1tzTmv2wKEvD/HMYo3+KsFwGXkPdIDzCoguwrvJlW9Evo9fzZAbKY8aC+jKizdzrJTkw/jGoK/1mtk+MwDvzDP1+u2+rkRYxLDKe4gFkJFr0EeM9vwqhqjajGZBeaBK3c+5aGcwZaCJxg2OW6/4D76Mq9geGoiXEeQOT976hayYELO83/bTs2DGgx3+CoRnpyw24mISGPDn85v6T4IjrZopmpnleyMZxkw5Q/sMo6t3NyMXOsM/WJJbI6rZ+NIoL2k1oXhCQ5UmOmlRpZRA0BZgThX52S5l8KwHZvBsOenzoLEnV5X7lAoKjQLAHbpdWmwjq7LMh7mjFxkeD9N/tvJUmD/CsCqGMuPVGWgwB76aV+QY/cGCJVA5p8mOQw6aFrz72Bguj5brp+KEuYvX4U2KAMaXtR8LiIWCjQRhGoht6O1/3n1AbTir9f7xz7elDsZ/tT0+sm+rtpntuUJ8rEVwXcEEGvtmuev1eLO7oPtTciocXeMiA+M80Zq3rDIR2+8EqV8sjkPFKGpgPrAL6+jZMzhlqh8/ursFSUxmpWnGHNw0Zoja9kuSG6lW5gxdZGuLLg7K9Kr5+bUvXzZon6QKQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006)(5023799004)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(10067099003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NOzfKPdrYR8C0OTUbsCPGZ2oaVToUxW/P4+O4GYLiWRug6WxJRLeZknswAmkbWhG3AZL4bNCaYGNcfdFI5zP/PdoZzl5mlkmgybzsrsiwakZ+5/ems7Jts54JET0OsF24GqCpKQWIs4aWL53l1vgusBoo9p8jZGmDovTC5Alj25ufpi6zvYbtH/497veUJHkTLC0/Bi2Tch/3v5M66q+ddsuIDj95Ye+ee9HzkBkoY7xXs7JOjl2bLcMSiGv7xoYitloF4tMX21tp4Qz6egQgac7sxB6TfxGedj4bDPVVuqhKJCv0y2xBDFvwyEhMuMDYcqw5GddLmOe2+ClQuqkm807Ud7sUeaOjca4XtXXXeSQEQlQB4Wk/7g8wHLYwkpK3BV9s7rVLHws6mVyJAQzmCcs/7DD1tY2zFxndRm5dB5/Jea36KDLcYciYAgLndhE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:48:50.1338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898c4bba-39e3-4a93-9843-08df36ae0e5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000045.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

Add event aliases and derived metrics for the NVIDIA Tegra410 uncore
PMUs, and fix perf's aggregation of PMU instances that are numbered in
more than one parts in their name.

The series covers the UCF, PCIe, PCIe target, CPU memory latency, and
chip-to-chip interconnect PMUs. It provides symbolic names for the raw
event encodings and metrics for bandwidth, frequency, and average read
latency.

The PCIe and PCIe target PMUs are named nvidia_pcie_pmu_<socket>_rc_<rc>
and nvidia_pcie_tgt_pmu_<socket>_rc_<rc>. Their json Unit uses the
existing comma-separated form ("nvidia_pcie_pmu_,rc_"), but perf only
merged instances that differ in the trailing number, so these events and
metrics gave one result per socket and were reported incorrectly (e.g.
with --metric-only), as discussed in v1. Patches 6-9 fix this:

- Patch 6 adds a check of the cpumasks of all merged PMU instances to the
  zero-count skip in perf stat, so a socket that counts nothing shows 0
  instead of having its row hidden.
- Patch 7 merges PMU instances that match the same comma-separated json
  Unit. This also applies to the HiSilicon hisi_sccl PMUs, which use the
  same json form; not tested on HiSilicon hardware.
- Patch 8 labels a merged uncore counter after all of its PMUs, e.g.
  nvidia_pcie_pmu_*_rc_*/cycles/ or nvidia_ucf_pmu/cycles/, instead of
  after the first instance, such as nvidia_pcie_pmu_0_rc_0/cycles/.
  Output with --no-aggr is unchanged.
- Patch 9 describes these PMU names in the ABI document.

Changes in v2:
- Move the uncore JSON out of the sys directory and remove the
  "Compat" fields. Thanks to Ian Rogers for the feedback.
- Drop "perf jevents: Process model files before sys subdirectories",
  which this series no longer needs.
- Add UCF SLC and memory bandwidth metrics from all sources to local
  CMEM (read, write and read+write) and from local sources to local
  CMEM and to remote memory, PCIe bandwidth metrics to local
  destinations, and read+write bandwidth metrics for UCF SLC, UCF
  memory and PCIe. Thanks to Chun-Tse Shao for the suggestion.
- Add patches 6-9 to fix the PCIe instance aggregation. Thanks to Ian
  Rogers and Chun-Tse Shao for the pointers.

v1: https://lore.kernel.org/all/20261019164241.403644-1-bwicaksono@nvidia.com/

Besar Wicaksono (9):
  perf jevents: Add support for NVIDIA Tegra410 UCF PMU aliasing
  perf jevents: Add support for NVIDIA Tegra410 PCIE PMU aliasing
  perf jevents: Add support for NVIDIA Tegra410 PCIE-TGT PMU aliasing
  perf jevents: Add support for NVIDIA Tegra410 CPU Memory Latency PMU
    aliasing
  perf jevents: Add support for NVIDIA Tegra410 C2C PMU aliasing
  perf stat: Check merged PMU instance's cpumasks when skipping zero
    counts
  perf pmu: Merge PMU instances that match the same comma-separated json
    Unit
  perf evsel: Name a merged uncore counter after all of its PMUs
  perf Documentation: Describe PMU names numbered in more than one place

 .../testing/sysfs-bus-event_source-devices    |  14 +
 .../arm64/nvidia/t410/uncore-cpu_mem.json     |  43 +
 .../arm64/nvidia/t410/uncore-nvclink.json     |  67 ++
 .../arm64/nvidia/t410/uncore-nvdlink.json     |  43 +
 .../arm64/nvidia/t410/uncore-nvlink_c2c.json  | 115 +++
 .../arch/arm64/nvidia/t410/uncore-pcie.json   | 249 ++++++
 .../arm64/nvidia/t410/uncore-pcie_tgt.json    |  83 ++
 .../arch/arm64/nvidia/t410/uncore-ucf.json    | 764 ++++++++++++++++++
 tools/perf/tests/pmu.c                        | 134 +++
 tools/perf/util/evlist.c                      |   2 +-
 tools/perf/util/evsel.c                       |  83 +-
 tools/perf/util/evsel.h                       |   2 +-
 tools/perf/util/parse-events.c                |   2 +-
 tools/perf/util/pmu.c                         |  65 ++
 tools/perf/util/pmu.h                         |   9 +
 tools/perf/util/pmus.c                        |  47 ++
 tools/perf/util/pmus.h                        |   1 +
 tools/perf/util/stat-display.c                |  20 +
 18 files changed, 1737 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-cpu_mem.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvclink.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvdlink.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvlink_c2c.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie_tgt.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-ucf.json

-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808481;
	b=AVBz02/sLkVZgwhRgdcyGMeFMwxD1yK4kfA9mNKOwrAIhl+Q9zgKRSIuo4pNpC5wbSj3
	 l+BCAPrQzAPz3cIWUF5DVgeDWgV6gICLiPMRsu4ZcliU5hlVQdWWho5GW3MyubzBptUQF
	 33aKYzb9Vxr802sy4+y11lrm9yq8PmLp16a49JkR/WCMVowpHBDJTXDdjubMsz1u0RQ3l
	 WeSI8CmxSDtX/Gug2f4zNK2bwxW61v8wFSuYgjFNg4Rrjt0K1LfsNHrpIRkvdsupIAXZT
	 IfuQmfi5ZVDRtD7cYZiAQqJwg3EKvIWUoPZLeKJhK6kFCjv5MBP391YlebjgXorkkxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808481;
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
	bh=s2fEH/wxEuoGYvwcDbZc1Q0HCduy5caX2JlssWH0y1Y=;
	b=KwPPEc/pe6iukhV/fWkp9ulsqTh6jE5bb9+ZNJUVtydTTBmewoK2qBudfMHVRdMk7nrS
	 aeuzSFC4BNKGxnyfTySa/XWfeFb6L7y1DR3HVmSA/67LNIA21lE5zggMRF5e58CsM9IA0
	 lU0a9oWgpYHGvdONIU8ec0yVoaBWY8tyjZURfP8ORNlxuq7Ye3kt8BBym9W5O/V0uu6XU
	 D35scc1MvmRcbSk3IOqj4XFkjzggF8m5q35pTQTcg75dJzROEkURwtcL/fpItXxHfslGs
	 Z429GmwBGF4FEEZWMVKkUrL3jipQp9dQdOk8VR8gbgvom7QxBkTC/9PrlduzttqXAKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qWjx2hVR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.71
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E4606A332;
	Wed,  4 Nov 2026 16:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C2E4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qWjx2hVR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGAubwkwMwSrNgNR6PADkPRbB4IuSH71AFbKKmsQzsOZpiZdbw2dqc26+gJohgC7Tqykh/M7GdVK01ibXHQl9tOL8fiL3apPh7Icn/WAoMjzwKeOg/iMiiKVqUbztkhxuLls+6pg3S2ZUw8YTQ6CutFBmSAmeC6lZ2/fCd3Om+3PRPNZRmbWPusOnHnzI35erSUZI5+TPnPYfPtCqIzjXEWOHpkuzOuEyejYP1GNK//x0t77Q+KzUcCEdvWZb4zjDurAWYZ5hdyxR8VClRo3IN4xOTDdQ+37aF/agucytO9rRMBUqgKqxyEI6hgKkonJ6VcpVWJN2uxgq1sxkOltzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2fEH/wxEuoGYvwcDbZc1Q0HCduy5caX2JlssWH0y1Y=;
 b=Za2uqPIamnOtbKM3mF2T++PCvRFrp3Y11K+rMDCbWhma9Nv+7mA/3oxLVjPdzndsS01f3/vbeeVWnP2Y1l8sL7e0+A0edi+wwyPHG76jLE6JTookcnTMmZJZHoLd1cnMle2O5PHjUGltbLJGflaZKX07niemidsJcbwWLyMN947HVgnNnIBB89aImQX0KpM57zUS9kMw+mDZt2FNBSO7Y8AoNlMM0H/XpwpWONZRBbHOJ+pZEEqSFyjV4RVfJl+6QbLsgwQYTJVN9O9gQTfahBCWnEMHvtJVCt8kFAipl+VBy1sW2J1pUKMYgzCmrChZdc39GaS3078tBQ4VmRmRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2fEH/wxEuoGYvwcDbZc1Q0HCduy5caX2JlssWH0y1Y=;
 b=qWjx2hVRgrdF8OuJgzta8gJB0/HDjtLLOeVZJlh6Qi1y/ip1/EvfL1Kf9NpkGq7q2FVHDXt70WO9N7JnzEi2ReTa/5X1bHgeEMgV3YekgexfkmscvBFVTlkSbath4m0e5cXzaVZK4CZ++eBCVn+W6zeMBeA7HIJoWmwr0P6eb6zfm1IUCv3RhcYxD/COLa56iZ3+TmmKBG6yd9TAJlCC7VxFshYH52zwAfI/6u2YUMgLgGroU99/KqWBLyu/ZC4obMgxILOWSz+4aJTUzOBZyS27kjXgkUP9zgqT5FOIY+yXbY8oudKyhnpo+XLV+dbE6zIdLp42NLo9lyUzIMABTA==
Received: from DS1PR02CA0017.namprd02.prod.outlook.com (2603:10b6:8:44a::12)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:07:57 +0000
Received: from CY4PEPF000392DC.namprd03.prod.outlook.com
 (2603:10b6:8:44a:cafe::86) by DS1PR02CA0017.outlook.office365.com
 (2603:10b6:8:44a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Wed, 4
 Nov 2026 16:07:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392DC.mail.protection.outlook.com (10.167.247.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 16:07:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:07:34 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:07:34 -0800
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via
 Frontend Transport; Wed, 4 Nov 2026 08:07:32 -0800
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
Subject: [PATCH v3 0/7] perf: Add NVIDIA Tegra410 uncore PMU events and metrics
Date: Wed, 4 Nov 2026 16:07:09 +0000
Message-ID: <20261104160716.2910873-1-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DC:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d17350c-06ff-49e5-d271-08df3a8dca69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|6133799003|10067099003|18002099003|5023799004|11063799006|261022105027099003|261026140227099003|261102123227099003|261028144727099003|261026121527099003|261021121427099003|56012099006|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	cL2rTDcn4HwMu7CFwOlmcYq0/21J1C1SKeYRFnX5hNFM+AZMMAXkQS+VJXiyUAMpG720JpAYLOrqT8Zsk/EZ4WyiLY/b7TnfPoA5c2xE9sS2Oh4WMBPh1KZvyFTMMF9QkSkLoamRsndDRv8YlN3HP8Wz8/eQOSNY9am/NM6TjV5s3weoMeTnnOzRZ4f5ovSuKARlS+3CkJRX/Iah+7fhA17V8LEdQoHy2E/8LEPIxxWzXMjfKCZMZtTrcUwRn2E9PSeT8mOe86rbsSGaXGOFTHbl12thVyAFgxRjpE6qG2pBV5B3sH3Hi4n5Rhb9h9quqOvo/GQIfsSroiaJ3n450fPTNvQhRSASqtDjT6W61fn5Qp0vijwABSWWjI6LCGfENI7nxoZ3NYqTFLE1UBLf8xpy26hGPQ06ByCthatIU7BL5W/4tELR/HfA/J5TB+C83fuittEXY9VTf1kXxlzry8fEZgtzYfQFRNOb9KmKzsBt5TLyKYRQpbWSTDLAlHo+YRW81es3fHU7HtY+EbstuHllYrGsHxROpnkcY77lbmA3IoYFObg3O10zniJFaWSPikWaZbwS3H7PNgyFt6MC65JMDpEfdJ8lFLAZpjp+IGjMYXRiViYGQmkCmqIRUHAgspD0fDpHfgOSjMEurr/WBUvJvU6uC5cV5bmVxJhEMvSSpEMpsabVCvVaiwqhuUv1dY7fBkiuzQ/XDOXM90C1sQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(5023799004)(11063799006)(261022105027099003)(261026140227099003)(261102123227099003)(261028144727099003)(261026121527099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	edh9QUkJ29w/pkFHZux0q4/rvrZhp5oUdhwIJVRt5rKbqdbASauBzQNGgP3RWevd71h9gXc+pKq2oL0peLtkI69QUS9yt43whexbwRN6dPvUD5IOgom08vvGVD4NuG0yOexyn/+LNVBpz/ZPlwiYxHtR78dX6Ukv7n4Er4uSReL2deEyZ1lxg5aofsdKDUNzW3TsJXOLsqEw60xqYryDrdtWyoiMpxlVvwfqaB57y05dTSWqL1YrkH/IPE9CIPUY5mnNhAeh4Edfkm8pqd4s/5Y4LPUfLADij+FqrXCnjuQyTEBXUUuBhE/dnw1Nyv77lje4mXdl9yHsyjC8IpgfC7TMFEoeuQ8udAZdvfd86o+hTVbc4/XYjVSW2JmAip8DBVHSjfMZduDGAxUq0HOBxvzHSfs3qr3TDTUIn7sfJngUW+OfTV5rdiTf9+tMMII1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:07:56.9646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d17350c-06ff-49e5-d271-08df3a8dca69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169

Add event aliases and derived metrics for the NVIDIA Tegra410 uncore
PMUs, and fix perf's aggregation of the Tegra410 PCIe PMU instances.

The series covers the UCF, PCIe, PCIe target, CPU memory latency, and
chip-to-chip interconnect PMUs. It provides symbolic names for the raw
event encodings and metrics for bandwidth, frequency, and average read
latency.

The PCIe and PCIe target PMUs are named nvidia_pcie_pmu_<socket>_rc_<rc>
and nvidia_pcie_tgt_pmu_<socket>_rc_<rc>. perf only strips the number at
the end of a PMU name, so the instances of each socket were treated as a
different PMU, and these events and metrics gave one result per socket
and were reported incorrectly (e.g. with --metric-only), as discussed in
v1 and v2. Patches 6 and 7 fix this:

- Patch 6 adds a check of the cpumasks of all merged PMU instances to the
  zero-count skip in perf stat, so a socket that counts nothing shows 0
  instead of having its row hidden.
- Patch 7 treats both numbers of the NVIDIA PCIe PMU names as the
  suffix, so the instances on all sockets are merged as nvidia_pcie_pmu
  or nvidia_pcie_tgt_pmu. Per-RC results are still available with
  --no-aggr or -A.

Changes in v3:
- Replace v2 patches 7-9 (merging PMU instances that match the same
  comma-separated json Unit, naming a merged counter after all of its
  PMUs, and the ABI document) with a special case for the NVIDIA PCIe
  PMU names in pmu_name_len_no_suffix(), perf_pmu__match_wildcard() and
  pmu_name_cmp(). Thanks to Ian Rogers for the suggestion.

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

v2: https://lore.kernel.org/all/20261030174816.1544471-1-bwicaksono@nvidia.com/
v1: https://lore.kernel.org/all/20261019164241.403644-1-bwicaksono@nvidia.com/

Besar Wicaksono (7):
  perf jevents: Add support for NVIDIA Tegra410 UCF PMU aliasing
  perf jevents: Add support for NVIDIA Tegra410 PCIE PMU aliasing
  perf jevents: Add support for NVIDIA Tegra410 PCIE-TGT PMU aliasing
  perf jevents: Add support for NVIDIA Tegra410 CPU Memory Latency PMU
    aliasing
  perf jevents: Add support for NVIDIA Tegra410 C2C PMU aliasing
  perf stat: Check merged PMU instance's cpumasks when skipping zero
    counts
  perf pmus: Treat both numbers of NVIDIA PCIe PMU names as suffix

 .../arm64/nvidia/t410/uncore-cpu_mem.json     |  43 +
 .../arm64/nvidia/t410/uncore-nvclink.json     |  67 ++
 .../arm64/nvidia/t410/uncore-nvdlink.json     |  43 +
 .../arm64/nvidia/t410/uncore-nvlink_c2c.json  | 115 +++
 .../arch/arm64/nvidia/t410/uncore-pcie.json   | 249 ++++++
 .../arm64/nvidia/t410/uncore-pcie_tgt.json    |  83 ++
 .../arch/arm64/nvidia/t410/uncore-ucf.json    | 764 ++++++++++++++++++
 tools/perf/util/pmu.c                         |   9 +
 tools/perf/util/pmus.c                        |  23 +
 tools/perf/util/stat-display.c                |  20 +
 10 files changed, 1416 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-cpu_mem.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvclink.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvdlink.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvlink_c2c.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-pcie_tgt.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-ucf.json

-- 
2.43.0


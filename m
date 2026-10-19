Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792428296;
	b=akxiHCwRLfjHbjgMyAEAEPKkVArmZW7eBUyuIXuALkcopR11QaVbsKjPJpbQlEj9kDpa
	 rDHrZgtu2/iQG/VnxMteP11kVdyUsdznaEoAOqPL7L3rsiScHeOTA8/ikb8Ap9ylX+3F2
	 j6hLkWLGsXCpXeZ6tHisOtWEGao8AnRWOSENjTlf0ap1dbCuasBqFuh+0A8CTF721lSTm
	 9x+qNQpx5JeKFjnKPqSMJ9LcQ/4kkVboDFljpDnQ8W4yrRaebnas3iSf2wSOMTeml54KC
	 dDSc2yh0el546eXJQhsASM2sYQvqGi1OVt+HZL8ChNCZbgfQJxYRE+0Qe0Uf/o7kH6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428296;
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
	bh=hcHcxAquXwGgc21732ASMtLScSgs/GR43jv5ngYk6TM=;
	b=vlJytxvABYkrTCEstbBljbLzql3JN20K8xM+jf8D6SOKOstMHtB0UKjkGfmSfAyoPHtZ
	 x07Ng4jeCSivCTst5wRqJ5NLJEm898KOw10hp4zZA7prLyyQoAEjJQ2jaS3Eo7OZ9XG1a
	 GFpag4pBya43ufsquhHcu6ZJsP/Khdz8tAghr8tzqD5oNc17NvuaD9Ae3heSg8PuSk6dV
	 DL4sffe9pZ2AKJjbv4kpqUUh+J7uGeFyBz7boqhYMlFz8hjQt3YZv/n41C4gXt6a3KDNI
	 0g6Oe7qAg6lyU/3rEuDF6MHC44AAlBuGaKB4fk3l7Hy6DG/2lKC3MBhc5uipqxNTdPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="qIt5iC/h";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.28
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB33606A31A;
	Mon, 19 Oct 2026 16:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BB33606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qIt5iC/h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeLjFLoBFq20GIeGYNBINeBz1Em0TWBTW51oJmpzuFFEJnguD1cYKdpg1KXQED6fLdwDxzlUJ3YcGxrkUaLEUADAefF7HQIBDg0vOkfNnk500DF0BtSIdk+8e+9iWs3CQhf/+LEp9BMTu+lBqze48RHx36JwbN7bNty04NueneocNwn96aBIp68OOyH0YgJ+sha6cTYiGWAjnQg56/0hUUdrPIqnANrc4BWbCDCsrzbLJmIoSoCVNHwxrAL524M76NCgV7SCSEwBXYQWmqVVgmG+3GpP8bSAudF80ZIJGuXPXZW8TxUk4b6zSgjPGwbN+EeG4Jrw7a3cKtSL3wpBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcHcxAquXwGgc21732ASMtLScSgs/GR43jv5ngYk6TM=;
 b=bVHQlGmj2qbfCGmBNafhfGCUKCk75ny+gT4tZnx80kYgksitVn95ZkhKY9UpLaR9NEiqqXFLJ2P46OYAOVg3O1UevxgZN/NQ58FdWlhpRB+VojslQEhSc69L61bZx+TkMEr9w/xpP5a0iyQkAw85289j7Z8Ee+sjZG0eNHaluofzkAlHsbyJtXprL+ajf2a+yqQBZAZYMQMvYsH35GiDTqqO57Jwkmpr3BT2iM1q68or+Qjv2wS36+sNaqO2NiZ/qpBdI+fnIxtZdm6fHdIOyCd5jvjD7se8Om3RTl4E8grtGlXpfeLACHeqRQ6N0/sythS7Ro6TGBJqeBYnoe94WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcHcxAquXwGgc21732ASMtLScSgs/GR43jv5ngYk6TM=;
 b=qIt5iC/hD+63GDHhBXWieAcRXBRWMxu3c7czBiUk6j44W54HPPN8WY9nkJHpb/pi3MZAsDgJolgiYC8J/hp44vSwxdH9CXKtfkR6hX6HRJibtNtsHzKRrLWw6j659P89z7LtgdadVMBaXbG5VcaNwIfSU+K97/ffnCaE9q9ZVapldiTJPcJEnhOSP9DsHts+PlHuj/cxXyrk0U1HzNEupplNUIiTZP57Eu4vZNbjFARxHmanoCW9gqXYmMX94bXo321XFITGGn+UcA1daCcRvFBa3rHmtduElo/w7ud5CxyRl93vvKcVKRIRzySNvONjB657hOSUT4RhBrsuiaEgbQ==
Received: from BN9PR03CA0595.namprd03.prod.outlook.com (2603:10b6:408:10d::30)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:44:46 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::1a) by BN9PR03CA0595.outlook.office365.com
 (2603:10b6:408:10d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 16:44:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:44:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 19 Oct
 2026 09:44:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 19 Oct
 2026 09:44:22 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 19 Oct 2026 09:44:21 -0700
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
Subject: [PATCH 2/6] perf jevents: Add support for NVIDIA Tegra410 UCF PMU aliasing
Date: Mon, 19 Oct 2026 16:42:37 +0000
Message-ID: <20261019164241.403644-3-bwicaksono@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d5d610-1657-4fce-e4c4-08df2e00489d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	OkBiV4h2zKDf15/sP8/XP3FeAeSw5K6ihtfsFvGWIiuxy7CasJxlL2cxq7Cc3+enrNvktmvRGoedJc/mFmw/qqkUJfqbPdXUfJbi3dTH6prkdjKifpouJ09MSLhfppemWOo5rVGGVoycVqrGtwaJopQVzdHWbpu24jsh7TW5zhLtQhuVmq3ZZ4oCtorLBz/SPa9RQ/7aPrI05GRkAv67v51MiNXRkqjIV8U2ZrnCHccJjCgW81TmGEtPdXn0T+x5EZsK3IWGsdXoI7FC0AgSmEyXNCxaj1LiEbfGEywTaMGEvTZtek3OOwZ5x0jvaA0kTCwH54ZixG9JCmefvOgyq7Vyt3XAyNGTh/0LyJmYmhS8dU2hqM+f2jm06tqDThyeExhoM0y4YR/7w+2vi+dkryujLOYcFPvKnPpfFTdDVTOAopryw8MM2XStpF/fGrPW/rd1n+tEjA9T4R1IRt1BkBxXCHRy46a9Fj+zfAXwuX4CmR1MsV90NDSIVviY0Okp39D71qRAX1cvd4qoKEUddHjnF7Z2GTjDSlw8x8Uy+Mc89NbUlCV8zCpaLj7shtqCoE5qPjNgW9Z6flDZTFi81jtfVznvbXmh1QLdL4y0/DV3cvecdeDWOoLsSkFZD0gFu2bmu6CoBfCcBLwlVbViOQpIaV9/zxCtgGZGAsOGCDKOBdlhtXnHy7wJEmnGT5yASgPl5K5WheObSEB3Ckubng==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SdEo0b3lyj0FkCCfJqRKB+xt59bZxoNiDIob8Wxl/cXJAdYhDOyChjVNdwMJixr9p/obAF8zAmM0cBqRUpg2zqE4Wt0q5NwbqQwHyB5ZjFNeps2v4w/EJhmnjQo3K6dkWskXn1TK89ZFcHdH//tT84j0Xa7DYuhdtjBaawtPbql7mgYefgIjCqkqI5f/H4LfMR3+ANGsz713ojJPvEXlGm3q+pVKB919fSIPwFKbPDylbPvxOAPmXGicQdssI6cMos+9cVvtcRBSP3itoVV4bc3nT1rfLX4K1g+aBsMJP+lmz1tUDiXX1yuY45NzZlDlKz3Gv3qFEZ/0jTdRKLNdlrw4nWxG/ezN/VHUnBYMR4blDjt8DL65hHGqe/Ek0SWfnUUKVqI1+v8Y54gyuYsV3LF1DAY4CPq2mdz4MHoziZ+nG7J+cAGQm2OwbIk7q0EW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:44:46.1301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d5d610-1657-4fce-e4c4-08df2e00489d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750

Add alias support for NVIDIA Tegra410 UCF PMU events and metrics.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../arm64/nvidia/t410/sys/uncore-ucf.json     | 693 ++++++++++++++++++
 1 file changed, 693 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore=
-ucf.json

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-ucf.js=
on b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-ucf.json
new file mode 100644
index 000000000000..37dae2a65fc8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-ucf.json
@@ -0,0 +1,693 @@
+[
+    {
+        "EventCode": "0x100000000",
+        "EventName": "UCF_CYCLES",
+        "BriefDescription": "Counts UCF cycles using the dedicated PMU cyc=
le counter.",
+        "PublicDescription": "Counts UCF cycles using the PMU's dedicated =
cycle counter.",
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
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
+        "Compat": "2cf2036b",
+        "Unit": "nvidia_ucf_pmu_"
+    }
+]
--=20
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808506;
	b=jEprynAs5uhOOobLsFDuMiinVgSEWmvJT6BXNEEih63ZStEhVgeB8Ja3msOlYtqAlplZ
	 D+7VrVy5AotgkNPW+uY36A2uM+m4l3VQeeKayrkbiSvVBQTRvJnap+fBoAKBr9a55J29t
	 O3MKWcV8M1Rz3NVaDh9skjEUr53aQFheCTz5Wv4hi34lfO2ckKndWHs9XUQy3KvKWAAPq
	 QEH0nnnaQx6yR1M7zd7pdcy5k5LYeVhnV5+4nFyRHRPxC0xyuqc1M1SFvxInxrdK7nkv5
	 /Iippxqu8SRaaES7FiKl+Kn/kYV58qJE0E7/4Uq1dUSuLRvoPtl6b+aSnFvlSqXwl3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808506;
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
	b=c4Z7TgsZlPE4N4Gkwh4u2hEDCBdva6h+raHQMvzGQgUbxfoabMt91lRzSkvG/lJ6l1DR
	 3TPQBor7CUlFOkp0Sai/UKuOE3N1occeq8A7ATVIOWUqsQ4TX+wZE7sR/Lq5WvMTlUfWU
	 JF7oqMu/8MpAOMf9NO1Ih4xqrkd4stNFMV4jWAma/Uy8e0SF7cCjLOesU7vIz3Be3v1TY
	 wrPALm01uRHp0DvTUIKjyQOixkbZtwV9G379wnVJCsmWrEx3lKtC7QgmBuCKcoKfp+qhg
	 +5dfQo19Wqm16Mxjl3PGeAVqSirvl97APT0qyLYuSBq1wm6kxYngj909q6c/TvKhXrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GDwQMHeC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.31
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1351606A332;
	Wed,  4 Nov 2026 16:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1351606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GDwQMHeC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnyad5gBxRxYR3fxrGylEEQPi2yNAE8jH2hN8xyxbh7z3iJS2l1l9hT0ZbVPdoopRQ3R7U148jOJDmRxBlEZ3+KpKSYROjTBiXMwr8wAE8owtWHPA2IPOUFs3bBAOzKFKA57XzpdwiCMikCe6hGdeHTxjBZSvXrvrxxMxEHZmn5qyx7GVZ0dssQPSWTGEKKqa00Isj37YNRU9G6iW/FAiForlDQIXwKIDixOrKFybLeyZkX7dx4JqOZjzpaDCBT/8FRwBQM1bV18s4Ja2bUQRPAAUMGIl0wUr6ZkxuQ8Jff2kTKcz1YHHeTw3iZGvMwb/cdrUw+R11i6bcQ/p0vWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tj+5d0UfNnMCWkAJDG8Qeo+KwXLzoRZ7s4oS0H+lhU=;
 b=MUdCduqfXOr+srG7t4eZEvLe6FEtLqr7rUOWlg5aEf4dHbapPRNquEcLmbjkdYS949SrBTqTN583EDT4pzdwel6EJLWQ6AIh4rflskZE3ijQL+Xau7J8xKCcuHR6jBMcOPTN9SXql1HGkVrv8fQweXbloNYJArwWign21Qyl8BYsjaDGpL+orNoB6kwjw1GyXbsqyiWNTIZXHNCLZCQQlnPfCtaevpVtmCyAjAmz3vZLJbd6nt2KcZyxTEaJqfWHs/BrQJqTCHpc8WvaA+IWvpXTNiaAKQkkCfmrWpvd7eU1RefOMk1SOTlw2ReYD7ooOrQRnh0bHEti+x1U1XwMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tj+5d0UfNnMCWkAJDG8Qeo+KwXLzoRZ7s4oS0H+lhU=;
 b=GDwQMHeCKijM4MMjFQyDqrDtj07xPKuvjz49h6f6VRdufKnDGHqyuE+FpcndCCBg1ezYH/M0oMMjthuuBvCpg2eXTuPfiA77MAkckx1LwjGIShckx1xyxQz0FDwn7ia3ffvQPlZn13Jp6eSY0gqf8ao5YM8lYRsk+aryskLoiHuQpqPCNtZ785V60uXAMSeKqa1XxGo0sX3lV/XWPuXohG3LTUNVCuFOs+m4KXHI+Uk6RYeMhy6afwxKtJHV1+G2aWoLvxzaD9Rc0mFmLIPyWF+C++Uff2NYueGSFO1Fg3/l01Db4m73Fa0mUW2wZwwX3TSiEB2zWFZnpKIs4njGfg==
Received: from PH7P220CA0100.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::14)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 16:08:12 +0000
Received: from CY4PEPF000392D6.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::a9) by PH7P220CA0100.outlook.office365.com
 (2603:10b6:510:32d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 16:08:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392D6.mail.protection.outlook.com (10.167.247.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 16:08:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:07:47 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:07:46 -0800
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via
 Frontend Transport; Wed, 4 Nov 2026 08:07:45 -0800
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
Subject: [PATCH v3 1/7] perf jevents: Add support for NVIDIA Tegra410 UCF PMU aliasing
Date: Wed, 4 Nov 2026 16:07:10 +0000
Message-ID: <20261104160716.2910873-2-bwicaksono@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D6:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 435f6855-d669-46cb-31db-08df3a8dd395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|11063799006|5023799004|56012099006|261021121427099003|261009223027099003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	52Gif9BZms66Xb09aFZX7v9OelF1Qf+TdY8aTt9Er441w3khIR/Cl5ULUgij2fnpfOILHZhUcuH8qgTGG6N8j0eBKIVDsqUEXO90U2Ed1M+fQEKY3IINdR5e+fkcj20rYa3c9XIfJkJCiZ9iKD7/Y/3KIclErw8GAdnAjUJ/kcjxOJF/06iWvdvOBwbz2uDvo/KBJ4fuhUEgmZxlAbh+16ojQcdfzCcalVcyjzUiSb1UIALUetmBvOz3B4j9szzUvkrxq4i21JHOJjAVD8gjQusV3whMsQB1sOVnhsm6zn27mUFWLgiE9yDIDlzJH1D6l5HJoetAyxqKeJtCWLTKWnojFWoQ1y+6kfHgrvguxPk7Uz4Zf6KZ7wktRhQGPuOOLvbx0sW4I8ch+Vq3jkREOuiCderCJ1mVhZTB/CeB/+uEE2zxKK9rZKt1g6lQ7hpuSPu6V5PLilFcPZxZvavlxAJFqHy9DY8ObVp8HVavMqLsGkFXOIjW6D4zCUi+DD9k/fjmC/bqgRDrD3kh/NQLTND5RlNKdb1/lGC+efU6ars7iJqJVU9yW6jFyzT+G2yCs6tSOzF7IBw7v7lWKCjIKk0jtkpjG+NKx4Me8P9itWH+gFyxzZCK0Eyk32bQvJ1G5fBItfUSUOW5xWFr+StpE6HQSHUQEz8amJBn/3VWP+n63L0oL2h7kyrftFVqmW+VhJ/Ncny7mi16shyWyt8yog==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(5023799004)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jowNJfTax0qWf4isbOU0vHobcU991UpC7wrHuiBciQnAypPPfizfSmsz1W/4bU8HaHYUlvbZ/8PNrGjoMHfK4cNB6FnN8r8BZfJSkh9Wd2tUMeeQZ1BCTgRs2SSXVdzZe9VIfFmwMJyuG4HROzUKAY8GRXnbSsfrqDJ3I9oRospAC/2ZRRUHJf0d151oZYrsj+46AJfeqXtsi6YwA45cET0OTq1MiBGyMJ+v+TRsbxuBBBeC4gmYayVg1PoQJ9u7uUtd+j0Z4ieoEHGtc1tnxZVURuKbO/q8LZZnE1ZGXY2tFimmzyvvt0b9GBDS+kueuN4wUOB5YITmI+3nrOOU9PUckkkqYtdA7jzMgifY0B7yBli5d6yFAsBV4Q3vxDqQgHMTIWwc1agXGiAYa8gM/g11azEAYUd2741v4QD73F3dF83XW0DuOlBX2MlduNco
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:08:12.2182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 435f6855-d669-46cb-31db-08df3a8dd395
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392D6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025

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


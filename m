Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792428310;
	b=UTGATmjooLMfjGW7vM1onG08idUnjaXD6EwcIZ0XHKvjZYcarXovbZSy970P6rlJX26R
	 JZbzGmmdJntmK6/qFmjiIVwILd22olaBpU2zvZJ8hLBz3Yh6/vLUuqbsn39Mh3ReYrXmg
	 QM67s2O4KJ7ypcupoGf9CFb9DHcnH0tlO+apXyoIV1OpelcGm9/3zwehOnErEBPnwspxT
	 YZxdgv9uc1XTDpZ3+iqmCzkWjsehKkxEkroiNUG4BtTR5SZalswrucsrmEXdcNgNr3aaj
	 25wOQjTrbcEMCg/shA4q/Cshv+keO2FOrG0lG4JNu/P9LuxE7Z5gagt7gPSSL4am/LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428310;
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
	bh=29/nPZPWma39enXdkXbVxvQeVO/gkslg3pYY2a3vmlA=;
	b=tf4WKXQ/yTBOfQkS7dqhsAFAYJRGTah+6at8/YD479vKOrmDdhA3zxTx8+7OdkunbwrW
	 xfJqbz2K/vepHhvpxGeriMMPmaCqbEUKjGkyabPp9c5e83KLGNm7gvXsU3Lx3QFObyAmS
	 unjhe5SvdZJPCWU/Mo9JTkhHxTPePmGTCGbzS4B/l16BjnHw54HTKDtAzLhKh5cLNCZ7Z
	 0z1I8LiLu8/kNB08ODRQuGvd/43vXXIb1XQnt9JI9jWDt73U719imlVGNdxsfZDD9G8Io
	 ehvNbRbOZo8Yuudy9QIaaWNhKYI1HY4VDhBfOoGoEuZI9O2BF/sf9+uKfnUGf/i6wEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GKw7zSRY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.4
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8C606A322;
	Mon, 19 Oct 2026 16:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69E8C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GKw7zSRY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGgnzwURST8nFCxxAR7x5FzrKMecOgZVbGU5zSfaUkOUfqVP2WnFms44B25jFChr03gvftqF3vZXJGLs1XjnGN2nZIFrSrGcBFjI6Z1PXo9eGec5iNCAdpugSNpeLazKn24xt71jcAJN2ADSjH6yNa7RPDpa0a2HmKgBBvJczLI3yd+gGTyVnYvR+NIM417skdaeL1FIYffao52zJB2599A7pclp1plRgC3dXnM2qRH8PM11RUhL+P+6dgMp8fbvCubicXIBsT68L2i1PT2pE3aR1oJsIKV+nvw/wzMI/HDUY03cXhNV7ixLdKVmXmk4n7+uxnTqWWAyA1EACOHJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29/nPZPWma39enXdkXbVxvQeVO/gkslg3pYY2a3vmlA=;
 b=qYS1lg+OU5XdOBmvthCmNrKD5sQI64VqSWsR5noshwulcTZ5o86Qxl7aWFnGHMMk2sBqD24oIcnIPCoggj7ak/yQoT7VFoJVB7lghx2ZHEHh74mRQ4XEOUUwH35UXwAigprsd9oitNQ/olyyC3iIgsEOJj3ZDVAk/7aJWye4XKVorO+XP41wsDem3eVrqWpsll/53KJTHZLwTCx5PkY+UC9w34z+QPtJ9PBA0oeG8gvEqDzNZlQ14fr/PuqvBQhbHXb3/TJW0ZSfnFwZftn+zj5e8rN9EX3X7010p6RZ3d3+w97dQ7gcZObvjDkoONkh9YPJJIRjeJ5XrS1CUr5wmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29/nPZPWma39enXdkXbVxvQeVO/gkslg3pYY2a3vmlA=;
 b=GKw7zSRYhZVNZ9xy9skoZ4uS0k3jpJpsLk9xSSZCTcR8F80BX/zxa2m7WXO9Yym6yDB7aGGadztUkUf/1eZ21XyywdKqfBCbWoGTaU1FNKjFNeqM0t6UzhPzI7GQFVvdewEDV872lvsEEl/lM9zONWc67lFsVTYftGYJWkRvsS7ayV7OMhIWf6D4DgWpRwVNeaCwpCquTfbKNuT9Qzz2JnxT+L7wT2YhbzO2niP0FUkkgxYElV/HNvXQ4liSCZJGD+u9UUoqpw8oAFkKxGx7pW0sdjlCPKl3jjeI0SJ1CLqeoJZs94pWbfs2trxlrpzAxkECQYeX66MSyT3rLkjR/g==
Received: from PH8P221CA0053.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::18)
 by LV5PR12MB9827.namprd12.prod.outlook.com (2603:10b6:408:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:45:04 +0000
Received: from PH3PEPF0005961C.namprd05.prod.outlook.com
 (2603:10b6:510:346:cafe::48) by PH8P221CA0053.outlook.office365.com
 (2603:10b6:510:346::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 16:45:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF0005961C.mail.protection.outlook.com (10.167.243.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:45:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 19 Oct
 2026 09:44:38 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 19 Oct
 2026 09:44:38 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 19 Oct 2026 09:44:37 -0700
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
Subject: [PATCH 6/6] perf jevents: Add support for NVIDIA Tegra410 C2C PMU aliasing
Date: Mon, 19 Oct 2026 16:42:41 +0000
Message-ID: <20261019164241.403644-7-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961C:EE_|LV5PR12MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: 9663c110-e2c0-4b19-7482-08df2e005340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|23010399003|11063799006|56012099006|261009223027099003|261009221227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZLoSHwRncrFbOvZRrGHgB5rQj6/UTjQmY5vTeASqVn3qrHu+/j3vxwylIfmEzc7x+3UsV7tXP+hPhLE6ypC/faNLFcY8pCEIDmc0Tqi+jjPE6qO3ULZ9FRx78+3Y8XUmQhtqx4d5hhnaKAujGH7hDDvIwpu4ZmF1Tkrd3WkQ98Hv2hIHHeCXZdlEuFFCZEnuGox4wG1C/zKPD7dWfpGqsKEvBy7+zcK6THsA7mgPGGcvwvu8K0jSHPLfZc/B4PHdsKznY/g4vS8D4+DfSl/s+fBzYG9qJkEph0vGvuNECQOkBul3JmkjplJERQLRdexNgfNWPaD3tRWksiqkOid0kvZDN3aeK1Q5cVmxq/EIVmV0O36ml+CeXJI8kYrAHDQ8FU5OUnsgW0n1ekC82KZw5gfHmHdiEPB12wW68Dm50dzX5dlQMXA+/Nk9bucujYDDuK9wSbTWM3+v/0J9StGbyjglLXb9mYfKzyvgmnQZ0/Xn7bDSbA1+a2NKmXi9Vo+0JW3Zj1tNJujj3JW3c0Zyfddc4KzyZ5IvLX+ZCojQ6UedJumYJgaqMJnM4DRRUeVeOgy8Da3MaNIN1HwzSc0M8PlRa0yKO6I+1tvrm7pH3rfuD6lUOVACfBK+Pwfngn5UXnu40I3Xy4748jobNnJX0Vnd6XZPUKcHxidN4CFtnyR125e5aWgbQj7/rawKh59qF1+HiARIIVzB73cc3aH8cg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(23010399003)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ykyq54WP1RYRP+rYYcOfuruusBgvRL4VzLVrCWkRgI6oiZ12WuZiVIEYbk2RlRj2lmzfm3qXK3Y1WBltohgqcPpHMWVJyzOVbIg0fg4bQ7rMVjCMfBux1fhJR7bUpTI1cKeCFFmsKFjzb0gKkZXSAY7v5UGvjFGA9SEYYBFHmoIDu/nweffuwrLFkN3yZuvij7pJEqy2Dn+vWNSQsPghJPNK+bL+5O66dBYl7+XWAkLj4Y10nRE9yqiFUnATdHJ6hHlYdEljOWfryWXAwiYFTlacyWz5ecuXGBEo/aA4WUP4GPJyFzKu5hsRkHbphpRM90Sb4f3DvzMDeXF90jEj4ct4e1+eumgUDSjnSvrUdChcTzWYWS12Th2fIpqP8rxQNnCLM9oe1C1rLtgGErcCe7wOqFlXs0KhoNQr2XfA0ats218uulwUeQHLUmhfK+OV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:45:04.0174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9663c110-e2c0-4b19-7482-08df2e005340
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF0005961C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9827

Add alias support for NVIDIA Tegra410 C2C PMU events.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../arm64/nvidia/t410/sys/uncore-nvclink.json |  75 ++++++++++
 .../arm64/nvidia/t410/sys/uncore-nvdlink.json |  48 +++++++
 .../nvidia/t410/sys/uncore-nvlink_c2c.json    | 129 ++++++++++++++++++
 3 files changed, 252 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvclink.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvdlink.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvlink_c2c.json

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvclink.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvclink.json
new file mode 100644
index 000000000000..fe94ae121a8d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvclink.json
@@ -0,0 +1,75 @@
+[
+    {
+        "EventCode": "0x0",
+        "EventName": "NVCLINK_CYCLES",
+        "BriefDescription": "Counts NV-CLink interface clock cycles.",
+        "PublicDescription": "Counts NV-CLink interface clock cycles. All NV-CLink instances share this clock, so the count is read from the first instance.",
+        "Compat": "NVDA2022",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "NVCLINK_IN_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding incoming read requests counted by NVCLINK_IN_RD_REQ each NV-CLink interface cycle.",
+        "PublicDescription": "Accumulates the outstanding incoming read requests counted by NVCLINK_IN_RD_REQ each NV-CLink interface cycle. Pair the two for the average read latency.",
+        "Compat": "NVDA2022",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "NVCLINK_IN_RD_REQ",
+        "BriefDescription": "Counts incoming read requests from the remote Tegra SoC at the NV-CLink interface.",
+        "PublicDescription": "Counts incoming read requests from the remote Tegra SoC at the NV-CLink interface, where local memory or a local device responds with data. Request size can be from 1 to 256 bytes. The count is summed over all NV-CLink instances.",
+        "Compat": "NVDA2022",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "EventCode": "0x5",
+        "EventName": "NVCLINK_OUT_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding outgoing read requests counted by NVCLINK_OUT_RD_REQ each NV-CLink interface cycle.",
+        "PublicDescription": "Accumulates the outstanding outgoing read requests counted by NVCLINK_OUT_RD_REQ each NV-CLink interface cycle. Pair the two for the average read latency.",
+        "Compat": "NVDA2022",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "EventCode": "0x6",
+        "EventName": "NVCLINK_OUT_RD_REQ",
+        "BriefDescription": "Counts outgoing read requests from the local Tegra SoC to the remote Tegra SoC at the NV-CLink interface.",
+        "PublicDescription": "Counts outgoing read requests from the local Tegra SoC to the remote Tegra SoC at the NV-CLink interface, where memory on the remote Tegra SoC responds with data. Request size can be from 1 to 256 bytes. The count is summed over all NV-CLink instances.",
+        "Compat": "NVDA2022",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "MetricName": "nvclink_freq",
+        "MetricGroup": "NVCLINK_Frequency;NVCLINK_Latency;NVCLINK_Read_Latency",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(NVCLINK_CYCLES / aggr_nr(NVCLINK_CYCLES)) / 1e9 / duration_time",
+        "ScaleUnit": "1GHz",
+        "BriefDescription": "NV-CLink interface clock frequency.",
+        "PublicDescription": "Average NV-CLink interface clock frequency over the measurement interval.",
+        "Compat": "NVDA2022",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "MetricName": "nvclink_in_avg_rd_latency",
+        "MetricGroup": "NVCLINK_Latency;NVCLINK_Read_Latency;NVCLINK_Incoming",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(NVCLINK_IN_RD_CUM_OUTS / NVCLINK_IN_RD_REQ) / nvclink_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average latency of incoming read requests from the remote Tegra SoC at the NV-CLink interface.",
+        "PublicDescription": "Average latency of the incoming read requests counted by NVCLINK_IN_RD_REQ, measured at the NV-CLink interface.",
+        "Compat": "NVDA2022",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "MetricName": "nvclink_out_avg_rd_latency",
+        "MetricGroup": "NVCLINK_Latency;NVCLINK_Read_Latency;NVCLINK_Outgoing",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(NVCLINK_OUT_RD_CUM_OUTS / NVCLINK_OUT_RD_REQ) / nvclink_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average latency of outgoing read requests sent by the local Tegra SoC to the remote Tegra SoC at the NV-CLink interface.",
+        "PublicDescription": "Average latency of the outgoing read requests counted by NVCLINK_OUT_RD_REQ, measured at the NV-CLink interface.",
+        "Compat": "NVDA2022",
+        "Unit": "nvidia_nvclink_pmu_"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvdlink.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvdlink.json
new file mode 100644
index 000000000000..c8f5d97a0ffb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvdlink.json
@@ -0,0 +1,48 @@
+[
+    {
+        "EventCode": "0x0",
+        "EventName": "NVDLINK_CYCLES",
+        "BriefDescription": "Counts NV-DLink interface clock cycles.",
+        "PublicDescription": "Counts NV-DLink interface clock cycles. All NV-DLink instances share this clock, so the count is read from the first instance.",
+        "Compat": "NVDA2020",
+        "Unit": "nvidia_nvdlink_pmu_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "NVDLINK_IN_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding read requests counted by NVDLINK_IN_RD_REQ each NV-DLink interface cycle.",
+        "PublicDescription": "Accumulates the outstanding read requests counted by NVDLINK_IN_RD_REQ each NV-DLink interface cycle. Pair the two for the average read latency.",
+        "Compat": "NVDA2020",
+        "Unit": "nvidia_nvdlink_pmu_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "NVDLINK_IN_RD_REQ",
+        "BriefDescription": "Counts read requests to local CXL memory at the NV-DLink interface.",
+        "PublicDescription": "Counts read requests to local CXL memory at the NV-DLink interface, from all requesters, local and remote. Request size can be from 1 to 256 bytes. The count is summed over all NV-DLink instances.",
+        "Compat": "NVDA2020",
+        "Unit": "nvidia_nvdlink_pmu_"
+    },
+    {
+        "MetricName": "nvdlink_freq",
+        "MetricGroup": "NVDLINK_Frequency;NVDLINK_Latency;NVDLINK_Read_Latency",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(NVDLINK_CYCLES / aggr_nr(NVDLINK_CYCLES)) / 1e9 / duration_time",
+        "ScaleUnit": "1GHz",
+        "BriefDescription": "NV-DLink interface clock frequency.",
+        "PublicDescription": "Average NV-DLink interface clock frequency over the measurement interval.",
+        "Compat": "NVDA2020",
+        "Unit": "nvidia_nvdlink_pmu_"
+    },
+    {
+        "MetricName": "nvdlink_in_avg_rd_latency",
+        "MetricGroup": "NVDLINK_Latency;NVDLINK_Read_Latency",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(NVDLINK_IN_RD_CUM_OUTS / NVDLINK_IN_RD_REQ) / nvdlink_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average latency of read requests to local CXL memory at the NV-DLink interface.",
+        "PublicDescription": "Average latency of the read requests counted by NVDLINK_IN_RD_REQ, measured at the NV-DLink interface.",
+        "Compat": "NVDA2020",
+        "Unit": "nvidia_nvdlink_pmu_"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvlink_c2c.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvlink_c2c.json
new file mode 100644
index 000000000000..dafcf7e600b0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvlink_c2c.json
@@ -0,0 +1,129 @@
+[
+    {
+        "EventCode": "0x0",
+        "EventName": "NVLINK_C2C_CYCLES",
+        "BriefDescription": "Counts NVLink-C2C interface clock cycles.",
+        "PublicDescription": "Counts NVLink-C2C interface clock cycles. All NVLink-C2C instances share this clock, so the count is read from the first instance.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "NVLINK_C2C_IN_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding incoming read requests counted by NVLINK_C2C_IN_RD_REQ each NVLink-C2C interface cycle.",
+        "PublicDescription": "Accumulates the outstanding incoming read requests counted by NVLINK_C2C_IN_RD_REQ each NVLink-C2C interface cycle. Pair the two for the average read latency. The gpu_mask filter works as described for NVLINK_C2C_IN_RD_REQ.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "NVLINK_C2C_IN_RD_REQ",
+        "BriefDescription": "Counts incoming read requests from connected GPUs or a remote Tegra SoC at the NVLink-C2C interface.",
+        "PublicDescription": "Counts incoming read requests sent by connected GPUs or a remote Tegra SoC to the local Tegra SoC at the NVLink-C2C interface, where the local Tegra SoC responds with data. Request size can be from 1 to 256 bytes. The count is summed over all NVLink-C2C instances. Filters: the gpu_mask filter selects GPUs by index, one bit per GPU. This filter is available only when GPUs are connected. An unset gpu_mask counts all GPUs.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x3",
+        "EventName": "NVLINK_C2C_IN_WR_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding incoming write requests counted by NVLINK_C2C_IN_WR_REQ each NVLink-C2C interface cycle.",
+        "PublicDescription": "Accumulates the outstanding incoming write requests counted by NVLINK_C2C_IN_WR_REQ each NVLink-C2C interface cycle. Available only when GPUs are connected. Pair the two for the average write latency. The gpu_mask filter works as described for NVLINK_C2C_IN_WR_REQ.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x4",
+        "EventName": "NVLINK_C2C_IN_WR_REQ",
+        "BriefDescription": "Counts incoming write requests from connected GPUs to the local Tegra SoC at the NVLink-C2C interface.",
+        "PublicDescription": "Counts incoming write requests sent by connected GPUs to the local Tegra SoC at the NVLink-C2C interface, where the GPU sends the data. Request size can be from 1 to 256 bytes. Available only when GPUs are connected. The count is summed over all NVLink-C2C instances. Filters: the gpu_mask filter selects GPUs by index, one bit per GPU. An unset gpu_mask counts all GPUs.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x5",
+        "EventName": "NVLINK_C2C_OUT_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding outgoing read requests counted by NVLINK_C2C_OUT_RD_REQ each NVLink-C2C interface cycle.",
+        "PublicDescription": "Accumulates the outstanding outgoing read requests counted by NVLINK_C2C_OUT_RD_REQ each NVLink-C2C interface cycle. Pair the two for the average read latency. The gpu_mask filter works as described for NVLINK_C2C_OUT_RD_REQ.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x6",
+        "EventName": "NVLINK_C2C_OUT_RD_REQ",
+        "BriefDescription": "Counts outgoing read requests to connected GPUs or a remote Tegra SoC at the NVLink-C2C interface.",
+        "PublicDescription": "Counts outgoing read requests from all requesters to connected GPUs or a remote Tegra SoC at the NVLink-C2C interface, where the GPU or remote Tegra SoC responds with data. Request size can be from 1 to 256 bytes. The count is summed over all NVLink-C2C instances. Filters: the gpu_mask filter selects GPUs by index, one bit per GPU. This filter is available only when GPUs are connected. An unset gpu_mask counts all GPUs.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x7",
+        "EventName": "NVLINK_C2C_OUT_WR_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding outgoing write requests counted by NVLINK_C2C_OUT_WR_REQ each NVLink-C2C interface cycle.",
+        "PublicDescription": "Accumulates the outstanding outgoing write requests counted by NVLINK_C2C_OUT_WR_REQ each NVLink-C2C interface cycle. Available only when GPUs are connected. Pair the two for the average write latency. The gpu_mask filter works as described for NVLINK_C2C_OUT_WR_REQ.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x8",
+        "EventName": "NVLINK_C2C_OUT_WR_REQ",
+        "BriefDescription": "Counts outgoing write requests to connected GPUs at the NVLink-C2C interface.",
+        "PublicDescription": "Counts outgoing write requests from all requesters to connected GPUs at the NVLink-C2C interface, where the requester sends the data. Request size can be from 1 to 256 bytes. Available only when GPUs are connected. The count is summed over all NVLink-C2C instances. Filters: the gpu_mask filter selects GPUs by index, one bit per GPU. An unset gpu_mask counts all GPUs.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "MetricName": "nvlink_c2c_freq",
+        "MetricGroup": "NVLINK_C2C_Frequency;NVLINK_C2C_Latency;NVLINK_C2C_Read_Latency;NVLINK_C2C_Write_Latency",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(NVLINK_C2C_CYCLES / aggr_nr(NVLINK_C2C_CYCLES)) / 1e9 / duration_time",
+        "ScaleUnit": "1GHz",
+        "BriefDescription": "NVLink-C2C interface clock frequency.",
+        "PublicDescription": "Average NVLink-C2C interface clock frequency over the measurement interval.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "MetricName": "nvlink_c2c_in_avg_rd_latency",
+        "MetricGroup": "NVLINK_C2C_Latency;NVLINK_C2C_Read_Latency;NVLINK_C2C_Incoming",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(NVLINK_C2C_IN_RD_CUM_OUTS / NVLINK_C2C_IN_RD_REQ) / nvlink_c2c_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average latency of incoming read requests at the NVLink-C2C interface.",
+        "PublicDescription": "Average latency of the incoming read requests counted by NVLINK_C2C_IN_RD_REQ, measured at the NVLink-C2C interface.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "MetricName": "nvlink_c2c_in_avg_wr_latency",
+        "MetricGroup": "NVLINK_C2C_Latency;NVLINK_C2C_Write_Latency;NVLINK_C2C_Incoming",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(NVLINK_C2C_IN_WR_CUM_OUTS / NVLINK_C2C_IN_WR_REQ) / nvlink_c2c_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average latency of incoming write requests from connected GPUs at the NVLink-C2C interface.",
+        "PublicDescription": "Average latency of the incoming write requests counted by NVLINK_C2C_IN_WR_REQ, measured at the NVLink-C2C interface. Available only when GPUs are connected.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "MetricName": "nvlink_c2c_out_avg_rd_latency",
+        "MetricGroup": "NVLINK_C2C_Latency;NVLINK_C2C_Read_Latency;NVLINK_C2C_Outgoing",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(NVLINK_C2C_OUT_RD_CUM_OUTS / NVLINK_C2C_OUT_RD_REQ) / nvlink_c2c_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average latency of outgoing read requests at the NVLink-C2C interface.",
+        "PublicDescription": "Average latency of the outgoing read requests counted by NVLINK_C2C_OUT_RD_REQ, measured at the NVLink-C2C interface.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "MetricName": "nvlink_c2c_out_avg_wr_latency",
+        "MetricGroup": "NVLINK_C2C_Latency;NVLINK_C2C_Write_Latency;NVLINK_C2C_Outgoing",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(NVLINK_C2C_OUT_WR_CUM_OUTS / NVLINK_C2C_OUT_WR_REQ) / nvlink_c2c_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average latency of outgoing write requests to connected GPUs at the NVLink-C2C interface.",
+        "PublicDescription": "Average latency of the outgoing write requests counted by NVLINK_C2C_OUT_WR_REQ, measured at the NVLink-C2C interface. Available only when GPUs are connected.",
+        "Compat": "NVDA2023",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    }
+]
-- 
2.43.0


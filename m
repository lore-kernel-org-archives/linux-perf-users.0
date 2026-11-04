Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808519;
	b=tgXogpTOn9gdtvs3KZQoh6ENfT0NNBY17w88yhsTWIjJJ2/QMerDICSYWn7VL0rOJnCz
	 AN5qIULvmBy+AtkqUjprdqKoxYhp1uzAuSh2ng+2hNBgg2ad1BSXb7I0AEf6irs2k2Qtd
	 SBnfQC8p9TsztHGcQW17wTQcEUL0bn46sKqCNXBP9M8nHNlCusQfIyxMXPzmFA0OHooe4
	 zFm/csstESY+9Tpr/THAAQX0bFfEkE4Q1oTRIk5plMpyHgx2hJEu8U1hOyauNQPdY1VlY
	 aVs/opbrYAE/2mgw9bKh4zGvMy+YdRUS9JzwXmLGXHkDYw5Jszdesb4opXrKybwZ93w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808519;
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
	bh=6PGgnpyMYrj/7HapEYVPI0E19gQGE0Xgd4pRqLiKqbo=;
	b=iec+3JAG9Og3pw310gq+dPnaUY/qrNnI0Ky89qriMJefEwNreNv4WGoFRROcfXRf1O9w
	 C7iyW05M0iUT1sEla4SX2zJ1B47yfni1kCFlGr7ATz6RrDOtrIpcnbUa13hyeQBYB+2Aq
	 fhEejrkjIzTeFLT1oIM/YbjpWv+UeWHeYZujA/jI5da5A9FloJxkf0ofBHGLmM3/705Gf
	 +iW6YJMmaeg0xwIE4W9RpCgAMjhHAbmP6bMdeHEK4ughATPsuiihb842afUTKKCVrADI3
	 rOjz9CZJZQcMqGLDt205F+WKk5ai4MgVBloP7TpRiLjc6s7I4Q57l/9y2JGq8sF2MiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="P/3JjS5z";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.69
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24529606A335;
	Wed,  4 Nov 2026 16:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24529606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P/3JjS5z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3t54KdCrADAHsdGD4d47BWqDQSWUIPwMislyXfwPT9BjfoUQk2Z9rDncgk9od8SE4rgIU+qiV9g4wIRZoBWdLfWBFQZbBaBhWX475H+S6XymBOmdbSBoDxLXbj0wW62seChDXKhbOBa2qZgpZY3QD3PZw6IZH6yXR8hk2Mq4iFQSdVMt9or20A7SIa0l8OXCHQZ5PrPZ4v2Icg217lQsukYzeee5VmzfhBOQ+w9/5o2baKfLqv9E5bcngW99AOL4rwGUSpBaUcFjRweuzJUp1r14IC4InWh8eUB7ZsT6JUZxYDtZIc04i4pP+JfENSX1yMvDFQ7sxSCajP5bh6Llw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PGgnpyMYrj/7HapEYVPI0E19gQGE0Xgd4pRqLiKqbo=;
 b=yRfLORdiyjNsC21PJI/qFX/0ya0QUIzngHsTNuzTw9xQ/cLrC4PcX6a5AW4KB5a900aspzvdKT8lLwDl1r5EGpoEPyStjwj+R/mzRy6W5+SHOUblU6IZ6MaMETar97X8MjRHc1ZvPDc9sleEDPELbw8dDuBjitKBKtABTqG/yicSQMrn1L3DcFbV3x8uiVXDOGsmRbK0/LypOlFTV/k1N/tAC5OetsZh3MaW8lOxCO8PR0EgJF8UdWAzDHNze4tDC1DMqCjeFW8gcxLNfqDcHnm7zE122QVgJDVJgO1ngLTUqcoiBCDHuySXjSQOE0YXkTuIrKEEhvt1EFyxlpt4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PGgnpyMYrj/7HapEYVPI0E19gQGE0Xgd4pRqLiKqbo=;
 b=P/3JjS5zCE7jmmW0jRLRszgmtfzuWgyPXz2f3ujw7wc1NBDxWfEXcJyxhsNfe9sdyrZDcUZwqz9ksu1Tw+fwMlyRhvFEb4loBt8uSRYGp7fKK7M75OTlN063f8W9IjIdnxL7o7tud1jcollu4idf99q/qsWh+Mbt2JQtXnWY3YBJWioAcbKcssDDYfyrGuuNichUQ+QjQVf3ZOSwvkP1ws9SR0KiLlPVD3F0HKZsh3r+qvZGmE6FGfceYCyb394+yw9SQfgyq8su3ixQcfM3DuWl4RZbG91pJjLHd7ME8dpBTMfTw71tCDlP/57EV3Tf2C1q3w32eAMZ1ekctYwlCA==
Received: from DS7PR05CA0047.namprd05.prod.outlook.com (2603:10b6:8:2f::26) by
 BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:08:32 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::81) by DS7PR05CA0047.outlook.office365.com
 (2603:10b6:8:2f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 16:08:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 16:08:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:08:04 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:08:03 -0800
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via
 Frontend Transport; Wed, 4 Nov 2026 08:08:02 -0800
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
Subject: [PATCH v3 5/7] perf jevents: Add support for NVIDIA Tegra410 C2C PMU aliasing
Date: Wed, 4 Nov 2026 16:07:14 +0000
Message-ID: <20261104160716.2910873-6-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c83f90-6178-49bb-282e-08df3a8ddec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261009221227099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7LQR4XpV/53cqrz5v4nEYF/yebGX4eM0h0jZdLgBAKKXGBpRsFtWbK29a9k3e2cZwXFUYzELGZh/4fj1bnfVxgk+NM+22i+t880Vb4BU7M8wOWdpzq0XKMYfcG0t9xJA2ieuB+dzERk+gFSKpSEAdGODTcaWTjTty2b9jFu4mG1xXBFs+NjudJXY8pe4dxoquFZZtA7OO1HtmRQjvF2ZTPqTtQpRXl3wl58oz0XBHzb1hpb9FlyH1NFDCZlGWMngKX0NNtZLQUFE8dzqL2zgeL9Q2iWfN5Rzb00l8oRGuLBOZryk0L+dU2MlqWR0HP3Z0KMRmUqV9pyIH6TYJ+vYBculcJvM+qGEzx+HssAg2X3CEOGDhfV8OIaSeZeojIrRkkPmkssmJw7TDvnnsQbh6u6tTRvPuh5rSVeLChpEsXWO3qxok5w8NePbL0YChmqPn5OJ2zoS8nRi8nuLusAoEsct2oElXZHXSQ9DD17ALx9TUcKIV1hft/iol3ojQEjDAKRk7fy2o9airo69+qzTu2IREmnYtavQzr6EkboFVYlhTApdExfiRe7j3ZVGrvF7RT8R2gLY7TWhyFTRrEISCXNgUneesq6v1zJSrdGNQ470zm4rnCeBHAbgNa6Xx6QB2D4p24HFnTqVjYtq8mSaN2hP5QTOxwUF2YyFs6zy4636a1cfJLyR5blqpr/4Tqzu3seoOeec5PA6rQItsGgewA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261009221227099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wo3Siz8KypJHJ2cBYqavdxkqZrUztqq854kX4DiJff6eM9U013+54zYSSW3MRiisVnqXWjv2DWo9p5SJ/75nxlMDmP7Zu/vvkYuFxFtjtGGSb0++JAp6v/bCY+z4jaCecBIC8Tdu2h+4Hqt70ozxyBlX5HdI6XW4xpNhBiSia1+31bMlDBZuRLjOaFs1YbFfar5phpC6zwezj36dOxk2zsJuS2JYx+OWQedll1/5ouajfDQeyA2Adrk6A1FsYc88Nd5F6YMYgPu+8eZjE2zu0qWDkVqsybliUWhBJ6N9qK2/tn7WDP4DsHT3VP6EJXbtjHpW7y40bzXQF4UV7Z+ap8AlRnjTNAs65NWrRLj4+0ruJtEGyVcIJpDH2Id5h0p6m2/IqtVdGqaRk9xjkr2khIxUUygJMVaicPWeHCm6OzbX9C+0diQAGuFbSMzRHErB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:08:31.0905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c83f90-6178-49bb-282e-08df3a8ddec4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448

Add alias support for NVIDIA Tegra410 C2C PMU events.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../arm64/nvidia/t410/uncore-nvclink.json     |  67 ++++++++++
 .../arm64/nvidia/t410/uncore-nvdlink.json     |  43 +++++++
 .../arm64/nvidia/t410/uncore-nvlink_c2c.json  | 115 ++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvclink.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvdlink.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvlink_c2c.json

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvclink.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvclink.json
new file mode 100644
index 000000000000..1e7f8115ff9c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvclink.json
@@ -0,0 +1,67 @@
+[
+    {
+        "EventCode": "0x0",
+        "EventName": "NVCLINK_CYCLES",
+        "BriefDescription": "Counts NV-CLink interface clock cycles.",
+        "PublicDescription": "Counts NV-CLink interface clock cycles. All NV-CLink instances share this clock, so the count is read from the first instance.",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "NVCLINK_IN_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding incoming read requests counted by NVCLINK_IN_RD_REQ each NV-CLink interface cycle.",
+        "PublicDescription": "Accumulates the outstanding incoming read requests counted by NVCLINK_IN_RD_REQ each NV-CLink interface cycle. Pair the two for the average read latency.",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "NVCLINK_IN_RD_REQ",
+        "BriefDescription": "Counts incoming read requests from the remote Tegra SoC at the NV-CLink interface.",
+        "PublicDescription": "Counts incoming read requests from the remote Tegra SoC at the NV-CLink interface, where local memory or a local device responds with data. Request size can be from 1 to 256 bytes. The count is summed over all NV-CLink instances.",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "EventCode": "0x5",
+        "EventName": "NVCLINK_OUT_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding outgoing read requests counted by NVCLINK_OUT_RD_REQ each NV-CLink interface cycle.",
+        "PublicDescription": "Accumulates the outstanding outgoing read requests counted by NVCLINK_OUT_RD_REQ each NV-CLink interface cycle. Pair the two for the average read latency.",
+        "Unit": "nvidia_nvclink_pmu_"
+    },
+    {
+        "EventCode": "0x6",
+        "EventName": "NVCLINK_OUT_RD_REQ",
+        "BriefDescription": "Counts outgoing read requests from the local Tegra SoC to the remote Tegra SoC at the NV-CLink interface.",
+        "PublicDescription": "Counts outgoing read requests from the local Tegra SoC to the remote Tegra SoC at the NV-CLink interface, where memory on the remote Tegra SoC responds with data. Request size can be from 1 to 256 bytes. The count is summed over all NV-CLink instances.",
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
+        "Unit": "nvidia_nvclink_pmu_"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvdlink.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvdlink.json
new file mode 100644
index 000000000000..7777add3741d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvdlink.json
@@ -0,0 +1,43 @@
+[
+    {
+        "EventCode": "0x0",
+        "EventName": "NVDLINK_CYCLES",
+        "BriefDescription": "Counts NV-DLink interface clock cycles.",
+        "PublicDescription": "Counts NV-DLink interface clock cycles. All NV-DLink instances share this clock, so the count is read from the first instance.",
+        "Unit": "nvidia_nvdlink_pmu_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "NVDLINK_IN_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding read requests counted by NVDLINK_IN_RD_REQ each NV-DLink interface cycle.",
+        "PublicDescription": "Accumulates the outstanding read requests counted by NVDLINK_IN_RD_REQ each NV-DLink interface cycle. Pair the two for the average read latency.",
+        "Unit": "nvidia_nvdlink_pmu_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "NVDLINK_IN_RD_REQ",
+        "BriefDescription": "Counts read requests to local CXL memory at the NV-DLink interface.",
+        "PublicDescription": "Counts read requests to local CXL memory at the NV-DLink interface, from all requesters, local and remote. Request size can be from 1 to 256 bytes. The count is summed over all NV-DLink instances.",
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
+        "Unit": "nvidia_nvdlink_pmu_"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvlink_c2c.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvlink_c2c.json
new file mode 100644
index 000000000000..48a64caaba61
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvlink_c2c.json
@@ -0,0 +1,115 @@
+[
+    {
+        "EventCode": "0x0",
+        "EventName": "NVLINK_C2C_CYCLES",
+        "BriefDescription": "Counts NVLink-C2C interface clock cycles.",
+        "PublicDescription": "Counts NVLink-C2C interface clock cycles. All NVLink-C2C instances share this clock, so the count is read from the first instance.",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "NVLINK_C2C_IN_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding incoming read requests counted by NVLINK_C2C_IN_RD_REQ each NVLink-C2C interface cycle.",
+        "PublicDescription": "Accumulates the outstanding incoming read requests counted by NVLINK_C2C_IN_RD_REQ each NVLink-C2C interface cycle. Pair the two for the average read latency. The gpu_mask filter works as described for NVLINK_C2C_IN_RD_REQ.",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "NVLINK_C2C_IN_RD_REQ",
+        "BriefDescription": "Counts incoming read requests from connected GPUs or a remote Tegra SoC at the NVLink-C2C interface.",
+        "PublicDescription": "Counts incoming read requests sent by connected GPUs or a remote Tegra SoC to the local Tegra SoC at the NVLink-C2C interface, where the local Tegra SoC responds with data. Request size can be from 1 to 256 bytes. The count is summed over all NVLink-C2C instances. Filters: the gpu_mask filter selects GPUs by index, one bit per GPU. This filter is available only when GPUs are connected. An unset gpu_mask counts all GPUs.",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x3",
+        "EventName": "NVLINK_C2C_IN_WR_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding incoming write requests counted by NVLINK_C2C_IN_WR_REQ each NVLink-C2C interface cycle.",
+        "PublicDescription": "Accumulates the outstanding incoming write requests counted by NVLINK_C2C_IN_WR_REQ each NVLink-C2C interface cycle. Available only when GPUs are connected. Pair the two for the average write latency. The gpu_mask filter works as described for NVLINK_C2C_IN_WR_REQ.",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x4",
+        "EventName": "NVLINK_C2C_IN_WR_REQ",
+        "BriefDescription": "Counts incoming write requests from connected GPUs to the local Tegra SoC at the NVLink-C2C interface.",
+        "PublicDescription": "Counts incoming write requests sent by connected GPUs to the local Tegra SoC at the NVLink-C2C interface, where the GPU sends the data. Request size can be from 1 to 256 bytes. Available only when GPUs are connected. The count is summed over all NVLink-C2C instances. Filters: the gpu_mask filter selects GPUs by index, one bit per GPU. An unset gpu_mask counts all GPUs.",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x5",
+        "EventName": "NVLINK_C2C_OUT_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding outgoing read requests counted by NVLINK_C2C_OUT_RD_REQ each NVLink-C2C interface cycle.",
+        "PublicDescription": "Accumulates the outstanding outgoing read requests counted by NVLINK_C2C_OUT_RD_REQ each NVLink-C2C interface cycle. Pair the two for the average read latency. The gpu_mask filter works as described for NVLINK_C2C_OUT_RD_REQ.",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x6",
+        "EventName": "NVLINK_C2C_OUT_RD_REQ",
+        "BriefDescription": "Counts outgoing read requests to connected GPUs or a remote Tegra SoC at the NVLink-C2C interface.",
+        "PublicDescription": "Counts outgoing read requests from all requesters to connected GPUs or a remote Tegra SoC at the NVLink-C2C interface, where the GPU or remote Tegra SoC responds with data. Request size can be from 1 to 256 bytes. The count is summed over all NVLink-C2C instances. Filters: the gpu_mask filter selects GPUs by index, one bit per GPU. This filter is available only when GPUs are connected. An unset gpu_mask counts all GPUs.",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x7",
+        "EventName": "NVLINK_C2C_OUT_WR_CUM_OUTS",
+        "BriefDescription": "Accumulates the outstanding outgoing write requests counted by NVLINK_C2C_OUT_WR_REQ each NVLink-C2C interface cycle.",
+        "PublicDescription": "Accumulates the outstanding outgoing write requests counted by NVLINK_C2C_OUT_WR_REQ each NVLink-C2C interface cycle. Available only when GPUs are connected. Pair the two for the average write latency. The gpu_mask filter works as described for NVLINK_C2C_OUT_WR_REQ.",
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    },
+    {
+        "EventCode": "0x8",
+        "EventName": "NVLINK_C2C_OUT_WR_REQ",
+        "BriefDescription": "Counts outgoing write requests to connected GPUs at the NVLink-C2C interface.",
+        "PublicDescription": "Counts outgoing write requests from all requesters to connected GPUs at the NVLink-C2C interface, where the requester sends the data. Request size can be from 1 to 256 bytes. Available only when GPUs are connected. The count is summed over all NVLink-C2C instances. Filters: the gpu_mask filter selects GPUs by index, one bit per GPU. An unset gpu_mask counts all GPUs.",
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
+        "Unit": "nvidia_nvlink_c2c_pmu_"
+    }
+]
-- 
2.43.0


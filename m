Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5E30567D;
	Mon, 12 Oct 2026 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791736; cv=fail; b=KDSaiqUzKQVZy/vgVbxpfTJGr6NKVli8KEOF6pZ7+QLpWdGbvC/3ynHq546S525AM3OkiSy06L4zk9s0SE9BA0D9QEFUEb8i+6TnqDsu4LDxPNy0YwiEQ5HX+ZpOOOQwPmhRY+S3FvzV20N/OuIQ5h8Vl2FgQmONTbrtRiciB70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791736; c=relaxed/simple;
	bh=3bEbZH/zL8EFLbTAhdWHpYb4NVf8eTRkcwelWJamrZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujueFxI3A9vE6zjo3+4yI7wMweg8siEhyumPMvVcrQ/+V0H+FM0ktvR9fEUiFGhFK3eKDIH9PqSmRMszShfO9U/vvT4Z9VqgR+xU9saiUleCexCZ4xLMazFb8zqwEJuiQaS9r07dEbN3ShfKx0aqniIQikl1qUIsxGv1dhy2lNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w5asGKEk; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w5asGKEk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fR2gGaXdh+6db8tdRlsBTbj2yHxN2FpPy8955kMCXpq2N+OwaRT7qsSRDU/Tl3cQuRsORmltRhHawKRxePuD3OrRI50Nr2+Me3IMX7C5uL9vJYL5jFJGpTY+xyWHcBGYq/XZeRE0KjJL7T6c+NSo1bBGEX82Z4CBhIZkXdOrGcIl7qiBV8jzWPZ8nIE58OXGh0JcKLS9tX4OBt2DM66uslSvpl/31acErWqFXSFPSxRPD42twNVqLVEGiAhAkAodYg/olYouzgNjrp1YuxGGmCavqBfNPpxrvoh4dc8wjsZq2+581ujPl99B/LJgOncVkzQTlBfHqYkSP65kZfWV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAMiX3RPmzOB5aN4Zu0mDtwBiZ20j4v6oDH/dH+jLz8=;
 b=oFLxnnddIapnRPLSSmbXIA5SGamwq40rBX5j4GuClzyS62NiCrC6nww8jKRlnTnPmZC1fbWKqK/4+jMORcFMlpV2QY/iFeuLU+JoNlYfLmI2avE/47t5wkXdcwQ5K4WqDDrjH4eUajWIa6t2yG7bFGkISc3716F/w/TfCUqnN88owVqOKt4xq7u2hC5ya4gmDCYtaEyyEonHGVy20YeoZXlBBT6Z0k3D/gP90KtXVTpRanWwsKoXbHJFioJ0usJFLQxbZx+NSugCOs962JGZV8ekothAPoMuP8r3+86GLXvGNyvv0G7T5o8si+VzmocaEsx1kyBFdYxSOqNSKp7xJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAMiX3RPmzOB5aN4Zu0mDtwBiZ20j4v6oDH/dH+jLz8=;
 b=w5asGKEkzxVgdGRcOHbjOkuBD0cxEAqg3Z+KZmKIBizX6b+ccY5O18Uj1sUDc0rzFqFu9XGin265zoKpJhgKn0QjMf3qV/VNdWOj4RR04UgnNceqgv4iy8HWh3tehjpMHvcbi7qTIxG4HEGANg3GUCkOB9bdNwQjv1Qs8eeJl94=
Received: from BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Mon, 12 Oct
 2026 07:55:20 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::34) by BL0PR05CA0009.outlook.office365.com
 (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 12
 Oct 2026 07:55:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 07:55:20 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 02:55:08 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 1/3] perf vendor events amd: Add Zen 6 data fabric events
Date: Mon, 12 Oct 2026 13:23:30 +0530
Message-ID: <9ae74ab1337b627f06f1cfb9e5c91c6e42ac6284.1791791463.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791791463.git.sandipan.das@amd.com>
References: <cover.1791791463.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: feb50e07-4757-4f94-b3be-08df283629c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|23010399003|11063799006|18002099003|56012099006|6133799003|10067099003|22082099003|261009223027099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	S/3aFhIUI2cWqrAh95ZBh/kWbrmk5KnIrJjTAa7YHJepKLhFkLfk86Bk6b53KHBWCpPKmvBSD4rsqI9nbmpeAsRvSpawlaX5DmVIGS1+gRWk1bnzhWFQiFCQDLWh4kafsanGyop89zgYVzL1o8VUS44OaC58N3FpycQhRPwNIYeaOGzBGgdx2QXks32HSSgd+Rpbl5rEqnEv6yQps+jMTxFGIWnCBfWoFA7eMro0vaV8509pJYoyP5GuhWIefke7n/rOImYHjqtZvcHoFOFCLSR1yBI/Mx74+LAOg+focosl1t+J1d1aCTHOPNmUkYNWbma7rGzCmOZTj5uK00wK96wpjlmOTqaQJPOtxivRbyOnxdTzwt9pMizI8ul3f0S6jQyaEaZfb/OPdVnT/QvzBsi0I6vL5Q4Ui3lAb5/s9jIwCCNwdZSr98x3Kk5GpNfKucUyMGWXhI9tztxsNficyKiz7G1Xtpb1y388wzmaxCMARzQG1SFAWsJFpSdV6EsUkI+Ts3Qt/6amSUHkPecIGwYoWoOxAQlN4ktQENOVGTBKXhfvJQlvQCBYmP8WYr9Gkl1kEyEf4LpOk3jDO2Le0Fm60J1ScfPSoAhYvmFatZYSW3S1i7DVEBTlys7USZJQ5t875JoZkiVoXAAU9P46Xw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(23010399003)(11063799006)(18002099003)(56012099006)(6133799003)(10067099003)(22082099003)(261009223027099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZGmIFyfaxh00I282rGcDBwO/hSqixvShhD+PJwpm3Og25D3VGkfWiF0KMbT3ZquByKkDn9bhJaS7rmmYV461pzjUnQSRJ0EGh+xLIyViqLksMeDKNdoCk14z40wgiFM+Rw/zq+SKmowUiPfkapqrTqTgrgzPqoCVD/JzMfP9CAo2JRCQjtgQbsg4Plb8WzDEbMIBd7TJZ8h/RohwVngwsDFK79Y3giOuW8OWb2rHiro0BwYeNPhXKWbak4V5xyYvOUZytUzJxiONexTciM4RyyuxZkucw8y1kfrdZf/4QBhGx7b2sLFGfRWhEEbPPUOAX1O5fviaLrldjb2s1ZMU2wwrgKa9pcbanXfDFQILAkvTjO9h4DV6e12F7mYudznvQIJ5ib5ARskJQJpgw0Egf3sTvDJkV3mcYvs78+FoYxcS2oGqq6xtvkK2SbRMRLGq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:55:20.3566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb50e07-4757-4f94-b3be-08df283629c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990

Add Zen 6 data fabric events sourced from Section 8.1 titled "Fabric
Performance Monitor Counter (PMC) Events" of the Processor Programming
Reference (PPR) for AMD Family 1Ah Model 51h Revision B0 processors,
available at the link below.

The events are primarily meant to monitor the flow of data at various
links and interfaces within the Data Fabric.

Unlike previous generations, the events do not set "PerPkg". On Zen 6
processors, a socket can have up to two IODs, each with its own Data
Fabric instance. Perf de-duplicates "PerPkg" counts by socket and die,
but the two IODs do not show up as separate domains in the topology
information. Setting "PerPkg" would therefore drop the counts from the
second IOD. The trade-off is that counts are no longer de-duplicated if
a CPU list with multiple CPUs from the same IOD is specified with "-C".

Link: https://bugzilla.kernel.org/attachment.cgi?id=311021
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen6/data-fabric.json         | 1542 +++++++++++++++++
 1 file changed, 1542 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/data-fabric.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/data-fabric.json b/tools/perf/pmu-events/arch/x86/amdzen6/data-fabric.json
new file mode 100644
index 000000000000..33ecbe35b5a9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/data-fabric.json
@@ -0,0 +1,1542 @@
+[
+  {
+    "EventName": "pie_general.fclk",
+    "PublicDescription": "Fabric Clock (FCLK) cycles.",
+    "EventCode": "0xc80",
+    "UMask": "0x001",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_0.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 0.",
+    "EventCode": "0x01f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_0.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 0.",
+    "EventCode": "0x01f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_0.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 0.",
+    "EventCode": "0x01f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_0.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 0.",
+    "EventCode": "0x01f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_0.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 0.",
+    "EventCode": "0x01f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_0.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 0.",
+    "EventCode": "0x01f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_1.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 1.",
+    "EventCode": "0x05f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_1.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 1.",
+    "EventCode": "0x05f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_1.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 1.",
+    "EventCode": "0x05f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_1.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 1.",
+    "EventCode": "0x05f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_1.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 1.",
+    "EventCode": "0x05f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_1.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 1.",
+    "EventCode": "0x05f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_2.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 2.",
+    "EventCode": "0x09f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_2.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 2.",
+    "EventCode": "0x09f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_2.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 2.",
+    "EventCode": "0x09f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_2.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 2.",
+    "EventCode": "0x09f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_2.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 2.",
+    "EventCode": "0x09f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_2.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 2.",
+    "EventCode": "0x09f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_3.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 3.",
+    "EventCode": "0x0df",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_3.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 3.",
+    "EventCode": "0x0df",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_3.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 3.",
+    "EventCode": "0x0df",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_3.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 3.",
+    "EventCode": "0x0df",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_3.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 3.",
+    "EventCode": "0x0df",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_3.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 3.",
+    "EventCode": "0x0df",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_4.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 4.",
+    "EventCode": "0x11f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_4.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 4.",
+    "EventCode": "0x11f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_4.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 4.",
+    "EventCode": "0x11f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_4.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 4.",
+    "EventCode": "0x11f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_4.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 4.",
+    "EventCode": "0x11f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_4.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 4.",
+    "EventCode": "0x11f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_5.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 5.",
+    "EventCode": "0x15f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_5.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 5.",
+    "EventCode": "0x15f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_5.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 5.",
+    "EventCode": "0x15f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_5.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 5.",
+    "EventCode": "0x15f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_5.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 5.",
+    "EventCode": "0x15f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_5.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 5.",
+    "EventCode": "0x15f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_6.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 6.",
+    "EventCode": "0x19f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_6.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 6.",
+    "EventCode": "0x19f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_6.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 6.",
+    "EventCode": "0x19f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_6.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 6.",
+    "EventCode": "0x19f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_6.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 6.",
+    "EventCode": "0x19f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_6.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 6.",
+    "EventCode": "0x19f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_7.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 7.",
+    "EventCode": "0x1df",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_7.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 7.",
+    "EventCode": "0x1df",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_7.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 7.",
+    "EventCode": "0x1df",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_7.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 7.",
+    "EventCode": "0x1df",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_7.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 7.",
+    "EventCode": "0x1df",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_7.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 7.",
+    "EventCode": "0x1df",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_8.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 8.",
+    "EventCode": "0x21f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_8.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 8.",
+    "EventCode": "0x21f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_8.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 8.",
+    "EventCode": "0x21f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_8.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 8.",
+    "EventCode": "0x21f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_8.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 8.",
+    "EventCode": "0x21f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_8.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 8.",
+    "EventCode": "0x21f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_9.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 9.",
+    "EventCode": "0x25f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_9.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 9.",
+    "EventCode": "0x25f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_9.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 9.",
+    "EventCode": "0x25f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_9.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 9.",
+    "EventCode": "0x25f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_9.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 9.",
+    "EventCode": "0x25f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_9.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 9.",
+    "EventCode": "0x25f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_10.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 10.",
+    "EventCode": "0x29f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_10.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 10.",
+    "EventCode": "0x29f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_10.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 10.",
+    "EventCode": "0x29f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_10.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 10.",
+    "EventCode": "0x29f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_10.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 10.",
+    "EventCode": "0x29f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_10.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 10.",
+    "EventCode": "0x29f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_11.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 11.",
+    "EventCode": "0x2df",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_11.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 11.",
+    "EventCode": "0x2df",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_11.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 11.",
+    "EventCode": "0x2df",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_11.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 11.",
+    "EventCode": "0x2df",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_11.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 11.",
+    "EventCode": "0x2df",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_11.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 11.",
+    "EventCode": "0x2df",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_12.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 12.",
+    "EventCode": "0x31f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_12.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 12.",
+    "EventCode": "0x31f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_12.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 12.",
+    "EventCode": "0x31f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_12.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 12.",
+    "EventCode": "0x31f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_12.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 12.",
+    "EventCode": "0x31f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_12.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 12.",
+    "EventCode": "0x31f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_13.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 13.",
+    "EventCode": "0x35f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_13.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 13.",
+    "EventCode": "0x35f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_13.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 13.",
+    "EventCode": "0x35f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_13.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 13.",
+    "EventCode": "0x35f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_13.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 13.",
+    "EventCode": "0x35f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_13.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 13.",
+    "EventCode": "0x35f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_14.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 14.",
+    "EventCode": "0x39f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_14.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 14.",
+    "EventCode": "0x39f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_14.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 14.",
+    "EventCode": "0x39f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_14.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 14.",
+    "EventCode": "0x39f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_14.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 14.",
+    "EventCode": "0x39f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_14.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 14.",
+    "EventCode": "0x39f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_15.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for Coherent Station (CS) 15.",
+    "EventCode": "0x3df",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_15.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for Coherent Station (CS) 15.",
+    "EventCode": "0x3df",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_15.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for Coherent Station (CS) 15.",
+    "EventCode": "0x3df",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_15.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for Coherent Station (CS) 15.",
+    "EventCode": "0x3df",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_15.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for Coherent Station (CS) 15.",
+    "EventCode": "0x3df",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_cs_15.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for Coherent Station (CS) 15.",
+    "EventCode": "0x3df",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_0.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 0.",
+    "EventCode": "0x41e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_0.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 0.",
+    "EventCode": "0x41e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_0.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 0.",
+    "EventCode": "0x41e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_0.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 0.",
+    "EventCode": "0x41e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_0.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 0.",
+    "EventCode": "0x41e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_0.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 0.",
+    "EventCode": "0x41e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_1.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 1.",
+    "EventCode": "0x45e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_1.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 1.",
+    "EventCode": "0x45e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_1.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 1.",
+    "EventCode": "0x45e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_1.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 1.",
+    "EventCode": "0x45e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_1.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 1.",
+    "EventCode": "0x45e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_1.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 1.",
+    "EventCode": "0x45e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_2.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 2.",
+    "EventCode": "0x49e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_2.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 2.",
+    "EventCode": "0x49e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_2.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 2.",
+    "EventCode": "0x49e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_2.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 2.",
+    "EventCode": "0x49e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_2.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 2.",
+    "EventCode": "0x49e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_2.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 2.",
+    "EventCode": "0x49e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_3.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 3.",
+    "EventCode": "0x4de",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_3.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 3.",
+    "EventCode": "0x4de",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_3.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 3.",
+    "EventCode": "0x4de",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_3.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 3.",
+    "EventCode": "0x4de",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_3.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 3.",
+    "EventCode": "0x4de",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_3.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 3.",
+    "EventCode": "0x4de",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_4.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 4.",
+    "EventCode": "0x51e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_4.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 4.",
+    "EventCode": "0x51e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_4.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 4.",
+    "EventCode": "0x51e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_4.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 4.",
+    "EventCode": "0x51e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_4.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 4.",
+    "EventCode": "0x51e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_4.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 4.",
+    "EventCode": "0x51e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_5.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 5.",
+    "EventCode": "0x55e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_5.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 5.",
+    "EventCode": "0x55e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_5.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 5.",
+    "EventCode": "0x55e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_5.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 5.",
+    "EventCode": "0x55e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_5.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 5.",
+    "EventCode": "0x55e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_5.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 5.",
+    "EventCode": "0x55e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_6.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 6.",
+    "EventCode": "0x59e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_6.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 6.",
+    "EventCode": "0x59e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_6.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 6.",
+    "EventCode": "0x59e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_6.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 6.",
+    "EventCode": "0x59e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_6.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 6.",
+    "EventCode": "0x59e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_6.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 6.",
+    "EventCode": "0x59e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_7.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 7.",
+    "EventCode": "0x5de",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_7.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 7.",
+    "EventCode": "0x5de",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_7.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 7.",
+    "EventCode": "0x5de",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_7.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 7.",
+    "EventCode": "0x5de",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_7.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 7.",
+    "EventCode": "0x5de",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_7.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 7.",
+    "EventCode": "0x5de",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_8.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 8.",
+    "EventCode": "0x61e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_8.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 8.",
+    "EventCode": "0x61e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_8.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 8.",
+    "EventCode": "0x61e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_8.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 8.",
+    "EventCode": "0x61e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_8.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 8.",
+    "EventCode": "0x61e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_8.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 8.",
+    "EventCode": "0x61e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_9.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 9.",
+    "EventCode": "0x65e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_9.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 9.",
+    "EventCode": "0x65e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_9.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 9.",
+    "EventCode": "0x65e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_9.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 9.",
+    "EventCode": "0x65e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_9.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 9.",
+    "EventCode": "0x65e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_9.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 9.",
+    "EventCode": "0x65e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_10.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 10.",
+    "EventCode": "0x69e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_10.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 10.",
+    "EventCode": "0x69e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_10.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 10.",
+    "EventCode": "0x69e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_10.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 10.",
+    "EventCode": "0x69e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_10.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 10.",
+    "EventCode": "0x69e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_10.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 10.",
+    "EventCode": "0x69e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_11.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 11.",
+    "EventCode": "0x6de",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_11.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 11.",
+    "EventCode": "0x6de",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_11.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 11.",
+    "EventCode": "0x6de",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_11.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 11.",
+    "EventCode": "0x6de",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_11.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 11.",
+    "EventCode": "0x6de",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_11.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 11.",
+    "EventCode": "0x6de",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_12.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 12.",
+    "EventCode": "0x71e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_12.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 12.",
+    "EventCode": "0x71e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_12.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 12.",
+    "EventCode": "0x71e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_12.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 12.",
+    "EventCode": "0x71e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_12.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 12.",
+    "EventCode": "0x71e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_12.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 12.",
+    "EventCode": "0x71e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_13.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 13.",
+    "EventCode": "0x75e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_13.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 13.",
+    "EventCode": "0x75e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_13.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 13.",
+    "EventCode": "0x75e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_13.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 13.",
+    "EventCode": "0x75e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_13.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 13.",
+    "EventCode": "0x75e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_13.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 13.",
+    "EventCode": "0x75e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_14.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 14.",
+    "EventCode": "0x79e",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_14.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 14.",
+    "EventCode": "0x79e",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_14.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 14.",
+    "EventCode": "0x79e",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_14.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 14.",
+    "EventCode": "0x79e",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_14.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 14.",
+    "EventCode": "0x79e",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_14.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 14.",
+    "EventCode": "0x79e",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_15.rd_local",
+    "PublicDescription": "Local inbound data beats (32 bytes each) for CPU Moderator (CCM) 15.",
+    "EventCode": "0x7de",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_15.wr_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for CPU Moderator (CCM) 15.",
+    "EventCode": "0x7de",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_15.rd_remote",
+    "PublicDescription": "Remote inbound data beats (32 bytes each) for CPU Moderator (CCM) 15.",
+    "EventCode": "0x7de",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_15.wr_remote",
+    "PublicDescription": "Remote outbound data beats (64 bytes each) for CPU Moderator (CCM) 15.",
+    "EventCode": "0x7de",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_15.rd_all",
+    "PublicDescription": "All (local and remote) inbound data beats (32 bytes each) for CPU Moderator (CCM) 15.",
+    "EventCode": "0x7de",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_ccm_15.wr_all",
+    "PublicDescription": "All (local and remote) outbound data beats (64 bytes each) for CPU Moderator (CCM) 15.",
+    "EventCode": "0x7de",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_0.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for IO Moderator (IOM) 0.",
+    "EventCode": "0x8df",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_0.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for IO Moderator (IOM) 0.",
+    "EventCode": "0x8df",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_0.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for IO Moderator (IOM) 0.",
+    "EventCode": "0x8df",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_0.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for IO Moderator (IOM) 0.",
+    "EventCode": "0x8df",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_0.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for IO Moderator (IOM) 0.",
+    "EventCode": "0x8df",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_0.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for IO Moderator (IOM) 0.",
+    "EventCode": "0x8df",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_1.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for IO Moderator (IOM) 1.",
+    "EventCode": "0x91f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_1.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for IO Moderator (IOM) 1.",
+    "EventCode": "0x91f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_1.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for IO Moderator (IOM) 1.",
+    "EventCode": "0x91f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_1.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for IO Moderator (IOM) 1.",
+    "EventCode": "0x91f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_1.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for IO Moderator (IOM) 1.",
+    "EventCode": "0x91f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_1.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for IO Moderator (IOM) 1.",
+    "EventCode": "0x91f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_2.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for IO Moderator (IOM) 2.",
+    "EventCode": "0x95f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_2.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for IO Moderator (IOM) 2.",
+    "EventCode": "0x95f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_2.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for IO Moderator (IOM) 2.",
+    "EventCode": "0x95f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_2.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for IO Moderator (IOM) 2.",
+    "EventCode": "0x95f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_2.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for IO Moderator (IOM) 2.",
+    "EventCode": "0x95f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_2.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for IO Moderator (IOM) 2.",
+    "EventCode": "0x95f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_3.rd_local",
+    "PublicDescription": "Local read data beats (64 bytes each) for IO Moderator (IOM) 3.",
+    "EventCode": "0x89f",
+    "UMask": "0x7fe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_3.wr_local",
+    "PublicDescription": "Local write data beats (64 bytes each) for IO Moderator (IOM) 3.",
+    "EventCode": "0x89f",
+    "UMask": "0x7ff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_3.rd_remote",
+    "PublicDescription": "Remote read data beats (64 bytes each) for IO Moderator (IOM) 3.",
+    "EventCode": "0x89f",
+    "UMask": "0xbfe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_3.wr_remote",
+    "PublicDescription": "Remote write data beats (64 bytes each) for IO Moderator (IOM) 3.",
+    "EventCode": "0x89f",
+    "UMask": "0xbff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_3.rd_all",
+    "PublicDescription": "All (local and remote) read data beats (64 bytes each) for IO Moderator (IOM) 3.",
+    "EventCode": "0x89f",
+    "UMask": "0xffe",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_iom_3.wr_all",
+    "PublicDescription": "All (local and remote) write data beats (64 bytes each) for IO Moderator (IOM) 3.",
+    "EventCode": "0x89f",
+    "UMask": "0xfff",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_link_0.out_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for Infinity Fabric Link (LINK) 0.",
+    "EventCode": "0xe1f",
+    "UMask": "0xf3e",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_link_1.out_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for Infinity Fabric Link (LINK) 1.",
+    "EventCode": "0xe5f",
+    "UMask": "0xf3e",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "data_beats_link_2.out_local",
+    "PublicDescription": "Local outbound data beats (64 bytes each) for Infinity Fabric Link (LINK) 2.",
+    "EventCode": "0xe9f",
+    "UMask": "0xf3e",
+    "Unit": "DFPMC"
+  }
+]
-- 
2.53.0


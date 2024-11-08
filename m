Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020122.outbound.protection.outlook.com [40.93.198.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B91A9B2D;
	Fri,  8 Nov 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097782; cv=fail; b=TL6VTx0ehBTb15wo19CLIKt5/KUTKgCmywJ62I00e/GRWMBCWgmoyZZ9ip2HudY4CCy+uq83yRfJAKmpcKm3CzHn0VB9304hBs7KAML4riDoh02HWUu3EWuAwmmP1gNt/16DqKHBEpdSLNpLmlWsrAGl4HfGigNQ0363SrFGMgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097782; c=relaxed/simple;
	bh=eDx2zlyfigM5GcSDZpQy4DUJtUnDowLmuljWmhCqLZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QM7pPpoFNskjByyK4qT+8JtuguN/3H0N0gnIrYhW/DI1y3utX5NJkmhBxXIwgvTn41NHBfwx0brhvvKZHcsnN1S2DjQHSZRKqEkmAi9WFUSzKxZYCR3ygz7xAzqLKA7iGJZhFcV8rwNFQ1XwZ2kmMmgQp/YG4APEVxTyBMlycSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nBbeDXBB; arc=fail smtp.client-ip=40.93.198.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nBbeDXBB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9QcgqaJzGcitk296IeJ49BLOfTna9BbHdJkWsjR/aiOEneKswLBu9DhAbPSSVwl6M9cOCAQH+smsLGDrx5yS3U9+nJRzK8tFEBvx1zzASPxRrP/Inxd94NHPuODdfSRgxy+J0QueNdPTmRfUppk71cDMI9wucr1MKzXDhVifEkgpyLGryF0tsrICSlk2OkhAcMdtlKo6pRD8WlbjbMyGa93ATNvuCnE5ld6GRe/lod8gCmd+RHHhGy5Y2+eqw6owYEklXO/EMFVaHwPjstYib84lEJ3u+mk5Rdhe+lgpsAx1y3BfxBmD8ZPfw0G2M7IngsduIY7ejlQTR8LqS1hBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrmErlUgJSCq4FyTHpIzCmE72M0GQFr4VFXVm+indVQ=;
 b=oNoKwp989r8aYuhE19wBKssUEYyNxw/6lJUVrPpF6H3Yu1A+GmwB1weBETy6OsVdibLopCF68oOIRC1RroQqMs/cY6WWAb14mXMb35emy2VVMulVMc2oCmHwtfyWpVOOWnErgHLfb6G44dYJ+uIbOaKN0Rno4UWGdlvkA9FQl3AwTgV/Xl5kPJBEXCS84S6leyxifZM9yfpKm67ivK16zDZEbDpGZymYlwIO5RXoctzvGnhjrXdN8a+7XzITEBQq6QPFW/08kSi01Z9DqErDUxZEF6keaceZ+4bUoU7fPNOJNeg/G0oLxeudxL1cHLQHDlg8gNJpJ/dT3nif9bbe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrmErlUgJSCq4FyTHpIzCmE72M0GQFr4VFXVm+indVQ=;
 b=nBbeDXBBVUQBawnnuMInObBxF3Enrm+BUzBy/qCIqlrKR4df4WG/Bqf4fCNcgwh29j6WIvT/DLLj4A4OzZXWYAfEZtNnbjp9FEZczq9rDZAMui0eXpqQh93eDgGiDUysa2LfOV+Iayc/LVSBBw0ytyWY0gjIW49ARtqPzN58W24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CH0PR01MB6841.prod.exchangelabs.com (2603:10b6:610:110::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Fri, 8 Nov 2024 20:29:33 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 20:29:33 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] perf arm-spe: Add support for SPE Data Source packet on AmpereOne
Date: Fri,  8 Nov 2024 20:29:46 +0000
Message-ID: <20241108202946.16835-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108202946.16835-1-ilkka@os.amperecomputing.com>
References: <20241108202946.16835-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CH0PR01MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df1dd23-d471-4601-bc45-08dd00340e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IR1gY6pkPzHHO7ZF7U23W/cgAkpLjVIh7GBpNVqFzgbQbg8wGgmPXq3++lNk?=
 =?us-ascii?Q?1wHt3NP3fCPIzXGEgfUdSFYZawucwKy//3KhsAlA/OlWybnCa6+mRg1XbpUT?=
 =?us-ascii?Q?5SyeUe5Tx2IOlWWZucbGSyRnBA/p9JNCx7YKnuWmnlQjRhOohBlrDBozAebG?=
 =?us-ascii?Q?AeSKIqpEJ7sKk5PX2U6VpbDUQkE4PupCdq43jgprsV/1EgULcLCH0/uby1lK?=
 =?us-ascii?Q?sIUnZtcA82NURycxy/n9BLV204FF+gSTEdD9J8I157hStvk2cATC/q0kE+I9?=
 =?us-ascii?Q?0NY4lnF0u9bheyPU8AexOi0ArLQoxA0tEmHNLLZlb1wfMVHuPc0TozEXMKK9?=
 =?us-ascii?Q?c2o8a3Jqi5wpMfOkTkbhvFsEV75n9zwYayXrUDY3hG1cEQGgyLjNZ0CPjdfs?=
 =?us-ascii?Q?F5ws5R9SPYNT9zruvsa7msRQ7rU/vFr7XPAR/9isypmdOiyoFyD2GJskfrK/?=
 =?us-ascii?Q?jBvdeo57OEMLiCwRDLSy3bjBmcJZN5RQ1zK3VPf3a5ynVDC13zZM/Ykk1KY/?=
 =?us-ascii?Q?KOG49ad6GpN5NOpluAh3mlz6yCfXcy9z8kG1JXYDNdj7h+uLYR/9LH005ezo?=
 =?us-ascii?Q?Ndw8vL2edqDKJ8d43z5wudq7KShSD2bbT209RMa58MVQ3sx4B3zS7xffxrW9?=
 =?us-ascii?Q?dm6oSC6WAzPKo2Yw0pn7EYj94UNZzWcwcn59OZrL6vAItQl84nvyk1RWsR5s?=
 =?us-ascii?Q?6QEKfEvBHEqZ0YDBh/ONBTWrRehMex9BPcpcC0FB70P+6GaDw2gu+IRIFZ9a?=
 =?us-ascii?Q?LbXuV8uPJPCIW0d1EKKq5PeBcmdwOaLun7zBrq8CZqrzAYgQpgDrYb8Vkkbf?=
 =?us-ascii?Q?VlRQhrcCrO4ymxqEaMaHolAm7zPqXKHaldl0dUgLJGhElVUDh2ZzYL1msIGn?=
 =?us-ascii?Q?LLLmzVmWFjB0R3R8w1ZdnOWpQByA1iQBEl8g0kUTu8CGNNnACxtgCT+H9Uv5?=
 =?us-ascii?Q?/lAPzSaRNmeSZ49I/Wv2yo69M1YM3a3ttydbuANc94bLldljQO2VTd/jgbf5?=
 =?us-ascii?Q?y6eA+Au/VGmP8+xSyajrueS4ZqFGm+41zEL6oVyMmgFXc0X+JWUHWGFC8FkX?=
 =?us-ascii?Q?Io0yfnYultsx0BiC5AcqfTh/Uh94TlIogRpQFl6m+6yKVZIFgushyqwWJ1R6?=
 =?us-ascii?Q?w27dlaLZUEiiACfX2d+zuGLVLRHQlHRLn0AKTNoeJ7gLKd+9NppEmIcYUiKC?=
 =?us-ascii?Q?M1JZilr0HgeBHi82deS0aUlK70+olwN2qGuush7AmHpTg4IxoL9gEA3YHuL2?=
 =?us-ascii?Q?vrB3naPqakGgwBj0F/hf98UgzUDzGMk5KYfcwr0JKZKKye/2Bd3SgZHtlzgb?=
 =?us-ascii?Q?72TBCZPaKjPvWcfrBARpQX9bMS2lh7LALTX6PQe0mqBikOBmNEvMi0hecTwY?=
 =?us-ascii?Q?aDTTE0zJ5mdZ+3nrDnta0bQwWsi9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yykkbOqlzvIGv8FOSFfDopY6XEDI2QQSgFd35OVrzOOHgYFMPYMzsd5CwvPY?=
 =?us-ascii?Q?+bnEiWiwJqvVC8aio/e1wCSme788FhsBU8zECNXzOwlSJYhk01L7iMUXphbu?=
 =?us-ascii?Q?sd1m4vTxVj971nesiNSZIJseotYgV7BWbparrJshMtVBNE3z8V2HajoNabcp?=
 =?us-ascii?Q?raGQfaPHkWReR2C4c1jbpO94lcnWTIZ/fi5p2upetzEZfrxNbpHq1wAM+1BU?=
 =?us-ascii?Q?NTqX1JwGaLMNCXkX8QhbRF8gFBUHIsq865phm+FiLaWiCJfAyXH2QUf8OUH/?=
 =?us-ascii?Q?dxp2GQ/Ct1lAU9ms1wC5V3/OzCw5XcxV7z7WcC65i4d6EjvBxUGEt7DSdlJ/?=
 =?us-ascii?Q?U3nXr2XykY1hdHgNxceqiX7f5bdKxXISzCIyyLCXn+Peq3wuf4MXLgqUi168?=
 =?us-ascii?Q?f+WLw0mITF1Ns/cTVpPJQEXNFPrrUDxIQHNrLQRTmqEfu0YUZx3xFbCv0H6j?=
 =?us-ascii?Q?kaBHhPy6MEt6WPBxqxFV61LCtxSIqLN+a9yqRGu2eI781JVH0/0QljqNGOJL?=
 =?us-ascii?Q?pyKHb96rKoXVir5SZtM3rj/F8bAAlWQflhIY/VIe12I00cMbURWjZU3bD47N?=
 =?us-ascii?Q?hKzus/mGKY32AJcP5Jj40bxvuWjd4ca65cngF0C3ER8eapW+zStWaiIwZWu6?=
 =?us-ascii?Q?idSE0Nip4DHdcyLPknh0Q/Rl9FB1CLA4Ox90DVlpPDBonzZGpIxnZog320m9?=
 =?us-ascii?Q?JhMdlvAlkhOQ4zc6FuEcLN7SQDqVvC3o/koXKveRnE2tSZqz63enj6nmOXIB?=
 =?us-ascii?Q?/ccqQS6gCqizlfvh+Fnv+Z5BSFLAnwIV2F0dysk9IU/vt6c4sJFzRAMZXSE7?=
 =?us-ascii?Q?nup4sKsjk7WbCHK1UJjvX0UBQAau2tYrXcj/RyF+wyBVIQKVRn3tqaPT+eNq?=
 =?us-ascii?Q?QyL32Ka3uyiwaLTv/rAwHXO3Cs6SuiGoHE4M+FlxYz2Q+4wsdGRqKicVX9Up?=
 =?us-ascii?Q?1x1yW5Fex816ElFi7Q4PGEIo2c7XruxtRpPNvwSeVtkBBnPM67zEkcXORA9R?=
 =?us-ascii?Q?ayTcH7/K4l13tR0gVQ1lDm0TmQQCv69LqQn5Z05hs4I8pkp2JiLQCiF3/EgH?=
 =?us-ascii?Q?ouwSQM5Jpnz8M+ffPg6BMNvX+TDf8dzFxc5GrwwEgeulhjh/br6bWuU4VZD/?=
 =?us-ascii?Q?BN0WzzFwqdY3/7A9D8+WwT33n87UB0rLla3w171NU5fAUaQGa4u6L19DUDot?=
 =?us-ascii?Q?1K1tXrztPdgHHSdarcgEnziOXOzwVImNJMLlWtA/hDQfBRcqZvKu5QaHK98o?=
 =?us-ascii?Q?djJWg8rPRVxCM+qsu130Rrg9Txco1Ru7GGp0D8pCamiTzys8SGWNMbf/ml4J?=
 =?us-ascii?Q?zhZakkwwoPMyln58XTcswtNMcEQIpKICrIy50gjAK8sDRlV6hIRQu0TuTc5x?=
 =?us-ascii?Q?zs9xjvfqn2OXSKgxa2xlIceB7Wm4jcHcEXcuM0YJCrZ2vN5GRHcDEQ/2PUNG?=
 =?us-ascii?Q?h0GZj2p8A5PXAFyTkySXZbNwxN5yYEb44o0GJDa73bG+UyygY7CLTpF56Nsh?=
 =?us-ascii?Q?hdrU9R4wX70D9jMUCVWSzpw2gdomsyWbKCmX/4ZIbOF1whX89hOX7PJeI/Gi?=
 =?us-ascii?Q?1oYP//zo25Rw4x7imuRNmHobtnYWgpC9Rs1z6azbWE5STkzgLsatGBOXPdfF?=
 =?us-ascii?Q?krFqQwjm1Arzo9gCqmy6bhU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df1dd23-d471-4601-bc45-08dd00340e08
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 20:29:33.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91xGPOCQqwNIuJdmadOB+4iK4AB+VpREjhLoq/CnjWGc2fw6RwZb4novpVVhbRdJ48mIA6kIXHmF9BQahF0+EJjsvn0fZHwCyBuFqLRmkSMuYdIZPWN86EYeEA5FBdqs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6841

Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 ++++
 tools/perf/util/arm-spe.c                     | 44 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 358c611eeddb..4bcd627e859f 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -67,6 +67,15 @@ enum arm_spe_common_data_source {
 	ARM_SPE_COMMON_DS_DRAM		= 0xe,
 };
 
+enum arm_spe_ampereone_data_source {
+	ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE    = 0x0,
+	ARM_SPE_AMPEREONE_SLC                           = 0x3,
+	ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE             = 0x5,
+	ARM_SPE_AMPEREONE_DDR                           = 0x7,
+	ARM_SPE_AMPEREONE_L1D                           = 0x8,
+	ARM_SPE_AMPEREONE_L2D                           = 0x9,
+};
+
 struct arm_spe_record {
 	enum arm_spe_sample_type type;
 	int err;
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 3064c3f22806..12761c39788f 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -455,6 +455,11 @@ static const struct midr_range common_ds_encoding_cpus[] = {
 	{},
 };
 
+static const struct midr_range ampereone_ds_encoding_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
+	{},
+};
+
 static void arm_spe__sample_flags(struct arm_spe_queue *speq)
 {
 	const struct arm_spe_record *record = &speq->decoder->record;
@@ -544,8 +549,47 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
 	}
 }
 
+/*
+ * Source is IMPDEF. Here we convert the source code used on AmpereOne cores
+ * to the common (Neoverse, Cortex) to avoid duplicating the decoding code.
+ */
+static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *record,
+						 union perf_mem_data_src *data_src)
+{
+	struct arm_spe_record common_record;
+
+	switch (record->source) {
+	case ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE:
+		common_record.source = ARM_SPE_COMMON_DS_PEER_CORE;
+		break;
+	case ARM_SPE_AMPEREONE_SLC:
+		common_record.source = ARM_SPE_COMMON_DS_SYS_CACHE;
+		break;
+	case ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE:
+		common_record.source = ARM_SPE_COMMON_DS_REMOTE;
+		break;
+	case ARM_SPE_AMPEREONE_DDR:
+		common_record.source = ARM_SPE_COMMON_DS_DRAM;
+		break;
+	case ARM_SPE_AMPEREONE_L1D:
+		common_record.source = ARM_SPE_COMMON_DS_L1D;
+		break;
+	case ARM_SPE_AMPEREONE_L2D:
+		common_record.source = ARM_SPE_COMMON_DS_L2;
+		break;
+	default:
+		pr_warning_once("AmpereOne: Unknown data source (0x%x)\n",
+				record->source);
+		return;
+	}
+
+	common_record.op = record->op;
+	arm_spe__synth_data_source_common(&common_record, data_src);
+}
+
 static const struct data_source_handle data_source_handles[] = {
 	DS(common_ds_encoding_cpus, data_source_common),
+	DS(ampereone_ds_encoding_cpus, data_source_ampereone),
 };
 
 static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
-- 
2.47.0


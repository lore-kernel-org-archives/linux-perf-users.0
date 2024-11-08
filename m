Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020138.outbound.protection.outlook.com [52.101.61.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88185101DE;
	Fri,  8 Nov 2024 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028131; cv=fail; b=UUoeikw00l+v+0H9cF7reCFAVV7TmnvAqwZuUtzw4tcF2Klt1cl0Xq5gQcXON3uXpL7cQhQVOKC9kcI8qhIbXn6yx/ERjIZohTcYmVUNESNxRB+7Pr8s6ojcP/vLlHPobeqSAt4L2m1nu5a2zj3p5KNTLnDpiqQNDRaFbpF18s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028131; c=relaxed/simple;
	bh=H+kDN0rKOph8fD9e52WomJB3xASXMCjS0hWEW5S0HE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKQTerXiVgLBBKZf1LuDXcuk12d/9Uzgk14uPpANsyb7uu9NKorQp3agaZpNzNWschD3AgtPc/zbJj9sg61xcfjPMKGHYm4xzCQ09rRN9v/8I/5UCUSn/Mk/mk7NITMJ3mvyplh73xpBRLFE0uxjEGIKTBxdkWYqI8MGA7cX2xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jtXA31u6; arc=fail smtp.client-ip=52.101.61.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jtXA31u6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5Fhj8hdbPvKM+47fE7nRw15nQuIO3yAmRd2wSEsu91qCFbJmMg9rYnSOMFD2H7AwCozKetT2x1/iSdQrf6newBmy29iaFChsOf34RzsLkDqh3UB6061VGcCk+4cEaHaw5X4fW+NpOL/ZH4jgIcmOnO4Oz+GNzG1cDxoHa/yweX9aV/ZJ94EU7y5fA9EA+ksu49Zl1SoKOPa823HWvDigeC5VKBmpA5K3rkjGRD3+JkR8lro6bM3hc12Pp90yJTN/Lspc4MzO4x5BnUcch0GdSSEt6xtjatw8JEIIaeDDJI11Rzlk97CptPNuBlYy87XK191+dzKug8K/qAdEKyuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Lp1zyDQwLkVqbaOZmQccSLK+0L8r2SK7hhIgVY3E50=;
 b=mtavcby/75DNf2EhJcwC6s3JfYHfg7gTLn8PQnuoqMEvMz64lXEeKDRegjJ+IjvfT5lJMbd/StZYCl5KVU745e7B8XZsRN3thEVhXo75eDeN9FH1Ox9g47mSoJuXJgzuGJAFXWGtRRer3qpLE+HdZWl8nnHEylKe6I/tRGDhrNaBK2/8xdTwxk/HiqNCB63/MxYKP4i9j94ruSnJf7Am+0b81WOcAb5s1uSBRqObxaSkhj2fOoO57awTA12b7OHSa2BNo1h9+mmemMP0bProHk+josFiVwHt9HxnbBzogmtHjN38Mgg3qtrbx0npqt1jMRxjRMckG6y8itYbeRPU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Lp1zyDQwLkVqbaOZmQccSLK+0L8r2SK7hhIgVY3E50=;
 b=jtXA31u6ztT1ZrUvIfHst6a/rBFF+5gtPNlfj3cuIza8C877RD46bwSLDaNjnvIIoigB4nSrPl0emk8gABg9ROxVk+RYjHLs75UaaUgNoCYa5XW3IvEUTvmDQS8Y8DagjA0Eh+wr1DCXY/ERY5YaH+qpF0jIvnFzT/Ci9Y0Zn6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CO1PR01MB7385.prod.exchangelabs.com (2603:10b6:303:158::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Fri, 8 Nov 2024 01:08:43 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 01:08:43 +0000
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
Subject: [PATCH v4 1/2] perf arm-spe: Prepare for adding data source packet implementations for other cores
Date: Fri,  8 Nov 2024 01:09:10 +0000
Message-ID: <20241108010911.58412-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108010911.58412-1-ilkka@os.amperecomputing.com>
References: <20241108010911.58412-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:610:119::12) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CO1PR01MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c7d393-e480-4935-8ad8-08dcff91e370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B9fAJNDQZJM/DXiiB9+JAZZ/KalGsSvxqTRWtTEgR2mIxgwehOfG4KHuYEpN?=
 =?us-ascii?Q?BQvg++b6P57MyMd6axTThAflFT8cyEMxp2eV+X00VmiAq7BIyNApgf4sUQ4r?=
 =?us-ascii?Q?aI2C59Un5emQNOH9rnrjXbVXt2U397N3gtNy0whab8jYXN9kSkhXPbD/u9fL?=
 =?us-ascii?Q?ZwkOuqt3jp87+32Q/b0WBvnpUhZwZUkS7ED4aGty9a/KbSCZrC8RrJBTvkPI?=
 =?us-ascii?Q?ptDAXZbCzqNGvnozPJt9ilpzYZjGVHBQ/NzFf3kI2g1ILGAmQmObxH7fXD5z?=
 =?us-ascii?Q?HaDeG9cFw0tfOAv0+YCME3B3C1c7b1TkcsCFRHSRPmWgJ+UjfROGDIABFdw2?=
 =?us-ascii?Q?rWUZF9abaKBdiyT+WXs4g1uhuzhfhrOm7vHLcvqUi/2cjhoV9v4hoWIjyAKm?=
 =?us-ascii?Q?rYXf07w//i8Hp0//F+EYXhQgaPrClnZMdDtD9SYwnvqQSNHAWn8vRM58onCC?=
 =?us-ascii?Q?VA700Sp0wQSE1RQx0O8tqviTn9APvc5FIaDQW7B29dX7CYp+UvGc2lyCNm2A?=
 =?us-ascii?Q?NYjUDtopyOUqUMRx/1DgUfSZHxBPCy1fYK/65+oOp0e/sUNk3GK8dIrq7jg7?=
 =?us-ascii?Q?To3r+bmsFAKcHTCM9qH9A/5a8rdkKWRUtzjQFZ8JOBq6iTwVL+SvIavZRjsH?=
 =?us-ascii?Q?+wkWz3XUeB3u5MCkplEQfCiHIOXBN/Leym7ez8V9eSi7+MOJpGf4pFQUHYRS?=
 =?us-ascii?Q?CUWt+bAEu3QgAmTHabYgxc+uE4kJKPI408RX74Fe6kmW4ZKsFhSJUsMe+QAz?=
 =?us-ascii?Q?Y4t8jQrt9qMADQzDSU3rvDw60UoH14CFUXTPSVPgDzRsaQM7r4XTs6A4RxjP?=
 =?us-ascii?Q?kySTyEf5yKJ9eaz/elEEnolEJXDNEk9WlM9BNLR1iQhmH7rcE0eM3LgphlnI?=
 =?us-ascii?Q?mJ4tlKVWP3qQCny9vkXzUO6W42/Wqjo2LCappwI0eBE/yo2kVt0SSjbwTg0G?=
 =?us-ascii?Q?tXSSds60GcQNcvf28XaPRb6Cbo/jiUijkBoSSIHSSBSvPufoutSO1FndlplP?=
 =?us-ascii?Q?jO/EXbThodKqkSQ78kSY+xf6j8WbJ0nUZXegsxWrpvX3o1y3ZV+CuJEdkLuY?=
 =?us-ascii?Q?Sc2dZVvhRu7Ub6M6/eqbw+gsZw8wwhD4aOny0Mb8eqJnbM5vpFmlRfEBtiS4?=
 =?us-ascii?Q?+CBVnYGHAlzjgHwavpz0ItxupZKQKeRlGfUvIxYzIar2QDCTXPXNk62ytHjO?=
 =?us-ascii?Q?A7i4CK+mGlg5BLfsbr2RbJXzCKs9xA7l38OA02LqBxPslHAH4ZREo+CEnwaU?=
 =?us-ascii?Q?tskL723fGT9J1FmMNkxOwKxSNLrTqO6tFKk38f/eg/KvAV3raex5j+dbCYNL?=
 =?us-ascii?Q?uq1qnP7D/1e+vOcdIXdr21UlTskZZv8L4VKh3LmLm2OhHtuoyvsjczZQaLJU?=
 =?us-ascii?Q?WhjQ7UwIYvUieTDxCUdPPHLiwtb6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9B4q1aoiMgDOzj3sDD2UZccg2BTZz+27LNdmw/J1syGeJEj3cYFIc/LMWNWV?=
 =?us-ascii?Q?y+Im3lrFiDY12E/1wwbDMqRZ6rbi5iTxrKKFVp5C/qX4HpTqi/IG1+NryRoS?=
 =?us-ascii?Q?VuxvnmUQoq+m/LV4sb1wYi15hVesCdTQ/BQwu3Gx1ZHNGL8/JR92762LbBRH?=
 =?us-ascii?Q?80AHDVZ3wbB52WyYxH3MelW8UZNpQxFsDJS2r1N4HAhPFBtx+Bw1qkSYCheL?=
 =?us-ascii?Q?lAxwhLuzex7r9SvxJ7NpGy6JDsxa5srSwexANnab8FSJGNJM3B6R7FDtLRLq?=
 =?us-ascii?Q?zRwOfZGxhuuDRr5ACe4CphLbmb8Vz1a3o3ZKvCtRrYzYsvFIncUpPxy26Pr+?=
 =?us-ascii?Q?ybbi/9yDe7w8v3YB554IaTdWeW2VBOwCwvDdbKEljZRpa4rJSWAu4L1MjPdJ?=
 =?us-ascii?Q?bYnfPIqBD/w44vtLcVNYPVIVJ/tQb4SOI1vbpKHsOfAICjomclYImmU6xA16?=
 =?us-ascii?Q?jPDlXzN/ezC+oQt004436WFUsEmJsSYUtaKxcC3yiVQ+DBnZxyr4JeD8GGwg?=
 =?us-ascii?Q?R8nlOQipRQKb9Dh9aVnIoUqfCv637NQtuKs6D0Hzxc3qGPKwOgXquUAm2qdX?=
 =?us-ascii?Q?8USHNJuxevhXUjL/5mN6j02fFm5aQQkLDgthQobzE32W9mlepT48Oj/p6SCk?=
 =?us-ascii?Q?Q3ASfqodh+7ZE82Qrpt03SyjIgCYZ5c1TaBH/Vi9QaPrzv2oXGaF8Rthdb9T?=
 =?us-ascii?Q?4LOSZy5uvzHhJiQeIKHUNeRa6lETMEUFte4Gp04F1ILkNCAUFyXFIijTeRoM?=
 =?us-ascii?Q?Mea3ZIXYozSFj43ZxNA0LMCK6kxbeg+pDDfOyl59Mc9H15HgOgwcWaS28tv6?=
 =?us-ascii?Q?3n3ehEdWo2IB7RGC64T7tCiBEgEHkiUL3WZUlCTI9nLaVs6jBgnvJF6E+CBs?=
 =?us-ascii?Q?l+eBdN2DkQnedUlx6c+EPRtscEKovPfDaNI1Nle20BqtdaeTCbdP5K+mRMjt?=
 =?us-ascii?Q?gu2MAdiBBAiqSHrLGdacJjZtDu1DnwJaTAHWLevawMEDRjsPdarAR2mzX+BF?=
 =?us-ascii?Q?Pmo2FynzxBfzAVg+bvxYoBBrHjdgYny9/sl3zueBZfRy+uT7b5IcEYXAJLrs?=
 =?us-ascii?Q?mFVybuIfsv9eN13zAQbT/dVks3s+eOJtHz0sLu+Wx+xNXF89QOczYf5nxwqB?=
 =?us-ascii?Q?AOwcvdOgpIu9kvfYbL4IXG6DeR/0PmaoLc21y4K/xDgqYT8zYRQGa2L5GT6h?=
 =?us-ascii?Q?JMAgL2QomU+OIvXtC7gi6/lnMyq+1R+OoCO9UORwBVcJnDTzQIl6RjulxzkZ?=
 =?us-ascii?Q?o32xaOqy91mQBPYTdVPRYOGeLtF6N56z6CoTuOWi6TTo51XK1+qxKpElYIv5?=
 =?us-ascii?Q?bD/nB8AdX1qnxfgmPFFULNxV7blIRr14NrnbthRPukjA22FW7oOk2l/CHJnf?=
 =?us-ascii?Q?z4rrK9NukwxzLaSWIlmRy/YaxussR8A5sjfGXgSSW9PmbnpGQ0g2+U35hwnm?=
 =?us-ascii?Q?KfQNyal31GoaWjNklgb4SXNnkkqXB34ot1MpMcfPPXL0S3GxVpdt70G6cuLE?=
 =?us-ascii?Q?0REuKuDx3T8GqpGecviO+/7Kdm4dOPuT2a5lN8HUQ8pCSXM1KQtF5afn2OTC?=
 =?us-ascii?Q?voLRBxckyEe5xIuvjE4uLjDfFS3aAa3wzr2l5efcI1AnSVakKiSqgcaTAhAK?=
 =?us-ascii?Q?+4gNldGfMj+dygTxmpgPTwI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c7d393-e480-4935-8ad8-08dcff91e370
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 01:08:43.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBlkgr8/TEEvQaLIIca+6X4kF27KvuF8XdvfGfuVgUTQoSs3ew5B4POJGtjyx4ldsmVlAKJV2LCD8d/iQDKuob8MV/uqOxfzJFoflJJC8riOjlIzv1Q3vZECiGuV565G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7385

Split Data Source Packet handling to prepare adding support for
other implementations.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 tools/perf/util/arm-spe.c | 42 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index dbf13f47879c..dfb0c07cb7fe 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -103,6 +103,18 @@ struct arm_spe_queue {
 	u32				flags;
 };
 
+struct data_source_handle {
+	const struct midr_range *midr_ranges;
+	void (*ds_synth)(const struct arm_spe_record *record,
+			 union perf_mem_data_src *data_src);
+};
+
+#define DS(range, func)					\
+	{						\
+		.midr_ranges = range,			\
+		.ds_synth = arm_spe__synth_##func,	\
+	}
+
 static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 			 unsigned char *buf, size_t len)
 {
@@ -443,6 +455,10 @@ static const struct midr_range common_ds_encoding_cpus[] = {
 	{},
 };
 
+static const struct data_source_handle data_source_handles[] = {
+	DS(common_ds_encoding_cpus, data_source_common),
+};
+
 static void arm_spe__sample_flags(struct arm_spe_queue *speq)
 {
 	const struct arm_spe_record *record = &speq->decoder->record;
@@ -555,12 +571,14 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
 }
 
-static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
+static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
+			      const struct arm_spe_record *record,
+			      union perf_mem_data_src *data_src)
 {
 	struct arm_spe *spe = speq->spe;
-	bool is_in_cpu_list;
 	u64 *metadata = NULL;
-	u64 midr = 0;
+	u64 midr;
+	unsigned int i;
 
 	/* Metadata version 1 assumes all CPUs are the same (old behavior) */
 	if (spe->metadata_ver == 1) {
@@ -592,18 +610,20 @@ static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
 		midr = metadata[ARM_SPE_CPU_MIDR];
 	}
 
-	is_in_cpu_list = is_midr_in_range_list(midr, common_ds_encoding_cpus);
-	if (is_in_cpu_list)
-		return true;
-	else
-		return false;
+	for (i = 0; i < ARRAY_SIZE(data_source_handles); i++) {
+		if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
+			data_source_handles[i].ds_synth(record, data_src);
+			return true;
+		}
+	}
+
+	return false;
 }
 
 static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
 				      const struct arm_spe_record *record)
 {
 	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
-	bool is_common = arm_spe__is_common_ds_encoding(speq);
 
 	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
@@ -612,9 +632,7 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
 	else
 		return 0;
 
-	if (is_common)
-		arm_spe__synth_data_source_common(record, &data_src);
-	else
+	if (!arm_spe__synth_ds(speq, record, &data_src))
 		arm_spe__synth_memory_level(record, &data_src);
 
 	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
-- 
2.47.0


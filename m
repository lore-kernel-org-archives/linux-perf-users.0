Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020122.outbound.protection.outlook.com [40.93.198.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22A1C1F34;
	Fri,  8 Nov 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097784; cv=fail; b=NP+2kVVJjaSrqo/pTfNSbh/gfxFOeC0f7DomIVXPha2yU2saYUPzpfSGNb5PS0CmcXA4HeXro2wvBbDyWO+xUNlCyA0RTMp3cKO3yzzWemHTbZ/S795tmOMX8T1FAg/UUbyeFeG7NzfdnXef7vz8GYI3Ns5rzRswT+nN2rsQyDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097784; c=relaxed/simple;
	bh=zzRLp8++scY5Duj8+i6eW+SCkzEEv666qtARkoWnj8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtXOvElMVf1DK2OcbnT/abm+XiJghB00SQmzxqf2wXERJcxTv4UwhD/9Dn4uEquvCz52x8IjbSD+/t8nEGEGMgddDySkQ00BAQMBgMJKU37NbcmUe9h5H8VQpL+LI5jVzV0vLr6H4jnjbXMQ85o9UCDhf6UMAzOHf5Ie+58A8Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KEGzpvPS; arc=fail smtp.client-ip=40.93.198.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KEGzpvPS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVBD7MpUSDgqWrYN+/Roj+149d8DmSW2s6PQCzDHw9+oZ0PbEW8EZsca0k6FihxdiwPGDqxPyACGdLN845gPZ+4LUaEtT2U8qQyP2gQ20HvJtt+svgheaDGKTDz+idz4Gqc8qFEp13XXn/D0a1QG2+g28u2Z2PTKAd1vm3DfucT+cvk/a2e6nkixNe9+M79KMhUddyJA1VlrosV2wZUZSO9oMoC8K2zHRaPBh1E6nMocxYu7d7WD2qbY0UdhP1bqsYieRD7ZsBvtQHKVra7Ve0cuhiPWKaG0pxWldSZJi6CWJPrZSUbDAeCOpzhaaHynJHNfiqaMS2PxnFid0dWTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbuJ11LvjiyiHeAmxVaPXqgB2cuWKI0o5ZvlE4nSWH4=;
 b=mppLGmwlm1OojJ6VHsFy6TYY0tk4yy+Dk+WaXEJ9v8LblP9LZR9Soq1eVoUfMFwzqkgotN4YdM1eHZE1E6SyiFLA1Z1rvBlEhTPss4IdVC+si7XRTfI1hcjm6bKcI/bJwNcJcVjADHYV+gR9QwLlviE+ZsfBM+IO7LCtKY8r85Kz6bmKf7T+FaPP6FGyVbMocJv1WIR0ANAG4YyIBCjeVZB96wux5E0f3W7YTmEVEyMcYYWRux7h7Rpp2/Co7TfzQckjCY87zGtLVrTSUftvtfLqASk4L7pcHB5CsWo0vav0vpvtTAtvuYC8UEhh9Aqiy7m0ARAg5mhcixVuriWVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbuJ11LvjiyiHeAmxVaPXqgB2cuWKI0o5ZvlE4nSWH4=;
 b=KEGzpvPSpYqxVA5TnB2E2Rl4c4IX+f3Ddu1CIm63WUBazgWglBXeEkoUaI/oTKG/WPKF+u9XRgOv8hmk7axWSmhFQ8i/r66KVAbNgW3zmYljmOxPAmUvldhjtCIwDvw3NDLh/gPQHhI990sgKgBT07NXEUfBq5UXlh8SBVbql+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CH0PR01MB6841.prod.exchangelabs.com (2603:10b6:610:110::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Fri, 8 Nov 2024 20:29:30 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 20:29:27 +0000
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
Subject: [PATCH v5 1/2] perf arm-spe: Prepare for adding data source packet implementations for other cores
Date: Fri,  8 Nov 2024 20:29:45 +0000
Message-ID: <20241108202946.16835-2-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: f87746c0-360b-426a-9f9d-08dd00340acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lmj303yfflY/t0VoaDwOAroKT9Pq4AczTxr/WMCkX9vYMpM1gYAwPEruCHVM?=
 =?us-ascii?Q?ZbieN0waR03yRsAAmeyAZQn7qdWj/ytMo+nIj6HwTpSjbq3KHPagqW8mLF+p?=
 =?us-ascii?Q?nMrt3DIbH7Pd7DDIVmJpAiFrFSRb7UZso5HXtUYpiUCkwOP/0J/UWR2Bp/Qb?=
 =?us-ascii?Q?mzQTPY0n4LpHozIQJicW21a5UC22MKCrwzNVZaBUyZvBu3lDjkQIPCp3xS4Q?=
 =?us-ascii?Q?/t7FLQS9qwY3QaZFlJ2MtDiniSAuOT0GxVafRB966+9W3s3Z5PEGEP+ANxJZ?=
 =?us-ascii?Q?lkqzWNEvRGLubXQG7RzLxOAGSNzzHKGaGAiMQN98t6W0G4s9SCTiSHIbg9wG?=
 =?us-ascii?Q?+T5t1+aCNQeon0UesmVuz28PQLHQSM81McED9cLIwD4D/4Iw3zoQl6NqFwzD?=
 =?us-ascii?Q?a/RnJKucaekg/TmWqEbzndrk2n0/GhNUMDEC+2iNucl19RMiW+ZflhHYLemf?=
 =?us-ascii?Q?z9rflW4jJqRJppfunTjJjxzKoc5mmq2JNvaSzYbSVf9am6eZUOhAaBjgY3UF?=
 =?us-ascii?Q?I++X25fpo8L9UNfHLwcjKZzo+xDbZp7CpyjKRSbboF/mmYocTtSjV05YOOcM?=
 =?us-ascii?Q?8nVL1iDyGA74CeJHshIs0FQWuvN7hS0WV3IFAlt5MPIFh5lKRABud+JmqdS0?=
 =?us-ascii?Q?ve5aC8BDvhHU/0/urzCjzdd/aQPj9NKbB6MHeZLMyc5F0Bq8wCg3oWXj1yzW?=
 =?us-ascii?Q?HDXWLFYYoH8NcMfY0soLP2CvIsJnuS0n6BNFmdRbPbpmZHvdHhbyf+uO6DVI?=
 =?us-ascii?Q?WwNov+ZXaQ+zTZC75ltHLe/D6LEBPcUvnBmctAWLSdJc5XEpfLJD6D23MQxM?=
 =?us-ascii?Q?jdSD0KESHLlM5xQzIo1xeAvkjRgVIlcaqsM5LR+tAnRLJ9E6d8ZYagMFaZEE?=
 =?us-ascii?Q?AWllNgfld20ry6H1IISS2RL7EJBCWRf2srhbClMZ2tLFq5GmgQTCMhubN6u+?=
 =?us-ascii?Q?82oSIFQzWnab/gFmiIFODeiJ0c2z/6+LX1/k+9dgcvWmm0woG1P8I0HN6ci6?=
 =?us-ascii?Q?Jr+RzOsUltjLg10XCrbgFd48zDCw0a2kLYfZqNqoCRYZqd+L7ItjVCXIJJiE?=
 =?us-ascii?Q?KMzSH49NK/bv6aFzKIFSwnWTU53Of/d9a1/iJpEe/HFhPQCuwYijVgFKaDij?=
 =?us-ascii?Q?aJEDoV1lAQD1tLMmFP1klJzAEnvNrM1TixBhs6+6b1kegZXKXyR+aVO4Ks0p?=
 =?us-ascii?Q?3sUVMPHWGXnxnyybk2lsYzx2gAlb6f6nbJ17IdEG2kj0mZUKiZTipxCN+7yi?=
 =?us-ascii?Q?J+KMc7iP30j/ITaCCEyc7xIyT6w/SlryyTzUtPsuXM1dL7RH2u4a45xjVWpU?=
 =?us-ascii?Q?pdCnFAHL1i5ASegmiOIDbqPP0qfZiFGPlizT7/9rv9F2uwbYfGcC2wJlKQ8Y?=
 =?us-ascii?Q?MrAyxg/VO13bvAo0ASkG/f/VJza8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7h2FL0li/CsbThTsQZ7vkQ6IZ4hmzdBjMF/+JLM9hJOmqkjm1ubEVcOTjDWB?=
 =?us-ascii?Q?ZqeHkzH10+N3ZeEnfyvoU7NVrCroe3fFNJ2gKXUyWcose9YQZJ3K6Um52lz9?=
 =?us-ascii?Q?EmdWd6N8UZxUuHkH8O9zwsNqxM2XRpgDcegGewcHnqEGbjrHcu+NDcHGqqLM?=
 =?us-ascii?Q?N8lvojD3dN9BC6EwIV4GAmt2Bu2wAfkzAUdrmc2Qj84z+/PlEytow+PtjnxM?=
 =?us-ascii?Q?9KvXnz8OwmnpN3/1g+k4R0NIqLEL4ocz4JuY4SfWSvQHDjAznPn0rDOu66KP?=
 =?us-ascii?Q?RruBv1d28n1PDXmUVTca68L1sVmAwgIyeX/seZTStjUTuMyUsRWlv27xJceU?=
 =?us-ascii?Q?3hafSN1axKstUL8W8/yrYBJURAf2P4ZANC3LmiZSTzpKYM22+IVoCZn+jmRh?=
 =?us-ascii?Q?N5lGrw1ZEL0nWxNKRch9Fob07J3fzA6zGJx1cJd1erFRyKimDTHiSaT3vr6W?=
 =?us-ascii?Q?5dbFPo4lhxQB6vodXZp1amAFkawa58dK5s+VULsn0JLshmVX9FGBM8x+k3Pj?=
 =?us-ascii?Q?1ZM/P0a2W/P48Yla314DtIv/st19oBvmerrcfnlvfY5uuRVWltnzFOn/paIA?=
 =?us-ascii?Q?SV8mSzL3mBW9UpCg/91g3QFwaSJ1WrvsZV7tYUxSv1GnydCiPl7e4DBO6EhH?=
 =?us-ascii?Q?gDBDSH+SKsHEEDlixjG+upiziJm+KNLoc2CHIF/goRXxsheZKugZYUJyza7w?=
 =?us-ascii?Q?qBAxKl/SLsGmIzGS7XsJX2zMRHFCoEPKPMLdxz41R1VH43Ivnt6t3kca9BUw?=
 =?us-ascii?Q?ptKXo6zvwa9nlDWWxSpJiyp1neCxAYcPqeHzzI0nQyoh2+wO5YYb1+t1uiDf?=
 =?us-ascii?Q?ly/bEgn73JOuz1SNxfsepCn/nfqykmxWu+iH/d2L3FuDgAV1oapTbF3DSovj?=
 =?us-ascii?Q?81EjvI1Dn6kt24TMuOvQ/Xt10TmNozhE4re5/sduaGfb9reso1DPOk+4WVhJ?=
 =?us-ascii?Q?c5Nlx+OExl68BadjZ1OlAA/XvJ15Uo+mXEPNX6jabq7mDLiZgDQ4ZaFHpoGy?=
 =?us-ascii?Q?wD734a3KdUMSjZuRH+u6kpnkqvMjUghe2u08tTWGzuyg3953OTDKGrjZ4txX?=
 =?us-ascii?Q?B7Ucyxeosk6ed/QVaGBVmNQUhLfdP0W7S0oN73wj+PMND9fjwLyYR05TBEhK?=
 =?us-ascii?Q?LOeVGewOWKcFbku82DKq3lu0kQHfykN8k6sPEToCEfk83q8Y7WD69ADoWh7t?=
 =?us-ascii?Q?i5XdLjQiS1FiB4lv8zurHvE/AdZH6M9lb81zmOMYjLALXGPD0M+PQSdUEsqI?=
 =?us-ascii?Q?mzQuHl0owrwSH4gIHuDhz7AAcGztuZfOVFraWRc9BqvGrqt7qIOJG2TY5jmL?=
 =?us-ascii?Q?HKv5OcLpg7TEOSe71VHzqZno3Z9V5iQHIFGGvZe/qWQrHiu7K4zLu35hAZEm?=
 =?us-ascii?Q?LtNrF+X8lawRObI3jAjJQLMBNEM85a5FK1nHVW9LH6lC7GPoxILVWdh1C3Le?=
 =?us-ascii?Q?NopjhqpDyyQSBwbiqRW9LKpDAjTayLtOv0ONHgf9V/f5Ys1Az2QWicwsGlbG?=
 =?us-ascii?Q?8PHC3afVDx2pu2RXWV1PRz2TlsmJHfDAROuMue70pf1yfC/4FCe0Q3XsEReD?=
 =?us-ascii?Q?RqEbFt6oFBj1B9zEMDzuDmCsUVgyvEwCfiCp+IsnACoxTHCMyQ8fAJIho/TI?=
 =?us-ascii?Q?oIlmxEVoc+KzbXUPmcXWWng=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87746c0-360b-426a-9f9d-08dd00340acd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 20:29:27.6998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4Ex6Cz0NvygIb6ocCSKXJ3s69ikDJizkrtbTCgjoh+Grf0prXKY598IsmiD35P+ibh5vU/4GWx3mKMbTLi2RQs4UhnQ9CZq4ruohZ6/gXvlerTzZlxqKrOZNGHo+e2r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6841

Split Data Source Packet handling to prepare adding support for
other implementations.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 tools/perf/util/arm-spe.c | 42 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index dbf13f47879c..3064c3f22806 100644
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
@@ -532,6 +544,10 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
 	}
 }
 
+static const struct data_source_handle data_source_handles[] = {
+	DS(common_ds_encoding_cpus, data_source_common),
+};
+
 static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 					union perf_mem_data_src *data_src)
 {
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


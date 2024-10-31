Received: from BL0PR05CU006.outbound.protection.outlook.com (mail-eastusazon11021140.outbound.protection.outlook.com [52.101.52.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C81BBBE0;
	Thu, 31 Oct 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410539; cv=fail; b=uNbqPy7UscNY9n8DRTNx8MLxjegPIAiWCJFBZGPN48JiziidimhQKFXx+YkxaXZ4BLZqU8IStFk+kqJLeKVQ2TvpaVkmJFu+lwerxyQyle+p8YJHq+QcbmvsWEBLASQOhceiC7oLAjApqSD8nNBVoKM3meNpeWABY5Lf01UEQCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410539; c=relaxed/simple;
	bh=omV2AR2gfqjWTiG1RkJcOifMFSgoYPeg7HpVJAGUN2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lz7tYFx1X4A0wVADp08yNHkUxa+NSlGE+Ka9yXWZcOi9A/8vCazmB5ff1fIHnKOwRWuqBgJ4VZfILW3fG2MsLnmq+ZbLa327c9ZOfVqBASIm4WsgpxPYyIsPcIHGDe5rnNkRUhv0fEuYTgTKmd0VIhDAy9K43L9BX6SZUvdUjTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=W5cGWHUt; arc=fail smtp.client-ip=52.101.52.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="W5cGWHUt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqOIuPwqj0YAxl+Lxuj4TOer2yRLpmi9osaL5ioz9rdWCwSXDWWe1KNglc5UV4Zi1pb5o5GL/0DsZdv0E949fX6ToZtHTSweDIaIkSPFbLiOGSgHPPcAynFur1WYZhr+yUi/U8tvcsNWVwTLBOcnQRNOj4+ZKt15Qe+4IonqiEhEwgRKlGD7YkLbjslpArZTKnu/k0wlYqhEFzopNctdIgR+amhWRVurrFO1j4Tp015LHt2K1+hxIYO1n2W4849uLZV2nvT8IHGhvfIvmYhYkGy3ZlpxZDChf3jx3gTpduGUWtL6N7dDb8fT5BQ6q4d7xHtQXN2tmZo/o4iY34QO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBibkdyjZV/1/ppByaipvOqsJDfDzCiJZNCKX7z2dUI=;
 b=s3o9FfZkbbO4vwkIrLf/A4tJcmxs2NDDPDesrP5XLsdvrAsWRAhrHDpJ6w+bXkcT1phvR7sr55R7kgjYydZzUwzcgv63YEmxwLghtwEtEEOy++dNaRFaGX4DgQxtBDAPBn4sIB9dnhUt6ZtG6DzGkVlzeK/uvSsOQUQcwmIzHrfE6Op5vU3LG/JASChw2bSPJqQAqmojS1WRTwRIjx8ohxz/JjoTdSfsqfK33plRa0CSucpBo3R9xuCugkhBEB/AJO+DGfB7dx9he68mZApT94rLfo13JpGUFKInOmeFXHKS1RaMg4LNKgzvEDY4Whttyvg6sEYpyzHcVtrX77r+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBibkdyjZV/1/ppByaipvOqsJDfDzCiJZNCKX7z2dUI=;
 b=W5cGWHUt8QQMjfEJy8vBHSAE9zGyC/5UhgepceVl2WeKv/N1Wq/nwa2GvBIefK+J6VvWmnSopf24nbj0wJvWVSwqdWHgSIIB3Yaap4keQYOpIuYIgDxrYWct4xSKiduDCyu3bZfWDgPNziegw+JiySy5m7HElCKVNcrxwsB2Iek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 PH7PR01MB7871.prod.exchangelabs.com (2603:10b6:510:1de::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.7; Thu, 31 Oct 2024 21:35:24 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.008; Thu, 31 Oct 2024
 21:35:21 +0000
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
Subject: [PATCH v2 2/2] perf arm-spe: Add support for SPE Data Source packet on AmpereOne
Date: Thu, 31 Oct 2024 21:35:33 +0000
Message-ID: <20241031213533.11148-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031213533.11148-1-ilkka@os.amperecomputing.com>
References: <20241031213533.11148-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::14) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|PH7PR01MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: efe4b449-e20b-41ec-c074-08dcf9f3ec1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jtTDmf6299F/q9xikAip3HnVb8EAKm08OiruNzWoj5U8o/jiwOoh6JfqCrSg?=
 =?us-ascii?Q?0JPJNgMXwVuWb2BYilmGVwUmAV9Wxmu4TxzCHeuf6Vj89S42pTcoqoBMq7Ki?=
 =?us-ascii?Q?2lzCTenuaFRYv9LliE9hhIlSlhYPdxVS/qKpbQZ0VYmxQZAFChPoE3sZlHVa?=
 =?us-ascii?Q?PRAVVW1mh//wNxS/NIWazaC7jVb4Cdp8pBytHEj7QRJuwnW847yMBejgjVT/?=
 =?us-ascii?Q?drDqO90B3bJVPLpJEGf/Sq0LlLfOFh80UaEmzQVduY3lADlBVk6/QL/MbPG+?=
 =?us-ascii?Q?2uW3dywa1tADWUoALQbIbPyXzBzbmpyeKXfPPX7FVWuHScwIlZkw588iMacH?=
 =?us-ascii?Q?lznL6iL22ylmp4nzPOvZmxZLvhSkIbCQbb7qS5+Bsu06Zeuv5O72wC2u1vEG?=
 =?us-ascii?Q?ZePARe+x8WI2dE5K4N3U4WtIXLy/OZBQ+7i0DCttX5xXl/mf4YHJUQVdfuPH?=
 =?us-ascii?Q?ZliabKKFoZ4KFPN0W+QEX1ar+rfK1La2IvENfbHlwvBP+lEZKjEMyIgngurU?=
 =?us-ascii?Q?p7WvdzNfjsJBI1p0TBuA/Va8LP4gzgbhutqsLsHCYSigX0NekZzNYXNV3SS/?=
 =?us-ascii?Q?NbThRobJaE4bb07+uFaPxOW7rr2SFZ5qIluu2LTv2N8pFQL7jui8KUvZmKUC?=
 =?us-ascii?Q?0ih1pD6qQK93RJ0cAF4isiAzgti8v7+uczBxNdr5YqD2fwunR8rLxzWtLdsu?=
 =?us-ascii?Q?inpfJ2AiJJ0YYZCLaTumNvMDalMDGLvHM3vSl/w5kjK5RzXeDQxTmUD0TClR?=
 =?us-ascii?Q?NXhw8pa/PX2chkUUK/P2c51y1Vs3XaQHuWb60Hpz6dx1YTw9oxD265fRaIxU?=
 =?us-ascii?Q?98lK9H6HMGlqDcKchNTJCjHsp1IrDX6z6EqolqXMtAXXp0FroPen9j7WRsVs?=
 =?us-ascii?Q?AjEpD9Z8XBvNZJ/wa/jwYszGQ5uZl5l/H9vXVm8hZXN8orZW3s1YLjYlWVtg?=
 =?us-ascii?Q?yyo+hTAkyuNqbaARLcRpKTRiK0fUDr4/YSIT2CpfNABu1+npLBEROi3bVvP6?=
 =?us-ascii?Q?J9sl6ET64gR3Xsx42hNzUTpSIhyhhOQWyMhysgw9c1IOLZ65+6n9TKZAoJ6C?=
 =?us-ascii?Q?vRy4od8qxZ9fcx9bWEbUBVacyMbVkk4LW9SsNi1bqg11bAviAbMzDrx9ebVe?=
 =?us-ascii?Q?G2xDuGwoCGFq+Y6yeZcoYBqi8gibfSkTICsIBfNrGfZjrd3cC1eW7ok7qKDN?=
 =?us-ascii?Q?kTb1pIKpdbPq2yKxCAE2Y/HjClv9MPTs0stnNOuWQQYdUaINIboSEbWiqB+d?=
 =?us-ascii?Q?myFCVROGocJnjDDO6G566/N4Qhpd7rT6jGsNFcgNfDzNBs0SdxVjbEzl3TF+?=
 =?us-ascii?Q?nCXZe3YC3kOPDL6MZqgKuKwp1gmlPPoJA99egQgTYAo88USyN+XaPcO0IX1E?=
 =?us-ascii?Q?bHaBtlyYABKWlZyNQfHHqTO2/pfF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSdyNIcHf73k4zoXPwnggE/bd7EsxVpep91U3KNHbQqL+uKo5YsZ/YZqNHK1?=
 =?us-ascii?Q?0OnnKu7WB3+C/ytc3Na+lsuMV9hy3JGtM5/atQyf6wlnyZvUumbYS2gwaNS6?=
 =?us-ascii?Q?k/9JgP2r8JgcJjy+PD1xd7vYvzMLdftAYKl0jEguVrVe1EXzNFW/eD8f8TpH?=
 =?us-ascii?Q?1uXoISOA+654/4iRi+dDtw4tCbLJ4usMGz+Uqf4KJXo9D+hqEGxz5Cfto2hb?=
 =?us-ascii?Q?wpuVjWljivHbFpLYDy/T8L8WTC4/UKydNOufLfHfSAyUJYzhYnkU8iYEsM9T?=
 =?us-ascii?Q?8/nG96nIsr61qWdtLCFNO/s22vRrk5zIybm/CDe/oXYepYYgEpLcdzKbYgKS?=
 =?us-ascii?Q?pvUS1kmGY+IBA7cDDky1gJarBhOr153+8NCul2uDGMz6vQ71yJfcmVtep9Gm?=
 =?us-ascii?Q?XHjslxfbhcfWL37C55IkYWT4lm7nCn5FJqBzEFQ0fKzA3vNrzX9asCEnOBNs?=
 =?us-ascii?Q?0uovVc8f4V8JkvOCkZ3O5PMyABf9JgHsDNWdEZBGO8xCDY1Jc/7lB3dIMif6?=
 =?us-ascii?Q?htiHwzySPlJakwbK2IkrV9Mxh03tyS/jAAO9NmZHTzC5pz8lSU1g9wdZqNrg?=
 =?us-ascii?Q?3lXQVwk5BIdCvvukxSI0x7hd8SzpogZAK/YDMBYfovfjG2HQhtI+3UEMaY8W?=
 =?us-ascii?Q?BPCWgjzC0KQjw8NSPqPAZyO+5tqE9NiVwSWz3ybjLF/i452ljU0Zu6620UTK?=
 =?us-ascii?Q?Jw2FeH38InpIddYlkMpTEqnD5fWGRk9dKru3yr1ducF5kENWzszVniIn7Qvh?=
 =?us-ascii?Q?k0EQlrEfLYcgvtP4yWcl3c9kXuW/8+44pUcKvbovNnOtfsnsayh0O1iZiVWy?=
 =?us-ascii?Q?ntbLYJcn+M7lqxQMLqmIB/IGvt7xJGC3Rc1hp08lPAvJmjgZk1oJlIl7N4Nu?=
 =?us-ascii?Q?YY6dPhm8U/0bFj3U3Eh/agvftjCH4L82fXNGO2kTR9OKXmK5RH7937EDYNIt?=
 =?us-ascii?Q?HEB2Nv/o7Qs6BOpkKZMEyMgJod8Gh1R9FQcmgY+2Hug1NI40vhY6MX78f2pu?=
 =?us-ascii?Q?aTQa9BYW/FD7Z52ikxzww5chgTH7ycdf/CCaxkoIVRp0+Hx5yFyvfVbERO8r?=
 =?us-ascii?Q?tOn+UPTUNUAMgOatD7bV2Dm4JCLNKOI61viXGGXHK2n4qODzji8TGTyNMehs?=
 =?us-ascii?Q?cOe6iC/R5NQH+dlz4DiOWErlaitCDorwjPaadeqs+Vnn2n/gtwvySf5awpC5?=
 =?us-ascii?Q?naMpPl0crkoLCHEJWxRP1BKdt+1w8+Aw806HSlC7dMHmKtHfM36VNYGR9Vkq?=
 =?us-ascii?Q?W11gb5xLM8IDbsIlgnCE9IeChTCZZY0E6EsRYAZeich1VXfWsFfbR8Z96+ha?=
 =?us-ascii?Q?4fkyIpnX5rUVr39BlZTW1PNriR7XKwOziouhCFN/Hzpbe4vAaagwvZRYq/w+?=
 =?us-ascii?Q?SZ3HMhn09Rhk3pmWlTdG1DxzrfM+naqgbEJXQhyYI9F2SHMB+wq6lM3xekwR?=
 =?us-ascii?Q?ZjV6/g6t4NUaqmoDT67hxg+6SLsc8l48ZbVIdSYQulOv1Eiitvcd5IMjc9vO?=
 =?us-ascii?Q?DMAkFLpuGQbuSrY5A32Xq5V57MToBNQCVhoujbOLPb8IkFPFrmzQYc2+rGR6?=
 =?us-ascii?Q?0YI8SmUZlN+4AjahZAi8C5+prkXdsJldPGeJzP42CP2KxbgQh4dYDDzIuQ5F?=
 =?us-ascii?Q?hvOHqDWw0eMHiL3pBip8dQ8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe4b449-e20b-41ec-c074-08dcf9f3ec1a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 21:35:21.4605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3NSLxWXMFLtYsalpVv6y8dFJXOMMJA6R4YgQe3odnM5A2vBMWSC/Ql30d6NYU8BYVdvEUQR0qS1girSWivh1e3GtVdw9lpffPJJm4+So7B3qd2g4ME0PM7Z7oQwN/lq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7871

Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 +++
 tools/perf/util/arm-spe.c                     | 65 +++++++++++++++++++
 2 files changed, 74 insertions(+)

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
index 9586416be30a..700d4bc8d8ec 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -103,6 +103,30 @@ struct arm_spe_queue {
 	u32				flags;
 };
 
+struct arm_spe_source_mapping {
+	u16 source;
+	enum arm_spe_common_data_source common_src;
+};
+
+#define MAP_SOURCE(src, common)				\
+	{						\
+		.source = ARM_SPE_##src,		\
+		.common_src = ARM_SPE_COMMON_##common,  \
+	}
+
+static int arm_spe__map_to_common_source(u16 source,
+					 struct arm_spe_source_mapping *tbl,
+					 int nr_sources)
+{
+	while (nr_sources--) {
+		if (tbl->source == source)
+			return tbl->common_src;
+		tbl++;
+	}
+
+	return -1;
+}
+
 static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 			 unsigned char *buf, size_t len)
 {
@@ -443,6 +467,11 @@ static const struct midr_range common_ds_encoding_cpus[] = {
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
@@ -532,6 +561,38 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
 	}
 }
 
+static struct arm_spe_source_mapping ampereone_sources[] = {
+	MAP_SOURCE(AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE, DS_PEER_CORE),
+	MAP_SOURCE(AMPEREONE_SLC, DS_SYS_CACHE),
+	MAP_SOURCE(AMPEREONE_REMOTE_CHIP_CACHE, DS_REMOTE),
+	MAP_SOURCE(AMPEREONE_DDR, DS_DRAM),
+	MAP_SOURCE(AMPEREONE_L1D, DS_L1D),
+	MAP_SOURCE(AMPEREONE_L2D, DS_L2),
+};
+
+/*
+ * Source is IMPDEF. Here we convert the source code used on AmpereOne cores
+ * to the common (Neoverse, Cortex) to avoid duplicating the decoding code.
+ */
+static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *record,
+						 union perf_mem_data_src *data_src)
+{
+	int common_src;
+	struct arm_spe_record common_record;
+
+	common_src = arm_spe__map_to_common_source(record->source,
+						   ampereone_sources,
+						   ARRAY_SIZE(ampereone_sources));
+	if (common_src < 0)
+		 /* Assign a bogus value that's not used for common coding */
+		common_record.source = 0xfff;
+	else
+		common_record.source = common_src;
+
+	common_record.op = record->op;
+	arm_spe__synth_data_source_common(&common_record, data_src);
+}
+
 static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 					union perf_mem_data_src *data_src)
 {
@@ -606,6 +667,8 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
 	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
 	bool is_common = arm_spe__is_ds_encoding_supported(speq,
 						common_ds_encoding_cpus);
+	bool is_ampereone = arm_spe__is_ds_encoding_supported(speq,
+						ampereone_ds_encoding_cpus);
 
 	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
@@ -616,6 +679,8 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
 
 	if (is_common)
 		arm_spe__synth_data_source_common(record, &data_src);
+	else if (is_ampereone)
+		arm_spe__synth_data_source_ampereone(record, &data_src);
 	else
 		arm_spe__synth_memory_level(record, &data_src);
 
-- 
2.47.0


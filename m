Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020138.outbound.protection.outlook.com [52.101.61.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862067464;
	Fri,  8 Nov 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028133; cv=fail; b=ObhEs5G087NeV/DUeDpiCIs2Qj4MO6pEA4c0GsbhBnDyNhYtoGNu7M80ExJ4W8Y/qBgS9IpyEJuFkZ5Z6OoGKovkzIS9fBpwAlQAcIOoLF706I1tJ/28txcdYRymkjwk0qYM4eMUy79gTNIqyiu/91l2D0//v527tbSyO5H9I+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028133; c=relaxed/simple;
	bh=ekzwYo6IFAabQoqLOCbyJuz/S1yTjzZRX+VXHTu0eS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6SpXpLR915bmhAJnPIA3PEoim+YhA9t6PZNPPhAGJ4AhQ/haRteUMwhMUQjD2jw42JVDmk4pU9UxCgTOg7LheNPeHQZsbapiKsL1XGC4pEDfEB8L12BjaPwVg/edmq5L/cbOOTLd6TT42E7BFtdFZqqVECL8WNhGOW2L0Zob98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=n/C+C0Og; arc=fail smtp.client-ip=52.101.61.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="n/C+C0Og"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biN7auLD5/Pia1ivi053PsvotFS3hk7M7gOt+pHGPf9qoEOLthWPHbyrfbLVOMsRE0i0DAYiSPdP3BsNFVupWqdiijQs23e2uE69rz/eUESnuqz27NwWc7RAE4H2VECii46uQQozZmVxgT0qEwcB37ZKA6n3y9Kebt3T+fswsv7gM7aAUmZDd0d4L7vGCqFS/x3uwBugGuguwwVo9M+HtaxusBatgNG/zaYZTmXTYxJQQpxEN2OX5rrrTyoxcBxKvvm2fSoRxy4qch5HtfcADzzdklrqW9qQyAfkaIeHkn5HuuTPtI7qmDfZxuMEMqCaVuXmCtR/Bn0yNOKCTiXhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx4yuVRUqEO4AyisEW0Rb/Ol4PtWENkMerlyl6CPBnw=;
 b=jLWcAAz7ahj3GRrhYNhMCZboPoDD2rr87r+qr1SrXl9nIEnXjWhVGoxs0sn1jqMPyStz+LlYfOIGf+j/py0KOU2PptKBms75N7t8nELgNJGS/cYLU09/o9q1yjTIM05v5dmUZ5ItUVCXegNKflUqDA7lLjA5ZlAnt3n8eAfVUoo1y6iHelhdaEryVxvc1wTs2YBEA/bQDGLUYim0COSAsUKafHA8jP9hb2nhgJQXjCwJ0oh9V7zSWJWEpwH+TsuK1MT+OCFVKZsXUp4HPnNLkHQvcJYaGlo2bqKWXSaO3VrqIrL0Dk2K6ZlwOIgCVUzJVT0farxZMnIHoOiKMyLNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx4yuVRUqEO4AyisEW0Rb/Ol4PtWENkMerlyl6CPBnw=;
 b=n/C+C0OgQgRS3FIRJTNXO85Djo+3WfJ4vcJ+UCXKl3V4uIhGRQI+dIKQHmHMEE2xPM7a8E3wFMrehCNERjDVdk3o2U9O8TNYRT/Hc7wooQwE/lzlJ74o7kmL15zraQi9xuyZRzG/uKEbJX7E9Q/UKEaARA2bDVFP3iopfg5pNlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CO1PR01MB7385.prod.exchangelabs.com (2603:10b6:303:158::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Fri, 8 Nov 2024 01:08:48 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 01:08:48 +0000
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
Subject: [PATCH v4 2/2] perf arm-spe: Add support for SPE Data Source packet on AmpereOne
Date: Fri,  8 Nov 2024 01:09:11 +0000
Message-ID: <20241108010911.58412-3-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2ddda937-3b49-4a32-01a5-08dcff91e6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/2aQVweG6X1Ct2+ZhCSQ/kFrP6RBSe6n6ktoUlbq1aSOftnhAn2y67x+KwP?=
 =?us-ascii?Q?AMimueefB+LbSjNnLOXuG9W+3/a787e4/X+AyVXBWEV9ImzhkRyV7qem4pyv?=
 =?us-ascii?Q?lKV+ECIqglu5mi2h4y+HggZKruks/SpgbDanEhlosOYeBtLArIQxQzs3W6MJ?=
 =?us-ascii?Q?3/j0QFFHplZxJiT6pMYWb6h/NIxaexHHvA2FZMMIu8UB2jmM1xVj4z7ymrzA?=
 =?us-ascii?Q?cgurNZqHfFdOJLdoQ+Z1rnIOYA46pNKKxO2Mnez8ZOU5NNUwEYa2+ppJ3A0R?=
 =?us-ascii?Q?aUIAWLIxaG3CDOXrDXQ9Apa6IPxvOuV1UYczMOtyrLGeJ2PNm5hKL92GTxgp?=
 =?us-ascii?Q?5AgwqmG6BQKqLDgeEDem+yvQare1CxdTKEAvMS7C0f3tRolX/DsfIWjHqQ5p?=
 =?us-ascii?Q?h7g4gfg9Y0vJQFB8Hy4W2w87zwT1V3BDOsZqd1ev4M5LwNgiI/mXNhr0aRtL?=
 =?us-ascii?Q?k2znRZLgdkUcyCOXzYlRGn21n+Vlzaf6T9rTcqCA+5kgK2B/NuzXuXKLTg8L?=
 =?us-ascii?Q?FdT6ert3eBiBlMxFb8T7/lyG91cA2f23n3w/lHNTVvZseCvdh6g50qJHyxaH?=
 =?us-ascii?Q?iQhwmFWrsjcfA3d/OoqRotFMcamMAYhM9Q/r6iHqkDSOeFGWC8VivqmIOYBp?=
 =?us-ascii?Q?RTHqybyNMXxFw6DFLm8svK24P2MsFXgMKfXgbcrAbtITAfS/D9kBl/Xk+MWL?=
 =?us-ascii?Q?Cu9VmKIn7v7AAH7tbt84U6A9a2j+iylW/MyqtTKR3elhSRFYai6Yn32L1lGi?=
 =?us-ascii?Q?cepLAhkolHxyps+BxWk++dpRAZYOs2Mo1y4AkhQpIUW4QmUIpC8FXkmfz2+t?=
 =?us-ascii?Q?bY07Jeixhfe2ZW26DWMxT1aJ1H+SjOlsSOadqQ5bnaw6nIJQfJHLNVmeQ7fI?=
 =?us-ascii?Q?L4ltL/52pVByTuk//bl5EPbC8zXY6tdkggO0aZPAQ/wPMUGNm6eGIAlYlScO?=
 =?us-ascii?Q?xokVBY2T7iFbSbwUl4qx1mpy8FCFut6lCsx3YF3VkX2xqJn7TfY8r93wdEGE?=
 =?us-ascii?Q?D0TPxAWbYU2luDhW7KcLd2DnTBCsLIDIZnhdfajmCQWbcFxjOgEMmFqgHwjL?=
 =?us-ascii?Q?RS04G+x7nAm1bAlqvxqaDyQQaUanrEMEPoFDy1eb7SPo3YAG/5+A6S32mLx8?=
 =?us-ascii?Q?ligBKn11UicTWHsEBHvlzNLGleMWItVcj0LQzVaIdJkYPxJreBv4tfnhlp+j?=
 =?us-ascii?Q?6WXqGuk2ZBq/uTKLj5iKcRc+7xrw5rMEAXd32JWgdqAbCd9sb7lujzD9E027?=
 =?us-ascii?Q?x63LSyZBZGm+scOekVyjrj/yjcFup32NEJ0KU1SneEX4Jw7tce4MD7jGoJES?=
 =?us-ascii?Q?ODtB4p0EX+bU/wkGMP13UgJIe7VAmwohAasIuHQk+Jx7g9cO6EnvoH9KYY11?=
 =?us-ascii?Q?9LqPFhTwdhjMS1rmwZ07tJC2mXIp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IXAOS9Xq1sQgLFZetGX28Q4E6g/96UywD7zfVd9cnyNOuJ1sfyx2Q2yDm2JC?=
 =?us-ascii?Q?3F2vYWQU1nxPcgq1YLPRey9aKCVuGVG9jUmbOMklllQ9tOIAZ2on+DpUvagG?=
 =?us-ascii?Q?XHGWKaaElKrFxKay0tCx+4/ag2M6bXfWcwRyTk8M9mzUOgJRSY1oCjBf01Ss?=
 =?us-ascii?Q?HUx3vSqHgcZo+6zrhzTIrDHMEVWlCNx7uxaik+1MbSUVDmIXQxXXMOyyi/Fh?=
 =?us-ascii?Q?AIgnepuob0hkYuNuNxAHXzk3XIig69kHDSVsN6pTLleCVxrBpoPMAUsf4YZF?=
 =?us-ascii?Q?GtEx4uwhLW5PCkQj7Aa+dUdiHGcYI1HeEaDS/Os6recbT0pw6foRzuq7PTf6?=
 =?us-ascii?Q?HDRmSfe6897ZK4rBIhifnFI+U7hqr67azWh09zB/ZNNlEnvqzSYN4Q8a7UgS?=
 =?us-ascii?Q?dKiXm0ozSfLkEodjTXjF1fKAqTzMuQ8Q5UDGyEmEz3GgLYiONGwjI4BmbZCh?=
 =?us-ascii?Q?kxyPKMNYshrGdjrs3seBdRIC5sIoNJpbBCne3nVTGd9VM81SOrExd+aKuBu5?=
 =?us-ascii?Q?Q2Wr7nB+AXeqPvJKNO6Stg4abcAvz8JpWS8+0wDnazZeL86TNvTS/mGQ6TiM?=
 =?us-ascii?Q?QM1CrQ5ygIfICLJsdXcuhkP/n3oVLft8OrXc7Xm6V8pjvY/nkrxEa9576lvY?=
 =?us-ascii?Q?pbk8vIm8a+2n0niXrARgWkHVSNrLA4cOAGOQQhbMwV2ab8Yc6z7A1gIwx6xw?=
 =?us-ascii?Q?B2myhuavnLfz5VdDHxv12pqEE4QOPchAd2R+swh/2ylz/DnIq2Vapi05ghnt?=
 =?us-ascii?Q?wBXm0I6N+SJ5knsB42HMJeNSetY0BjNwkH6FqmDITHnK0Z0UiQuzgXqImiOa?=
 =?us-ascii?Q?jaEVbwcM3TdkPpkWzQqelg5VLxmUwqYhQV8OqoM+3HuksnkGo4ISYsWz8RKo?=
 =?us-ascii?Q?BBX7u+GGCxiWy6SVLC0Sv623sVzmxmcfTR+oti26/5Pio8nvrhYHp6v1VGAF?=
 =?us-ascii?Q?mjBhoDbvFuK5neFdyx0kLVA9zvygMLGVK+T52H1D6Cx7qmd8wDBZDNk+nhzV?=
 =?us-ascii?Q?qL+vrI6Hw3Us7jm4CYyIKkrrm5iharcu1GjwxSr9F4eMRYCu/8/OXF/260sr?=
 =?us-ascii?Q?bmhjSUIhUYm8P16Gv5TR0we0HdA9h7R3de9MUolS4RMDYsoEg0Mg8n9ND4PF?=
 =?us-ascii?Q?zVVAXss2hheqoplujiWXFAH5eFcYpmbdnFEeWyeFM7EgXJ37jhMm76cnITxL?=
 =?us-ascii?Q?ILKyVpAeBOguYFmPCKSUvnCyaGbZY73ETP10jzmek5UfnbsO8+DD0vNVZ02J?=
 =?us-ascii?Q?BEMY+V+syzAgsb78z6WuivDxDMbeYlPLO0czYrlVn6qF5ECwXbZ36v3F5ucU?=
 =?us-ascii?Q?fody0ugadvHsmplWlh0C5sC/SQdxFpaS1kPMO3NYnZuYCcieHsvLIxOZQwyB?=
 =?us-ascii?Q?FA1GO4TrPqgs2QLozUKK5UP35wUb3fAJzXkBT4Syekh7zzdYzYTlu57pcmxm?=
 =?us-ascii?Q?7cU9/SPRe7Y3G4suLfIg2LL+uOjX7tdNLFtX2RIic/38Nz0nBnzmrkCzYouI?=
 =?us-ascii?Q?ttAm4UZtPkn/ejzUIOMlqyCg8a9yjRjIDHU5bwtpMFmgyIHE+qEs+G8OqTOk?=
 =?us-ascii?Q?oWIfZwSEhwKZxx8rE5YOrI8sxJIVodd1TS3fyMuu3PsCcUsvajStH609qJlt?=
 =?us-ascii?Q?+JdJ4sRILDaz8rwp2L404T4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddda937-3b49-4a32-01a5-08dcff91e6bc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 01:08:48.8423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Vua2hu1KGj/6jE30bqgQ0FKsgmJm+xPhmUD4CJh2j+pDbg3RsjJsg4xF8Q7sBhnbDoFbavZsO30/nCqu5NlC9HYdZpa6h022QcuyAyGwG96BNDt9Kpnik/zRheuuIjf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7385

Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
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
index dfb0c07cb7fe..df84933b673d 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -455,8 +455,14 @@ static const struct midr_range common_ds_encoding_cpus[] = {
 	{},
 };
 
+static const struct midr_range ampereone_ds_encoding_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
+	{},
+};
+
 static const struct data_source_handle data_source_handles[] = {
 	DS(common_ds_encoding_cpus, data_source_common),
+	DS(ampereone_ds_encoding_cpus, data_source_ampereone),
 };
 
 static void arm_spe__sample_flags(struct arm_spe_queue *speq)
@@ -548,6 +554,44 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
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
 static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 					union perf_mem_data_src *data_src)
 {
-- 
2.47.0


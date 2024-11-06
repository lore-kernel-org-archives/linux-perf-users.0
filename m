Received: from BL0PR05CU006.outbound.protection.outlook.com (mail-eastusazon11021086.outbound.protection.outlook.com [52.101.52.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BB20C30F;
	Wed,  6 Nov 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921836; cv=fail; b=L2jNtIvfKqfXtJKo6cemfmL4B/a4cjQZFG0M/LAx0WjzKBP/AwnaUtRMIL92dNbUOsH/HGvuXLesnhOj5ysNgQ405NozHem4RMdtcwu5X+piqNzaGSRtKFeQ658qBZoHmCwPdWYBKHMc5UMVjHLVo+g+Yp9N1tElS0ngGEXa17o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921836; c=relaxed/simple;
	bh=gt9SvD+TA4nRx4Sn0dwyFU69Gm55I3amhufw2L5zzBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TH418GNIh0JX/KUpe79Lwax3ZrE/v/OjhxXpnjQSvBm1urW/5zstmBQ2SE3yy4zx3mPz2SFEHGsMerMewHN8yJV6qKM98mJOyL/5sL6UP+UlZW7+Zda+OJjs8YNohTWmVe9+OgPob4YibgooxSN8rH6bnYh8uBWdaEYUCPR0KRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lDwgBQed; arc=fail smtp.client-ip=52.101.52.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lDwgBQed"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FG+aJlUGIzP/OnBbB8uMHj9ZscPTHhoMq7mPvogjA/BRwcDksrYsNHybxOhez5HL32uiiEjmsbzLYmE+HIBV+uEWSzW+Hey2dYoJysLBv/BoC1rNJyFSj4NwR1AZAYE183VdMTUi84TEe4oAnFrCJRe9XZfOvlFCmg5TVtnYz+wHionOgpxkboCx4aFJIHfH9zIcMxwEI5iysIBbqdpHEHRLJENZAwsnXMJzFHqlaJ/pF7CrVdC4IK7/2TXEte1ctyDpPE3cqbyNmEzsTS0ploUgAPmopFHTuubHxvxJZLYDfM4VnzNpG/lZPWGVKp7FcWGiG7GQ5JAGx5MH1XN7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaoqbpkRgrgy8PNxBKuexzT/HltuIpEhApRiHOA08to=;
 b=TOYZa0HbB76JLJfkZIEiV45Yjqj+ODdNjVWeJXDmteJjbMvTEQTYBUqR6vNCcae72XOY8tGDZNbn8bsF7WYRYix+1rQORkyDXzwawqfdjkEXRMMspIRYJOuM9/Drbjx2FW/JyAd7t0zFmjgRuBXorXK+Xjt2UGptLIBoT7MQ0lv00P33+2o+pva7CbDG+hXFL6TnzaQhYpdgUxRdHJI6UjCsiPT4Ct0ZnNXMwGRFqsZzetxww7DypQF1fDCPEtI60OYIzHoo49RCmIJuDo8bLDqUnDvpaaHqEPB769t3RdOhZjI33rJPYzzppjA9yet6dE/D4RuBeubUi+DKknTwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaoqbpkRgrgy8PNxBKuexzT/HltuIpEhApRiHOA08to=;
 b=lDwgBQed7JjtPlE1DT0Jl8htkp+zYLDyZ+cDY4ohyiM49ToyK7v5DBrprebOVXtAFnUSCLFl14p9qyRzvpvu6wI/PbvMLdG4XlbDcRlynnuFv44vZ0YIQi2W6XCt/sWjWjKcVPs80oIosSxKG0SOnOwsUhZLIbCQdLr4nax8VCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 DS1PR01MB8775.prod.exchangelabs.com (2603:10b6:8:220::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Wed, 6 Nov 2024 19:37:12 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 19:37:11 +0000
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
Subject: [PATCH v3 1/2] perf arm-spe: Prepare for adding data source packet implementations for other cores
Date: Wed,  6 Nov 2024 19:37:39 +0000
Message-ID: <20241106193740.6159-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106193740.6159-1-ilkka@os.amperecomputing.com>
References: <20241106193740.6159-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:610:11a::9) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|DS1PR01MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c076ac4-b768-47d0-da02-08dcfe9a68e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZsBmUxGYXVDbExnXaRPR2a/9ATpn04n5V5riDbBnuBcFZwwuIjSxhp42VVZb?=
 =?us-ascii?Q?OWyut5V5SHBYeVnCO8nACGkjjpvTJNPNjss/4/ZRjfwJ8vB37iRECn4nm3Z/?=
 =?us-ascii?Q?1sIBVbE22Hjt5TTsC9rpG41N67KaHG0mpIQi6Gk980N4xO1LAH+a7b9dsFpf?=
 =?us-ascii?Q?A8/fUnJRO5G/WPBNeWPBQ001ov8qBRc5Z2o1aI20rX+DE8y/4fEo2oDguBH/?=
 =?us-ascii?Q?ZeZRR/4hEZxJm3h03ymzDamQxVecNptWhxE5VL++Y3A3I4aVCajKuSo+f/9t?=
 =?us-ascii?Q?mCzFui5X6JXFUW5FcdIga34/kK8F7TbVhBOtsA5W6nijQJQQdhu6ltmcWpyi?=
 =?us-ascii?Q?wgVHpGKu7v1RXaAyNyzleSYcbAwyAGCxecbgfR0R7+mrH2po3vDkqMH5wJAv?=
 =?us-ascii?Q?Cd6JcvodkvzQp9e4d33sljA25NzU6r/ZyVhB3Nf1ZvcG93NgwEfCfzazqruY?=
 =?us-ascii?Q?ClYKs4x7nJD/7AkbKsV4pvpDLqaXLz2WeQ/WJLQdpm77cAMBm0MT6uPKVDsl?=
 =?us-ascii?Q?LvCxB+YNmTVoaqolHhKEd9Z0Dp6mqbzHoqNfefCTERTPY7YEefJVkNtuvHUM?=
 =?us-ascii?Q?4EfIkWER+BP8drGI+tgEIL8U61jXy+X2loDBTpD8F5lalchxlsRPeOWwecqI?=
 =?us-ascii?Q?YhdPB4rmGF/zK4pkqiPSLpizeS5d61dPwyudO09ZftRHwxfsEkZn1c+rullo?=
 =?us-ascii?Q?LmzeSYQYmuP3BdG8t9WPmyIW/ys4baNCquRcSjh7gsT53Gojd9t0MynB0wSM?=
 =?us-ascii?Q?v1EzpaKYgtyqnK/CnK/fsOi4RVmPzYl+1AJX+mSUV+n9Du2erA0Rmh4SzyIA?=
 =?us-ascii?Q?Fj0Zp2BrBi5iNEDdESiKtt4NK9RBUOUMFQ3xXDi4fwi/Cjue0a0okOfXwYKs?=
 =?us-ascii?Q?XgQXjPr7cAhYVR3kPAf46GoBpOndV54Y4XoVA2ZF0a/GXeQoT19PWRT6pBWR?=
 =?us-ascii?Q?14bC0M8Ix8/0giYkQj2No+q4uxXcshElrl5SJFub66rvWTLYG9PlVML/ZmNL?=
 =?us-ascii?Q?ZlCsIRyjw+IocX7oBMklHE7QFadmWSQKhTVDft1DDBtXe7Jjz+lTJAOEoWs1?=
 =?us-ascii?Q?IBtdZRLMS0bRzlJSb2s2tp0qPn9S59tQ92hGlGCasVJlkR04cEuEWD7/OsaS?=
 =?us-ascii?Q?dcz+CiT1eZx4u2XeHiGqVCw11N61eXkF4d97Z3DBPFhHQi7e2oWVZa/nC23g?=
 =?us-ascii?Q?P1nQVU/6tVol9NA3aGxlXSeFODcejPPhcmNB7R1j2Lvl0j3cOm/LM5c9lCuQ?=
 =?us-ascii?Q?h7GFtUcWgZJF28ntCoPjxZ8ZLHI/nybCbEnTS8+q5+01hDrSKeiPchjV/Rf0?=
 =?us-ascii?Q?g3IRr/4iAzsBznoqO7Uda7dUmvVCO+ioYjHk7TBMWg3kriZHzobOrVDQ3zio?=
 =?us-ascii?Q?jpZKYh6hjy4jdOD6cpqAS5qThqGP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7g9hymY1fjfSP4V5AJ1r5C6wkBjtvyogmpUa7ZA6NkWB16c9m7noijl7+oXq?=
 =?us-ascii?Q?vICRDFnBQFXxT8UkH+DjCH11By0TiT3LpZK2Q/iqlsAXY/u67LJ7U9p9e8EW?=
 =?us-ascii?Q?6rdwoKeI+Q6Kv2oAXYcTp4K0KcwCdn9BLAs1+aAN+Kn7SWiAJ+yYL6olNUAx?=
 =?us-ascii?Q?WONC5tjJRAAvZTDpjDMcemAODKJb0gys97d+jLXIbxJUr4b73DoHEtJuf7S0?=
 =?us-ascii?Q?OBmeC8fo7eIy2DB4qYjBW3kiJrQzWkhTCb32LymJ0PsSNwwkXG7B3VNQ+fcI?=
 =?us-ascii?Q?5A7g55OdE5qoG9FYmIOU3wqy785T+FUtxeI741kBlG192KVMK8TrRVAOFzx3?=
 =?us-ascii?Q?CwrdQtNyu402FdTspgMzcll5qyXzAu1WYniip/TAJ8Ys6ugViFtJHrWKmBsv?=
 =?us-ascii?Q?YFxG+bdJ6+WY+qGfA/SVJuc++V989dm/GlRkJxEfLSkX74RnIOvtOjSPxA0i?=
 =?us-ascii?Q?P5ZHvMH7QYHlD4r0iTKBeiQE9ikhxB8oyR7CvKn1Ef1Wj9tBH0GYRn7eUyuM?=
 =?us-ascii?Q?FqC2jh4y3w0WmwvnhFKxg55GO3YPTsd+PaGkSh9Hmthvq97LuSYs9r5hLmbA?=
 =?us-ascii?Q?N1UU+q6CjOELnXIumAHGMKtx8TypPJMCgUzv3yjRcSA5sOSe5/m5ryGk7BnC?=
 =?us-ascii?Q?thiswxrYW96lkZNqnCVaDBE+2Os9pC6XryeC4YIsSa7aLYqGcZwSbAIg8rnz?=
 =?us-ascii?Q?YHAP/vp9Rr9VBGl6v+yeqWLNUwRAA9S9WXFaSJnv1hQ0tTfFA6YNIn4g/+pj?=
 =?us-ascii?Q?S3riKIjfRQCVjUMrhxVI2cl3ohzNth79788LO6DNQHTsAPSwA/Z3NWfgRjA1?=
 =?us-ascii?Q?qVhbkeAYW95D0zv4L2tqVp9zMpgwn0fPvdtZ6dosC14acJXmaVwlLuItSeGU?=
 =?us-ascii?Q?Pwag/dwmx/z9aLA46DtFo6HcOexwRjZzqAKiZ+llGTUcF66PC5FszSMP9WMu?=
 =?us-ascii?Q?FxERBmnQmBCu0QFYM7fekOqjXQozLJJaJfBOgJvMQEPUMDXNUepqApUJNKBV?=
 =?us-ascii?Q?sf2Z8tBjNQamm1jvl2JsqQMM489hTd+TkYomL9TwaoMEgFgA1rVgZkWUJDjr?=
 =?us-ascii?Q?HpxZzcLBua4zynQAIvHBtPRR0knJfxrzzMBeFTMpk9OYqKkTccNhLIUhU/xW?=
 =?us-ascii?Q?7oArZiWkWGz2pJcD43QURbcWqSClqFyScgGynLWVCPnDZ5Lwod/5fkV1hk9A?=
 =?us-ascii?Q?8XT3gG7H/MjTWGR3s0RXFCGX/kmeCkxOkjRdzUaBC4OdonhVWtjRw7tB7fYK?=
 =?us-ascii?Q?QYuTgDh5C2bjMpDB+XWUInuH1I+H7V8fzIkI/abVcLYaGFvwZRFtj4IvtGnX?=
 =?us-ascii?Q?afSzK0IMvSE6PuHgWOKGgheTr3CyoZV+VhANdMkryZwQud+JGzVfvxtBXRGt?=
 =?us-ascii?Q?uIcy17MXTOPSLo2g2t5vQw8zLUVOo+qshnP5K9LxAKVLuFuimfJLJPyEEwiN?=
 =?us-ascii?Q?RZNprlthyKYkXaolnYGep9mClHjdoSlxxIUN4SV1N2BMf6rh5Cw++YaygMmX?=
 =?us-ascii?Q?zfnMNStMnO7PQeVBGp8usdWaUSbsGsSKswQ+LbJAh8bwCvHd+wiJHpxDcnXk?=
 =?us-ascii?Q?D9ukGaPbs/ZecElFD4h2zX4qulbBRrjMjC3+ZTa2BtCw3rBOQFB+r4yTwns3?=
 =?us-ascii?Q?qlev8a6Qpq7e+5QbcqbwLiY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c076ac4-b768-47d0-da02-08dcfe9a68e0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:37:11.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5408EUNlU3E6NjDx1+gqA4jKX8mXoTKaI2z9PjyCzFslCNIXSdwewDRUZVSCBVBWn824h7m/OtNjcT7YSQTRNBblyJ2W051G+KRk7tJB6fnyeEtVSIY2HbZ+N6HjlxKt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8775

Split Data Source Packet handling to prepare adding support for
other implementations.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 tools/perf/util/arm-spe.c | 65 ++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index dbf13f47879c..b222557cc27a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -103,6 +103,18 @@ struct arm_spe_queue {
 	u32				flags;
 };
 
+struct data_src {
+	struct midr_range midr_range;
+	void (*ds_synth)(const struct arm_spe_record *record,
+			 union perf_mem_data_src *data_src);
+};
+
+#define DS(range, func)			\
+	{						\
+		.midr_range = range,			\
+		.ds_synth = arm_spe__synth_##func,	\
+	}
+
 static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 			 unsigned char *buf, size_t len)
 {
@@ -430,19 +442,6 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
-static const struct midr_range common_ds_encoding_cpus[] = {
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
-	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
-	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
-	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
-	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
-	{},
-};
-
 static void arm_spe__sample_flags(struct arm_spe_queue *speq)
 {
 	const struct arm_spe_record *record = &speq->decoder->record;
@@ -532,6 +531,19 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
 	}
 }
 
+static const struct data_src data_sources[] = {
+	DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_A720), data_source_common),
+	DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_A725), data_source_common),
+	DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C), data_source_common),
+	DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_X3), data_source_common),
+	DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_X925), data_source_common),
+	DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1), data_source_common),
+	DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2), data_source_common),
+	DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1), data_source_common),
+	DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2), data_source_common),
+	{},
+};
+
 static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 					union perf_mem_data_src *data_src)
 {
@@ -555,12 +567,14 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
 }
 
-static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
+static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
+			      const struct arm_spe_record *record,
+			      union perf_mem_data_src *data_src)
 {
 	struct arm_spe *spe = speq->spe;
-	bool is_in_cpu_list;
+	const struct data_src *src = data_sources;
 	u64 *metadata = NULL;
-	u64 midr = 0;
+	u64 midr;
 
 	/* Metadata version 1 assumes all CPUs are the same (old behavior) */
 	if (spe->metadata_ver == 1) {
@@ -592,18 +606,21 @@ static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
 		midr = metadata[ARM_SPE_CPU_MIDR];
 	}
 
-	is_in_cpu_list = is_midr_in_range_list(midr, common_ds_encoding_cpus);
-	if (is_in_cpu_list)
-		return true;
-	else
-		return false;
+	while (src->midr_range.model) {
+		if (is_midr_in_range(midr, &src->midr_range)) {
+			src->ds_synth(record, data_src);
+			return true;
+		}
+		src++;
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
@@ -612,9 +629,7 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
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


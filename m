Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022137.outbound.protection.outlook.com [40.93.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD419B3C3
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Aug 2024 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708182; cv=fail; b=L8uIZva6CH6o1yjErVllvcPNO3LT/j3WETiHWj6MC7W+3yq2RVyTlJpF7t3GLq7QzPmdY2UKOn+D+0KEz/FiRSvi+ClJegRYzUBvg7lTWOeQmf8fkBwLXhXzP4QLQSDBjSfm1hO76tjAZJbZqdpDeoGFnJHLCHxXiLzuhNWYCng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708182; c=relaxed/simple;
	bh=gEXJmtpGG+GxZxH3XNzJf8HWzI090mO5mF9e7INymZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMqk2/sV7xWQ6xx8nsp7RYrcmyTy2NE78svhgizg9FloRO/ig3MWZ+yVrNnxYWur/h4Q1RSkr5Ptt04jGLLBwqf8ku0aANlVxMOVBTP6mJTKR+FPjlR217Oybk4cIcvpjxMPPoVZffXjZI5CXqBCzBjKGPNagsMNTAQm4Njaer8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=fvDGWXbB; arc=fail smtp.client-ip=40.93.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="fvDGWXbB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQTEQ2EeyFoXtVOl2JM6DcSqpk+e/6/Ht/CcJP09gz5/Z05QkGEkK1PHlAeVxThQFNqCEu6E26cQtZvF5cA83n4V2E6ivbGjCKmEHO6PrzGRHaETVKuHa+tzJzIUS0PWrLSCyGXOGZlpjqc2d97b1+CbDL4lUo1wD7TJL1VLbDPsaNxVw/pYag0Qa2PR4lllnRBrmzZZSXd4G982zpX1FAjSBTMugVQTTobtiDgT9E9UFGHmE5x0G6ynM3rBKq1RzUgDgh8ZFZycC17ZRbUjSCLYwTAi8NebUZ9PbLai86OSJYUh771JjOplCUfEHHl0uLt/PJgLXwVHfdQ2QOFD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyJOIoAT/e8kDozGR4O15DBCTLg01XAPpAw7eBjWNjo=;
 b=HYt/yiDX+NYM/xvZs4giOMSiDkKuyn+zEuUqGZCJI1kDFPEibZvZZPYL4XnW852cZ2DcANrr/fi/kGVkjOeOx4Cz3I6kPPE0QJkFTsbCmrdEJkQmWK0iOF/lgqYKAyTZbbhU4SVh6G42WFnBWvAbqDXD1VFpPkC9t9hmXzC0m4fMG5aYjqzebI03piJEcl5weIrbJZbVWnZk2Zwlin0Tx6jz9CNdZirDolU/+QDp4F9/5kp5wicCCeZX+D7dU8CkvVTnC/917kFtlu1hO5NgQn4cAYGZvXtZ8/vtaXt2uUUVvFkjpKf6/zkV7bsBKDwbIQW52JVqoH6tKb1Cc1GpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyJOIoAT/e8kDozGR4O15DBCTLg01XAPpAw7eBjWNjo=;
 b=fvDGWXbB2y0jdRnabe/tUoS1AaejR+TzmespaF17huT1JfuSIaImviFAnlfxLZccR5p27nQzlWP5N7BR0mP/C9U/9GJ0ODMxAGZaCyfLoBrf2cfFo3hbC+bA34zh7Bj70MLg9ii8RmtFXz3Sf109EL5VPziNSNQOD4vPJ2HgtxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) by
 CYYPR01MB8410.prod.exchangelabs.com (2603:10b6:930:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 21:36:17 +0000
Received: from SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea]) by SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:36:17 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 4/5] Add map pgoff to python dictionary based on MAPPING_TYPE
Date: Mon, 26 Aug 2024 15:35:53 -0600
Message-Id: <2c0276834838dd444ad11fbbe670eca9c17f6ece.1724698250.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
References: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQ1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::7) To SJ2PR01MB8150.prod.exchangelabs.com
 (2603:10b6:a03:4ff::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8150:EE_|CYYPR01MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbdd500-02f2-4bb7-e2a2-08dcc6171e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hdsGdBcpIrkMC4B4j8rr1fassa5IXFXeWqJqcVvZUwYRo38pVqv0x6Pbv9V2?=
 =?us-ascii?Q?RCoC4LNcIJqyK0RXTSK61ug1RNChMFhb0fbp9fBIxOmJE9hvf+xt8uB7R+bx?=
 =?us-ascii?Q?61kKQUQCWwK64naI1Qty7ahk/5PfnB3cbF0HQiZAYk9/WUfwwbKL7BWObxh1?=
 =?us-ascii?Q?+oqSGr2MuQbbyMGxGRd21tT9NctRhi1cLT0shXEw52tWeP0RDoIYCzCz2z3C?=
 =?us-ascii?Q?H7ajsNJNZggEoch73mUdENWuXdmfZic8KmT+MT+kLoLtMiaHRjsna+Kv6QbX?=
 =?us-ascii?Q?xiiCU+kRlg+Xtcq6q8UNzZj1IMH8ZcO4VEoM/5WWfwh+7/S0yKd1IQgegRq3?=
 =?us-ascii?Q?LPIye2g5T/KlxiFFUb63Mlqwx9Wu3Fbo7R3I20KrzeprZZFKPkOprEcL4zLN?=
 =?us-ascii?Q?zz/R/zRdVi9fS7S1r67GFVU+xPxH64Ij9StfL4AY9ALB1e7eTm63KT9z2+K7?=
 =?us-ascii?Q?V9iwqqr3bRlqqdmI0SqHJYnpICx2m8R1yVxs5KXuvOWMKcVF4wgFr6jyynGj?=
 =?us-ascii?Q?lmg9Fk+eUN9bNf1DTFrn8BXGpFH6asBi7yVgm3eFguWDmvsE267Eh4u3YGqZ?=
 =?us-ascii?Q?aqWR15F2YK78+qyZUCm6XKJhcSananTHxrcBjwQ2U9h8gW95Q/PknzKOcek5?=
 =?us-ascii?Q?g3gVrXs7XRkBxPE5kLvdsga2YaulwQ4FxjtCVB02di3e30+gSxLq2syo4S7/?=
 =?us-ascii?Q?Bis+KZcRSK8Hit+JwTHljJU5cU/QlVGfan0c4rHFCQcwL3dPgo1MJuYwOo5+?=
 =?us-ascii?Q?pE2ZMgvaHzjCXCgVFyKnFbWtoSe9n8jRDWdy0s0/GQpteiud0k+wGHj2ygWH?=
 =?us-ascii?Q?xiFd6s7G9M20mrRO4RIuS5H7PrrnqrnQmfnkGxRD1uBXZcfZmFLbnpziJhzb?=
 =?us-ascii?Q?us3wJR5j+vyHy7zrhBgJJjmT5T+tJ6cZYnJa8EMZ2y48lcjbuw6/XdVi23TY?=
 =?us-ascii?Q?JLeN69oZCiiFIoRYkhr2pR6tvTFtBdTvZQ4DD1PFnAdfvQOM/RKmjAbrB0Sh?=
 =?us-ascii?Q?oeAonZoSh/SkPB7mHtEL2edH/UTiwLp2EJ5ERVxj1qZJcH6AjLog685MeyH7?=
 =?us-ascii?Q?Taa+eWbHDTtETtYq39zkldoSyv3zTPx0Ml6Y/DYfLHY/QFRtDWPDVYzZ74RN?=
 =?us-ascii?Q?oe8npQ1mCHsZDflbDhSoR8VI5WS2II5VI4ebIkAF9Je7DMvsV3wC5WnapnGs?=
 =?us-ascii?Q?YPrZIHvvgiObFsyAw1/mWm9LPLwOJbE7O2G1guE3shpyKO84UP5OWe73C2Mo?=
 =?us-ascii?Q?QBZEi73B8EZsCW3/lrTr8iRs0qGxSWgiss3bimrmo1LDTNxmK+qFNXkiKZZq?=
 =?us-ascii?Q?O3lRIVyRr2jOHW2hZMiwFVgqacuBDnhveSIiUugkAKi5XxsENurjjZoc1lsR?=
 =?us-ascii?Q?g2Ssh/Kd5T+Brt/Du/DARjerjj99w+dPIdcd/vXQadR+HMvhOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8150.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?up1VzwWdYfQLFfHzcWJus604eLTbeYCvY4toRBLYzAmn+++jSGm/ffmdKZDD?=
 =?us-ascii?Q?GXTV7RhiyxtCCffDww8fOx8pIN2LAAnLsoBhUi442emev8grBd+NVO92R2Si?=
 =?us-ascii?Q?q6baSQVm7ppMwRtFC6AXF25BBDx+ArKFVq4O9NAuNwJR5l4LFwJKZ+lXJ9qq?=
 =?us-ascii?Q?QyVAkPxUpfKyF9Xbk0wjjqjsq/iIdfCy6Zq0p2aB9aitPxlDqTRLqYLKgWiQ?=
 =?us-ascii?Q?LfC3PmM2wVAIiTG4Zv16lI651HCPyyJsLs0uTJHLHHeBBlq6oe0u3uJRWrMx?=
 =?us-ascii?Q?UtrvKd32zBXasboKVrfEOTwKebxs1zNvlBdLJs3dvSgUp5MyCdumFkGRTgYI?=
 =?us-ascii?Q?CfvifAOyHshFWrafWcfBW9xS6eQ6HdFReNJj6jJkzPC8Wb7n4vt673+A9DVY?=
 =?us-ascii?Q?zgesVSVJ6cgDA7kginNT95r/tTyo0VDQzavZFE4LzD8vg5MKEf6Cx4LkEqRK?=
 =?us-ascii?Q?Ifo7tDIJUa2heKL1dHBzMM7zliNenPgmEl/k890xbIh8g48uOe1IEGqrmjq+?=
 =?us-ascii?Q?LsSOsQyppamj3jHqtCIqAUBmMoCltW+uUYQBDFq4ySPoIYX3x3x8617xJg9z?=
 =?us-ascii?Q?3pGAEnIqBfN8XoF9OoBB4DZ/zMbkaEupebV6CIRo/vf5N56QoFDaUIZpL2Hg?=
 =?us-ascii?Q?nVxQ9QfBNn7QMHsAnXOz1TMOQK0EZ1zWPTuulJRdCqtGiTTrWnx9qb/K+hZ7?=
 =?us-ascii?Q?pq8bOSuYKNUFkYRgF41eMfFL7sFuOHO4Gq+mKS2aL5muZnR+xxKALMNN1Ser?=
 =?us-ascii?Q?SmVZMkJ1iA71CdF7cJZ8k9fj4P+elmQYNeNAWftYa81UJsMWRBk66BKh0xg9?=
 =?us-ascii?Q?boPEo9uOhbQwb/v4/U5Bixx/+8j4RtqKFo89DVzA5iNqrRWaOvMdcqCFYI7L?=
 =?us-ascii?Q?2v9GhsxsBYsWBIk0UhQUh1B/99dQchRa/IDCtwCO75aARi98DFvwJEn0zaay?=
 =?us-ascii?Q?rePPcEHqFaC68L+JwoPm0T/zaW0Z+H3aLsq4qip2zjnM7CDEylpTyv3AjAqx?=
 =?us-ascii?Q?ocstxqND4J6pyLekhTz2QeXPEWoKjqAaplAP3MzI+IhDFjRpguetaPdes6B8?=
 =?us-ascii?Q?YADFSpuZRh8Tqu2d32C+SCksI5h9XkZTR32YVp8wrKnxMzsCTrE7wRTEWfAG?=
 =?us-ascii?Q?dgxwYRv23u1X7LM4XuFPtuBOKfKhcoFIxdi+raoIRHc/t3CQUTyF5w32NjED?=
 =?us-ascii?Q?BIm/YTqJJKAz1XyalKbDi6vUQNRmDYKePlF0wVugNuWphhOgZ6oz0It5/Rfk?=
 =?us-ascii?Q?Lx8allEqZXwnH3FveyIuC5rSj6q7/M32VXnna064s13AxRO1y4BmKT9lEplA?=
 =?us-ascii?Q?CGVe0ryCQsbiy9oQ7vWm7/RDe+3cu6W0j/rEUdWKd6Drt/eBq4ms//fxBi1l?=
 =?us-ascii?Q?v49B5kTtnUO0FoUUg9udqoTwcaxIVICEq4Z8fHccRHDd/kmN8QWobkK8EOQk?=
 =?us-ascii?Q?q3504JcvQAuSwub13gPLyUuklmg7/y11uTCnrLMHkuNyJbvrG1qaPZUnkuD5?=
 =?us-ascii?Q?iVGFalSq0fwEHtfUrWkjgUdtuO5i5tvwHrB7yvAXfr9jJZFfii+m5UJ2Q2hw?=
 =?us-ascii?Q?XXHoZJ2Mf9FAHIDlBoRmA68laG6l4WgOxVQPdXYAWyufvOWPb37aGxTBEzWl?=
 =?us-ascii?Q?iiqNNYlm7pyGBHOh8BpaO22/uOrvP4kF66aR2P/9Z9wY?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbdd500-02f2-4bb7-e2a2-08dcc6171e2d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8150.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:36:17.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfpZi6S+EfDOEIz2DaQ7inkcg7RZqbXOhyHjeSWYeD49gp7Zf+RDzOD1VmonQc4UoL9HI4N+ha9CrJOER2v9eM3AGDGKTvXg/xQZZvie9EF4xAjlVxuDHXYpVnHpRsn4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8410

Changes in V2:
  - Updated mailing list distribution

Add map_pgoff parameter to python dictionary so it can be seen by the
python script, arm-cs-trace-disasm.py. map_pgoff is forced to zero in
the dictionary if file type is MAPPING_TYPE__IDENTITY. Otherwise, the
map_pgoff value is directly added to the dictionary.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 .../util/scripting-engines/trace-event-python.c     | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index fb00f3ad6815..8a056c3574ec 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -798,7 +798,8 @@ static int set_regs_in_dict(PyObject *dict,
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			    const char *dso_field, const char *dso_bid_field,
 			    const char *dso_map_start, const char *dso_map_end,
-			    const char *sym_field, const char *symoff_field)
+			    const char *sym_field, const char *symoff_field,
+			    const char *map_pgoff)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
@@ -814,6 +815,12 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			PyLong_FromUnsignedLong(map__start(al->map)));
 		pydict_set_item_string_decref(dict, dso_map_end,
 			PyLong_FromUnsignedLong(map__end(al->map)));
+		if (al->map->mapping_type == MAPPING_TYPE__DSO)
+			pydict_set_item_string_decref(dict, map_pgoff,
+				PyLong_FromUnsignedLongLong(al->map->pgoff));
+		else
+			pydict_set_item_string_decref(dict, map_pgoff,
+				PyLong_FromUnsignedLongLong(0));
 	}
 	if (al->sym) {
 		pydict_set_item_string_decref(dict, sym_field,
@@ -898,7 +905,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	pydict_set_item_string_decref(dict, "comm",
 			_PyUnicode_FromString(thread__comm_str(al->thread)));
 	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
-			"symbol", "symoff");
+			"symbol", "symoff", "map_pgoff")
 
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
@@ -923,7 +930,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyBool_FromLong(1));
 		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
 				"addr_dso_map_start", "addr_dso_map_end",
-				"addr_symbol", "addr_symoff");
+				"addr_symbol", "addr_symoff", "map_pgoff");
 	}
 
 	if (sample->flags)
-- 
2.25.1


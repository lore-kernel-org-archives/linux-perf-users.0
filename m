Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012063.outbound.protection.outlook.com [52.101.126.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BD1F948;
	Tue,  5 Aug 2025 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754362217; cv=fail; b=jCkYYimVfxOyUHnJi9jY3bCY4EQ3klDLiaVSVopmRFv0sBakmLm1nNpF148Q4fhlCyWL+aYULqJqUDsSCMDALzhUgVqZM967cbXsTnhq4pHkjr4YJesfamOKtvGUnG45+iZaHmtRvqUi6MME6OFQzDKyN80hn/UE3GdNASPh7Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754362217; c=relaxed/simple;
	bh=by0vm03SNAg/TWt6wP1aP8zkA620MSYbzCLb1aESZBI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ehUZ6oOjFEgglgl9ymqG2tGM8PM8wRiP97ll1ZPm3dgIRHPjHRYnuYjbfE8BUoFgT6tUA7unjneizXrEwEA1mfyVyAKdfVH0d56So+L5y2qMCw2w68OXyAFHv4aSj9msA0mTUGOls4tv99yXmIHwXIbMI1keIji1BknL2a/yfSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=q2LSSGHi; arc=fail smtp.client-ip=52.101.126.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="q2LSSGHi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe5fbD5w09DGbJQlJI0q21k4ZMlfUIPA9SzE8llYl6vxu0UCVqmw4iA/ORvtP1qKDJA9Sq+pxp7SaIahaOgkpBs9PTdgDW5rIbeBE3XbedU1hbAbiesnHDVVUxdlnt4JiRKsLSERyaJ8H0eExmYZ3808p2zs7zZWtbmY3eiv7bDZl5Tr99ZB1pMTSmKnf8+WRXlVJXE8KdMBZZbgar2NC5ag0AgOJkbwk6qS4E/ndfoYIsNpmovqzcTRf8DwO577naMwVttwIcXq70s/Hv3gs33sIwlaiI/fU5qLmEremxociQFaVjppWhCQEreA4OR8WvbMzEoOZ5fkOwiyt0YXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyODzpwGrlNlzAicTrUmSvO2+dCaMH9e4iFCa4JnlO4=;
 b=f0d/oqqJ5qGLeIayEhwF85DusTkbunHeeDJAuzpqwK4fAOOzxP5sZYuKnIlRBX1kf9XZJBkTmZjOzl4XDGGXGqL5Mm5SSCaDYezT9dQ4w2jq9yhdmWGAe/rxBaGTSlO090PEnKhXigwOlriqNrW8CuWko7HgzuuESJ0IKD2kukbP72TXHCcRpucItd3pfjIb7Jz/DlbdNPubYat1dvbjShYUZml6I87DnTbvpVVzyA2eE898JS660pff3QOcx9fwkVTXBy/7vj7bABJkGOJwpuxEDj7xyzA3trWxh7YJhiLO/02O2U8orPATnF2APJlXJgYvvNGmQnPEXRF5QdrZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyODzpwGrlNlzAicTrUmSvO2+dCaMH9e4iFCa4JnlO4=;
 b=q2LSSGHi0bcdpFgrrtTZKAd3njxvb6hUXbW0B0eYlOtxlLYcdhvrKMvmJmDHeE16CdBIlzB2vBn8MB9BJIKx/vDcB471yiMdkSZFCcR3H7HKmOpF4u9pmTTiwiVBDbhCadJMi6lSJpdgFrrvDyHh33q9SQX5blvn0PC6e6pjZTGxARSyggJux5NJkYuszXq2fLS1HQMgGjNfSD6xEZFqNZNrzpbwT5Q1dIWuJt3FUogUFtdOHWIuqZ8Yl/lmfUMZa6xSRDG7MhXhxalw6/LCBf2jUgKxEQn8q77PDR8yk2sxGnjWfLGt8fzdfBMAOhmHVQ9LyBQ5gghWIp35egQ2yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY1PPF94D6C05EF.apcprd06.prod.outlook.com (2603:1096:408::91e) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Tue, 5 Aug 2025 02:50:11 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 02:50:11 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] uprobes: Remove redundant __GFP_NOWARN
Date: Tue,  5 Aug 2025 10:50:00 +0800
Message-Id: <20250805025000.346647-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::12) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY1PPF94D6C05EF:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bd8cc8-5ef9-42cc-766a-08ddd3cacbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TG47vbZXQvdGnkxjLWVP+UM0tts2+yo6qEbCgrvNbkvaxpGNclV+6BUjSvjM?=
 =?us-ascii?Q?uqdWgN3CINQXKPGnnDqWrtxveB9tvRxGmwbTpQraz3FD/AdbeSS+G1aJJCj/?=
 =?us-ascii?Q?XnbZTVBywGTzr20EyA6ONFeh8Dd5jJBAkb0Xde4trgM+iP7AZ7BFmo5p1sfY?=
 =?us-ascii?Q?j1VGljiVvq62kLpzkPhXSWJQ4/XpSaNUz2+qZlIVKuTYrjiIo0BxJLllnm9j?=
 =?us-ascii?Q?GXVlNzExB7LqCH7HTvUoN2+rE4Yfzkewb6axHjCUZXh8x0tP1oQdQkUuklAc?=
 =?us-ascii?Q?74us4Ma+HGBAdKewfDP3Y5YSxVeu0wAWlBEX8rzNNyUIgcok4l7AeWyZjMdK?=
 =?us-ascii?Q?ggkmhMdL9AUg6KkEo2rV/OLONqVTDKAUrsSzTuSNiwYobjKynYBeRwgWqvsD?=
 =?us-ascii?Q?eekfLI94MkaV7bPPFTJ+1q7HZ9+idS8X6IHv3fiiqjdgWNcKzpNSP8mnAz73?=
 =?us-ascii?Q?oaYV7VWU4tObv7udd3SVT8EMjKFq0NVJ35T2gtORo26oCQJpypGCqRoXs3LD?=
 =?us-ascii?Q?YJRY0I/gkHWD/SUyd+Ulhr2clD+83eliW13DfcS06igsn7ypRYvXPz1YVHVa?=
 =?us-ascii?Q?FcTglFaSSgXlRrTkaaoOxCZvO4JbJ4y80gx9Of5XyDWjhlw6CxMBmxKCYAIr?=
 =?us-ascii?Q?sb4ZwpBhMFDEmnZkuOObcPtmlAjlwhCdc8bkqVmfj571IL2/8y86kExpMxEF?=
 =?us-ascii?Q?436VnKta0kT67fvBKFbUDJMgfZvOWWr2gJWLVRQMaR9RHKW8uupJ0+ZHVtCT?=
 =?us-ascii?Q?iF5yyr6AXQJmqxBLFXH428o/V9oFbrkFmvIrFQAQFyqNtMvFIh+/HlUOq1SS?=
 =?us-ascii?Q?VeqcK61j5BymAszbyb4jOzhdvcfNmiZJ+8EMjVaUgzHCdOyzolzl/HUsUcjx?=
 =?us-ascii?Q?qeF6yJittte9elHJxGK0U7JRictFeGj7ZYFpMK+Nk/bOMbzh/zDRPeBtzBMe?=
 =?us-ascii?Q?hDwwxXJ3PdsZ++MUHFf/Aso4swXs1zlmfUGJb7pjDRWA0/FwYMTVIr7zB+kW?=
 =?us-ascii?Q?xqZvdSKP/rZuVrMgMU3O16sDngPQafeuErFuvc03zicqJ3tq7PDxc0lMzMq/?=
 =?us-ascii?Q?KbRYNcpMpHvoGRyS9C366I2rUx9pVmvWFXyPnK3XRIjFsSCsfgZnYnjMU5pe?=
 =?us-ascii?Q?tCrUZ1wgfcGwIKoBCTDbnwqdwEevrbWeYebfFFGFzxp6sCgHZsEyCZItSvht?=
 =?us-ascii?Q?igXTajFKG6TbVvd6DxsKzIIMX2hA4cvxXpazUB8770QXh1u3O8PO/tV8DMkJ?=
 =?us-ascii?Q?HFrQk2jDVl+3i4vrKS7j50Ftp4ofHhxl1p77V+AzulGtnI/AfLvdP2PovuR6?=
 =?us-ascii?Q?njBYy2lpBJEpiuPv7WcjfSWj5iaEMcRtVnyTVrXhQGlxW60zfSJBm5VcjLC7?=
 =?us-ascii?Q?SiY8ivshUBjN4A9J32CIS5K5Tm3F9IAHCj+vfqnzZ/h9lUXrwKK7dNNkO+zZ?=
 =?us-ascii?Q?VfPYtJtk9QBU03q7MD4h8AxcWN4wUugespwPvmWKUMzCK/9Q/VhEAyxyMOC7?=
 =?us-ascii?Q?N8cA23qS7zikQ1Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TqhI5c/Q0B/FKH8DWxojne6ksc6hkEFnViKHziTf9+fmYpveBs1iyEg4Nfm0?=
 =?us-ascii?Q?qsyM9QsJKA1syL+nD0Mq4Y6NSwn8/MM8h6FU2/Wmwtlj2Fynq8mHvvKROjuy?=
 =?us-ascii?Q?B9HgxOL3XFPaP0xEzxzrHLzEHyFn6RtOGRsJ7T3jr6lr78eQXKmJR6HR4j37?=
 =?us-ascii?Q?AEWz4MCbjbuZJ4bJ3iG+3pNAkC7Dtio5vieqIlUMr5QCq+jDPF2H1HWTASfR?=
 =?us-ascii?Q?93I+ATD7oXG3JAAun4m9KMQ50ZWj+Ryeud867p5WVMcRBs+TlgK4oclYVIku?=
 =?us-ascii?Q?fg11B4SoHKTD3Akjg6Go96dXO7go/J/MFOHnbGBHlMO5kXsHXPCuy9ibUf6B?=
 =?us-ascii?Q?FEuGyfLv22pVRvHB1nkFqKlcyGu1CMQVKHs1rL1Yzl+CdBZ6o17StEk/Jv5u?=
 =?us-ascii?Q?a7g/oboTLQ/hYckvIgZ2MzjTu0KI4p2Kt6yrI2Y4spEE/Ils61w5psOVcXEp?=
 =?us-ascii?Q?zNLGpHd80IhumiHN7cpiz+qhFPOqEB8iKDUyPbuUnDQhHXSWLErkWx29Zetl?=
 =?us-ascii?Q?iY8oH8hmM4ekcrJBv62LIq3fVjaPsZvZ7hdfB2Qe4jAWI2swzF8XtKHS/SPZ?=
 =?us-ascii?Q?DBRoZfuIY16BNgM3YpsHPNceJpQmow69RFgs0S/XRzIimfzqhkgeMYr3MT6E?=
 =?us-ascii?Q?Z+QO0JH1I1Q+Tu4FOSYdAnS/nQhVV/leiUHgOI1zJ1CMStra3kNfJFYwRYq3?=
 =?us-ascii?Q?2vUZSfxI0V5sJM2+IdFqhULH8UPU1acPg1Aa0VRd0trNn8epseEssIceJsmj?=
 =?us-ascii?Q?h7OyYOk121KB3VRUlPHPfmP561nVazSJWJqkVArWRT7PQbTewToStBz/mA5U?=
 =?us-ascii?Q?USSYcnnBZF4L2Xhv/2GGQjKC8tyN7PLqya8ad/6bCZWr1lntqvLr8Ocf+838?=
 =?us-ascii?Q?be6ac4/ikH3OE1VqdQn2nVYtrK4uMAaOWWfqeSeC76xoOotHsG2FrgGwt8a8?=
 =?us-ascii?Q?EfCqC7ru5ddBQ9gpnuQAnmR4g0EIa/vMw9nxSg8HSdEkqZUVF18CUGL/bASa?=
 =?us-ascii?Q?QapDbNfeC0nyO4x0xdMS/vX7h8KFArxsCkfoQKQ8CcZbB6JvyEO94LaPRzR2?=
 =?us-ascii?Q?odZ5hydU353ZRGikzW0G/sOvH2oLvqtzDGJI1Oa6dtrCbAE4CVtktH77Ca9Q?=
 =?us-ascii?Q?FSDHgS27k73KXFS/aBD7pcMNosv+0U+xVfN1wJgL+ZR57QGQTsSi39ydXchg?=
 =?us-ascii?Q?MzShgLKcyF1g6RPy/nSfnH0ZmNGqgNkuULqCWDblfyT+/fcXLwt0c+s4Ty4R?=
 =?us-ascii?Q?qbkNEsBFQwf6lpghIFKXKnSEyWLzlYpE+ZQo7qYHDtke7vVvV2yuXYR82hhi?=
 =?us-ascii?Q?SsjAQvqP3nbnfFf4iDqAxTVxL48OtGYRDxAu8eVvYKbx7IX9io2E2NCZM8Oj?=
 =?us-ascii?Q?q+slIEM46KM8f5nGjQ1Q4cnLmazfmDJVo4ZUEGSr4Op7PZz4DU+HhC+scryg?=
 =?us-ascii?Q?plBH7L7eAJifipGOW30nK7hq6sIroWVrwbFmfAAuOqxjcFuoG96ySrV5VomC?=
 =?us-ascii?Q?5RTmK19m47gSycf9Eoj09qUu3N1xxX9o9zsRd+SYg3hYMAZjQn7AL0pztVc7?=
 =?us-ascii?Q?68azW9lnOzKY3qR/Tshgx0SBsZqIWq6GsmsdlL5W?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bd8cc8-5ef9-42cc-766a-08ddd3cacbb4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:50:11.3502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/iXvSkvk3Sp0EnYotvhJm2vnLDiT1q6sIrjp67TNGZmvhnsROTLU924zTXnX8yXNCZ9iM5SlSSMMZzVGKxEOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF94D6C05EF

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7ca1940607bd..5d12b9fdc917 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1210,7 +1210,7 @@ build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
 			 * reclaim. This is optimistic, no harm done if it fails.
 			 */
 			prev = kmalloc(sizeof(struct map_info),
-					GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
+					GFP_NOWAIT | __GFP_NOMEMALLOC);
 			if (prev)
 				prev->next = NULL;
 		}
-- 
2.34.1


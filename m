Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022092.outbound.protection.outlook.com [52.101.43.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08414A4DB
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821803; cv=fail; b=QVHFf4Ty5aa1ItOSoD0+YueZ7C1GSKOP+CWNHn7nVmDQKiC2TtGaoEiU4I7kbUXpKOPBIgH3py78qRfAFjmhGGeszgRBQN1eH8v8M7CCdxX+iNuWEkEainQ5XCEOaJ0GjHtUyqCuQkZtcltyh8tWPolOfgTZr/P86n/43mdGWRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821803; c=relaxed/simple;
	bh=IVqjxL8NYITgvXYgWBtDVBIBvFjnwicjoG9hlW4dJso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6mf1nzBLpPKaZqfbYuyf/yfwreHjMArTNVRKD1qMc6jO4BgvkK0Nd9iW7PaBmg4mwN9cYRBjrBS5VY2+zY1Jhn+Ev5kCOqe5hn5K79gNRZT9sF7fn0/Oas377mn2GTxqnhtGPJsrQ5fpJeQbFn7ALVkkXffSQKXF1udCYT50v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Z5tM5qhe; arc=fail smtp.client-ip=52.101.43.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Z5tM5qhe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZVixYgy4ni7jTu3f34pahQB+J41WNJ7ZyCFQcRZqBS6zkizn2oLuKEqKKbUpbv/zjPl2L7UCVpkquEJbQ90jPm8BYypLlC7G5DfI86z+er2uqSk36dlhej49OJUnocAGMioDEVvFPJ37JIH1D8efv2gaJIOLY6CII1dDCk51GODZoIpKxOEBHhtn4OCQqbFbcekFrEMG7VHX9eY1JnHMWw1uEWDU6g7/lqyH/KiwLz931y4JxC2skuaW07MWxwP8ukl8jfkCW4YrbCXMOF1gWCiAr5oi7/8/FBYvmcoOsGBsp5B70dZnlRwrsKid7lMa0ditJ+NNwNGZUyoqw+oYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46Lnfa419ba6MwoTBOGTytQvW5UJhrJmfl9dt3uEQ2w=;
 b=rI7sIDfKew24dkgJcx/tirPrzuqTOm7Cts3km/RcmMsVr0LAYQIQLyPvX9OATiQuf0OSWpehuxgY7iFSwu1cT5GUSE9C2+X5NfZBTvuo/Op+y6Iw+Ivj3FeJ7zwNUtUPgMrYHO9orXtVPeUSkITQRNmRw+9R9HirQMg/3uEu6+y3il0uK1EPnRE9JTUXLmYA7zjDsGkEcZdC608Rpa2H+1SKeOf32fGZnfYXOhuqa14/rtQK+Rt38ndKQjW7mUmPlTrVsTGzyfw810ASoroDT5l3vEoQ6LHbCC84UMx0xbi/xIGLn5GNpFZfoXygsPpzkjmJxtX7VJuH44pcFTajQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46Lnfa419ba6MwoTBOGTytQvW5UJhrJmfl9dt3uEQ2w=;
 b=Z5tM5qheGDW4oxY/ya+kbDTNXDeUowhSjLzkTfyAlwtPins/va88bOCyTERdo3vfr4fC1xL+yObXdt/t9kQtlPXj3f2m7kVd0aGhmOrHMzB8a5dXXk0SVR9pZv+KWrQ9v4UyRhX93Myg4WPerqFlJHp95b+4ILUTkH0rpCZP7Co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA0PR01MB6506.prod.exchangelabs.com (2603:10b6:806:eb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 05:09:59 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 05:09:59 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 2/4] Force MAPPING_TYPE__IDENTIY for PIE
Date: Tue, 27 Aug 2024 23:09:38 -0600
Message-Id: <05faf8cf48948cdadcf3757eb5fc0305497805c6.1724820993.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::27) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SA0PR01MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d52a60-60f0-4f9b-ed7e-08dcc71faa39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?32cfeAvvELdRukimp22DSPBN7TsanSeZZvEIEFI1K5e7UgWsWJ62DYDszgUJ?=
 =?us-ascii?Q?dWAgu7FdtD2F1S3CGo3BoOHn0VKn4EIdvkyBRDrCLW3ZIczthFimPvw/y3Zv?=
 =?us-ascii?Q?tQKOX0ciB+cX/bjl95ckzTLvhspMgYrLFGM+VgTfy3T+wvMni1mbEK+sDc5h?=
 =?us-ascii?Q?LYOrj61DNV7s5VC2r5QPURp9cyZi8ZW1rrYsVEe4Js3pBKBWnTphNDDhVyUW?=
 =?us-ascii?Q?IHFp05OVbBnRkGsLEq58jqBfO4s/GtdzYuuZdwpWVO2byUHnvimIH+l3GUYK?=
 =?us-ascii?Q?Q7+ZVbDEuMZKs4Epz6xGJPXNwJ5R/zLrHrePiIkv2KiIXx/5xdRiZh0XMq1I?=
 =?us-ascii?Q?Pen2no/pqk25YyR8Q2TR3nLg7jmJHCSdemiq8jnd1MuDQdlzJumUL0J3pPF5?=
 =?us-ascii?Q?02OEjEPq7yZDDwpmyO7aKW2XsH1gxaPQN6s17GyGCG+ZyNZss5WJ0qbOjkAG?=
 =?us-ascii?Q?QuyLuLdOTWNOhFpqhDlbI6nt1zj9u4qj7sZTwgMT4CZARycvFM8ZE0KgJs44?=
 =?us-ascii?Q?E0hOC2ggZl09jkUbAkGi1JJLXU/szdRu73QSTZr+gda5RF49Etu22gm5ItVw?=
 =?us-ascii?Q?f8tiuzfKCBkI9WsSmv4V/R5BRgd0HPbsipxBSDOhDJTA/qQUxi1aSb45KROK?=
 =?us-ascii?Q?BmBoRT0fs1STYYKPKPz5x0ZDexfnymfJ7DARvMmsAtxXWR8qulm1YPm5n7Uh?=
 =?us-ascii?Q?idAMzrJMwRpFSiGaSvABbj/jOdpBDcvbq3o6575k+MFu2gremJ/mF/KkuA1W?=
 =?us-ascii?Q?VQK/DltJNj0SsRVvrz8Amf36TQ8R7EP0IjcdLYlTnJ1InvKwmALbwzbaXFGy?=
 =?us-ascii?Q?1J9tkcqEych1hGiA2CpjuxLIvjFS4R1RgNGJBF0rxWS6IJys1lt7TAaWBr8V?=
 =?us-ascii?Q?B8NprhOVcnWn2VkoBI2cvpan4nwBw/A6GrIxCwSfrpwn66pGcVeCN8KSXQDN?=
 =?us-ascii?Q?3ccKj2QZjLq35agG5wbetlbLmRe8mLAH12zR1D9s2pVjb5yszt938WaundJ6?=
 =?us-ascii?Q?sNyCy35c0uPmnoI4Vvc52yVpll1Z8jY02RzM7ek8kPj3UoKEjoV2fsixPHL5?=
 =?us-ascii?Q?501rrpXKzOnsIN+FbzXwWyhYS60v0fC18nKvTDiINOW+GJmmRbpZOhwkAMBF?=
 =?us-ascii?Q?dkZqYnue2qQ4GHgf9o5ur9Am+5lncbLkXRWs2EpjeSmSae6j8Hg6PZboQgcC?=
 =?us-ascii?Q?e5n5gAp43YV+Fjeoboj8PULVUMSkN5n/Cn1GUZmRw06DdaRKurkUrQrWRzMr?=
 =?us-ascii?Q?1d1q4RRdEyxlFJ7Xunt6iNkIcz4TyXnIACSwL1wXpC9xmeg4GI8QBOV1ob5y?=
 =?us-ascii?Q?EWylV5c5WTcRvtpuIMBTrrOKZaR5yZgpkQ3iZMNhDhbVZiTgFq9NLFFaHXXG?=
 =?us-ascii?Q?SYhv1KS6D8bAB6tJUYa6A8FepXqVnLMnpyggiUM2v2oKpXTKpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nv+oAd8PZlhx5dbNX7fpz2CUd+kFu3pb5CWFh5HCrllwk+na0XycGeFl4kJv?=
 =?us-ascii?Q?XtbE63XZL0vTaBBLcQZ3SbOY4hUwAUj9xzW6HpXkXro/+Y6FrYhoC28jYPea?=
 =?us-ascii?Q?5tq1P3cy+990Lj47YrZAj2zfbJzui1j6AFi//ppB5vMxa2K8iV+0ZDkFM7rB?=
 =?us-ascii?Q?ztAzcAeDwmGmpY6TzTBCr1SxuqFv9i9U2qPABcZoq7HMaKzxuzTZdm2JHrCj?=
 =?us-ascii?Q?M4zj1HokgqxbewBr35QFuLWRREMKfp8JCEZz7tUzQ78Y1tdi2Zz4s3DN71zc?=
 =?us-ascii?Q?aHvBk6P6Db4V2CuMu8dkB//qbSRO6nPntLcp4WfENXFJbKdssaDrRv3czkch?=
 =?us-ascii?Q?dYE3uLKdLsVirdc2zXE4LfVOslbW27tlBA8Abcz8ZB1cyvoZyJc5rmnQJk0w?=
 =?us-ascii?Q?Zst4+SZ68CgQsXnofb4gmjZcCw8TcLzYkwmiq9wVO62ox033gofb+7sEUitV?=
 =?us-ascii?Q?TFnp7tW5fHGNJ494+K7h1bEp2/GH5AiQCtN3SjUw9Jk0G92KEGYMY2xovJ1d?=
 =?us-ascii?Q?XmyRuZgay4yvhpWcRYnGIi5GV7T43dmiqkXi/049404zt90EWm1NdXC6z/nm?=
 =?us-ascii?Q?vF/aEBn0fBhKzoZbn3hVkgs2sB3BeuoeBOuInO0aa3ahHDUAU1DcSQTU+fWY?=
 =?us-ascii?Q?kU7JXzR1ixtrjYer+ohyO8i7/4OvMGxOwOQ6nOUtZwR/c4lADyv/vjXNJUs9?=
 =?us-ascii?Q?KuJxhBgFw9qIlp8lRs4EschAHM+yms9bLK+BRtNWP3ukEO8Fk9geTAxZp47O?=
 =?us-ascii?Q?Id1ZbYrIIv64D7ssK9xJbPKadCEYbxroEnG0ghj5WURJfqVqpAADso9qr5dv?=
 =?us-ascii?Q?3zB1rrJETS8tZdmP3aQZJOAht10TtT27TFu5xu8a9U3j2imL+splMwRjltP8?=
 =?us-ascii?Q?jCc+71nstf55Usrn84Zik6sW1/LIUREGe78mjGB2ttAaZckzwNptGSSIvPBt?=
 =?us-ascii?Q?Wi07OqFoevXhbJjO5cx3F4NrERTerjJL4VoTCisD2KnQNljepeaMkRTIEsi3?=
 =?us-ascii?Q?66e2a74rHViRuVYCielOalvx2lzeGNaxAcw8czR+dkAZg3U1DqAebRoDXDoC?=
 =?us-ascii?Q?R1paNe2Udbytfhkn4p9QqKMqADk+Zo4cnFKO4DsB7dvBqdNwNdwO4ZKFwa9+?=
 =?us-ascii?Q?JRimqrf7LmbSG13o5Zc6qZOki6e3HPQZ/Eg1aCZ+5BUVwGCjMDNhRFNyBPLs?=
 =?us-ascii?Q?OE6N84itG76XHVJ3mVjCDiwhpBYHnOytn6vyYP/IiN7QVaPrWEoOG81XVGQ1?=
 =?us-ascii?Q?rCqUWUQHEfMeGLt/xZeOP9q7NC6QGT3fXTNlFRPopybao66UzCV1S87pgEC/?=
 =?us-ascii?Q?UZPjhijeog2pP0QWfYyqup7cLXnbzarjO+AR1HQl7446NNFqAMwzvnOxdsk7?=
 =?us-ascii?Q?/xPyXOBzjLKvmdMsQ0rESIyvNaHF88kDEGquKymLiM0dl17V4HU9WJRHqrn4?=
 =?us-ascii?Q?tyM9FBdGPYfnjIqdNyYOuTJlp6Y12E7H+ZFwyuqAIFYFRovWpeeT/68/vsYD?=
 =?us-ascii?Q?3d4cdjta2awyDb7Lt4jgKUvD9UN8YMIsEYQ7M3BiU5gu0mufK5FwbI6zl8cy?=
 =?us-ascii?Q?mzCYg4fMEIkQ4QclDJdJB55u5HnRYDK/ty6RwuwKk26YLygslwPjGEuaUsnI?=
 =?us-ascii?Q?oUY0z4BQmG50Zt4ThxHhzETF5UslmTDMjzR9EKTkzg7F?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d52a60-60f0-4f9b-ed7e-08dcc71faa39
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:09:59.5331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4CeqSmz06gc0NO0uHkOfiCyJYb3wmLzInJwQIBngtKb6ON/qdhn4/2hEq9sJ85EQDDR9eC/Y/Wf1QRrIw09/OWHrf5dZm4f7gy+VDzFmsdOUWatMxJbzW6RkVu486Zn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6506

Use dso__is_pie() to check whether the DSO file is a Position
Independent Executable (PIE). If PIE, change the MAPPING_TYPE to
MAPPING_TYPE__IDENTITY so a zero map pgoff (text offset) is passed
into the script.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 tools/perf/util/map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e781c8d56a9a..c846faec177b 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -173,8 +173,8 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		assert(!dso__kernel(dso));
 		map__init(result, start, start + len, pgoff, dso, prot, flags);
 
-		if (anon || no_dso) {
-			map->mapping_type = MAPPING_TYPE__IDENTITY;
+		if (anon || no_dso || dso__is_pie(dso)) {
+			map__set_mapping_type(map, MAPPING_TYPE__IDENTITY);
 
 			/*
 			 * Set memory without DSO as loaded. All map__find_*
-- 
2.25.1


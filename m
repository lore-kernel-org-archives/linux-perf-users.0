Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B601103
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495140; cv=fail; b=o9JptzexxBHfCY3X93XNy4JXOWYWhyJOsmaMxiJ1EjqLEV2d1P9dq4soAa6U+uUZbfnVYQFKemgoasDH5a+pPQ2Cqie6cC8NmV+DNJ42fWNUKOT61uUJcvZCH5aVVHey1b0suo1M781B0rXlVBPbdo6OCdR4K2arp2i3XlrEniw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495140; c=relaxed/simple;
	bh=Wm6fY8wTUvEk3F1Ok1pcZgU1x0Ts3RtUnnAP7gYdzRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBn2SI+ZYVZoLEtlg3yY9D6NwfpfVHjmQHTa25B7duero/E+bpHaY29aeYRI/1RkgN6RXVVzdtkGs4lawqDhU67wlGBXm8nKaBKEUZZLvRCBXPvpvPhgYphtp4XESbe7L3Rurn2VjVehwBjlrSUURFe81DE4GZZ7VXCA2Fcv0w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=T7zrAxYp; arc=fail smtp.client-ip=52.101.62.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="T7zrAxYp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X28sH2sNA69e3fHf6nEiz1cTlKqt6z+Qt36yUVOnSr1Dh+qnzLrhySCt02fJyG7rYNA+J1ipKTF6KwCBDKK64bwNQSV3TJL1o17q3tnqsxga+8ohcfFFsQ0iLZmdLpYjx78F05TjibJ+Y0bmi4qv+gotE1eSvBHlnPkamEDoipj2PAag6ipq1LVou0YKgk5QInZSTD8BGtwxjCEASKEBjQ8r2yE/KX5/qw6nFy+pLyn6jli2c91jE/P+PkpqnpPt0mbTYxgg/yMDr8ygWVJ8RblMhN5QvTjRTs35ffUv48+qyHwEPamGNqKTPm7ddj06r6pdRekDz8ZMYuYd3+Iecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiE8twlbfqyo2soIykexS6EUqxRW3kdCuY5H08Ox//w=;
 b=xQmBNdtpc5oKR3Q/+AO9hnkDXG3YwnbfMprHBuwRPRJQi/12+Os0jazJBb9JFWMqdqrPoODmXulXuaM7Yn0TGShb6O6EHbdaDdxoPMu8ZDV8HHnGF9g3XKpab+NkOBYJoZbJGTnqvYEDr9drmTUaiKp7v+iy2OWGlZEYhrg9XTzA5Qdo5aX8kf8V2s+kzmWKrQZ99zW4d05U5LjXRj/Hv6kHHiliJFkPbpW7KFq8Q0HJjF0A6gq9YHAlpP9a6FxUY/wdV0atPAcDjHzJzN7erhOULN7bxiwd+xb+QWrBauDG0vWXfTKzi7KtPK/UdUK+07pyHiIoi6DbaazBt+1Zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiE8twlbfqyo2soIykexS6EUqxRW3kdCuY5H08Ox//w=;
 b=T7zrAxYp0K7cku5xsnUygSgAmo+9A0Drmewj47MgaccSb/M/ZNfLGV7xNV1dNMmUQCz2eF6FlQxIjHUjgFHdfVK+Pekw+YeWKiV1RmFvcRBc2FR2rOt0+pyT4WUqzk4ghsKtpGtGsNWIY2IxtvgDT9oggztz7Yk0Ar2Rpipt5co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 MW6PR01MB8365.prod.exchangelabs.com (2603:10b6:303:248::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Thu, 5 Sep 2024 00:12:14 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 00:12:12 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V6 2/4] Force MAPPING_TYPE__IDENTIY for PIE
Date: Wed,  4 Sep 2024 18:11:31 -0600
Message-Id: <47f46f008dad63a8685345fabc2701d50c7b47c3.1725493961.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
References: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:610:5b::24) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|MW6PR01MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: e149bed8-4879-4430-b586-08dccd3f63ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qbjio4qo6dTeqA968uKauh+t1RMwvX89zdK9UsuFy5zna6GZvT7NMfO9HsQF?=
 =?us-ascii?Q?7/o07CyHM+n3nkzHExyeT5VBbz0ntEApJewZy3LkDb6D1QCLB4eGzmsToBQe?=
 =?us-ascii?Q?p8kMqRWJI04FD2eMEfMf2svTGkdVOYcMh2VDMe3g8ihv4IV4R2GmXGLTOQQi?=
 =?us-ascii?Q?8dFeuviqRLEMp35pfVFCtp0IoKvlfHyWTVl9PCqqzaqt60/oftvCKbKlWlOV?=
 =?us-ascii?Q?Tvk5j30eHYsyxdw9eBYNSLri+9iX9hNsvjrP86o9/xdqH/Akvu5dboHc7vbk?=
 =?us-ascii?Q?fKco5lciLqjhUjwF1/ExZ5D0mZmXl8Nr0jaxS+AcoI6WJJtS/qemewgk0qbZ?=
 =?us-ascii?Q?E1iiu9d3BUz/ZYLjx/Reni3c1uzEWFBQYAZ6PhjiWoP2qw0XiZY7WIS9029D?=
 =?us-ascii?Q?betX9s0MEOVbIMWRR7207Vq5vN0rIq1BYGQBwxb3cNJPa7eKeViXb/D2aLk9?=
 =?us-ascii?Q?FYJRoxtU1UtoUVXkaKaztr4ZbequLFiyDVz5Q8eBCGBlW9KSNbC1vE6zvJ2q?=
 =?us-ascii?Q?RoUfBb6qr+KOMnAcMNLsVXztEvuxbG0tz8Ndu7uGilLuZumC7voocsKpKpdY?=
 =?us-ascii?Q?J9e859S7WlSvaDa6UNmJjl5z4pA5O64NZaXu6bNdeHRDkNYc3pq90SBjMsQg?=
 =?us-ascii?Q?9G0XYA4PDmc/zDuIHcBz61OUVQe5/gxaP/3H1UdYhvo/LDWLYIZGnopO1zsT?=
 =?us-ascii?Q?PcOnWxZ8FGWI7ZHhJin00PTOV1IkMOCSrpYdJexRq82x5zdqxWs/G2Xmc16V?=
 =?us-ascii?Q?tna5ryGG17gGNqCVgdLl2UIgtG01W8ey1h0P7KXjpU0SnWd3GXZxGn5o5XTa?=
 =?us-ascii?Q?YOuMGwEI6pu+/ETwSGnZlqlGdRilgDqeDaxee6aNGvvbE5MPmZimjG/uMSbl?=
 =?us-ascii?Q?pYL8KDOm8JRaGALUs/qNZKIRtnauAAraWMZ5cAi7rB95BGosRcXlUykq/eVY?=
 =?us-ascii?Q?dmzhaqo8K4jplQbciOYEaK9rwSP5q+Yp5y8PrGHvcgdbpfbMPo4lZFI1bzPf?=
 =?us-ascii?Q?7mDuZgAjmxxak82eK+mRwyKvyYyLpgCJJSPlVzYcaunB7TG4fKm5p/4WBT+j?=
 =?us-ascii?Q?h9DM6k1Qp8Yg9mR6ybqqDVBz0j5W/Ayu7EqfodK+Nd0P5sMHSRDUOJJy6mCk?=
 =?us-ascii?Q?xmPltgLAlsXZHMr2uIuYmZc2vuT818StPAav+fs+z7aPpORJsTeN1GRzLKmw?=
 =?us-ascii?Q?9gdmJy6GTKdx4mV5Zj8aIoiyQuLLGQqt4OPAxDzRWbjcxaJyfAv3OHZg305K?=
 =?us-ascii?Q?GksNm55eYCdHLqg8dAraPxU8BBUjPr1b6/V2rrB+/K+MZrsYZmrF0qtkGbuu?=
 =?us-ascii?Q?Ty4l0LOQOWvKfcFWHWPsNMfpe2JxwBd/XcSEWRkXAUvPDp/lWAXXNkUcv2pc?=
 =?us-ascii?Q?VYpuvWlqjOGbiRtpByRv7AvcZNIjnKqBge14AQTM7WQzl3Wd4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?If2X3sOg4qbVagbCP4L6hITaEqCiKvecF/wpoljZON2FFxfb8oerYP40avQL?=
 =?us-ascii?Q?kQPQMP7O2EajZkAVSVRtz4kT43/fRMKnBcv+phkNf3mu/Jw8KTcIirXj9QpS?=
 =?us-ascii?Q?KoT48vqLWBbC7lFix1a8cTzvVZslkKcS9myA8NmRRmJHNTjOBLVZ1MIpUBXA?=
 =?us-ascii?Q?pg0K6/HnvAYmxmWhrqYfFgxzEgxTjsNAI3k2ctlo1pvuaSM2D6Zi9wuJZuKV?=
 =?us-ascii?Q?KZlt3nz3eEjILtmuqSeCRVV9lg3Y8cWfVUesci2bb26hpSdIb0lX6doCrnCP?=
 =?us-ascii?Q?lUja15KES92BnbMGEc06YaBFaIlAQUPJ7POPSYK5HTIuc9X4T0Q4qhAtGGD5?=
 =?us-ascii?Q?d0hjixRpwGzdPsqMlzD75DU9n6suesptrjIbuXvf/dzVBfUuSiJ3WYMYJ3ca?=
 =?us-ascii?Q?25iNSbaVV2fYsk0E1nSdALYwCojBboXPI1gwCueXgZqqaCosEVaVVZox+UVx?=
 =?us-ascii?Q?vUJgxk4GHp9f4LEz7rwzxzWNr4aMUAQ898Y5VRV69+5wNErJl4Ia9wCzbTSg?=
 =?us-ascii?Q?sOaBXkuBB5xUXrG4LNDeiaQSINNGLTUyNxCMN/iuzQpwjuJt04AWGIS9sJDR?=
 =?us-ascii?Q?IyjFEjSkaHuOx/bUzJrSpO5Fu8F4d3CkPL8X8lRgWRoIuacGZAAZxZKtRnYB?=
 =?us-ascii?Q?KxM+Q0fqvt7tRa8Us3D9dxbKf10kW7pbcznWaFRQHCxmpTKcLjl2msXDxZnx?=
 =?us-ascii?Q?k6sWOgiCjUpSVMOTNA5PEwPaJyw8PCiypsq0ZLf4qQ3A/jB4EYKGqF+63IgH?=
 =?us-ascii?Q?KK/qcE4SyizbnZbJ6K1uqWF2MCQ2MfOPPX0id/Z7c9vRgrAWko5SyDDCxFpp?=
 =?us-ascii?Q?MDHMmcfzYqDeAeI2gY25+HvFt2Drl65rJtsZcGcWPsMcpkokjfa7DC7IyiO0?=
 =?us-ascii?Q?rzZiQkrkPvKOEOPmqjzepXNKyBBwrsZEOe8hGq7IfSF19mBd/7QNJGCdaUzd?=
 =?us-ascii?Q?ey4fIRfRKVj4Qdo67iKQY6Ca+Pjd0beLCD2ox+r3JEYMKMOXAn7TUCtyNNxB?=
 =?us-ascii?Q?3ImcKrwQsmPtUFrZxttAxz2yrjn8PropwwLS2a9/bj5LJUeNBrgpXaGcBjK4?=
 =?us-ascii?Q?6ykSNbU6WgVLZsDU2l88dVqCMCVYrCAz92x5ieBKypGrFaNmQO8stuABJfog?=
 =?us-ascii?Q?/eR1Kreu+ZNiWf93DTx5sIltZWpCfNmkCJY4j7Nr2RifEV83uBviYH30W01Q?=
 =?us-ascii?Q?w2L84YJzsyct+P50Fws8aArKbAEx3QaHkg9eHY/F3Bjt81jvCnd+Kla7MUt1?=
 =?us-ascii?Q?zZTr5pBqnBDuuEiWFoYFGw6FI809Mqrh2JGlkBWnigNb0tL5XDydHRvjQuVy?=
 =?us-ascii?Q?ZXu9khOJbqTzUN+W4ypB4PldhylwRJI1hvLbENq4kxeeyd19hgsjSCcR7zXI?=
 =?us-ascii?Q?b2vgSuoENOa1F/pq5tZ7BW7HdUO/41KLgQedP5aAinhBXEOt5JBlDaSN+f7R?=
 =?us-ascii?Q?auiJzpuD/nvbWGLU8fLMnVvbftBxxQb5UQNswZjxGA+GSSw4AmCbi6iXYqKU?=
 =?us-ascii?Q?LoEZ/2BnPU2OIUyIBQCQo0su4KXPb3M5NjpsDLyWe/V08k9VvCeq+awzODIO?=
 =?us-ascii?Q?Awk7sKMsQqByyVWa5DEZMB8p845bZXzPZOYpNa2uFmLAwJId6mn1lpR07J9d?=
 =?us-ascii?Q?cYh0vxZDuNQQ/LFqYzc+c9kZJjyEsROpRvgtOEC585+2?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e149bed8-4879-4430-b586-08dccd3f63ad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 00:12:12.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDLe5yquv8u5D4u0Z+Ir37Nznl2dU1nCwNAOqhMbFLgQn9b3EMu5MyRyQF1Ge3LbXgwwoYeY9KUPvcphgG2wgLlZOqsaeROE4aGnC+fi/fhqNvfwqMgkqYAqyRangCIB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8365

Use dso__is_pie() to check whether the DSO file is a Position
Independent Executable (PIE). If PIE, change the MAPPING_TYPE to
MAPPING_TYPE__IDENTITY so a zero map pgoff (text offset) is passed
into the script.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
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
2.44.0


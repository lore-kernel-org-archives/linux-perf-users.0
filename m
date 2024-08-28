Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020104.outbound.protection.outlook.com [52.101.85.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D14087C
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809841; cv=fail; b=gFr/sEWOkS9s29/rCcngSN083WWRtAh2v1cfgY/1koLppOjxRyHCm6mrISopBgCBxyGHbKq+VKXmevPrrQL+qecfNp7EzuPirUQmaGspL7hiSOBMNOwiEYgWc9Ftns4+4R6VNL2jBPDsHNGdXzyx5r8qfpesw/kZCWYXB0NvXUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809841; c=relaxed/simple;
	bh=IVqjxL8NYITgvXYgWBtDVBIBvFjnwicjoG9hlW4dJso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jIKdq1Io9DzPY7Umz9AYx/rMgoXoonjL2aD928cXMYac76IttVgG2eBIYxqqbS/WraGrRWg+DiNbQ5IF47y/IX6G+3EBSb91Er9CIzOLWyjgmXE/Rx2ulasR7DkE9DwTd2etGWzJekvkKWP4ANtAHOVVV8k+JQWXrhHePypMkM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JNNJAMmJ; arc=fail smtp.client-ip=52.101.85.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JNNJAMmJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULbPfLdxhOHV40Fe5QzjmyNH8i6yr+Hu+UAezKOXCvZNdzgc2olY3nIgh79bvWN9d1Mcpfe1QSi5Yw8eF6WE+DLRnY8+himM+aXfd7uTvljsMYx78nQkS6w+RbM+J2hGkzihl/CXq4jBGqTui5EtolXR1+7VOMUx/Rx4f1mTGB4jv/saCVydXdo8MVZISWh5x4pylV68sGplxIJvLTNRp292fKAwV1zXS5Z0HNZlUGUHDOwn3x3Cb26FFX0NyJA5lkABNCiJgJQEwwIhRhyiM0P+JdsWOTaQ/IzoDqFg221tB7xnz1LNoPC5TJ7uV8H5m1V0DiDyZEdYGYvKzrg5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46Lnfa419ba6MwoTBOGTytQvW5UJhrJmfl9dt3uEQ2w=;
 b=ozEo3c8X0Z8FGJY8m0FAodF911MErVxwE8nSXv5Cj6mxw9UTis1uJaYd3Rly8apCt50LYP4/0VucQgcnNO+Fr+lviJDXByTGKfAXzyFMqlsDjpMJmd0EmJA4lhrvx6mxePn3lINBW8gDdiq9dygxMH/+kSDkcVv8X177rKVb+O6PwWm4bIqQns9AXyOJDh7o5ygrLvvxCU4DZKZ4jOGoMnky6KzMmQ9H5rdQnegWYSdm+Kv5AYbPETQGMle7HBV5N1ddUHjKiT6rioSW1OfRIzKbPbPG+g/AQl8NeNWNL6qalq+I7KhKypnpX12QD0hCv3MCFhrIsrh1cPwSZENSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46Lnfa419ba6MwoTBOGTytQvW5UJhrJmfl9dt3uEQ2w=;
 b=JNNJAMmJ7pPwAnavTcIGMUqDPWqLLSTIAA8POcg/WLS+Ei5+catygwTdyOtbyTmTE4ZxePV13PZNGvKgxAL57UgU6x0k3DP4jrRd6r1uUZo2lM30DLkTEwoBOYc5qyfFmDON+3oU0fy4c8RzQ4QGaM1k6vRVm+zrOND4SVAB2Vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 LV2PR01MB7576.prod.exchangelabs.com (2603:10b6:408:17c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Wed, 28 Aug 2024 01:50:37 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:50:36 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V3 2/4] Force MAPPING_TYPE__IDENTIY for PIE
Date: Tue, 27 Aug 2024 19:50:15 -0600
Message-Id: <85c2c76685f9aa55ada3178af8cd109f3dc7b0b0.1724808513.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724808513.git.scclevenger@os.amperecomputing.com>
References: <cover.1724808513.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|LV2PR01MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0b6f64-e357-4555-39ca-08dcc703cff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?blAmYqPBvFFi/7GFz3AF4epkCU8M8cb2G/kUzD7fvfSklY1vQelp05zm0qlV?=
 =?us-ascii?Q?ewmcPN09X40FKDbuWgIx/1L2XTgduANMwRnWZker/wPBQT0sYxH6jr1dtERE?=
 =?us-ascii?Q?YlfXrFPphzS+FE/Cssvh+295YSvfRAFW8PwP9rHRq/i7FgQQDNCvaBzRf92U?=
 =?us-ascii?Q?63xc9adIXu/GrBiKKaQR0cOtJyhMowX5Zt1CB0kWmEnZWfwVZE2FszbSdbqk?=
 =?us-ascii?Q?XaAEb/OfoW1iQ/22tfopYEtN/TdKsSFWJS62qCUrp49h8lkt4qlI3gglzDEr?=
 =?us-ascii?Q?hUUC4QNu/kC/ySjSMKaAi+fJdnqCHeeRQRtnNXMZJL17PsN3boW6m4ZsRfmU?=
 =?us-ascii?Q?m3QpixzZSnd3G3fKCj5HbvKQ5LvnGQRU2thkcTvV38W7FyQttba58Yc6DbNB?=
 =?us-ascii?Q?vciVEPbopo6rGoYjk/fx97DRm+8DFUQh0DT22Q5TWKyblqJFyhdjaLoT18cT?=
 =?us-ascii?Q?sSndvYIH4+tytyUSDpJIniO1vydy1ZTyUVfp2o5ylLd3/Yi2E5vZNHj4qIuM?=
 =?us-ascii?Q?uKemALpzakbBeCJRMkZS/4qBWW1Sc7IXjMiGwAdSkHC+s9dxEOs8fwLyuIVL?=
 =?us-ascii?Q?EvzI5SbLhF1+V0ZZsiWbN38pBhsq4GRz+E9T25F5fejR2YBMqlUMAR7HsMo8?=
 =?us-ascii?Q?rU9TZAzw0d8Du2Jb0F+NqOVmMoHB0R31qnVHZ8ZhwlqaI5ED+WXTpHWVYaBB?=
 =?us-ascii?Q?Hg6CTYIvZxjbHtCXS+AYy1duDDaX79dd1jaPtpri4svB53Ypw1yIUeBqx3at?=
 =?us-ascii?Q?9rS8Bx1W41G/QSE9TbESmYYrwN9fXWzLSHqtMQqv0AuawhBZzdbYTaum/pro?=
 =?us-ascii?Q?9sZHwt7EhAsImwf9Xhy7VeRx179ShgpPsjbqBIbkAfadDnMIyoOSU68uyd/G?=
 =?us-ascii?Q?O4ivOxflHTHr4vBYbE1AvxkCHIzGzbXaDrVtwUs5HDBnkKjD03/BqaXmQo/o?=
 =?us-ascii?Q?Dh6fMOWqYykdBN+S02VRFWVsWRNP+BiJKE6pBVSb87dn61e24SeTfNFbtKXX?=
 =?us-ascii?Q?KOiVr6Ug8zXHv6bUUPze9RzJte0fvXDK8rF3JVU4ECX1hKtfGotPpC+wNxmA?=
 =?us-ascii?Q?kGW2wUbJ/8fFHaOiDUvP8zyiLyGSeBUNF75woAOz8y4uFLtO4ENOWi/OJmVi?=
 =?us-ascii?Q?gMj1dMA74rTSAqG4nVJmelQbtf9z9v+lCOvFvPcmRso9miKqyfpaawTQRsqa?=
 =?us-ascii?Q?yvndfiRCaGt41z0QCibVoj+y+zuFPC8iQQR8oreNxNGBGWKn3I0e+czRczuk?=
 =?us-ascii?Q?Md4qxlBITRNYLM/u8CQstxfCy9L8ZACVQt9AJ71Ywn30w9NCWu9hRzMwimky?=
 =?us-ascii?Q?1q0Q1gD7e9AT5dwcbG7/EnE6vk0vP9/IKZ5DlNFpkT+IEd3aMBaX3Q2bgE9m?=
 =?us-ascii?Q?iuQYU1m4i5FX5M8COxTXXfUIQHBnP0eeCorc3vbetwxwU4Gi2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+GZueBaoi8T4vcgkMrhOKmHqR0PAaZ6hCpENrXMWZtbGY+RCpTdLEJ3XoRI?=
 =?us-ascii?Q?4WzwzM9y+1JbJfVMGuwibWNNPn2GV6BExyBfxuNOQ/g2iCoZ/ST28+kTDfDi?=
 =?us-ascii?Q?5i5QqHHdDuuF71b5vakFN5y97sqo3gBiCEuHv5/S6Ermtd9tn5aNuqW4Us6o?=
 =?us-ascii?Q?6qIsDezl9uwvRfpgJvv1KGA/qqBUNcTlLdiEua26FJSZbxf9oHm4sijyNv18?=
 =?us-ascii?Q?JOK652sZ8jPO3FKfizhymPgaKddfO4PDDVoopK3DLGtzp6aI5R1ielexGK7+?=
 =?us-ascii?Q?a58MdV3IJl2kLwLEzaT1GKDFuFyhUcaFd/JrHqxCe4SvvGp0wY2ZlghDiw7F?=
 =?us-ascii?Q?voJfvR1slBLU+vGs97ljnSZF9b3nzgQHEAzFfWH+9k1vxwCNWAbwIR2OzV2F?=
 =?us-ascii?Q?09S+1Ycg6yl6A4nH7o1QyjEpWjJpqjqHIk39LVvJ2VpakOrz2JtA5pgAIdmA?=
 =?us-ascii?Q?n00iyAdzMjVqMRuXVycZLhKI7jQwOBqWvi+GmTkMLpTVmDTdep9Afg1ruGpC?=
 =?us-ascii?Q?uCtrW0x3Aai9capdkYm3ZFK7W+ZUvpFpUAjN+4eXf4xH24FACCQzLXz4wGWO?=
 =?us-ascii?Q?PKu41zi0kvxnU3Yyb/uCMel2hibj+gYOiO3wccx1zmEO5cg4INR9+9b8VGeM?=
 =?us-ascii?Q?Cr7BS27SCNKhnXKNTvEYnv6tSXRb5IWWOfAvdDxw5LY8HIsakgpK9ty30TrF?=
 =?us-ascii?Q?plb9YqvFZFizMrlgznobyT3EyCcaj2IBuj/5PQRm5ljHaS3S130O/V0PMSyL?=
 =?us-ascii?Q?KaI7SQaWnVJAXxxBR4vTaUI/smgKuuSDgoudXfaZwVEh29q4zTQniNUxKv1F?=
 =?us-ascii?Q?3EDn+NZDOKxOINXZyEqB9bIq9uXysZIt2kzlNtzuSHUaI7jJ+CwU8E7e5evx?=
 =?us-ascii?Q?AEzCbyqZUkPgka+++FYu1k15niSBbfE0eRckvpAJCbW4fihvEM3pc3Y+pJz1?=
 =?us-ascii?Q?OuMkzIh3R3cIrN574POo3ERqYMqjHw3XiF7gkuZ0GGIbcu3KTaVuJJ+0vYir?=
 =?us-ascii?Q?07Yl3D+bs3E3U32SB6H1uBeGJtqs3s+RpVMHzA9nCu35UDi4bZKGI7JwwKlG?=
 =?us-ascii?Q?oewZioQyDw6Mg58bU9dAc6IJGbQxhOzhAFu59uQCv6F40K/WGqAx7W/rS/pd?=
 =?us-ascii?Q?6mLns6syVeStVt/YFpPl5JoraFKKHubAKzeerr7DlOX71Grxg5lq1ULf3cDp?=
 =?us-ascii?Q?4+3TC2szIfkiyuV2NE+pGBCkur1M8grbj+9JehqNEPkfCzxWZJjwsUAS9b89?=
 =?us-ascii?Q?UfjO9Tb0jGEoUJRMWIzkW8KDdQ9kR1Q+EzdSLoUGHcbPr9lgzOGG5CHtlagP?=
 =?us-ascii?Q?TToji+3lX4j5SYN9QjmAoEDDIF/k2yZLdYly9cT/25SmKPGg8hiLbx3mjfbR?=
 =?us-ascii?Q?DN8XsQwEFIet699SIMrBRKPWgTGzeybyY5ZoRLAVEa7+/xgLLgULxejRis9x?=
 =?us-ascii?Q?8+N1ndF+3KZu79wjUHSchw/nqr5EM1SCB0WWpzxO0jJWwjflhS3CK8PHDGQD?=
 =?us-ascii?Q?RKrh9qVBq7TcCf3IeDLT2M2qk6JCoMS8o4bq2oLTnZAriVAV/taroGZ9xs1u?=
 =?us-ascii?Q?wMyoqMGERSshrlitBUBsSGG10jS13oWNobcI9B/3md8nGJF6AeOdrqP0bF+h?=
 =?us-ascii?Q?iELI1aVpzEJ9nD6uT40auXDVAV5UfCudsxx2EEVV0HB7?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0b6f64-e357-4555-39ca-08dcc703cff2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:50:36.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dryqFgmLIXynoZLVAdv/wC60E5QYef2ca6RQNGYEHyPvROwZxFhG6q6XiSHSTi20G2sRNgVfg0g36XwhBCmLKFdTi+UKGkGLNdgrn7oDeS3ZIC8RVthV/LGZZGKLXbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7576

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


Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020095.outbound.protection.outlook.com [40.93.198.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925A1AE04D
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575333; cv=fail; b=pyrJ7rVEtau0hSCznvoCdqroQQAMj9SogNQuPu7OxkEv5+Gd3ngflCIXdepVjx8XucG4N2UuBM/ly+1St5c23XEQ+7RMWiYbfxLLTxnVf0z93DDpWFslnkm5qLAGefLxzCgB7+V64XZcgEN7kMqVOS/cEIh6H9DeGRihkN53Lbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575333; c=relaxed/simple;
	bh=Wm6fY8wTUvEk3F1Ok1pcZgU1x0Ts3RtUnnAP7gYdzRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YzuYw89i+Vg4Y6IOl4b9AToiPBszaRCcbb83h7boJlbQLddhPN/K9lTTk+vd5gdkRsiQxAZvUOohf9O3+XDt+BtcaPN6eVWNlrEPTIKD6TuduZT9r7TwvJyPlzMq2vb9GSJTt+1SxQHplQyzYgP4CtYI2T+U0ukx6X2s3vix+yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PZ4+09Js; arc=fail smtp.client-ip=40.93.198.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PZ4+09Js"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbP7iY2jxCBhM83E7PK0F1laItyNq9FtcEdGrILIAiPj8e25ZqfKvV7cXNBAxgk9QBwcqH/W2hGt/dH9wI5DklO91jxK98OSulmveAi8vNnrQNdBATSMnqeUpkj7IEeHGDnsXruMAcz3ngKO+Z0Wb6QMZWXWLpLdn9UfBo7J4phizTe8WreCnGy+9HvpZ6IZzUSouvYRoNG+RCFJ51EJEdbEAq0QF4KzNPbtBlXL2Bivg9P1nfaWmmzWyCj2nagn33Cx37L6BZvLVBy/KFCv5qtqm8seTzPJ9s5a+2FB0CVNwK7ETxYRO/yPLNRG10mqocXr64mmWbC5conLwQILaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiE8twlbfqyo2soIykexS6EUqxRW3kdCuY5H08Ox//w=;
 b=HYfSV/viRV+kzYDOGUwfLEU5xYB+cUJhPrAhdnZztJ1Uw8vmJkyJJq/+a3rsujJOqieMdHL/IKTJw+/Da466EofaTABzRMgCIU3JvAJ8kbUmv5c92DW+LNHQpiWxI6GOToAI+0dJ1nBOC/4XnnS66U5zPkXCr4Qo4M6sjJkE4Gfjb1DkSh60KHu0TwIJFIR8AYvTRlchMWP16kYQC+Y4okA63boRuwmeanfLrjw2wMc/JNJAcKK3YiAdKCPQwNlhQE6iiJPXRPw/c/0DWcBzT15aZzhaAGf0iCSOeS9iNuBv6OA7QdVOHpt1JY0EYfsat6N2ZNEIvYIgQ9tl8D41GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiE8twlbfqyo2soIykexS6EUqxRW3kdCuY5H08Ox//w=;
 b=PZ4+09JsXr9ncdkpY29H3aVPLmFL/n2x6AqVEUYWamf0KggGu2ukL5K0RkmvVCShydUl+ILRZtdNTA/iKtFFbm5n82MEjWXMJjao6XpyFV3vzqCuGK5twJCefFkCTB5SWUAWXFP8AO8Fvw1uLiZZIslHDeHvFYsuS+0LSIC1Xuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB6501.prod.exchangelabs.com (2603:10b6:510:15::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 22:28:46 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 22:28:46 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V7 2/4] Force MAPPING_TYPE__IDENTIY for PIE
Date: Thu,  5 Sep 2024 16:28:27 -0600
Message-Id: <2a1fd852366c82249c59dbcb878b0517ca2aeed9.1725573309.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
References: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0056.namprd18.prod.outlook.com
 (2603:10b6:610:55::36) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH0PR01MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: a46516ab-68b1-46c9-c696-08dccdfa1afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Io124GGfoLe3m0qNAWwSKaG+cnCipNu7QWsFZvQ77Gi8Xgjoej9RIYPWG6Fd?=
 =?us-ascii?Q?Y1hyDfmc3mZJX9kT1y9hCjPpEOk+tZbarylYqroApaCjj+2HhJpW38KSuCej?=
 =?us-ascii?Q?+yBGUE8zWdDLr+m6bFQmuozzINzqsHUExFHkpIZ3wRgRs2X91ssoFvuk4+R4?=
 =?us-ascii?Q?vw95hMpY8MPGF+2sUy8BE9ZOxtm+x+V9L3ARQIMXHVR3qXGHNppq5HEWhojT?=
 =?us-ascii?Q?51SJKsUrmubHoCyqRV7LQB5VrfP2CPhMhB4YKaSxiGVg+GnBS/DG3HDI2kMn?=
 =?us-ascii?Q?2sZduDY1UtVyJtg0w+ygnCpvRy/vZLrrMcJhcsMRA1lRO5urXfmlw/lVUrmJ?=
 =?us-ascii?Q?ay0ZfPHwgQzOWQl3vPvOlNZ2/W8juf2/xrITbt0xqdyd3S9ZgyXYTVJcX6Bd?=
 =?us-ascii?Q?6wHaGqigh9Z1yHb9ZhZf9funKL+nhg2cy5Q7E0umBcWOS5AI5fxOZEtXcI2W?=
 =?us-ascii?Q?FUP/l/5e7CHbDTgNgoIwzAu6HObzVtdTmLHvtuoPAAHZWGZhv/YLG3BC3vb2?=
 =?us-ascii?Q?MFoGhcqpTmSIjX6yAJ1tLTNObMbdyv+jLZAM5HvBVq7RAZmKaAm+ot1XLuAv?=
 =?us-ascii?Q?17n2iXU9ARKPIN1TH40GNvPVaHBkPi0NnU1rVXeaKNVYk83Vr9iJGcjA8Q2y?=
 =?us-ascii?Q?kXLVgPYjGW6N0tcoNHW4m5quHHtqsvXH93tmi/TqAqysVunJwPLOoV/Y24YV?=
 =?us-ascii?Q?LS3n7oreUrgEerqOVE8p4b1UOBoJXblTnqsndVxEZ00lOYZWGrCXrNYLMuUg?=
 =?us-ascii?Q?LxjvS4+Wo/FKEWlt0TXHGavA/Ofk9hCMS55IjktLju2t3qhkVxqH2IfW3UM+?=
 =?us-ascii?Q?m7iszq03dNw5URHWEkcjKQwKVumxFLMDEeX6n78TPiV8FjwR79RMr25BaFp9?=
 =?us-ascii?Q?a+hCtPduIK3uj7hEHJsJ0XQJpYXOjF09fCfoSzwJr0qITdGKvfxPiop8WdeK?=
 =?us-ascii?Q?mEmtHfHyoq+R8LZ6dA1oPQjKlX/cxAzqpKDfSYFAf1JiHgptGgaFiTGYZKlc?=
 =?us-ascii?Q?en9ZnHA9LiGObyq3onHQaSSXuTagOxm4BXrGlk7h6BPq5Gd5xT+tXblbm6lv?=
 =?us-ascii?Q?mTwbwdGbELj13p4gbPKTRf2cvV43F4MaLncrRhQc8VG+JdVkX8dVuB6ZmQv2?=
 =?us-ascii?Q?CCVmbJhi1Y87J4GOUsLb5EdwUPa4LX7pzd24CIPGJD26EM6PlnKz2biKys6l?=
 =?us-ascii?Q?If5WGLkBh8LdtnygLZYAIcmIo9oC7VSJp/K5ed+xA3cSjGXlJHgXGAeTR+F/?=
 =?us-ascii?Q?96cdNObXfPEgsLYVEo2MJqHyxG6knJP+28j0mji5I5MOVsMHHoPHu9SGgUhz?=
 =?us-ascii?Q?UOi7PxnPD4jnW2bfs7fPDeGVAyxjL4DBC/j8zRdvTjbGG6jK8BtMvPQcbd1L?=
 =?us-ascii?Q?AoBjZOPsNvUc4PWUx/O9XXAkymy1URnWBsk+tfA9r33wVIkT2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ep9sRKIlCpXBtXByhIS9i4MPMRVLzpcDgpNrAzLu6Pj9z0IyZ04O50Km2Gh3?=
 =?us-ascii?Q?ziXANft81vsPAO2qH9QbCZ2NJ/LctbPD7mDAxr0dodzjqkmlUtlRSK60X6Ig?=
 =?us-ascii?Q?VGjBuiclL9QxaqX5tEv6YkFa8JxVHfD+nNUYWfx05jn5miZJ27MVDk1vbhFq?=
 =?us-ascii?Q?aoaX6B5tlz+HteDoQ3VWrMMCSPeJjQjfUpNx0k7Sk0zPh0XzUmc85OBFk9Jb?=
 =?us-ascii?Q?NauQRA4BQUqkONMPCaDs2m9Xzt4k4k+CBW3QcoqoFFbnyva58GBMIU+/no0M?=
 =?us-ascii?Q?Nk5o8T4Vj8sYO/Q6CDCommfyZpkdkyqkrXcUTXCGM9qlOwQLs9tFLbqSYZrK?=
 =?us-ascii?Q?Usma3lpn61eLW9+2zJ9n2TU5BXSoVwZDiC+7PUMcGBcvzcvrZ6YNOtD+vzp8?=
 =?us-ascii?Q?o3X5bOtbGYFCIKfowFyHFAb44OK7f0NIW+Yz1XGXV66JLz3JFWuk8L43CQ6Q?=
 =?us-ascii?Q?qVDSsX0XMruFdrl21sr6tqtlGkA4FqSzHyw1sBgzPfWdh2o6C3yiGb9/ZSuW?=
 =?us-ascii?Q?FDchRbMwxNYXMJ1HUplLxCiMmQZqVWBacdF8ibK6ldIa+wuT/DQ/EZwbHp0N?=
 =?us-ascii?Q?cubNZr3rgHIPbZzTUw2LiSeKs4FKFOgIyvmQNBAFUUszlJQJc9g+MpQ3tvsL?=
 =?us-ascii?Q?fy00aRa95XbkiB30q3Mtmgg0Qoj8LR1v/QMkZN1G8z+ltemqFaaJAKnkT/mZ?=
 =?us-ascii?Q?TqP5RWkAdmjIeHeeV1GLFB2ATOC7DJTnqQDVV0M5DKYXWko6IazqDo8RLaJb?=
 =?us-ascii?Q?WqUeYDH+e8YgfFE+Ww5pOJcaqAh9ObXE6YP4LbRQTtoaesDTpxWx9Hl7kN0I?=
 =?us-ascii?Q?n1sT+aUdOIwflwYeAaQBOgfMCKyMlpayth1PxZZPM1Ni1oU7HeCfMlYm/DIR?=
 =?us-ascii?Q?M4DmncEXI7Tj9FV5DyfFYjCt9m/WHk0aAobfYUN6z5YdA0u/dFVzzrdvqn8b?=
 =?us-ascii?Q?cv4Xw+VFmYBBlP4IT8OCDSP4X+2fLWrWbswB+jVB1VhghOilByJvY5R/comH?=
 =?us-ascii?Q?FIqCW0wzyqniIVfP2EdMtotmWe5L/ZOM7TSG9IwJMkZihRT8lSU6p9gct0dq?=
 =?us-ascii?Q?ATMC9L7bVOJaRHUkQvSnBurCwy2YC3ENKVkJH32/DcvWlajj7Ro/14jS/wbg?=
 =?us-ascii?Q?RQqWfz6ulGBBnooM11FpAfC5BG9w1VEo4KCrTFZJDwgeYvc4oGS4B1LlvK+5?=
 =?us-ascii?Q?LPIYef2BgL9pLx7qOHRrB+roAIfPEWI0Jk6x6rlvyv/mqN+G/n7Xu85nWZIU?=
 =?us-ascii?Q?EZv2vFLZTjCq8ZYO2vzJgc7DufqwHhk+k6A9c+jt/5FYj1OC1Efk+9sjCqMp?=
 =?us-ascii?Q?JNzS3x7HamyjlQ5SkVsUPmY1ugytq35ZpRRJGu1Xyo9xHU4+VVjGL6zfvT3c?=
 =?us-ascii?Q?9uGwy3+UhjIAn8dHkXP2kmTnqSv726oeKgjLE7cljD+sHgGxktiHaR3KkrmT?=
 =?us-ascii?Q?sHMX+De578S/m08mmJG2aN0QfhvPQql3NwWR3O9WwjbEdCKq5vSocsnho6Is?=
 =?us-ascii?Q?gefGLTddyjH57FAy0JgJKitjKjcaXxV6HFnAbH5KBG9QGYq/N5LXkOrl6+Xz?=
 =?us-ascii?Q?mwYiPpa2lI7f3ltUJhWV7bucjfUKVRPu0uDeIIBk65xKlLQSOU89HtKg+3Q4?=
 =?us-ascii?Q?S/CtIekb+tY/we3JdKL1o3Oy0nt1lkuRoUpPUgjhHY9m?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46516ab-68b1-46c9-c696-08dccdfa1afb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 22:28:45.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtJTY7IHsOxF4fbtzX9owi3Av9g0U6gDxmH/0vxodtsdq2eDtBTwHLlw82nvNM9DOi6R5AEzGq3gIix4VSe+Dx6X9gBYnhvtXGAI8Y6IL1zCIAWa0eHbSXWGmr65B+fC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6501

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


Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE031AC8AE
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887101; cv=fail; b=FWWUIoGRV4OMhPNbUQ8hJ/P/wvt792kStg9reiJSucJftRIhJAJrGtkMsvI5gEyZ85T+NaV8aWGUr06HJYQ1uuxfb6Wz+tIk8rMLwP18TOUpNLW413PgF5TosUOjo3JyqKcUkCQRLzDFWUqVDNVUwW8ptiA5ID/Fa5WXQnTpVSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887101; c=relaxed/simple;
	bh=IVqjxL8NYITgvXYgWBtDVBIBvFjnwicjoG9hlW4dJso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zc0j6Mw5SHFC6DsCL3JfLGvypnz+wWWOALvGjbFyEamAebd15ZJY0dnRC0rWS0HtaFhJquIarjneM2cB3RMjPcmqZUdU2J51dTvsoIrGUt7gjipm1pHATsHSBHT5EMsYI08qNh8AKjm9ingavqYWqzSfgHIGJGoo4yJJj2LnWpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Pmi7G9wm; arc=fail smtp.client-ip=40.107.244.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Pmi7G9wm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW2BGvXuc1CrfDhbi04ER1tM7DDJl6zWCqEzWvH1lw/lL2q8U4g4Dh0mKLaJAOgz/CQCtBwWTaVY2XuCYmN019iza4cDF/ERQkcgQyt/Cj63deSxLJ9658IoQP1jyKVd1E3WzdeeGGfv/ZV1yjYjIcIkiFTteGdYx8biYQ4XdJU2xVv4zwExCieEmiauRI9Fbv/qwZYotjQZ6KhdsixVgmmFZ1Bb+2ZlFnLplUWJ/CDEoh4RcKkXdiMC675dLDNYcjyoe3rvHxooCkG4aHD1OKmhgp7aNLPWttOMu2EgyPjg1L0mWf/NwPCxmiF7+QIsRsxI2BLMc6+LJ8Y5uUO6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46Lnfa419ba6MwoTBOGTytQvW5UJhrJmfl9dt3uEQ2w=;
 b=AsuLceaHxyJ2b+4RfgAx4/iSqpUSzeRYBWVaE8KI3PZJ5xw2QOh0K/sCrGrlgLgOZC5sTCCtpY4OddKSPdVPfiYRHAn9DtIObmOHR+Psp3WRLNdaIFhr8TiZP4g+d1J3EhXyLbT3mi6t1+rXgFFAJWYO9Mg8th9lfXJ10YfYbNgNFLd6Zxm7CdcaU7JiDF7qx3cLxT5olFNARDX/GdoRIjLWUGCB5FPT74ceOAYw+uMggncwjReZsW/N8wklSuDMOBh+y4yrjBMzLC5pfO3i6zPaPXZXV3XIMMlgWULLg1sSKHBH2qCO0/ZFQZB5MDXJmV1jyj8cedTiIfrac24CfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46Lnfa419ba6MwoTBOGTytQvW5UJhrJmfl9dt3uEQ2w=;
 b=Pmi7G9wmuO6+x1Up3HfWMFoRYjZPBZ/hCcUgfjDcHlYfHt/yOhaFHx4yllqScEk+jpu5nvk3HeQPEXJdor8MhfKfEPIUvX3My8/NPWhZ1tkajUk3kjN7OZ5nYV6iIzN/2gnhIM9ivJq+bMDJSVzlsdL4GSSZRX/c3nu1PsoYQe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB7895.prod.exchangelabs.com (2603:10b6:510:28a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 23:18:16 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 23:18:16 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V5 2/4] Force MAPPING_TYPE__IDENTIY for PIE
Date: Wed, 28 Aug 2024 17:17:57 -0600
Message-Id: <070af7268841ba70678fcd615119b66816f996f3.1724879699.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
References: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::24) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH0PR01MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7c0bcc-73e3-4d7f-6d51-08dcc7b7b1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MIFv6yqDeHlduLi8s36Bh6sq/zRE0uII/J/ZuR5A7RkPAEt+fO4qpoe99Trg?=
 =?us-ascii?Q?eVrJeiSolhSxDKV/HIbzNLT/2QcVWmyrOnXhXFj2UTlrJfLSX7ibhYCsxXri?=
 =?us-ascii?Q?U6q6D49gyhpSvBdQUNkJHaulUIwgvTkklGVgra77PRWuoDMNkmPF9RWy+N7C?=
 =?us-ascii?Q?Ow/1BOmDj2OvVeEr9NYLm8s02syUQAUmD+ITzYfsihSaSSKV1cKWD74k8owg?=
 =?us-ascii?Q?iW4zegAxl3tvYd9Rxd8293/rRVzf2TLFMbMh9qxgLpcTMl6ohzqL3daqHNga?=
 =?us-ascii?Q?V3LgzpSNkvbcPsWYDuqBCvkBBDSgA9qW+fPp/o1p492jQ++ZjriD25OCIz/S?=
 =?us-ascii?Q?VxlHv7ro8rh1zJFkxK6swZsQ1d6kb/XESSB/7a9LJ/UKsmRcVqANUgsLYG+m?=
 =?us-ascii?Q?YMN8+oxZRPQlq9wmKLk53UMACUgCPL9aNShNeXCST749SEs78MsC+zGX5mBK?=
 =?us-ascii?Q?+AfbT1VINlepcFcM4x4J9NAJN9pmFPuZ+jGzyyn8F9isz+b//7RVFKAfpwY4?=
 =?us-ascii?Q?tuPg33DA2241Qe+heJiyc0jwY6vGtIbqSfpcTiyb87jNqpaHSCqfckS0UchY?=
 =?us-ascii?Q?COtE8UmFiUmo5eiwjmlutrLVlXtXQl8vxdif1OgBkkjXCcCnSqCxWBZw67Zz?=
 =?us-ascii?Q?KlpxxXoQ8QrNH9UsWgGyPcb7p2+5BhRD9PBS15i/GOEsIXsT8h2NLdmZkySZ?=
 =?us-ascii?Q?n4bdA491lqb708chQy/AWEHCGnri+sDDgzBqZvP9fyAGF4cvnaXJ07dnt6XC?=
 =?us-ascii?Q?VRlWXlq0LjTkAQLYzo/oDU455aWmCLSKra7XPaauvsqMSxpmmPl9tP6liWCF?=
 =?us-ascii?Q?U7WOsGOSDi3UlKpB+tSXNlshZLO+8O6+QT5BnSuSWAuE29zlx5hWBBjmMJpi?=
 =?us-ascii?Q?SN3IpPf35SbXYUg9IA/GPgwZg6VYGhajuj243ZdzpHhFkQwQcufPu8mtTzY3?=
 =?us-ascii?Q?keD8gdjfInzvY6ovj/ZOU+l/0ngQVaaTmhAw0gPxDJyo4qnBQ6ycGu2x4tYl?=
 =?us-ascii?Q?VkDpUb1jjsTVa9O4R5M5Z5vWyDN5iRwDd9MRkiCF7G6S+4EUhCf/TkWnPshq?=
 =?us-ascii?Q?IeP5LWHCB2Uo8OnRxw0IvuCHp47RNr3xG8BYZVvNDqQEQvDCJtcaAbL9Z5Es?=
 =?us-ascii?Q?QfD1Ia2qxLRo2m1+8kNlk/P/7SzFKDQwSvWZs42gBct6raT78JvA47kzfubJ?=
 =?us-ascii?Q?Vtz3c9Rzh+8C2zaMhH0zFr2AOvCKucT9pu0aF0P0hdSJN24xpr1dPQkhKFKU?=
 =?us-ascii?Q?lRcLN02PPIIxhjFF/VhPAh5ufVOOK2quelGw1yNiMjNqLShTMGwWGC4hbQN8?=
 =?us-ascii?Q?1/q2lQuvNyT1LtwxG+P+96S7BV8ZxAvkEahfz5DfnXcZELLZyrCDe3aqVnJW?=
 =?us-ascii?Q?AlQk91ZB64JQvxiiByyN68tQL6Aal+M1EuEztyWEdRIWyCjcMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H3fixxKS1rQqQHEc+yVOdPXyKjSjyrt4FG7sjr+UmmLAyKRYWV+nrO0bQk6R?=
 =?us-ascii?Q?eEoQSKA6X5fkBj4yyZG5GpcSwPmH7RuU/+90VF2oCc+MJAnu8ZIkTpL13MiH?=
 =?us-ascii?Q?flef1ICRLx48fbutDbQQ5h45n0YJv0HxH1qaK8r0nqvzOuGhkcnhGuh7vt2i?=
 =?us-ascii?Q?oxyxFWJvVVOQHHIMlx9w38ThOVdjXyAZjxGPCOYKaAgY6leZTI4WsyZeqq78?=
 =?us-ascii?Q?eUw7LVangv2RTRlTPVc4hTjDgZBiNvCGRKvpWkD6IHGXmqfc8k0qN0Q8dY9g?=
 =?us-ascii?Q?iIyOTd1Z343jvf1es2gY/Eh+LSWOn8RqhdN6TBsJamRfbCG/Gq1JSvK6TU1r?=
 =?us-ascii?Q?v4hrI4kj0lniKj5JvVBfgwa+hg0JC0sGNldMUWqWhhHMUXvG996EUNEzv912?=
 =?us-ascii?Q?I3BYEh5eb9GHGSRzS3qkcx3zoOjDIMsqz0+nwEpKjDXT/r3iO1NWEtdwsYmI?=
 =?us-ascii?Q?Mo1wlEzLAbJDDWkxBGFHjCuV7y/aZGGKGO1wnvyeuno5dTLHzI9ijcOcWSD2?=
 =?us-ascii?Q?T+BE5vs3alS+T7lthpon4ku8bUTuz7d1AnlapdPBzgbHFyJawpI8sPDVETJI?=
 =?us-ascii?Q?4e1CULZ9yeMnUvbvvQFKt9VWw0DtGPbIg09JiGz5zJ6auT9tn8t/cjrlUDxv?=
 =?us-ascii?Q?cZaM6vyUmu3S0oUq30iekO9YrWDMa7lReZzJMF7oFpv6Ad8mctMjCtZwceL7?=
 =?us-ascii?Q?qtf0/IkvGihjuvIGiZd40hMSSGO2mrONK+agpaVvsbPHCMkt2atyRB381qoL?=
 =?us-ascii?Q?qq+1UU6InJoMiSrDZZE/0Dl8cbs5CclDPVFqLD4KF19ddwtbVvlg0CCCt1rb?=
 =?us-ascii?Q?DgC3A1EwZUjvC7HcUAKh6q+7ug8fppq0/P3Vg7EU5vVsLJCyv6u9G1YleMtu?=
 =?us-ascii?Q?V3E8KdMD7//NrNg7tFq3gX8jlUWKdHZ/45ESmcsHjXAmmxf15luvLtxfHSux?=
 =?us-ascii?Q?hgCbdeChE1Yvu51bAjpjP0n1cxvQfJ9oVJJAd/cHZ/RYQrh6VrPpINPZjgrg?=
 =?us-ascii?Q?cEwTDMVD/PiPNUrXV2Ivvfq4CW5saRkiy5PCo70gaTSQGeqOfJdWrVxQ2aZF?=
 =?us-ascii?Q?oKDi2N/j1t0u9g2VrjjCdsMXYvoj3eNI77KYUhmbX7mzO4jWgxynar5yyht+?=
 =?us-ascii?Q?ONWhW0r+zyL151Zx+nyJ2KVKy8t1udvA8IpdqoUp5offoPIp8wGA7IRiXfae?=
 =?us-ascii?Q?/RK1ak2Oi09qeM/zH+RMHwrxmzbP3dtsW9+nhykG0urIDnhKIL07oH8yj8Li?=
 =?us-ascii?Q?eVnxycB5u1207lGts/LRt4ATUqsZcxzA19AQ8gDWH/MHtbWN5cqgUGwZPRL/?=
 =?us-ascii?Q?CPkeYQXz+gRvZQC1FsKrL47gLEqt0muKVDP1QQat4V0EeaRHgyvuJna+ZKrN?=
 =?us-ascii?Q?yGI8oYeRO1VuwsnaQf2uZeCHBrUVz135CyLR9bXxzF54Ai8FTYdlOvqhL3zL?=
 =?us-ascii?Q?JK7YLFVJ2Tt8zAHJf/n9NjSKjTZSP5E+h1IykMoJzEluI8H1kWhAnu4tJC9j?=
 =?us-ascii?Q?37LlhN8VHjdyE9DT5/NRrNvGigoiicmaMS4eU9vkev0bMDNT9IKK3Nh4FW37?=
 =?us-ascii?Q?PQKtqgU0HUFuMfz87vpObxcJgYxnmVT8JUETz7DDk1LptoRIWmDLM6Lggc8i?=
 =?us-ascii?Q?Bm+F8NOJHLeGsM2nkl13BMX5vTiWdxHKeB5pylsRRcYb?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7c0bcc-73e3-4d7f-6d51-08dcc7b7b1f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 23:18:15.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+6tbmkcwCPsTW0oiKO7mC9luvKo89+VWLjJFkUbDIRY3icqIhkA3smeoKk3NnwPbstLE81pdfWU4UJtBqQN5yqiQWZBlGG6nXyOLiktjnP8ECagjse5U+G8Vdx0EdMV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7895

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


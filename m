Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021093.outbound.protection.outlook.com [40.93.194.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14F21A9B2D;
	Fri,  8 Nov 2024 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097744; cv=fail; b=UUoVKEtrdNexJJc8f/ms1U6jJG2z0+wkD8bgDi/Sy56nRVwbEIPL6Bn4xQEEyXriqn5bVARGsZyBGKAePfX5XgyXWcILzz14E77WKtfhniRj1IAh2SFJlSpwMogzzQk1fKVG1oiYPzpbGrjfzbehYv5nflLrcjwMYOGNx9KHHkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097744; c=relaxed/simple;
	bh=w+e7ICk8UzzQQJC/XQl7mgRuJt3klMpQzdzg03EeQQU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZIHU1dRO8npF98xta1A/phJGprCxEXckHmtYFUlOrw/HE0Y3J4USAG3no25u3ShrACJ6svWhyzxl+4bu6ObzkAlyOMAOm1oHI2qPUL6ZO6eo/67+iy4jfNRM1M0Pzrk1FdV62DAz8pxrGWF7VsnUWbFhg0wBTJrcRRCIXH23maw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=n0mlCscq; arc=fail smtp.client-ip=40.93.194.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="n0mlCscq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVr28qGdJWAkXgyWgQtg3qTPm29xGsj38mwvOhGF1VlA7CEgmP8czD57S0cM+MRN2d+8QjhTKEWqs5DFvGu/VPoUIsbSOYF1QSdlz0koG9j3T9NG5yuh/Vuig3HHnaR8P8kQsD75N8ndgca7ilnYxCk5UBsjJZlcwRAOjUvx8lsKhTAUNGC33BLERT5BKk/qRwyby9xiczUDuxUq7vZITd7aqPTFWf60013cLf+H4BijwQH26Rb6RUB57uuXwWglyJ4nGz+APgdepSdKmWhzvTmt8gnJAzx4wTVEifIx977MNPsI+eN5FXuENTtNdAKB+iWrf/uyYuZndXQ6zEYRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwOm0CEu3A8roUNtHXENy0xHJzQ39E0vUsLlmqezsV4=;
 b=dwj0REzCKKJJNGwQNvXfI31Fp83tL8bVqxmwoH5wzHzAyyHDyqR0r3/Vbi7g1eIH8wyCq+/cjwyHRcFFJhok1u/M5jjweLw7b5YuIjKUBC9P3/MzBZwhNn5W5Be/ES0AWhtBkAzp3T3Cz+pl79qvbd6chyqNkeOmakgSk2mOtDSp3VSQh3vM5I5G5/ZCDbMfYJkRWv1uVsOAwCZ9HEV/9xJluBbFmiKdGyhqsdhILDIMZUQw9kTEdkiasuOCkeN/cxfpJ/91uf6g/+4Bwon7VxnlcKlASjnXVZhTqikEUvgQuhszyYJnNvCI1wLS1yUPf2uBDQBMqt2Br73kKNzY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwOm0CEu3A8roUNtHXENy0xHJzQ39E0vUsLlmqezsV4=;
 b=n0mlCscqd8eExREQUMwfNcV74CUIUWr79MDEkiqFf8A/cy1kzao1+WSgUUoNMS20KSdFUHlXkWwqcPUSR3NwiNcFGtqiuK0+SbtEpxIbYONIgl3r3p45ham0xn859L4IH47blGdFITPEv/m3ajPkL1enUBiKTUkUcn5PytO8lsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 SN4PR01MB7456.prod.exchangelabs.com (2603:10b6:806:203::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.12; Fri, 8 Nov 2024 20:29:00 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 20:28:59 +0000
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
Subject: [PATCH v5 0/2] [PATCH v4 0/2] perf arm-spe: Add support for SPE Data Source packet on AmpereOne
Date: Fri,  8 Nov 2024 20:29:44 +0000
Message-ID: <20241108202946.16835-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|SN4PR01MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f9c677-d892-4c21-2200-08dd0033fa2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u7+xB0uQqTFXVNrjBkgybW2w/uFTbeij0xHlGUCR7bDw7x39eGISbUitiri5?=
 =?us-ascii?Q?m9HYCyq2j+xcXSZr2I2jLv96K0Texzr+YMH8XEz/9FedMIL80vQqVxfb8Mp4?=
 =?us-ascii?Q?uf3Awhwsvg2jTKQy7E+t93FWC4DlUxdrbco8GTr3wrVatjbjfrO4xwMkkHvF?=
 =?us-ascii?Q?zIjwP1Wx1Ns/jyp60V7k4tljLYEtOinIOIBXoUr3ghxI5gqqqNUNymJ26c7i?=
 =?us-ascii?Q?aBFIJKPanJi808OvO1C70BtTNG90edk79EVXHQtN6noLCQLdD4/YAhcQgzfC?=
 =?us-ascii?Q?yhtpLoeQkzgi8JmRCgQHAhGcHWR0ZeN1SehFubX/iIYFMOpJeuny+Fhi5yEZ?=
 =?us-ascii?Q?0dnVQKulDWhLJFegt6rJzEyK2a73wpgZTkxHs0iLAiU2B1V5ztnqVgAQEBDU?=
 =?us-ascii?Q?tMfZVrz6hIn3bp+u2wYB93hKzwrD9LTFU9Eo4caWQbWTqPPaPFckO9oidhJr?=
 =?us-ascii?Q?yUznUzdz8OVzrmE1UHQKtenPjR7OtHFUn4MJv92xCHo00UAnDYGAE89f5MFG?=
 =?us-ascii?Q?6qUSuITjmiv9kKEp6t2/2fk83eSXSt+2omfzqLlXHsowoosa0kBqjWwdrS4Z?=
 =?us-ascii?Q?3gxkGcFILkTCVZx0FAh1ioX88kr0AWxkvlymTju2z1eBpSXP0roJeWggDoOy?=
 =?us-ascii?Q?VD+tvxj3FZA/tJJbkL37O7ZZu6+FQB/hHctuiurmNDlYBF8XqO0AAR4Lppq9?=
 =?us-ascii?Q?g/IvJwceOg8L1MM+TIHVjvOo00vdBLIaSZzXPvla2PE0mGgs/kbLml0icP5W?=
 =?us-ascii?Q?OdzI43W/+kTDMLOVGg4fyevWyBlV39SE575CssohYxcwxkqzp9LiY0yTmn7/?=
 =?us-ascii?Q?QXfYn67xGn71HUpNVQuNG9vBzcKNFLaJEwvi4luaN3p/ZsyyrLzc838QwQJ6?=
 =?us-ascii?Q?erxgc1JudqEzK3ieIywLREMgAW2P+W3PWxJACuwqDlCNwAYRF90Jw3JDG58R?=
 =?us-ascii?Q?YkadeVeSKDw28UEjWKJ8l/AvHweaa+QbuBHkKHo+4Iq9lehNCpNdJb1E/FgS?=
 =?us-ascii?Q?nG4KmQpqL+prdXFdFYjL5z6GGUJT20IfGhGR7iPcfvX4hwoYkvQMzDAzvzcE?=
 =?us-ascii?Q?MmiHlTPclcXtlwTyDTnlxAG/W59tPmD0qaMs/xdRkdulUN+3UDd2HKDZPzRu?=
 =?us-ascii?Q?9Cf7sQUf5x41Hn+lVZb2SKnIr9UvAl4c10ojiy2mDBilf60a2PZBNLgMCHqn?=
 =?us-ascii?Q?ESSNx10DyXlkjYog9bGw+tPzXZptaksQ54J1zewES0UQzH799VIjGUGsB2aE?=
 =?us-ascii?Q?bgR4auoC5eB3E9rzm+sLmIxOAhxhIucUSNR4k4WvqBV4sUOnfIXllY23Y4NQ?=
 =?us-ascii?Q?GhGMZFTD55p0dNqC3229Kt9WtNcfvR9KePYhlfLzUQVpXuBFBvc8vTdGWOM7?=
 =?us-ascii?Q?v3uiYa+MyLxPKIFHVQ1oN8kx5O5m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Gm+d2H95BgwcZkvQxyF4Teve2wIBd8C24HqbgWOwzVHPDmbAFn58kDhO9Oe?=
 =?us-ascii?Q?X6MeUjWrcRlroJPG/0yEBUy/eRZPmO5ZZH6p0xXQ4isj9rZIon7f/Q8M/RIr?=
 =?us-ascii?Q?XzYTCFetOTwrxY/FTzcpOCtp2O0wzvX012RFjCc/O5dn/fWA45H0DebAfkPH?=
 =?us-ascii?Q?51y5YbBheCNbyE6a8qigaTmFnABBzp6yzGjyhaG/LwacLQm/Bka7QvqwtY6p?=
 =?us-ascii?Q?aFBM68c+F4MEqBdSCA2/Q9d7D+cfHiTIrMRkHLTcngT22IPi0s3sjNsR0Ueo?=
 =?us-ascii?Q?6pXs8IIU2O5rSXOH2/j8nTN21NtUvV/xdHs4STSIwThz2LqT04932kjbPFgn?=
 =?us-ascii?Q?dKjpZ7V3i11gcwCBC5Xi+yqg/qRdM0C7TCAO7z/crkSEFiWZlVMVi/0e9Cbc?=
 =?us-ascii?Q?1TIJnEZVEi9tnhkNS4Uqnz5TMrp7Mtg5uUbdM1AkuhRPAIb0wnbJISaZ8hAP?=
 =?us-ascii?Q?P5tOMNzW0pGq+aVgoaZ+G5mxoQnJZwWex74mWmHPk3QlKfTcD1ZGhFJIkzYC?=
 =?us-ascii?Q?xw+5L2Qz4lYapbgkeVA8zoha9/d92Bjiedm3hLoQ1Aijra1hFuWqvvXX2het?=
 =?us-ascii?Q?fKJ+oLx4t/Fc9Ja8GaVZSZQPehIiRLLRMZyYpui17DamyFshSbMu5YRpQW8e?=
 =?us-ascii?Q?9h4nzRKX7idFFV9CyYzKGfbxMUnDsB6W+aKwDPOx1N5ymHEtlwwoPdUkTP+z?=
 =?us-ascii?Q?fqDrRLDklioDJkrcLP/GWHG+p+deZ1kKZMlv84aZKPVQzsS6tOkBfQK/Vo6e?=
 =?us-ascii?Q?dguUlLPBJBMgKxJKuYyUwxgd38BgrJe7C1ieMm2klLmsUo3WNm0GQ1lAk2Ju?=
 =?us-ascii?Q?uGY2AsIPwRKv0JdxDdMu5ZyFpF6Y9y0KB6hjDv/qXULDqSvRZHxN1uWqhebM?=
 =?us-ascii?Q?3nuyTWW05hTTV7pvwWvzrjpsB1UNe099D5nb2b2Q3hdFITL/8NLeN5x/Qq6D?=
 =?us-ascii?Q?qesVD0g/RqDkTE6qXmRm8mQNvH6vyMF8lDW4nrf8bm2TAdpEKf1O8Ell6C6e?=
 =?us-ascii?Q?7I1+I12UWR3V9sjhnsDdkiweODxIE6gfYIG4oD4Z2NFPviQjiwPzAj73w5zR?=
 =?us-ascii?Q?IURE3zRL6lVuXcI0h/qWPyoom7CIzTRoVywl7iugZhqucyyoJG1Eiv6RhKvw?=
 =?us-ascii?Q?I5ngGDoY88s1HMnzL+6xo9tDqUwTY1B49XQqf1YMGIIW7mdqjrs2x9bpKcJr?=
 =?us-ascii?Q?9tFE1MIzYseMu2c4AFRY44cPqBakLAgHiZlK0nnMnPeU85fc5rBdblxajZAH?=
 =?us-ascii?Q?+Bd0Ew1G+qEOOSH7sq66ZDo0tkUq30muhuW+GgRZlVlHLvTogmdBXe2WkSSE?=
 =?us-ascii?Q?/a/Kpd9CiwLJuHLr9pOkjIyBTjQ7/XogJz7scMr3A8bwC/YEmVdpwEMpUpYa?=
 =?us-ascii?Q?bxq6jnQFzmy0BTnmYSVvLZPj1/O12aJQ9Tc4JPRNCgBdTPP/T/wj5P8z/83A?=
 =?us-ascii?Q?uva6bPlINQue6ybqcx+WPZDnOkq9jZRtHHYcNLNvi8Z4apqvK1mHA94G1vuf?=
 =?us-ascii?Q?q7ZpB01npDQP2nsqyCf21U6sGEVu5cD/JaicWsWkYtUmilz92YeVKQ2FHwAC?=
 =?us-ascii?Q?8a0ZNq8ErdZ+HkU6vCRtQ8n+4JikWuyJsWRcZ5eSSgDMBjmoRa3j1q3VEjT9?=
 =?us-ascii?Q?WYztOGyFfsMbntfvdVVSE8k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f9c677-d892-4c21-2200-08dd0033fa2d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 20:28:59.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrE4MhqX56z/R/1ae0YzfbdaIW2zRHlRsRdzTGleyIVu77fdua9Xw4FjNEjU5mHEHVQ9yEt6iVChSXAvvGFw6jUsJ/+emSOGH5zq4uxY0u/RLVX+uMWVp15VRGPyw9au
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7456

v1:
	* https://lore.kernel.org/all/20241024233035.7979-1-ilkka@os.amperecomputing.com/

v2:
	* Doesn't use read_cpuid_implementor() anymore as that was broken and
	  unnecessary.
	* Convert AmpereOne source field to matching common source fields to
	  avoid duplicating the code.
	* Rebased on top of perf-tools-next/perf-tools-next (ba993e5ada1d)
	* https://lore.kernel.org/all/20241031213533.11148-1-ilkka@os.amperecomputing.com/

v3:
	* Changed source mapping to simple switch statement
	* Dropped is_xyz() stuff
	* Added table to map midr to data source decoding function
	* https://lore.kernel.org/all/20241106193740.6159-1-ilkka@os.amperecomputing.com/

v4:
	* Split midr/decoding function table
	* Made AmpereOne DS decoding function to ignore unknown sources
	* https://lore.kernel.org/all/20241108010911.58412-1-ilkka@os.amperecomputing.com/

v5:
	* Moved data_source_handles[] to fix the build issue

Ilkka Koskinen (2):
  perf arm-spe: Prepare for adding data source packet implementations
    for other cores
  perf arm-spe: Add support for SPE Data Source packet on AmpereOne

 .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 ++
 tools/perf/util/arm-spe.c                     | 86 ++++++++++++++++---
 2 files changed, 83 insertions(+), 12 deletions(-)

-- 
2.47.0

